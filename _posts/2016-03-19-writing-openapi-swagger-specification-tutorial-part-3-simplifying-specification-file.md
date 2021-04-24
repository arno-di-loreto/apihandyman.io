---
id: 754
title: 'Writing OpenAPI (Swagger) Specification Tutorial - Part 3 - Simplifying specification file'
date: 2016-03-19T17:10:20+00:00
author: Arnaud Lauret
layout: post
guid: http://apihandyman.io/?p=754
permalink: /writing-openapi-swagger-specification-tutorial-part-3-simplifying-specification-file/
dsq_thread_id:
  - 4866935229
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
series_title: Simplifying specification file
series_number: 3
codefiles: writing-openapi-swagger-specification-tutorial
---
After [learning the basics](/writing-openapi-swagger-specification-tutorial-part-2-the-basics/) and having written a *little bit huge* file for a *so simple* API, you may be concerned by what nightmare it could be to handle a bigger and more complex API. REST assured that the [OpenAPI Specification (formerly Swagger Specification)](https://openapis.org/) format offers all means to write really *small and simple* specification files whatever the described API's size and complexity.<!--more--> 

{% include _postincludes/writing-openapi-swagger-specification-tutorial.md %} 

In this third part you will learn how to simplifiy the specification file by defining *reusable* *definitions*, *responses* and *parameters* and using them with *references* and thus make the writing and reading of OpenAPI Specification fairly easy.

# Simplifying data model description
We'll use the final example of the [previous part](/writing-openapi-swagger-specification-tutorial-part-2-the-basics/) as starting point. When taking a look at this specification file, the obvious problem is that a *Person* is defined three times:
{% codefile file:simple_openapi_specification_05_with_body_parameter.yaml  highlight:"33-41,50-58,78-86" footer:true %}

By using *reusable definitions* this *not so simple specification* will be transformed into this one:
{% codefile file:simple_openapi_specification_06_with_definitions.yaml highlight:"31,40,60,64-78" footer:true %}

The *OpenAPI Specification [definitions section (Swagger Object)](https://github.com/OAI/OpenAPI-Specification/blob/master/versions/2.0.md#swaggerObject)* allows you to define *once and for all* objects/entities/models that can be used anywhere in the specification (i.e. where a *[schema](https://github.com/OAI/OpenAPI-Specification/blob/master/versions/2.0.md#schemaObject)* is defined).

## Adding definitions section
We'll start by adding a new *definitions* section at the end of the document (nb: it can be placed anywhere as long as it's on the root of the OpenAPI Specification tree structure).
{% codefile file:simple_openapi_specification_06_with_definitions.yaml lines:"61-64" highlight:"64" footer:false %}

## Defining a reusable definition
Then we define a *Person* once and for all in the *definitions* section:
{% codefile file:simple_openapi_specification_06_with_definitions.yaml lines:"64-74" highlight:"65-74" footer:false %}

Note that the information provided in *Person* are exactly the same as the one provided in the three schemas describing a person in previous version. A *[definition](https://github.com/OAI/OpenAPI-Specification/blob/master/versions/2.0.md#definitionsObject)* is simply a named *[schema object](https://github.com/OAI/OpenAPI-Specification/blob/master/versions/2.0.md#schemaObject)*.

## Referencing a definition from another definition
We'll start using this newly created *definition* by referencing it in another one. As we have defined a *Person* we'll also define *Persons* which is an array (or a list) of *Persons*. The information provided in *Persons* are *almost* the same as the one provided in the *get /persons* response:
{% codefile file:simple_openapi_specification_05_with_body_parameter.yaml  lines:"29-41" footer:false %}

The only difference is that the schema describing the array's *items* has been replaced by a *[reference ($ref)](https://github.com/OAI/OpenAPI-Specification/blob/master/versions/2.0.md#referenceObject)* to the *Persons definition*.
{% codefile file:simple_openapi_specification_06_with_definitions.yaml lines:"75-78" highlight:"78" footer:false %}
A reference is only a path to another declaration within the OpenAPI Specification.

## Using definitions in responses
Once we have defined *Person* and *Persons*, we can use them to replace the inline schemas by references in all operations responses. 

### get /persons
Before
{% codefile file:simple_openapi_specification_05_with_body_parameter.yaml lines:"27-39" highlight:"31-39" footer:false %}
After
{% codefile file:simple_openapi_specification_06_with_definitions.yaml lines:"27-31" highlight:"31" footer:false %}

### get /persons/{username}
Before
{% codefile file:simple_openapi_specification_05_with_body_parameter.yaml lines:"74-86" highlight:"78-86" footer:false %}
After
{% codefile file:simple_openapi_specification_06_with_definitions.yaml lines:"56-60" highlight:"60" footer:false %}

## Using definitions in parameters
Definitions are not only meant to be used within the *definitions* section (it would be pointless), they can also be used in operations *parameters*.

### post /persons:
Before
{% codefile file:simple_openapi_specification_05_with_body_parameter.yaml lines:"42-58" highlight:"50-58" footer:false %}
After
{% codefile file:simple_openapi_specification_06_with_definitions.yaml lines:"32-40" highlight:"40" footer:false %}

# Simplifying responses description
Now we have discovered references (*$ref*), we'll see they can be used for other matters like *responses* definition. 
{% codefile file:simple_openapi_specification_09_with_responses.yaml highlight:"32-33,48-49,68-69,86-91,93-97" footer:true %}

## Defining a reusable HTTP 500 response
Let's say, we want *every* API's operation to return an error code and message to provide more detailed information about what happened when an operation failed with an HTTP 500 error.
If we do that the *basic* way, we'll end adding a 500 response on each operation like this: 
{% codefile file:simple_openapi_specification_07_with_responses_wrong.yaml lines:"13-88" highlight:"32-39,54-61,81-88" footer:true %}

As every operation will handle HTTP 500 error exactly the same way, it's a pity to have to declare three times exactly the same thing.

## Defining an Error definition
But, we have learned that we can define a schema once and for all. So let's create an *Error* definition containing string code and message in the *definitions* section.
{% codefile file:simple_openapi_specification_09_with_responses.yaml lines:"71-91" highlight:"86-91" footer:false %}

A first *almost* good idea would be to use this definition in every operation for 500 response schema. 
{% codefile file:simple_openapi_specification_08_with_responses_less_wrong.yaml lines:"13-74" highlight:"35,53,74" footer:true %}

## Defining a reusable response

But it can be even more simple if we declare a response once and for all within the *OpenAPI Specification [responses section (Swagger Object)](https://github.com/OAI/OpenAPI-Specification/blob/master/versions/2.0.md#swaggerObject)*. This section allows to define reusable responses definitions.
{% codefile file:simple_openapi_specification_09_with_responses.yaml lines:"71-97" highlight:"93-97" footer:false %}
*Note that the response use the Error definition.*

## Using the defined response
Using a defined response is done through a *$ref* (just like we did when using definitions). 
### get /users
{% codefile file:simple_openapi_specification_09_with_responses.yaml lines:"27-33" highlight:"32-33" footer:false %}
### post /users
{% codefile file:simple_openapi_specification_09_with_responses.yaml lines:"43-49" highlight:"48-49" footer:false %}
### get /users/{username}
{% codefile file:simple_openapi_specification_09_with_responses.yaml lines:"61-69" highlight:"68-69" footer:false %}

# Simplifying parameters description
Like models/schemas and responses, parameters description can be simplified easily.
{% codefile file:simple_openapi_specification_13_with_parameters.yaml highlight:"18-20,46-47,72-73,77-79,123-139" footer:true %}

## Defining a path parameter once for a path
If we add a *delete* operation to the */persons/{username}* path, a first idea could be to do it that way:
{% codefile file:simple_openapi_specification_10_with_single_path_parameter_wrong.yaml lines:"51-85" highlight:"56-60,74-78" footer:true %}
*Note that we had the good idea to create a reusable 404 response.*

But having to redefine the *username* parameter which is shared by each operation on */persons/{username}* path is a bit cumbersome. Luckily you can define [*parameters* on path level](https://github.com/OAI/OpenAPI-Specification/blob/master/versions/2.0.md#pathItemObject):
{% codefile file:simple_openapi_specification_11_with_single_path_parameter.yaml lines:"51-79" highlight:"51-57" footer:true %}

## Defining reusable parameters
If we add a *get /persons/{username}/friends* operations to get a paginated list of a person's friends, a first idea could be to do it that way:
{% codefile file:simple_openapi_specification_12_with_parameters_wrong.yaml lines:"81-108" highlight:"82-87,91-99" footer:true %}
*Note that we reuse the 500 and 404 responses*.

But that way, we redefine the *username* parameter just like on path */persons/{username}*:
{% codefile file:simple_openapi_specification_12_with_parameters_wrong.yaml lines:"51-57" highlight:"53-57" footer:false %}

And we also redefine the *pageNumber* and *pageSize* parameters which already exist on *get /persons*:
{% codefile file:simple_openapi_specification_12_with_parameters_wrong.yaml lines:"14-26" highlight:"19-26" footer:false %}

### Define reusable parameters
As we have done with *definitions* and *responses*, we can define reusable parameters within the *OpenAPI Specification [parameters section (Swagger Object)](https://github.com/OAI/OpenAPI-Specification/blob/master/versions/2.0.md#swaggerObject)*.

{% codefile file:simple_openapi_specification_13_with_parameters.yaml lines:"123-139" footer:false %}

### Use reusable parameters
These reusable parameters can be used with a reference just like definitions and responses.

#### get /persons
Before
{% codefile file:simple_openapi_specification_12_with_parameters_wrong.yaml lines:"14-26" highlight:"19-26" footer:false %}

After
{% codefile file:simple_openapi_specification_13_with_parameters.yaml lines:"14-20" highlight:"19-20," footer:false %}

#### get and delete /persons/{username}
Before
{% codefile file:simple_openapi_specification_12_with_parameters_wrong.yaml lines:"51-57" highlight:"53-57" footer:false %}

After
{% codefile file:simple_openapi_specification_13_with_parameters.yaml lines:"45-47" highlight:"47" footer:false %}

#### get /persons/{username}/friends
Before
{% codefile file:simple_openapi_specification_12_with_parameters_wrong.yaml lines:"81-99" highlight:"83-87,92-99" footer:false %}

After
{% codefile file:simple_openapi_specification_13_with_parameters.yaml lines:"71-79" highlight:"73,78-79" footer:false %}

# Conclusion
By defining reusable *definitions*, *responses* and *parameters* and using them with *references* you can easily write OpenAPI Specification files which are simple and easily understandable. 
In [next post](/writing-openapi-swagger-specification-tutorial-part-4-advanced-data-modeling/), we'll dig deeper in various aspect of the OpenAPI Specification.