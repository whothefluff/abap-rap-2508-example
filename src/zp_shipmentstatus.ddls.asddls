@AbapCatalog: {
  extensibility: {
    allowNewCompositions: true,
    dataSources: [ '_Extension' ],
    elementSuffix: 'ZEX',
    extensible: true,
    quota: {
      maximumBytes: 10000,
      maximumFields: 1000
    }
  },
  viewEnhancementCategory: [ #PROJECTION_LIST ]
}
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Shipment Status'
@Search.searchable: true
define root view entity ZP_ShipmentStatus
  as select from zashpmt_sta
  composition [0..*] of ZP_ShipmentStatusT as _Texts
  association [1] to ZE_ShipmentStatus as _Extension
    on $projection.ID = _Extension.ID
  {
    @ObjectModel.text.association: '_Texts'
    key id as ID,
    @Search: {
      defaultSearchElement: true,
      fuzzinessThreshold: 1,
      ranking: #MEDIUM
    }
    natural_id as NaturalId,
    @Semantics.user.createdBy: true
    local_created_by as LocalCreatedBy,
    @Semantics.systemDateTime.createdAt: true
    local_created_at as LocalCreatedAt,
    @Semantics.user.localInstanceLastChangedBy: true
    local_last_changed_by as LocalLastChangedBy,
    @Semantics.systemDateTime.localInstanceLastChangedAt: true
    local_last_changed_at as LocalLastChangedAt,
    @Semantics.systemDateTime.lastChangedAt: true
    total_last_changed_at as TotalLastChangedAt,
    _Extension,
    _Texts
  }
