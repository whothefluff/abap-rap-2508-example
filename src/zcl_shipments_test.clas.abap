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

    modify entities of ZA_ShipmentStatus
      entity ShipmentStatus
        create fields ( NaturalId LocalizedDescription )
        auto fill cid
        with value #( ( %data = value #( NaturalId = 1
                                         LocalizedDescription = 'Draft' ) ) )
        mapped final(mapped)
      failed final(failed)
      reported final(reported).

    commit entities.

    out->write( mapped ).

    out->write( failed ).

  endmethod.

endclass.
