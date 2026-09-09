# Sales Order Report (RAP)

A read-only RAP (RESTful ABAP Programming) business object that reports on
Sales Order header (VBAK) and item (VBAP) data, with the sales order number
as the filter/input field.

## What this is

A standard **read-only, no-draft** RAP scenario: two CDS-based entities
(header and item) linked by an association, exposed as an OData V4 service.
No create/update/delete operations are defined, so VBAK/VBAP stay owned by
standard SAP logic — this BO only reads.

"Sales order as input" is implemented the RAP way: `SalesOrder` (VBELN) is
the key field on the header entity and is marked `@UI.selectionField`, so it
becomes a filter field on the Fiori Elements List Report — the user types a
sales order number (or a range) and the report shows the matching header,
with items available via the association/facet on the object page.

## Object list

| Object | Type | Purpose |
|---|---|---|
| `ZI_SalesOrderHeader` | Interface CDS view (root) | Reads VBAK, exposes key fields |
| `ZI_SalesOrderItem` | Interface CDS view | Reads VBAP, associated to header |
| `ZC_SalesOrderHeader` | Projection CDS view (root) | Consumption view for the service |
| `ZC_SalesOrderItem` | Projection CDS view | Consumption view for the service |
| `ZI_SalesOrderHeader` (bdef) | Behavior definition (interface) | Read-only, exposes `_Item` |
| `ZI_SalesOrderItem` (bdef) | Behavior definition (interface) | Read-only, exposes `_Header` |
| `ZC_SalesOrderHeader` (bdef) | Behavior definition (projection) | Read-only, exposes `_Item` |
| `ZC_SalesOrderItem` (bdef) | Behavior definition (projection) | Read-only, exposes `_Header` |
| `ZC_SalesOrderHeader` (ddlx) | Metadata extension | List report / object page UI annotations |
| `ZC_SalesOrderItem` (ddlx) | Metadata extension | Item table UI annotations |
| `ZSD_C_SALESORDER` | Service definition | Exposes both entities |
| `ZSB_C_SALESORDER` | Service binding (created in ADT, not a text file) | OData V4 - UI |

## Fields exposed

**Header (VBAK):** SalesOrder (VBELN), CreatedOn/By, SalesOrderType (AUART),
SalesOrganization (VKORG), DistributionChannel (VTWEG), Division (SPART),
SalesGroup (VKGRP), SalesOffice (VKBUR), SoldToParty (KUNNR),
PurchaseOrderNumber/Date (BSTNK/BSTDK), DocumentDate (AUDAT),
NetValue/Currency (NETWR/WAERK).

**Item (VBAP):** SalesOrder/SalesOrderItem (VBELN/POSNR), Material (MATNR),
ItemDescription (ARKTX), ItemCategory (PSTYV), Plant (WERKS),
StorageLocation (LGORT), MaterialGroup (MATKL), OrderQuantity/Unit
(KWMENG/VRKME), NetPrice/NetValue/Currency (NETPR/NETWR/WAERK),
RejectionReason (ABGRU).

## Deploying this (steps to do in ADT / Eclipse)

1. Create a package (e.g. `ZRAP_SALESORDER_REPORT`) if you don't have one yet.
2. Create the DDL sources under `ddl/` in the order: `zi_salesorder_header`,
   `zi_salesorder_item`, `zc_salesorder_header`, `zc_salesorder_item` — paste
   each file's content, activate as you go (header/item interface views can
   be activated together since they reference each other).
3. Create the behavior definitions under `behavior/` for each of the four
   views, with the same names, and activate.
4. Create the metadata extensions under `ddlx/` for `ZC_SalesOrderHeader`
   and `ZC_SalesOrderItem`, and activate.
5. Create the service definition `ZSD_C_SALESORDER` from `service/`, and
   activate.
6. In ADT, right-click the service definition → **New Service Binding**,
   name it `ZSB_C_SALESORDER`, binding type **OData V4 - UI**, bind both
   `SalesOrderHeader` and `SalesOrderItem`, activate, then **Publish** and
   **Preview** — the Fiori Elements List Report opens with Sales Order as a
   filter field.

## Notes / things to adjust before productive use

- `@AccessControl.authorizationCheck: #NOT_REQUIRED` is set on both
  interface views for simplicity. For a productive report, replace this
  with `#CHECK` and add a proper CDS-based authorization (e.g. against
  `V_VBAK_VKO` / `V_VBAK_AAT` or a custom authorization object) so users
  only see sales orders they're authorized for.
- SQL view names (`ZIVSALESORDHD`, `ZIVSALESORDIT`) are placeholders —
  rename if they collide with anything in your system, and check the
  16-character SQL view name limit if you rename the CDS entities.
- No draft handling is included since this is a read-only reporting
  scenario (no `with draft;` in the behavior definitions).
