@AbapCatalog.sqlViewName: 'ZIVSALESORDIT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Sales Order Item - Interface View'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
  serviceQuality: #X,
  sizeCategory: #S,
  dataClass: #MIXED
}
define view entity ZI_SalesOrderItem
  as select from vbap

  association [1..1] to ZI_SalesOrderHeader as _Header
    on $projection.SalesOrder = _Header.SalesOrder
{
  key vbeln            as SalesOrder,
  key posnr            as SalesOrderItem,
      matnr             as Material,
      arktx             as ItemDescription,
      pstyv             as ItemCategory,
      werks             as Plant,
      lgort             as StorageLocation,
      matkl             as MaterialGroup,
      kwmeng            as OrderQuantity,
      vrkme             as SalesUnit,
      netpr             as NetPrice,
      netwr             as NetValue,
      waerk             as Currency,
      abgru             as RejectionReason,

      // Associations
      _Header
}
