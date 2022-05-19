---
title: What is the OpenAPI Specification?
date: 2022-05-18
author: Arnaud Lauret
layout: post
permalink: /what-is-the-openapi-specification/
category: post
tools:
  - OpenAPI Specification
---

OpenAPI, or the OpenAPI Specification, formerly known as the Swagger Specification, is a machine-readable and human-friendly API description format. That short description is correct but does not help to understand what it is OpenAPI: it's the Rosetta Stone of the Web API world. Let's see why.
<!--more-->

{% include banner-author-link.md %}

{% capture content %}️This post is an expansion of my "What is OpenAPI in 60 seconds" video.

{% include video.html title="what-is-openapi" %}{% endcapture %}
{% include alert.html level="info" content=content %}

# OpenAPI is a format describing web APIs

OpenAPI is a format describing "RESTish" web APIs. That means APIs that take advantage of the HTTP protocol semantic, relying on `GET /this` and `POST /that` operations, can be described using that format.

## It's a JSON or YAML document

An OpenAPI document can be in JSON or YAML formats. Note that the official name for a file using the OpenAPI Specification format is "OpenAPI document." Still, many say "OpenAPI," "OpenAPI file," and even "OpenAPI specification" or "OpenAPI spec." I recommend using YAML, but you can use the format you prefer. 

YAML format brings the possibility of adding comments. Though considered more human-friendly than JSON, the YAML format can be tricky because of indentations.

{% code language:yaml title:"YAML" %}
openapi: 3.1.0
# A comment
...
{% endcode %}

JSON format doesn't have the indentation problem but writing all those brackets and quotes can be annoying. It also does not facilitates the writing of long texts (that you may need when using the `description`  properties to describe the API,  an operation, a response, or a property)

{% code language:json title:"json" %}
{
  "openapi": "3.1.0",
  ...
}
{% endcode %}

## It describes web APIs, their operations, and inputs/outputs

A basic OpenAPI document will contain:

- The version of the specification used
- General information about the API, such as its name and version
- Its paths and their operations
- The operations inputs (query parameters, for instance) and success and error outputs (HTTP status codes and data, for example) 

{% codefile file:openapi.yaml title:"A basic OpenAPI document" language:yaml %}

## It relies on the JSON Schema Specification to describe data

