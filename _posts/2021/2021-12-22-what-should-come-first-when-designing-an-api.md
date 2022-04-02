---
title: What should come first when designing an API?
date: 2021-12-22
author: Arnaud Lauret
layout: post
permalink: /what-should-come-first-when-designing-an-api/
category: post
---

Either you provide public or private APIs, you must have a design first approach.
But what does actually mean "design first"?
Does it mean religiously writing all your `GET /this` and `POST /that` in an OpenAPI file?
But if that so, how is this so different from the code first approach where you write actual code to generate an OpenAPI file?
Maybe it's time to clarify what should come first when designing API.
<!--more-->

# Definitions

The "design first" and "code first" approach are very often opposed to each other.

The "code first" approach consists in coding the implementation and generating from it a formal description afterwards, usually an OpenAPI Specification file.
If you've read this blog you know what I think about generating OpenAPI from code in such a case (if not, you should read [6 reasons why generating OpenAPI from code when designing and documenting APIs sucks](/6-reasons-why-generating-openapi-from-code-when-designing-and-documenting-apis-sucks/)).
This approach has some serious drawbacks but I work with teams who are happy with it.
Either you like it or not, either it can have some drawbacks (but also some advantages), should this approach be opposed to "design first"?

Nope, that's a wrong debate.
The "design first" approach is unfortunately more often than not used to describe something else.
Indeed, it is often used to describe the "spec first" approach, an approach in which you describe formally an API using an API specification format such as the OpenAPI Specification before writing any line of code of the implementation.

So, what means "design first"?
The "design first" approach simply means you actually "design" your API before doing anything else.
And that could actually be done in both "spec first" and "code first" approaches.
Indeed, if I know my API needs a `GET /this`, and even if [generating OpenAPI Spec from code sucks]((/6-reasons-why-generating-openapi-from-code-when-designing-and-documenting-apis-sucks/)), there's no big difference between writing OpenAPI Spec code and your favorite language code.

There's no big difference ... as long as you actually _design_ your API first.

# Natural language almost first

So what truly is this "design first" approach that you MUST actually use to create APIs?
When designing an API, what should come first is not thinking about `GET /this` and `POST /that`.
What comes first is the needs your API should fulfill.
And those needs are not `GET /this` and `POST /that`, those needs are more like "Search products" or "Place an order.

Before thinking about HTTP methods and resource paths, you must have a clear understanding of the needs.
And you must describe them using crystal clear natural language.
You usually start with high level needs like "buying some products" and decompose them in flows, each step being an actual operation of your API, like "Search products", "Add product to basket" and "Place an order" (read more about all that in my book [The Design of Web APIs](https://www.manning.com/books/the-design-of-web-apis)).
Working using natural language allows to include everyone in the conversation and to focus on the business perspective while keeping REST & HTTP heated discussions for later.
Actually having a clear description of what the API should do in natural language facilitate those later discussions.
 
By the way, if [you're an ESL API Designer I recommend to do that in your native language](/excuse-my-french-api-or-being-an-english-as-a-second-language-api-designer/#when-should-i-use-english-during-design-process).

So, whatever works in your context, spec or code first, design your API by working first on the needs using natural language.
That's the heart of design first.