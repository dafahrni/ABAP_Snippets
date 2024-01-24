CLASS lcl_node DEFINITION.
  PUBLIC SECTION.
    METHODS:
      constructor IMPORTING p_data TYPE string,
      get_data RETURNING VALUE(rv_data) TYPE string,
      data_is_equal IMPORTING p_data TYPE string RETURNING VALUE(rv_flag) TYPE abap_bool,
      set_next IMPORTING p_next TYPE REF TO lcl_node,
      get_next RETURNING VALUE(rv_next) TYPE REF TO lcl_node.

  PRIVATE SECTION.
    TYPES:
      BEGIN OF ty_node,
        data TYPE string,
        next TYPE REF TO lcl_node,
      END OF ty_node.

    DATA:
      ms_node TYPE ty_node.
ENDCLASS.
  
CLASS lcl_node IMPLEMENTATION.
  METHOD constructor.
    ms_node-data = p_data.
  ENDMETHOD.

  METHOD get_data.
    rv_data = ms_node-data.
  ENDMETHOD.

  METHOD data_is_equal.
    IF ms_node-data = p_data.
      rv_flag = abap_true.
    ELSE.
      rv_flag = abap_false.
    ENDIF.
  ENDMETHOD.

  METHOD set_next.
    ms_node-next = p_next.
  ENDMETHOD.

  METHOD get_next.
    rv_next = ms_node-next.
  ENDMETHOD.
ENDCLASS.
