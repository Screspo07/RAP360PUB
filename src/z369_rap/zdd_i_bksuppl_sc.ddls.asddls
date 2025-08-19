@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Booking Supplements - Interface Entity'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZDD_I_BKSUPPL_SC
  as projection on ZDD_R_BKSUPPL_SC
{
  key BookSupplUUID,
      TravelUUID,
      BookingUUID,
      BookingSupplementId,
      SupplementId,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      Price,
      CurrencyCode,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      LocalLastChangedAt,
      /* Associations */
      _Booking : redirected to parent ZDD_I_BOOKING_SC,
      _Product,
      _SupplementText,
      _Travel  : redirected to ZDD_I_TRAVEL_SC
}
