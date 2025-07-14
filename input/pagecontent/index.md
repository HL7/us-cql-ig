### Introduction

This implementation guide contains architectural guidance and re-usable libraries that facilitate the use of [Clinical Quality Language (CQL)](http://cql.hl7.org) with FHIR in the US Realm, with an initial use case of Prior Authorization Support Questionnaires as described in the [DaVinci Documentation Templates and Rules (DTR)](https://hl7.org/fhir/us/davinci-dtr/) implementation guide. Much of the guidance and content presented here is built on work done in the quality measurement domain, including patterns established by measure developers as part of testing and developing quality measures for use with FHIR. These patterns have been generalized to support US Core as well as harmonized to be usable across use cases.

The content in this implementation guide is provided for reuse and proposed to help streamline implementation and development of CQL-based knowledge artifacts in the US Realm. The guidance here is published informative and the IG imposes no conformance expectations on systems that make use of it. However, the content in this implementation guide is still stable as of publication versions, and will use semantic versioning to communicate change impact across publication versions, as described in the [CRMI IG versioning](https://hl7.org/fhir/uv/crmi/artifact-lifecycle.html#artifact-versioning) topic.

### Scope of Use

This guide supports the use of CQL with FHIR in the US Realm by:

* Providing architectural guidance for the evaluation of CQL expressions in the context of artifacts such as questionnaires, quality measures, and decision support rules.
* Providing re-usable libraries of CQL expressions to retrieve data for common use cases in the US Realm
* Providing guidance for managing CQL expressions that may involve retrieval of data from multiple versions of the US Core implementation guide
* Gathering requirements for tooling to simplify the authoring of questionnaires that use CQL

The term artifact here refers to a FHIR resource that is definitional in nature or use such as a Questionnaire, or a Library (as opposed to a FHIR resource that is representing instance-specific data, such as an Observation). This implementation guide provides common artifacts that support the use of CQL with FHIR in the US Realm. The artifacts support a broad range of use cases across the healthcare domain, including prior-authorization, quality measurement and reporting, clinical decision support, computable guidelines, and public health case reporting. Any use of CQL within the US Realm could benefit from the artifacts provided here, as well as provide feedback to these artifacts, both in the form of proposed changes to existing artifacts, as well as proposing new artifacts that could be re-used across use cases.

Providing standardized CQL libraries will reduce burden by establishing best practices and reusable expressions for common questions across questionnaires, both currently and into the future. As well, these shared CQL artifacts will support a user with deep clinical knowledge but limited technical knowledge to be able to build and maintain CQL-based questionnaires. Open questionnaire authoring environments (i.e., LHC forms builder) exist and will enable the growth of CQL artifacts (see the [Tooling Support](tooling-support.html) page for further discussion).

> NOTE: Although the current guidance has been developed based on the prior-authorization questionnaires as the first use case, the intent is to capture common patterns, guidance, and artifacts that are usable across use-cases.

The artifacts provided by this implementation guide fall into three general categories:

1. Common CQL: Libraries of re-usable CQL expressions, such as US Core Common and US Core Elements, that are intended to be used in production systems as shared artifacts
2. Example Artifacts: Example content, such as the example Questionnaires, that are intended to illustrate how the shared artifacts may be used
3. Tests: Test content that demonstrates expected behavior of the CQL and Example artifacts

#### Out of Scope

This implementation guide does not:

* Define or mandate the use of any particular subsets of CQL
* Define functions for the retrieval of simple elements from already retrieved FHIR resources (e.g. Patient.birthDate)
* Define expectations for certification that require the use of any of the helper libraries provided in this implementation guide

### How to Read This Guide

#### Target Audiences

This implementation guide is targeted at two main audiences:

* **Authors**: Persons involved in the development of CQL-based FHIR Knowledge Artifacts that are authoring CQL, either directly or with tooling assistance
* **Integrators**: Persons involved in the development of systems that support authoring, publishing, distributing, and implementing CQL-based FHIR Knowledge Artifacts

This Guide is divided into several pages which are listed at the top of each page in the menu bar:

* **[Home](index.html)**
* **Background**
  * **[Background](background.html)**
  * **[Use Cases](use-cases.html)**
* **Guidance**
  * **[Architectural Guidance](architectural-guidance.html)**
  * **[Query Management](query-management.html)**
  * **[Testing](testing.html)**
* **Authoring**
  * **[Authoring](authoring.html)**
  * **[Patterns](patterns.html)**
  * **[Examples](examples.html)**
  * **[Usage](usage.html)**
  * **[Tooling Support](tooling-support.html)**
* **CQL Artifacts**
  * **[US Core Common](Library-USCoreCommon.html)**
  * **[US Core Elements](Library-USCoreElements.html)**
  * **[US Core Model Information](Library-USCore-ModelInfo.html)**
  * **[Cumulative Medication Duration](Library-CumulativeMedicationDuration.html)**
* **[FHIR Artifacts](artifacts.html)**
* **Support**
  * **[Downloads](downloads.html)**
  * **[License](license.html)**
* **[Changes](changes.html)**

> NOTE: This implementation guide is informative, and therefore does not include a "Specification" topic like many other implementation guides do.

### Roadmap

Implementers of this content are encouraged to provide feedback through the usual mechanisms for feedback on HL7 FHIR Implementation Guides, by submitting an [issue](https://jira.hl7.org/secure/CreateIssueDetails!init.jspa?pid=10405&amp;issuetype=10600&amp;customfield_11302=FHIR-us-cql). To see the current status of the feedback for this specification, see the [US CQL Specification Dashboard](https://jira.hl7.org/secure/Dashboard.jspa?selectPageId=17807). For more information on how to submit feedback, refer to the [Specification Feedback](https://confluence.hl7.org/spaces/HL7/pages/19136736/Specification+Feedback) page in the HL7 confluence.

Feedback submitted to this implementation guide is discussed and resolved in the [Clinical Decision Support](https://confluence.hl7.org/spaces/CDS/pages/40742690/Meeting+Index) weekly meeting.

This implementation guide will be published for a two-year implementation period, during which time we will seek implementer feedback, applying as needed. The next ballot of this material will take place when the community indicates sufficient feedback and/or need for an updated release.

### Acknowledgements

This Implementation Guide was made possible by the thoughtful contributions of the following people and organizations:

* [The DaVinci Project Member Organizations](https://www.hl7.org/about/davinci/index.cfm?ref=common)
* Raj Godavarthi, MCG Health
* Mike Gould, Zeomega
* Yan Heras, Optimum eHealth
* Kyle Johnsen, Epic
* Crystal Kallem, Point of Care Partners
* Lloyd McKenzie, Dogwood Consulting
* Viet Nguyen, HL7
* Rob Reynolds, Smile Digital Health
* Brenin Rhodes, Smile Digital Health
* Bryn Rhodes, Smile Digital Health
* Raleigh Thompson, Smile Digital Health

### Dependencies

{% include dependency-table-short.xhtml %}

### Cross Version Analysis

{% include cross-version-analysis.xhtml %}

### Global Profiles

{% include globals-table.xhtml %}

### IP Statements

{% include ip-statements.xhtml %}

Many of the examples in this implementation guide are informed by prior-authorization forms freely available on the internet and used with permission.

<!--
TODO:

* Testing
  * Test Cases Parameters Resources ({{site.data.fhir.ver.cql}}/conformance.html#fhir-type-mapping)
  * Test Case Inputs expressed as Parameters in each test case (Parameters-input.json)
  * Unit Tests for Common Calculations (USCoreElementsTests.cql - BSA testing)
  * Remove Practitioner/Organization/Provider-related questions from example questionnaires (move to ExamplePatientAndCoverage)
  * Document mapping from Questionnaire/$populate to Library/$evaluate parameters
  * Document test case structure (w/ inputParameters and expectedResults)
* Architectural Guidance
  * Versioning
    * Multi-version approach
  * Data Requirements Transformation
  * Search Parameters Usage
* Patterns
  * Patient and Family History
  * Laboratory Testing
  * MedicationRequest
  * AllergyIntolerance
  * ServiceRequest
* Authoring Documentation
  * Workflow diagram illustrating tooling and pattern touchpoints
-->