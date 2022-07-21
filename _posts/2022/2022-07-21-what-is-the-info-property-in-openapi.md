---
title: What is the info property in OpenAPI?
date: 2022-07-21
series: OpenAPI Specification Reference
series_number: 2
author: Arnaud Lauret
layout: post
permalink: /what-is-the-info-property-in-openapi/
category: post
---

The info property of an OpenAPI document contains metadata that provides an overview of an API, but what does it represent exactly? How did it evolve across the OpenAPI Specification versions? And how to can it be used and misused? This is the second post in the OpenAPI Specification Reference series.
<!--more-->

{% include _postincludes/openapi-specification-reference.md %}

# Definition

What represents the `info` property, how it is structured, is it required, and where it is located.

{% codefile file:complete-license-url-version-31.openapi.yaml title:"An OpenAPI 3.1 document with a complete info property (license url variant)" language:yaml highlight:2-14 %}

## What does it represent?

The `info` property (lines 2 to 15 in the document above) contains metadata that provides an overview of an API, what can be done with it, who to contact about it, and its limitations and conditions of use. It contains:

- The API's version (`version` properties). The OpenAPI Specification doesn't enforce any way of versioning an API, the version just needs to be set as a string.
- Various descriptions of the API, such as its name (`title` ) and a short and long description (`summary` and `description` ).
- Contact information (`contact` property) to get more details or support.
- Legal information pointing to documents outside of the OpenAPI document describing the API's conditions of use and limitations (`termsOfService` and `license` properties).

## How is it structured?

The `info` property is an Info object and relies on two other objects; the `contact` property is a Contact object, and the `license` one is a License object. Those three object are [extensible](https://github.com/OAI/OpenAPI-Specification/blob/main/versions/3.1.0.md#specificationExtensions). All other properties are of type `string` (especially the `version`, see "[Missing quotes around the version of the API](#how-to-write-a-multiline-description-in-yaml)"). Some may require a specific format (`url` or `email,` for example).

{% include _postincludes/openapi-info.md version="3.1" %}

## Is it required?

The `info` property itself is required; an OpenAPI document will be considered invalid without it. It may be more or less complete; a minimal `info` property will contain the API's name (`title`) and version (`version`).

{% codefile file:minimal-version-31.openapi.yaml title:"A minimal Info object" language:yaml highlight:2-4 %}

When a `license` property is present, the License object must include at least a license `name`, `identifier` and `url` are optional. According to specification and schema, when the `contact` property could be empty as all properties of the Contact object are optional. Obviously, a minimal instance must contain at least one of its `name`,`email` , or `url` properties.

{% capture content %}
Note that there's an inconsistency between the optional status of `identifier` and `url` described in the specification and the official JSON Schema which makes them required (see [Issue 2975](https://github.com/OAI/OpenAPI-Specification/issues/2975), _I'm waiting a confirmation before proposing a fix_).
{% endcapture %}
{% include alert.html level="warning" content=content %}

{% codefile file:minimal-contact-license-version-31.openapi.yaml title:"Minimal License and Contact objects" language:yaml highlight:5,7 %}

The `identifier` and `url` of the License object (`license` property of the Info Object) are mutually exclusive. That means only one of them can be provided and so a License object can't contain them both at the same time.

{% codefile file:complete-license-identifier-version-31.openapi.yaml title:"A complete License object (identifier variant)" language:yaml lines:13-14 %}

{% codefile file:complete-license-url-version-31.openapi.yaml title:"A complete License object (url variant)" language:yaml lines:13-14 %}

## Where is it located?

