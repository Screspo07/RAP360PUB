@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Clientes Libros'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZCDS_CLIEN_Lib_SC
  as select from ztb_clien_lib_sc
{

  key id_libro                    as IdLibro,
      count( distinct id_cliente) as ventas
}
group by
  id_libro;
