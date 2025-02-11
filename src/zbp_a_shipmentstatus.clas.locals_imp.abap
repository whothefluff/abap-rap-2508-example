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

    types new_entities_text type table for create ZI_ShipmentStatus\\ShipmentStatus\_Texts.

    types old_entities_new_text type table for update ZI_ShipmentStatus\\ShipmentStatusTexts.

    types creating_text type table for create ZI_ShipmentStatus\\ShipmentStatus\_Texts.

    types: read_text_result_dummy type structure for read result ZI_ShipmentStatus\\ShipmentStatus\_Texts,
           text_tky type read_text_result_dummy-%tky.

    if create_entities is not initial.

      data(create_rel) = value abp_behv_relating_tab( ).

      data(new_entities_text) = value new_entities_text( ).

      loop at create_entities reference into final(c_e).

        create_rel = value #( base create_rel
                              ( sy-tabix ) ).

        new_entities_text = value #( base new_entities_text
                                     ( %cid_ref = c_e->*-%cid
                                       %tky = value #( %is_draft = c_e->*-%is_draft
                                                       %pky = value #( %key = value #( id = c_e->*-%key-id ) ) )
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

      read entities of ZI_ShipmentStatus
        entity ShipmentStatus
          by \_Texts
            from corresponding #( update_entities )
            link final(existing_status_link).

      data(old_entities_new_text) = value old_entities_new_text( ).

      data(old_entities_new_text_rel) = value abp_behv_relating_tab( ).

      data(creating_text) = value creating_text( ).

      data(creating_text_rel) = value abp_behv_relating_tab( ).

      loop at update_entities reference into final(u_e).

        if u_e->*-%control-LocalizedDescription eq if_abap_behv=>mk-on
           and line_exists( existing_status_link[ key entity
                                                  source-%tky-ID = u_e->*-%tky-ID ] ).

          final(row_no) = sy-tabix.

          final(text_tky) = value text_tky( %is_draft = u_e->*-%tky-%is_draft
                                            %key = value #( Language = sy-langu
                                                            ID = u_e->*-%tky-%key-ID ) ).

          "update existing text
          if line_exists( existing_status_link[ key draft
                                                source-%tky = corresponding #( u_e->*-%tky )
                                                target-%tky = text_tky ] ).

            old_entities_new_text = value #( base old_entities_new_text
                                             ( %tky = text_tky
                                               %cid_ref = u_e->*-%cid_ref
                                               Description = u_e->*-LocalizedDescription ) ).

            old_entities_new_text_rel = value #( base old_entities_new_text_rel
                                                 ( row_no ) ).

          "text is being created and modified in the same transaction
          "although this doesn't work because EML is a gigantic piece of unmitigated garbage full of useless bugs
          elseif line_exists( new_entities_text[ key cid
                                                 %cid_ref = u_e->*-%cid_ref ] ).

            old_entities_new_text = value #( base old_entities_new_text
                                             ( %tky = text_tky
                                               %cid_ref = new_entities_text[ key cid
                                                                             %cid_ref = u_e->*-%cid_ref ]-%target[ 1 ]-%cid
                                               description = u_e->*-LocalizedDescription ) ).

            old_entities_new_text_rel = value #( base old_entities_new_text_rel
                                                 ( row_no ) ).

          "new text
          else.

            creating_text = value #( base creating_text
                                     ( %tky = corresponding #( u_e->*-%tky )
                                       %cid_ref = u_e->*-%cid_ref
                                       %target = value #( ( %cid = |%cidShipmentStatusText{ row_no }|
                                                            %is_draft = u_e->*-%tky-%is_draft
                                                            Language = sy-langu
                                                            Description = u_e->*-LocalizedDescription ) ) ) ).

            creating_text_rel = value #( base creating_text_rel
                                         ( row_no ) ).
          endif.

        endif.

      endloop.

      if old_entities_new_text is not initial.

        modify augmenting entities of ZI_ShipmentStatus
          entity ShipmentStatusTexts
            update fields ( Description )
              with old_entities_new_text
              relating to update_entities by old_entities_new_text_rel.

      endif.

      if creating_text is not initial.

        modify augmenting entities of ZI_ShipmentStatus
          entity ShipmentStatus
            create by \_Texts
              fields ( Language Description )
              with creating_text
              relating to update_entities by creating_text_rel.

      endif.

    endif.

  endmethod.

endclass.
