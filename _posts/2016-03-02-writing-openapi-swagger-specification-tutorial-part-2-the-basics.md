---
id: 752
title: 'Writing OpenAPI (Swagger) Specification Tutorial - Part 2 - The Basics'
date: 2016-03-02T21:07:29+00:00
author: Arnaud Lauret
layout: post
guid: http://apihandyman.io/?p=752
permalink: /writing-openapi-swagger-specification-tutorial-part-2-the-basics/
dsq_thread_id:
  - 4866765277
dsq_needs_sync:
  - 1
category: Posts
tags:
  - OpenAPI
  - Swagger
  - API Specification
  - Documentation
  - API First
series: Writing OpenAPI (Swagger) Specification Tutorial
series_title: Part 2 - The basics
---
After [discovering](/writing-openapi-swagger-specification-tutorial-part-1-introduction/) what is the OpenAPI Specification format, it's now time to write a first simple OpenAPI Specification file to learn the basics. 

# Writing OpenAPI (fka Swagger) Specification tutorial
This tutorial is composed of several posts:

- Part 1: [Introduction](/writing-openapi-swagger-specification-tutorial-part-1-introduction/)
- Part 2: **The basics**
- Part 3: [Simplifying specification file](/writing-openapi-swagger-specification-tutorial-part-3-simplifying-specification-file/)
- Part 4: [Advanced data modeling](/writing-openapi-swagger-specification-tutorial-part-4-advanced-data-modeling)
- Part 5: [Advanced input and output modeling](/writing-openapi-swagger-specification-tutorial-part-5-advanced-input-and-output-modeling/)
- Part 6: [Defining security](/writing-openapi-swagger-specification-tutorial-part-6-defining-security)
- Part 7: [Documentation](/writing-openapi-swagger-specification-tutorial-part-7-documentation/)
- Part 8: [Splitting specification file](http://apihandyman.io/writing-openapi-swagger-specification-tutorial-part-8-splitting-specification-file/)
- Part 9: Extending the OpenAPI specification (coming soon)

All tutorial's files are available on [gist](https://gist.github.com/arno-di-loreto/5a3df2250721fb154060).

If you're a bit lost in the [specification](https://github.com/OAI/OpenAPI-Specification/blob/master/versions/2.0.md), take a look at my [*visual documentation:*
![OpenAPISpecificationVisualDocumentation](/images/writing-openapi-swagger-specification-tutorial/openapi-specification-visual-documentation.png "OpenAPI Specification Visual Documentation")
](http://openapi-specification-visual-documentation.apihandyman.io/)

In this second part you will learn how to give some basic informations about your API, describe endpoints using various HTTP methods with path, query and body parameters and returning various HTTP status and responses. 

# Learning the basics with a first simple API

## 1 An almost empty OpenAPI Specification
We'll start with an almost empty, yet valid, file giving some basic informations.
{% gist id:5a3df2250721fb154060 file:simple_openapi_specification_01.yaml footer:true %}

### 1.1 OpenAPI Specification version
First we need to tell which version of the OpenAPI specification we are using via the *swagger* attribute... 

{% gist id:5a3df2250721fb154060 file:simple_openapi_specification_01.yaml lines:"1" footer:false %}

Yes, *swagger*. As explained in the [introduction](/writing-openapi-swagger-specification-tutorial-part-1-introduction/), the OpenAPI specification is based on Swagger. It will probably [be replaced by something else](https://github.com/OAI/OpenAPI-Specification/issues/561) in the next version of the specification.
The only possible value is (for now) *2.0*.

### 1.2 API description
Then we give some informations about our API with *[info](https://github.com/OAI/OpenAPI-Specification/blob/master/versions/2.0.md#infoObject)*: the API's *version* (not to be confused with the specification version and the file version) a *title* and an optionnal *description*.
{% gist id:5a3df2250721fb154060 file:simple_openapi_specification_01.yaml lines:"3-6" footer:false %}

### 1.3 API URL
Speaking of *web* API, an important information is the root URL which people and programs will use to call it.
This is described by [giving](https://github.com/OAI/OpenAPI-Specification/blob/master/versions/2.0.md#swaggerObject) a list of accepted *schemes* (or protocols, like http or https), a *host*, and a *basepath*. 
{% gist id:5a3df2250721fb154060 file:simple_openapi_specification_01.yaml lines:"8-11" footer:false %}

All of these APIs endpoints URL will use *https://simple.api/open101* as base URL.
These informations are not required, an OpenAPI specification without these data is still valid.

### 1.4 API operations
Finally, as our API does absolutely nothing for now, we add an empty paths list. (nb. in YAML an empty object is describe using *{}*).
{% gist id:5a3df2250721fb154060 file:simple_openapi_specification_01.yaml lines:"13" footer:false %}

## 2 Defining an operation
Let our API do something by adding an operation to *list some persons*.
{% gist id:5a3df2250721fb154060 file:simple_openapi_specification_02_with_operation.yaml highlight:"13-32" footer:true %}

### 2.1 Adding a path
In the *paths* section we add a new path */persons* corresponding to the *persons* resource.
{% gist id:5a3df2250721fb154060 file:simple_openapi_specification_02_with_operation.yaml lines:"13-14" footer:false %}

### 2.2 Adding an http method on path
On each [path](https://github.com/OAI/OpenAPI-Specification/blob/master/versions/2.0.md#pathItemObject) we can add any [http verb](https://en.wikipedia.org/wiki/Hypertext_Transfer_Protocol#Request_methods) (like *get*, *post*, *put* or *delete*) to manipulate the corresponding resource.
To list some *persons*, we need to apply the *get* http method to the */persons* resource (or path). We also give a short description (*summary*) and a longer one if necessary (*description*).
{% gist id:5a3df2250721fb154060 file:simple_openapi_specification_02_with_operation.yaml lines:"15-17" footer:false %}

Therefore to list some persons we'll have to call *get /persons* (or *get https://simple.api/open101/persons* to be precise).

### 2.3 Describing response
For each operation, you can describe any response matching an [http status code](https://en.wikipedia.org/wiki/List_of_HTTP_status_codes) (like *200 OK* or *404 Not Found*) in the *[responses](https://github.com/OAI/OpenAPI-Specification/blob/master/versions/2.0.md#responsesObject)* section.
We'll only handle *200* when responding to get /persons and we'll tell what the response means via its *description*.
{% gist id:5a3df2250721fb154060 file:simple_openapi_specification_02_with_operation.yaml lines:"18-20" footer:false %}

### 2.4 Describing response's content
The *get /persons* operation returns a list of persons, we describe what it is with the *[schema](https://github.com/OAI/OpenAPI-Specification/blob/master/versions/2.0.md#schemaObject)* section of the response.
A list of person is an object which *type* is *array*. Each item in this array is an object containing three *properties* of type *string*: firstName, lastName and username. Only username will be always provided (i.e. *required*).
{% gist id:5a3df2250721fb154060 file:simple_openapi_specification_02_with_operation.yaml lines:"21-32" footer:false %}

## 3 Defining query parameters
As we'll have to handle many *persons*, it could be a good idea to add paging capabilities to the *get /resources* operation. We'll do that by adding query parameters to define the requested page and number of items per page.
{% gist id:5a3df2250721fb154060 file:simple_openapi_specification_03_with_query_parameters.yaml highlight:"18-26" footer:true %}

### 3.1 Adding a parameters section to the get /persons operation
First we add a *parameters* section in *get* http method for */persons* path.
{% gist id:5a3df2250721fb154060 file:simple_openapi_specification_03_with_query_parameters.yaml lines:"13-18" highlight:"18" footer:false %}

### 3.2 Adding paging query parameters
Then in the *parameters* list we define two optional parameters *named* pageSize and pageNumber of *type* integer located *in* query. We also provide a *description* for each one.   
{% gist id:5a3df2250721fb154060 file:simple_openapi_specification_03_with_query_parameters.yaml lines:"18-27" highlight:"19-26" footer:false %}

Therefore to list some persons we can use *get /persons?pageSize=20&pageNumber=2* and we'll get the page number 2 with 20 persons max.

## 4 Defining a path parameter
We would like to access directly a *specific person* by it's *username*, so we'll add a *get /persons/{username}* operation to our API. *{username}* is called a *path parameter*.
{% gist id:5a3df2250721fb154060 file:simple_openapi_specification_04_with_path_parameter.yaml highlight:"42-66" footer:true %}

### 4.1 Adding a get /persons/{username} operation
First we add a */persons/{username}* path, after the */persons* one, in the *paths* section and define the *get* operation for this path. 
{% gist id:5a3df2250721fb154060 file:simple_openapi_specification_04_with_path_parameter.yaml lines:"1-14" highlight:"13" footer:false %}
{% gist id:5a3df2250721fb154060 file:simple_openapi_specification_04_with_path_parameter.yaml lines:"40-45" highlight:"42-45" footer:false %}

### 4.2 Describing username path parameter
As *{username}* is a path parameter, we need to describe it. It is done by adding a *parameters* section to the *get* operation and adding a *required* parameter with a *name* matching the parameter defined in the path (here username) located *in* path of *type* string. We also provide an optional *description*.
{% gist id:5a3df2250721fb154060 file:simple_openapi_specification_04_with_path_parameter.yaml lines:"46-51" footer:false %}

A common problem when defining path parameter is to forget *required: true* (as the Swagger Editor snippet do not provide it). If *required* is not provided, its default value is *false*, meaning that the parameter is *optional*. A path parameter is always required.

### 4.3 Adding responses
Don't forget to add 200 response returning a *person*. Note that the schema used in 200 is the same as the array's item in *get /persons* 200 response.
{% gist id:5a3df2250721fb154060 file:simple_openapi_specification_04_with_path_parameter.yaml lines:"52-64" highlight:"55-64" footer:false %}

As a username may not match an existing person we also add a 404 response. Note that this response do not return anything besides the 404 http status code. 
{% gist id:5a3df2250721fb154060 file:simple_openapi_specification_04_with_path_parameter.yaml lines:"65-66" footer:false %}

## 5 Defining a body parameter
We would like to have the capability of adding a person to our list of persons so we'll add a *post /persons* operation to our API.
{% gist id:5a3df2250721fb154060 file:simple_openapi_specification_05_with_body_parameter.yaml highlight:"42-63" footer:true %}

### 5.1 Adding post /persons operation
We first add a post method to the /persons path (after the *get* one) in the *paths* section.
{% gist id:5a3df2250721fb154060 file:simple_openapi_specification_05_with_body_parameter.yaml lines:"13-14" footer:false %}

{% gist id:5a3df2250721fb154060 file:simple_openapi_specification_05_with_body_parameter.yaml lines:"42-44" footer:false %}

### 5.2 Describing a person body parameter
Then we define a parameter *named* person located in *body* of *type* object. The person object's is described via it's *schema*. Note that this schema is the same as the 200 response of *get /persons/{username}*. The firstName and lastName attributes are optional and username is *required*.  
{% gist id:5a3df2250721fb154060 file:simple_openapi_specification_05_with_body_parameter.yaml lines:"45-58" highlight:"49-58" footer:false %}

### 5.3 Defining responses
Don't forget to define responses for this new operation.
{% gist id:5a3df2250721fb154060 file:simple_openapi_specification_05_with_body_parameter.yaml lines:"59-63" footer:false %}

# To simplicity and beyond
You now have learned the basics of the OpenAPI Specification. But as you may have guess, working that way on huge API may not be so easy. But rest assured, the OpenAPI Specification files we've seen can be simplified. We'll learn in the [next part](/writing-openapi-swagger-specification-tutorial-part-3-simplifying-specification-file/) how to describe swiftly and easily even the hugest API by using factorization and references.
