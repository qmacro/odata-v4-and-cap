---
theme: ./themes/theme.json
author: DJ Adams
date: DD MMM YYYY
paging: "%d / %d"
---

# Talk

OData V4 and SAP Cloud Application Programming Model

# Speaker

DJ Adams, Developer Advocate at SAP

# What we'll cover

In this session we'll look at what the SAP Cloud Application Programming Model (CAP) has to offer for the Open Data Protocol (OData) V4.

> While there is a version 4.01 of OData, the latest incarnation of which is from 2020, this talk covers the more widely known and implemented 4.0 version.

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
