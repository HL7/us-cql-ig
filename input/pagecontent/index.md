### Introduction

This implementation guide contains architectural guidance and re-usable libraries that facilitate the use of [Clinical Quality Language (CQL)](http://cql.hl7.org) with FHIR in the US Realm, with an initial use case of Prior Authorization Support Questionnaires as described in the [Da Vinci Documentation Templates and Rules (DTR)](https://hl7.org/fhir/us/davinci-dtr/) implementation guide. Much of the guidance and content presented here is built on work done in the quality measurement domain, including patterns established by measure developers as part of testing and developing quality measures for use with FHIR. These patterns have been generalized to support US Core as well as harmonized to be usable across use cases.

The content in this implementation guide is provided for re-use and proposed to help streamline implementation and development of CQL-based knowledge artifacts in the US Realm. The guidance here is published as informative and the IG imposes no conformance expectations on systems that make use of it. This does not mean that the content cannot be used in production; the content in this implementation guide is stable as of publication, and will use semantic versioning to communicate change impact across new versions, as described in the [CRMI IG versioning](https://hl7.org/fhir/uv/crmi/artifact-lifecycle.html#artifact-versioning) topic. In particular, this means that production systems can expect no breaking changes without a corresponding major version increment, and that any minor version increment indicates compatible changes.

### Scope of Use

This guide is a [Content Implementation Guide](https://hl7.org/fhir/uv/crmi/introduction.html#content-igs) that supports the use of CQL with FHIR in the US Realm by:

* Providing architectural guidance for the evaluation of CQL expressions in the context of artifacts such as questionnaires, quality measures, and decision support rules
* Providing re-usable libraries of CQL expressions to retrieve data for common use cases in the US Realm
* Providing guidance for managing CQL expressions that may involve retrieval of data from multiple versions of the US Core implementation guide
* Gathering requirements for tooling to simplify the authoring of questionnaires that use CQL

The term [_artifact_](https://hl7.org/fhir/uv/crmi/index.html#artifacts) here refers to a FHIR resource that is definitional in nature or use, such as a Questionnaire or a Library (as opposed to a FHIR resource that is representing instance-specific data, such as an Observation). This implementation guide provides common artifacts that support the use of CQL with FHIR in the US Realm. The artifacts support a broad range of use cases across the healthcare domain, including prior authorization, quality measurement and reporting, clinical decision support, computable guidelines, and public health case reporting. Any use of CQL within the US Realm could benefit from the artifacts provided here, as well as provide feedback to these artifacts, both in the form of proposed changes to existing artifacts, as well as proposing new artifacts that could be re-used across use cases.

Providing standardized CQL libraries will reduce burden by establishing best practices and re-usable expressions for common questions across questionnaires, both currently and into the future. As well, these shared CQL artifacts will support a user with deep clinical knowledge but limited technical knowledge to be able to build and maintain CQL-based questionnaires. Open questionnaire authoring environments (e.g., LHC forms builder) exist and will enable the growth of CQL artifacts (see the [Tooling Support](tooling-support.html) page for further discussion).

> NOTE: Although the current guidance has been developed based on the prior authorization questionnaires as the first use case, the intent is to capture common patterns, guidance, and artifacts that are usable across use cases.

The artifacts provided by this implementation guide fall into three general categories:

1. Common CQL: Libraries of re-usable CQL expressions, such as US Core Common and US Core Elements, that are intended to be used in production systems as shared artifacts
2. Example Artifacts: Example content, such as the example Questionnaires, that are intended to illustrate how the shared artifacts may be used
3. Tests: Test content that demonstrates expected behavior of the CQL and Example artifacts

#### Out of Scope

This implementation guide does not:

* Define or mandate the use of any particular subsets of CQL
* Define functions for the retrieval of simple elements from already retrieved FHIR resources (e.g., Patient.birthDate)
* Define expectations for certification that require the use of any of the helper libraries provided in this implementation guide

### How to Read This Guide

#### Target Audiences

This implementation guide is targeted at two main audiences:

* **Authors**: Persons involved in the development of CQL-based FHIR Knowledge Artifacts that are authoring CQL, either directly or with tooling assistance
* **Integrators**: Persons involved in the development of systems that support authoring, publishing, distributing, and implementing CQL-based FHIR Knowledge Artifacts

This guide is divided into several pages which are listed at the top of each page in the menu bar:

* **[Home](index.html)**
* **Background**
  * **[Background](background.html)**
  * **[Use Cases](use-cases.html)**
* **Guidance**
  * **[Architectural Guidance](architectural-guidance.html)**
  * **[Query Management](query-management.html)**
  * **[Testing](testing.html)**
    * **[Unit Testing Proposal](unit-testing.html)**
* **Authoring**
  * **[Authoring](authoring.html)**
  * **[Patterns](patterns.html)**
  * **[Examples](examples.html)**
  * **[Usage](usage.html)**
  * **[Tooling Support](tooling-support.html)**
* **CQL Artifacts**
  * **[US Core Common](Library-USCoreCommon.html)**
  * **[US Core Elements](Library-USCoreElements.html)**
  * **[US Core Model Information](uscore-modelinfo.html)**
  * **[Cumulative Medication Duration](Library-CumulativeMedicationDuration.html)**
  * **[CARIN Blue Button Common](Library-C4BBCommon.html)**
  * **[CARIN Blue Button Model Information](c4bb-modelinfo.html)**
  * **[QI Core Model Information](qicore-modelinfo.html)**
* **[FHIR Artifacts](artifacts.html)**
* **Support**
  * **[Downloads](downloads.html)**
  * **[License](license.html)**
* **[Changes](changes.html)**

> NOTE: This implementation guide is informative, and therefore does not include a "Specification" topic like many other implementation guides do.

### Roadmap

Implementers of this content are encouraged to provide feedback through the usual mechanisms for feedback on HL7 FHIR Implementation Guides, by submitting an [issue](https://jira.hl7.org/secure/CreateIssueDetails!init.jspa?pid=10405&amp;issuetype=10600&amp;customfield_11302=FHIR-us-cql). To see the current status of the feedback for this specification, see the [US CQL Specification Dashboard](https://jira.hl7.org/secure/Dashboard.jspa?selectPageId=17807). For more information on how to submit feedback, refer to the [Specification Feedback](https://confluence.hl7.org/spaces/HL7/pages/19136736/Specification+Feedback) page in the HL7 Confluence.

Feedback submitted to this implementation guide is discussed and resolved in the [Clinical Decision Support](https://confluence.hl7.org/spaces/CDS/pages/40742690/Meeting+Index) weekly meeting.

This implementation guide will be published for a two-year implementation period, during which time we will seek implementer feedback, applying changes as needed. The next ballot of this material will take place when the community indicates sufficient feedback and/or need for an updated release.

### Acknowledgements

This implementation guide was made possible by the thoughtful contributions of the following people and organizations:

* [The Da Vinci Project Member Organizations](https://www.hl7.org/about/davinci/index.cfm?ref=common)
* Raj Godavarthi, MCG Health
* Mike Gould, ZeOmega
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

{% include dependency-table-short-en.xhtml %}

### Dependency Versions

The following table lists the versions for all conformance artifacts (including code systems, value sets, profiles, libraries, etc.) referenced by this implementation guide.

{% include expansion-params-en.xhtml %}

### Cross Version Analysis

{% include cross-version-analysis-en.xhtml %}

### Global Profiles

{% include globals-table-en.xhtml %}

### IP Statements

<ul>
<li>ISO maintains the copyright on the country codes, and controls its use carefully. For further details see the ISO 3166 web page: <a href="https://www.iso.org/iso-3166-country-codes.html">https://www.iso.org/iso-3166-country-codes.html</a><div data-fhir="generated" id="ipp_1" onclick="if (document.getElementById('ipp2_1').innerHTML != '') {document.getElementById('ipp_1').innerHTML = document.getElementById('ipp2_1').innerHTML; document.getElementById('ipp2_1').innerHTML = ''}"> <span style="cursor: pointer; border: 1px grey solid; background-color: #fcdcb3; padding-left: 3px; padding-right: 3px; color: black">Show Usage</span></div><div id="ipp2_1" style="display: none">
<ul>
<li><a href="http://terminology.hl7.org/6.5.0/CodeSystem-ISO3166Part1.html">ISO 3166-1 Codes for the representation of names of countries and their subdivisions — Part 1: Country code</a>: <a href="Library-C4BB-ModelInfo.html">C4BB</a>, <a href="Library-C4BBCommon.html">C4BBCommon</a><span id="ips_1" onclick="document.getElementById('ips_1').innerHTML = document.getElementById('ips2_1').innerHTML">... <span style="cursor: pointer; border: 1px grey solid; background-color: #fcdcb3; padding-left: 3px; padding-right: 3px; color: black">Show 21 more</span></span><span id="ips2_1" style="display: none">, <a href="index.html">CQLUSCommon</a>, <a href="Library-CumulativeMedicationDuration.html">CumulativeMedicationDuration</a>, <a href="Library-CumulativeMedicationDurationTests.html">CumulativeMedicationDurationTests</a>, <a href="Library-ExamplePatientAndCoverageInitialExpressions.html">ExamplePatientAndCoverageInitialExpressions</a>, <a href="Questionnaire-ExamplePatientAndCoverageQuestionnaire.html">ExamplePatientAndCoverageQuestionnaire</a>, <a href="Library-GMTPInitialExpressions.html">GMTPInitialExpressions</a>, <a href="Questionnaire-GMTPQuestionnaire.html">GMTPQuestionnaire</a>, <a href="Library-MBODAInitialExpressions.html">MBODAInitialExpressions</a>, <a href="Questionnaire-MBODAQuestionnaire.html">MBODAQuestionnaire</a>, <a href="Library-MNACInitialExpressions.html">MNACInitialExpressions</a>, <a href="Questionnaire-MNACQuestionnaire.html">MNACQuestionnaire</a>, <a href="Library-PriorAuthManifestExample.html">PriorAuthManifestExample</a>, <a href="Library-QICore-ModelInfo.html">QICore</a>, <a href="Library-UPPARFInitialExpressions.html">UPPARFInitialExpressions</a>, <a href="Questionnaire-UPPARFQuestionnaire.html">UPPARFQuestionnaire</a>, <a href="Library-USCore-ModelInfo.html">USCore</a>, <a href="Library-USCoreCommon.html">USCoreCommon</a>, <a href="Library-USCoreCommonTests.html">USCoreCommonTests</a>, <a href="Library-USCoreElements.html">USCoreElements</a>, <a href="Library-USCoreElementsTests.html">USCoreElementsTests</a> and <a href="Library-USCoreTests.html">USCoreTests</a></span></li>
</ul>
</div></li>
<li>The UCUM codes, UCUM table (regardless of format), and UCUM Specification are copyright 1999-2009, Regenstrief Institute, Inc. and the Unified Codes for Units of Measures (UCUM) Organization. All rights reserved. <a href="https://ucum.org/trac/wiki/TermsOfUse">https://ucum.org/trac/wiki/TermsOfUse</a><div data-fhir="generated" id="ipp_2" onclick="if (document.getElementById('ipp2_2').innerHTML != '') {document.getElementById('ipp_2').innerHTML = document.getElementById('ipp2_2').innerHTML; document.getElementById('ipp2_2').innerHTML = ''}"> <span style="cursor: pointer; border: 1px grey solid; background-color: #fcdcb3; padding-left: 3px; padding-right: 3px; color: black">Show Usage</span></div><div id="ipp2_2" style="display: none">
<ul>
<li><a href="http://terminology.hl7.org/6.5.0/CodeSystem-v3-ucum.html">Unified Code for Units of Measure (UCUM)</a>: <a href="Questionnaire-MBODAQuestionnaire.html">MBODAQuestionnaire</a> and <a href="Questionnaire-MNACQuestionnaire.html">MNACQuestionnaire</a></li>
</ul>
</div></li>
<li>These codes are excerpted from ASTM Standard, E1762-95(2013) - Standard Guide for Electronic Authentication of Health Care Information, Copyright by ASTM International, 100 Barr Harbor Drive, West Conshohocken, PA 19428. Copies of this standard are available through the ASTM Web Site at www.astm.org.<div data-fhir="generated" id="ipp_3" onclick="if (document.getElementById('ipp2_3').innerHTML != '') {document.getElementById('ipp_3').innerHTML = document.getElementById('ipp2_3').innerHTML; document.getElementById('ipp2_3').innerHTML = ''}"> <span style="cursor: pointer; border: 1px grey solid; background-color: #fcdcb3; padding-left: 3px; padding-right: 3px; color: black">Show Usage</span></div><div id="ipp2_3" style="display: none">
<ul>
<li><a href="http://hl7.org/fhir/R4/codesystem-signature-type.html">Signature Type Codes</a>: <a href="Questionnaire-MBODAQuestionnaire.html">MBODAQuestionnaire</a></li>
</ul>
</div></li>
<li>This material contains content from <a href="http://loinc.org">LOINC</a>. LOINC is copyright &copy; 1995-2020, Regenstrief Institute, Inc. and the Logical Observation Identifiers Names and Codes (LOINC) Committee and is available at no cost under the <a href="http://loinc.org/license">license</a>. LOINC&reg; is a registered United States trademark of Regenstrief Institute, Inc.<div data-fhir="generated" id="ipp_4" onclick="if (document.getElementById('ipp2_4').innerHTML != '') {document.getElementById('ipp_4').innerHTML = document.getElementById('ipp2_4').innerHTML; document.getElementById('ipp2_4').innerHTML = ''}"> <span style="cursor: pointer; border: 1px grey solid; background-color: #fcdcb3; padding-left: 3px; padding-right: 3px; color: black">Show Usage</span></div><div id="ipp2_4" style="display: none">
<ul>
<li><a href="http://terminology.hl7.org/6.5.0/CodeSystem-v3-loinc.html">LOINC</a>: <a href="Library-USCoreElements.html">USCoreElements</a></li>
</ul>
</div></li>
<li>This material derives from the HL7 Terminology (THO). THO is copyright &copy;1989+ Health Level Seven International and is made available under the CC0 designation. For more licensing information see: <a href="https://terminology.hl7.org/license.html">https://terminology.hl7.org/license.html</a><div data-fhir="generated" id="ipp_5" onclick="if (document.getElementById('ipp2_5').innerHTML != '') {document.getElementById('ipp_5').innerHTML = document.getElementById('ipp2_5').innerHTML; document.getElementById('ipp2_5').innerHTML = ''}"> <span style="cursor: pointer; border: 1px grey solid; background-color: #fcdcb3; padding-left: 3px; padding-right: 3px; color: black">Show Usage</span></div><div id="ipp2_5" style="display: none">
<ul>
<li><a href="http://terminology.hl7.org/7.3.0/CodeSystem-library-type.html">LibraryType</a>: <a href="Library-C4BB-ModelInfo.html">C4BB</a>, <a href="Library-C4BBCommon.html">C4BBCommon</a><span id="ips_5" onclick="document.getElementById('ips_5').innerHTML = document.getElementById('ips2_5').innerHTML">... <span style="cursor: pointer; border: 1px grey solid; background-color: #fcdcb3; padding-left: 3px; padding-right: 3px; color: black">Show 20 more</span></span><span id="ips2_5" style="display: none">, <a href="Library-CumulativeMedicationDuration.html">CumulativeMedicationDuration</a>, <a href="Library-CumulativeMedicationDurationTests.html">CumulativeMedicationDurationTests</a>, <a href="Library-ExamplePatientAndCoverageInitialExpressions.html">ExamplePatientAndCoverageInitialExpressions</a>, <a href="Questionnaire-ExamplePatientAndCoverageQuestionnaire.html">ExamplePatientAndCoverageQuestionnaire</a>, <a href="Library-GMTPInitialExpressions.html">GMTPInitialExpressions</a>, <a href="Questionnaire-GMTPQuestionnaire.html">GMTPQuestionnaire</a>, <a href="Library-MBODAInitialExpressions.html">MBODAInitialExpressions</a>, <a href="Questionnaire-MBODAQuestionnaire.html">MBODAQuestionnaire</a>, <a href="Library-MNACInitialExpressions.html">MNACInitialExpressions</a>, <a href="Questionnaire-MNACQuestionnaire.html">MNACQuestionnaire</a>, <a href="Library-PriorAuthManifestExample.html">PriorAuthManifestExample</a>, <a href="Library-QICore-ModelInfo.html">QICore</a>, <a href="Library-UPPARFInitialExpressions.html">UPPARFInitialExpressions</a>, <a href="Questionnaire-UPPARFQuestionnaire.html">UPPARFQuestionnaire</a>, <a href="Library-USCore-ModelInfo.html">USCore</a>, <a href="Library-USCoreCommon.html">USCoreCommon</a>, <a href="Library-USCoreCommonTests.html">USCoreCommonTests</a>, <a href="Library-USCoreElements.html">USCoreElements</a>, <a href="Library-USCoreElementsTests.html">USCoreElementsTests</a> and <a href="Library-USCoreTests.html">USCoreTests</a></span></li>
<li><a href="http://terminology.hl7.org/7.3.0/CodeSystem-usage-context-type.html">UsageContextType</a>: <a href="Library-PriorAuthManifestExample.html">PriorAuthManifestExample</a></li>
<li><a href="http://terminology.hl7.org/7.3.0/CodeSystem-v3-AdministrativeGender.html">AdministrativeGender</a>: <a href="Questionnaire-ExamplePatientAndCoverageQuestionnaire.html">ExamplePatientAndCoverageQuestionnaire</a></li>
<li><a href="http://terminology.hl7.org/7.3.0/CodeSystem-v3-NullFlavor.html">NullFlavor</a>: <a href="Questionnaire-ExamplePatientAndCoverageQuestionnaire.html">ExamplePatientAndCoverageQuestionnaire</a></li>
</ul>
</div></li>
<!--NOTE: This is a copy of the rendered include for ip statements because the generated one does not include CPT. The reason it does not include CPT is there are no actual codes, only references to the CPT URL. -->
<li>This material contains content from CPT® Copyright 2025 American Medical Association. All rights reserved. AMA and CPT are registered trademarks of the American Medical Association.</li>
</ul>
<!--$$1$$-->

Many of the examples in this implementation guide are informed by prior authorization forms freely available on the internet and used with permission.

