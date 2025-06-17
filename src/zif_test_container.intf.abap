INTERFACE zif_test_container
  PUBLIC.

  "! Loads a JSON file and converts it to an internal table
  "! @parameter generic_table | Generic table format
  METHODS get_json_table
    CHANGING generic_table TYPE ANY TABLE.

  "! Loads a XML file and converts it to an internal table
  "! @parameter generic_table | Generic table format
  METHODS get_xml_table
    CHANGING generic_table TYPE ANY TABLE.

  "! Loads a file and returns it in a string format
  "! @parameter result | File as string
  METHODS get_file_string
    RETURNING VALUE(result) TYPE string.

  "! Loads a file and returns it in a raw format
  "! @parameter result | File as xstring
  METHODS get_file_xstring
    RETURNING VALUE(result) TYPE xstring.
ENDINTERFACE.
