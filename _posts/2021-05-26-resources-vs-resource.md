---
date: 2021-05-26
author: Arnaud Lauret
layout: post
category: post
permalink: /resources-rules-and-resource-sucks-or-is-it-the-other-way-around/
title: /resources rules and /resource sucks ... or is it the other way around?
---

Using singular or plural to represent a list of something is an old debate in computer science, especially in the database field.
But what about APIs then?
It's still the same, if you look at various APIs, you'll see that something like "list/search resources" could be either represented by a `GET /resources` or a `GET /resource`.
Who is right?
Who is wrong?
I have a preference, you may have another, but should we really give importance to such a debate?
Aren't we missing something?
Let's investigate that topic and discover what's really important when choosing collection resource path.
<!--more-->

# Is there a "right" REST solution?

Regarding choosing between `/customer` and `/customers`, I often meet people who ask me "is _whatever solution_ RESTful?" which basically means "what is the _right_ solution?".
When doing a choice, I always try to refer to a RFC, standard or common practice in order to make the "right" choice.
So, let's see what the [REST Architectural Style dissertation](https://www.ics.uci.edu/~fielding/pubs/dissertation/top.htm) says about that.

In short, REST is an architectural style which has been created by Roy Fielding to explain how distributed applications should interact with each other.
He did that to explain how the HTTP protocol work and analyze factually the impact of its possible evolutions.
Actually, he chose to describe factually a model and confront others ideas to this model, rather than just saying "my way is the best", which is something that we all should think about.
This architectural style defines a set of constraints (client/server separation, statelessness, cacheability, layered system, uniform interface and code on demand)that a REST system must conforms to.

REST APIs (or RESTful) APIs are supposed to embrace the REST Architectural Style and its constraints.
Actually, this more often than not means those APIs try to conform more or less to HTTP semantic without thinking too much about all REST constraints.
Speaking of constraints, does Mr Fielding dissertation talks about choosing resources paths?
Resource paths (or resource identifiers) are not precisely identified as a constraint but there are some guidance provided:

{% include quote.html
    author="Roy Fielding"
    source="Architectural Styles and the Design of Network-based Software Architectures"
    url="https://www.ics.uci.edu/~fielding/pubs/dissertation/evaluation.htm#sec_6_2_1"
    text="The definition of resource in REST is based on a simple premise: identifiers should change as infrequently as possible. Because the Web uses embedded identifiers rather than link servers, authors need an identifier that closely matches the semantics they intend by a hypermedia reference, allowing the reference to remain static even though the result of accessing that reference may change over time. REST accomplishes this by defining a resource to be the semantics of what the author intends to identify, rather than the value corresponding to those semantics at the time the reference is created. It is then left to the author to ensure that the identifier chosen for a reference does indeed identify the intended semantics."
%}

For what matters in this post, this could be summarized by saying resource identifiers (or path) should change as infrequently as possible and it is up to the author to choose the most adapted semantics.
So as you can see, nothing about singular or plural, according to the REST architectural style, it's up to us to choose as long as it means something.

# What is sure: don't do both

So according to REST principles, `/resources` or `/resource`, you can choose the one you like.
But you have to choose one, you can't use both, for the sake of consistency and predictability.

Indeed, it would be quite awkward to do `GET /customers` to search or list customers and a `GET /order` to list orders.
APIs are supposed to be consistent with themselves and other APIs of the same domain/organization.
Choose one format, write it down in your API design guidelines and ensure that everyone designing APIs in your organization stick to this choice.

And for those who would come to the idea of using `GET /customers` to search or list customers and a {% raw %}`GET /customer/{customerId}`{% endraw %} to read a specific customer, because "oh, we are reading a single element so let's go singular now".
Please don't do that.

If people do a `GET /whatever` to get a list of whatever they're used to brainlessly do a {% raw %}`GET /whatever/{whateverId}`{% endraw %} to get a specific element.
You'll disturb many people by breaking habits.
But there are more than habits involved here, doing that simply breaks the semantic of paths.
In a file system, do folder names change when you target a file inside them?
In a database, do you change table name when doing a `select * where id=whateverId`?
No.
So, please chose one side or the other, no middle ground here.

# My reasoned opinion: plural

I use plural names for collections mostly because of semantics: plural means "it contains multiple elements". 
Note that I use plural in both path (`/customers` is a path of collection resource) but also in data models (`customers` is a property representing a list of customers inside a data model).

Using plural name for a collection also avoid surprise when having singleton resources, for instance {% raw %}`GET /customers/{customerId}/address`{% endraw %}, I know by reading this that I'll manipulate a single address and not a list of address.
That's the main reason why I'm not using singular.
Using singular for collection name would make that less obvious, though the data returned by a {% raw %}`GET /customer/{customerId}/address`{% endraw %} would give more than a hints about what is actually returned (list or single element).
But that requires to trigger a read operation call to know that (if we don't rely on documentation at all).

But let's be objective, the plural option is not without drawbacks.
Obviously as a machine getting data containing a `customerId` (singular) and trying to guess how the API work without taking advantage of the documentation, I have some work to do to "know" that the plural of customer is customers in order to try a {% raw %}`GET /customers/{customerId}`{% endraw %} (which is quite simple here but determine singular or plural is not always that simple).
But if your API is a true REST API that shouldn't be a problem because it provides the ready to use links to other resources.
Problem solved if that's actually a problem, which is not the case most of the time.
Indeed most people don't care about hypermedia nor automatic API discovery and rely on the API documentation to write code that actually use the API (even for testing).

Regarding the singular option, I also wonder how then would be called a customer list inside a data model?
I would probably add a suffix (`customerList`) but then that introduce inconsistency between path and data, that is another reason why I prefer the plural option.

# The truth is elsewhere

I think the lesson to learn here is not determining which one is "better" between `/resources` and `/resource`, I'm sure someone using singular name has plenty of good reason doing so.
No, the lesson here is that when there is non refutable standard solution, you have to reason to choose one that makes sense.
Avoid "just because" solutions that you can't explain.
Avoid at all costs "wtf" solutions (like `GET /customers` + {% raw %}`GET /customer/{customerId}`{% endraw %}) introducing complexity or inconsistency.
And don't forget to put it in your guidelines and ensure that everyone in your organization stick to that decision for the sake of consistency.