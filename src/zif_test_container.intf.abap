INTERFACE zif_test_container
  PUBLIC.

  "! Loads a JSON file and converts it to an internal table
  "! @parameter generic | Generic format
  METHODS get_json_data
    CHANGING generic TYPE any.

  "! Loads a XML file and converts it to an internal table
  "! @parameter generic | Generic format
  METHODS get_xml_data
    CHANGING generic TYPE any.

  "! Loads a file and returns it in a string format
  "! @parameter result | File as string
  METHODS get_file_string
    RETURNING VALUE(result) TYPE string.

  "! Loads a file and returns it in a raw format
  "! @parameter result | File as xstring
  METHODS get_file_xstring
    RETURNING VALUE(result) TYPE xstring.
ENDINTERFACE.
