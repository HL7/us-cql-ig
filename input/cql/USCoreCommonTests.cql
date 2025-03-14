library USCoreCommonTests version '0.1.0'

using USCore version '3.1.1'
using FHIR version '4.0.1'

include USCoreCommon version '0.1.0' called UC

context Patient

define test_email:
  assertEqual(UC.Email(Patient.telecom).value, 'peter.chalmers@example.org').testPasses()

define test_fax:
  assertEqual(UC.Fax(Patient.telecom).value, '(345) 678 9012').testPasses()

define test_mobile_number:
  assertEqual(UC.Mobile(Patient.telecom).value, '(123) 456 7890').testPasses()

define test_pager:
  assertEqual(UC.Pager(Patient.telecom).value, '(456) 789 0123').testPasses()

define test_work_number:
  assertEqual(UC.Work(Patient.telecom).value, '(234) 567 8901').testPasses()

define fluent function testPasses(condition System.Boolean):
  if condition then ' PASS' else ' ***** FAIL *****'

define function assertEqual(valueA System.String, valueB System.String):
  valueA = valueB