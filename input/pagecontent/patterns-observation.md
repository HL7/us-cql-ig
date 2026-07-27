The FHIR Observation resource supports capturing a variety of information in a medical record, including simple name/value pair assertions, as well as multi-component observations, and logical groupings of observations. US Core defines several observation profiles to support a variety of use cases, including:

* Vital Signs
* Clinical Results
* Laboratory Results
* Screening Assessments
* Simple Observations
* Other Observations

#### Vital Signs

US Core defines the base [US Core Vital Signs Profile]({{site.data.fhir.ver.uscore6}}/StructureDefinition-us-core-vital-signs.html) to represent vital signs generally, as well as specific vital signs for many common vital signs such as Weight, Height, BMI, and Blood Pressure.

#### Clinical Results

US Core defines [US Core Observation Clinical Result Profile]({{site.data.fhir.ver.uscore6}}/StructureDefinition-us-core-observation-clinical-result.html) to represent clinical test results. Note that the laboratory test result profile is derived from the clinical result profile (i.e. all laboratory results are clinical results).

#### Laboratory Results

US Core defines [US Core Laboratory Result Observation]({{site.data.fhir.ver.uscore6}}/StructureDefinition-us-core-observation-lab.html) to record laboratory observations.

Observation codes will be LOINC. Result values will generally be represented in different ways, according to the type of lab result. The LOINC code itself will often describe the expected representation of possible values for a given observation or test result.

#### Screening Assessments

US Core defines [US Core Screening Assessment]({{site.data.fhir.ver.uscore6}}/StructureDefinition-us-core-observation-screening-assessment.html) to record the result of screening assessment tools.

#### Simple Observations

US Core defines [US Core Simple Observation]({{site.data.fhir.ver.uscore6}}/StructureDefinition-us-core-simple-observation.html) to record observations not otherwise classified as clinical tests, laboratory results, vital signs, screening assessments, or other specific profiles defined in US Core.

#### Other Observations

US Core defines the following additional profiles for capturing specific types of observations:

* [US Core Pregnancy Status]({{site.data.fhir.ver.uscore6}}/StructureDefinition-us-core-observation-pregnancystatus.html)
* [US Core Pregnancy Intent]({{site.data.fhir.ver.uscore6}}/StructureDefinition-us-core-observation-pregnancyintent.html)
* [US Core Smoking Status]({{site.data.fhir.ver.uscore6}}/StructureDefinition-us-core-smokingstatus.html)
* [US Core Occupation]({{site.data.fhir.ver.uscore6}}/StructureDefinition-us-core-observation-occupation.html)
* [US Core Sexual Oritentation]({{site.data.fhir.ver.uscore6}}/StructureDefinition-us-core-observation-sexual-orientation.html)

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

Generally, new versions of USCore since 3.1.1 have introduced additional profiles, but have not impacted representation of existing profiles. As of 6.1.0, there are generally:

* vital signs (including vital signs described in the base FHIR specification, as well as additional vital signs profiles)
* clinical results
  * laboratory results
* screening assessments
* simple observations

### Common Elements and Functions

#### Status

The FHIRCommon library defines functions and terminology declarations to support determining status of an observation:

