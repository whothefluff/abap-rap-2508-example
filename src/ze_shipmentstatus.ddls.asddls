@AbapCatalog: {
  extensibility: {
    dataSources: [ 'zashpmt_sta' ],
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
@EndUserText.label: 'Shipment Status Includes'
define view entity ZE_ShipmentStatus
  as select from zashpmt_sta as zashpmt_sta
  {
    key id as ID
  }
