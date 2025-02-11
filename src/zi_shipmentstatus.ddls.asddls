@AbapCatalog: {
  extensibility: {
    allowNewCompositions: true,
    dataSources: [ 'ZP_ShipmentStatus' ],
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
define root view entity ZI_ShipmentStatus
  provider contract transactional_interface
  as projection on ZP_ShipmentStatus as ZP_ShipmentStatus
  {
    key ID,
    NaturalId,
    LocalCreatedBy,
    LocalCreatedAt,
    LocalLastChangedBy,
    LocalLastChangedAt,
    TotalLastChangedAt,
    _Extension,
    _Texts: redirected to composition child ZI_ShipmentStatusT
  }
