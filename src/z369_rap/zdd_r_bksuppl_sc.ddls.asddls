@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Booking Supplements - Root Entity'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZDD_R_BKSUPPL_SC
  as select from ztb_bksuppl_sc

  association        to parent ZDD_R_BOOKING_SC as _Booking        on $projection.BookingUUID = _Booking.BookingUUID
  association [1..1] to ZDD_R_TRAVEL_SC         as _Travel         on $projection.TravelUUID = _Travel.TravelUuid

  association [1..1] to /DMO/I_Supplement       as _Product        on $projection.SupplementId = _Product.SupplementID
  association [1..*] to /DMO/I_SupplementText   as _SupplementText on $projection.SupplementId = _SupplementText.SupplementID

{
  key booksuppl_uuid        as BookSupplUUID,
      root_uuid             as TravelUUID,
      parent_uuid           as BookingUUID,

      booking_supplement_id as BookingSupplementId,
      supplement_id         as SupplementId,

      @Semantics.amount.currencyCode: 'CurrencyCode'
      price                 as Price,
      currency_code         as CurrencyCode,

      //Local ETag field
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      local_last_changed_at as LocalLastChangedAt,

      //Agregamos asociacion
      _Booking,
      _Travel,
      _Product,
      _SupplementText
}
