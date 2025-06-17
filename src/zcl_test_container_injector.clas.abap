CLASS zcl_test_container_injector DEFINITION
  PUBLIC ABSTRACT FINAL
  CREATE PUBLIC
  FOR TESTING.

  PUBLIC SECTION.
    "! Inject double into Factory ZCL_TEST_CONTAINER_FACTORY
    CLASS-METHODS inject_test_container
      IMPORTING double TYPE REF TO zif_test_container.
ENDCLASS.


CLASS zcl_test_container_injector IMPLEMENTATION.
  METHOD inject_test_container.
    zcl_test_container_factory=>test_container = double.
  ENDMETHOD.
ENDCLASS.
