@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Libros'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}

@Metadata.allowExtensions: true

define view entity zcds_libros_sc
  as select from    ztb_libros_sc     as libros
    inner join      ztb_categ_sc      as categoria on libros.bi_categ = categoria.bi_categ
    left outer join ZCDS_CLIEN_Lib_SC as ventas    on libros.id_libro = ventas.IdLibro
  association [0..*] to ZCDS_CLIENTES_SC as _Clientes on $projection.IdLibro = _Clientes.IdLibro
{
  key libros.id_libro       as IdLibro,
      libros.titulo         as Titulo,
      libros.bi_categ       as BiCateg,
      libros.autor          as Autor,
      libros.editorial      as Editorial,
      libros.idioma         as Idioma,
      libros.paginas        as Paginas,
      @Semantics.amount.currencyCode: 'moneda'
      libros.precio         as Precio,
      libros.moneda         as Moneda,

      case
        when ventas.ventas < 1 then 0
        when ventas.ventas = 1 then 1
        when ventas.ventas = 2 then 2
        when ventas.ventas > 2 then 3
        else 0
      end                   as ventas,

      categoria.descripcion as descripcion,
      libros.formato        as Formato,
      libros.url            as imageUrl,
      _Clientes

}
