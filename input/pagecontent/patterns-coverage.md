USCore defines the [USCore Coverage]({{site.data.fhir.ver.uscore}}/StructureDefinition-us-core-coverage.html)

### Modifier Elements

The base Coverage resource defines the following _modifier_ elements:

* status

In general, applications should ensure that the `status` element for a Coverage resource is appropriately set for their use case. Note that for many applications, such as prior-authorization, Coverage resources would be expected to have a status of `active` in order to be considered.

The US Core Coverage profile does not introduce any modifier extensions.

### Search Parameters

In general, the Coverage under consideration will be established by application context, so although US Core does define search parameters for Coverage based on Patient, no special considerations are discussed here.

### Cross-Version Considerations

There are no significant backwards-compatibility issues between versions for the Coverage profile.

### Common Elements and Functions

#### Member ID

The [USCore 6.1 Coverage Profile](https://hl7.org/fhir/us/core/STU6.1/StructureDefinition-us-core-coverage.html) defines a slice on identifier called `memberid` that can be used to access the patient's member id

```cql
define "Covered Member ID":
  Coverage.memberId()
```

#### Subscriber ID

