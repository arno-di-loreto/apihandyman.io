---
title: API Design Tips And Tricks - Getting, creating, updating or deleting multiple resources in one API call
date: 2017-04-22
author: Arnaud Lauret
layout: post
permalink: /api-design-tips-and-tricks-getting-creating-updating-or-deleting-multiple-resources-in-one-api-call/
category: post
tags:
  - API Design Tips And Tricks
---

Getting, creating, updating or deleting multiple resources in a single API call is a common need in REST APIs. But how to achieve that in a consistent way accomodating how we work with a single resource and REST principles? This is what we'll see in this post.<!--more-->

# Working with a single resource

Before talking about how to work with multiple resources all at once, let's see how to handle a single resource with a REST API.

## Creating a resource
The common way of creating a `resource` is to do a `POST` request on `/resources`. The body of the request containing the resource to create.

{% code language:txt numbers:false %}
POST /resources HTTP/1.1

{
  "some": "some data",
  "other": "some other data"
}
{% endcode %}

If everything is OK and the resource created, the response's status to this request will be a `201 Created` and the response's body will contain at least the ID (`id`) or the URL/URI (`href`) of the created resources. It may also contain the full resource itself. 

{% code language:txt numbers:false %}
HTTP/1.1 201 Created

{
  "id": "ID",
  "href": "/resources/ID",
  "some": "some data",
  "other": "some other data"
}
{% endcode %}

If there's something wrong, the response's status will be an error, for example a `400 Bad Request` because of some missing data and the response's body will contain information about the error.

{% code language:txt numbers:false %}
HTTP/1.1 400 Bad Request

{
  "message": "missing some data" 
}
{% endcode %}

## Getting a resource

Once created a resource can be accessed with a `GET /resources/ID` request. If everything is OK, the server will return a `200 Accepted` and the resource. If there's something wrong, it will return an error like `404 Not Found` if the resource does not exist or a `403 Forbidden` if the user is not allowed to access that resource.

## Updating a resource
A `PATCH /resources/ID` request will update partially a resource:

{% code language:txt numbers:false %}
PATCH /resources HTTP/1.1

{
  "other": "modified data"
}
{% endcode %}

If everything is OK, the server will return a OK status like `200 Accepted`, and just like with the `POST` request, the body may contain the updated resource.

{% code language:txt numbers:false %}
HTTP/1.1 200 Accepted

{
  "id": "ID",
  "href": "/resources/ID",
  "some": "some data",
  "other": "modified data"
}
{% endcode %}

If there's a problem, the server will return an error. This error could be, for example, a `404 Not Found` due to an invalid ID.

{% code language:txt numbers:false %}
HTTP/1.1 404 Not Found

{
  "message": "Resource <ID> not found" 
}
{% endcode %}

## Replacing or creating a resource

While a `PATCH /resources/ID` updates partially a resource, a `PUT /resources/ID` one will replace the resource. It may also create a new resource with the provided ID if it does not exist (and if it is allowed).

{% code language:txt numbers:false %}
PUT /resources/ID HTTP/1.1

{
  "some": "some new data",
  "other": "some other new data"
}
{% endcode %}

If everything is OK, the server will return a OK status. Depending on what happened the status may be, for example, a `200 Accepted` for a replacement of an existing resource or a `201 Created` when a resource has been created. 

{% code language:txt numbers:false %}
HTTP/1.1 200 Accepted

{
  "id": "ID",
  "href": "/resources/ID",
  "some": "some new data",
  "other": "some other new data"
}
{% endcode %}

## Deleting a resource
And finally, to delete a resource, the request is `DELETE /resources/ID` without a body. If everything is OK, the server will return a `200 Accepted`. If there's something wrong, it will return an error like `404 Not Found` if the resource does not exist or a `403 Forbidden` if the user is not allowed to delete that resource.

## But why explaining all that? I want to work with multiple resources!

To work with multiple resources with a REST APIs, you definitely need to know how to work properly with a single one. This quick reminder is there to show how we use the HTTP protocol in REST APIs to express what we want to do and what happened in **a clear and consistent way** when working with a single resource:

- the URI define which resource we are using
- the HTTP method express what we want to do
- the HTTP response status explain what happened

Now we'll see how continue to do so when working with multiple resources.

