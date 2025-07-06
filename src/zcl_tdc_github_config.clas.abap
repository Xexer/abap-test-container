CLASS zcl_tdc_github_config DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES zif_test_container_config.

    "! Create a configuration for GitHub
    "! @parameter file_path | Path to the GitHub file
    METHODS constructor
      IMPORTING file_path TYPE string.
ENDCLASS.


CLASS zcl_tdc_github_config IMPLEMENTATION.
  METHOD constructor.
    zif_test_container_config~file_path = file_path.
    zif_test_container_config~source_platform = zif_test_container_config=>platforms-github.
  ENDMETHOD.


  METHOD zif_test_container_config~load_file_from_source.
    TRY.
        DATA(destination) = cl_http_destination_provider=>create_by_url( zif_test_container_config~file_path ).
        DATA(client) = cl_web_http_client_manager=>create_by_http_destination( destination ).

        DATA(response) = client->execute( i_method = if_web_http_client=>get ).

        IF response->get_status( )-code = 200.
          RETURN response->get_text( ).
        ENDIF.

      CATCH cx_root INTO DATA(http_error).
        RAISE EXCEPTION NEW zcx_test_container_error( previous = http_error ).
    ENDTRY.
  ENDMETHOD.
ENDCLASS.
