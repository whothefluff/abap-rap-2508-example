class lhc_ShipmentStatus definition
                         inheriting from cl_abap_behavior_handler.

  private section.

    methods augment_create_update for modify
              importing
                create_entities for create ShipmentStatus
                update_entities for update ShipmentStatus.

endclass.
class lhc_shipmentstatus implementation.

  method augment_create_update.

    types new_entities_text type table for create ZI_ShipmentStatus\_Texts.

    if create_entities is not initial.

      data(create_rel) = value abp_behv_relating_tab( ).

      data(new_entities_text) = value new_entities_text( ).

      loop at create_entities reference into final(c_e).

        create_rel = value #( base create_rel
                              ( sy-tabix ) ).

        new_entities_text = value #( base new_entities_text
                                     ( %cid_ref = c_e->*-%cid
                                       %tky = value #( %is_draft = c_e->*-%is_draft
                                                       %pky = value #( %key = value #( ID = c_e->*-%key-id ) ) )
                                       %target = value #( ( %cid = |%cidShipmentStatusText{ sy-tabix }|
                                                            %is_draft = c_e->*-%is_draft
                                                            Language = sy-langu
                                                            Description = c_e->*-LocalizedDescription ) ) ) ).

      endloop.

      modify augmenting entities of ZI_ShipmentStatus
        entity ShipmentStatus
          create by \_Texts
            fields ( Language
                     Description )
            with new_entities_text
            relating to create_entities by create_rel.

    endif.

    if update_entities is not initial.

    endif.

  endmethod.

endclass.
