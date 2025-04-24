library USCoreCommonTests

using FHIR version '4.0.1'
using USCore version '7.0.0'

include USCoreCommon called UC

context Patient

define TestEmail:
  UC.Email(Patient.telecom).value

define TestFax:
  UC.Fax(Patient.telecom).value

define TestMobileNumber:
  UC.Mobile(Patient.telecom).value

define TestPager:
  UC.Pager(Patient.telecom).value

define TestWorkNumber:
  UC.Work(Patient.telecom).value