# Same action on resources of the same type

So what if I want to `PATCH /resources/ID1` and `PATCH /resources/ID2` at the same time? When it comes to do one thing with multiple resources of the same type all at once:

- We send a request providing:
  - the **type** of **all** resources
  - the **action** which will be applied to all these resources
  - the **identified** data for **all** resources
- We expect **a** response providing the result for **each** resource containing exactly the same information as if we had made a single request

## A request containing multiple resources

To tell the resources type we're working with, we will use the endpoint corresponding to a collection of resources, for example `/resources` or `/users/bob/friends`.

To identify the action we want to apply on the resources we'll simply use the matching HTTP verb:

- `GET /resources` to get multiple resources
- `POST /resources` to create new resources
- `PATCH /resources` to update multiple resources
- `PUT /resources` to replace multiple resources
- `DELETE /resources` to delete multiple resources

How to provide resources data and identifier will slightly vary depending on the action.

### Create multiple resources

To provide all needed information for a creation, we have to send an array of items containing a unique identifier determined by the consumer (`id`) and the resource's data (`body`):

{% code language:json numbers:false %}
[
  {
    "id": "CREATION1",
    "body": {"resource's": "data"}
  },
  {
    "id": "CREATION2",
    "body": {"resource's": "data"}
  }
]
{% endcode %}

It can also be done with a key/value map, the resource's ID being the key and its data the value:

{% code language:json numbers:false %}
{
  "CREATION1" : {"resource's": "data"},
  "CREATION2" : {"resource's": "data"}
}
{% endcode %}

Receiving these data with a `POST /resources` request, the server will create the 2 resources provided. The provided `id` will be used in the response to identify the response corresponding to this resource.

### Update or replace multiple resources
To update or replace multiple resources, it's exactly the same thing, besides the value of the resource's id, which will be the one we would have use for a single resource (`/resources/ID`).

{% code language:json numbers:false %}
{
  "ID1" : {"resource's": "data"},
  "ID2" : {"resource's": "data"}
}
{% endcode %}

Receiving these data with a `PATCH /resources` request, the server will execute both `PATCH /resources/ID1` and `PATCH /resources/ID2` (it works the same with `PUT`). Just like with `POST`, the provided ids will be used to identify each response.

### Get or delete multiple resources
To get or delete multiple resources we will again use the resources ids but as a `GET` or `DELETE` request does not have a body, they will be provided in a query parameter like this `DELETE /resources?ids=ID1,ID2`.

## A response containing responses

A response to such a request will have to contain exactly the same data we would have had doing single calls. We need to provide a response containing multiple responses, how can we do that?

> One Status Code to bring them all and in the lightness bind them  
> *The Lord of the HTTP Status Codes*

The 207 HTTP status code is exactly what we're looking for:

> The 207 (Multi-Status) status code provides status for multiple independent operations

This status has been defined by [RFC 4918](https://tools.ietf.org/html/rfc4918#section-11.1) *HTTP Extensions for Web Distributed Authoring and Versioning (WebDAV)*. Here's an example of a WebDAV 207 response when deleting some resources:

{% code language:xml numbers:false %}
<?xml version="1.0" encoding="utf-8" ?>
<d:multistatus xmlns:d="DAV:">
  <d:response>
    <d:href>http://www.example.com/container/resource3</d:href>
    <d:status>HTTP/1.1 423 Locked</d:status>
    <d:error><d:lock-token-submitted/></d:error>
  </d:response>
  <d:response>
    <d:href>http://www.example.com/container/resource4</d:href>
    <d:status>HTTP/1.1 200 OK</d:status>
  </d:response>
</d:multistatus>
{% endcode %}
  
{% img file:whatthehellisthat.gif %}

Oops, sorry for the XML, it's only to show that a WebDAV *207* response contains a list of response. Each of this response point to a resource (href) and contains also the response itself, how could it look in a less frightening JSON way:

{% code language:json numbers:false %}
[
  {
    "id": "ID1",
    "status": "201",
    "headers": [
      {"header's name": "header's value"}
    ],
    "body": { "the": "response's body"}
  },
  {
    "id": "ID2",
    "status": "400",
    "headers": [
      {"header's name": "header's value"}
    ],
    "body": { "the": "response's body"}
  }
]
{% endcode %}

A 207 will response will contain a list of responses, each response containing:

- An identifier (`id`) matching the one provided in the request
- The HTTP response's data composed of a `status`, `headers` and a `body`. These data are exactly the same we would have received for a single call.

Note that we can also use a map in which the keys are the responses identifiers:

{% code language:json numbers:false %}
{
  "ID1": {
    "status": "201",
    "headers": [
      {"header's name": "header's value"}
    ],
    "body": { "the": "response's body"}
  },
  "ID2": {
    "status": "400",
    "headers": [
      {"header's name": "header's value"}
    ],
    "body": { "the": "response's body"}
  }
}
{% endcode %}

We could even match request and response based on position in the list.

## Two levels of error

In that case, we must be aware that there are two types of errors, the one concerning one or more of the resources and the one concerning the *multiple* request itself.

For errors concerning the action on each resource), the HTTP status returned by the server will be a 207 and each sub-response will contains the status for each sub-request (as explained in previous paragraph).

