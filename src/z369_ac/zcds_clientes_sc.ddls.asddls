@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Clientes'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Metadata.allowExtensions: true
define view entity ZCDS_CLIENTES_SC
  as select from ztb_clientes_sc  as Clientes
    inner join   ztb_clien_lib_sc as ClientesLibros on ClientesLibros.id_cliente = Clientes.id_cliente
{
  key  ClientesLibros.id_libro as IdLibro,
  key  Clientes.id_cliente     as IdCliente,
  key  Clientes.type_access    as TypeAccess,
       Clientes.nombre         as Nombre,
       Clientes.apellidos      as Apellidos,
       Clientes.email          as Email,
       Clientes.url            as Imagen
}
