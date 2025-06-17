CLASS zcl_test_container DEFINITION
  PUBLIC FINAL
  CREATE PRIVATE
  GLOBAL FRIENDS zcl_test_container_factory.

  PUBLIC SECTION.
    INTERFACES zif_test_container.

    METHODS constructor
      IMPORTING configuration TYPE REF TO zif_test_container_config.

  PRIVATE SECTION.
    DATA configuration TYPE REF TO zif_test_container_config.

    METHODS load_file_from_source.
ENDCLASS.


CLASS zcl_test_container IMPLEMENTATION.
  METHOD constructor.
    me->configuration = configuration.
  ENDMETHOD.


  METHOD zif_test_container~get_file_string.
  ENDMETHOD.


  METHOD zif_test_container~get_file_xstring.
  ENDMETHOD.


  METHOD zif_test_container~get_json_table.
  ENDMETHOD.


  METHOD zif_test_container~get_xml_table.
  ENDMETHOD.


  METHOD load_file_from_source.
    CASE configuration->source_platform.
      WHEN configuration->platforms-github.

      WHEN OTHERS.
        RAISE EXCEPTION NEW zcx_test_container_error( ).
    ENDCASE.
  ENDMETHOD.
ENDCLASS.
