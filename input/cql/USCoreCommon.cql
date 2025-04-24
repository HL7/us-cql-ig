/*
@author: Bryn Rhodes
@description: This library defines functions to expose extensions defined
in USCore as fluent functions in CQL, as well as common terminology and functions
used in writing CQL with FHIR and USCore profiles.
*/
library USCoreCommon

using FHIR version '4.0.1'
using USCore version '7.0.0'

include FHIRHelpers version '2.0.0-ballot'
include FHIRCommon version '2.0.0-ballot'
//include fhir.uv.cql.FHIRHelpers version '2.0.0-ballot'
//include fhir.uv.cql.FHIRCommon version '2.0.0-ballot'

codesystem "CVX": 'http://hl7.org/fhir/sid/cvx'
codesystem "ActCode": 'http://terminology.hl7.org/CodeSystem/v3-ActCode'
codesystem "ObservationStatusCodes": 'http://hl7.org/fhir/observation-status'
codesystem "USCoreConditionCategory": 'http://hl7.org/fhir/us/core/CodeSystem/condition-category'
codesystem "CDC Race and Ethnicity Codes": 'urn:oid:2.16.840.1.113883.6.238'
codesystem "CommunicationCategoryCodeSystem": 'http://terminology.hl7.org/CodeSystem/communication-category'
codesystem "IdentifierType": 'http://terminology.hl7.org/CodeSystem/v2-0203'

code "MedicalRecordNumber": 'MR' from "IdentifierType" display 'Medical record number'

// Encounter Class Codes
code "ambulatory": 'AMB' from ActCode display 'ambulatory'
code "emergency": 'EMER' from ActCode display 'emergency'
code "field": 'FLD' from ActCode display 'field'
code "home health": 'HH' from ActCode display 'home health'
code "inpatient encounter": 'IMP' from ActCode display 'inpatient encounter'
code "inpatient acute": 'ACUTE' from ActCode display 'inpatient acute'
code "inpatient non-acute": 'NONAC' from ActCode display 'inpatient non-acute'
code "observation encounter": 'OBSENC' from ActCode display 'observation encounter'
code "pre-admission": 'PRENC' from ActCode display 'pre-admission'
code "short stay": 'SS' from ActCode display 'short stay'
code "virtual": 'VR' from ActCode display 'VR'

// Condition Category Codes
code "health-concern": 'health-concern' from "USCoreConditionCategory" display 'Health Concern'

// MedicationRequest Category Codes
code "Inpatient": 'inpatient' from "MedicationRequestCategory" display 'Inpatient'
code "Outpatient": 'outpatient' from "MedicationRequestCategory" display 'Outpatient'
code "Community": 'community' from "MedicationRequestCategory" display 'Community'
code "Discharge": 'discharge' from "MedicationRequestCategory" display 'Discharge'

// Observation Status Codes
code "observation-registered": 'registered' from "ObservationStatusCodes" display 'Registered'
code "observation-preliminary": 'preliminary' from "ObservationStatusCodes" display 'Preliminary'
code "observation-final": 'final' from "ObservationStatusCodes" display 'Final'
code "observation-amended": 'amended' from "ObservationStatusCodes" display 'Amended'
code "observation-corrected": 'corrected' from "ObservationStatusCodes" display 'Corrected'
code "observation-cancelled": 'cancelled' from "ObservationStatusCodes" display 'Cancelled'
code "observation-entered-in-error": 'entered-in-error' from "ObservationStatusCodes" display 'Entered in Error'
code "observation-unknown": 'unknown' from "ObservationStatusCodes" display 'Unknown'

code "Systolic Blood Pressure": '8480-6' from FHIRCommon.LOINC
code "Diastolic Blood Pressure": '8462-4' from FHIRCommon.LOINC
code "BMI": '39156-5' from FHIRCommon.LOINC

context Patient

define fluent function race(patient Patient):
  (patient.extension('http://hl7.org/fhir/us/core/StructureDefinition/us-core-race')) E
    return {
      ombCategory: (E.extensions('ombCategory')) ombCategory return ombCategory.value as FHIR.Coding,
      detailed: (E.extensions('detailed')) detailed return detailed.value as FHIR.Coding,
      text: E.extension('text').value as FHIR.string
    }

define fluent function ethnicity(patient Patient):
  (patient.extension('http://hl7.org/fhir/us/core/StructureDefinition/us-core-ethnicity')) E
    return {
      ombCategory: E.extension('ombCategory').value as FHIR.Coding,
      detailed: (E.extensions('detailed')) detailed return detailed.value as FHIR.Coding,
      text: E.extension('text').value as FHIR.string
    }

define fluent function tribalAffiliation(patient Patient):
  (patient.extension('http://hl7.org/fhir/us/core/StructureDefinition/us-core-tribal-affiliation')) E
    return {
      tribalAffiliation: E.extension('tribalAffiliation').value as CodeableConcept,
      isEnrolled: E.extension('isEnrolled').value as boolean
    }

define fluent function birthSex(patient Patient):
  patient.extension('http://hl7.org/fhir/us/core/StructureDefinition/us-core-birthsex').value as FHIR.code

define fluent function systolic(bloodPressureProfile BloodPressureProfile):
  singleton from (
    bloodPressureProfile.component C
      where C.code ~ "Systolic Blood Pressure"
  )

define fluent function diastolic(bloodPressureProfile BloodPressureProfile):
  singleton from (
    bloodPressureProfile.component C
      where C.code ~ "Diastolic Blood Pressure"
  )

