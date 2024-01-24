CLASS zcl_generic_list DEFINITION PUBLIC.
  PUBLIC SECTION.
    METHODS:
      constructor,
      add_element IMPORTING p_data TYPE string,
      first RETURNING VALUE(rv_data) TYPE string,
      last RETURNING VALUE(rv_data) TYPE string,
      get_element IMPORTING p_index TYPE i RETURNING VALUE(rv_data) TYPE string,
      remove_element IMPORTING p_data TYPE string RETURNING VALUE(rv_success) TYPE abap_bool,
      index_of IMPORTING p_data TYPE string RETURNING VALUE(rv_index) TYPE i,
      count RETURNING VALUE(rv_count) TYPE i.
  PRIVATE SECTION.
    TYPES:
      BEGIN OF ty_node,
        first TYPE REF TO lcl_node,
        last  TYPE REF TO lcl_node,
        count TYPE i,
      END OF ty_node.

    DATA:
      ms_node TYPE ty_node.
ENDCLASS.



CLASS ZCL_GENERIC_LIST IMPLEMENTATION.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_GENERIC_LIST->CONSTRUCTOR
* +-------------------------------------------------------------------------------------------------+
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD constructor.
    CLEAR ms_node-first.
    CLEAR ms_node-last.
    ms_node-count = 0.
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_GENERIC_LIST->ADD_ELEMENT
* +-------------------------------------------------------------------------------------------------+
* | [--->] P_DATA                         TYPE        STRING
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD add_element.
    DATA(lt_new_node) = NEW lcl_node( p_data ).

    IF ms_node-count = 0.
      ms_node-first = lt_new_node.
      ms_node-last = lt_new_node.
    ENDIF.

    ms_node-last->set_next( lt_new_node ).
    ms_node-last = lt_new_node.
    ms_node-count += 1.
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_GENERIC_LIST->GET_ELEMENT
* +-------------------------------------------------------------------------------------------------+
* | [--->] P_INDEX                        TYPE        I
* | [<-()] RV_DATA                        TYPE        STRING
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD get_element.
    DATA(lv_index) = 0.
    DATA(lt_current_node) = ms_node-first.

    WHILE lt_current_node IS NOT INITIAL AND lv_index < p_index.
      lt_current_node = lt_current_node->get_next(  ).
      lv_index += 1.
    ENDWHILE.

    IF lt_current_node IS NOT INITIAL AND lv_index = p_index.
      rv_data = lt_current_node->get_data(  ).
    ENDIF.
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_GENERIC_LIST->FIRST
* +-------------------------------------------------------------------------------------------------+
* | [<-()] RV_DATA                        TYPE        STRING
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD first.
    IF ms_node-first IS INITIAL.
      RETURN.
    ENDIF.

    DATA(lv_data) = ms_node-first->get_data( ).
    DATA(v_index) = index_of( lv_data ).
    IF ( 0 <= v_index AND v_index < ms_node-count ).
      rv_data = get_element( v_index ).
    ENDIF.
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_GENERIC_LIST->LAST
* +-------------------------------------------------------------------------------------------------+
* | [<-()] RV_DATA                        TYPE        STRING
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD last.
    IF ms_node-last IS INITIAL.
      RETURN.
    ENDIF.
    DATA(v_index) = index_of( ms_node-last->get_data( ) ).
    IF ( 0 <= v_index AND v_index < ms_node-count ).
      rv_data = get_element( v_index ).
    ENDIF.
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_GENERIC_LIST->INDEX_OF
* +-------------------------------------------------------------------------------------------------+
* | [--->] P_DATA                         TYPE        STRING
* | [<-()] RV_INDEX                       TYPE        I
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD index_of.
    DATA(lt_current_node) = ms_node-first.
    DATA(lv_index) = 0.

    WHILE lt_current_node IS NOT INITIAL AND NOT lt_current_node->data_is_equal( p_data ).
      lt_current_node = lt_current_node->get_next(  ).
      lv_index += 1.
    ENDWHILE.

    IF lt_current_node IS NOT INITIAL AND lt_current_node->data_is_equal( p_data ).
      rv_index = lv_index.
    ELSE.
      " Element not found
      rv_index = -1.
    ENDIF.
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_GENERIC_LIST->REMOVE_ELEMENT
* +-------------------------------------------------------------------------------------------------+
* | [--->] P_DATA                         TYPE        STRING
* | [<-()] RV_SUCCESS                     TYPE        ABAP_BOOL
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD remove_element.
    DATA(lt_current_node) = ms_node-first.
    DATA lt_previous_node TYPE REF TO lcl_node.
    DATA(lv_index) = 0.

    WHILE lt_current_node IS NOT INITIAL AND NOT lt_current_node->data_is_equal( p_data ).
      lt_previous_node = lt_current_node.
      lt_current_node = lt_current_node->get_next(  ).
      lv_index += 1.
    ENDWHILE.

    IF lt_current_node IS NOT INITIAL AND lt_current_node->data_is_equal( p_data ).
      " Element found, remove it
      IF lt_previous_node IS INITIAL.
        " last Element, re-initialize this instance
        IF lt_current_node = ms_node-last.
          CLEAR ms_node-first.
          CLEAR ms_node-last.
          "ms_node-count = 0.
        ELSE.
          " Removing the first element
          ms_node-first = lt_current_node->get_next(  ).
        ENDIF.
      ELSE.
        " Removing a middle or last element
        lt_previous_node->set_next( lt_current_node->get_next(  ) ).
        IF lt_current_node = ms_node-last.
          ms_node-last = lt_previous_node.
        ENDIF.
      ENDIF.

      ms_node-count -= 1.
      rv_success = abap_true.
    ELSE.
      rv_success = abap_false.
    ENDIF.
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_GENERIC_LIST->COUNT
* +-------------------------------------------------------------------------------------------------+
* | [<-()] RV_COUNT                       TYPE        I
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD count.
    rv_count = ms_node-count.
  ENDMETHOD.
ENDCLASS.