class lsc_ZP_ShipmentStatus definition ##CLASS_FINAL
                            inheriting from cl_abap_behavior_saver.

  protected section.

    methods save_modified redefinition.

endclass.

class lsc_ZP_ShipmentStatus implementation.

  method save_modified.

    raise entity event ZP_ShipmentStatus~Deleted
      from corresponding #( delete-ShipmentStatus ).

  endmethod.

endclass.

class lhc_ShipmentStatus definition ##CLASS_FINAL
                         inheriting from cl_abap_behavior_handler .

  private section.

    methods get_instance_features for instance features
              importing
                keys request requested_features for ShipmentStatus
              result
                result ##NEEDED.

    methods get_instance_authorizations for instance authorization
              importing
                keys request requested_authorizations for ShipmentStatus
              result
                resulT ##NEEDED.

    methods precheck_create for precheck
              importing
                entities for create ShipmentStatus.

    methods GetFromNaturalId for read
              importing
                keys for function ShipmentStatus~GetFromNaturalId
              request
                requested_fields
              result
                result.

    methods precheck_delete for precheck
              importing
                keys for delete ShipmentStatus ##NEEDED.

endclass.
class lhc_ShipmentStatus implementation.

  method get_instance_features.

    return.

  endmethod.
  method get_instance_authorizations.

    return.

  endmethod.
  method precheck_create.

    types existing_nat_ids type hashed table of ZP_ShipmentStatus-NaturalId with unique key table_line.

    read entities of ZP_ShipmentStatus in local mode
      entity ShipmentStatus
        execute GetFromNaturalId
        from corresponding #( entities
                              mapping %param = %data
                                      %cid = %cid )
        request value #( NaturalId = if_abap_behv=>mk-on )
      result final(funct_result)
      failed final(funct_failed)
      reported final(funct_reported) ##EML_READ_IN_LOCAL_MODE_OK.

    final(existing_nat_ids) = value existing_nat_ids( for <r> in funct_result "where ( %param-%is_draft eq if_abap_behv=>mk-off )
                                                      ( <r>-%param-%data-NaturalId ) ).

    final(existing_entities) = filter #( entities in existing_nat_ids where %data-NaturalId eq table_line ).

                                     "first add all problems that might have occurred in the function EXCEPT for when the entity doesn't exist, as that is a good scenario
    failed-ShipmentStatus = value #( ( lines of value #( for <f> in funct_failed-ShipmentStatus where ( not ( %fail-cause eq if_abap_behv=>cause-not_found ) )
                                                         ( <f> ) ) )
                                     "then add what we are actually checking: duplicated values of the id
                                     ( lines of value #( for <e> in existing_entities
                                                         ( %op = value #( %create = if_abap_behv=>mk-on )
                                                           %tky = value #( %is_draft = <e>-%is_draft
                                                                           %pky = value #( %key = <e>-%key ) )
                                                           %cid = <e>-%cid ) ) ) ).

    reported-ShipmentStatus = value #( ( lines of funct_reported-ShipmentStatus )
                                       ( lines of value #( for <e> in existing_entities
                                                           ( %op = value #( %create = if_abap_behv=>mk-on
                                                                            %element = value #( %field = value #( NaturalId = if_abap_behv=>mk-on ) ) )
                                                             %tky = value #( %is_draft = <e>-%is_draft
                                                                             %pky = value #( %key = <e>-%key ) )
                                                             %cid = <e>-%cid
*                                                             %msg = new zcl_cp_text_symbol_message( i_text_symbol = 'This Natural ID already exists'(001)
*                                                                                                    i_type = zcl_cp_message_type_fty=>error )
                                                             %state_area = `duplicateNaturalId` ) ) ) ).

  endmethod.
  method GetFromNaturalId.

    types: sigh like line of keys,
           jesus_christ_already type sigh-%param,
           not_completely_useless_param type standard table of jesus_christ_already with empty key.

    types: begin of partial_key,
             id type ZP_ShipmentStatus-ID,
             natural_id type ZP_ShipmentStatus-NaturalId,
           end of partial_key,
           partial_keys type hashed table of partial_key with unique key natural_id.

    types: begin of full_key,
             id type ZP_ShipmentStatus-ID,
             natural_id type ZP_ShipmentStatus-NaturalId,
             cid type abp_behv_cid,
           end of full_key,
           full_keys type hashed table of full_key with unique key id.

    final(heeeeeeeeeeeeeeeeeelp) = corresponding not_completely_useless_param( keys mapping ( table_line = %param mapping NaturalId = NaturalId ) ).

    data(found_keys_aux) = value partial_keys( ).

    select ShipmentStatus~ID,
           ShipmentStatus~NaturalId
      from @heeeeeeeeeeeeeeeeeelp as keys
      inner join ZP_ShipmentStatus as ShipmentStatus
        on keys~NaturalId eq ShipmentStatus~NaturalId
      into table @found_keys_aux.

    final(not_found_keys) = value full_keys( for <k> in filter #( keys except in found_keys_aux where %param-NaturalId eq natural_id )
                                             ( id = value #( )
                                               natural_id = <k>-%param-NaturalId
                                               cid = <k>-%cid ) ).

    final(found_keys) = value full_keys( for <k> in filter #( keys in found_keys_aux where %param-NaturalId eq natural_id )
                                         ( value #( id = found_keys_aux[ natural_id = <k>-%param-NaturalId ]-id
                                                    natural_id = <k>-%param-NaturalId
                                                    cid = <k>-%cid ) ) ).

    read entities of ZP_ShipmentStatus in local mode
      entity ShipmentStatus
        from value #( for <fk> in found_keys
                      ( %tky = value #( ID = <fk>-id )
                        %control = corresponding #( requested_fields ) ) )
      result final(found_entities)
      failed failed.

    result = value #( for <e> in found_entities
                      ( %cid = found_keys[ id = <e>-%data-ID ]-cid
                        %param = <e> ) ).

    failed-ShipmentStatus = value #( base failed-ShipmentStatus
                                     for k in not_found_keys
                                     ( %cid = k-cid
                                       %op = value #( %action = value #( GetFromNaturalId = if_abap_behv=>mk-on ) )
                                       %fail = value #( cause = if_abap_behv=>cause-not_found ) ) ).

  endmethod.
  method precheck_delete.

    return. "Forbid deletion if still used in certain tables

  endmethod.

endclass.
