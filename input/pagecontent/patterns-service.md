US Core defines [US Core ServiceRequest]({{site.data.fhir.ver.uscore6}}/StructureDefinition-us-core-servicerequest.html) to track the proposal / planning / ordering of a service, and [US Core Procedure]({{site.data.fhir.ver.uscore6}}/StructureDefinition-us-core-procedure.html) to track performing a service.

Typical procedure codes include SNOMED-CT, CPT, HCPCS II, ICD-10-PCS, CDT, and LOINC.

### Modifier Elements

The ServiceRequest resource defines the following modifier elements:

* status
* intent
* doNotPerform

In addition to being modifiers, the `status` and `intent` elements are required with a required binding. The USCoreCommon library defines several functions for determining status and intent.

However, `doNotPerform` is not required, so care must be taken to ensure that if specified, the `doNotPerform` element is respected.

### Search Parameters

USCore defines the following mandatory search parameters:

* patient, category
* patient, code
* patient, category, authored

In addition, the following optional parameters are defined:

* patient, status
* patient, code, authored

> NOTE: For discussion on how to manage search parameters with terminology, see the [Terminology Considerations](architectural-guidance.html#terminology-considerations) discussion in the Architectural Guidance topic.

> NOTE: For discussion on how to manage optional search parameters, see the [Performant Data Access](architectural-guidance.html#performant-data-access) discussion in the Architectural Guidance topic.

### Cross-Version Considerations

Note that 3.1.1 does not define a profile for ServiceRequest, so the direct FHIR ServiceRequest resource is used.

### Common Elements and Functions

#### Requested Services

> NOTE: In the [prior auth use case](use-case-pa.html), the workflow is generally being conducted in the context of 1 or more order, so you'll want to start by working off that context before searching the FHIR server for service requests.

<!--
> TODO: in UCE we want a few wrappers for common things people would want from a ServiceRequest (procedure code, who/where requested it, who/where is performing it), however these are currently built on ```UCE."Most Recent ServiceRequest"``` which could be pulling the wrong data. We need our functions structured to support working on the data in context during DTR.
-->

If you need to search for requested services, this is made available with ```UCE."All ServiceRequests"```.

> NOTE: Content for this page was adapted from the [QICore Authoring Patterns - Procedures](https://github.com/cqframework/CQL-Formatting-and-Usage-Wiki/wiki/Authoring-Patterns-QICore-v6.0.0#procedures) topic.