@AbapCatalog.entityBuffer.definitionAllowed: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Shipment Status Texts'
@ObjectModel: {
  dataCategory: #TEXT,
  representativeKey: 'ID',
  semanticKey: [ '_up.NaturalId' ]
}
@Search.searchable: true
define view entity ZP_ShipmentStatusT
  as select from zashpmt_stat
  association to parent ZP_ShipmentStatus as _up
    on $projection.ID = _up.ID
  association of many to exact one I_Language as _Language
    on $projection.Language = _Language.Language
  {
    @ObjectModel.foreignKey.association: '_Language'
    @Semantics.language: true
    key language as Language,
    key cast( id as ZT_ShipmentStatusInternalId preserving type ) as ID,
    @Semantics.user.createdBy: true
    created_by as CreatedBy,
    @Semantics.systemDateTime.createdAt: true
    created_at as CreatedAt,
    @Semantics.user.localInstanceLastChangedBy: true
    last_changed_by as LastChangedBy,
    @Semantics.systemDateTime.localInstanceLastChangedAt: true
    last_changed_at as LastChangedAt,
    @Search: {
      defaultSearchElement: true,
      fuzzinessThreshold: 1,
      ranking: #HIGH
    }
    @Semantics.text: true
    cast( description as ZT_ShipmentStatusDescription preserving type ) as Description,
    _up,
    _Language
  }
