US Core defines [US Core Allergy Intolerance](https://build.fhir.org/ig/HL7/US-Core/StructureDefinition-us-core-allergyintolerance.html).

This captures allergies / adverse reactions associated with a patient.

The codes come from a set of common substances for allergy documentation in SNOMED and RXNORM (US Core 3.1.1: {{site.data.fhir.ver.uscore3}}/ValueSet-us-core-allergy-substance.html, US Core 6.1.0: https://vsac.nlm.nih.gov/valueset/2.16.840.1.113762.1.4.1186.8/expansion).

### Modifier Elements

The AllergyIntolerance resource defines the following modifier elements:

* clinicalStatus
* verificationStatus

Note that neither of these elements are required, but both are must support, and have a required binding. As such the USCoreCommon library defines functions such as `isActive()` for assessing these statuses. Further examples are provided in the "Common Elements" section below.

### Search Parameters

USCore requires searching by:

* patient

In addition, servers may support searching by:

* clinical-status

> NOTE: For discussion on how to manage search parameters with terminology, see the [Terminology Considerations](architectural-guidance.html#terminology-considerations) discussion in the Architectural Guidance topic.

> NOTE: For discussion on how to manage optional search parameters, see the [Performant Data Access](architectural-guidance.html#performant-data-access) discussion in the Architectural Guidance topic.

### Cross-Version Considerations

There are no significant differences between the 3.1.1, 6.1.0, and 7.0.0 versions of this profile.

### Common Elements and Functions

#### Current allergies

To get all confirmed active allergies, ```UCE."Active Confirmed Allergies and Intolerances"``` can be used. 

##### Contrast dye allergy:

Ordering HeadMRI vs HeadCT because patient has allergy to CT dye

```
ICD-10-CM Code for Radiographic dye allergy status Z91.041
```

##### Egg allergy:

```
ICD-10-CM (International Classification of Diseases, 10th Revision, Clinical Modification)
Z91.012 – Allergy to eggs
T78.1XXA – Other adverse food reactions, not elsewhere classified, initial encounter
T78.1XXD – Other adverse food reactions, not elsewhere classified, subsequent encounter
T78.1XXS – Other adverse food reactions, not elsewhere classified, sequela
Z91.018 – Allergy to other foods
SNOMED CT (Systematized Nomenclature of Medicine – Clinical Terms)
91934008 – Egg allergy
281784008 – Egg intolerance
293982008 – Anaphylaxis due to egg
LOINC (Logical Observation Identifiers Names and Codes)
6096-8 – Egg IgE [Mass/volume] in Serum
6241-0 – Egg white IgE [Mass/volume] in Serum
7286-1 – Egg yolk IgE [Mass/volume] in Serum
```

##### Nut allergy: 

```
ICD-10-CM Codes for Nut Allergies
ICD-10-CM classifies food allergies, including nut allergies, under T78.0–T78.1 and Z91.01 series:
T78.01XA – Anaphylactic reaction due to peanuts, initial encounter
T78.01XD – Anaphylactic reaction due to peanuts, subsequent encounter
T78.01XS – Anaphylactic reaction due to peanuts, sequela
T78.02XA – Anaphylactic reaction due to other nuts and seeds, initial encounter
T78.02XD – Anaphylactic reaction due to other nuts and seeds, subsequent encounter
T78.02XS – Anaphylactic reaction due to other nuts and seeds, sequela
Z91.010 – Allergy to peanuts
Z91.018 – Allergy to other nuts
Z91.019 – Allergy to unspecified nuts
```

```cql
define "AllergicToDrugX":
  UCE."Active Confirmed Allergies and Intolerances" A
    where A.code ~ "DrugX"
```

#### No known allergies

To check if a patient has confirmed they have no known allergies, use ```UCE."No Known Allergies (Confirmed)"```. This will check for SNOMED 716186003 (No known allergy (situation)) as advised in US Core.

> NOTE: Content for this page was adapted from the [QICore Authoring Patterns - Allergies](https://github.com/cqframework/CQL-Formatting-and-Usage-Wiki/wiki/Authoring-Patterns-QICore-v6.0.0#allergies) topic.