CLASS zcl_test_container_factory DEFINITION
  PUBLIC ABSTRACT FINAL
  CREATE PUBLIC
  GLOBAL FRIENDS zcl_test_container_injector.

  PUBLIC SECTION.
    "! Create a new test container
    "! @parameter configuration | Configuration for the source
    "! @parameter result        | New instance for a container
    CLASS-METHODS create
      IMPORTING configuration TYPE REF TO zif_test_container_config
      RETURNING VALUE(result) TYPE REF TO zif_test_container.

  PRIVATE SECTION.
    "! Double for injector ZCL_TEST_CONTAINER_INJECTOR
    CLASS-DATA test_container TYPE REF TO zif_test_container.
ENDCLASS.


CLASS zcl_test_container_factory IMPLEMENTATION.
  METHOD create.
    IF test_container IS BOUND.
      RETURN test_container.
    ELSE.
      RETURN NEW zcl_test_container( configuration ).
    ENDIF.
  ENDMETHOD.
ENDCLASS.
