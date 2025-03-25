US Core defines [US Core MedicationRequest]({{site.data.fhir.ver.uscore6}}/StructureDefinition-us-core-medicationrequest.html) to record a patient's medication prescription or order, as well as self-reported medications.

MedicationRequest can either use a code which will be RXNORM plus an optional NDC (https://vsac.nlm.nih.gov/valueset/2.16.840.1.113762.1.4.1010.4/expansion), or use a reference to a more detailed Medication resource (which also uses RXNORM plus optional NDC).

### Modifier Elements

The MedicationRequest resource defines the following modifier elements:

* status
* intent
* doNotPerform

In addition to being modifiers, the `status` and `intent` elements are required with a required binding. The USCoreCommon library defines several functions for determining status and intent.

However, `doNotPerform` is not required, so care must be taken to ensure that if specified, the `doNotPerform` element is respected.

### Search Parameters

USCore defines the following mandatory search parameters:

* patient, intent
* patient, intent, status

In addition, the following optional parameters are defined:

* patient, intent, encounter
* patient, intent, authoredOn

> NOTE: For discussion on how to manage search parameters with terminology, see the [Terminology Considerations](architectural-guidance.html#terminology-considerations) discussion in the Architectural Guidance topic.

> NOTE: For discussion on how to manage optional search parameters, see the [Performant Data Access](architectural-guidance.html#performant-data-access) discussion in the Architectural Guidance topic.

### Cross-Version Considerations

Although newer versions of USCore introduce additional capability through new elements, there are no significant backwards compatibility issues associated with using the 3.1.1 version.

### Common Elements and Functions

#### Active Medications

> NOTE: In the prior auth use case (https://build.fhir.org/ig/cqframework/cqf-us/use-case-pa.html), the workflow is generally being conducted in the context of 1 or more order, so you'll want to start by working off that context before searching the FHIR server for medication requests.

<!--
> TODO: in UCE we want a few wrappers for common things people would want from a MedicationRequest (procedure code, who/where requested it, who/where is performing it), however these are currently built on ```UCE."Most Recent MedicationRequest"``` which could be pulling the wrong data. We need our functions structured to support working on the data in context during DTR.
-->

To get all medications, ```UCE."All Medication Requests"``` can be used. To filter it down to active medications, ```UCE."Active Medication Orders"``` can be used.

> NOTE: Content for this page was adapted from the [QICore Authoring Patterns - Medications](https://github.com/cqframework/CQL-Formatting-and-Usage-Wiki/wiki/Authoring-Patterns-QICore-v6.0.0#medications) topic.