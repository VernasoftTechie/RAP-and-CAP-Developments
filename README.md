# RAP-and-CAP-Developments
RAP and CAP Developments by Kalyan

## Getting objects from this repo into your SAP system

The ABAP source files in each feature folder here (e.g. `SalesOrderReport/`) are plain source text with real ADT file extensions (`.ddls.asddls`, `.bdef.asbdef`, `.srvd.asrvd`, etc.), but they are **not** abapGit-formatted — there's no companion metadata XML or `.abapgit.xml` config, so abapGit can't pull them directly into brand-new objects yet.

The reliable two-step flow:

1. **Create the objects manually in ADT first.** Open each file here, copy its content, and paste it into a new object you create in Eclipse/ADT (New CDS View, New Behavior Definition, New Service Definition, etc.) in your target package, then activate. Each feature folder's own README lists the objects in the order to create them. This is guaranteed correct since ADT generates all the DDIC metadata itself.
2. **Once the objects exist and are activated, hand the package to abapGit.** Link your package to this GitHub repo as an abapGit repository and do a stage/commit from there — abapGit will serialize the real, activated objects into its own correct format and push that up, so from then on pulling and pushing this package via abapGit works normally.

In short: this repo works today as a readable source-code reference and change history; treat the first abapGit push as coming *from* your system, not *into* it.
