CLASS ltc_container DEFINITION FINAL
  FOR TESTING RISK LEVEL HARMLESS DURATION SHORT.

  PRIVATE SECTION.
    TYPES: BEGIN OF github_test,
             text    TYPE string,
             number  TYPE i,
             boolean TYPE abap_bool,
           END OF github_test.
    TYPES github_tests TYPE STANDARD TABLE OF github_test WITH EMPTY KEY.

    TYPES: BEGIN OF deep,
             version     TYPE string,
             description TYPE string,
             table       TYPE github_tests,
           END OF deep.

    CONSTANTS:
      BEGIN OF test_files,
        json_table     TYPE string VALUE `https://raw.githubusercontent.com/Xexer/abap-test-container/refs/heads/main/examples/json-table.json`,
        xml_table      TYPE string VALUE `https://raw.githubusercontent.com/Xexer/abap-test-container/refs/heads/main/examples/xml-table.xml`,
        raw_file       TYPE string VALUE `https://raw.githubusercontent.com/Xexer/abap-test-container/refs/heads/main/examples/raw-file.txt`,
        deep_structure TYPE string VALUE `https://raw.githubusercontent.com/Xexer/abap-test-container/refs/heads/main/examples/deep-structure.json`,
      END OF test_files.

    METHODS get_github_cut
      IMPORTING file_path     TYPE string
      RETURNING VALUE(result) TYPE REF TO zif_test_container.

    METHODS load_json_table     FOR TESTING RAISING cx_static_check.
    METHODS load_xml_table      FOR TESTING RAISING cx_static_check.
    METHODS load_raw_file       FOR TESTING RAISING cx_static_check.
    METHODS load_deep_structure FOR TESTING RAISING cx_static_check.
ENDCLASS.

CLASS zcl_test_container DEFINITION LOCAL FRIENDS ltc_container.

CLASS ltc_container IMPLEMENTATION.
  METHOD get_github_cut.
    RETURN NEW zcl_test_container( NEW zcl_tdc_github_config( file_path ) ).
  ENDMETHOD.


  METHOD load_json_table.
    DATA result TYPE github_tests.

    DATA(cut) = get_github_cut( test_files-json_table ).

    cut->get_json_data( CHANGING generic = result ).

    cl_abap_unit_assert=>assert_not_initial( result ).
    cl_abap_unit_assert=>assert_equals( exp = 2
                                        act = lines( result ) ).
    cl_abap_unit_assert=>assert_equals( exp = 1337
                                        act = result[ 2 ]-number ).
  ENDMETHOD.


  METHOD load_xml_table.
    DATA result TYPE github_tests.

    DATA(cut) = get_github_cut( test_files-xml_table ).

    cut->get_xml_data( CHANGING generic = result ).

    cl_abap_unit_assert=>assert_not_initial( result ).
    cl_abap_unit_assert=>assert_equals( exp = 3
                                        act = lines( result ) ).
    cl_abap_unit_assert=>assert_equals( exp = 9
                                        act = result[ 2 ]-number ).
  ENDMETHOD.


  METHOD load_raw_file.
    DATA(cut) = get_github_cut( test_files-raw_file ).

    DATA(result) = cut->get_file_string( ).

    cl_abap_unit_assert=>assert_equals( exp = `TEST`
                                        act = result ).
  ENDMETHOD.


  METHOD load_deep_structure.
    DATA result TYPE deep.

    DATA(cut) = get_github_cut( test_files-deep_structure ).

    cut->get_json_data( CHANGING generic = result ).

    cl_abap_unit_assert=>assert_equals( exp = '1.0'
                                        act = result-version ).
    cl_abap_unit_assert=>assert_equals( exp = 2
                                        act = lines( result-table ) ).
  ENDMETHOD.
ENDCLASS.
