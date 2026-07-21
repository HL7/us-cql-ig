This topic provides query management guidance for implementers to support the use of CQL within FHIR artifacts such as questionnaires, typically from a DTR application. The functions and guidance provided here facilitate:

* Manage optional server-side parameters
* Check for modifier elements and extensions
* Manage optional _include and _revInclude situations
* Manage _element filtering
* Manage version differences among servers
* Provide simpler functions with typical search parameter filters (e.g., including only final and amended observations)
* Manage extension retrieval for extensions expected to be present (e.g., USCore and CRD extensions)
* Complex element retrieval such as "Cumulative Medication Duration" and "Body Surface Area"

* [Authoring](authoring.html)
* [Patterns](patterns.html)
* Libraries
    * [USCoreCommon](Library-USCoreCommon.html)
    * [USCoreElements](Library-USCoreElements.html)
    * [USCoreTests](Library-USCoreTests.html)