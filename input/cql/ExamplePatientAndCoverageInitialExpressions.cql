library ExamplePatientAndCoverageInitialExpressions

using USCore version '7.0.0'
using FHIR version '4.0.1'

include hl7.fhir.uv.cql.FHIRHelpers version '4.0.1'
include USCoreCommon called UC
include USCoreElements called UCE

codesystem "Identifier Type": 'http://terminology.hl7.org/CodeSystem/v2-0203'

code "Member Number": 'MB' from "Identifier Type"
code "Subscriber Number": 'SN' from "Identifier Type"

parameter "Coverage" FHIR.Coverage
parameter "ServiceRequest" FHIR.ServiceRequest

context Patient

define "Retrieve Service Request test parameter":
  // The VSCode extension doesn't support parameters
  // When executing CQL with the VSCode extension retrieve the resource specific for the test case
  //   the list of resource ids match the resources from the test case folders
  singleton from ([FHIR.ServiceRequest] SR where SR.id in { 
    'minimal-service-request-example'
  })

define "Service Request":
  Coalesce(
    ServiceRequest,
    "Retrieve Service Request test parameter"
  )

define "Retrieve Coverage test parameter":
  // The VSCode extension doesn't support parameters
  // When executing CQL with the VSCode extension retrieve the resource specific for the test case
  //   the list of resource ids match the resources from the test case folders
  singleton from ([FHIR.Coverage] CV where CV.id in { 
    'minimal-coverage-example'
  })

define "Member Coverage":
  Coalesce(
    Coverage,
    "Retrieve Coverage test parameter"
  )

define "Patient Name":
  Patient.officialName().first().firstMiddleLast()

define "Date of Birth":
  Patient.birthDate

define "Birth Sex":
  Patient.gender

define "Medical Record Number":
  Patient.medicalRecordNumber()

define "Phone Number":
  Mobile(Patient.telecom).value

define "Email Address":
  Email(Patient.telecom).value

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
  "Member Coverage".memberID()

// TODO: is there a need to check for coverage period and order?
//       also do we need to check that the payor organization is the same as the source of the prior auth form?
define "Policy Number":
  "Member Coverage".policyNumber()

define "Requesting Provider":
  UCE.RequestingProvider("Service Request")

define "Requesting Provider Name":
  "Requesting Provider".name.family

define "Requesting Provider Phone":
  Work("Requesting Provider".telecom).value

define "Requesting Provider Address":
  (singleton from "Requesting Provider".address).line

define "Requesting Provider NPI":
  "Requesting Provider".identifier I 
  where I.system = 'http://hl7.org/fhir/sid/us-npi'
  return I.value

define "Requesting Provider Fax":
  Fax("Requesting Provider".telecom).value

define "Servicing Provider":
  UCE.ServicingProvider("Service Request")

define "Servicing Provider Name":
  "Servicing Provider".name

define "Servicing Provider Phone":
  Work("Servicing Provider".telecom).value

define "Servicing Provider Address":
  (singleton from "Servicing Provider".address).text

define "Servicing Provider NPI":
  "Servicing Provider".identifier I 
  where I.system = 'http://hl7.org/fhir/sid/us-npi'
  return I.value

define "Servicing Provider Fax":
  Fax("Servicing Provider".telecom).value

define function Work(contactPoints List<ContactPoint>):
  singleton from (contactPoints P where P.system = 'phone' and P.use = 'work')

define function Mobile(contactPoints List<ContactPoint>):
  singleton from (contactPoints P where P.system = 'phone' and P.use = 'mobile')

define function Email(contactPoints List<ContactPoint>):
  singleton from (contactPoints P where P.system = 'email')

define function Fax(contactPoints List<ContactPoint>):
  singleton from (contactPoints P where P.system = 'fax')