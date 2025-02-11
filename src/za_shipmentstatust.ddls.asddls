@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Shipment Status Texts'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZA_ShipmentStatusT
  as projection on ZI_ShipmentStatusT
  {
    key Language,
    key ID,
    CreatedBy,
    CreatedAt,
    LastChangedBy,
    LastChangedAt,
    Description,
    _up: redirected to parent ZA_ShipmentStatus,
    _Language
  }
