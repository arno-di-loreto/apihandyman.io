---
title: Writing OpenAPI (Swagger) Specification Tutorial - Part 9 - Extending the OpenAPI specification
date: 2017-02-19
author: Arnaud Lauret
layout: post
permalink: /writing-openapi-swagger-specification-tutorial-part-9-extending-the-openapi-specification/
category: post
tags:
  - OpenAPI
  - Swagger
  - API Specification
  - Documentation
  - API First
tools:
  - OpenAPI Specification
series: Writing OpenAPI (Swagger) Specification Tutorial
series_title: Extending the OpenAPI specification
series_number: 9
codefiles: writing-openapi-swagger-specification-tutorial
---
This is the end, my OpenAPI friends, the end. The end? Not really. This last part of the OpenAPI tutorial is a new beginning. With previous parts we have learned to master the OpenAPI specification but there's a last thing to learn to unleash its full power: extensions. This format is easily extensible, it allows to add custom data within an API description. But for what purposes? Let's have a glimpse of these extensions endless possibilities.
<!--more--> 

{% include _postincludes/writing-openapi-swagger-specification-tutorial.md %}

In this final part we'll learn how to extend the OpenAPI specification to add custom data and most important, we'll discover why we would do that.

# One size may not fit all

After working for a while with the OpenAPI format, you WILL want to add other data into you API descriptions, this is your destiny. Fortunately, the creator of the format had foreseen that:  

> While the Swagger Specification tries to accommodate most use cases, additional data can be added to extend the specification at certain points.  
> *[OpenAPI Specification](https://github.com/OAI/OpenAPI-Specification/blob/master/versions/2.0.md#vendorExtensions)*

Once known as *Vendor Extensions*, these *Specification Extensions* can be created by anyone, don't be fooled by their original name. 

## Custom property

To add a custom property with an OpenAPI definition file you only need to prefix its name by `x-`: 

{% code language:yaml %}
x-<what you want>: <value>
{% endcode %}

Here's a custom property `x-custom-info` in the `info` section of an OpenAPI file:

{% codefile file:simple_openapi_specification_53_custom_property.yaml lines:3-7 highlight:7 %} 

If a standard Swagger/OpenAPI parser encounters such property, it will ignore it because it's prefixed with `x-`. This `info` section with a custom property is valid:

{% img file:custom-property.png %}

## Custom object

Extensions are not only meant to be atomic properties, they can also be objects:

{% codefile file:simple_openapi_specification_54_custom_object.yaml lines:3-13 highlight:7-13 %}

Note that sub-properties names do not need to be prefixed with `x-`.

## Extensions almost anywhere

These custom data structures can be added almost anywhere in the specification. You can test if a location is ok by simply adding your extension where you want within the online editor and see if the validator complains or not.

You can also take a look at my [visual documentation](http://openapi-specification-visual-documentation.apihandyman.io/) to check if the location you want to use allows extension or not: 

{% img file:almost-anywhere.png source:"http://openapi-specification-visual-documentation.apihandyman.io/" %}

Here's an example using various location (non-exhaustive example):

{% codefile file:simple_openapi_specification_55_extensions_almost_anywhere.yaml language:yaml highlight:"3,9-15,24,32,37"%}

# Why customizing the OpenAPI specification?

So, adding custom information within an OpenAPI specification file is fairly easy. But the question is less about the how and more about the why. Why would you add custom data to your OpenAPI files?

You can use some extensions provided by open source or commercial tools or create your own. You can simply add custom data without processing them for documentation purpose or use these informations to generate documentation, client code, server code or tests or even configure some tools.

Let's see some examples.    
*nb: This post is not a sponsored one.*

## Example 1: Documentation
[Gelato, the Mashape Developer Portal solution](https://docs.gelato.io/guides/control-grouping-with-swagger), uses the [`x-gelato-group`](https://docs.gelato.io/guides/control-grouping-with-swagger) extension to group operations in the portal navigation.

{% img file:gelato.png %}

Of course, as an OpenAPI expert you would have use tags to do that. Beware to not reinvent the wheel when creating your extensions.

## Example 2: Client code generation

[API Matic, a SDK/DX kits generator](https://docs.apimatic.io/advanced/swagger-test-cases-extensions/) uses extension ton control SDK generation.

{% img file:apimatic.png %}

## Example 3: Server code generation

[Swagger Node, a node module which help to build API implementation with a design first approach](https://github.com/swagger-api/swagger-node) uses a `x-swagger-router-controller` extension to link an API endpoint to its controller implementation.

{% img file:swagger-node.png %}

## Example 4: API gateway configuration

Not only the AWS API gateway allows to import a Swagger/OpenAPI file but it also provides a [complete set of extensions]((http://docs.aws.amazon.com/apigateway/latest/developerguide/api-gateway-swagger-extensions.html)) to configure how the API is linked to backend systems (like lambda).

{% img file:aws-api-gateway.png %}

# Conclusion
This post concludes the OpenAPI/Swagger specification tutorial. You master now every single aspect of the OpenAPI specification and with this last post I hope to have given you some ideas to be creative to include this format in each step of the API lifecycle.
