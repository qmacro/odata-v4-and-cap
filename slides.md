---
theme: ./themes/theme.json
author: DJ Adams
date: DD MMM YYYY
paging: "%d / %d"
---

<!-- markdownlint-disable MD025 -->

# Talk

OData V4 and SAP Cloud Application Programming Model

# Speaker

DJ Adams, Developer Advocate at SAP

# What we'll cover

In this session we'll look at what the SAP Cloud Application Programming Model (CAP) has to offer for the Open Data Protocol (OData) V4. The latest incarnation of OData is 4.01. This talk covers the more widely known and implemented 4.0 version.

---

# A brief history of OData

```text
1995 1996 1997 1998 1999 2000 2001 2002 2003 2004
|                   |                   |
MCF                 RSS                 Atom

2005 2006 2007 2008 2009 2010 2011 2012 2013 2014
|         |                                  |
RFC4287   RFC5023                            |
(format)  (protocol)                         |
          |                                  |
          OData (MS OSP)                     OData V4 (OASIS)

2015 2016 2017 2018 2019 2020 2021 2022
|
OData V4 (ISO/IEC)
```

<!--
OASIS's stewardship of the OData standard and the eventual submission to ISO/IEC meant a more structured set of standards documents and documentation process, leading to greater clarity and accuracy, but perhaps at the cost of complexity and more formal language.

SAP is a key member of the OASIS OData Technical Committee.
-->

---

# OData specification documents

* Core specification components and related works
* Core components (plus errata):
  * Protocol (how it relates to HTTP)
  * URL Conventions (what you can do with OData URLs)
  * Common Schema Definition Language (metadata)
* Related and supporting works:
  * ABNF Construction Rules (formal grammar definition)
  * Core Vocabularies (Capabilities, Core and Measures)
  * Formats (Atom and JSON) and Schemas (EDMX and EDM)
* Extensions:
  * Data Aggregation
  * Temporal Data

The extension documents are Committee Specifications

---

# Navigating the OASIS documents

Different document types denoting position in drafting, review and approval flow:

* Committee Note
* Committee Specification
* Public Review Draft
* Candidate OASIS Standard
* OASIS Standard

👉 `https://github.com/qmacro/odata-specs/blob/master/overview.md`

---

# CAP features for OData

* See [Serving OData APIs](https://cap.cloud.sap/docs/advanced/odata) in the Capire documentation

---

# New $search system query option

* Brand new system query option for cross-property text search
* See [Part 2: URL Conventions section 5.1.7 System Query Option $search](http://docs.oasis-open.org/odata/odata/v4.0/errata03/os/complete/part2-url-conventions/odata-v4.0-errata03-os-part2-url-conventions-complete.html#_Toc453752364)
* [Available for Node.js and Java](https://cap.cloud.sap/docs/advanced/odata#overview)
* Use annotation `@cds.search` for more precise definitions (see [Searching Textual Data](https://cap.cloud.sap/docs/guides/providing-services#searching-data))

👉 `http://localhost:4004/northwind-model/Categories?$search=products`

---

# Improved $expand

* In V4, expanded entities can be filtered, ordered, paged, etc with a more composable nested syntax
* `$expand=<navprop>(...)`
* Already some support for key system query options, in particular `$filter`, `$select` and `$orderby`
* [Some examples](sample/app/filter.html) (see [Part 4 - all things $filter](https://www.youtube.com/watch?v=R9JyaPYtWKs&list=PL6RpkC85SLQDYLiN1BobWXvvnhaGErkwj&index=4))

👉 `http://localhost:4004/northwind-model/Suppliers?$select=CompanyName&$expand=Products($orderby=UnitPrice;$filter=UnitsInStock gt 0;$select=ProductName,UnitPrice,UnitsInStock)`

---

# $count as system query option

* In V2, `$count` could be appended to a resource path for a raw scalar value response, and `$inlinecount` was a system query option
* In V4, `$count` is also now a system query option, replacing `$inlinecount`

👉 `http://localhost:4004/northwind-model/Products/$count`

👉 `http://localhost:4004/northwind-model/Products?$count=true`

---

# Data aggregation

* A committee specification level extension to V4 with early support in CAP
* Described in the document "OData Extension for Data Aggregation Version 4.0 (CS 02)"
* Implemented via the new `$apply` system query option, using:
  * Transformations (`filter`, `groupby` and `aggregate` supported currently)
  * Aggregation methods (`min`, `max`, `sum`, `average` etc)

👉 `http://localhost:4004/northwind-model/Products?$apply=aggregate(UnitPrice%20with%20max%20as%20MostExpensive)`

👉 `http://localhost:4004/northwind-model/Products?$apply=filter(Discontinued%20eq%20true)/groupby((Category_CategoryID),aggregate(UnitsInStock%20with%20sum%20as%20TotalStock))`
---

# References and further reading

* OData Version 4.0 specifications (the core components):
  * [Part 1: Protocol](http://docs.oasis-open.org/odata/odata/v4.0/odata-v4.0-part1-protocol.html)
  * [Part 2: URL Conventions](http://docs.oasis-open.org/odata/odata/v4.0/odata-v4.0-part2-url-conventions.html)
  * [Part 3: Common Schema Definition Language](http://docs.oasis-open.org/odata/odata/v4.0/odata-v4.0-part3-csdl.html)
* [OASIS OData standards overview](https://www.oasis-open.org/standards/#odatav4.0)
* An overview and map of the [OASIS Documents](https://github.com/qmacro/odata-specs/blob/master/overview.md)
* [OData Published as an ISO Standard](https://www.odata.org/blog/OData-Published-as-an-ISO-Standard/)
* [What's New in OData Version 4.0](http://docs.oasis-open.org/odata/new-in-odata/v4.0/new-in-odata-v4.0.html)
* The CAP documentation section on [Serving OData APIs](https://cap.cloud.sap/docs/advanced/odata)
* [Monday morning thoughts: OData](https://blogs.sap.com/2018/08/20/monday-morning-thoughts-odata/)
* [RFC 4287](https://datatracker.ietf.org/doc/html/rfc4287) (The Atom Syndication Format)
* [RFC 5023](https://www.rfc-editor.org/rfc/rfc5023.html) (The Atom Publishing Protocol)
* [Back to basics video series on OData](https://www.youtube.com/playlist?list=PL6RpkC85SLQDYLiN1BobWXvvnhaGErkwj) (Hands-on SAP Dev)

---

# Standards

A list of the most recent standards (with approval dates) taken from the [OASIS OPEN list of standards relating to the Open Data Protocol](https://www.oasis-open.org/standards/#odatav4.0)

* OData Atom Format Version 4.0 (17 Nov 2013)
* OData Common Schema Definition Language (CSDL) JSON Representation Version 4.01 (12 May 2020)
* OData Common Schema Definition Language (CSDL) XML Representation Version 4.01 (12 May 2020)
* OData Extension for Data Aggregation Version 4.0 (04 Nov 2015)
* OData Extension for Temporal Data Version 4.0 - CS 01 (04 Nov 2015)
* OData JSON Format v4.0 (24 Feb 2014)
* OData JSON Format v4.01 (12 May 2020)
* OData v4.0 (24 Feb 2014)
* OData v4.01 (23 Apr 2020)
* Repeatable Requests Version 1.0 (07 Jul 2020)
