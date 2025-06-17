INTERFACE zif_test_container_config
  PUBLIC.

  TYPES platform TYPE c LENGTH 10.

  CONSTANTS: BEGIN OF platforms,
               github TYPE platform VALUE 'GITHUB',
             END OF platforms.

  DATA file_path       TYPE string   READ-ONLY.
  DATA source_platform TYPE platform READ-ONLY.
ENDINTERFACE.
