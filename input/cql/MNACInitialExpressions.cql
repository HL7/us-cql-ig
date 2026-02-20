library MNACInitialExpressions version '1.0.1'

using USCore version '7.0.0'
using FHIR version '4.0.1'

include hl7.fhir.uv.cql.FHIRHelpers version '4.0.1'
include USCoreCommon version '1.0.1' called UC
include USCoreElements version '1.0.1' called UCE

codesystem "Identifier Type": 'http://terminology.hl7.org/CodeSystem/v2-0203'
codesystem "ICD10": 'http://hl7.org/fhir/sid/icd-10-cm'
codesystem "SNOMED CT": 'http://snomed.info/sct'

code "Member Number": 'MB' from "Identifier Type"
code "UTI": 'T83.5' from "ICD10"
code "Abnormal Urine Finding": '102866000' from "SNOMED CT"

parameter "ServiceRequest" FHIR.ServiceRequest

context Patient

define "Retrieve Service Request test parameter":
  // The VSCode extension doesn't support parameters
  // When executing CQL with the VSCode extension retrieve the resource specific for the test case
  //   the list of resource ids match the resources from the test case folders
  singleton from ([FHIR.ServiceRequest] SR where SR.id in { 
    'service-request-example'})

define "Service Request":
  Coalesce(
    ServiceRequest,
    "Retrieve Service Request test parameter"
  )

define "Date of Request":
  "Service Request".authoredOn.value

//https://www.hca.wa.gov/assets/billers-and-providers/13-760.pdf

define "Diagnosis":
  First("SR Related Condition".code).text.value

define "Item Requested":
  "Service Request".code.coding.display.value

define "UTI in Last Year":
  Exists("UTI Diagnostic Reports Last Year")

define "Lab Reports UTIs":
  "UTI Diagnostic Reports Last Year".presentedForm

define "Dates of UTIs":
  "UTI Diagnostic Reports Last Year".effective.value

//TODO: create example MedicationStatement
define "Antibiotics Used":
  [FHIR.MedicationStatement] MS
    where First(MS.reasonReference.reference) in "UTI Diagnostic Reports Last Year".id

define "Check Symptoms":
  'TBD'

define "Fever Temperature":
  'TBD'

define "Catheterization Frequency":
  'TBD'

define "Additional Comment":
  'TBD'

define "Physician Name":
  "Requesting Physician".name.family 

define "Physician Telephone":
  Mobile("Requesting Physician".telecom).value

define "Physician Fax":
  Fax("Requesting Physician".telecom).value

define "Referring Physician Telephone":
  'TBD'

define "Date":
  Today()

//helper definitions
// define "All ServiceRequests":
//   [FHIR.ServiceRequest]

// define "Most Recent ServiceRequest":
//   UC.MostRecent("All ServiceRequests")

define "SR Related Condition":
  [FHIR.Condition] C
  where EndsWith(First("Service Request".reasonReference.reference.value), C.id)

define "UTI Diagnostic Reports Last Year":
  [FHIR.DiagnosticReport] C
  where "Abnormal Urine Finding".code in C.conclusionCode.coding.code
  and C.effective	> (Today() - 1 year)

define "Requesting Physician":
  singleton from (
    [USCore.PractitionerProfile] P
  where EndsWith("Service Request".requester.reference, P.id))

define function Fax(contactPoints List<ContactPoint>):
  singleton from (contactPoints P where P.system = 'fax')

define function Mobile(contactPoints List<ContactPoint>):
  singleton from (contactPoints P where P.system = 'mobile')
