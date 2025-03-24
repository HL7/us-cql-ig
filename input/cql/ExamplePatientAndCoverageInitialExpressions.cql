library ExamplePatientAndCoverageInitialExpressions

using USCore version '3.1.1'
using FHIR version '4.0.1'

include FHIRHelpers version '4.0.1'
include USCoreCommon called UC
include USCoreElements called UCE

codesystem "Identifier Type": 'http://terminology.hl7.org/CodeSystem/v2-0203'

code "Member Number": 'MB' from "Identifier Type"
code "Subscriber Number": 'SN' from "Identifier Type"

parameter "Coverage" FHIR.Coverage
parameter "Coverage Id" List<System.String> 
  default { 'minimal-coverage-example' }    // TODO: remove defaults for production use

parameter "ServiceRequest" FHIR.ServiceRequest
parameter "ServiceRequest Id" List<System.String> 
  default { 'minimal-service-request-example' }     // TODO: remove defaults for production use

context Patient

// Patient
define "Member Coverage":
  Coalesce(
    Coverage,
    singleton from ([FHIR.Coverage] CV
      where CV.id in "Coverage Id")
  )

define "Patient Name":
  UCE."Name - First Middle(s) Last"

define "Date of Birth":
  Patient.birthDate

define "Birth Sex":
  Patient.birthsex

define "Medical Record Number":
  UCE."Medical Record Number"

define "Phone Number":
  UC.Mobile(Patient.telecom).value

define "Email Address":
  UC.Email(Patient.telecom).value

define "Address":
  (singleton from Patient.address).line

define "City":
  Patient.address.city

define "State":
  Patient.address.state

define "Postal Code":
  Patient.address.postalCode

// Coverage
// define "Coverage":
//   First(clinical C where C is FHIR.Coverage)

// TODO: is there a need to check for coverage period and order? 
//       also, do we need to check that the payor organization is the same as the source of the prior auth form?
define "Member ID":
  UCE.MemberID("Member Coverage").value

// TODO: is there a need to check for coverage period and order?
//       also do we need to check that the payor organization is the same as the source of the prior auth form?
define "Policy Number":
  UCE.PolicyNumber("Member Coverage").value

define "Most Recent ServiceRequest":
  Coalesce(
    ServiceRequest,
    singleton from ([FHIR.ServiceRequest] SR
      where SR.id in "ServiceRequest Id")
  )

define "Requesting Provider":
  UCE.RequestingProvider("Most Recent ServiceRequest")

define "Requesting Provider Name":
  "Requesting Provider".name.family

define "Requesting Provider Phone":
  UC.Work("Requesting Provider".telecom).value

define "Requesting Provider Address":
  (singleton from "Requesting Provider".address).line

define "Requesting Provider NPI":
  "Requesting Provider".identifier I 
  where I.system = 'http://hl7.org/fhir/sid/us-npi'
  return I.value

define "Requesting Provider Fax":
  "Requesting Provider".telecom T
  where T.system = 'fax'
  return T.value

define "Servicing Provider":
  UCE.ServicingProvider("Most Recent ServiceRequest")

define "Servicing Provider Name":
  "Servicing Provider".name

define "Servicing Provider Phone":
  UC.Work("Servicing Provider".telecom).value

define "Servicing Provider Address":
  (singleton from "Servicing Provider".address).text

define "Servicing Provider NPI":
  "Servicing Provider".identifier I 
  where I.system = 'http://hl7.org/fhir/sid/us-npi'
  return I.value

define "Servicing Provider Fax":
  "Servicing Provider".telecom T
  where T.system = 'fax'
  return T.value