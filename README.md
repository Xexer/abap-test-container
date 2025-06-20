# Test Container for ABAP Cloud (TDC)

## Idea

In the current version of ABAP Cloud, ABAP doesn't support test data containers. This simple solution is intended to make larger sets of test data easily available. The idea is to make the data available via platforms like GitHub, as these have built-in editors for JSON and XML, making data maintenance and handling easier.

## Mocking

In this case, the data is loaded from GitHub and made available to the test case. JSON, XML, and RAW are currently supported. The data is mapped generically, so the source data type must also match the target data type. This allows for different formats and data types.

## Example

Möchtest du ein Beispiel für die Konfiguration und die Daten haben, dann findest du im Unit Test der Klasse ZCL_TEST_CONTAINER weiter Informationen.
