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

    "! Loads file from source
    "! @parameter result | File as plain string
    METHODS load_file_from_source
      RETURNING VALUE(result) TYPE string.
ENDCLASS.


CLASS zcl_test_container IMPLEMENTATION.
  METHOD constructor.
    me->configuration = configuration.
  ENDMETHOD.


  METHOD zif_test_container~get_file_string.
    RETURN load_file_from_source( ).
  ENDMETHOD.


  METHOD zif_test_container~get_file_xstring.
    DATA(plain_content) = load_file_from_source( ).

    RETURN xco_cp=>string( plain_content )->as_xstring( xco_cp_character=>code_page->utf_8 )->value.
  ENDMETHOD.


  METHOD zif_test_container~get_json_table.
    DATA(plain_content) = load_file_from_source( ).

    /ui2/cl_json=>deserialize( EXPORTING json = plain_content
                               CHANGING  data = generic_table ).
  ENDMETHOD.


  METHOD zif_test_container~get_xml_table.
    DATA(binary_content) = zif_test_container~get_file_xstring( ).
    DATA(reader) = cl_sxml_string_reader=>create( binary_content ).

    CALL TRANSFORMATION id SOURCE XML reader
         RESULT data = generic_table.
  ENDMETHOD.


  METHOD load_file_from_source.
    TRY.
        DATA(destination) = cl_http_destination_provider=>create_by_url( configuration->file_path ).
        DATA(client) = cl_web_http_client_manager=>create_by_http_destination( destination ).

        CASE configuration->source_platform.
          WHEN configuration->platforms-github.
            DATA(response) = client->execute( i_method = if_web_http_client=>get ).
            IF response->get_status( )-code = 200.
              RETURN response->get_text( ).
            ENDIF.

          WHEN OTHERS.
            RAISE EXCEPTION NEW zcx_test_container_error( ).
        ENDCASE.

      CATCH cx_root INTO DATA(http_error).
        RAISE EXCEPTION NEW zcx_test_container_error( previous = http_error ).
    ENDTRY.
  ENDMETHOD.
ENDCLASS.
