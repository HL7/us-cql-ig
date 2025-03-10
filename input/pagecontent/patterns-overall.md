### Element Considerations

Whether logic in general should make use of the various elements of a resource (or profile of a resource) depends on measure or rule intent. However, there are some general guidelines that should be followed to ensure correct expression and evaluation of CQL.

#### Element Cardinality

To begin with, all elements in FHIR resources and profiles have a cardinality that determines whether and how many values may appear in that element. Cardinality is expressed as a range, typically from `0` or `1` to `1` or `*`. A cardinality of `0..1` means the element is optional. A cardinality of `1..1` means the element is required. A cardinality of `0..*` means the element may appear any number of times, and a cardinality of `1..*` means the element must appear at least once, but may appear multiple times. Although other cardinalities are possible, those described above are the most common.

NOTE: Cardinality determines whether and how many values may appear for a given element, but the fact that an element is specified as required (e.g. 1..1) does not mean that expressions using that profile must use that element.

#### Must Support Elements

In addition, elements in FHIR resources and profiles may be marked _must support_, meaning that implementations are required to provide values for the element if they are present in the system. To ensure expression logic can be evaluated correctly, expressions should only make use of elements that are marked must support (or otherwise have a reasonable expectation of being present). For a complete discussion of this aspect, refer to the [MustSupport Flag](https://hl7.org/fhir/us/core/must-support.html) topic in the US Core Implementation Guide.

#### Modifier Elements

And finally, elements in FHIR resources and profiles may be marked as _modifier_ elements, meaning that the value of the element may change the overall meaning of the resource. For example, the `clinicalStatus` element of a `Condition` is a modifier element because the value determines whether the `Condition` overall represents the presence or absence of a condition. As a result, for each modifier element, authors must carefully consider whether each possible value would impact the intent of the expression.

##### Modifier Extensions

In addition to modifier elements, extensions in FHIR may be modifier extensions, and any FHIR resource that has modifier extensions that are not understood cannot be processed. Applications may consider performing this check as part of the overall environment, or the CQL logic may be used to ensure that either no modifier extensions are specified, or that only expected modifier extensions are present using the [`checkModifiers()`](https://hl7.org/fhir/fhirpath.html#functions) function.

### ImplicitRules

A key modifier element that must be considered for any FHIR resource is [`implicitRules`](https://hl7.org/fhir/R4/resource-definitions.html#Resource.implicitRules). If this element is specified, it must be respected and understood. Applications may consider performing this check as part of the overall environment, or the CQL logic may be used to ensure that either no implicit rules are specified, or that the implicitRules are expected:

```cql
define fluent function checkImplicitRules(resource Resource, knownImplicitRules String):
  Message(
    resource, 
    resource.imiplicitRules !~ knownImplicitRules, 
    'implicit-rules-check', 
    'Error', 
    'Implicit rules check failed for resource ' + resource.resourceType + '\' + resource.id
  )
```
### Accessing Data

To summarize, _cardinality_ determines whether data will be present at all, _must support_ determines whether the element can reasonably be expected to be present, and _modifier_ elements must always be considered to determine the impact of possible values of the element on the result of the expression.

With these element considerations in mind, there are some general patterns for accessing data within CQL using the [Retrieve](https://cql.hl7.org/02-authorsguide.html#retrieve) expression:

```cql
define "All Allergies and Intolerances":
  [USCore."AllergyIntolerance"]
```

This retrieve expression consists only of the name of the profiled resource being requested, and will result in all AllergyIntolerance resources that conform to the profile being retrieved.

Because the `clinicalStatus` and `verificationStatus` elements of the AllergyIntolerance resource are modifier elements, they should be considered whenever accessing and using these types of resources.

The `USCoreCommon` library provides fluent functions for checking these status elements:

```cql
define "Active Confirmed Allergies and Intolerances":
  "All Allergies and Intolerances".allergyActive().allergyConfirmed()
```

### Context Questions

The following topics discuss issues related to types of questions that will be common to multiple questionnaires, and may potentially already be known from context.

#### Billing/Servicing Provider

Should questions related to determining and identifying billing/servicing provider be present in prior authorization questionnaires?

Possibilities:
1. Known ahead of time (and part of the ServiceRequest, so doesn't make sense to ask)
2. Not known, but will be specified by a separate process (such as order dispatch)
3. Servicing isn't part of the process

* Directed order - provider has to be on the order
* Undirected order - provider may or may not be on the order, requesting organization may need to specify at some point, but may not care. If provider doesn't care and payer does, having it in the questionnaire potentially gives the payer an opportunity for the in/out of network check to be performed, as well as for the payer to participate in the decision of who the servicing/billing provider is?

Should the question(s) be framed as "Pick one of these in network providers near you?"

TODO: Definitely need examples of "Pick an organization from this list", "Pick a practitioner from this list"?

> Note that the paper equivalent is "provider name, address, and phone number", whereas the FHIR Questionnaire approach is based on lists

#### Questions related to the Service being Authorized

Authorization for lab tests is sometimes determined based on category (e.g. preventative, treatment, elective). Is this categorization something that would typically be expected to be present in the ServiceRequest (likely not), and if not, how would that be represented, or is it only something that is captured as part of the Prior Authorization process?

Could potentially put it in a "reason", but that may not necessarily be coded in a way that is useful for the payer

#### Urgency

Almost all prior auth forms contain a question about the urgency of the request. Different forms have different ways of expressing the same logic. E.g., the [Humana Uniform Pharmacy Prior Authorization Request Form](https://docushare-web.apps.external.pioneer.humana.com/Marketing/docushare-app?file=2567656) uses check boxes with the strings "Urgent" and "Non-Urgent". The form [Geisinger Medical Benefit Outpatient Drug Authorization Form](https://www.geisinger.org/-/media/OneGeisinger/Files/PDFs/Provider/NaviNet/Forms/medical-benefit-outpatient-drug-authorization-form-050819.pdf?sc_lang=en&hash=6EDE27E13FCCB5731E081FC49B85359D) contains a categorization as "Urgent" more in a boolean logic with a required rationale if the request is labelled as "Urgent". 

Potentially, urgency can be determined by specific FHIR elements such as the MedicationRequest.priority element. In the current implementations, only `routine` codes are determined non-urgent, all other codes (such as `stat`, `asap`, `urgent`).

