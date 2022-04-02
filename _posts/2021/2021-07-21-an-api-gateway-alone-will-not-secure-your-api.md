---
title: An API Gateway alone will not secure your API
date: 2021-07-21
author: Arnaud Lauret
layout: post
permalink: /an-api-gateway-alone-will-not-secure-your-api/
category: post
---

How many times people realized that an API was not so secured despite being exposed on an API gateway?
Too many times.
While being a must have to securely expose APIs, an API gateway will not do all the security work for you.
Security in general, and API security in particular, is a matter for everyone.
Let's see what is the job of an API gateway and what you still have to do to actually securely expose APIs.
<!--more-->

# What's an API gateway's job?

In its most usual form, an API gateway is a proxy that sits between server applications exposing APIs and their consumer applications (they could be other server applications, mobile applications, web applications or whatever).
An API gateway may bring features such as logging, monitoring, rate limiting, simple connection to API catalogue or API developer portal (sometimes bundled with it), request/response transformations (we'll talk more about that terrible idea in a later post) and more.
But these are only _additional_ features, an API gateway's core job is security.

## A guard at the gate

An API gateway's fundamental role is to ensure that:

- Only registered consumer applications can consume the exposed APIs
- Each registered consumer application only consumes the API(s) it is allowed to
- And each registered consumer application only use an API's operations it is allowed to

For instance, if an API gateway exposes a CRM (Customer Relationship Management) and a Contract APIs:

- Unregistered consumers won't be able to consume any of those APIs
- A registered consumer may be allowed to consume only the CRM API and not the Contract one.
- This registered consumer allowed to consume the CRM API may be allowed to only call "Search customers" and "Read customer" operations but not the "Create customer" one.

## A "security languages" interpret 

In order to make API calls, a consumer must provide a valid access token along with its requests.

{% include quote.html 
    source="Monty Python's and The Holy Grail"
    author="Knight of Ni"
    text="You must return here with a shrubbery... or else you will never pass through this wood... "
%}

A registered consumer request an access token using its credentials, if end users are involved the API gateway will talk to an identity provider to authenticate them.
The obtained access token is a proof that this consumer is allowed to consume some APIs exposed on the gateway in the name of someone.
On every call, the consumer sends this access token along with its request.
A call will only be transmitted to the implementation if the token is still valid (it may have expired) and linked to a consumer being allowed to use the API's operation mentioned in the request.

To achieve that, an API gateway may have to speak "Oauth 1.0", "Oauth 2.0", "Oauth 2.1", "SAML", "OpenID Connect", etc... with consumer applications and/or identity providers.
It handles that complexity on the behalf of the server application exposing the API.
This server application, the API's implementation, will receive only authorized calls without having to care about which "security languages" are involved.

# What's your job?

An API gateway simplifies heavily the work for teams building the server applications exposing APIs as they don't have to code to manage complex security protocols or frameworks.
But it does not mean at all that an API gateway handles ALL security aspects.
Yes, I'm deeply sorry, but even when using an API gateway, you still have to work on security.

## Configure and administrate consumers

It's still up to you to actually configure and administrate consumers.
Indeed, you must ensure that:

- Adapted granularity is used when declaring consumers. For a "customer mobile application" will you declare a single consumer (terrible idea), or one for each mobile OS (less terrible but still terrible) or one for each OS and application version (better) or ... 
- Only the API owners can actually let consumers use their APIs. It's not unusual to forget that when building more or less centralized API gateway platform.
- Consumers access rights are revoked when they should. When an old version of a mobile application becomes unsupported for instance.
- Adapted security mode are used. Letting people use the Oauth 2.0 Customer Credentials flow in a mobile application or single page web application is a terrible idea that is too often seen.

But even doing that is not enough, there is still work to do beyond the API gateway.

## Build secured implementations

When the API's implementation receives a call from the API gateway that means the API gateway considers it's a valid one.
But that does not means it's actually valid from the implementation's perspective.
Basically, at implementation level you have to check every single piece of data to ensure that it is coherent with what you know about the consumer and end user.

If a consumer sends a `GET /crm/customers/12345`, the gateway checks the access token is linked to a consumer that is allowed to call the CRM API and more precisely the "Read customer" operation, hence {%raw%}`GET /crm/customers/{customerId}`{%endraw%}.
But the API gateway will not check that the consumer or the end user (if any) are actually allowed to get information about that specific `12345` customer.
It's up to the implementation to check that.
This can be done as long as the API gateway provides information about the consumer and end user along the transmitted request.
And just in case: no, replacing `12345` by a more complex id such as `7a31bfa6-463e-47e0-bf20-193086d5a29d`, does not allow to not do this check.

And the same goes for a `POST /contract/contracts` request which is supposed to create a 1 billion Euros life insurance contract.
It's up to the implementation to check that consumer or end user are allowed to create a contract with such amount and not the API gateway.

By the way, do we actually need to expose those two features?

## Design secured APIs

Before API implementation and API gateway, security must be dealt with during the design of APIs.

It's up to you to choose if you'll create an API or not and which feature you'll put in it or not.
You're under no obligation to create APIs for everything and expose every feature of any system.

And once you're sure about what you want to expose, be sure sure to choose secured design and representation.
For instance avoid putting sensitive data such as personal data in path or query parameters, indeed a {%raw%}`GET /customers/{socialSecurityNumber}`{%endraw%} will be logged by any equipment between consumer and provider.

And last but not least, it is also up to you to choose how the access to the API will be partitioned.
You have to design the scopes that grants access to all of or a subset of the API's operations.
These scopes will be used by the gateway to decide if a consumer is allowed to use an operation or not.
For instance, you can put all of the read operations of the CRM API under the "crm:read_only" scope, the "Create customer" operation under the "crm:partner" and the "Create customer", "Update customer" and "Delete customer" under the "crm:admin" scope.
A consumer which has been granted the "crm:partner" scope can only do "Create customer" and not do "Search customers" or "Delete customer".

# An API gateway is not the API security panacea

So, putting an API gateway in front of your API's implementation may makes your life easier but don't be fooled, you'll still have to actively work on security yourself.
API security concerns the API gateway configuration (consumers, security mode, lifecycle), the implementation (application/fine grained security) and the design (what you expose and how you expose it).