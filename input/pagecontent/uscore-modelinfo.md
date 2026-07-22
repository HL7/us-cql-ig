This implementation guide includes the model information for the US Core specification, [USCore-ModelInfo](Library-USCore-ModelInfo.html), version 6.1.0. The following table lists the available classes, the base resource type which they represent, and the [primary code path](https://cql.hl7.org/02-authorsguide.html#filtering-with-terminology) established for each class:

|Profile|Primary Code Path|
|---|---|
|[AllergyIntolerance Profile]({{site.data.fhir.ver.uscore7}}/StructureDefinition-us-core-allergyintolerance.html)|code|
|[BMI Profile]({{site.data.fhir.ver.uscore7}}/StructureDefinition-us-core-bmi.html)|code|
|[Blood Pressure Profile]({{site.data.fhir.ver.uscore7}}/StructureDefinition-us-core-blood-pressure.html)|code|
|[Body Height Profile]({{site.data.fhir.ver.uscore7}}/StructureDefinition-us-core-body-height.html)|code|
|[Body Temperature Profile]({{site.data.fhir.ver.uscore7}}/StructureDefinition-us-core-body-temperature.html)|code|
|[Body Weight Profile]({{site.data.fhir.ver.uscore7}}/StructureDefinition-us-core-body-weight.html)|code|
|[CarePlan Profile]({{site.data.fhir.ver.uscore7}}/StructureDefinition-us-core-careplan.html)|category|
|[CareTeam Profile]({{site.data.fhir.ver.uscore7}}/StructureDefinition-us-core-careteam.html)|category|
|[Condition Encounter Diagnosis Profile]({{site.data.fhir.ver.uscore7}}/StructureDefinition-us-core-condition-encounter-diagnosis.html)|code|
|[Condition Problems and Health Concerns Profile]({{site.data.fhir.ver.uscore7}}/StructureDefinition-us-core-condition-problems-health-concerns.html)|code|
|[Coverage Profile]({{site.data.fhir.ver.uscore7}}/StructureDefinition-us-core-coverage.html)|type|
|[DiagnosticReport Profile for Laboratory Results Reporting]({{site.data.fhir.ver.uscore7}}/StructureDefinition-us-core-diagnosticreport-lab.html)|code|
|[DiagnosticReport Profile for Report and Note Exchange]({{site.data.fhir.ver.uscore7}}/StructureDefinition-us-core-diagnosticreport-note.html)|code|
|[DocumentReference Profile]({{site.data.fhir.ver.uscore7}}/StructureDefinition-us-core-documentreference.html)|code|
|[Encounter Profile]({{site.data.fhir.ver.uscore7}}/StructureDefinition-us-core-encounter.html)|type|
|[Goal Profile]({{site.data.fhir.ver.uscore7}}/StructureDefinition-us-core-goal.html)|category|
|[Head Circumference Profile]({{site.data.fhir.ver.uscore7}}/StructureDefinition-us-core-head-circumference.html)|code|
|[Heart Rate Profile]({{site.data.fhir.ver.uscore7}}/StructureDefinition-us-core-heart-rate.html)|code|
|[Immunization Profile]({{site.data.fhir.ver.uscore7}}/StructureDefinition-us-core-immunization.html)|vaccineCode|
|[Implantable Device Profile]({{site.data.fhir.ver.uscore7}}/StructureDefinition-us-core-implantable-device.html)|type|
|[Laboratory Result Observation Profile]({{site.data.fhir.ver.uscore7}}/StructureDefinition-us-core-observation-lab.html)|code|
|[Location Profile]({{site.data.fhir.ver.uscore7}}/StructureDefinition-us-core-location.html)|type|
|[Medication Profile]({{site.data.fhir.ver.uscore7}}/StructureDefinition-us-core-medication.html)|code|
|[MedicationDispense Profile]({{site.data.fhir.ver.uscore7}}/StructureDefinition-us-core-medicationdispense.html)|medication|
|[MedicationRequest Profile]({{site.data.fhir.ver.uscore7}}/StructureDefinition-us-core-medicationrequest.html)|medication|
|[Observation Clinical Result Profile]({{site.data.fhir.ver.uscore7}}/StructureDefinition-us-core-observation-clinical-result.html)|code|
|[Observation Occupation Profile]({{site.data.fhir.ver.uscore7}}/StructureDefinition-us-core-observation-occupation.html)|code|
|[Observation Pregnancy Intent Profile]({{site.data.fhir.ver.uscore7}}/StructureDefinition-us-core-observation-pregnancyintent.html)|code|
|[Observation Pregnancy Status Profile]({{site.data.fhir.ver.uscore7}}/StructureDefinition-us-core-observation-pregnancystatus.html)|code|
|[Observation Screening Assessment Profile]({{site.data.fhir.ver.uscore7}}/StructureDefinition-us-core-observation-screening-assessment.html)|code|
|[Observation Sexual Orientation Profile]({{site.data.fhir.ver.uscore7}}/StructureDefinition-us-core-observation-sexual-orientation.html)|code|
|[Organization Profile]({{site.data.fhir.ver.uscore7}}/StructureDefinition-us-core-organization.html)|N/A|
|[Patient Profile]({{site.data.fhir.ver.uscore7}}/StructureDefinition-us-core-patient.html)|N/A|
|[Pediatric BMI for Age Observation Profile]({{site.data.fhir.ver.uscore7}}/StructureDefinition-pediatric-bmi-for-age.html)|code|
|[Pediatric Head Occipital Frontal Circumference Percentile Profile]({{site.data.fhir.ver.uscore7}}/StructureDefinition-head-occipital-frontal-circumference-percentile.html)|code|
|[Pediatric Weight for Height Observation Profile]({{site.data.fhir.ver.uscore7}}/StructureDefinition-pediatric-weight-for-height.html)|code|
|[Practitioner Profile]({{site.data.fhir.ver.uscore7}}/StructureDefinition-us-core-practitioner.html)|code|
|[PractitionerRole Profile]({{site.data.fhir.ver.uscore7}}/StructureDefinition-us-core-practitionerrole.html)|code|
|[Procedure Profile]({{site.data.fhir.ver.uscore7}}/StructureDefinition-us-core-procedure.html)|code|
|[Provenance Profile]({{site.data.fhir.ver.uscore7}}/StructureDefinition-us-core-provenance.html)|code|
|[Pulse Oximetry Profile]({{site.data.fhir.ver.uscore7}}/StructureDefinition-us-core-pulse-oximetry.html)|code|
|[QuestionnaireResponse Profile]({{site.data.fhir.ver.uscore7}}/StructureDefinition-us-core-questionnaireresponse.html)|name|
|[RelatedPerson Profile]({{site.data.fhir.ver.uscore7}}/StructureDefinition-us-core-relatedperson.html)|relationship|
|[Respiratory Rate Profile]({{site.data.fhir.ver.uscore7}}/StructureDefinition-us-core-respiratory-rate.html)|code|
|[ServiceRequest Profile]({{site.data.fhir.ver.uscore7}}/StructureDefinition-us-core-servicerequest.html)|type|
|[Simple Observation Profile]({{site.data.fhir.ver.uscore7}}/StructureDefinition-us-core-simple-observation.html)|code|
|[Smoking Status Observation Profile]({{site.data.fhir.ver.uscore7}}/StructureDefinition-us-core-smokingstatus.html)|code|
|[Specimen Profile]({{site.data.fhir.ver.uscore7}}/StructureDefinition-us-core-specimen.html)|type|
|[Vital Signs Profile]({{site.data.fhir.ver.uscore7}}/StructureDefinition-us-core-vital-signs.html)|code|

> Previous versions of the USCore-ModelInfo library (3.1.1 and 6.1.0) were included as embedded resources in the CQL-to-ELM translator (referenced without a namespace and using the version of the implementation guide). This is the `6.1.0-derived` version of the US Core Model Information file. As of version 8.0.0, the US Core implementation guide now includes [model information](https://hl7.org/fhir/us/core/Library-uscore-8.0.0-model-definition.html).

> Previous versions of the USCore-ModelInfo library were generated using [Profile-informed authoring](https://hl7.org/fhir/uv/cql/using-modelinfo.html#profile-informed-modelinfo). However, as of 6.1.0-derived, based on authoring and implementer feedback, the model information file is generated as a Derived model info:

> This model information file was generated with the [uscore-6-1-0-modelinfo-settings](Parameters-uscore-6-1-0-modelinfo-settings.html) parameters, using the process described in [Derived Model Info]({{site.data.fhir.ver.cql}}/using-modelinfo.html#derived-modelinfo).