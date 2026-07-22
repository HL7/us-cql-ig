To use these libraries in your implementation guide, include a reference to this implementation guide as an implementation guide dependency. If your implementation guide is specified as an XML resource:

```xml
<dependsOn id="cql-us">
  <uri value="http://hl7.org/fhir/us/cql/ImplementationGuide/hl7.fhir.us.cql"/>
  <packageId value="hl7.fhir.us.cql"/>
  <version value="2.0.0"/>
</dependsOn>
```

If your implementation guide is specified as a JSON resource:

```json
    "dependsOn": [{
      "id": "cql-us",
      "uri": "http://hl7.org/fhir/us/cql/ImplementationGuide/hl7.fhir.us.cql",
      "packageId": "hl7.fhir.us.cql",
      "version": "2.0.0"
    }]
```

And if your implementation guide is specified using SUSHI, add this to your `sushi-config.yaml`:

```yaml
dependencies:
  hl7.fhir.us.cql: 
    id: cql-us
    version: 2.0.0
```

#### USCore ModelInfo

Clinical Quality Language (<a href="http://cql.hl7.org">CQL</a>) is a high-level, domain-specific language focused on clinical quality, and it is targeted at measure and decision support artifact authors. Additionally, the CQL specification provides a machine-readable canonical representation called Expression Logical Model (<a href="https://cql.hl7.org/04-logicalspecification.html">ELM</a>), which is targeted at implementations, and designed to enable automated sharing of clinical knowledge.

To use CQL with USCore, <a href="https://cql.hl7.org/07-physicalrepresentation.html#data-model-references">model information</a> must be provided to the implementation environment. The <a href="Library-USCore-ModelInfo.html">USCore-ModelInfo</a> library provides this information for US Core. To use USCore, include a <a href="https://cql.hl7.org/02-authorsguide.html#data-models">using declaration</a> as shown in the example below:

```cql
using USCore version '6.1.0-derived'
```

> NOTE: The `-derived` label is used to distinguish this model info from the non-derived model info. See the [US Core Model Info](uscore-modelinfo.html) page for more information.

