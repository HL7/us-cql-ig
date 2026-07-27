# Refined Unit Test Drafts

These `refined-*` test cases are **illustrative drafts** for the assertion model described on the
[Unit Testing Proposal](../../pagecontent/unit-testing.md) page. They demonstrate the four capabilities
called out in balloter feedback — relative timing, tolerant floating-point/unit comparison, type-aware and
negatable assertions, and partial matching of lists/complex objects.

They use the **proposed** `expected-results` format (a `name` plus `operator` / `expected` / `tolerance` /
`negated` parts) and, where relative timing is involved, a `Parameters-test-context.json` that pins
`evaluationDateTime`. This format is not yet executed by the current VSCode CQL test runner (which performs
exact-equality on `name`/`value` pairs); it is provided to make the proposal concrete and to seed the
enhanced runner. The corresponding test expressions were added to `USCoreElementsTests.cql` and
`USCoreCommonTests.cql` under the "Refined unit test demonstration" headings.

## USCoreElementsTests

### `refined-age-in-days` — relative timing
Patient born `2026-01-01`, evaluation time pinned to `2026-01-08`.
- `Test Age In Days` **equals** `7`; **between** `1` and `30`; **exists** (not null).
- `Test Age In Years` **equals** `0`.

Because `ageInDays()`/`ageInYears()` resolve `Today()` from the pinned `evaluationDateTime` rather than the
wall clock, the expected values are stable no matter when the suite runs.

### `refined-bsa` — floating point + units
Height `175 cm`, weight `154.324 [lb_av]` (deliberately mixed metric/imperial source units).
- `Test BSA (Mosteller)` **approximately** `1.84 m2` within `0.01` (exact value ≈ `1.8428`).
- `Test BSA (DuBois and DuBois)` **approximately** `1.85 m2` within `0.01` (exact value ≈ `1.8483`).
- `Test BSA (Mosteller)` **greaterThan** `1.5 m2`.

`CalculateBSA` returns `m2`; the assertion normalizes UCUM units before applying the tolerance, so the
imperial weight and metric height in the source data still yield a metric result that matches. Exact
equality against `1.84`/`1.85` would fail — the point of `approximately`.

### `refined-active-medications` — partial list matching
Three `MedicationRequest`s: `metformin-active-order` (active/order → included), `lisinopril-stopped`
(stopped → excluded), `atorvastatin-active-plan` (intent `plan` → excluded).
- `Test Active Medication Orders` **countGreaterThan** `0`; **lengthOf** `1`.
- **includes** the request with identifier `metformin-active-order` (partial template — identifier only).
- **does not include** (`negated`) `lisinopril-stopped` or `atorvastatin-active-plan`.

The `includes` assertions match on a partial resource template (identifier), so the test does not depend on
the full serialized MedicationRequest and does not break when unrelated requests are added.

## USCoreCommonTests

### `refined-demographics` — type-aware equality, negation, partial Coding match
Patient with `us-core-birthsex = F` and a `us-core-race` `ombCategory` of White (`2106-3`).
- `Test Birth Sex` **equals** `F`; **not equals** `M` (`negated`).
- `Test Race Categories` **includes** a Coding with code `2106-3`; **does not include** `2054-5` (Black);
  **lengthOf** `1`.

`includes` over `Test Race Categories` matches a partial `Coding` (system + code), leaving `display` and any
other Codings unconstrained.
