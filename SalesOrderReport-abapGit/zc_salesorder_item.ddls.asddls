@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Sales Order Item - Projection View'
@Metadata.allowExtensions: true
@ObjectModel.usageType:{
  serviceQuality: #X,
  sizeCategory: #S,
  dataClass: #MIXED
}
define view entity ZC_SalesOrderItem
  provider contract transactional_query
  as projection on ZI_SalesOrderItem
{
  key SalesOrder,
  key SalesOrderItem,
      Material,
      ItemDescription,
      ItemCategory,
      Plant,
      StorageLocation,
      MaterialGroup,
      OrderQuantity,
      SalesUnit,
      NetPrice,
      NetValue,
      Currency,
      RejectionReason,

      // Associations
      _Header : redirected to parent ZC_SalesOrderHeader
}
