@AbapCatalog: {
  extensibility: {
    dataSources: [ 'zdshpmt_sta' ],
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
@EndUserText.label: 'Shipment Status Draft'
define view entity ZP_ShipmentStatusD
  as select from zdshpmt_sta as zdshpmt_sta
  {
    key id as ID,
    naturalid as NaturalId,
    localcreatedby as LocalCreatedBy,
    localcreatedat as LocalCreatedAt,
    locallastchangedby as LocalLastChangedBy,
    locallastchangedat as LocalLastChangedAt,
    totallastchangedat as TotalLastChangedAt,
    draftentitycreationdatetime as DraftEntityCreationDateTime,
    draftentitylastchangedatetime as DraftEntityLastChangeDateTime,
    draftadministrativedatauuid as DraftAdministrativeDataUUID,
    draftentityoperationcode as DraftEntityOperationCode,
    hasactiveentity as HasActiveEntity,
    draftfieldchanges as DraftFieldChanges
  }
