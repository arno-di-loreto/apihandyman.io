---
id: 1079
title: 'Writing OpenAPI (Swagger) Specification Tutorial - Part 6 - Defining Security'
date: 2016-05-22T18:26:38+00:00
author: Arnaud Lauret
layout: post
guid: http://apihandyman.io/?p=1079
permalink: /writing-openapi-swagger-specification-tutorial-part-6-defining-security/
dsq_thread_id:
  - 4866893028
category: Posts
tags:
  - OpenAPI
  - Swagger
  - API Specification
  - Documentation
  - API First
series: Writing OpenAPI (Swagger) Specification Tutorial
series_title: Part 6 - Defining Security
---
After mastering [input and output modeling](/writing-openapi-swagger-specification-tutorial-part-5-advanced-input-and-output-modeling/) like a Jedi, let's see how we can describe API's security with the [OpenAPI specification's](https://openapis.org/).<!--more-->

# Writing OpenAPI (fka Swagger) Specification tutorial
This tutorial is composed of several posts:

- Part 1: [Introduction](/writing-openapi-swagger-specification-tutorial-part-1-introduction/)
- Part 2: [The basics](/writing-openapi-swagger-specification-tutorial-part-2-the-basics/)
- Part 3: [Simplifying specification file](/writing-openapi-swagger-specification-tutorial-part-3-simplifying-specification-file/)
- Part 4: [Advanced data modeling](/writing-openapi-swagger-specification-tutorial-part-4-advanced-data-modeling/)
- Part 5: [Advanced input and output modeling](/writing-openapi-swagger-specification-tutorial-part-5-advanced-input-and-output-modeling/)
- Part 6: **Defining security**
- Part 7: [Documentation](/writing-openapi-swagger-specification-tutorial-part-7-documentation/)
- Part 8: [Splitting specification file](http://apihandyman.io/writing-openapi-swagger-specification-tutorial-part-8-splitting-specification-file/)
- Part 9: Extending the OpenAPI specification (coming soon)

In previous parts we've learned to write efficiently highly accurate interface description, in this seventh part we'll learn how to describe how an API is secured.

All tutorial's files are available on [GIST](https://gist.github.com/arno-di-loreto/5a3df2250721fb154060).

If you're a bit lost in the [specification](https://github.com/OAI/OpenAPI-Specification/blob/master/versions/2.0.md), take a look at my [*visual documentation:*
{% img file:"/images/writing-openapi-swagger-specification-tutorial/openapi-specification-visual-documentation.png" label:"OpenAPI Specification Visual Documentation" source:"http://openapi-specification-visual-documentation.apihandyman.io/"%}

# 1 Security definitions
Following (almost) the same principle used with `parameters` and `definitions`, security can be defined and then used on different levels.
Security definition takes place on specification's root level in `securityDefinition` section. It contains a list of named security definitions. Each definition can be of type:

- `basic` for Basic Authentication
- `apiKey` when using an API key to secure the API
- `oauth2` for Oauth 2

## 1.1 Basic Authentication

To define a `basic` security it's fairly easy, we only have to set its `type` to `basic`:

{% gist id:5a3df2250721fb154060 file:simple_openapi_specification_17_defining_security_basic.yaml lines:"17-23" footer:true %}

In this example we have defined three security definitions (`UserSecurity`, `AdminSecurity` and `MediaSecurity`), each of them is of `basic` type.

## 1.2 API Key

To define an `apiKey` security we have to:

- Set `type` to `apiKey`
- Indicate where the API ley is located with `in`. An API can be in a `header` or a `query` parameter
- And then give the parameter's `name`

{% gist id:5a3df2250721fb154060 file:simple_openapi_specification_18_defining_security_apikey.yaml lines:"17-29" footer:true %}

In this example, we have defined three security definitions of `apiKey` type:

- `UserSecurity` uses a `header` parameter named `SIMPLE-API-KEY`
- `AdminSecurity` uses a `header` parameter named `ADMIN-API-KEY`
- `MediaSecurity` uses a `query` parameter named `media-api-key`

## 1.3 Oauth 2

### 1.3.1 Flow and URLs
When defining an `oauth2` security definition, we can define the Oauth2 `flow` used and corresponding `authorizationUrl` and/or `tokenUrl` depending on the chosen flow:

{: .table .table-bordered}
Flow        | Required URLs
------------|------------------------------
implicit    | authorizationUrl
password    | tokenUrl
application | tokenUrl
accessCode  | authorizationUrl and tokenUrl

{% gist id:5a3df2250721fb154060 file:simple_openapi_specification_19_defining_security_oauth2.yaml lines:"17-22" footer:true %}

In this example we have defined a `OauthSecurity` security definition of `oauth2` type using an `accessCode` flow with an authorizationUrl and a tokenUrl.
 
### 1.3.2 Scopes
We can also define `scopes` by using a hashmap, the key is the scope's name and the value is its description.

{% gist id:5a3df2250721fb154060 file:simple_openapi_specification_19_defining_security_oauth2.yaml lines:"17-26" highlight:"23-26" footer:true %}

In this example, we've added three scopes (`admin`, `user` and `media`) to our `OauthSecurity` security definition

# 2 Using security definitions

Once we have described security definitions in `securityDefinition` we can apply them to the overall API or to specific operations with the `security` sections.
When we apply a security definition to an operation, it overrides API security.

## 2.1 Basic Authentication
Let's see how we can use a `basic` security definition.

### 2.1.1 API level
In this example the security definition which apply to ALL API operations is `UserSecurity`:
{% gist id:5a3df2250721fb154060 file:simple_openapi_specification_17_defining_security_basic.yaml lines:"17-29" highlight:"25-26" footer:true %}

### 2.1.2 Operation level
As `GET /persons` operation do not define a `security`, it's the `UserSecurity` defined on top level which applies:
{% gist id:5a3df2250721fb154060 file:simple_openapi_specification_17_defining_security_basic.yaml lines:"28-39" highlight:"29,32" footer:true %}

On `POST /persons` operation, the top level security is overridden by `AdminSecurity`: 
{% gist id:5a3df2250721fb154060 file:simple_openapi_specification_17_defining_security_basic.yaml lines:"55-59" highlight:"58-59" footer:true %}

On `POST /images` operation, the top level security is also overridden, but this time it's by `MediaSecurity`:
{% gist id:5a3df2250721fb154060 file:simple_openapi_specification_17_defining_security_basic.yaml lines:"246-252" highlight:"246,249,251-252" footer:true %}

## 2.2 API Key
We can do exactly the same things with an API key security definition.

### 2.2.1 API level
In this example the security definition which apply to ALL API operations is `UserSecurity`:
{% gist id:5a3df2250721fb154060 file:simple_openapi_specification_18_defining_security_apikey.yaml lines:"17-35" highlight:"31-32" footer:true %}

### 2.2.2 Operation level
As `GET /persons` operation do not define a `security`, it's the `UserSecurity` defined on top level which applies:
{% gist id:5a3df2250721fb154060 file:simple_openapi_specification_18_defining_security_apikey.yaml lines:"34-45" highlight:"35,38" footer:true %}

On `POST /persons` operation, the top level security is overridden by `AdminSecurity`:
{% gist id:5a3df2250721fb154060 file:simple_openapi_specification_18_defining_security_apikey.yaml lines:"61-65" highlight:"61,64,65" footer:true %}

On `POST /images` operation, the top level security is also overridden, but this time it's by `MediaSecurity`:
{% gist id:5a3df2250721fb154060 file:simple_openapi_specification_18_defining_security_apikey.yaml lines:"252-258" highlight:"252,255,257-258" footer:true %}

## 2.3 Oauth 2
With an `oauth2` the principle is the same but you can also define which scope(s) you use.

### 2.3.1 API level
In this example the security definition which apply to ALL API operations is `OauthSecurity` with the `user` scope:
{% gist id:5a3df2250721fb154060 file:simple_openapi_specification_19_defining_security_oauth2.yaml lines:"17-33" highlight:"28-30" footer:true %}

### 2.3.2 Operation level
As `GET /persons` operation do not define a `security`, it's the `OauthSecurity` with `user`scope defined on top level which applies:
{% gist id:5a3df2250721fb154060 file:simple_openapi_specification_19_defining_security_oauth2.yaml lines:"32-43" highlight:"33,36" footer:true %}

On `POST /persons` operation, the top level security scope is overridden by `admin`:
{% gist id:5a3df2250721fb154060 file:simple_openapi_specification_19_defining_security_oauth2.yaml lines:"59-64" highlight:"59,62-64" footer:true %}

On `POST /images` operation, the top level security is also overridden, but this time it's by `media`:
{% gist id:5a3df2250721fb154060 file:simple_openapi_specification_19_defining_security_oauth2.yaml lines:"252-259" highlight:"252,255,257-259" footer:true %}

# 3 Using multiple security types
It's not mandatory to define a single type of security definition and use only one at a time.
The examples below show how we can define security definitions of different types and use more than one on operations. 

## 3.1 Security definitions
Here we define there different types of security:
{% gist id:5a3df2250721fb154060 file:simple_openapi_specification_20_defining_security_multiple.yaml lines:"17-31" footer:true %}

## 3.2 Global security
Then we choose to apply both of them globally:
{% gist id:5a3df2250721fb154060 file:simple_openapi_specification_20_defining_security_multiple.yaml lines:"33-36" footer:true %}
It means that a consumer can call any operation (which do not override security) with one of those two security types.

## 3.3 Overriding global security
As `GET /persons` operation do not define a `security`, it's the Oauth 2 `OauthSecurity` with `user`scope OR the basic authentication `LegacySecurity` defined on top level which applies:
{% gist id:5a3df2250721fb154060 file:simple_openapi_specification_20_defining_security_multiple.yaml lines:"38-49" highlight:"39,42" footer:true %}

On `POST /persons` operation, the top level security scope Oauth 2 `OauthSecurity` is overridden by `admin` and consumer can also still use the basic authentication `LegacySecurity`:
{% gist id:5a3df2250721fb154060 file:simple_openapi_specification_20_defining_security_multiple.yaml lines:"65-71" highlight:"65,68-71" footer:true %}

On `POST /images` operation, the top level security is fully overridden by the API Key `MediaSecurity`:
{% gist id:5a3df2250721fb154060 file:simple_openapi_specification_20_defining_security_multiple.yaml lines:"260-266" highlight:"260,263,265-266" footer:true %}

# Conclusion
You now have mastered security. With this new post you are now a full expert when it comes to describe an API interface with the OpenAPI specification. But an interface contract alone may not be easy to understand without some explainations. In next post we'll learn how to document this interface description (coming soon) to ease its understanding.