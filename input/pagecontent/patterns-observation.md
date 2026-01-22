The FHIR Observation resource supports capturing a variety of information in a medical record, including simple name/value pair assertions, as well as multi-component observations, and logical groupings of observations. US Core defines several observation profiles to support a variety of use cases, including:

* Vital Signs
* Clinical Results
* Laboratory Results
* Screening Asessments
* Simple Observations
* Other Observations

#### Vital Signs

#### Clinical Results

#### Laboratory Results

US Core defines [US Core Laboratory Result Observation]({{site.data.fhir.ver.uscore7}}/StructureDefinition-us-core-observation-lab.html) to record laboratory observations.

Observation codes will be LOINC. Result values will generally be represented in different ways, according to the type of lab result. The LOINC code itself will often describe the expected representation of possible values for a given observation or test result.

#### Screening Asessments

#### Simple Observations

#### Other Observations

### Modifier Elements

Regardless of which profile is used, the Observation resource defines the following modifier elements:

* status

In addition to being a modifier, this element is required with a required binding. The USCoreCommon library defines several functions for determining the status of an observation, as discussed in the Status section below.

### Search Parameters

USCore defines the following mandatory search parameters:

* patient, category
* patient, code
* patient, category, date

In addition, the following optional search parameters are described:

* patient, category, status
* patient, category, _lastUpdated
* patient, code, date

