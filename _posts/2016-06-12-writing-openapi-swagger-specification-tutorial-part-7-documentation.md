---
id: 1118
title: 'Writing OpenAPI (Swagger) Specification Tutorial - Part 7 - Documentation'
date: 2016-06-12T21:22:15+00:00
author: Arnaud Lauret
layout: post
guid: http://apihandyman.io/?p=1118
permalink: /writing-openapi-swagger-specification-tutorial-part-7-documentation/
dsq_thread_id:
  - 4905047708
category: Posts
tags:
  - OpenAPI
  - Swagger
  - API Specification
  - Documentation
  - API First
series: Writing OpenAPI (Swagger) Specification Tutorial
series_title: Part 7 - Documentation
---
Previous [posts](http://apihandyman.io/category/openapi-swagger-specification/) showed how to write a highly accurate description of an API interface contract with the [OpenAPI specification](https://openapis.org/). But an interface contract, no matter how brilliant, is nothing without some explainations. A fully documented OpenAPI specification file can provide some useful information and be used as a part of an API's documentation.<!--more-->

# Writing OpenAPI (fka Swagger) Specification tutorial
This tutorial is composed of several posts:

- Part 1: [Introduction](/writing-openapi-swagger-specification-tutorial-part-1-introduction/)
- Part 2: [The basics](/writing-openapi-swagger-specification-tutorial-part-2-the-basics/)
- Part 3: [Simplifying specification file](/writing-openapi-swagger-specification-tutorial-part-3-simplifying-specification-file/)
- Part 4: [Advanced data modeling](/writing-openapi-swagger-specification-tutorial-part-4-advanced-data-modeling/)
- Part 5: [Advanced input and output modeling](/writing-openapi-swagger-specification-tutorial-part-5-advanced-input-and-output-modeling/)
- Part 6: [Defining security](/writing-openapi-swagger-specification-tutorial-part-6-defining-security)
- Part 7: **Documentation**
- Part 8: [Splitting specification file](/writing-openapi-swagger-specification-tutorial-part-8-splitting-specification-file/)
- Part 9: Extending the OpenAPI specification (coming soon)

In previous parts we've learned to create highly accurate API description, in this seventh part we'll learn how to use the OpenAPI specification to make it a valuable part of an API documentation.

All tutorial's files are available on [GIST](https://gist.github.com/arno-di-loreto/5a3df2250721fb154060).

If you're a bit lost in the [specification](https://github.com/OAI/OpenAPI-Specification/blob/master/versions/2.0.md), take a look at my [*visual documentation:*
![OpenAPISpecificationVisualDocumentation](/images/writing-openapi-swagger-specification-tutorial/openapi-specification-visual-documentation.png "OpenAPI Specification Visual Documentation")
](http://openapi-specification-visual-documentation.apihandyman.io/)

# API's general informations
First things first. When using an API, API consumers want to have some general informations about it like its version, its name, some description, term of service, how to contact the API provider, what kind of licencing it uses. The [`info`](https://github.com/OAI/OpenAPI-Specification/blob/master/versions/2.0.md#infoObject) object placed on root level can be used to provide such information:

{% gist id:5a3df2250721fb154060 file:simple_openapi_specification_21_documentation.yaml lines:"3-14" footer:true %}

# Categorizing operations with Tags
By using `tags` on operation level, we can categorize operations. `tags` is a simple list of names.

## Single tag
This operation belongs to the `Person` category:

{% gist id:5a3df2250721fb154060 file:simple_openapi_specification_21_documentation.yaml lines:"78-87" highlight:"86-87" footer:true %}

## Multiple tags
An operation can belong to different categories:

{% gist id:5a3df2250721fb154060 file:simple_openapi_specification_21_documentation.yaml lines:"152-162" highlight:"160-162" footer:true %}

# Descriptions everywhere
We can add some descriptions at almost every level of the OpenAPI specification.

## Security definitions
A `description` can be added to security definitions:

{% gist id:5a3df2250721fb154060 file:simple_openapi_specification_21_documentation.yaml lines:"54-71" highlight:"56,65,70" footer:true %}

## Schema title and description
Each schema (used in a definition, a parameter or a response) can have a `title` and a `description`:

{% gist id:5a3df2250721fb154060 file:simple_openapi_specification_21_documentation.yaml lines:"460-463" highlight:"462,463" footer:true %}

{% gist id:5a3df2250721fb154060 file:simple_openapi_specification_21_documentation.yaml lines:"500-502" highlight:"501,502" footer:true %}

## Property description
Properties can be described with `description`:

{% gist id:5a3df2250721fb154060 file:simple_openapi_specification_21_documentation.yaml lines:"466-469" highlight:"468" footer:true %}

## Parameter's description
Whether defined inline or in `parameters` section, a parameter can have a `description`.

### Inline parameter's description
{% gist id:5a3df2250721fb154060 file:simple_openapi_specification_21_documentation.yaml lines:"78-79" footer:false %}
{% gist id:5a3df2250721fb154060 file:simple_openapi_specification_21_documentation.yaml lines:"110" footer:false %}
{% gist id:5a3df2250721fb154060 file:simple_openapi_specification_21_documentation.yaml lines:"120-126" highlight:"124" footer:true %}

### Reusable parameter's description
{% gist id:5a3df2250721fb154060 file:simple_openapi_specification_21_documentation.yaml lines:"702-712" highlight:"707,712" footer:true %}

## Operation's summary, description and operationId:
An operation can be described with a `summary` and a longer `description`. An `operationId` can be added. It can be used as a link to the implementation running behind the API for example.

{% gist id:5a3df2250721fb154060 file:simple_openapi_specification_21_documentation.yaml lines:"78-85" highlight:"83-85" footer:true %}

## Response's description
Whether inline or defined in `responses`, a response can have a `description`.

### Inline response's description
{% gist id:5a3df2250721fb154060 file:simple_openapi_specification_21_documentation.yaml lines:"78-82" footer:false %}
{% gist id:5a3df2250721fb154060 file:simple_openapi_specification_21_documentation.yaml lines:"93-95" highlight:"95" footer:true %}

### Reusable response's description
{% gist id:5a3df2250721fb154060 file:simple_openapi_specification_21_documentation.yaml lines:"668-670" highlight:"670" footer:true %}

## Reponse's header's description
Headers returned with a response can have a `description`:
 
{% gist id:5a3df2250721fb154060 file:simple_openapi_specification_21_documentation.yaml lines:"671-678" highlight:"673,676" footer:true %}

## Tags descriptions
Tags can have `descriptions`. We need to add a `tags` section on specification file root level, on each item in this list we set a `name` (corresponding to the name used in tags list on operation level) and a `description`:
{% gist id:5a3df2250721fb154060 file:simple_openapi_specification_21_documentation.yaml lines:"20-22" footer:true %}

# Using GFM in descriptions
In almost all `description`, we can use `GFM` ([Github Flavored Markdown](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet)). To check if an object description support GFM, take a look at my [visual documentation](http://openapi-specification-visual-documentation.apihandyman.io/) or the original [specification](https://github.com/OAI/OpenAPI-Specification/blob/master/versions/2.0.md).
*Note that GFM support can vary depending the tool processing the OpenAPI specification file.*

## Simple multiline description
By adding a `|` and a new line with a new tab, we can write multiline descriptions:
{% gist id:5a3df2250721fb154060 file:simple_openapi_specification_22_documentation_with_gfm.yaml lines:"320-328" highlight:"326-328" footer:true %}

## Simple GFM description
{% gist id:5a3df2250721fb154060 file:simple_openapi_specification_22_documentation_with_gfm.yaml lines:"27-30" highlight:"28-29" footer:true %}

## Description with array
{% gist id:5a3df2250721fb154060 file:simple_openapi_specification_22_documentation_with_gfm.yaml lines:"598-616" highlight:"604-611" footer:true %}

## Description with code
{% gist id:5a3df2250721fb154060 file:simple_openapi_specification_22_documentation_with_gfm.yaml lines:"1-18" highlight:"6-17" footer:true %}

# Examples
Examples can be provided for atomic or object properties, definitions, and responses.

## Atomic property example
Atomic properties can be illustrated with an `example`:

{% gist id:5a3df2250721fb154060 file:simple_openapi_specification_21_documentation.yaml lines:"466-492" highlight:"470,474,481,486,492" footer:true %}

## Object property example
Object properties, can also be illustrated with a complex `example` complying to the underlying JSON Schema:

{% gist id:5a3df2250721fb154060 file:simple_openapi_specification_21_documentation.yaml lines:"515-539" highlight:"529-539" footer:true %}

## Definition Example
An example can be defined for the entire definition just like for an object property (it must conforms to its underlying JSON schema):

{% gist id:5a3df2250721fb154060 file:simple_openapi_specification_21_documentation.yaml lines:"553-567" highlight:"561-567" footer:true %}

## Response's Example
On response level, we can provide `example`, each one corresponding to a media type returned by the operation. Here's an example for an application/json media type:

{% gist id:5a3df2250721fb154060 file:simple_openapi_specification_21_documentation.yaml lines:"308" footer:false %}
{% gist id:5a3df2250721fb154060 file:simple_openapi_specification_21_documentation.yaml lines:"312" footer:false %}
{% gist id:5a3df2250721fb154060 file:simple_openapi_specification_21_documentation.yaml lines:"324-325" footer:false %}
{% gist id:5a3df2250721fb154060 file:simple_openapi_specification_21_documentation.yaml lines:"337-374" highlight:"337-368" footer:true %}

## Examples precedence
If we defined examples on multiple levels (property, object, definition, response), it's always the higher level which is taken into account by tools processing OpenAPI specification file.

# Operation's deprecation
An operation can be deprecated by setting `deprecated` to `true`:

{% gist id:5a3df2250721fb154060 file:simple_openapi_specification_21_documentation.yaml lines:"152-159" highlight:"159" footer:true %}

# Links to external API documentation
In most case, the OpenAPI specification file MUST NOT be the only API's documentation. How to create an application key, use cases, operation chaining and many other things need to be documented. All these other documentations can be separated from the specification file.
However, the OpenAPI specification allow to provide links to these other documentations when needed.

## Link to general API documentation
We can add an [`externalDoc`](https://github.com/OAI/OpenAPI-Specification/blob/master/versions/2.0.md#externalDocumentationObject) object on root level with a link to the API documentation.

{% gist id:5a3df2250721fb154060 file:simple_openapi_specification_21_documentation.yaml lines:"16-18" footer:true %}

## Link to specific operation documentation 
Each operation can have its own link to an external documentation using the same [`externalDoc`](https://github.com/OAI/OpenAPI-Specification/blob/master/versions/2.0.md#externalDocumentationObject) object:

{% gist id:5a3df2250721fb154060 file:simple_openapi_specification_21_documentation.yaml lines:"375-384" highlight:"382-384" footer:true %}

## Link to tag documentation 
A tag's description can also provide an external link:
{% gist id:5a3df2250721fb154060 file:simple_openapi_specification_21_documentation.yaml lines:"20-25" highlight:"24-25" footer:true %}

# Conclusion
Even if an OpenAPI specification MUST NOT be the only documentation for an API, it can be a good part of it, and you now have mastered this aspect of the specification. In [next post](/writing-openapi-swagger-specification-tutorial-part-8-splitting-specification-file/) we'll see how we can split a OpenAPI specification file in different files.
