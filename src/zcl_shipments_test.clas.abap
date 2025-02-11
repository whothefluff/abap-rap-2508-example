class zcl_shipments_test definition
                         public
                         final
                         create public.

  public section.

    interfaces: if_oo_adt_classrun.

  protected section.

endclass.
class zcl_shipments_test implementation.

  method if_oo_adt_classrun~main.

    read entities of ZA_ShipmentStatus
      entity ShipmentStatus
        execute GetFromNaturalId
          from value #( ( %param = value #( NaturalId = 1 ) ) )
          request value #( ID = if_abap_behv=>mk-on )
          result final(result).

    modify entities of ZA_ShipmentStatus
      entity ShipmentStatus
        delete from value #( for <r> in result
                             ( %tky-ID = <r>-%param-%tky-ID ) ) ##EML_FAILED_MISSING_OK.

    commit entities. if sy-subrc eq 0.endif. "worthless patronizing check

    modify entities of ZA_ShipmentStatus
      entity ShipmentStatus
        create fields ( NaturalId LocalizedDescription )
          auto fill cid
          with value #( ( %data = value #( NaturalId = 1
                                           LocalizedDescription = 'Draf' ) ) ) ##NO_TEXT
      mapped final(mapped_c)
      failed final(failed_c)
      reported final(reported_c).

*    modify entities of ZA_ShipmentStatus
*      entity ShipmentStatus
*        create fields ( NaturalId LocalizedDescription )
*          with value #( ( %cid = `testing`
*                          %data = value #( NaturalId = 1
*                                           LocalizedDescription = 'Draf' ) ) ) ##NO_TEXT
*        update fields ( LocalizedDescription )
*          with value #( ( %cid_ref = `testing`
*                          %data = value #( LocalizedDescription = 'Draft' ) ) ) ##NO_TEXT
*      mapped final(mapped_c)
*      failed final(failed_c)
*      reported final(reported_c).

    commit entities.

    if sy-subrc eq 0.

      out->write( mapped_c ).

      modify entities of ZA_ShipmentStatus
        entity ShipmentStatus
          update fields ( LocalizedDescription )
            with value #( ( %data = value #( %key = mapped_c-ShipmentStatus[ 1 ]-%tky-%key
                                             LocalizedDescription = 'Draft' ) ) ) ##NO_TEXT
        mapped final(mapped_u)
        failed final(failed_u)
        reported final(reported_u).

      commit entities.

      if sy-subrc eq 0.

        out->write( mapped_u ).

      else.

        out->write( failed_u ).

      endif.

    else.

      out->write( failed_c ).

    endif.

  endmethod.

endclass.
