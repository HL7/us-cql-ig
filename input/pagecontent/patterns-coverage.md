USCore defines the [USCore Coverage]({{site.data.fhir.ver.uscore6}}/StructureDefinition-us-core-coverage.html) profile to record insurance coverage information for a patient.

### Modifier Elements

The base Coverage resource defines the following _modifier_ elements:

* status

In general, applications should ensure that the `status` element for a Coverage resource is appropriately set for their use case. Note that for many applications, such as prior authorization, Coverage resources would be expected to have a status of `active` in order to be considered.

The US Core Coverage profile does not introduce any modifier extensions.

### Search Parameters

In general, the Coverage under consideration will be established by application context, so although US Core does define search parameters for Coverage based on Patient, no special considerations are discussed here.

> NOTE: For discussion on how to manage search parameters with terminology, see the [Terminology Considerations](architectural-guidance.html#terminology-considerations) discussion in the Architectural Guidance topic.

> NOTE: For discussion on how to manage optional search parameters, see the [Performant Data Access](architectural-guidance.html#performant-data-access) discussion in the Architectural Guidance topic.

### Cross-Version Considerations

There are no significant backwards-compatibility issues between versions for the Coverage profile.

### Common Elements and Functions

#### Member or Subscriber ID

The USCore Coverage Profile defines a slice on identifier called `memberid` that can be used to access the patient's member id. The US Core Elements library provides the [`.memberID()`](Library-USCoreElements.html#:~:text=define%20fluent%20function-,memberID,-%28coverage%20FHIR) fluent function for this purpose, along with [`.policyNumber()`](Library-USCoreElements.html#:~:text=define%20fluent%20function-,policyNumber,-%28coverage%20FHIR) for accessing the subscriber id:

```cql
define "Covered Member ID":
  Coverage.memberID()
```

In addition, the profile defines an invariant that either the `memberid` slice or `subscriberId` must be present.