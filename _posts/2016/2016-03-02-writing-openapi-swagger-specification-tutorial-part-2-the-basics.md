---
title: The basics
series: Writing OpenAPI (Swagger) Specification Tutorial
series_number: 2
date: 2016-03-02
author: Arnaud Lauret
layout: post
permalink: /writing-openapi-swagger-specification-tutorial-part-2-the-basics/
category: post
tools:
  - OpenAPI Specification
codefiles: writing-openapi-swagger-specification-tutorial
---
After [discovering](/writing-openapi-swagger-specification-tutorial-part-1-introduction/) what is the OpenAPI Specification format, it's now time to write a first simple OpenAPI Specification file to learn the basics.<!--more--> 

{% include _postincludes/writing-openapi-swagger-specification-tutorial.md %}

In this second part you will learn how to give some basic informations about your API, describe endpoints using various HTTP methods with path, query and body parameters and returning various HTTP status and responses. 

# An almost empty OpenAPI Specification
We'll start with an almost empty, yet valid, file giving some basic informations.
{% codefile file:simple_openapi_specification_01.yaml footer:true %}

## OpenAPI Specification version
First we need to tell which version of the OpenAPI specification we are using via the *swagger* attribute... 

{% codefile file:simple_openapi_specification_01.yaml lines:"1" footer:false %}