> NOTE: For discussion on how to manage search parameters with terminology, see the [Terminology Considerations](architectural-guidance.html#terminology-considerations) discussion in the Architectural Guidance topic.

> NOTE: For discussion on how to manage optional search parameters, see the [Performant Data Access](architectural-guidance.html#performant-data-access) discussion in the Architectural Guidance topic.

### Cross-Version Considerations

Generally, new versions of USCore since 3.1.1 have introduced additional profiles, but have not impacted representation of existing profiles. As of 7.0.0, there are generally:

* vital signs (including vital signs described in the base FHIR specification, as well as additional vital signs profiles)
* clinical results
  * laboratory results
* screening assessments
* simple observations

### Common Elements and Functions

#### Status

The USCoreCommon library defines functions and terminology declarations to support determining status of an observation:

* [`isResulted()`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html#:~:text=define%20fluent%20function-,isResulted,-%28observation%20FHIR): returns true if the status is `final`, `amended`, or `corrected`
* [`isFinal()`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html#:~:text=define%20fluent%20function-,isFinal,-%28observation%20FHIR): Returns true if the status is `final`
* [`isAmended()`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html#:~:text=define%20fluent%20function-,isAmended,-%28observation%20FHIR): Returns true if the status is `amended`
* [`isCorrected()`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html#:~:text=define%20fluent%20function-,isCorrected,-%28observation%20FHIR): Returns true if the status is `corrected`

As well as for filtering lists of observations with a given status:

* [`resulted()`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html#:~:text=define%20fluent%20function-,resulted,-%28observations%20List): returns Observations in the given list with a status is `final`, `amended`, or `corrected`
* [`final()`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html#:~:text=define%20fluent%20function-,final,-%28observations%20List): Returns Observations in the given list with a status is `final`
* [`amended()`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html#:~:text=define%20fluent%20function-,amended,-%28observations%20List): Returns Observations in the given list with a status is `amended`
* [`corrected()`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html#:~:text=define%20fluent%20function-,corrected,-%28observations%20List): Returns Observations in the given list with a status is `corrected`

#### Category

* [`.hasCategory(Code)`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html#:~:text=define%20fluent%20function-,hasCategory,-%28observation%20FHIR): Returns true if the given observation has the given category
* [`.isSocialHistory()`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html#:~:text=define%20fluent%20function-,isSocialHistory,-%28observation%20FHIR): Returns true if the given observation has a category of social history
* [`.isVitalSign()`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html#:~:text=define%20fluent%20function-,isVitalSign,-%28observation%20FHIR): Returns true if the given observation has a category of vital sign
* [`.isImaging()`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html#:~:text=define%20fluent%20function-,isImaging,-%28observation%20FHIR): Returns true if the given observation has a category of imaging
* [`.isLaboratory()`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html#:~:text=define%20fluent%20function-,isLaboratory,-%28observation%20FHIR): Returns true if the given observation has a category of laboratory
* [`.isProcedure()`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html#:~:text=define%20fluent%20function-,isProcedure,-%28observation%20FHIR): Returns true if the given observation has a category of procedure
* [`.isSurvey()`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html#:~:text=define%20fluent%20function-,isSurvey,-%28observation%20FHIR): Returns true if the given observation has a category of survey
* [`.isExam()`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html#:~:text=define%20fluent%20function-,isExam,-%28observation%20FHIR): Returns true if the given observation has a category of exam
* [`.isActivity()`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html#:~:text=define%20fluent%20function-,isActivity,-%28observation%20FHIR): Returns true if the given observation has a category of activity

#### Interpretation

Note that the interpretation element of an observation may not be present, and may not be coded as expected. Care must be taken in the use of this element to ensure that data conforms with the expectations of the logic.

* [`.positive()`](Library-USCoreCommon.html#:~:text=define%20fluent%20function-,positive,-%28observations%20List): Returns Observations in the given list that have an interpretation of positive
* [`.negative()`](Library-USCoreCommon.html#:~:text=define%20fluent%20function-,negative,-%28observations%20List): Returns Observations in the given list that have an interpretation of negative

#### Timings

* [`.during(Encounter)`](Library-USCoreCommon.html#:~:text=define%20fluent%20function-,during,-%28observations%20List): Returns Observations in the given list that were issued during the given Encounter
* [`.within(Quantity)`](Library-USCoreCommon.html#:~:text=define%20fluent%20function-,within,-%28observations%20List): Returns Observations in the given list that were issued within the given time duration before now
* [`.consecutively()`](Library-USCoreCommon.html#:~:text=define%20fluent%20function-,consecutively,-%28observations%20List): Returns Observations consecutively by when they were issued
* [`.consecutivelyFrom(Observation)`](Library-USCoreCommon.html#:~:text=define%20fluent%20function-,consecutivelyFrom,-%28observations%20List): Returns Observations consecutively by when they were issued, on or after when the given Observation was issued  

#### Observation Elements

In addition, the USCoreElements library defines expressions for accessing the various USCore profiles, such as:

* [`"All Laboratory Results"`](Library-USCoreElements.html#:~:text=observation%2Dlab%0A*/%0Adefine-,%22All%20Laboratory%20Results%22,-%3A%0A%20%20%5B%22LaboratoryResultObservationProfile)
* [`"Resulted Laboratory Results"`](Library-USCoreElements.html#:~:text=%22Resulted%20Laboratory%20Results%22)
* `"Pediatric BMI for Age"`

In general, the expressions to retrieve observations for a particular profile include the `.resulted()` function to ensure only final, amended, or corrected observations are returned.

#### Pregnancy Status

US Core allows for the presence of pregnancy to be represented in multiple resources. The US Core profile [Pregnancy Status]({{site.data.fhir.ver.uscore7}}/StructureDefinition-us-core-observation-pregnancystatus.html) allows for the representation of pregnancy as an Observation. However, pregnancy information may also be represented in a laboratory test result, an encounter diagnosis, or a problem list item.

To determine if an individual is pregnant, the following approach may be used to consider all three approaches: 

```cql
valueset "Pregancy Condition Codes": 'TBD'
valueset "Pregnancy Test Codes": 'TBD'

codesystem "SNOMEDCT": 'http://snomed.info/sct'

code "Pregnant": '77386006' from "SNOMEDCT" display 'Pregnant (finding)'
code "Positive": 'positive' from "Interpretation Codes"
 
define "Positive Pregnancy Observation":
  ["Observation Pregnancy Status Profile"] PregnancyStatus
    where PregnancyStatus.status = 'final'
      and PregnancyStatus.value ~ "Pregnant" 
      and PregnancyStatus.effective.toInterval() overlaps "Measurement Period"

define "Positive Pregnancy Test Result":
  ["Laboratory Result Observation": "Pregnancy Test Codes"] PregnancyTest
    where PregnancyTest.status = 'final'
      and PregnancyTest.value ~ "Positive"
      and PregnancyTest.effective.toInterval() during "Measurement Period"
      
define "Pregnancy Encounter Diagnosis":
  [ConditionEncounterDiagnosis: "Pregnancy Condition Codes"] EncounterDiagnosis
    with "Encounters" Encounter
      such that EncounterDiagnosis.encounter.references(Encounter)
      
define "Pregnancy Condition":
  [ConditionProblemsHealthConcerns: "Pregnancy Condition Codes"] Condition
    where Condition.clinicalStatus ~  "active"
      and Condition.verificationStatus ~ "confirmed"
      and Condition.prevalenceInterval() starts during "Measurement Period"

define IsPregnant:
  exists "Positive Pregnancy Observation" 
    or exists "Positive Pregnancy Test"
    or exists "Pregnancy Condition"
    or exists "Pregnancy Encounter Diagnosis"
```

Note that the examples above assume the existence of a ValueSet "Pregnancy Condition Codes" containing codes pertaining to conditions while pregnant.

In addition, the "Pregnancy Encounter Diagnosis" criteria is assuming the existence of an "Encounters" expression that constrains the encounter diagnoses to measure intent as well as the measurement period.

If a use case requires the use of prevalence period (onset and/or abatement time for a condition), it will require the use of condition profiles because onset and/or abatement times are only available in the Condition resource.

##### Pregnancy Intent

The [Pregnancy Intent]({{site.data.fhir.ver.uscore7}}/StructureDefinition-us-core-observation-pregnancyintent.html) profile sets minimum expectations for the Observation resource to record, search, and retrieve the "patient's intent to become pregnant" over the next year.

```cql
codesystem "LOINC": 'http://loinc.org'

code "Pregnancy intention in the next year - Reported": '86645-9'
code "Yes, I want to become pregnant": 'LA26438-4'

define "Positive Pregnancy Intent":
  ["Observation Pregnancy Intent Profile"] PregnancyIntent
    where PregnancyIntent.effective.toInterval() during "Measurement Period"
      and PregnancyIntent.value ~ "Yes, I want to become pregnant"
```
    
### Examples

#### Three Concurrent Negative Stick Tests

This example illustrates logic for identifying three concurrent negative "stick tests":

```cql
define StickTest:
  [Observation: "Stick Test Codes"] O
    where O.status in { 'final', 'amended', 'corrected' }

define "Three Consecutive Negative Stick Tests":
  exists (
    StickTest.during(Encounter).consecutively().take(3).negative().count() = 3
  )
```

In addition, this expression can be parameterized with current context (for example from a trigger context) with:

```cql
StickTest.consecutivelyFrom(%context).take(3).negative().count() = 3
```

> NOTE: Content for this page was adapted from the [QICore Authoring Patterns - Laboratory Result](https://github.com/cqframework/CQL-Formatting-and-Usage-Wiki/wiki/Authoring-Patterns-QICore-v6.0.0#laboratory-result) topic.

