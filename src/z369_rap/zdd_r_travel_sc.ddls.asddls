@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Travel - Root Entity'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZDD_R_TRAVEL_SC
  as select from ztb_travel_sc
  composition [0..*] of ZDD_R_BOOKING_SC         as _Booking

  association [0..1] to /DMO/I_Agency            as _Agency        on $projection.AgencyId = _Agency.AgencyID
  association [0..1] to /dmo/customer            as _Customer      on $projection.CustomerId = _Customer.customer_id

  //Forma uno de solucionar una cardinalidad de 1 a 1 cuando va de 0 a muchos
  // association [1..1] to /DMO/I_Overall_Status_VH_Text as _OverallStatus on  $projection.OverallStatus = _OverallStatus.OverallStatus
  //                                                                     and _OverallStatus.Language   = $session.system_language

  association [1..1] to /DMO/I_Overall_Status_VH as _OverallStatus on $projection.OverallStatus = _OverallStatus.OverallStatus

  association [0..1] to I_Currency               as _Currency      on $projection.CurrencyCode = _Currency.Currency

{

  key travel_uuid            as TravelUuid,
      travel_id              as TravelId,
      agency_id              as AgencyId,
      customer_id            as CustomerId,
      begin_date             as BeginDate,
      end_date               as EndDate,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      booking_fee            as BookingFee,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      total_price            as TotalPrice,
      currency_code          as CurrencyCode,
      description            as Description,
      overall_status         as OverallStatus,

      //Campos de auditoria
      @Semantics.user.createdBy: true
      local_created_by       as LocalCreatedBy,
      @Semantics.systemDateTime.createdAt: true
      local_created_at       as LocalCreatedAt,
      @Semantics.user.localInstanceLastChangedBy: true
      local_local_created_by as LocalLocalCreatedBy,

      //Local ETag field -> Odata Etag / Bloqueo
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      local_local_created_at as LocalLocalCreatedAt,

      //Total ETag field
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at        as LastChangedAt,

      //   _association_name // Make association public
      _Booking,
      _Agency,
      _Customer,
      _OverallStatus,
      _Currency
}
