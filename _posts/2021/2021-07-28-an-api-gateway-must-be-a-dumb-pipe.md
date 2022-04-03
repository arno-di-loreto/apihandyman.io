---
title: An API gateway must be a dumb pipe
date: 2021-07-28
author: Arnaud Lauret
layout: post
permalink: /an-api-gateway-must-be-a-dumb-pipe/
category: post
---

An API gateway is a proxy that sits between API providers and their consumers.
Its main role is to ensure that only authorized consumers consume some APIs.
But API gateways usually come also with features such as request/response transformation and some of them even allow to code complex orchestration.
Such transformation features can be very useful if used wisely.
But they also can give terrible ideas with terrible consequences.
<!--more-->

# Good transformation and orchestration

The most basic API gateway will allow to expose an API on `https://api.motu.com/v1` while it's implementation is exposed on `https/under.lying.server.prod/whatever/path`.
Before transmitting the request to the underlying server `https/under.lying.server.prod`, it will modify the path, replacing `v1` by `/whatever/path`.

As security is probably not handled the same way before and after the gateway, it may remove the original Authorization header containing a meaningless access token and replace by another one containing a JWT token holding information such as which consumer app made this call and in the name of who.

If it takes advantage of an API description format such as the OpenAPI Specification, it may strip the a `GET https://api.motu.com/v1/characters?unknownFilter=skeletor` request from the `unknownFilter` query parameter which is not declared in the interface contract.
It may does the same on the response and strip any undeclared headers.

Possibly, it may seamlessly handle a `POST /whatever` request coming with a `X-HTTP-Method-Override: PUT` header and turn it into a `PUT /whatever`. (See {% include post-link.html alias="http-method-override" %})

Beyond simple transformation, an API gateway may do some orchestration like sending request and response logs somewhere for instance.

# Bad transformation and orchestration

All that basically means an API gateway allows to "write code", real code using JavaScript, Java, Groovy or whatever language and/or pseudo-code using box and arrow based GUIs.
And seeing that, some may have terrible ideas. 

When returning the response of `GET /characters/he-man` why not transforming `"type": "H"` to `"side": "hero"`?
Why not taking the USD `price` in `GET /toys/he-man` response and convert it into EUR calling a third party API?
Why not returning a subset of `GET /characters/he-man` and `GET /toys/he-man` when responding to `GET /action-figures/he-man`?

Why not indeed?

If you do that, you put business logic outside of its original domain, its original implementation.
It's not uncommon to have business logic split across various components but putting it in an API gateway can be a problem.

It may simply introduce complexity in the development workflow.
Coding on this component may be easy ... but coding with all the CI/CD, quality checks, ... stuff may not be that simple. 

Also, coding in that component may require special skills that the team owning the business logic, the team actually implementing the original underlying APIs may not have.
So this team may have to delegate that code to someone else.
And that may lead to organizational issue and a lack of ownership.
The original team may think they don't own that code and not really care about it.
The other team coding on the gateway may not care as much as the original team, and even if it's not the case, as they may not know the underlying business rules that can cause some bugs.

# An API gateway is a smart-dumb pipe

Introducing business logic in an API gateway basically transforms it into a good (or very bad I should say) old ESB.
Remember them?
Those bloated too smart pipes that ruined many information systems because they were so complicated to manage.
So don't do that, keep API gateways dumb.
Well, not so dumb; as long as an API gateway do smart "API exposition related stuff" and stays dumb from a business perspective, that's totally ok.
 