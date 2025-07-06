CLASS ltc_connection DEFINITION FINAL
  FOR TESTING RISK LEVEL HARMLESS DURATION SHORT.

  PRIVATE SECTION.
    CONSTANTS:
      BEGIN OF test_files,
        json_table TYPE string VALUE `https://raw.githubusercontent.com/Xexer/abap-test-container/refs/heads/main/examples/json-table.json`,
        xml_table  TYPE string VALUE `https://raw.githubusercontent.com/Xexer/abap-test-container/refs/heads/main/examples/xml-table.xml`,
      END OF test_files.

    METHODS get_cut
      IMPORTING file_path     TYPE string
      RETURNING VALUE(result) TYPE REF TO zif_test_container_config.

    METHODS load_github_json FOR TESTING RAISING cx_static_check.
    METHODS load_github_xml  FOR TESTING RAISING cx_static_check.
ENDCLASS.

CLASS zcl_tdc_github_config DEFINITION LOCAL FRIENDS ltc_connection.

CLASS ltc_connection IMPLEMENTATION.
  METHOD get_cut.
    RETURN NEW zcl_tdc_github_config( file_path ).
  ENDMETHOD.


  METHOD load_github_json.
    DATA(cut) = get_cut( test_files-json_table ).

    DATA(result) = cut->load_file_from_source( ).

    cl_abap_unit_assert=>assert_not_initial( result ).
  ENDMETHOD.


  METHOD load_github_xml.
    DATA(cut) = get_cut( test_files-xml_table ).

    DATA(result) = cut->load_file_from_source( ).

    cl_abap_unit_assert=>assert_not_initial( result ).
  ENDMETHOD.
ENDCLASS.
