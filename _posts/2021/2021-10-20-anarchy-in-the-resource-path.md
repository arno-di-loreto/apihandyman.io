---
title: Anarchy in the resource path
date: 2021-10-20
author: Arnaud Lauret
layout: post
permalink: /anarchy-in-the-resource-path/
category: post
---

While doing API design reviews and API design training sessions, I often see resource paths designed in an anarchic way.
By anarchic, I mean their various levels seem to have been chosen randomly or some of them seem at awkward places. 
But why should such paths should be considered wrong?
Let's see a few examples of how to not design resource paths to talk about it.
<!--more-->

# What is a resource and a path

In a REST API, a path like `/this/is/a/path` identifies a unique resource and this resource will be manipulated thought standard HTTP methods.
A `GET /this/is/a/path` means "read that resource" and `DELETE /this/is/a/path` means delete that resource.
But beyond that HTTP-esque description, a resource is supposed to represent a business concept.

A business concept could be an easily identifiable object or list of objects such as "user's accounts", or "an account", or "an account's transactions" in a banking API.
But sometimes, they're not such obviously identifiable business objects, they could be processes like "user verification" or "loan simulation".
Whatever their nature, these business concepts must be represented by a meaningful and easy to interpret path.
That seems an obvious platitude right?

# Anarchic paths

Well, not quite.
Sometimes, during my API design reviews or training sessions,  I encounter paths that are not meaningful or not easy to interpret at all.
Here's a selection of what I've seen.

## RPC path

During my API Design 101 training session, the attendees work on a very simple but deadly use case: a product catalog.
An exercise consists in designing a path for the "catalog" and the "product" business concepts (or resources).
The only requirement is ensuring that each path allows to identify each resource in a unique way, some examples such as `/path`, `/another/path`, `/with/a/{variable}` or `/{variable}/in/path` are provided to help attendees understand the vast possibilities.   

And more often than not, one of the attendee designs an "RPC path" such as `/read/product/{productId}`; I actually wait for that eagerly.
That allows me to stress and remind the fact that in a REST API, path are not there to literally represent the "functions" identified to fulfil a use case.
In a REST API, a "function" is represented by an HTTP method + a resource path, and that is not totally intuitive for beginner API designers.

Fixing that is usually quite simple, just remove the "function part" of the path, but ensure that what is left is an actual business concept and the path is actually a good representation of it.

## Stacked path parameters

Often but not always linked to RPC path, I often encounter path containing a stack of path parameters, `/getTransactions/{from}/{to}/{accountId}` or `/transactions/{from}/{to}/{accountId}` for instance.
In the first case, it is just a variation of previous case, but fixing it (hence removing the "get") just leads to the second one.
This paths seems to represent the transactions of an account identified by its id (`accountId)` between two dates (`from` and `to`).
Note that I can guess that because `from` and `to` are fairly common names in such case and probably does not mean "from something to something that is not a date".
I could be wrong, but the risk is low.
So what's the problem?

If we take for granted that filters on collections (lists) are mostly done using query parameters, this current form is the usual sign of "I don't know there's something called query parameters" (and maybe also a sign of "I generated my spec from code" by the way).
The most common representations used in such a case would be just `/transactions` (the list of transactions) and would be used like this `/transactions?accountId={accountId}&from={from}&to={to}` to filter that list on a subset of elements.

If you consider that's is totally normal to use path parameters to filter lists, you have another problem: all of them are mandatory.
That makes such a path highly specific.
What if you need to represent "all transactions" or "transactions between two dates"?
Well, you can add a `/transactions` and a `/transactions/{from}/{to}`.
But what if you want all transaction since the beginning of time to a given date?
What if you need to filter transactions on their type?
You'll have to add new paths, many of them if you want to handle all possible combinations.
And all that to just represent various subsets of "transactions".
Doing that will only make you API complex; better just say there are `/transactions` and manage all possible filters as query params, that will help you and your consumers keep sanity.

And if you want to make `accountId` a required filter, read [What's the problem with required query parameters?](/what-s-the-problem-with-required-query-parameters/).

## Reverse hierarchical organization

The previous example can also be a sign of "I don't know that a path represents a hierarchy".
You'll see it more clearly with this example: `/transactions/accounts/{accountId}`.
I often see this, it is supposed to represent "an account's transactions".
But this path literally describes "a list of transactions containing a list of accounts, each account being identified by accountId". 
The correct path is `/accounts/{accountId}/transactions`, a path is read from left to right (in english), the last element (`/transactions`) describing the actual resource (a list of transactions).

## Unclear relationships

Another example I often get during my API design 101 training session: `/catalog` vs `/product/{productId}`.
If we take for granted that a "catalog" is just a list of "product", we don't really see the connection between those two.
I would prefer a more consistent representation relying on hierarchy and represent them as `/products` and `/products/{productId}`.
You get the single element by just adding it's id to the path representing its parent list.

## Inconsistency between list and single elements

And if you think that the solution is `/products` vs `/product/{productId}`, read [/resources rules and /resource sucks ... or is it the other way around?](/resources-rules-and-resource-sucks-or-is-it-the-other-way-around/)

# My rule of thumb

A good path represents a business concept, such as "resource", and not an action, such as "read resource".

A good path not only relies on semantic, choosing the right words, but also on organization.
A good path must represent a hierarchy, last elements describing the actual resource: `/resources/{resourceId}/sub-resources` is a "sub resources" and not a "resources".

A list's good path represents all possible subsets, taking advantage of query params to get only specif elements.
If `/resources` represents "all resources", it can also represent "resources of type X" with `/resources?type=X`.

Good paths help together to understand how they are related and are guessable.
They must take advantage of hierarchy: `/resources` contains `/resources/{resourceId}` which contains `/resources/{resourceId}/sub-resources`.
You can easily guess how to address parent from child and reverse.