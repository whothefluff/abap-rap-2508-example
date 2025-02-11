@AbapCatalog.entityBuffer.definitionAllowed: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Shipment Status Texts'
define view entity ZI_ShipmentStatusT
  as projection on ZP_ShipmentStatusT
  {
    key Language,
    key ID,
    CreatedBy,
    CreatedAt,
    LastChangedBy,
    LastChangedAt,
    Description,
    _up: redirected to parent ZI_ShipmentStatus,
    _Language
  }
