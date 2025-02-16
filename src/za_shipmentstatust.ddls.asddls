@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Shipment Status Texts'
@Metadata.allowExtensions: true
@Search.searchable: true
define view entity ZA_ShipmentStatusT
  as projection on ZI_ShipmentStatusT
  {
    @Consumption.valueHelpDefinition: [{
      entity: {
        name: 'I_Language',
        element: 'Language'
      },
      useForValidation: true
    }]
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
