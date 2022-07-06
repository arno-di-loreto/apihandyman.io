---
title: What is the openapi property?
date: 2022-07-06
series: OpenAPI Specification Reference
series_number: 1
author: Arnaud Lauret
layout: post
permalink: /what-is-the-openapi-property/
codefiles: openapi-reference/openapi
category: post
---

No OpenAPI document without the openapi property, but what does it represent? How did it evolve across the OpenAPI Specification versions? And how to take advantage of it? This is the first post in the OpenAPI Specification Reference series.
<!--more-->

{% include _postincludes/openapi-specification-reference.md %}

# Definition

What represents the `openapi` property, is it required, and where it is located.

{% codefile file:version-31.openapi.yaml title:"An OpenAPI 3.1 document" language:yaml highlight:1 %}

The `openapi` property (line 1 in the document above) specifies the version of the OpenAPI Specification used in the document. It does not participate in the description of an API itself; it could be considered the only "OpenAPI metadata" in an OpenAPI document. 

The version of the OpenAPI Specification takes advantage of [semantic versioning](https://semver.org/) `major.minor.patch`, `3.1.0` , for instance. Therefore, the `openapi` property is a string (not a number).  Note that some minor non-backward compatible modifications could happen (see Changelog).

The `openapi` property is required; an OpenAPI document will be considered invalid without it.

The `openapi` property is defined in the [OpenAPI object](https://github.com/OAI/OpenAPI-Specification/blob/main/versions/3.1.0.md#oasObject) and located at the document's root. It appears only once in a document.

# Changelog

How the `openapi` property evolved across the different versions of the specification.

## Version 2.0

In version 2.0 and earlier, the specification's version was stored in a `swagger` property (at the same location) because that was the name of the specification at that time (read [What is the OpenAPI Specification?](https://apihandyman.io/what-is-the-openapi-specification/) to learn more about this).

{% codefile file:version-20.openapi.yaml title:"A Swagger 2.0 document" language:yaml highlight:1 %}


## Version 3.0

The new "OpenAPI Specification" name was introduced in the 3.0 version, hence the modification of the property's name specifying the version of the specification to `openapi`.

{% codefile file:version-30.openapi.yaml title:"An OpenAPI 3.0 document" language:yaml highlight:1 %}

## Version 3.1

While version 3.1 did not bring any structural change regarding the openapi property; it modified the interpretation of its value. Strict semantic versioning was used in version 3.0: a modification of the minor version (3.0.0 to 3.1.0, for instance) must be backward compatible. Version 3.1 introduces a "loose semantic versioning" where non-backward compatible minor version changes (3.1.0 to 3.2.0, for example) may be introduced if the impact is considered sufficiently low compared to the benefits. 

{% codefile file:version-31.openapi.yaml title:"An OpenAPI 3.1 document" language:yaml highlight:1 %}

# Usage

How the `openapi` property can be used and misused.

## Use case examples

While the `openapi` property has no use inside a document, it is pretty helpful for the tools and processes that take advantage of the OpenAPI Specification. By the way, if you plan to create a format (for whatever VALID reasons), I would highly recommend putting the version inside documents.

### OpenAPI Parsers

- Check you're reading an OpenAPI document: if the property is absent, the document may not be an OpenAPI one.
- Choose an adapted parser or JSON Schema based on the name of the property (swagger, openapi) and its value (2.0, 3.0.X, 3.1.X).

### API Tools

- Check the document is compatible with the tools you're using (version 3.1 is not supported in all tools yet at the moment this is written).
- Check the tools you plan to use are compatible with your existing documents.
- Raise warnings or errors when linting documents to enforce moving from Swagger 2.0 to OpenAPI 3 to stop using outdated and with-less-features tools.

### API Governance

- Raise warnings or errors when linting documents to enforce moving from Swagger 2.0 to OpenAPI 3 to allow describing and documenting APIs more precisely.
- Apply linting rules only on specific version(s) of the specification 

## Troubleshooting

The usual problems encountered with the `openapi` property. 

### Not the version of the API

When starting to use the OpenAPI Specification, the property and its value can be confounded with the version of the API described in the document (which is specified in `info.version`). Hopefully, most of the time, parsers will raise an error, but not straightforward like "did you try to put the API's version in the `openapi` property instead of `info.version`?

### Almost semantic versioning

Be cautious with version 3.1 (and above) when working on OpenAPI-based tools because it introduces a "loose semantic versioning" where a minor version change may not be backward compatible (see Changelog). Version 3.1 introduces a few [non-backward-compatible-but-with-limited-impact changes](https://www.openapis.org/blog/2021/02/16/migrating-from-openapi-3-0-to-3-1-0), mainly around schema definitions.

### Missing quotes

This is a concern only in version 2.0. It is recommended put quotes around the value in YAML because 2.0 would be interpreted as a number instead of a string.

# Documentation

Where to find more information about the `openapi` property.

## Official documentation

- Version 3.1
  - [OpenAPI Specification version description](https://github.com/OAI/OpenAPI-Specification/blob/main/versions/3.1.0.md#versions)
  - [openapi property definition in OpenAPI object](https://github.com/OAI/OpenAPI-Specification/blob/main/versions/3.1.0.md#oasObject)
- Version 3.0
  - [OpenAPI Specification version description](https://github.com/OAI/OpenAPI-Specification/blob/main/versions/3.0.3.md#versions)
  - [openapi property definition in OpenAPI object](https://github.com/OAI/OpenAPI-Specification/blob/main/versions/3.0.3.md#oasObject)
- Version 2.0
  - [swagger property definition in Swagger object](https://github.com/OAI/OpenAPI-Specification/blob/main/versions/2.0.md#swagger-object)

## API Handyman resources

- All examples shown in this post can be found in my [openapi-samples](https://github.com/arno-di-loreto/openapi-samples/tree/main/reference/openapi-property) Github repository.