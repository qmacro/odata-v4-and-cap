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

In this session we'll look at the intersection of OData V4 and the SAP Cloud Application Programming Model (CAP) which already supports many features.

> The latest incarnation of OData is 4.01. This talk covers the more widely known and implemented 4.0 version.

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

> See [Monday morning thoughts: OData](https://blogs.sap.com/2018/08/20/monday-morning-thoughts-odata/)

<!--
OASIS's stewardship of the OData standard and the eventual submission to ISO/IEC meant a more structured set of standards documents and documentation process, leading to greater clarity and accuracy, but perhaps at the cost of complexity and more formal language.

SAP is a key member of the OASIS OData Technical Committee.
-->

---

# OData specification documents

Core specification components and related works

## Core components (plus errata)

* Protocol (how it relates to HTTP)
* URL Conventions (what you can do with OData URLs)
* Common Schema Definition Language (metadata)

## Related and supporting works

* ABNF Construction Rules (formal grammar definition)
* Core Vocabularies (Capabilities, Core and Measures)
* Formats (Atom and JSON) and Schemas (EDMX and EDM)

## Extensions (Committee Specifications)

* Data Aggregation
* Temporal Data

---

# Navigating the OASIS documents

Different document types denoting position in drafting, review and approval flow:

* Committee Note
* Committee Specification
* Public Review Draft
* Candidate OASIS Standard
* OASIS Standard

`https://github.com/qmacro/odata-specs/blob/master/overview.md`

---

> Examples based on `qmacro/odata-v4-and-cap`

---

# New $search system query option

* Brand new system query option for cross-property text search
* See [Part 2: URL Conventions section 5.1.7 System Query Option $search](http://docs.oasis-open.org/odata/odata/v4.0/errata03/os/complete/part2-url-conventions/odata-v4.0-errata03-os-part2-url-conventions-complete.html#_Toc453752364)
* [Available in CAP for Node.js and Java](https://cap.cloud.sap/docs/advanced/odata#overview)
* Use annotation `@cds.search` for more precise definitions - see [Searching Textual Data](https://cap.cloud.sap/docs/guides/providing-services#searching-data)

`http://localhost:4004/main/Categories?$filter=contains(CategoryName,%27products%27)`

`http://localhost:4004/main/Categories?$filter=contains(Description,%27products%27)`

vs

`http://localhost:4004/main/Categories?$search=products`

---

# Improved $expand

* Expanded entities can be filtered, ordered, paged, etc with a more composable nested syntax `$expand=<navprop>(<system-query-option>;...)`
* Already some support for key system query options, in particular `$filter`, `$select` and `$orderby`
* Deep dive: [Part 4 - all things $filter](https://www.youtube.com/watch?v=R9JyaPYtWKs&list=PL6RpkC85SLQDYLiN1BobWXvvnhaGErkwj&index=4)

```text
http://localhost:4004/main/Suppliers
  ?$select=CompanyName
  &$expand=Products(
    $orderby=UnitPrice;
    $filter=UnitsInStock gt 0;
    $select=ProductName,UnitPrice,UnitsInStock
  )
```

`http://localhost:4004/filter.html#more-advanced-usage`

(See first example "Suppliers and their stocked products, ordered by price")

---

# $count as system query option

## OData V2

* `$count` appended to a resource path -> raw scalar value
* `$inlinecount` as system query option

## OData V4

* `$count` is also now a system query option, replacing `$inlinecount`

`http://localhost:4004/main/Products/$count`

`http://localhost:4004/main/Products?$count=true`

---

# Data aggregation

* A committee specification level extension to V4 with early support in CAP
* Described in the document "OData Extension for Data Aggregation Version 4.0 (CS 02)"
* Implemented via the new `$apply` system query option, using:
  * Transformations (`filter`, `groupby` and `aggregate` supported currently)
  * Aggregation methods (`min`, `max`, `sum`, `average` etc)

## Example

```text
http://localhost:4004/main/Products
  ?$apply=aggregate(
    UnitPrice with max as MostExpensive
)
```

---

# Data aggregation (cntd)

* A committee specification level extension to V4 with early support in CAP

## Another example

```text
http://localhost:4004/main/Products?
  $apply=filter(Discontinued eq true)
         /groupby(
           (Category_CategoryID),
           aggregate(
             UnitsInStock with sum as TotalStock
            )
          )
```

See `http://localhost:4004/filter.html#data-aggregation`

---

# Data aggregation with custom aggregates

* [Custom aggregates](http://docs.oasis-open.org/odata/odata-data-aggregation-ext/v4.0/cs02/odata-data-aggregation-ext-v4.0-cs02.html#_Toc435016600) can be defined with annotations - [supported in CAP](https://cap.cloud.sap/docs/advanced/odata#custom-aggregates)
* Virtual properties simplifying otherwise explicit and complex expressions

## Standard, explicit

```text
http://localhost:4004/main/Products
  ?$apply=aggregate(
    UnitsInStock with sum as TotalStock
  )
```

---

# Data aggregation with custom aggregates (cntd)

* [Custom aggregates](http://docs.oasis-open.org/odata/odata-data-aggregation-ext/v4.0/cs02/odata-data-aggregation-ext-v4.0-cs02.html#_Toc435016600) can be defined with annotations - [supported in CAP](https://cap.cloud.sap/docs/advanced/odata#custom-aggregates)
* Virtual properties simplifying otherwise explicit and complex expressions

## Custom

* Annotations: `https://github.com/qmacro/odata-v4-and-cap/blob/main/sample/srv/customaggregates.cds`
* Metadata: `http://localhost:4004/custom-aggregates/$metadata`
* Result: `http://localhost:4004/custom-aggregates/Products?$apply=aggregate(UnitsInStock)`

---

# Singletons

* A neater way to [represent a single entity at the service root](http://docs.oasis-open.org/odata/new-in-odata/v4.0/cn01/new-in-odata-v4.0-cn01.html#_Toc366145535)
* Implement at the service layer with [@odata.singleton](https://cap.cloud.sap/docs/advanced/odata#custom-aggregates)

```text
http://localhost:4004/main/Products
  ?$orderby=UnitPrice asc
  &$top=1
```

`http://localhost:4004/main/Products?$orderby=UnitPrice%20asc&$top=1`

vs

* Annotations: `https://github.com/qmacro/odata-v4-and-cap/blob/main/sample/srv/singleton.cds`
* Metadata: `http://localhost:4004/singleton-example/$metadata`
* Result: `http://localhost:4004/singleton-example/BestBargain`

---

# Actions and functions

* Clear semantics, can be bound or unbound
* Actions may have side effects, functions may not

Examples|Bound|Unbound
-|-|-
Action|discontinue|submitOrder
Function|addressLine|randomProduct

* Metadata: `http://localhost:4004/main/$metadata`

## Function examples (GET)

* Bound: `http://localhost:4004/main/randomProduct()`
* Unbound: `http://localhost:4004/main/Suppliers/1/Main.addressLine()`

## Action examples (POST)

* Bound: `https://github.com/qmacro/odata-v4-and-cap/blob/main/sample/bin/ba-discontinue`
* Unbound: `https://github.com/qmacro/odata-v4-and-cap/blob/main/sample/bin/ua-submitOrder`

---

> Examples based on `SAP-samples/odata-basics-handsonsapdev`

---

# Annotations (1 of 2)

* Vocabularies and annotations have been refactored and greatly improved
* Standard and custom vocabularies

## Standard vocabularies

* From OASIS: `Core`, `Measures`, `Capabilities`, `Validation`, `Aggregation`, `Authorization`

### Example (Capabilities.DeleteRestrictions)

* Described by a type: `https://github.com/oasis-tcs/odata-vocabularies/blob/main/vocabularies/Org.OData.Capabilities.V1.md#deleterestrictionstype`
* @readonly as sugar: `https://cap.cloud.sap/docs/advanced/fiori#prefer-readonly-mandatory-`
* Annotate entity: `https://github.com/SAP-samples/odata-basics-handsonsapdev/blob/annotations/bookshop/srv/service.cds`
* Result: `http://localhost:4004/stats/$metadata`

> CAP does the right thing and implements the annotation semantic (returning 405 on DELETE request)

---

# Annotations (2 of 2)

* Vocabularies and annotations have been refactored and greatly improved
* Standard and custom vocabularies

## Custom vocabularies

* From SAP: `Analytics`, `CodeList`, `Common`, `UI` and many more - see [odata-vocabularies](https://sap.github.io/odata-vocabularies/)

### Example (UI.SelectionFields)

* From the UI Vocabulary `https://github.com/SAP/odata-vocabularies/blob/main/vocabularies/UI.md`
* `https://github.com/SAP-samples/odata-basics-handsonsapdev/blob/annotations/bookshop/srv/index.cds`
  * Separate annotations & definitions with `annotate` keyword
  * Extended syntax for complex expressions (`UI: { ... }`)
* Result: `http://localhost:4004/catalog/$metadata`
* App: `http://localhost:4004/webapp/index.html#browse-books`

---

# References and further reading

* OData Version 4.0 specifications (the core components):
  * [Part 1: Protocol](http://docs.oasis-open.org/odata/odata/v4.0/odata-v4.0-part1-protocol.html)
  * [Part 2: URL Conventions](http://docs.oasis-open.org/odata/odata/v4.0/odata-v4.0-part2-url-conventions.html)
  * [Part 3: Common Schema Definition Language](http://docs.oasis-open.org/odata/odata/v4.0/odata-v4.0-part3-csdl.html)
* [OASIS OData standards overview](https://www.oasis-open.org/standards/#odatav4.0)
* [OData Vocabularies Version 4.0](http://docs.oasis-open.org/odata/odata-vocabularies/v4.0/odata-vocabularies-v4.0.html)
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
