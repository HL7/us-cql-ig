The following approaches can be used to test CQL-based Questionnaires:

### Unit Testing

As with all CQL-based artifact development, CQL libraries used in CQL-based Questionnaires should be tested with focused test cases that ensure expected behavior. These are effectively "unit tests" for the CQL library, and can be authored and validated with the VSCode CQL Plugin:

https://github.com/cqframework/vscode-cql/wiki/User-Guide#adding-test-data

Each of the libraries in this implementation guide have associated test cases defined in the input/tests/library directory. Each library under test has a folder named the same as the library, and each of these folders has sub-folders corresponding to test cases for the library.

Each of the test cases is a single patient with all the resources for that test case, as well as an `expected-results` Parameters resource that defines the expected results for each expression in the library. For example, the `ExamplePatientAndCoverageInitialExpressions` library has the following expression declaration:

```cql
define "Patient Name":
  UCE."Name - First Middle(s) Last"
```

And the `Parameters-expected-results` resource has the following parameter indicating the expected result for the `minimal-patient-example` test case:

```json
{
    "resourceType": "Parameters",
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

> Note that these tests are not included directly as resources in the implementation guide, since they are part of testing and not directly required for implementation. However, the test resources are included in the Postman collections described below.

### Integration Testing

Based on the DTR sequence diagram, the following 3 integration test scenarios are identified:

![Integration Test Scenarios](images/Integration-Test-Scenarios.png)

1. Questionnaire Package Response
2. EHR FHIR Queries
3. Questionnaire Populate

#### Questionnaire Package Response

The [DTR Inferno Test Kit](https://inferno.healthit.gov/test-kits/davinci-dtr/) supports verifying the result of the $questionnaire-package operation:

#### EHR FHIR Queries

The [DTR SMART on FHIR App](https://github.com/HL7-DaVinci/dtr) has facilities for end-to-end testing of the DaVinci DTR questionnaire use case, including questionnaire population and EHR FHIR queries.

#### Questionnaire Populate

The Questionnaire populate aspect can be tested with a REST client (such as Postman) and a FHIR server that implements the Questionnaire/$populate operation.

The source repository for this implementation guide contains Postman collections that test this operation for each of the included example questionnaires:

[Postman Collections](https://github.com/cqframework/cqf-us/tree/master/postman)

