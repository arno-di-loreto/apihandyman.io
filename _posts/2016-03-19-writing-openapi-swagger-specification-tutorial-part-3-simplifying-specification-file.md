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
categories:
  - OpenAPI (Swagger) Specification
---
After [learning the basics](/writing-openapi-swagger-specification-tutorial-part-2-the-basics/) and having written a *little bit huge* file for a *so simple* API, you may be concerned by what nightmare it could be to handle a bigger and more complex API. REST assured that the [OpenAPI Specification (formerly Swagger Specification)](https://openapis.org/) format offers all means to write really *small and simple* specification files whatever the described API's size and complexity. 
 
# Writing OpenAPI (fka Swagger) Specification tutorial
This tutorial is composed of several posts:

- Part 1: [Introduction](/writing-openapi-swagger-specification-tutorial-part-1-introduction/)
- Part 2: [The basics](/writing-openapi-swagger-specification-tutorial-part-2-the-basics/)
- Part 3: **Simplifying specification file**
- Part 4: [Advanced data modeling](/writing-openapi-swagger-specification-tutorial-part-4-advanced-data-modeling)
- Part 5: [Advanced input and output modeling](/writing-openapi-swagger-specification-tutorial-part-5-advanced-input-and-output-modeling/)
- Part 6: [Defining security](/writing-openapi-swagger-specification-tutorial-part-6-defining-security)
- Part 7: [Documentation](/writing-openapi-swagger-specification-tutorial-part-7-documentation/)
- Part 8: [Splitting specification file](http://apihandyman.io/writing-openapi-swagger-specification-tutorial-part-8-splitting-specification-file/)
- Part 9: Extending the OpenAPI specification (coming soon)

All tutorial's files are available on [gist](https://gist.github.com/arno-di-loreto/5a3df2250721fb154060).

If you're a bit lost in the [specification](https://github.com/OAI/OpenAPI-Specification/blob/master/versions/2.0.md), take a look at my [*visual documentation:*
<center>![OpenAPISpecificationVisualDocumentation](/wp-content/uploads/2016/02/OpenAPI-Specification-Visual-Documentation.png "OpenAPI Specification Visual Documentation")
</center>](http://openapi-specification-visual-documentation.apihandyman.io/)

In this third part you will learn how to simplifiy the specification file by defining *reusable* *definitions*, *responses* and *parameters* and using them with *references* and thus make the writing and reading of OpenAPI Specification fairly easy.


# 1 Simplifying data model description
We'll use the final example of the [previous part](/writing-openapi-swagger-specification-tutorial-part-2-the-basics/) as starting point. When taking a look at this specification file, the obvious problem is that a *Person* is defined three times:
[gist id="5a3df2250721fb154060" file="simple_openapi_specification_05_with_body_parameter.yaml"  highlight="33-41,50-58,78-86" show_meta="1"]

By using *reusable definitions* this *not so simple specification* will be transformed into this one:
[gist id="5a3df2250721fb154060" file="simple_openapi_specification_06_with_definitions.yaml" highlight="31,40,60,64-78" show_meta="1"]

The *OpenAPI Specification [definitions section (Swagger Object)](https://github.com/OAI/OpenAPI-Specification/blob/master/versions/2.0.md#swaggerObject)* allows you to define *once and for all* objects/entities/models that can be used anywhere in the specification (i.e. where a *[schema](https://github.com/OAI/OpenAPI-Specification/blob/master/versions/2.0.md#schemaObject)* is defined).

## 1.1 Adding definitions section
We'll start by adding a new *definitions* section at the end of the document (nb: it can be placed anywhere as long as it's on the root of the OpenAPI Specification tree structure).
[gist id="5a3df2250721fb154060" file="simple_openapi_specification_06_with_definitions.yaml" lines="61-64" highlight="64" show_meta="0"]

## 1.2 Defining a reusable definition
Then we define a *Person* once and for all in the *definitions* section:
[gist id="5a3df2250721fb154060" file="simple_openapi_specification_06_with_definitions.yaml" lines="64-74" highlight="65-74" show_meta="0"]

Note that the information provided in *Person* are exactly the same as the one provided in the three schemas describing a person in previous version. A *[definition](https://github.com/OAI/OpenAPI-Specification/blob/master/versions/2.0.md#definitionsObject)* is simply a named *[schema object](https://github.com/OAI/OpenAPI-Specification/blob/master/versions/2.0.md#schemaObject)*.

## 1.3 Referencing a definition from another definition
We'll start using this newly created *definition* by referencing it in another one. As we have defined a *Person* we'll also define *Persons* which is an array (or a list) of *Persons*. The information provided in *Persons* are *almost* the same as the one provided in the *get /persons* response:
[gist id="5a3df2250721fb154060" file="simple_openapi_specification_05_with_body_parameter.yaml"  lines="29-41" show_meta="0"]

The only difference is that the schema describing the array's *items* has been replaced by a *[reference ($ref)](https://github.com/OAI/OpenAPI-Specification/blob/master/versions/2.0.md#referenceObject)* to the *Persons definition*.
[gist id="5a3df2250721fb154060" file="simple_openapi_specification_06_with_definitions.yaml" lines="75-78" highlight="78" show_meta="0"]
A reference is only a path to another declaration within the OpenAPI Specification.

## 1.4 Using definitions in responses
Once we have defined *Person* and *Persons*, we can use them to replace the inline schemas by references in all operations responses. 

### 1.4.1 get /persons
Before
[gist id="5a3df2250721fb154060" file="simple_openapi_specification_05_with_body_parameter.yaml" lines="27-39" highlight="31-39" show_meta="0"]
After
[gist id="5a3df2250721fb154060" file="simple_openapi_specification_06_with_definitions.yaml" lines="27-31" highlight="31" show_meta="0"]

### 1.4.2 get /persons/{username}
Before
[gist id="5a3df2250721fb154060" file="simple_openapi_specification_05_with_body_parameter.yaml" lines="74-86" highlight="78-86" show_meta="0"]
After
[gist id="5a3df2250721fb154060" file="simple_openapi_specification_06_with_definitions.yaml" lines="56-60" highlight="60" show_meta="0"]

## 1.5 Using definitions in parameters
Definitions are not only meant to be used within the *definitions* section (it would be pointless), they can also be used in operations *parameters*.

### 1.5.1 post /persons:
Before
[gist id="5a3df2250721fb154060" file="simple_openapi_specification_05_with_body_parameter.yaml" lines="42-58" highlight="50-58" show_meta="0"]
After
[gist id="5a3df2250721fb154060" file="simple_openapi_specification_06_with_definitions.yaml" lines="32-40" highlight="40" show_meta="0"]

# 2 Simplifying responses description
Now we have discovered references (*$ref*), we'll see they can be used for other matters like *responses* definition. 
[gist id="5a3df2250721fb154060" file="simple_openapi_specification_09_with_responses.yaml" highlight="32-33,48-49,68-69,86-91,93-97" show_meta="1"]

## 2.1 Defining a reusable HTTP 500 response
Let's say, we want *every* API's operation to return an error code and message to provide more detailed information about what happened when an operation failed with an HTTP 500 error.
If we do that the *basic* way, we'll end adding a 500 response on each operation like this: 
[gist id="5a3df2250721fb154060" file="simple_openapi_specification_07_with_responses_wrong.yaml" lines="13-88" highlight="32-39,54-61,81-88" show_meta="1"]

As every operation will handle HTTP 500 error exactly the same way, it's a pity to have to declare three times exactly the same thing.

## 2.2 Defining an Error definition
But, we have learned that we can define a schema once and for all. So let's create an *Error* definition containing string code and message in the *definitions* section.
[gist id="5a3df2250721fb154060" file="simple_openapi_specification_09_with_responses.yaml" lines="71-91" highlight="86-91" show_meta="0"]

A first *almost* good idea would be to use this definition in every operation for 500 response schema. 
[gist id="5a3df2250721fb154060" file="simple_openapi_specification_08_with_responses_less_wrong.yaml" lines="13-74" highlight="35,53,74" show_meta="1"]

## 2.3 Defining a reusable response

But it can be even more simple if we declare a response once and for all within the *OpenAPI Specification [responses section (Swagger Object)](https://github.com/OAI/OpenAPI-Specification/blob/master/versions/2.0.md#swaggerObject)*. This section allows to define reusable responses definitions.
[gist id="5a3df2250721fb154060" file="simple_openapi_specification_09_with_responses.yaml" lines="71-97" highlight="93-97" show_meta="0"]
*Note that the response use the Error definition.*

## 2.4 Using the defined response
Using a defined response is done through a *$ref* (just like we did when using definitions). 
### 2.4.1 get /users
[gist id="5a3df2250721fb154060" file="simple_openapi_specification_09_with_responses.yaml" lines="27-33" highlight="32-33" show_meta="0"]
### 2.4.2 post /users
[gist id="5a3df2250721fb154060" file="simple_openapi_specification_09_with_responses.yaml" lines="43-49" highlight="48-49" show_meta="0"]
### 2.4.3 get /users/{username}
[gist id="5a3df2250721fb154060" file="simple_openapi_specification_09_with_responses.yaml" lines="61-69" highlight="68-69" show_meta="0"]

# 3 Simplifying parameters description
Like models/schemas and responses, parameters description can be simplified easily.
[gist id="5a3df2250721fb154060" file="simple_openapi_specification_13_with_parameters.yaml" highlight="18-20,46-47,72-73,77-79,123-139" show_meta="1"]

## 3.1 Defining a path parameter once for a path
If we add a *delete* operation to the */persons/{username}* path, a first idea could be to do it that way:
[gist id="5a3df2250721fb154060" file="simple_openapi_specification_10_with_single_path_parameter_wrong.yaml" lines="51-85" highlight="56-60,74-78" show_meta="1"]
*Note that we had the good idea to create a reusable 404 response.*

But having to redefine the *username* parameter which is shared by each operation on */persons/{username}* path is a bit cumbersome. Luckily you can define [*parameters* on path level](https://github.com/OAI/OpenAPI-Specification/blob/master/versions/2.0.md#pathItemObject):
[gist id="5a3df2250721fb154060" file="simple_openapi_specification_11_with_single_path_parameter.yaml" lines="51-79" highlight="51-57" show_meta="1"]

## 3.2 Defining reusable parameters

If we add a *get /persons/{username}/friends* operations to get a paginated list of a person's friends, a first idea could be to do it that way:
[gist id="5a3df2250721fb154060" file="simple_openapi_specification_12_with_parameters_wrong.yaml" lines="81-108" highlight="82-87,91-99" show_meta="1"]
*Note that we reuse the 500 and 404 responses*.

But that way, we redefine the *username* parameter just like on path */persons/{username}*:
[gist id="5a3df2250721fb154060" file="simple_openapi_specification_12_with_parameters_wrong.yaml" lines="51-57" highlight="53-57" show_meta="0"]

And we also redefine the *pageNumber* and *pageSize* parameters which already exist on *get /persons*:
[gist id="5a3df2250721fb154060" file="simple_openapi_specification_12_with_parameters_wrong.yaml" lines="14-26" highlight="19-26" show_meta="0"]

### 3.2.1 Define reusable parameters
As we have done with *definitions* and *responses*, we can define reusable parameters within the *OpenAPI Specification [parameters section (Swagger Object)](https://github.com/OAI/OpenAPI-Specification/blob/master/versions/2.0.md#swaggerObject)*.

[gist id="5a3df2250721fb154060" file="simple_openapi_specification_13_with_parameters.yaml" lines="123-139" show_meta="0"]

### 3.2.2 Use reusable parameters
These reusable parameters can be used with a reference just like definitions and responses.

#### 3.2.2.1 get /persons
Before
[gist id="5a3df2250721fb154060" file="simple_openapi_specification_12_with_parameters_wrong.yaml" lines="14-26" highlight="19-26" show_meta="0"]

After
[gist id="5a3df2250721fb154060" file="simple_openapi_specification_13_with_parameters.yaml" lines="14-20" highlight="19-20," show_meta="0"]

#### 3.2.2.2 get and delete /persons/{username}
Before
[gist id="5a3df2250721fb154060" file="simple_openapi_specification_12_with_parameters_wrong.yaml" lines="51-57" highlight="53-57" show_meta="0"]

After
[gist id="5a3df2250721fb154060" file="simple_openapi_specification_13_with_parameters.yaml" lines="45-47" highlight="47" show_meta="0"]

#### 3.2.2.3 get /persons/{username}/friends
Before
[gist id="5a3df2250721fb154060" file="simple_openapi_specification_12_with_parameters_wrong.yaml" lines="81-99" highlight="83-87,92-99" show_meta="0"]

After
[gist id="5a3df2250721fb154060" file="simple_openapi_specification_13_with_parameters.yaml" lines="71-79" highlight="73,78-79" show_meta="0"]

# Conclusion
By defining reusable *definitions*, *responses* and *parameters* and using them with *references* you can easily write OpenAPI Specification files which are simple and easily understandable. 
In [next post](/writing-openapi-swagger-specification-tutorial-part-4-advanced-data-modeling/), we'll dig deeper in various aspect of the OpenAPI Specification.