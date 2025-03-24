library USCoreCommonTests

using USCore version '3.1.1'
using FHIR version '4.0.1'

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