For errors concerning the main request (misspelled query parameter for DELETE, or invalid body map/list structure for example), the server may return a *400 Bad Request* for example.

## Single and multiple creations with the same endpoint

Note that `POST /resources` was supposed to be used to create a single resource. If we want to handle the single/multiple duality we have two options:

### Use a list/map for both case

The input is exactly the same for 1 or more resources, we will only provide a single one item to create a single resource.

{% code language:json numbers:false %}
{
  "CREATION1" : {"resource's": "data"}
}
{% endcode %}

The server's response should be always be the one described earlier for multiple creations even if there's only a single item.

### Accept both a list/map and single object

The input for a single resource contains only the resource's data:

{% code language:json numbers:false %}
{"resource's": "data"}
{% endcode %}

The server response will be the one expected for a single creation.

The input for multiple resource contains a list/map:

{% code language:json numbers:false %}
{
  "CREATION1" : {"resource's": "data"}
  "CREATION2" : {"resource's": "data"}
}
{% endcode %}

The server response will be the one expected for a multiple creations as seen earlier.


# Different actions on resources of the same type 
What if we want to `DELETE /resources/ID1` and `PATCH /resources/ID2` at the same time? As it is an action that impacts the data in various way we should use the `POST` HTTP verb. Concerning the URI, we have two options, use `/resources` or create a specific resources for this use case like `/resource-modifications` for example. The request will be then something like `POST /resources` or `POST /resource-modifications` and we will have to provide the action (`method`) for each resource:

{% code language:json numbers:false %}
[
  {
    "id": "ID1",
    "method": "DELETE"
  },
  {
    "id": "ID2",
    "method": "PATCH",
    "body": {"resource's": "data"}
  }
]
{% endcode %}

The server will do `DELETE /resources/ID1` and `PATCH /resources/ID2` and the response will be a *207* using the structure using the provided `id` as seen previously in his post.

# Different actions on resources of different types
What if I want to do `DELETE /resources/ID1` and `PATCH /another-resources/ID2` at the same time?

{% img file:waitwhat.gif %}
  
This is really nasty and definitely not REST, but it can be useful for [backend for frontend or experience API](https://www.infoq.com/articles/api-facades) for example.

To do that we'll need to `POST` data on a specific endpoint which could something like `/batch`, `/bulk` or even `/` and we will have to add a `uri` and replace the `id` value by something provided by the consumer:

{% code language:json numbers:false %}
[
  {
    "id": "ACTION1",
    "uri": "/resources/ID1",
    "method": "DELETE"
  },
  {
    "id": "ACTION2",
    "uri": "/another-resources/ID2",
    "method": "PATCH",
    "body": {"resource's": "data"}
  }
  ,
  {
    "id": "ACTION3",
    "uri": "/resources",
    "method": "POST",
    "body": {"resource's": "data"}
  }
]
{% endcode %}

Actions number 1 is `DELETE /resources/ID1` and its result will be identified in the 207 response by the id `ACTION1`.

To see a complete example you should take a look at [Facebook's Graph API batch endpoint](https://developers.facebook.com/docs/graph-api/making-multiple-requests) documentation. Note that this batch endpoint match request/response based on index and does far more than just processing a bunch of request.