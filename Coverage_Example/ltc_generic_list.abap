CLASS ltc_generic_list DEFINITION FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PUBLIC SECTION.
    METHODS after_creation_list_is_empty FOR TESTING.
    METHODS add_increases_element_count FOR TESTING.
    METHODS index_of_returns_valid_index FOR TESTING.
    METHODS index_of_returns_invalid_index FOR TESTING.
    METHODS get_returns_expected_data FOR TESTING.
    METHODS first_returns_expected_data FOR TESTING.
    METHODS last_returns_expected_data FOR TESTING.
    METHODS remove_returns_true FOR TESTING.
    METHODS remove_returns_false FOR TESTING.
    METHODS remove_many_entries FOR TESTING.

  PRIVATE SECTION.
    DATA:
      mo_sut TYPE REF TO zcl_generic_list.

    METHODS setup.
    METHODS assert_true.
ENDCLASS.

CLASS ltc_generic_list IMPLEMENTATION.

  METHOD after_creation_list_is_empty.

    cl_abap_unit_assert=>assert_equals( exp = 0 act = mo_sut->count(  ) ).
    cl_abap_unit_assert=>assert_initial( mo_sut->first( ) ).
    cl_abap_unit_assert=>assert_initial( mo_sut->last( ) ).

  ENDMETHOD.

  METHOD add_increases_element_count.

    mo_sut->add_element( '1' ).
    mo_sut->add_element( '2' ).
    mo_sut->add_element( '3' ).
    mo_sut->add_element( '4' ).
    mo_sut->add_element( '5' ).

    cl_abap_unit_assert=>assert_equals( exp = 5 act = mo_sut->count(  ) ).

  ENDMETHOD.

  METHOD index_of_returns_valid_index.

    " arrange
    mo_sut->add_element( '1' ).
    mo_sut->add_element( '2' ).
    mo_sut->add_element( '3' ).
    mo_sut->add_element( '4' ).
    mo_sut->add_element( '5' ).

    " act + assert
    cl_abap_unit_assert=>assert_equals( exp = 0 act = mo_sut->index_of( '1' ) ).
    cl_abap_unit_assert=>assert_equals( exp = 1 act = mo_sut->index_of( '2' ) ).
    cl_abap_unit_assert=>assert_equals( exp = 2 act = mo_sut->index_of( '3' ) ).
    cl_abap_unit_assert=>assert_equals( exp = 3 act = mo_sut->index_of( '4' ) ).
    cl_abap_unit_assert=>assert_equals( exp = 4 act = mo_sut->index_of( '5' ) ).

  ENDMETHOD.

  METHOD index_of_returns_invalid_index.

    " act + assert
    cl_abap_unit_assert=>assert_equals( exp = -1 act = mo_sut->index_of( '1' ) ).

  ENDMETHOD.

  METHOD get_returns_expected_data.

    " arrange
    mo_sut->add_element( '1' ).
    mo_sut->add_element( '2' ).
    mo_sut->add_element( '3' ).
    mo_sut->add_element( '4' ).
    mo_sut->add_element( '5' ).

    " act
    DATA(actual_data) = mo_sut->get_element( 2 ).

    " assert
    cl_abap_unit_assert=>assert_equals( exp = '3' act = actual_data ).

  ENDMETHOD.

  METHOD first_returns_expected_data.

    " arrange
    mo_sut->add_element( '1' ).
    mo_sut->add_element( '2' ).
    mo_sut->add_element( '3' ).
    mo_sut->add_element( '4' ).
    mo_sut->add_element( '5' ).

    " act
    DATA(actual_data) = mo_sut->first( ).

    " assert
    cl_abap_unit_assert=>assert_equals( exp = '1' act = actual_data ).

  ENDMETHOD.

  METHOD last_returns_expected_data.

    " arrange
    mo_sut->add_element( '1' ).
    mo_sut->add_element( '2' ).
    mo_sut->add_element( '3' ).
    mo_sut->add_element( '4' ).
    mo_sut->add_element( '5' ).

    " act
    DATA(actual_data) = mo_sut->last( ).

    " assert
    cl_abap_unit_assert=>assert_equals( exp = '5' act = actual_data ).

  ENDMETHOD.

  METHOD remove_returns_true.

    " arrange
    mo_sut->add_element( '1' ).

    " act
    DATA(v_result) = mo_sut->remove_element( '1' ).

    " assert
    cl_abap_unit_assert=>assert_true( v_result ).
    cl_abap_unit_assert=>assert_initial( mo_sut->get_element( 0 ) ).
    cl_abap_unit_assert=>assert_equals( exp = 0 act = mo_sut->count(  ) ).

  ENDMETHOD.

  METHOD remove_returns_false.

    " act
    DATA(v_result) = mo_sut->remove_element( '1' ).

    " assert
    cl_abap_unit_assert=>assert_false( v_result ).

  ENDMETHOD.

  METHOD remove_many_entries.

    " arrange
    mo_sut->add_element( '1' ).
    mo_sut->add_element( '2' ).
    mo_sut->add_element( '3' ).
    mo_sut->add_element( '4' ).
    mo_sut->add_element( '5' ).

    " assert
    cl_abap_unit_assert=>assert_equals( exp = 5 act = mo_sut->count(  ) ).
    cl_abap_unit_assert=>assert_equals( exp = '1' act = mo_sut->first( ) ).
    cl_abap_unit_assert=>assert_equals( exp = '5' act = mo_sut->last( ) ).

    " act
    mo_sut->remove_element( '1' ).
    mo_sut->remove_element( '5' ).

    " assert
    cl_abap_unit_assert=>assert_equals( exp = 3 act = mo_sut->count(  ) ).
    cl_abap_unit_assert=>assert_equals( exp = '2' act = mo_sut->first( ) ).
    cl_abap_unit_assert=>assert_equals( exp = '4' act = mo_sut->last( ) ).

    " act
    mo_sut->remove_element( '2' ).
    mo_sut->remove_element( '4' ).

    " assert
    cl_abap_unit_assert=>assert_equals( exp = 1 act = mo_sut->count(  ) ).
    cl_abap_unit_assert=>assert_equals( exp = '3' act = mo_sut->first( ) ).
    cl_abap_unit_assert=>assert_equals( exp = '3' act = mo_sut->last( ) ).

    " act
    mo_sut->remove_element( '3' ).

    " assert
    cl_abap_unit_assert=>assert_equals( exp = 0 act = mo_sut->count(  ) ).
    cl_abap_unit_assert=>assert_initial( mo_sut->first( ) ).
    cl_abap_unit_assert=>assert_initial( mo_sut->last( ) ).

  ENDMETHOD.

  METHOD setup.
    mo_sut = NEW zcl_generic_list( ).
  ENDMETHOD.

  METHOD assert_true.

  ENDMETHOD.

ENDCLASS.