The `info` property is a property of the [OpenAPI object](https://github.com/OAI/OpenAPI-Specification/blob/main/versions/3.1.0.md#oasObject) and so is located at the OpenAPI document’s root. This property and the related Info, License and Contact objects appear only once in a document.

# Changelog

How the `info` property and its components evolved across the different versions of the specification.

The Info object hasn't much structurally changed between version 2.0 and 3.1. Some clarifications and more-or-less non-backward compatible modifications have been made to the content of some values and some optional data have been added.

## Version 2.0 (2014)

The `info` property structure in version 2.0 is almost the same as in the 3.x versions minus the additions made in 3.1. Two properties, `termsOfService` and `description` have some "specific" behaviors that must be noted.

{% codefile file:complete-version-20.openapi.yaml title:"A Swagger 2.0 document with a complete info property" language:yaml highlight:5-6 %}

{% include _postincludes/openapi-info.md version="2.0" changelog="true" %}

### Terms of service is implicitly a URL

Though the `termsOfService` property is a string without any specific format, most parsers and tools expect its value to be a URL like in 3.x versions.

### Description markdown syntax is different from later versions

The `description` property supports the [GFM (Github Flavored Markdown)](https://docs.github.com/en/get-started/writing-on-github/getting-started-with-writing-and-formatting-on-github/basic-writing-and-formatting-syntax#GitHub-flavored-markdown) syntax, which differs from the one used in 3.x versions (see "[Which Markdown syntax to support in description?](#which-markdown-syntax-to-support-in-description)").

## Version 3.0 (2017)

There is no structural modification in version 3.0. Still, the descriptions of two existing properties, `termsOfService` and `description`, have been modified, introducing more-or-less non-backward compatible changes.

{% codefile file:complete-version-30.openapi.yaml title:"An OpenAPI 3.0 document with a complete info property" language:yaml highlight:5-6 %}

{% include _postincludes/openapi-info.md version="3.0" changelog="true" %}

### Terms of service is explicitly a URL

The `termsOfService` property is now explicitly a URL ([Issue #661](https://github.com/OAI/OpenAPI-Specification/pull/661), [Pull Request #255](https://github.com/OAI/OpenAPI-Specification/pull/255)). Out of context, it is an actual non-backward compatible change, but it is not, based on the typical property usage in version 2.0.

### Description now uses CommonMark markdown syntax

The `description` property now supports markdown using the [CommonMark](https://spec.commonmark.org/) syntax instead of GFM syntax ([Pull Request #720](https://github.com/OAI/OpenAPI-Specification/pull/720)). This modification was introduced because the definition of GFM and its differences from the original Markdown format were unclear then. Conversely, the CommonMark specification was considered well documented, rigorously defined, and would facilitate tool creators' work. It seems not to be the case anymore in 2022; see [GFM specification](https://github.github.com/gfm/), which was probably not available in 2017 and is equivalent to CommonMark specification quality. Question: At equivalent quality, could another argument in favor of such a change be to avoid using a "proprietary" format? CommonMark is a "non-proprietary" attempt to specify the Markdown syntax formally. That was a knowingly accepted non-backward compatible lossy change; markdown table support loss, among other less-used features, was considered acceptable because there was a work-around, using HTML tables, and [CommonMark was supposed to evolve to support this feature](https://talk.commonmark.org/t/tables-in-pure-markdown/81/186) ([see issue #1867](https://github.com/OAI/OpenAPI-Specification/issues/1867) and Markdown support section in Troubleshooting).

### Tools may ignore some markdown features in rich text for security reasons 

Regardless of which markdown syntax is used in `description`, or any other rich text value, version 3.0 adds some precisions about markdown parsing and security: [tools may ignore certain markdown features for security concerns](https://github.com/OAI/OpenAPI-Specification/blob/main/versions/3.1.0.md#richText) (See [issue 1078](https://github.com/OAI/OpenAPI-Specification/issues/1078), [Pull Request #1090](https://github.com/OAI/OpenAPI-Specification/pull/1090), and [Security issues with Markdown support in description](#) in Troubleshooting)

## Version 3.1 (2021)

In version 3.1, two optional properties were added; `summary` was added to the Info object and `identifier` was added to the License one. These are backward compatible modifications.

{% codefile file:complete-license-identifier-version-31.openapi.yaml title:"An OpenAPI 3.1 document with a complete info property (license identifier variant)" language:yaml highlight:2-14 %}

{% include _postincludes/openapi-info.md version="3.1" changelog="true" %}

### API's summary added to Info Object

The `summary` property has been added to the Info object ([Issue #832](https://github.com/OAI/OpenAPI-Specification/issues/832), [Pull request #1779](https://github.com/OAI/OpenAPI-Specification/pull/1779)). It's a short description of the API which is similar to the summary found on a path or an operation. That simplifies documentation tools work which would take the first sentence or first nth characters as a summary in previous version (See [API documentation use case examples](#api-documentation)). That can also help better set the boundaries of the API (see [API design use case examples](#api-design)).

### SPDX identifier added to License Object

The `identifier` property has been added to the License object ([Issue #1599](https://github.com/OAI/OpenAPI-Specification/issues/1599), [Pull Request #2105](https://github.com/OAI/OpenAPI-Specification/pull/2105)). It is a [SPDX (Software Package Data eXchange) license expression](https://spdx.dev/spdx-specification-21-web-version/#h.jxpfx0ykyb60) which  "provides a way for one to construct expressions that more accurately represent the licensing terms typically found in open source software source code." The value can be an [official SPDX identifier](https://spdx.org/licenses/) or a custom one.

This new `identifier` property is optional but mutually exclusive with the `url` one. No information were found in the specification, issues or pull requests explaining this mutual exclusive relationship.

{% codefile file:complete-license-identifier-version-31.openapi.yaml title:"A complete License object (identifier variant)" language:yaml lines:13-14 %}

{% codefile file:complete-license-url-version-31.openapi.yaml title:"A complete License object (url variant)" language:yaml lines:13-14 %}

# Usage

How the `info` property and its components can be used and misused.

## Notes about certain properties

### Using rich text formatting in description

The `description` property supports markdown to propose rich text formatting (see "[Which Markdown syntax to support in description?](#which-markdown-syntax-to-support-in-description)").

{% codefile file:complete-license-url-version-31.openapi.yaml title:"A rich text (markdown) description" language:yaml lines:6 %}

{% include image.html source="rich-text-rendered.jpg" %}

## Use case examples

The `info` property can be used for API design, governance, documentation, and tools. Here are a few examples; some of them may deserve more complete articles.

### API design

- In the early stage of design, designers can take advantage of almost empty documents containing only an `info` property (empty `paths` or empty `components`) to describe the API in natural language briefly. Giving a name (`title`) and crafting a short description (`summary` ) of an API can be an excellent start to set boundaries. The longer markdown-compatible `description` can be used to list the use cases to fulfill.

### API governance

- The `version` property can be used in conjunction with a [semantic version](https://semver.org/) (`2.1,` for example) to inform about the type of changes introduced. Note that the version can be anything that fits into a string. For example, it could be an ISO8601 date (`2022-07-19`).
- An organization can ensure that an API has an identified owner by enforcing providing the `contact` information. 

### API documentation

- An API catalog can take advantage of the `title` and `summary` properties of OpenAPI documents to generate a list of APIs.
- A UI showing an API's detailed information can take advantage of the markdown sections (`# level 1`  and `## level 2,` for example) present in `the description to build a menu and` various pages.
- The `description` can list the modifications a new version brings (in a `# Changelog` section, for instance).
- The support form of an API on an API portal could take advantage of the `contact` property.
- The `description` can be used to fill the gap in the OpenAPI Specification and add (non-machine readable) information that can't be put elsewhere in the document, though it may be preferable to use machine-readable extensions (See [Description vs extension](#description-vs-extension)).

### API Tools

- Depending on the type of change indicated by a semantic `version` , the tool in charge of deploying an API on an API gateway may choose to update (minor change`1.7`  to `1.8`  for example) or recreate the API (major change, `1.8`  to `2.0`  for example), leaving the previous version unmodified.
- Monitoring and logging tools may use the API `title` as an identifier of the API (hoping there are governance controls ensuring it is unique).

## Troubleshooting

The usual problems, concerns, and questions encountered when using the `info` property (Info, Contact, and License objects). Some of the elements evoked here may deserve more complete articles.

- [Info may be more than metadata](#info-may-be-more-than-metadata)
- [Version is not the interface’s contract one](#version-is-not-the-interfaces-contract-one)
- [Missing quotes around the version of the API](#missing-quotes-around-the-version-of-the-api)
- [How to write a multiline description in YAML?](#how-to-write-a-multiline-description-in-yaml)
- [Description as a substitute or copy of some OpenAPI elements](#description-as-a-substitute-or-copy-of-some-openapi-elements)
- [Description vs extension](#description-vs-extension)
- [Which Markdown syntax to support in description?](#which-markdown-syntax-to-support-in-description)
- [Security issues with Markdown support in description](#security-issues-with-markdown-support-in-description)
- [Non URL terms of service](#non-url-terms-of-service)
- [What is a license for an API?](#what-is-a-license-for-an-api)
- [Is it possible to use a custom license identifier?](#is-it-possible-to-use-a-custom-license-identifier)
- [License used for terms of service](#license-used-for-terms-of-service)

### Info may be more than metadata

The `info` property is described as "metadata" and could be seen as not being part of the API contract. But this property may directly or indirectly describe behavior and provide information impacting the overall API's contract. For instance, the document(s) linked in `termsOfService` could define rate limits or the `description` may describe some of the API's behavior in human-readable fashion only.

### Version is not the interface's contract one

When generating an OpenAPI document from code, the `version` property may contain the implementation's version or build number instead of the interface's contract version. The framework or library used may need some configuration tuning to ensure that the correct expected value is put in this property.

### Missing quotes around the version of the API

Many APIs use a `major.minor` semantic versioning, so the `info.version` value could be `1.0` for instance. Not putting quotes around this value will cause an error because `info.version` is defined as a string and such value will be interpreted as a number by OpenAPI parsers either the document is in JSON or YAML.

### How to write a multiline description in YAML?

A complex and long markdown `description` can be a burden to write on a single line. Hopefully YAML supports multiline string values. Right after `description: ` add a `|` followed by a new line, this allows to write multiline string values. Read more about multiline strings in YAML [here](https://yaml-multiline.info/).

{% codefile file:description-markdown-multiline-version-31.openapi.yaml title:"A multiline description" language:yaml highlight:5-14 %}

### Description as a substitute or copy of some OpenAPI elements

An axis of OpenAPI documents analysis (that can be done during an API review process) is to ensure the `description` property doesn't contain information that could have been described in a machine-readable way with other OpenAPI elements or information that has been already formally described elsewhere.

### Description vs extension

The description property could be used to fill the gap in the OpenAPI Specification, but the information provided are mostly human-readable only (though it could be partially machine-interpreted taking advantage of rich text features like sections). It could be preferable to take advantage of [extensions (custom x- properties)](https://github.com/OAI/OpenAPI-Specification/blob/main/versions/3.1.0.md#specificationExtensions).

_API Handyman note: A dedicated post about extensions in planned in this OpenAPI Reference series._

### Which Markdown syntax to support in description?

The use of [CommonMark](https://commonmark.org/) was introduced in 3.0 ([Pull Request #720](https://github.com/OAI/OpenAPI-Specification/pull/720)) in replacement of GFM (Github Flavored Markdown) used in previous version, see [version 3.0 changelog](#version-30-2017).

According to what is said in the [3.1 specification](https://github.com/OAI/OpenAPI-Specification/blob/main/versions/3.1.0.md#rich-text-formatting) and in the [issue #972](https://github.com/OAI/OpenAPI-Specification/issues/972) discussion, tools should support CommonMark 0.27 and above (the latest version as of the moment of writing is 0.30).

The problem is that transitioning from GFM to CommonMark markdown syntax came with some loss, especially the (non-HTML) table support (see [Issue #1867](https://github.com/OAI/OpenAPI-Specification/issues/1867)) and many people are used to [table GFM syntax](https://github.github.com/gfm/#tables-extension-). The [discussion about supporting table in CommonMark exists](https://talk.commonmark.org/t/tables-in-pure-markdown/81/186) but is not yet settle even in 2022. In 2017, the table issue was known and it was decided that as CommonMark supported HTML and markdown table was possibly coming to CommonMark, it was OK to switch.

Hopefully, according to the [CommonMark table discussion](https://talk.commonmark.org/t/tables-in-pure-markdown/81/186) it seems "there are plenty of CommonMark implementations out there that offer table extensions compatible with what GitHub uses.

_API Handyman note: Based on those elements, I would (I'm not speaking in the name of OAI) recommend to support the most common markdown syntax(es), especially GFM tables, and not just pure CommonMark. That way it is possible to easily deal with all versions of OpenAPI from 2.0 to 3.1 and what most users will expect regarding markdown support._

### Security issues with Markdown support in description

This is not an OpenAPI specific topic, any tool/format relying on markdown is subject to security issues like [local file inclusion](https://www.akamai.com/blog/security/markdown-menace) or [XSS](https://michelf.ca/blog/2010/markdown-and-xss/). Therefore, it is accepted and even up to the tools to ignore some normally supported markdown feature for security concerns (See [Rich Text Formatting section](https://github.com/OAI/OpenAPI-Specification/blob/main/versions/3.1.0.md#richText),  [issue 1078](https://github.com/OAI/OpenAPI-Specification/issues/1078) and [Pull Request #1090](https://github.com/OAI/OpenAPI-Specification/pull/1090)). But, as always with security measures, a balance has to be found with user experience (completely forbidding HTML support could be a problem for instance).  

### Non URL terms of service

In version 2.0, it was not clearly stated that `termsOfService` was a URL, so some documents may contain a text value which is not a URL. Based on a search on the APIs.guru directory, it can be assumed it is quite rare, if not non-existing on public APIs, though the situation may be different on the millions on private APIs. Nevertheless, most tools parsing 2.0 documents will expect a URL and ignore other values, but maybe silently. This is not an issue anymore in 3.x documents as the specifications clearly states the expected format.

### What is a license for an API?

According to [issue #726](https://github.com/OAI/OpenAPI-Specification/issues/726), the `license` property describes the license (like Apache 2.0 for instance) that is applicable to the interface contract itself which is described in the OpenAPI document. It tells if one can re-implement or re-license the API, it does not apply to the implementation.

_API Handyman note, I'll need to investigate that topic, as despite what is said above, I'm not sure about what means a license for an API and even if an API can be licensed. Also does it relate to copyright (as in the [Google vs Oracle API case](https://en.wikipedia.org/wiki/Google_LLC_v._Oracle_America_Inc.))?_

### Is it possible to use a custom license identifier?

It is possible to use custom license `identifier` in the License object? Yes and no. The property only expects a [SPDX expression](https://spdx.dev/spdx-specification-21-web-version/#h.jxpfx0ykyb60) value and not an actual [official SPDX identifier](https://spdx.org/licenses/) or a combination of those. 

A pseudo-custom identifier which is a combination of existing ones can be used. The information available on the [official license list](https://spdx.org/licenses/) will allow to parse it. 

But if the `identifier` is a completely custom one (which is not based on existing license identifiers), impossible to understand using the official list, how people or machine reading the document are supposed to understand that code? I wouldn't recommend to use such an identifier unless you're sure that people and machine using the document know what to do with it, but how to be 100% sure? In that case, it would be more secure to use a `url` instead of an `identifier`.

Note that the SPDX documentation can be overwhelming. On [Issue #1599](https://github.com/OAI/OpenAPI-Specification/issues/1599), silverhook [shows an example of completely custom SPDX identifier](https://github.com/OAI/OpenAPI-Specification/issues/1599#issuecomment-510819281): 

> If a license is not listed on the SPDX License List, you can still use SPDX annotation to indicate a unique license by prepending LicenseRef- to the (unique) license name. E.g. LicenseRef-My_Very_Own_Look_But_Do_Not_Touch_License-2.0 is a valid SPDX license identifier.

### License used for terms of service

Some OpenAPI document may use the license object to point to their terms of service (or terms and conditions). That is not correct according to the definition (and clarification) of what is the `license` property. See [issue #1672](https://github.com/OAI/OpenAPI-Specification/issues/1672).

# Documentation

Where to find more information about the `info` property and its components.

{% include _postincludes/openapi-specification-reference-links.md names="info-object,contact-object,license-object" folder="info-property" %}