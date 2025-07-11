# Test Container for ABAP Cloud (TDC)

## Idea

In the current version of ABAP Cloud, ABAP doesn't support test data containers. This simple solution is intended to make larger sets of test data easily available. The idea is to make the data available via platforms like GitHub, as these have built-in editors for JSON and XML, making data maintenance and handling easier. You can find more informations about the project in this [blog post](https://software-heroes.com/en/blog/abap-cloud-test-data-container) on Software-Heroes.

## Mocking

In this case, the data is loaded from GitHub and made available to the test case. JSON, XML, and RAW are currently supported. The data is mapped generically, so the source data type must also match the target data type. This allows for different formats and data types.

## Example

If you would like an example of the configuration and data, you can find further information in the unit test of the ZCL_TEST_CONTAINER class.

### Setup configuration

```ABAP
DATA(configuration) = NEW zcl_tdc_github_config( test_file_path ).
```

### Get container

```ABAP
DATA(container) = zcl_test_container_factory=>create( configuration ).
```

### Get data

```ABAP
container->get_json_data( CHANGING generic = result ).
```
