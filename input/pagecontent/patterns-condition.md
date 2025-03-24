USCore defines [USCore Condition Encounter Diagnosis](https://build.fhir.org/ig/HL7/US-Core/StructureDefinition-us-core-condition-encounter-diagnosis.html) and [USCore Condition Problems and Health Concerns](https://build.fhir.org/ig/HL7/US-Core/StructureDefinition-us-core-condition-problems-health-concerns.html).

Many clinical systems make a distinction between the active conditions for a patient (i.e. the problem list or health concerns) and the diagnoses associated with an encounter. Problem list items and health concerns are typically documented with additional information about the condition such as prevalence period and clinical status, while encounter diagnoses typically have less information, usually only the diagnosis code as part of the encounter information. Within FHIR, both these types of data are represented using the Condition resource. The category element is used to indicate which kind of data the Condition represents, a problem list item, a health concern, or an encounter diagnosis.

Typical code systems for Condition.code include ICD-10, SNOMED, and LOINC. For historical conditions there will also be ICD-9.

### Modifier Elements

Conditions in US Core have the following modifier elements:

* clinicalStatus
* verificationStatus

Note that neither of these elements are required, but both are must support, and have a required binding. As such the USCoreCommon library defines functions such as `isActive()` for assessing these statuses. Further examples are provided in the "Common Elements" section below.

### Search Parameters

USCore defines the following mandatory search parameters for Condition resources:

* patient
* category (problem list, health concern, encounter diagnosis)

In addition, the following optional parameters are defined:

* code (applications will almost always want this)
* clinical-status (common to only want active)
* onset-date / asserted-date / recorded-date / abatement-date / _lastUpdated (probably used a lot)
* encounter (some payers will care about which encounter. its more rare in prior auth)

> NOTE: For discussion on how to manage search parameters with terminology, see the [Terminology Considerations](architectural-guidance.html#terminology-considerations) discussion in the Architectural Guidance topic.

> NOTE: For discussion on how to manage optional search parameters, see the [Performant Data Access](architectural-guidance.html#performant-data-access) discussion in the Architectural Guidance topic.

### Cross-Version Considerations

The 3.1.1 version of USCore has a single profile for Conditions and the `category` element is used to distinguish between problem list items, health concerns, and encounter diagnoses. As a result, expressions that referenced Condition directly in 3.1.1 will need to reference both profiles in 6.1.0:

```cql
define "All Conditions":
  [ConditionProblemsHealthConcerns]
    union [ConditionEncounterDiagnosis]
```

### Common Elements and Functions

#### Associated Condition

Often the most relevant condition/diagnosis is available in the context of the workflow (such as ServiceRequest.reason or Encounter.reason). For prior auth the condition/diagnosis associated with the orders getting prior auth should already be known to the payer during CRD or PAS prior to returning the questionnaire, so it's best practice not to ask for it again in the questionnaire.

#### Active Conditions

```cql
define "Active Diabetes Conditions":
  UCE."All Conditions" Condition
    where Condition.code in "Diabetes"
      and Condition.isActive()
```

The USCoreCommon library defines functions and terminology declarations to facilitate common tests for the status elements of conditions:

* `isActive()`: Returns true if `clinicalStatus` is one of `active`, `recurrence`, or `relapse`
* `isConfirmed()`: Returns true if `verificationStatus` is `confirmed`
* `isRefuted()` : Returns true if `verificationStatus` is `refuted`

Note that if the status elements being tested in these functions are not present, they will in general return `null` (i.e. unknown), so care must be taken to ensure the correct interpretation in that case. For example:

```cql
define "Not Refuted":
  UCE."All Conditions" Condition
    where Condition.verificationStatus is not null implies not Condition.isRefuted()
```

#### Historical Conditions

To answer questions like "Have you ever been diagnosed with diabetes" use the `"All Conditions"` expression:

```cql
define "History of Diabetes":
  UCE."All Conditions" Condition
    where Condition.code in "Diabetes"
```

If you have more filters such as excluding things that were refuted you can include those:

```cql
define "History of Diabetes":
  UCE."All Conditions" Condition
    where Condition.code in "Diabetes"
      and Condition.verificationStatus is not null implies not Condition.isRefuted()
```

To answer questions like "Have you had COVID in the past 3 months", use ```prevalenceInterval```:

```cql
define "COVID Conditions":
  UCE."All Conditions" Condition
    where Condition.code in "COVID Diagnosis Codes"
      and Condition.prevalenceInterval() status 3 months on or before Today()
```

Note that time frame and status requirements could vary by condition and payer interpretation and might not be spelled out in the medical policy. As such, the USCoreCommon and USCoreElement expressions are intended to be flexible to support a broad range of uses.

Note that the USCore profiles for condition indicate that:

* There is no single element in Condition that represents the date of daignosis. It may be the assertedDate extension, Condition.onsetDateTime, or Condition.recordedDate.

Although all three are marked as Must Support, servers are not required to support all three.

The USCoreCommon library defines the following functions for determining onset, abatement, and prevalence:

* `toInterval()`: returns an interval representation of a time-valued element (i.e. choice of time types)
* `abatementInterval()`: returns the abatement interval of a condition
* `prevalenceInterval()`: returns the prevalence interval of a condition (i.e. earliest onset through latest abatement if known)

> Some of this content is adapted from https://github.com/cqframework/CQL-Formatting-and-Usage-Wiki/wiki/Authoring-Patterns-QICore-v6.0.0#conditions


