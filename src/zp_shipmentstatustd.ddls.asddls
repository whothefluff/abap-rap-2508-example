@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Shipment Status Texts Draft'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
  serviceQuality: #X,
  sizeCategory: #S,
  dataClass: #MIXED
}
define view entity ZP_ShipmentStatusTD
  as select from zdshpmt_stat
  {
    key language as Language,
    key id as ID,
    createdby as CreatedBy,
    createdat as CreatedAt,
    lastchangedby as LastChangedBy,
    lastchangedat as LastChangedAt,
    description as Description,
    draftentitycreationdatetime as DraftEntityCreationDateTime,
    draftentitylastchangedatetime as DraftEntityLastChangeDateTime,
    draftadministrativedatauuid as DraftAdministrativeDataUUID,
    draftentityoperationcode as DraftEntityOperationCode,
    hasactiveentity as HasActiveEntity,
    draftfieldchanges as DraftFieldChanges
  }
