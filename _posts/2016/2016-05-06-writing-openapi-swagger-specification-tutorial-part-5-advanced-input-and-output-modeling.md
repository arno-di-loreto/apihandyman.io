---
title: Advanced Input And Output Modeling
series: Writing OpenAPI (Swagger) Specification Tutorial
series_number: 5
date: 2016-05-06
author: Arnaud Lauret
layout: post
permalink: /writing-openapi-swagger-specification-tutorial-part-5-advanced-input-and-output-modeling/
category: post
tools:
  - OpenAPI Specification
codefiles: writing-openapi-swagger-specification-tutorial
---
After learning how to [create an accurate data model](/writing-openapi-swagger-specification-tutorial-part-4-advanced-data-modeling/), we continue to delve into the [OpenAPI specification's](https://openapis.org/) and discover how to describe tailor made API's inputs and outputs.<!--more-->

{% include _postincludes/writing-openapi-swagger-specification-tutorial.md %}

In previous parts (especially [The basics](/writing-openapi-swagger-specification-tutorial-part-2-the-basics/) and [Simplifying specification file](/writing-openapi-swagger-specification-tutorial-part-3-simplifying-specification-file/) we have learned how to describe simple operations parameters and responses using inline definitions or high level ones.
In this fifth part you will discover all the tips and tricks to describe highly accurate parameters and responses.

# Parameters
In this section you will learn to define:

- Required or optional parameter
- Parameter with default value
- Parameter with empty value
- Array parameter
- Header parameter
- Form parameter
- File parameter
- Parameter's media type

## Required or optional parameter
We already have used the `required` key word which is used to define a mandatory parameter or a mandatory value in definition.

### Defining a required or optional parameter
In a parameter, `required` is an optional value which type is `boolean`. Its default value is false.

When used in a operation, the `username` parameter is mandatory:
{% codefile file:simple_openapi_specification_15_advanced_input_and_output_modeling.yaml lines:"480-485" highlight:"483" footer:true %}

When used in an operation, the `pageSize` parameter is NOT mandatory (`required` is not defined and therefore is false).
{% codefile file:simple_openapi_specification_15_advanced_input_and_output_modeling.yaml lines:"486-497" footer:true %}

### Defining a required or optional property in a definition used as a parameter
In a definition, `required` is an optional value which type is a list of string. This list contains the mandatory properties names. A property which is not referenced in this list is NOT mandatory. If `required` is not defined, all object properties are not mandatory. When this definition is used on a request, all `required` properties MUST be provided.

In the definition `Person` which is used as a body parameter in `POST /persons`, the username property is mandatory (present in `required` list) , all others are not mandatory (not referenced in `required` list).
{% codefile file:simple_openapi_specification_15_advanced_input_and_output_modeling.yaml lines:"297-322" highlight:"298-299" footer:true %}

## Parameter with default value
By using the keyword `default` you can define a default value for a parameter or a default value for a property in a definition. This default value is the one that the server will use if none is provided. Using default does not make sense when a property or parameter is required.

### Defining a parameter's default value
On the parameter `pageSize`, we set its `default` value to `20`. If this value is not provided, the server will then return pages containing `20` elements.
{% codefile file:simple_openapi_specification_15_advanced_input_and_output_modeling.yaml lines:"486-497" highlight:"497" footer:true %}

On the parameter `pageNumber`, we set its `default` value to `1`. If this value is not provided, the server will then return the `first` page.
{% codefile file:simple_openapi_specification_15_advanced_input_and_output_modeling.yaml lines:"498-503" highlight:"503" footer:true %}

### Defining a property's default value in a definition used as a parameter
On the definition `Person`, the avatarBase64PNG property default value is a 64x64 pixels API Handyman PNG icon as a base64 string.

<img src="data:image/png;base64,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" />*Default Avatar*

{% codefile file:simple_openapi_specification_15_advanced_input_and_output_modeling.yaml lines:"297-322" highlight:"320" footer:true %}

### Defining a default value in a hashmap definition used as a parameter 
In previous post ([Advanced data modeling](/writing-openapi-swagger-specification-tutorial-part-4-advanced-data-modeling/)) we've learned how to define hashmaps. 
We can set a default value in a an hashmap this way:

{% codefile file:simple_openapi_specification_15_advanced_input_and_output_modeling.yaml lines:"323-329" highlight:"326-329" footer:true %}

Just like we've learned on previous post, we define a property `defaultLanguage` on `SpokenLanguages` definition and today we set a `default` value for this property. Therefore is the property `spokenLanguages` of the `Person` definition (which is a `SpokenLanguages`) is not provided on `POST /persons`, its value will be `{"defaultLanguage": "english"}`

## Parameter with empty value
If we want to add a filter parameter to include non verified users on `GET /persons` a first idea would be to have something like `GET /persons?page=2&includeVerifiedUsers=true`. 
But why should we have to set a value when the parameters name is sufficient to express what we want to do? Having `GET /persons?page=2&includeVerifiedUsers` would be much better.

To do that we just need to use the `allowEmptyValue` key word on the parameter's description. We have also define a default value to false, therefore `GET /persons?page=2&includeVerifiedUsers` will include verified users and `GET /persons?page=2` will not.
{% codefile file:simple_openapi_specification_15_advanced_input_and_output_modeling.yaml lines:"504-509" highlight:"509" footer:true %}
 
## Array parameter
When it comes to sorting or filtering an API designer almost always ends asking himself: but how will I define an array parameter on a get request in my OpenAPI specification?

It's easy, he just need to define an `array type` attribute and use the accurate `collectionFormat`:

collectionFormat&nbsp;&nbsp;    | Description
--------------------|--------------------------------
csv (default value) | Comma separated values `foo,bar`
ssv                 | Space separated values `foo bar`
tsv                 | Tab separated values `foo\tbar`
pipes               | Pipes separated values `foo|bar`
multi               | Corresponds to multiple parameter instances instead of multiple values for a single instance `foo=bar&foo=baz`. This is valid only for parameters in query or formData.

### Defining a separated values parameter
If we want to sort a persons list on multiple parameters (username, firstname, lastname, lastTimeOnline) ascending or descending we could use something like `GET /persons?sort=-lastTimeOnline|+firtname|+lastname`.
The sort parameters are in a pipe separated array named `sort`, each of them starting with `+` for an ascending sort or `-` for a descending one.

This `sort`parameter is defined with an `array` of `string` using a `pipes collectionFormat`:
{% codefile file:simple_openapi_specification_15_advanced_input_and_output_modeling.yaml lines:"510-519" highlight:"513,517,5195" footer:true %}
We can now have requests like this: `GET /persons?sort=String1|String2|String3`. But how do we set the sorting direction and how can we we enforce the values within the array?

In this specific use case we will define a pattern for the string within the array, just like we've learned on previous part when defining the `username` property. This pattern says that a value within the array may start with `+` (for ascending) and `-` (for descending) and be followed by `username`, `firstname`, `lastname` or `lastTimeOnline`.
{% codefile file:simple_openapi_specification_15_advanced_input_and_output_modeling.yaml lines:"510-520" highlight:"520" footer:true %}
Our API is now ready to handle a `GET /persons?sort=-lastTimeOnline|+firtname|+lastname` request.

And icing on the cake, we can also define a default sort (last online time descending and username ascending) by adding a `default` value on the array level:
{% codefile file:simple_openapi_specification_15_advanced_input_and_output_modeling.yaml lines:"510-523" highlight:"521-523" footer:true %}

### Defining a multiple values parameter
If we want to filter a persons collected items list on mutiple items types we could use something like `GET /persons/apihandyman/collected-items?itemType=AudioCassette&itemType=Vinyl`.
The filter parameters are in a multi array named `itemType`, each value corresponding to one of the item's type we want to filter on.

This `filterItemTypes` parameter is defined with an `array` of `unique string`using a `multi colectionFormat`:
{% codefile file:simple_openapi_specification_15_advanced_input_and_output_modeling.yaml lines:"524-531" highlight:"527,528,529,531" footer:true %}

And icing on the cake we enforce the possible values by defining an `enum` on the string within the array:
{% codefile file:simple_openapi_specification_15_advanced_input_and_output_modeling.yaml lines:"524-535" highlight:"532-535" footer:true %}

## Parameter location is not only path, query or body

When describing a parameter, the keyword `in` is used to set its location.
We already have seen in previous parts the most common values of `in` are:  

- path
- query
- body

But they are not the only ones, there two others:

- header
- formData

We'll see in next sections how we can use them in an API definition to define 

- Header parameter
- Form parameter
- File parameter

## Header parameter
Let's say we want our API consumer's to provide some informations about themselves by using the good old `User-Agent` HTTP header (for tracking, debugging, or whatever you want).

We define the parameter just like any other one, we just need to set the `header`value in `in`:
{% codefile file:simple_openapi_specification_15_advanced_input_and_output_modeling.yaml lines:"536-540" footer:true %}

And we use it (on every path) just like any other parameter:
{% codefile file:simple_openapi_specification_15_advanced_input_and_output_modeling.yaml lines:"16-19" highlight:"19" footer:false %}

There's absolutely no way of telling once and for all that all operations needs this header parameter (for now).

*nb: This works also with custom HTTP header.*

## Form parameter
Let's say we have a partner who need to use our API in a js-less-browser environment to create persons. He can only provide the creation information in a good old HTML form format:
{% codefile file:simple_openapi_specification_16_advanced_input_and_output_modeling_form.txt" footer:true %}

No problem, we just need to define all form parameters with `in` sets to  `formData` and setting the `consumes` media type to `application/x-www-form-urlencoded`: 
{% codefile file:simple_openapi_specification_15_advanced_input_and_output_modeling.yaml lines:"77-104" highlight:"80,81,86,93,96,99" footer:true %}

## File parameter
To define an operation which will accept a file as input parameter, you need to:

- use `multipart/form-data` media type
- set parameter's `in` value to `formData`
- set parameter's `type` value to `file`

{% codefile file:simple_openapi_specification_15_advanced_input_and_output_modeling.yaml lines:"230-247" highlight:"236,239,240" footer:true %}

And what if I want to restrict file's media type? Unfortunately, it's not possible for now:

> The spec doesn't allow specifying a content type for specific form data parameters. It's a limitation of the spec.
> *[Ron Ratovsky](https://twitter.com/webron) comment in [Swagger UI 609 issue](https://github.com/swagger-api/swagger-ui/issues/609)*

## Parameter's media types
An API can consume various *media types*, the most common one is *application/json*, but it's not the only one an API can use. The keyword `consumes` on root or operation level is used to describe the accepted media types list.

We set the global media-type on the root level of the OpenAPI document, here our API consumes JSON and YAML:
{% codefile file:simple_openapi_specification_15_advanced_input_and_output_modeling.yaml lines:"10-12" footer:true %}

This settings can be overriden on the operation level by redefining the consumes list:
{% codefile file:simple_openapi_specification_15_advanced_input_and_output_modeling.yaml lines:"230-247" highlight:"235-236" footer:true %}

# Responses
In this section you will learn to define:

- Response without a body
- Required or optional values in response
- Response's headers
- Default response
- Response's media types

## Response without a body
It's a common feature in HTTP protocole and in REST API to have response without body. For example the 204 HTTP Status is used by a server which wants to indicate a succes without returning any content (or body).
 
To define a response without a body, all you have to do is set its status and description:
{% codefile file:simple_openapi_specification_15_advanced_input_and_output_modeling.yaml lines:"43-55" highlight:"54-55" footer:true %}

## Required or optional values in response
Just like we've seen on parameters, we can define mandatory properties in definition used in responses.
Mandatory properties are defined with the `required` list. A property referenced in this list MUST be sent by the server and a property absent from this list MAY be sent by the server.

When `GET /persons/apihandyman` returns a `Person`, this person will surely contains a `username`, but all other values may not be sent:
{% codefile file:simple_openapi_specification_15_advanced_input_and_output_modeling.yaml lines:"297-322" highlight:"298-298" footer:true %}

## Response's headers
The HTTP status and the body are not the only way to provide information on the result of an API call, HTTP headers can be used too.

Let's say we want to offer something like the Twitter's API rate limiting information to provide the remaining number of API calls and when the limit will be reset. We have to define two header X-Rate-Limit-Remaining and X-Rate-Limit-Reset and *each* API response:
{% codefile file:simple_openapi_specification_15_advanced_input_and_output_modeling.yaml lines:"43-61" highlight:"56-61" footer:true %}

Unfortunately there's *absolutely no way* of defining such headers once and for all (for now).

## Default response
The OpenAPI specification allow to define a `default` response on each operation. 

This could be used to define a single generic response but your API definition would not be easily understandable. I'd prefer to use it in conjunction with a full description of which HTTP status an API handle, and then use the default response to say *if you have any other HTTP status than the ones I described explicitely, it do not comes from this API*. 

A generic response defined once and for all in the `responses` section:
{% codefile file:simple_openapi_specification_15_advanced_input_and_output_modeling.yaml lines:"470-471" footer:true %}

This response used as a `default` response on each operation:
{% codefile file:simple_openapi_specification_15_advanced_input_and_output_modeling.yaml lines:"153-170" highlight:"169" footer:true %}

Unfortunately there's *absolutely no way* of defining a global response once and for all (for now).

## Response's media types
An API can produce various *media types*, the most common one is *application/json*, but it's not the only one an API can use. The keyword `produces` on root or operation level is used to describe the returned media types list.

We set the global media-type on the root level of the OpenAPI document, here our API produces JSON and YAML:
{% codefile file:simple_openapi_specification_15_advanced_input_and_output_modeling.yaml lines:"13-15" footer:true %}

This settings can be overriden on the operation level by redefining the local produces list, here's an example on `GET /images/{imageId}` operation which return an image:
{% codefile file:simple_openapi_specification_15_advanced_input_and_output_modeling.yaml lines:"258-294" highlight:"268-273" footer:true %}

Note that the produces contains images media types but also json and yaml media types as if there's a 500 error, the message will be return with one of those 2 media types.

# How to use a single definition when output returns more data than input needs
And finally, as already seen on [previous part in section 2.1](/writing-openapi-swagger-specification-tutorial-part-4-advanced-data-modeling/), in a definition the `readOnly` property is set to true to indicate that this property MAY be sent in a response and MUST NOT be sent in a request.

It allows you to use a single definition when output returns more data than input needs.

In the definition `Person` which is both used as a part of the response in `GET /persons` and a body parameter in `POST /persons` the `lastTimeOnline` property has `readOnly` set to true. Therefore this property MUST NOT be provided on `POST /persons` and MAY be returned by the server on `GET /persons`:
{% codefile file:simple_openapi_specification_15_advanced_input_and_output_modeling.yaml lines:"297-322" highlight:"316" footer:true %}

*Warning: SwaggerUI does not handle this yet ([issue 884](https://github.com/swagger-api/swagger-ui/issues/884)).*

# Conclusion
You are now a Jedi of API's input and ouput definition with the OpenAPI specification. In next post you'll learn to [describe how your API is secured](/writing-openapi-swagger-specification-tutorial-part-6-defining-security).