[JSON Schema](https://json-schema.org/) is a specification, independent from OpenAPI, dedicated to describing data. It can be used standalone to describe and then validate data. In the OpenAPI Specification, every single piece of data, from bodies to headers and parameters, is described with JSON schema. Note that OpenAPI 3.0 relies on a slightly modified [JSON Schema draft 00](https://spec.openapis.org/oas/v3.0.3#schema-object). OpenAPI 3.1 uses [JSON Schema draft 2012-12](https://spec.openapis.org/oas/v3.1.0#schema-object).

{% codefile file:openapi.yaml title:"A query parameter" language:yaml lines:19-20 %}

{% codefile file:openapi.yaml title:"A response body" language:yaml lines:27-36 %}

# OpenAPI is based on and replaces the Swagger 2.0 specification

You may know OpenAPI by another name: Swagger. OpenAPI is both Swagger and not Swagger.

## It is based on the Swagger 2.0 Specification

The OpenAPI Specification is formerly known as the Swagger Specification. This API description format was initially created for the Swagger project which aimed to facilitate the generation of documentation (Swagger UI) and SDK (Swagger Codegen) of the API of the [Wordnik](https://www.wordnik.com/) online dictionary.

The libraries and related Swagger tools were rapidly widely adopted, but the release of Swagger 2.0 and the Swagger Editor in September 2014 put the underlying Swagger specification to the forefront. The specification became a first-class citizen and started to be used by teams having an API design-first approach (designing APIs before implementing them). 

## It replaces the Swagger 2.0 Specification

In 2015, thanks to the work of a group of forward-looking API experts, the Swagger specification was donated to the API community by Smartbear, who owns the Swagger brand: The OpenAPI Specification was born. 

The OpenAPI Specification was born, but in the beginning, it was still the Swagger Specification 2.0. The first "true" OpenAPI Specification, the 3.0 version, was released in July 2017, followed by 3.1 in February 2021. Among many new features, the most emblematic and visible change between the Swagger Specification and OpenAPI is the replacement of `Swagger: 2.0` by `openapi: 3.x.x` .

## It does not replace the Swagger tools and brand

Smartbear still owns the Swagger brand. They maintain and create Swagger-named tools that take advantage of the OpenAPI Specification (SwaggerHub, for instance). Nowadays, most proprietary and open source "swagger-named" tools are now supporting at least OpenAPI 3.0. If they don't, I recommend sending a pull request to propose an update (open source), request an upgrade (proprietary), or not use them anymore. Note that now, open source tools taking advantage of the OpenAPI Specification usually have OpenAPI-based names.

# OpenAPI is an open source and vendor-neutral format

The OpenAPI does not evolve by itself randomly; a community and rules are guiding its evolution.

## It's managed by the OpenAPI Initiative

When the Swagger Specification was donated to the API community in 2015, it was donated to a newly created organization named the [OpenAPI Initiative](https://www.openapis.org/) (OAI). The OAI is an open governance structure operating under the Linux Foundation.

> The OpenAPI Initiative (OAI) was created by a consortium of forward-looking industry experts who recognize the immense value of standardizing on how APIs are described.

The OpenAPI not only aims to evolve the OpenAPI format, but it also promotes it. For instance, the OpenAPI organizes the [API Specification Conference (ASC)](https://events.linuxfoundation.org/openapi-asc/), where all practitioners of all API specifications (OpenAPI, AsyncAPI, JSON Schema, GraphQL, gRPC, ...) gather to share their knowledge, stories, questions, ...

## It's a vendor-neutral format

Though various vendors support the OpenAPI Initiative, it is a vendor-neutral format. The OpenAPI format will evolve for the greater good and not the specific needs of a vendor solution (but don't worry, there is a solution for that in a few paragraphs).

## It's a community-driven open source format

The Technical Steering Committee guides the evolution of the OpenAPI Specification by bringing their expertise and incorporating the community's feedback. 

The API community can also contribute simply by using the OpenAPI Specification and sharing what they do with it.

Individuals and organizations can participate and don't hesitate to [contribute](https://www.openapis.org/participate/how-to-contribute).

# OpenAPI is "open" but not only for open APIs

[Naming](https://martinfowler.com/bliki/TwoHardThings.html) is hard. Let's be honest the "OpenAPI Specification" name has left more than one of us dubious about its meaning and even how to write it. To be honest, we didn't know what Swagger was about either (especially when you speak Frenglish), but it sounded cooler.

## It's "OpenAPI" and not "Open API"

It is pretty prosaic but interesting to know, as it shows consistency in design can be challenging. In the beginning, everyone was unsure if it was "Open API" or "OpenAPI." The original website was presenting the "OpenAPI initiative" and the "Open API Specification" (or was it the opposite?). Everything is settled; it's the OpenAPI (1 word) Specification and the OpenAPI (1 word also) Initiative.

## It's not reserved to open APIs (public APIs)

As the OpenAPI Specification contains the words "open" and "API," it is not that rare to hear "OpenAPI is for public/open APIs" or "Will using OpenAPI make my APIs public/open?".

An "Open API" or "Public API" is an API that an organization provides to almost anyone willing to accept its terms of service. For instance, companies such as Stripe or Twilio provide public/open APIs. Thanks (or because) of European PSD2 regulations, all European Union banks provide some public/open APIs (accessible to authorized third parties).

The OpenAPI Specification is unrelated to the open/public APIs concerns. Any API can be described using the OpenAPI Specification, and using it does not change its visibility. So, you can use it safely for your private and partner APIs (the ones you build only for yourself or the ones you provide to a few selected partners). And you can also use it for your public/open APIs.

## It's an open format bringing interoperability

The specification itself is "open" because it's open source. What is "open" is also the consequence of using the specification. It facilitates the creation of APIs and so enables the opening of systems. It brings interoperability between solutions and opens software solutions using it to others. 

# OpenAPI is a source of endless possibilities for API tools and practices

The OpenAPI Specification already offers many opportunities, and the API community has only scratched the surface.

## It is a design-first and API-first pillar

The OpenAPI specification can be used during the design phase of an API. It can be written in a code editor like VS Code or generated by an API design tool like Stoplight Studio. That way of using OpenAPI helped to change the mindset of many regarding how to create APIs and help promoted design-first and API-first strategies.

## It has numerous other usages

The possibilities are endless because it's a machine-readable and machine-writable format. It can be of great of for API governance: use Spectral to lint an OpenAPI document to ensure it respects some API design guidelines. It can be used at the infrastructure level to configure an API gateway. It can be used to generate documentation (HTML, Postman Collection ...), generate server or client code, validate incoming API requests, and generate tests... It can be generated from logs to reverse engineer an existing API.

## It's extensible

The possibilities are also endless because the OpenAPI Specification is extensible. Though the format is vendor-neutral, so you can't add specific elements shared by all in the original specification, it allows you to add customs information by yourself. You have to add the custom information in  `x-named` properties (that can be atomic values or objects), and standard OpenAPI parsers will ignore those properties. For instance, while an API gateway solution may take advantage of the OpenAPI format for most configurations, it may sometimes need gateway-specific elements, which could be put under an `x-gateway-configuration`  inside each API operation.

# OpenAPI is the Rosetta Stone of the Web API world

What precedes is all "what is OpenAPI," making it the Rosetta Stone of the Web API world. If you're not familiar with this part of history and its use in the English language, the Merriam-Webster dictionary says the Rosetta stone _is:_

1. A black basalt stone found in 1799 that bears an inscription in hieroglyphics, demotic characters, and Greek and is celebrated for having given the first clue to the decipherment of Egyptian hieroglyphics
2. One that gives a clue to understanding

The OpenAPI Specification is the Rosetta Stone of the Web API world because:

3. Like the Rosetta Stone, a bridge between Egyptian hieroglyphics and Greek, OpenAPI is a bridge. It's a bridge between API tools (vendors, open source). It helps build a bridge between all people involved in creating and consuming APIs (business stakeholders, product owners, designers, implementers, consumers, etc...)
4. OpenAPI gives an understanding of what an API or a set of APIs is. It's a guide when you define them. It helps you understand APIs you didn't create yourself. It can help you understand the API surface of a system, an organization, or a domain across many organizations