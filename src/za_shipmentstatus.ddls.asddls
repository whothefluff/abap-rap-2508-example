@AbapCatalog: {
  entityBuffer.propagationAllowed: true,
  extensibility: {
    allowNewCompositions: true,
    dataSources: [ 'ZI_ShipmentStatus' ],
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
@Metadata.allowExtensions: true
@Search.searchable: true
define root view entity ZA_ShipmentStatus
  provider contract transactional_query
  as projection on ZI_ShipmentStatus as ZI_ShipmentStatus
  {
    key ID,
    NaturalId,
    LocalCreatedBy,
    LocalCreatedAt,
    LocalLastChangedBy,
    LocalLastChangedAt,
    TotalLastChangedAt,
    _Texts.Description as LocalizedDescription: localized,
    _Extension,
    _Texts: redirected to composition child ZA_ShipmentStatusT
  }
