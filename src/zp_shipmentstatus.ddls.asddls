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
@ObjectModel: {
  representativeKey: 'ID',
  semanticKey: [ 'NaturalId' ]
}
@Search.searchable: true
define root view entity ZP_ShipmentStatus
  as select from zashpmt_sta
  composition of exact one to many ZP_ShipmentStatusT as _Texts
  association of exact one to exact one ZE_ShipmentStatus as _Extension
    on $projection.ID = _Extension.ID
  {
    @ObjectModel.text.association: '_Texts'
    key cast( id as ZT_ShipmentStatusInternalId preserving type ) as ID,
    @Search: {
      defaultSearchElement: true,
      fuzzinessThreshold: 1,
      ranking: #MEDIUM
    }
    cast( natural_id as ZT_ShipmentStatusNaturalId preserving type ) as NaturalId,
    @Semantics.user.createdBy: true
    local_created_by as LocalCreatedBy,
    @Semantics.systemDateTime.createdAt: true
    local_created_at as LocalCreatedAt,
    @Semantics.user.localInstanceLastChangedBy: true
    local_last_changed_by as LocalLastChangedBy,
    @Semantics.systemDateTime.localInstanceLastChangedAt: true
    local_last_changed_at as LocalLastChangedAt,
    @Semantics.systemDateTime.lastChangedAt: true
    //    cast( total_last_changed_at as ZT_ShipmentStatusAggrChangedAt preserving type ) as TotalLastChangedAt,
    @EndUserText.label: 'Aggregate Changed On' //shouldn't be necessary but what would SAP be without unfinished untested features
    total_last_changed_at as TotalLastChangedAt,
    _Extension,
    _Texts
  }
