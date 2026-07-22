US Core defines [US Core Laboratory Result Observation]({{site.data.fhir.ver.uscore6}}/StructureDefinition-us-core-observation-lab.html) to record laboratory observations.

Observation codes will be LOINC. Result values will generally be represented in different ways, according to the type of lab result. The LOINC code itself will often describe the expected representation of possible values for a given observation or test result.

### Modifier Elements

The Observation resource defines the following modifier elements:

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

* `isResulted()`: returns true if the status is `final`, `amended`, or `corrected`
* `isFinal()`
* `isAmended()`
* `isCorrected()`

In addition, the USCoreElements library defines expressions for accessing the various USCore profiles, such as:

* `"All Laboratory Results"`
* `"Resulted Laboratory Results"`
* `"Pediatric BMI for Age"`

In general, the expressions to retrieve observations for a particular profile include the `.resulted()` function to ensure only final, amended, or corrected observations are returned.

> NOTE: Content for this page was adapted from the [QICore Authoring Patterns - Laboratory Result](https://github.com/cqframework/CQL-Formatting-and-Usage-Wiki/wiki/Authoring-Patterns-QICore-v6.0.0#laboratory-result) topic.

