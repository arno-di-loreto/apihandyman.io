---
title: Introduction
series: Writing OpenAPI (Swagger) Specification Tutorial
series_number: 1
date: 2016-03-02
author: Arnaud Lauret
layout: post
permalink: /writing-openapi-swagger-specification-tutorial-part-1-introduction/
category: post
tools:
  - OpenAPI Specification
codefiles: writing-openapi-swagger-specification-tutorial
---
Previously in the APIverse...  
Since I started my [*Swagger* journey](/starting-a-swagger-journey-beyond-generated-swagger-ui/), there have been *some* changes. The *Swagger Specification* has been [donated](http://swagger.io/introducing-the-open-api-initiative/) to the newly created [OpenAPI Initiative](https://openapis.org/news/announcement/2015/11/new-collaborative-project-extend-swagger-specification-building-connected) under the Linux foundation and is reborn as the *[OpenAPI Specification](http://apievangelist.com/2016/01/04/the-openapi-specification-fka-the-swagger-specification/)*. Therefore, my Swagger Journey will become an *OpenAPI Specification (fka Swagger Specification) Journey*.<!--more-->

This first part explains what is the OpenAPI Specification, why you *will* use it and what tools you can use to write these specifications.

{% include _postincludes/writing-openapi-swagger-specification-tutorial.md %}

# The OpenAPI Specification

The OpenAPI Specification is an API description format or API definition language. Basically, an OpenAPI Specification file allow you to describe an API including (among other things):

- General information about the API
- Available paths (/resources)
- Available operations on each path (get /resources)
- Input/Output for each operation

The Open API Specification's specification can be found in the [github repository of the Open API Initiative](https://github.com/OAI/OpenAPI-Specification/blob/master/versions/2.0.md). This document describes every aspect of the Open API Specification.
Even if this documentation is fairly easy to read, I was sometimes a little bit lost. So, based on this *text* specification, I have created the *[OpenAPI Map](http://openapi-map.apihandyman.io/?version=2.0)* a *visual* documentation which can help to figure how a OpenAPI specification file is structured for people who are more visual like me.

{% img file:"/images/commons/openapi/openapi-map-v2.png" label:"OpenAPI Map" source:"http://openapi-map.apihandyman.io/?version=2.0" %}

Reading the specification is not mandatory to do this tutorial, you can dig into the specification as you discover it through this tutorial.

# Why using an API definition language such as OpenAPI specification?
Using an API definition language such as OpenAPI specification helps to describe easily and quickly an API. It's particularly useful when you're in the design process of your API (cf. my [first post in the series](/starting-a-swagger-journey-beyond-generated-swagger-ui/)).

Being a simple text file, the OpenAPI specification file can be shared and managed within any [VCS](https://en.wikipedia.org/wiki/Version_control) just like [code][/code](http://blog.smartbear.com/documentation/the-utopia-of-api-documentation/).

Once written, OpenAPI specification file can also be used as:

- source material for documentation
- specification for developers
- partial or complete code generation
- and many other things...

# Writing OpenAPI Specification

What can we use to write an OpenAPI Specification file?

> You kids keep your noses clean, you understand? You'll be hearing from me if you don't! We ain't gonna stand for any weirdness out here! 
> *[Officer Dorf](http://www.imdb.com/name/nm0589798/?ref_=tt_trv_qu) about OpenAPI Specification writing*

## JSON vs YAML

{% img file:fridopenapi.png %}

An Open API Specification file can be written either in [JSON](https://en.wikipedia.org/wiki/JSON) or [YAML](https://en.wikipedia.org/wiki/YAML). But, if you intend to *write* and not generate this file, I urge you to do that in YAML as YAML is far more easy to write and read than JSON.

A picture is worth a thousand words, let's compare a simple definition in JSON...
{% codefile file:simple_openapi_specification_00_YAML_vs_JSON.json %}

...to the same definition in YAML:
{% codefile file:simple_openapi_specification_02_with_operation.yaml %}

YAML seems definitely more easy to write and read for humans. And almost every tool using OpenAPI specification files handle YAML. In last resort, you can easiliy convert YAML to JSON (and vice versa).

## Editor
Even if an OpenAPI specification is a simple text file which can be edited with any text editor, it's better to use a specialized one. The best available tool to write Open API Specification file is *Swagger Editor*. It's a set of static file allowing you to write and validate Open API Specification in YAML and see a rendering of the written specification.

{% img file:swaggereditor-petstore.png %}
  
On the left pane, you write your API definition.
On the right one you see a rendering of your definition and potential syntax errors.

The editor also provides useful snippets to guide you:
{% img file:swagger.editor.gif %}

You can use the [online version](http://editor.swagger.io/) but you can also have your own editor instance on any http server. You just need to download the [lastest build](https://github.com/swagger-api/swagger-editor/releases/latest) and serve it with an http server. Go to [Swagger Editor Github repository](https://github.com/swagger-api/swagger-editor/#running-locally) for a complete how-to.

# What about writing your first OpenAPI Specification?

{% img file:jason.gif label:"YAML + editor. You've been warned." %}
  
We are now ready to proceed to [Part 2 - The basics](/writing-openapi-swagger-specification-tutorial-part-2-the-basics/) and write our first API definition using the Open API Specification.
