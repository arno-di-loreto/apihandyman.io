---
id: 975
title: 'Writing OpenAPI (Swagger) Specification Tutorial - Part 4 - Advanced Data Modeling'
date: 2016-04-17T17:52:32+00:00
author: Arnaud Lauret
layout: post
guid: http://apihandyman.io/?p=975
permalink: /writing-openapi-swagger-specification-tutorial-part-4-advanced-data-modeling/
dsq_thread_id:
  - 4866765285
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
series_title: Advanced Data
series_number: 4
codefiles: writing-openapi-swagger-specification-tutorial
---
After learning how to [simplify specification files](/writing-openapi-swagger-specification-tutorial-part-3-simplifying-specification-file/), let's start delving into the [OpenAPI specification's](https://openapis.org/) and discover how to describe a high accuracy API's data model.<!--more-->

{% include _postincludes/writing-openapi-swagger-specification-tutorial.md %}

In this fourth part you will discover all the tips and tricks you can use to describe properties and definitions to describe an accurate API's data model.
 
# Tailor made properties

> Primitive data types in the Swagger Specification are based on the types supported by the JSON-Schema Draft 4. Models are described using the Schema Object which is a subset of JSON Schema Draft 4.
> [OpenAPI Specification Data Types](https://github.com/OAI/OpenAPI-Specification/blob/master/versions/2.0.md#data-types)

Using the [JSON Schema Draft 4](http://json-schema.org/documentation.html), the OpenAPI Specification allows to define every aspects of any type of property.

## Strings length and pattern
When defining a *string* property, we can specify its length range and its pattern:


Property  | Type   | Description 
----------|--------|-------------
minLength | number | String's minimum length
maxLength | number | String's maximum length
pattern   | string | Regular expression (if you're not a regex expert, you should try [Regex 101](https://regex101.com/))

The *username* in the *Person* definition is a string which length is between 8 and 64 and composed of lower case alphanumeric characters:
{% codefile file:simple_openapi_specification_14_advanced_data_modeling.yaml lines:"118-122" highlight:"120-122" footer:true %}

## Dates and times
Date and time are handled with *string* properties conforming to [RFC 3339](http://xml2rfc.ietf.org/public/rfc/html/rfc3339), all you need to do is to use the appropriate *format*:


Format   | Property contains | Property's value example
---------|-------------------|------------------------------
date     | [ISO8601 full-date](http://xml2rfc.ietf.org/public/rfc/html/rfc3339.html#anchor14) | 2016-04-01
date-time | [ISO8601 date-time](http://xml2rfc.ietf.org/public/rfc/html/rfc3339.html#anchor14) | 2016-04-16T16:06:05Z

In the *Person* definition, *dateOfBirth* is a date and *lastTimeOnline* is a timestamp:
{% codefile file:simple_openapi_specification_14_advanced_data_modeling.yaml lines:"123-128" highlight:"125,128" footer:true %}

You should read the [5 laws of API dates and times](http://apiux.com/2013/03/20/5-laws-api-dates-and-times/) by [Jason Harmon](https://twitter.com/jharmn) to learn how to handle date and time with an API.

## Numbers type and range

When defining a number property, we can specify if this property is an integer, a long, a float or a double by using the [appropriate type and format combination](https://github.com/OAI/OpenAPI-Specification/blob/master/versions/2.0.md#data-types).


Value   |Type     | Format
--------|---------|-------
integer | integer | int32
long    | integer | int64
float   | number  | float
double  | number  | double


And just like string, we can define additional properties like the value range and also indicate if the value is a multiple of something:


Property   |Type  | Description
--------|---------|-------
minimum | number  | Minimum value
maximum          | number  | Maximum value                     
exclusiveMinimum | boolean | Value must be > minimum           
exclusiveMaximum | boolean | Value must be < maximum           
multipleOf       | number  | Value is a multiple of multipleOf 

The *pageSize* parameter is an integer > 0 and <= 100 and a multiple of 10:
{% codefile file:simple_openapi_specification_14_advanced_data_modeling.yaml lines:"288-298" highlight:"292-298" footer:true %}

The *maxPrice* property of *CollectingItem* definition is a double value > 0 and <= 10000:
{% codefile file:simple_openapi_specification_14_advanced_data_modeling.yaml lines:"190-196" highlight:"191-196" footer:true %}

## Enumerations
On each property we can define a set of accepted value with the *enum* property.

The property *code* of definition *Error* can take only three value (DBERR, NTERR and UNERR):
{% codefile file:simple_openapi_specification_14_advanced_data_modeling.yaml lines:"169-174" highlight:"171-174" footer:true %}

## Arrays size and uniqueness
Arrays size and uniqueness are defined by these properties:


Property   |Type  | Description
--------|---------|-------
minItems    | number  | Minimum number of items in the array
maxItem     | number  | Maximum number of items in the array
uniqueItems | boolean | Indicate if all array's elements are unique

The *Person* definition contains a property *items* which is an array of *Person*. This array contain only unique elements and can have between 10 and 100 items: 
{% codefile file:simple_openapi_specification_14_advanced_data_modeling.yaml lines:"140-148" highlight:"144-146" footer:true %}


## Binary data
Binary data can be handled with *string* properties using the appropriate *format*:


Format   | Property contains
---------|------------------
byte     | Base64 encoded characters
binary   | Any sequence of octets

The property *avatarBase64PNG* of *Person* definition is a base64 encoded PNG image:
{% codefile file:simple_openapi_specification_14_advanced_data_modeling.yaml lines:"130-132" highlight:"132" footer:true %}


# Advanced definition modeling

## Using same definitions on read and write operations
It's not unusual that reading a resource returns more than the data needed when creating or updating it. To solve this problem you'll probably end having two different definitions, one for creating or updating and the other for reading. Fortunately, it can be avoided. 

When describing a property in a definition, we can set a *[readOnly](https://github.com/OAI/OpenAPI-Specification/blob/master/versions/2.0.md#schema-object)* property to *true* to explain that this property may be sent in a response and must not be sent in a request. 

In the example below, the *lastTimeOnline* property in the *Person* definition does not have sense when creating an *Person*. With *readOnly* set to true on this property, we can use the same *Person* definition in both *post /persons* and *get /persons/{username}*, *lastTimeOnline* will only be of interest when using get:
{% codefile file:simple_openapi_specification_14_advanced_data_modeling.yaml lines:"126-129" highlight:"129" footer:true %}

## Combining multiple definitions to ensure consistency
When designing an API, it is highly recommended to propose a consistent design. You can for example decide that paged collection data should always be accompanied on the root level by the *same* data explaining the current paging status (totalItems, totalPage, pageSize, currentPage).

A first option would be to define this attribute on every single collection:
{% codefile file:simple_openapi_specification_14_advanced_data_modeling.yaml lines:"221-234" highlight:"227-234" footer:true %}

Having to describe again and again, endlessly the same properties on each collection is not only boring but also dangerous: you can forget some properties or misspelled them. And what will happen when you'll want to add a new information on paging? You'll have to update every single collection.

A better option would be to define a Paging model and then use it in every collection:
{% codefile file:simple_openapi_specification_14_advanced_data_modeling.yaml lines:"236-254" highlight:"242-243,245-254" footer:true %}

But the paging attributes are not on the root level anymore.
The [*allOf* JSON Schema v4 property](https://github.com/OAI/OpenAPI-Specification/blob/master/versions/2.0.md#composition-and-inheritance-polymorphism) can provide an elegant and simple solution to this problem:
{% codefile file:simple_openapi_specification_14_advanced_data_modeling.yaml lines:"256-259" footer:true %}

The allOf property allow to create a new definition composed of all referenced definitions attributes.
It also functions perfectly with inline definitions:
{% codefile file:simple_openapi_specification_14_advanced_data_modeling.yaml lines:"261-271" footer:true %}

## Create a hierarchy between definitions to implement inheritance (highly experimentatl)
As stated in the OpenAPI Specification, composition do not imply hierarchy. The use of *discriminator* indicate the property used to know which is the type of the *sub-definition* or *sub-class* (this property MUST be in the required list).

Here we define a CollectingItem *super-definition*, which is subclassed using the *allOf* property. The consumer will determine which *sub-definition* used by scanning the *itemType* property.
{% codefile file:simple_openapi_specification_14_advanced_data_modeling.yaml lines:"178-217" highlight:"178-181,198-200,210-212" footer:true %}

This is highly experimental as the content of *discriminator* field is not clear in the specification's current version ([issue 403](https://github.com/OAI/OpenAPI-Specification/issues/403)) and as far as I know it is not supported by any tool using OpenAPI specification.

## Maps, Hashmap, Associative array

> A map is structure that can map key to value
> [Hash table on Wikipedia](https://en.wikipedia.org/wiki/Hash_table)

A string/string JSON map:

{% code language:json %}
{ 
  "key1": "value1",
  "key2": "value2"
}
{% endcode %}

A string/object JSON map:

{% code language:json %}
{ 
  "key1": {"complexValue1": "value1"},
  "key2": {"complexValue2": "value2"}
}
{% endcode %}

In an OpenAPI specification the key is always a string and do not need to be defined (if the key is an integer, it will be considered as a string).
The value's type is defined within the property: [*additionalProperties*](https://github.com/OAI/OpenAPI-Specification/blob/master/versions/2.0.md#model-with-mapdictionary-properties).

### String to String Hashmap:
If you want to have a string to string map property in the *Person* definition explaining which languages this person speaks, the resulting data would look like this:

{% code language:json %}
{
"username": "apihandyman",
"spokenLanguage": { 
    "en": "english",
    "fr": "French"
  }
}
{% endcode %}

Defining the *spokenLanguage* property in the *Person* definition is done this way:

{% codefile file:simple_openapi_specification_14_advanced_data_modeling.yaml lines:"109-138" highlight:"133-134, 136-138" footer:true %}


### String to Object Map
If you want to have a string to object map property in the *Error* definition to provide a multilingual long and short error message, the resulting data would look like this:

{% code language:json %}
{
  "code": "UNERR",
  "message": { 
    "en": {
        "shortMessage":"Error", 
        "longMessage":"Error. Sorry for the inconvenience."
    },
    "fr": {
        "shortMessage":"Erreur", 
        "longMessage":"Erreur. Désolé pour le dérangement."
    }
  }
}
{% endcode %}

Defining the *message* property in the *Error* definition is done this way:
{% codefile file:simple_openapi_specification_14_advanced_data_modeling.yaml lines:"150-159" highlight:"158-159" footer:false %}
{% codefile file:simple_openapi_specification_14_advanced_data_modeling.yaml lines:"164-176" highlight:"175-176" footer:true %}

### Hashmap with default value(s)
And finally, if you want to add a default language multilingual error message in your map (i.e. adding a default value in the map).  

The returned structure do not differs from the precedent example:
{% code language:json %}
{
  "code": "UNERR",
  "message": {
    "defaultLanguage": {
        "shortMessage":"Error", 
        "longMessage":"Error. Sorry for the inconvenience."
    }, 
    "en": {
        "shortMessage":"Error", 
        "longMessage":"Error. Sorry for the inconvenience."
    },
    "fr": {
        "shortMessage":"Erreur", 
        "longMessage":"Erreur. Désolé pour le dérangement."
    }
  }
}
{% endcode %}

But in the OpenAPI Specification, we add a *defaultLanguage* property to the *MultilingualErrorMessage* definition to the explicitly declare this value in the map:

{% codefile file:simple_openapi_specification_14_advanced_data_modeling.yaml lines:"150-176" highlight:"160-162" footer:true %}

You can define as many as "default" values as you want.
This also can be used for string to string map.

*Inspired by this [stackoverflow question]((http://stackoverflow.com/questions/29666480/how-can-i-define-a-map-with-arbitrary-keys-in-a-swagger-model)) answered by [Ron Ratovsky](https://twitter.com/webron)*

# Conclusion
You now have mastered the art of defining an accurate data model with the OpenAPI Specification.
Be aware that even if the OpenAPI Specification defines all this possibilities, some may not be supported/used by every tool working with OpenAPI specification files. But at least your API data model's description will be highly accurate.
In the [next post](/writing-openapi-swagger-specification-tutorial-part-5-advanced-input-and-output-modeling/) we'll continue our delving in the specification and learn all tips and tricks to describe the input and outputs of an API.
