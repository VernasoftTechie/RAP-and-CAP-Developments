@AbapCatalog.sqlViewName: 'ZIVSALESORDHD'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Sales Order Header - Interface View'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
  serviceQuality: #X,
  sizeCategory: #S,
  dataClass: #MIXED
}
define root view entity ZI_SalesOrderHeader
  as select from vbak

  association [0..*] to ZI_SalesOrderItem as _Item
    on $projection.SalesOrder = _Item.SalesOrder
{
  key vbeln            as SalesOrder,
      erdat             as CreatedOn,
      ernam             as CreatedBy,
      auart             as SalesOrderType,
      vkorg             as SalesOrganization,
      vtweg             as DistributionChannel,
      spart             as Division,
      vkgrp             as SalesGroup,
      vkbur             as SalesOffice,
      kunnr             as SoldToParty,
      bstnk             as PurchaseOrderNumber,
      bstdk             as PurchaseOrderDate,
      audat             as DocumentDate,
      netwr             as NetValue,
      waerk             as Currency,

      // Associations
      _Item
}
