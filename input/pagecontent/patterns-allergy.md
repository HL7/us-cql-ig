The [US Core Allergy Intolerance]({{site.data.fhir.ver.uscore7}}/StructureDefinition-us-core-allergyintolerance.html) profile is used to capture allergies and adverse reactions associated with a patient. 

By default, the primary terminology filter for AllergyIntolerance is `code`. The codes for this element are expected to come from a set of [common codes designating substances for allergy documentation in SNOMED and RXNORM](https://vsac.nlm.nih.gov/valueset/2.16.840.1.113762.1.4.1186.8/expansion).

### Modifier Elements

The AllergyIntolerance resource defines the following modifier elements:

* clinicalStatus
* verificationStatus

Note that neither of these elements are required, but both are must support, and have a required binding. As such the FHIRCommon library defines functions such as `isActive()` for assessing these statuses. Further examples are provided in the "Common Elements" section below.

### Search Parameters

USCore requires searching by:

* patient

In addition, servers may support searching by:

* clinical-status

> NOTE: For discussion on how to manage search parameters with terminology, see the [Terminology Considerations](architectural-guidance.html#terminology-considerations) discussion in the Architectural Guidance topic.

> NOTE: For discussion on how to manage optional search parameters, see the [Performant Data Access](architectural-guidance.html#performant-data-access) discussion in the Architectural Guidance topic.

### Cross-Version Considerations

There are no significant differences between the 3.1.1, 6.1.0, and 7.0.0 versions of this profile.

### Common Elements and Functions

#### Abatement and prevalence interval

Abatement for an AllergyIntolerance can be represented in multiple ways:

* [`.abatement()`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html#:~:text=define%20fluent%20function-,abatement,-%28allergyIntolerance%20AllergyIntolerance): Returns the abatement of the given AllergyIntolerance, if present
* [`.resolutionAge()`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html#:~:text=define%20fluent%20function-,resolutionAge,-%28allergyIntolerance%20AllergyIntolerance): Returns the resolutionAge of the given AllergyIntolerance, if present

Using these options, an abatement, as well as a prevalence interval, can be calculated:

* [`.abatementInterval()`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html#:~:text=define%20fluent%20function-,abatementInterval,-%28allergyIntolerance%20AllergyIntolerance): Returns an interval representing the normalized abatement of the given AllergyIntolerance resource.
* [`.prevalenceInterval()`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html#:~:text=define%20fluent%20function-,prevalenceInterval,-%28allergyIntolerance%20AllergyIntolerance): Returns an interval representing the normalized prevalence period of the given AllergyIntolerance resource

#### Clinical and verification status

To facilitate checking allergy intolerance status, the following functions are defined in the FHIRCommon library. The `is...` functions operate on a single AllergyIntolerance (and so are typically used within a `where` clause), while the other functions operate on a list of AllergyIntolerance resources, and so are typically used when dealing with an entire set of resources as a single expression:

* [`.isActive()`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html#:~:text=define%20fluent%20function-,isActive,-%28allergyIntolerance%20FHIR)
* [`.active()`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html#:~:text=define%20fluent%20function-,active,-%28allergyIntolerances%20List)
* [`.isInactive()`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html#:~:text=define%20fluent%20function-,isInactive,-%28allergyIntolerance%20FHIR)
* [`.inactive()`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html#:~:text=define%20fluent%20function-,inactive,-%28allergyIntolerances%20List)
* [`.isResolved()`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html#:~:text=define%20fluent%20function-,isResolved,-%28allergyIntolerance%20FHIR)
* [`.resolved()`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html#:~:text=define%20fluent%20function-,resolved,-%28allergyIntolerances%20List)

The AllergyIntolerance resource also has a verificationStatus element to represent information such as whether the allergy has been confirmed. The element is not required, but if it is present, it is a modifier element, and has the potential to negate the information the resource is conveying (e.g., the `refuted` status). For most usage, when application intent is looking for positive evidence of an allergy, the verification statuses of `refuted` and `entered-in-error` should be excluded if `verificationStatus` is present:

```cql
define "Verified Allergies":
  [AllergyIntolerance] VerifiedAllergyIntolerance
    where VerifiedAllergyIntolerance.verificationStatus is not null implies
      (VerifiedAllergyIntolerance.verificationStatus ~ "confirmed"
        or VerifiedAllergyIntolerance.verificationStatus ~ "unconfirmed"
      )
```

To support re-use of this pattern, the FHIRCommon library defines the `isVerified` and `verified` functions, along with other functions for testing verification status. As with the clinical status functions there are two sets, one using an `is` prefix, that are used with single AllergyIntolerance instances, and one set without, used with sets of AllergyIntolerance resources.

* [`.isVerified()`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html#:~:text=define%20fluent%20function-,isVerified,-%28allergyIntolerance%20FHIR)
* [`.verified()`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html#:~:text=define%20fluent%20function-,verified,-%28allergyIntolerance%20FHIR)
* [`.isConfirmed()`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html#:~:text=define%20fluent%20function-,isConfirmed,-%28allergyIntolerance%20FHIR)
* [`.confirmed()`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html#:~:text=define%20fluent%20function-,confirmed,-%28allergyIntolerances%20List)
* [`.isUnconfirmed()`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html#:~:text=define%20fluent%20function-,isUnconfirmed,-%28allergyIntolerance%20FHIR)
* [`.unconfirmed()`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html#:~:text=define%20fluent%20function-,unconfirmed,-%28allergyIntolerances%20List)
* [`.isRefuted()`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html#:~:text=define%20fluent%20function-,isRefuted,-%28allergyIntolerance%20FHIR)
* [`.refuted()`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html#:~:text=define%20fluent%20function-,refuted,-%28allergyIntolerances%20List)

#### Current allergies

To get all confirmed active allergies, ```UCE."Active Confirmed Allergies and Intolerances"``` can be used. 

Current allergies to specific substances can make use of the terminology filter as part of the retrieve:

```cql
define "Statin Allergy Intolerance":
  [USCore."AllergyIntolerance": "Statin Allergen"] StatinAllergyIntolerance
    where StatinAllergyIntolerance.isActive()
```

> NOTE: Because the AllergyIntolerance profile does not constrain the values of the `clinicalStatus` or `verificationStatus` elements, authors must consider the possible values of these elements to ensure the expression matches intent.

In retrospective cases, the logic will be evaluated on data that exists at the time of evaluation. This means that while a given allergy/intolerance may have been active during the retrospective period, it might no longer be active when the logic is evaluated.

* [`"All Allergies and Intolerances"`](Library-USCoreElements.html#:~:text=core%2Dallergyintolerance%0A*/%0Adefine-,%22All%20Allergies%20and%20Intolerances%22,-%3A%0A%20%20%5BUSCore)
* [`"Active Confirmed Allergies and Intolerances"`](Library-USCoreElements.html#:~:text=%22Active%20Confirmed%20Allergies%20and%20Intolerances%22)
* [`"Common Allergies and Intolerances"`](Library-USCoreElements.html#:~:text=()%0A%0Adefine-,%22Common%20Allergies%20and%20Intolerances%22,-%3A%0A%20%20%22All%20Allergies)
* [`"Active Confirmed Common Allergies and Intolerances"`](Library-USCoreElements.html#:~:text=%22Active%20Confirmed%20Common%20Allergies%20and%20Intolerances%22)

#### No known allergies

To check if a patient has confirmed they have no known allergies, use `UCE."No Known Allergies (Confirmed)"`. This will check for SNOMED 716186003 (No known allergy (situation)) as advised in US Core.

US Core also supports documenting `UCE."No Known Allergies (Not Asked)"`, which also uses the No known allergy (situation) SNOMED code, but the instance uses the `unconfirmed` verification status.

* [`"No Known Allergies (Confirmed)"`](Library-USCoreElements.html#:~:text=%22No%20Known%20Allergies%20%28Confirmed%29%22)
* [`"No Known Allergies (Not Asked)"`](Library-USCoreElements.html#:~:text=%22No%20Known%20Allergies%20%28Not%20Asked%29%22)

##### Contrast dye allergy:

Ordering HeadMRI vs HeadCT because patient has allergy to CT dye

```
ICD-10-CM Code for Radiographic dye allergy status Z91.041
```

##### Egg allergy:

```
ICD-10-CM (International Classification of Diseases, 10th Revision, Clinical Modification)
Z91.012 – Allergy to eggs
T78.1XXA – Other adverse food reactions, not elsewhere classified, initial encounter
T78.1XXD – Other adverse food reactions, not elsewhere classified, subsequent encounter
T78.1XXS – Other adverse food reactions, not elsewhere classified, sequela
Z91.018 – Allergy to other foods
SNOMED CT (Systematized Nomenclature of Medicine – Clinical Terms)
91934008 – Egg allergy
281784008 – Egg intolerance
293982008 – Anaphylaxis due to egg
LOINC (Logical Observation Identifiers Names and Codes)
6096-8 – Egg IgE [Mass/volume] in Serum
6241-0 – Egg white IgE [Mass/volume] in Serum
7286-1 – Egg yolk IgE [Mass/volume] in Serum
```

##### Nut allergy: 

```
ICD-10-CM Codes for Nut Allergies
ICD-10-CM classifies food allergies, including nut allergies, under T78.0–T78.1 and Z91.01 series:
T78.01XA – Anaphylactic reaction due to peanuts, initial encounter
T78.01XD – Anaphylactic reaction due to peanuts, subsequent encounter
T78.01XS – Anaphylactic reaction due to peanuts, sequela
T78.02XA – Anaphylactic reaction due to other nuts and seeds, initial encounter
T78.02XD – Anaphylactic reaction due to other nuts and seeds, subsequent encounter
T78.02XS – Anaphylactic reaction due to other nuts and seeds, sequela
Z91.010 – Allergy to peanuts
Z91.018 – Allergy to other nuts
Z91.019 – Allergy to unspecified nuts
```

```cql
define "AllergicToDrugX":
  UCE."Active Confirmed Allergies and Intolerances" A
    where A.code ~ "DrugX"
```

> NOTE: Content for this page was adapted from the [QICore Authoring Patterns - Allergies](https://github.com/cqframework/CQL-Formatting-and-Usage-Wiki/wiki/Authoring-Patterns-QICore-v6.0.0#allergies) topic.