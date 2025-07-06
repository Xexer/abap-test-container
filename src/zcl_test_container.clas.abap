CLASS zcl_test_container DEFINITION
  PUBLIC FINAL
  CREATE PRIVATE
  GLOBAL FRIENDS zcl_test_container_factory.

  PUBLIC SECTION.
    INTERFACES zif_test_container.

    METHODS constructor
      IMPORTING configuration TYPE REF TO zif_test_container_config.

  PRIVATE SECTION.
    "! Configuration for access
    DATA configuration TYPE REF TO zif_test_container_config.
ENDCLASS.


CLASS zcl_test_container IMPLEMENTATION.
  METHOD constructor.
    me->configuration = configuration.
  ENDMETHOD.


  METHOD zif_test_container~get_file_string.
    RETURN configuration->load_file_from_source( ).
  ENDMETHOD.


  METHOD zif_test_container~get_file_xstring.
    DATA(plain_content) = configuration->load_file_from_source( ).

    RETURN xco_cp=>string( plain_content )->as_xstring( xco_cp_character=>code_page->utf_8 )->value.
  ENDMETHOD.


  METHOD zif_test_container~get_json_data.
    DATA(plain_content) = configuration->load_file_from_source( ).

    /ui2/cl_json=>deserialize( EXPORTING json = plain_content
                               CHANGING  data = generic ).
  ENDMETHOD.


  METHOD zif_test_container~get_xml_data.
    DATA(binary_content) = zif_test_container~get_file_xstring( ).
    DATA(reader) = cl_sxml_string_reader=>create( binary_content ).

    CALL TRANSFORMATION id SOURCE XML reader
         RESULT data = generic.
  ENDMETHOD.
ENDCLASS.
