CLASS lth_config DEFINITION.
  PUBLIC SECTION.
    INTERFACES zif_test_container_config.

    TYPES: BEGIN OF github_test,
             text    TYPE string,
             number  TYPE i,
             boolean TYPE abap_bool,
           END OF github_test.

    TYPES github_tests TYPE STANDARD TABLE OF github_test.

    METHODS constructor
      IMPORTING file_path TYPE string.
ENDCLASS.


CLASS lth_config IMPLEMENTATION.
  METHOD constructor.
    zif_test_container_config~file_path = file_path.
    zif_test_container_config~source_platform = zif_test_container_config=>platforms-github.
  ENDMETHOD.
ENDCLASS.


CLASS ltc_container DEFINITION FINAL
  FOR TESTING RISK LEVEL HARMLESS DURATION SHORT.

  PRIVATE SECTION.
    CONSTANTS:
      BEGIN OF test_files,
        json_table TYPE string VALUE `https://raw.githubusercontent.com/Xexer/abap-test-container/refs/heads/main/examples/json-table.json`,
        xml_table  TYPE string VALUE `https://raw.githubusercontent.com/Xexer/abap-test-container/refs/heads/main/examples/xml-table.xml`,
      END OF test_files.

    METHODS load_github_json FOR TESTING RAISING cx_static_check.
    METHODS load_github_xml  FOR TESTING RAISING cx_static_check.
    METHODS load_json_table  FOR TESTING RAISING cx_static_check.
    METHODS load_xml_table   FOR TESTING RAISING cx_static_check.
ENDCLASS.

CLASS zcl_test_container DEFINITION LOCAL FRIENDS ltc_container.

CLASS ltc_container IMPLEMENTATION.
  METHOD load_github_json.
    DATA(cut) = NEW zcl_test_container( NEW lth_config( test_files-json_table ) ).

    DATA(result) = cut->load_file_from_source( ).

    cl_abap_unit_assert=>assert_not_initial( result ).
  ENDMETHOD.


  METHOD load_github_xml.
    DATA(cut) = NEW zcl_test_container( NEW lth_config( test_files-xml_table ) ).

    DATA(result) = cut->load_file_from_source( ).

    cl_abap_unit_assert=>assert_not_initial( result ).
  ENDMETHOD.


  METHOD load_json_table.
    DATA result TYPE lth_config=>github_tests.

    DATA(cut) = NEW zcl_test_container( NEW lth_config( test_files-json_table ) ).

    cut->zif_test_container~get_json_table( CHANGING generic_table = result ).

    cl_abap_unit_assert=>assert_not_initial( result ).
    cl_abap_unit_assert=>assert_equals( exp = 2
                                        act = lines( result ) ).
    cl_abap_unit_assert=>assert_equals( exp = 1337
                                        act = result[ 2 ]-number ).
  ENDMETHOD.


  METHOD load_xml_table.
    DATA result TYPE lth_config=>github_tests.

    DATA(cut) = NEW zcl_test_container( NEW lth_config( test_files-xml_table ) ).

    cut->zif_test_container~get_xml_table( CHANGING generic_table = result ).

    cl_abap_unit_assert=>assert_not_initial( result ).
    cl_abap_unit_assert=>assert_equals( exp = 3
                                        act = lines( result ) ).
    cl_abap_unit_assert=>assert_equals( exp = 9
                                        act = result[ 2 ]-number ).
  ENDMETHOD.
ENDCLASS.
