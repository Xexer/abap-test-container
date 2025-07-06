INTERFACE zif_test_container_config
  PUBLIC.

  TYPES platform TYPE c LENGTH 10.

  CONSTANTS: BEGIN OF platforms,
               github TYPE platform VALUE 'GITHUB',
             END OF platforms.

  "! Path to the file
  DATA file_path       TYPE string   READ-ONLY.

  "! Platform where the file is located
  DATA source_platform TYPE platform READ-ONLY.


  "! Loads file from source
  "! @parameter result | File as plain string
  METHODS load_file_from_source
    RETURNING VALUE(result) TYPE string.
ENDINTERFACE.
