> For [Content Implementation Guides](https://hl7.org/fhir/uv/crmi/introduction.html#content-igs) (i.e. implementation guides that primarily consist of knowledge artifacts) such as this one, best practice is to provide test content as part of the source repository, and as packaged bundles for ease of distribution. This is because 1) the number of test cases may be (and usually is for production-level content) quite large, resulting in large package files if test content is included, and 2) Test content is part of validating expected behavior, rather than directly needed for implementation, and so should be packaged separately to allow implementers to better manage dependency size and purpose. A future version of this implementation guide will consider using the [Related IGs](https://build.fhir.org/ig/FHIR/ig-guidance/branches/master/related-igs.html) feature of the FHIR packaging ecosystem to support distribution of test cases. Test content for this IG is currently accessible via the [Downloads](downloads.html) page.

The following approaches can be used to test CQL-based Questionnaires:

### Unit Testing

As with all CQL-based artifact development, CQL libraries used in CQL-based Questionnaires should be tested with focused test cases that ensure expected behavior. These are effectively "unit tests" for the CQL library, and can be authored and validated with the VSCode CQL Plugin:

[User's Guide - Adding Test Data](https://github.com/cqframework/vscode-cql/wiki/User-Guide#adding-test-data)

Each of the libraries in this implementation guide have associated test cases defined in the input/tests/library directory. Each library under test has a folder named the same as the library, and each of these folders has sub-folders corresponding to test cases for the library.

Each of the test cases is a single patient with all the resources for that test case, as well as an `expected-results` Parameters resource that defines the expected results for each expression in the library. For example, the `ExamplePatientAndCoverageInitialExpressions` library has the following expression declaration:

```cql
define "Patient Name":
  UCE."Name - First Middle(s) Last"
```

And the `expected-results` Parameters resource has the following parameter indicating the expected result for the `minimal-patient-example` test case:

```json
{
    "resourceType": "Parameters",
    "id": "expected-results",
    "parameter": [
        ...
        {
            "name": "Patient Name",
            "valueString": "Peter James Chalmers"
        },
        ...
    ]
}
```

> Note that these tests are not included directly as resources in the implementation guide, since they are part of testing and not directly required for implementation. However, the test resources are included in _test bundles_ available on the [Downloads](downloads.html) page. 

### Integration Testing

Based on the DTR sequence diagram, the following 3 integration test scenarios are identified:

![Integration Test Scenarios](Integration-Test-Scenarios.png)

1. Questionnaire Package Response
2. EHR FHIR Queries
3. Questionnaire Populate
4. Next Question (Adaptive Questionnaire Testing)

#### Questionnaire Package Response

The [DTR Inferno Test Kit](https://inferno.healthit.gov/test-kits/davinci-dtr/) supports verifying the result of the $questionnaire-package operation:

#### EHR FHIR Queries

The [DTR SMART on FHIR App](https://github.com/HL7-DaVinci/dtr) has facilities for end-to-end testing of the DaVinci DTR questionnaire use case, including questionnaire population and EHR FHIR queries.

#### Questionnaire Populate

The Questionnaire populate aspect can be tested with a REST client (such as Postman) and a FHIR server that implements the Questionnaire/$populate operation.

The source repository for this implementation guide contains Postman collections that test this operation for each of the included example questionnaires:

(NOTE: These collections were tested against a [HAPI JPA Server Starter](https://github.com/hapifhir/hapi-fhir-jpaserver-starter) instance using version 3.19.0 of the [Clinical Reasoning](https://github.com/cqframework/clinical-reasoning) module.  They also include their own version of the FHIRHelpers Library (4.1.0) due to some technical limitations in the CQF Tooling used to construct the questionnaire bundles.  Once those limitations have been removed these example collections will be regenerated.)

[Postman Collections](https://github.com/HL7/us-cql-ig/tree/master/postman)

#### Next Question (Adaptive Questionnaire Testing)

For systems that support adaptive questionnaires, testing this capability can be accomplished with a REST client (such as Postman) and a FHIR server that implements the Questionnaire/$next-question operation.