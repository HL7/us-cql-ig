USCore defines [USCore Condition Encounter Diagnosis]({{site.data.fhir.ver.uscore6}}/StructureDefinition-us-core-condition-encounter-diagnosis.html) and [USCore Condition Problems and Health Concerns]({{site.data.fhir.ver.uscore6}}/StructureDefinition-us-core-condition-problems-health-concerns.html).

Many clinical systems make a distinction between the active conditions for a patient (i.e., the problem list or health concerns) and the diagnoses associated with an encounter. Problem list items and health concerns are typically documented with additional information about the condition such as prevalence period and clinical status, while encounter diagnoses typically have less information, usually only the diagnosis code as part of the encounter information. Within FHIR, both these types of data are represented using the Condition resource. The category element is used to indicate which kind of data the Condition represents, a problem list item, a health concern, or an encounter diagnosis. The [FHIRCommon]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html) library has functions for distinguishing category if needed.

Typical code systems for `Condition.code` include ICD-10, SNOMED, and LOINC. For historical conditions there will also be ICD-9.

### Modifier Elements

Conditions in US Core have the following modifier elements:

* clinicalStatus
* verificationStatus

Note that neither of these elements are required, but both are must support, and have a required binding. As such the FHIRCommon library defines functions such as `isActive()` for assessing these statuses. Further examples are provided in the "Common Elements" section below.

### Search Parameters

USCore defines the following mandatory search parameters for Condition resources:

* patient
* category (problem list, health concern, encounter diagnosis)

In addition, the following optional parameters are defined:

* code (applications will almost always want this)
* clinical-status (common to only want active)
* onset-date / asserted-date / recorded-date / abatement-date / _lastUpdated (probably used a lot)
* encounter (some payers will care about which encounter. It's more rare in prior auth)

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

#### Category

As noted above, many clinical systems make a distinction between "problem list items" and "encounter diagnoses". The category element can be used to distinguish these uses. US Core introduces the category of "health concern". The FHIRCommon library defines functions for determining the category of a condition, and US Core Common introduces `isHealthConcern`:

* `isProblemListItem()`
* `isEncounterDiagnosis()`
* `isHealthConcern()`

#### Relevant Condition

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

> NOTE: The `isActive()` function makes use of the `clinicalStatus` element of the `Condition`, which is the _current_ status of the `Condition` record. For retrospective cases (such as quality reporting), the logic may be evaluated on data that exists at the time of evaluation. This means that while a given condition may have been active during the measurement period, it might no longer be active when the measure is run. As such, the `isActive()` function should not be used in retrospective contexts. Instead, the most reliable way to determine whether a condition was active at some point in time is to use the [Onset, Abatement, and Prevalence Period](#onset-abatement-and-prevalence-period) elements as discussed below.

#### Verified Conditions

The `Condition` resource in FHIR has a `verificationStatus` element to represent, for example, whether the information has been confirmed. 

* `isUnconfirmed()`
* `isProvisional()`
* `isDifferential()`
* `isConfirmed()`
* `isRefuted()`

The element is not required, but if it is present, it is a modifier element, and has the potential to negate the information the `Condition` resource represents (e.g., refuted). For most usage, when artifact intent is looking for positive evidence of a condition, the verification statuses of `refuted` and `entered-in-error` should be excluded if `verificationStatus` is present:

```cql
define "Verified Conditions":
  [Condition] VerifiedCondition
    where VerifiedCondition.verificationStatus is not null implies
      (VerifiedCondition.verificationStatus ~ "confirmed"
        or VerifiedCondition.verificationStatus ~ "unconfirmed"
        or VerifiedCondition.verificationStatus ~ "provisional"
        or VerifiedCondition.verificationStatus ~ "differential"
      )
```

To support re-use of this pattern, the `isVerified` fluent function can be used:

```cql
define fluent function isVerified(condition FHIR.Condition):
  condition.verificationStatus is not null implies
    (condition.verificationStatus ~ "confirmed"
      or condition.verificationStatus ~ "unconfirmed"
      or condition.verificationStatus ~ "provisional"
      or condition.verificationStatus ~ "differential"
    )
```

```cql
define "Verified Conditions":
  UCE."All Conditions" Condition
    where Condition.isVerified()
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
      and Condition.prevalenceInterval() overlaps Interval[Today() - 3 months, Today()]
```

Note that time frame and status requirements could vary by condition and payer interpretation and might not be spelled out in the medical policy. As such, the USCoreCommon and USCoreElement expressions are intended to be flexible to support a broad range of uses.

Note that the USCore profiles for condition indicate that:

* There is no single element in Condition that represents the date of diagnosis. It may be the assertedDate extension, Condition.onsetDateTime, or Condition.recordedDate.

Although all three are marked as Must Support, servers are not required to support all three.

#### Onset, Abatement, and Prevalence Period

The `Condition` resource defines `onset` and `abatement` elements that specify the prevalence period of the condition. The elements can be specified as choices of various types to allow systems flexibility in the way that information is represented. The US Core profiles for `Condition` constrain those choices to only those that support actual computation of a prevalence period. The Common libraries define the following functions for determining onset, abatement, and prevalence:

* `toInterval()`: returns an interval representation of a time-valued element (i.e., choice of time types)
* `abatementInterval()`: returns the abatement interval of a condition
* `prevalenceInterval()`: returns the prevalence interval of a condition (i.e., earliest onset through latest abatement if known)

```cql
define "Active Diabetes Conditions Onset Within A Year":
  "Active Diabetes Conditions" Diabetes
    where Diabetes.prevalenceInterval() starts 1 year on or before Today()
```

The `prevalenceInterval` function takes a `Condition` resource and returns the interval from the start of the onset to the end of the abatement. If the Condition is active (i.e., has a clinicalStatus of active, recurrence, or relapse), then the ending boundary of the interval is inclusive (i.e., closed). Otherwise, the ending boundary of the interval is exclusive (i.e., open). When looking for whether a condition was active at some point, use the `prevalenceInterval` function rather than looking at the status element only.


> Some of this content is adapted from https://github.com/cqframework/CQL-Formatting-and-Usage-Wiki/wiki/Authoring-Patterns-QICore-v6.0.0#conditions


