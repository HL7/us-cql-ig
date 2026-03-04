This provides a list of changes to the CQF US specification since its initial release

### Version 2.0.0-ballot

#### Compatible, Substantive Changes

* [FHIR-53462](https://jira.hl7.org/browse/FHIR-53462): Added pregnancy patterns
    * [Pregnancy Status](https://build.fhir.org/ig/HL7/us-cql-ig/en/patterns-observation.html#pregnancy-status)
    * [Pregnancy Intent](https://build.fhir.org/ig/HL7/us-cql-ig/en/patterns-observation.html#pregnancy-intent)
* [FHIR-53461](https://jira.hl7.org/browse/FHIR-53461): Added imaging patterns
    * [Imaging Procedures](https://build.fhir.org/ig/HL7/us-cql-ig/en/patterns-service.html#imaging-procedures)
* [FHIR-53459](https://jira.hl7.org/browse/FHIR-53459): Added observation patterns
    * [Status](https://build.fhir.org/ig/HL7/us-cql-ig/en/patterns-observation.html#status)
    * [Category](https://build.fhir.org/ig/HL7/us-cql-ig/en/patterns-observation.html#category)
    * [Interpretation](https://build.fhir.org/ig/HL7/us-cql-ig/en/patterns-observation.html#interpretation)
    * [Timings](https://build.fhir.org/ig/HL7/us-cql-ig/en/patterns-observation.html#timings)
    * [Consecutive Negative Tests](https://build.fhir.org/ig/HL7/us-cql-ig/en/patterns-observation.html#three-concurrent-negative-stick-tests)
* [FHIR-53458](https://jira.hl7.org/browse/FHIR-53458): Added patient name and age patterns
    * [Patient Name](https://build.fhir.org/ig/HL7/us-cql-ig/en/patterns-patient.html#patient-name)
    * [Patient Birthdate](https://build.fhir.org/ig/HL7/us-cql-ig/en/patterns-patient.html#patient-birthdate)
    * [Patient Age](https://build.fhir.org/ig/HL7/us-cql-ig/en/patterns-patient.html#patient-age)
* [FHIR-53460](https://jira.hl7.org/browse/FHIR-53460): Added allergy patterns
    * [Abatement and Prevalence Interval](https://build.fhir.org/ig/HL7/us-cql-ig/en/patterns-allergy.html#abatement-and-prevalence-interval)
    * [Clinical and Verification Status](https://build.fhir.org/ig/HL7/us-cql-ig/en/patterns-allergy.html#clinical-and-verification-status)
* [FHIR-55600](https://jira.hl7.org/browse/FHIR-55600): Added claim and explanation of benefit patterns, and derived model info for USCore 6.1.0, QICore 6.0.0, and CarinBB 2.1.1
    * [Mammography Claim](https://build.fhir.org/ig/HL7/us-cql-ig/en/patterns-claim#mammography-claim)
* [FHIR-53941](https://jira.hl7.org/browse/FHIR-53941): Specified primary code path for all profiles in US Core model information
* [FHIR-53940](https://jira.hl7.org/browse/FHIR-53940): Added fluent functions for CumulativeMedicationDuration
* [FHIR-53939](https://jira.hl7.org/browse/FHIR-53939): Added fluent function for accessing sex extension on USCore Patient

#### Non-substantive Changes

* [FHIR-53938](https://jira.hl7.org/browse/FHIR-53938): Declared version in all library content
* [FHIR-53485](https://jira.hl7.org/browse/FHIR-53485): Corrected frequency result in ToDaily

### Version 1.0.0

The following changes were applied as a result of comments received during the 1.0.0 ballot

#### Non-Compatible (Breaking) Changes

* [FHIR-50432](https://jira.hl7.org/browse/FHIR-50432) Improved name handling functions for Patient and Practitioner resources

#### Compatible, Substantive Changes

* [FHIR-50719](https://jira.hl7.org/browse/FHIR-50719) Add slice and extension functions to USCoreCommon
* [FHIR-50718](https://jira.hl7.org/browse/FHIR-50718) Support derived model info
* [FHIR-50505](https://jira.hl7.org/browse/FHIR-50505) Updated US Core reference to version 7 and provided guidance on usage of prior versions

#### Non-Substantive

* [FHIR-50835](https://jira.hl7.org/browse/FHIR-50835) Fixed errors in MDOBA questionnaire example
* [FHIR-50826](https://jira.hl7.org/browse/FHIR-50826) Fixed errors in GMTP test cases
* [FHIR-50823](https://jira.hl7.org/browse/FHIR-50823) Fixed errors in GMTP test cases
* [FHIR-50741](https://jira.hl7.org/browse/FHIR-50741) Restored examples and documented IP concerns
* [FHIR-50722](https://jira.hl7.org/browse/FHIR-50722) Restored examples
* [FHIR-50720](https://jira.hl7.org/browse/FHIR-50720) Condition isActive() should not be used in retrospective use cases
* [FHIR-50684](https://jira.hl7.org/browse/FHIR-50684) Clarified UseContext being Bold (Section 7.1.1)
* [FHIR-50683](https://jira.hl7.org/browse/FHIR-50683) Fixed Typo in section 4.3
* [FHIR-50646](https://jira.hl7.org/browse/FHIR-50646) Emphasize standardized libraries of CQL will reduce burden
* [FHIR-50557](https://jira.hl7.org/browse/FHIR-50557) Corrected Inconsistent references to DTR Implementation Guide
* [FHIR-50556](https://jira.hl7.org/browse/FHIR-50556) Added Link to Clinical Practice Guidelines IG is mis-labeled
* [FHIR-50555](https://jira.hl7.org/browse/FHIR-50555) Change Log is now a top-level menu item
* [FHIR-50554](https://jira.hl7.org/browse/FHIR-50554) Fixed Multiple URLs are not hyperlinks
* [FHIR-50553](https://jira.hl7.org/browse/FHIR-50553) Updated DTR sequence diagram
* [FHIR-50552](https://jira.hl7.org/browse/FHIR-50552) Clarified tooling support
* [FHIR-50551](https://jira.hl7.org/browse/FHIR-50551) Added link to CMS-0057-F
* [FHIR-50550](https://jira.hl7.org/browse/FHIR-50550) Reorganized use cases menu
* [FHIR-50548](https://jira.hl7.org/browse/FHIR-50548) Corrected standards status to 'Informative' throughout
* [FHIR-50507](https://jira.hl7.org/browse/FHIR-50507) Reorganized specification menu
* [FHIR-50506](https://jira.hl7.org/browse/FHIR-50506) Clarified Scope of the IG
* [FHIR-50503](https://jira.hl7.org/browse/FHIR-50503) Expanded examples for other Use Cases
* [FHIR-50502](https://jira.hl7.org/browse/FHIR-50502) Expanded documentation of Testing Scope
* [FHIR-50501](https://jira.hl7.org/browse/FHIR-50501) Expanded documentation on Authoring Common CQL Assets
* [FHIR-50434](https://jira.hl7.org/browse/FHIR-50434) Clarified how test resources can be obtained
* [FHIR-50431](https://jira.hl7.org/browse/FHIR-50431) Corrected standards status to Informative throughout
* [FHIR-50430](https://jira.hl7.org/browse/FHIR-50430) Clarified scope and purpose of the IG
* [FHIR-50244](https://jira.hl7.org/browse/FHIR-50244) Corrected example link
* [FHIR-50226](https://jira.hl7.org/browse/FHIR-50226) Corrected example link

### Version 1.0.0-ballot

This is the initial version of the CQF US implementation guide, based on FHIR version 4.0.1 and US Core 3.1.1.