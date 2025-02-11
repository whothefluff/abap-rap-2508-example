@AbapCatalog.entityBuffer.definitionAllowed: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Shipment Status Texts'
define view entity ZP_ShipmentStatusT
  as select from zashpmt_stat
  association to parent ZP_ShipmentStatus as _up
    on $projection.ID = _up.ID
  association [0..1] to I_Language as _Language
    on $projection.Language = _Language.Language
  {
    key language as Language,
    key cast( id as z_shipment_status preserving type ) as ID,
    @Semantics.user.createdBy: true
    created_by as CreatedBy,
    @Semantics.systemDateTime.createdAt: true
    created_at as CreatedAt,
    @Semantics.user.localInstanceLastChangedBy: true
    last_changed_by as LastChangedBy,
    @Semantics.systemDateTime.localInstanceLastChangedAt: true
    last_changed_at as LastChangedAt,
    description as Description,
    _up,
    _Language
  }
