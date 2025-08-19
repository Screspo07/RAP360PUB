@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Booking - Consumption Entity'
@Metadata.ignorePropagatedAnnotations: true

@Metadata.allowExtensions: true
@Search.searchable: true

define view entity ZDD_C_BOOKING_SC
  as projection on ZDD_R_BOOKING_SC
{
  key BookingUUID,
      TravelUUID,

      @Search.defaultSearchElement: true
      BookingID,
      BookingDate,

      @ObjectModel.text.element: [ 'CustomerName' ]
      @Consumption.valueHelpDefinition: [{ entity: {name: '/DMO/I_Customer_StdVH',
                                                    element: 'CustomerID'},
                                         //Ayuda para comporbar que el valor exista
                                          useForValidation: true }]
      CustomerID,
      _Customer.LastName        as CustomerName,
      //Campos conectados / uno depende del otro
      @Search.defaultSearchElement: true
      @ObjectModel.text.element: [ 'CustomerName' ]
      @Consumption.valueHelpDefinition: [{ entity: {name: '/DMO/I_Flight_StdVH',
                                                  element: 'ConnectionID'},
                                                  //Adicion para relacionar campos
                                                  additionalBinding: [{ localElement: 'FlightDate',
                                                  element: 'FlightDate',
                                                  //Tipo de coneccion / obtenemos resultados
                                                  usage: #RESULT },

                                                  { localElement: 'ConnectionId',
                                                  element: 'ConnectionID',
                                                  //Tipo de coneccion / obtenemos resultados
                                                  usage: #RESULT },

                                                   { localElement: 'FlightPrice',
                                                  element: 'Price',
                                                  //Tipo de coneccion / obtenemos resultados
                                                  usage: #RESULT },

                                                    { localElement: 'CurrencyCode',
                                                  element: 'CurrencyCode',
                                                  //Tipo de coneccion / obtenemos resultados
                                                  usage: #RESULT }
                                                  ],
                                                  //Ayuda para comporbar que el valor exista
                                                  useForValidation: true }]
      AirlrneID,
      _Carrier.Name             as CarrierName,

      @Consumption.valueHelpDefinition: [{ entity: {name: '/DMO/I_Flight_StdVH',
                                                  element: 'ConnectionId'},
                                                  //Adicion para relacionar campos
                                                  additionalBinding: [{ localElement: 'AirlrneID',
                                                  element: 'AirlineID',
                                                  //Tipo de coneccion / obtenemos filtro y resultados
                                                  usage: #FILTER_AND_RESULT },

                                                  { localElement: 'FlightDate',
                                                  element: 'FlightDate',
                                                  //Tipo de coneccion / obtenemos resultados
                                                  usage: #RESULT },

                                                   { localElement: 'FlightPrice',
                                                  element: 'Price',
                                                  //Tipo de coneccion / obtenemos resultados
                                                  usage: #RESULT },

                                                    { localElement: 'CurrencyCode',
                                                  element: 'CurrencyCode',
                                                  //Tipo de coneccion / obtenemos resultados
                                                  usage: #RESULT }
                                                  ],
                                                  //Ayuda para comporbar que el valor exista
                                                  useForValidation: true }]
      ConnectionId,

      @Consumption.valueHelpDefinition: [{ entity: {name: '/DMO/I_Flight_StdVH',
                                             element: 'FlightDate'},
                                             //Adicion para relacionar campos
                                             additionalBinding: [{ localElement: 'AirlrneID',
                                             element: 'AirlineID',
                                             //Tipo de coneccion / obtenemos filtro y resultados
                                             usage: #FILTER_AND_RESULT },

                                             { localElement: 'ConnectionId',
                                             element: 'ConnectionID',
                                             //Tipo de coneccion / obtenemos resultados
                                             usage: #FILTER_AND_RESULT },

                                              { localElement: 'FlightPrice',
                                             element: 'Price',
                                             //Tipo de coneccion / obtenemos resultados
                                             usage: #RESULT },

                                               { localElement: 'CurrencyCode',
                                             element: 'CurrencyCode',
                                             //Tipo de coneccion / obtenemos resultados
                                             usage: #RESULT }
                                             ],
                                             //Ayuda para comporbar que el valor exista
                                             useForValidation: true }]
      FlightDate,
      //

      @Semantics.amount.currencyCode: 'CurrencyCode'
      FlightPrice,

      @Consumption.valueHelpDefinition: [{ entity: {name: 'I_CurrencyStdVH',
                                                    element: 'Currency'},
                                         //Ayuda para comporbar que el valor exista
                                          useForValidation: true }]
      CurrencyCode,

      @ObjectModel.text.element: [ 'BookingStatus' ]
      @Consumption.valueHelpDefinition: [{ entity: {name: '/DMO/I_Booking_Status_VH',
                                                    element: 'BookingStatus'},
                                         //Ayuda para comporbar que el valor exista
                                          useForValidation: true }]
      BookingStatus,
      //Forma 2 de solucionar el problema de la cardinalidad al agregar el LOCALIZED
      _BookingStatus._Text.Text as BookingStatusText : localized,
      LocalLastChangedAt,
      /* Associations */
      _BookingStatus,
      _BookingSupplement : redirected to composition child ZDD_C_BKSUPPL_SC,
      _Carrier,
      _Connection,
      _Customer,
      _Travel            : redirected to parent ZDD_C_TRAVEL_SC
}
