@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Sales Order Header - Projection View'
@Metadata.allowExtensions: true
@ObjectModel.usageType:{
  serviceQuality: #X,
  sizeCategory: #S,
  dataClass: #MIXED
}
@Search.searchable: true
@UI: { headerInfo: { typeName: 'Sales Order', typeNamePlural: 'Sales Orders' } }
define root view entity ZC_SalesOrderHeader
  provider contract transactional_query
  as projection on ZI_SalesOrderHeader
{
  key SalesOrder,

      @Search.defaultSearchElement: true
      CreatedOn,
      CreatedBy,
      SalesOrderType,
      SalesOrganization,
      DistributionChannel,
      Division,
      SalesGroup,
      SalesOffice,
      SoldToParty,
      PurchaseOrderNumber,
      PurchaseOrderDate,
      DocumentDate,
      NetValue,
      Currency,

      // Associations
      _Item : redirected to ZC_SalesOrderItem
}