Yes, *swagger*. As explained in the [introduction](/writing-openapi-swagger-specification-tutorial-part-1-introduction/), the OpenAPI specification is based on Swagger. It will probably [be replaced by something else](https://github.com/OAI/OpenAPI-Specification/issues/561) in the next version of the specification.
The only possible value is (for now) *2.0*.

## API description
Then we give some informations about our API with *[info](https://github.com/OAI/OpenAPI-Specification/blob/master/versions/2.0.md#infoObject)*: the API's *version* (not to be confused with the specification version and the file version) a *title* and an optionnal *description*.
{% codefile file:simple_openapi_specification_01.yaml lines:"3-6" footer:false %}

## API URL
Speaking of *web* API, an important information is the root URL which people and programs will use to call it.
This is described by [giving](https://github.com/OAI/OpenAPI-Specification/blob/master/versions/2.0.md#swaggerObject) a list of accepted *schemes* (or protocols, like http or https), a *host*, and a *basepath*. 
{% codefile file:simple_openapi_specification_01.yaml lines:"8-11" footer:false %}

All of these APIs endpoints URL will use *https://simple.api/open101* as base URL.
These informations are not required, an OpenAPI specification without these data is still valid.

## API operations
Finally, as our API does absolutely nothing for now, we add an empty paths list. (nb. in YAML an empty object is describe using *{}*).
{% codefile file:simple_openapi_specification_01.yaml lines:"13" footer:false %}

# Defining an operation
Let our API do something by adding an operation to *list some persons*.
{% codefile file:simple_openapi_specification_02_with_operation.yaml highlight:"13-32" footer:true %}

## Adding a path
In the *paths* section we add a new path */persons* corresponding to the *persons* resource.
{% codefile file:simple_openapi_specification_02_with_operation.yaml lines:"13-14" footer:false %}

## Adding an http method on path
On each [path](https://github.com/OAI/OpenAPI-Specification/blob/master/versions/2.0.md#pathItemObject) we can add any [http verb](https://en.wikipedia.org/wiki/Hypertext_Transfer_Protocol#Request_methods) (like *get*, *post*, *put* or *delete*) to manipulate the corresponding resource.
To list some *persons*, we need to apply the *get* http method to the */persons* resource (or path). We also give a short description (*summary*) and a longer one if necessary (*description*).
{% codefile file:simple_openapi_specification_02_with_operation.yaml lines:"15-17" footer:false %}

Therefore to list some persons we'll have to call *get /persons* (or *get https://simple.api/open101/persons* to be precise).

## Describing response
For each operation, you can describe any response matching an [http status code](https://en.wikipedia.org/wiki/List_of_HTTP_status_codes) (like *200 OK* or *404 Not Found*) in the *[responses](https://github.com/OAI/OpenAPI-Specification/blob/master/versions/2.0.md#responsesObject)* section.
We'll only handle *200* when responding to get /persons and we'll tell what the response means via its *description*.
{% codefile file:simple_openapi_specification_02_with_operation.yaml lines:"18-20" footer:false %}

## Describing response's content
The *get /persons* operation returns a list of persons, we describe what it is with the *[schema](https://github.com/OAI/OpenAPI-Specification/blob/master/versions/2.0.md#schemaObject)* section of the response.
A list of person is an object which *type* is *array*. Each item in this array is an object containing three *properties* of type *string*: firstName, lastName and username. Only username will be always provided (i.e. *required*).
{% codefile file:simple_openapi_specification_02_with_operation.yaml lines:"21-32" footer:false %}

# Defining query parameters
As we'll have to handle many *persons*, it could be a good idea to add paging capabilities to the *get /resources* operation. We'll do that by adding query parameters to define the requested page and number of items per page.
{% codefile file:simple_openapi_specification_03_with_query_parameters.yaml highlight:"18-26" footer:true %}

## Adding a parameters section to the get /persons operation
First we add a *parameters* section in *get* http method for */persons* path.
{% codefile file:simple_openapi_specification_03_with_query_parameters.yaml lines:"13-18" highlight:"18" footer:false %}

## Adding paging query parameters
Then in the *parameters* list we define two optional parameters *named* pageSize and pageNumber of *type* integer located *in* query. We also provide a *description* for each one.   
{% codefile file:simple_openapi_specification_03_with_query_parameters.yaml lines:"18-27" highlight:"19-26" footer:false %}

Therefore to list some persons we can use *get /persons?pageSize=20&pageNumber=2* and we'll get the page number 2 with 20 persons max.

# Defining a path parameter
We would like to access directly a *specific person* by it's *username*, so we'll add a *get /persons/{username}* operation to our API. *{username}* is called a *path parameter*.
{% codefile file:simple_openapi_specification_04_with_path_parameter.yaml highlight:"42-66" footer:true %}

## Adding a get /persons/{username} operation
First we add a */persons/{username}* path, after the */persons* one, in the *paths* section and define the *get* operation for this path. 
{% codefile file:simple_openapi_specification_04_with_path_parameter.yaml lines:"1-14" highlight:"13" footer:false %}
{% codefile file:simple_openapi_specification_04_with_path_parameter.yaml lines:"40-45" highlight:"42-45" footer:false %}

## Describing username path parameter
As *{username}* is a path parameter, we need to describe it. It is done by adding a *parameters* section to the *get* operation and adding a *required* parameter with a *name* matching the parameter defined in the path (here username) located *in* path of *type* string. We also provide an optional *description*.
{% codefile file:simple_openapi_specification_04_with_path_parameter.yaml lines:"46-51" footer:false %}

A common problem when defining path parameter is to forget *required: true* (as the Swagger Editor snippet do not provide it). If *required* is not provided, its default value is *false*, meaning that the parameter is *optional*. A path parameter is always required.

## Adding responses
Don't forget to add 200 response returning a *person*. Note that the schema used in 200 is the same as the array's item in *get /persons* 200 response.
{% codefile file:simple_openapi_specification_04_with_path_parameter.yaml lines:"52-64" highlight:"55-64" footer:false %}

As a username may not match an existing person we also add a 404 response. Note that this response do not return anything besides the 404 http status code. 
{% codefile file:simple_openapi_specification_04_with_path_parameter.yaml lines:"65-66" footer:false %}

# Defining a body parameter
We would like to have the capability of adding a person to our list of persons so we'll add a *post /persons* operation to our API.
{% codefile file:simple_openapi_specification_05_with_body_parameter.yaml highlight:"42-63" footer:true %}

## Adding post /persons operation
We first add a post method to the /persons path (after the *get* one) in the *paths* section.
{% codefile file:simple_openapi_specification_05_with_body_parameter.yaml lines:"13-14" footer:false %}

{% codefile file:simple_openapi_specification_05_with_body_parameter.yaml lines:"42-44" footer:false %}

## Describing a person body parameter
Then we define a parameter *named* person located in *body* of *type* object. The person object's is described via it's *schema*. Note that this schema is the same as the 200 response of *get /persons/{username}*. The firstName and lastName attributes are optional and username is *required*.  
{% codefile file:simple_openapi_specification_05_with_body_parameter.yaml lines:"45-58" highlight:"49-58" footer:false %}

## Defining responses
Don't forget to define responses for this new operation.
{% codefile file:simple_openapi_specification_05_with_body_parameter.yaml lines:"59-63" footer:false %}

# To simplicity and beyond
You now have learned the basics of the OpenAPI Specification. But as you may have guess, working that way on huge API may not be so easy. But rest assured, the OpenAPI Specification files we've seen can be simplified. We'll learn in the [next part](/writing-openapi-swagger-specification-tutorial-part-3-simplifying-specification-file/) how to describe swiftly and easily even the hugest API by using factorization and references.
