library USCoreCommonTests version '2.0.0-ballot'

using FHIR version '4.0.1'
using USCore version '6.1.0-derived'

include USCoreCommon version '2.0.0-ballot' called UC

context Patient

//* _01_ define fluent function race(patient Patient):
define _01_TestRace: Patient.race()

//* _02_ define fluent function ethnicity(patient Patient):
define _02_TestEthnicity: Patient.ethnicity()

//* _03_ define fluent function tribalAffiliation(patient Patient):
define _03_TestTribalAffiliation: Patient.tribalAffiliation()

//* _04_ define fluent function birthSex(patient Patient):
define _04_TestBirthSex: Patient.birthSex()

//* _05_ define fluent function systolic(bloodPressureProfile BloodPressureProfile):
define _05_TestSystolic:
  [Observation] O
    return O.systolic()

//* _06_ define fluent function diastolic(bloodPressureProfile BloodPressureProfile):
define _06_TestDiastolic:
  [Observation] O
    return O.diastolic()

//* _07_ define fluent function isHealthConcern(condition FHIR.Condition):
define _07_TestIsHealthConcern:
  [Condition] C
    where C.isHealthConcern()

