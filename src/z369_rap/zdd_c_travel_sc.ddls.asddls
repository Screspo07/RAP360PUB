@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Travel - Consumption Entity'
@Metadata.ignorePropagatedAnnotations: true

@Metadata.allowExtensions: true
@Search.searchable: true

//entidad de capa de consumo
define root view entity ZDD_C_TRAVEL_SC
  provider contract transactional_query
  as projection on ZDD_R_TRAVEL_SC
{
  key TravelUuid,

      //Ayudas de busquedad
      @Search.defaultSearchElement: true
      TravelId,

      //Ayudas de busquedad
      @Search.defaultSearchElement: true
      //Vincular nombre al ID
      @ObjectModel.text.element: [ 'AgencyName' ]

      @Consumption.valueHelpDefinition: [{ entity: {name: '/DMO/I_Agency_StdVH',
                                                    element: 'AgencyID'},
                                         //Ayuda para comporbar que el valor exista
                                          useForValidation: true }]

      AgencyId,
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
      _Agency.Name              as AgencyName,

      //Ayudas de busquedad
      @Search.defaultSearchElement: true
      //Vincular nombre al ID
      @ObjectModel.text.element: [ 'CustomerName' ]

      @Consumption.valueHelpDefinition: [{ entity: {name: '/DMO/I_Customer_StdVH',
                                                    element: 'CustomerID'},
                                         //Ayuda para comporbar que el valor exista
                                          useForValidation: true }]
      CustomerId,
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
      _Customer.last_name       as CustomerName,

      BeginDate,
      EndDate,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      BookingFee,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      TotalPrice,

      @Consumption.valueHelpDefinition: [{ entity: {name: 'I_CurrencyStdVH',
                                                    element: 'Currency'},
                                         //Ayuda para comporbar que el valor exista
                                          useForValidation: true }]
      CurrencyCode,
      Description,

      @ObjectModel.text.element: [ 'OverallStatusText' ]
      @Consumption.valueHelpDefinition: [{ entity: {name: '/DMO/I_Overall_Status_VH',
                                                    element: 'OverallStatus'},
                                         //Ayuda para comporbar que el valor exista
                                          useForValidation: true }]
      OverallStatus,
      //Forma 2 de solucionar el problema de la cardinalidad al agregar el LOCALIZED
      _OverallStatus._Text.Text as OverallStatusText : localized,
      LocalCreatedBy,
      LocalCreatedAt,
      LocalLocalCreatedBy,
      LocalLocalCreatedAt,
      LastChangedAt,
      /* Associations */
      _Agency,
      _Booking : redirected to composition child ZDD_C_BOOKING_SC,
      _Currency,
      _Customer,
      _OverallStatus
}
