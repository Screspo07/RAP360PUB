@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Booking Supplements - Consumption Entity'
@Metadata.ignorePropagatedAnnotations: true

@Metadata.allowExtensions: true
@Search.searchable: true

define view entity ZDD_C_BKSUPPL_SC
  as projection on ZDD_R_BKSUPPL_SC
{
  key BookSupplUUID,
      TravelUUID,
      BookingUUID,

      @Search.defaultSearchElement: true
      BookingSupplementId,

      @ObjectModel.text.element: [ 'SupplementDescription' ]
      @Consumption.valueHelpDefinition: [{ entity: {name: '/DMO/I_Supplement_StdVH',
                                                    element: 'SupplementID'},

                                           additionalBinding: [{ localElement: 'Price' ,
                                                                 element: 'Price',
                                                                 usage: #FILTER_AND_RESULT  },

                                                                 { localElement: 'CurrencyCode' ,
                                                                 element: 'CurrencyCode',
                                                                 usage:  #FILTER_AND_RESULT }],

                                         //Ayuda para comporbar que el valor exista
                                          useForValidation: true }]
      SupplementId,
      _SupplementText.Description as SupplementDescription : localized,

      @Semantics.amount.currencyCode: 'CurrencyCode'
      Price,
      @Consumption.valueHelpDefinition: [{ entity: {name: 'I_CurrencyStdVH',
                                                    element: 'Currency'},
                                         //Ayuda para comporbar que el valor exista
                                          useForValidation: true }]

      CurrencyCode,

      LocalLastChangedAt,
      /* Associations */
      _Booking : redirected to parent ZDD_C_BOOKING_SC,
      _Product,
      _SupplementText,
      _Travel  : redirected to ZDD_C_TRAVEL_SC
}