* [`isResulted()`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html#:~:text=define%20fluent%20function-,isResulted,-%28observation%20FHIR): returns true if the status is `final`, `amended`, or `corrected`
* [`isFinal()`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html#:~:text=define%20fluent%20function-,isFinal,-%28observation%20FHIR): Returns true if the status is `final`
* [`isAmended()`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html#:~:text=define%20fluent%20function-,isAmended,-%28observation%20FHIR): Returns true if the status is `amended`
* [`isCorrected()`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html#:~:text=define%20fluent%20function-,isCorrected,-%28observation%20FHIR): Returns true if the status is `corrected`

As well as for filtering lists of observations with a given status:

* [`resulted()`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html#:~:text=define%20fluent%20function-,resulted,-%28observations%20List): returns Observations in the given list with a status of `final`, `amended`, or `corrected`
* [`final()`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html#:~:text=define%20fluent%20function-,final,-%28observations%20List): Returns Observations in the given list with a status of `final`
* [`amended()`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html#:~:text=define%20fluent%20function-,amended,-%28observations%20List): Returns Observations in the given list with a status of `amended`
* [`corrected()`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html#:~:text=define%20fluent%20function-,corrected,-%28observations%20List): Returns Observations in the given list with a status of `corrected`

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

* [`.during(Encounter)`](Library-USCoreCommon.html#:~:text=define%20fluent%20function-,during,-%28observations%20List): Returns Observations in the given list whose effective time is during the given Encounter, accurate to the minute
* [`.chronologically()`](Library-USCoreCommon.html#:~:text=define%20fluent%20function-,chronologically,-%28observations%20List): Returns Observations chronologically by their effective time
* [`.chronologicallyAfter(Observation)`](Library-USCoreCommon.html#:~:text=define%20fluent%20function-,chronologicallyAfter,-%28observations%20List): Returns Observations chronologically by their effective time, on or after the start of the effective time of the given Observation  

> NOTE: We are seeking implementer feedback on timing functions specifically: What additional timing functions would be useful?

##### Specimen Collection Time

Note that for the specific timing of specimen collection time, although the FHIR Specimen resource defines a collection time element, that element is not indicated as must support in the US Core Specimen profile, and so is not likely to be available for use. In addition, the `effectiveTime` element of the Observation resource is specifically documented as the "physiologically relevant time", and "usually either the time of the procedure or specimen collection". To allow for the specimen collection time to be used, logic can prefer that element if present, falling back to the observation effective time if for laboratory results. As with all clinical logic patterns, when this method is used, care should be taken to ensure that the data on which the logic will be run conforms to this usage pattern.

As an example, consider the index date of an infection using specimen collection time:

```cql
define "Bacteremia or Fungemia Result With Specimen":
  from
    "Bacteremia or Fungemia Result" R,
    [Specimen: "Specimen Type - Blood"] S
    where R.specimen.references(S)
    return {
      result: R,
      specimen: S
    }
```

The index date of a set of results could then be determined by:

```cql
  indexDate: Min(
    results R 
      return Coalesce(
        start of R.specimen.collection.collected.toInterval(), // Specimen.collection.collected, if present
        start of R.result.effective.toInterval() // Fallback to Observation.effective
      )
  )
```

Note that the specimen collection type here still needs to be identified (using the `"Specimen Type - Blood"` value set in this case), as it can usually not be reliably inferred from the test type.

#### Observation Elements

In addition, the USCoreElements library defines expressions for accessing the various USCore observation profiles:

* Laboratory Result
  * [`"All Laboratory Results"`](Library-USCoreElements.html#:~:text=define%20%22All%20Laboratory%20Results%22)
  * [`"Resulted Laboratory Results"`](Library-USCoreElements.html#:~:text=define%20%22Resulted%20Laboratory%20Results%22)
* Pediatric BMI for Age
  * [`"Pediatric BMI for Age"`](Library-USCoreElements.html#:~:text=define%20%22Pediatric%20BMI%20for%20Age%22)
  * [`"Pediatric BMI for Age All Statuses"`](Library-USCoreElements.html#:~:text=define%20%22Pediatric%20BMI%20for%20Age%20All%20Statuses%22)
* Pediatric Head Circumference Percentile
  * [`"Pediatric Head Circumference Percentile"`](Library-USCoreElements.html#:~:text=define%20%22Pediatric%20Head%20Circumference%20Percentile%22)
  * [`"Pediatric Head Circumference Percentile All Statuses"`](Library-USCoreElements.html#:~:text=define%20%22Pediatric%20Head%20Circumference%20Percentile%20All%20Statuses%22)
* Pediatric Weight for Height
  * [`"Pediatric Weight for Height"`](Library-USCoreElements.html#:~:text=define%20%22Pediatric%20Weight%20for%20Height%22)
  * [`"Pediatric Weight for Height All Statuses"`](Library-USCoreElements.html#:~:text=define%20%22Pediatric%20Weight%20for%20Height%20All%20Statuses%22)
* Pulse Oximetry
  * [`"Pulse Oximetry"`](Library-USCoreElements.html#:~:text=define%20%22Pulse%20Oximetry%22)
  * [`"Pulse Oximetry All Statuses"`](Library-USCoreElements.html#:~:text=define%20%22Pulse%20Oximetry%20All%20Statuses%22)
* Smoking Status
  * [`"Smoking Status"`](Library-USCoreElements.html#:~:text=define%20%22Smoking%20Status%22)
  * [`"Smoking Status All Statuses"`](Library-USCoreElements.html#:~:text=define%20%22Smoking%20Status%20All%20Statuses%22)
  * [`"Most Recent Smoking Status"`](Library-USCoreElements.html#:~:text=define%20%22Most%20Recent%20Smoking%20Status%22)
* Vital Signs
  * [`"All Vital Signs"`](Library-USCoreElements.html#:~:text=define%20%22All%20Vital%20Signs%22)
  * [`"All Vital Signs All Statuses"`](Library-USCoreElements.html#:~:text=define%20%22All%20Vital%20Signs%20All%20Statuses%22)
* Respiratory Rate
  * [`"All Respiratory Rate Measurements"`](Library-USCoreElements.html#:~:text=define%20%22All%20Respiratory%20Rate%20Measurements%22)
  * [`"All Respiratory Rate Measurements All Statuses"`](Library-USCoreElements.html#:~:text=define%20%22All%20Respiratory%20Rate%20Measurements%20All%20Statuses%22)
* Heart Rate
  * [`"All Heart Rate Measurements"`](Library-USCoreElements.html#:~:text=define%20%22All%20Heart%20Rate%20Measurements%22)
  * [`"All Heart Rate Measurements All Statuses"`](Library-USCoreElements.html#:~:text=define%20%22All%20Heart%20Rate%20Measurements%20All%20Statuses%22)
* Body Temperature
  * [`"All Body Temperature Measurements"`](Library-USCoreElements.html#:~:text=define%20%22All%20Body%20Temperature%20Measurements%22)
  * [`"All Body Temperature Measurements All Statuses"`](Library-USCoreElements.html#:~:text=define%20%22All%20Body%20Temperature%20Measurements%20All%20Statuses%22)
* Body Height
  * [`"All Body Height Measurements"`](Library-USCoreElements.html#:~:text=define%20%22All%20Body%20Height%20Measurements%22)
  * [`"All Body Height Measurements All Statuses"`](Library-USCoreElements.html#:~:text=define%20%22All%20Body%20Height%20Measurements%20All%20Statuses%22)
* Head Circumference
  * [`"All Head Circumference Measurements"`](Library-USCoreElements.html#:~:text=define%20%22All%20Head%20Circumference%20Measurements%22)
  * [`"All Head Circumference Measurements All Statuses"`](Library-USCoreElements.html#:~:text=define%20%22All%20Head%20Circumference%20Measurements%20All%20Statuses%22)
* Body Weight
  * [`"All Body Weight Measurements"`](Library-USCoreElements.html#:~:text=define%20%22All%20Body%20Weight%20Measurements%22)
  * [`"All Body Weight Measurements All Statuses"`](Library-USCoreElements.html#:~:text=define%20%22All%20Body%20Weight%20Measurements%20All%20Statuses%22)
* Body Mass Index
  * [`"All Body Mass Index Measurements"`](Library-USCoreElements.html#:~:text=define%20%22All%20Body%20Mass%20Index%20Measurements%22)
  * [`"All Body Mass Index Measurements All Statuses"`](Library-USCoreElements.html#:~:text=define%20%22All%20Body%20Mass%20Index%20Measurements%20All%20Statuses%22)
* Blood Pressure
  * [`"All Blood Pressure Measurements"`](Library-USCoreElements.html#:~:text=define%20%22All%20Blood%20Pressure%20Measurements%22)
  * [`"All Blood Pressure Measurements All Statuses"`](Library-USCoreElements.html#:~:text=define%20%22All%20Blood%20Pressure%20Measurements%20All%20Statuses%22)
  * [`"Systolic Blood Pressure"`](Library-USCoreElements.html#:~:text=define%20%22Systolic%20Blood%20Pressure%22)
  * [`"Diastolic Blood Pressure"`](Library-USCoreElements.html#:~:text=define%20%22Diastolic%20Blood%20Pressure%22)
* Body Surface Area
  * [`"Most Recent BSA"`](Library-USCoreElements.html#:~:text=define%20%22Most%20Recent%20BSA%22)

In general, the expressions to retrieve observations for a particular profile include the `.resulted()` function to ensure only final, amended, or corrected observations are returned. Each profile typically provides an `All Statuses` variant that returns observations regardless of status, along with a status-filtered expression built on top of it.

#### Clinical Results

Clinical test results **(including imaging results)** in US Core use the [ObservationClinicalResult]({{site.data.fhir.ver.uscore6}}/StructureDefinition-us-core-observation-clinical-result.html) profile. By default, clinical test results in US Core are characterized by the code element.

```cql
define ObservationClinicalResult:
  ["Observation Clinical Result Profile"] O
    where O.isResulted()
```

Note that observations associated with imaging are expected to represent specific measurements obtained from imaging. See the [Imaging Procedures](patterns-service.html#imaging-procedures) discussion for more information.

> NOTE: US Core 5 defined two different profiles for clinical results, one for [test results](https://hl7.org/fhir/us/core/STU5.0.1/StructureDefinition-us-core-observation-clinical-test.html), and one for [imaging results](https://hl7.org/fhir/us/core/STU5.0.1/StructureDefinition-us-core-observation-imaging.html). These profiles were combined in US Core 6 in the clinical result profile.

#### Pregnancy Status

US Core allows for the presence of pregnancy to be represented in multiple resources. The US Core profile [Pregnancy Status]({{site.data.fhir.ver.uscore6}}/StructureDefinition-us-core-observation-pregnancystatus.html) allows for the representation of pregnancy as an Observation. However, pregnancy information may also be represented in a laboratory test result, an encounter diagnosis, or a problem list item.

As an example, to determine if an individual is pregnant at any point during a measurement period, the following approach may be used to consider all three approaches: 

```cql
valueset "Pregancy Condition Codes": 'TBD'
valueset "Pregnancy Test Codes": 'TBD'

codesystem "SNOMEDCT": 'http://snomed.info/sct'

code "Pregnant": '77386006' from "SNOMEDCT" display 'Pregnant (finding)'
code "Positive": 'POS' from "Interpretation Codes"
 
define "Positive Pregnancy Observation":
  ["Observation Pregnancy Status Profile"] PregnancyStatus
    where PregnancyStatus.status = 'final'
      and PregnancyStatus.value ~ "Pregnant" 
      and PregnancyStatus.effective.toInterval() overlaps "Measurement Period"

define "Positive Pregnancy Test Result":
  ["Laboratory Result Observation": "Pregnancy Test Codes"] PregnancyTest
    where PregnancyTest.status = 'final'
      and PregnancyTest.value ~ "Positive"
      and PregnancyTest.effective.toInterval() overlaps "Measurement Period"
      
define "Pregnancy Encounter Diagnosis":
  [ConditionEncounterDiagnosis: "Pregnancy Condition Codes"] EncounterDiagnosis
    with "Encounters" Encounter
      such that EncounterDiagnosis.encounter.references(Encounter)

define "Pregnancy Condition":
  [ConditionProblemsHealthConcerns: "Pregnancy Condition Codes"] Condition
    where Condition.clinicalStatus ~  "active"
      and Condition.verificationStatus ~ "confirmed"
      and Condition.prevalenceInterval() overlaps "Measurement Period"

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

The [Pregnancy Intent]({{site.data.fhir.ver.uscore6}}/StructureDefinition-us-core-observation-pregnancyintent.html) profile sets minimum expectations for the Observation resource to record, search, and retrieve the "patient's intent to become pregnant" over the next year.

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

#### Three Consecutive Negative Stick Tests

This example illustrates logic for identifying three consecutive negative "stick tests":

```cql
define StickTest:
  [Observation: "Stick Test Codes"] O
    where O.status in { 'final', 'amended', 'corrected' }

define "Three Consecutive Negative Stick Tests":
  exists (
    StickTest.during(Encounter).chronologically().take(3).negative().count() = 3
  )
```

> NOTE: The use of the term _consecutive_ here means there are no intervening positive tests, rather than that they are strictly sequential chronologically (i.e. with no gaps in time in between).

In addition, this expression can be parameterized with current context (for example from a trigger context) with:

```cql
StickTest.chronologicallyAfter(%context).take(3).negative().count() = 3
```

> NOTE: Content for this page was adapted from the [QICore Authoring Patterns - Laboratory Result](https://github.com/cqframework/CQL-Formatting-and-Usage-Wiki/wiki/Authoring-Patterns-QICore-v6.0.0#laboratory-result) topic.

