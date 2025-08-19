@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Travel - Interface Entity'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZDD_I_TRAVEL_SC
  provider contract transactional_interface
  as projection on ZDD_R_TRAVEL_SC
{
  key TravelUuid,
      TravelId,
      AgencyId,
      CustomerId,
      BeginDate,
      EndDate,

      @Semantics.amount.currencyCode: 'CurrencyCode'
      BookingFee,

      @Semantics.amount.currencyCode: 'CurrencyCode'
      TotalPrice,

      CurrencyCode,
      Description,
      OverallStatus,

      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      LocalLocalCreatedAt,


      @Semantics.systemDateTime.lastChangedAt: true
      LastChangedAt,


      /* Associations */
      _Agency,
      _Booking : redirected to composition child ZDD_I_BOOKING_SC,
      _Currency,
      _Customer,
      _OverallStatus
}
