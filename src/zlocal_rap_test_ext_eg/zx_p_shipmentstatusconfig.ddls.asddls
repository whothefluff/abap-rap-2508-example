extend view entity ZP_ShipmentStatus with
  {
    //    cast( _Extension.ZZIsActiveZEX as ZT_ShipmentStatusIsActive preserving type ) as ZZIsActiveZEX
    @EndUserText.label: 'Is Active' //shouldn't be necessary but what would SAP be without unfinished untested features
    _Extension.ZZIsActiveZEX as ZZIsActiveZEX
  }
