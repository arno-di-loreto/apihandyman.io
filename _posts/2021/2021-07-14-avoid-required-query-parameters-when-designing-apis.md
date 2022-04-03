---
title: What's the problem with required query parameters?
date: 2021-07-14
author: Arnaud Lauret
layout: post
permalink: /what-s-the-problem-with-required-query-parameters/
category: post
---

When reviewing API designs, I often encounter operations such as `GET /resources?queryParameter=value` where the query parameter is required.
Consumers won't be able to make that request without providing this parameter and a correct value; that's usually a problem.
Indeed, at best it will ruin developer experience and at worst it is a sign of design smell.
Let's see why.
<!--more-->

# What are query parameters and how they are usually used

According to {% include rfc.html code="3986" section="3.4" %}, the "query component" of a URI is everything that goes after a question mark (`?`).
The elements coming after that question mark are often in the form of a `key=value` pair. 
That means in `https://api.eternia.com/characters?hasMagicalPowers=true`, `hasMagicalPowers` is a query parameter and its value is `true`.

Query parameters can be used in any type of HTTP requests but in most REST/RESTful/RESTish APIs, such query parameters are added on operations such as `GET /characters`, that represents something like "list characters" or "search for characters", in order to allow consumers to filter the results.
While a `GET /characters` is supposed to return all characters, a `GET /characters?hasMagicalPowers=true` will only return the ones having magical powers.

{% include post-link.html format="note-read" alias="resources-vs-resource" comment="If you wonder why `/characters` and not `/character`" %}

# Required query parameters ruin DX

I have a rule of thumb when designing APIs: whatever the type of inputs, the less you request, the better because that help people do their first request and later ones without having to think too much.
That is key when you want to build the best possible DX (developer experience).
And query parameters are no exception.

In the example above, turning `hasMagicalPowers` into a required query parameters will first lead to people failing their very first request because they expect that a `GET /characters` can be done without any query parameters.
Why would they expect that?
Because it's the most encountered behavior.
That does not seem much, that's not exactly "ruining" the developer experience but that's quite annoying.
This could be the straw that breaks the camel's back, people may go elsewhere especially if there are other APIs offering the same services without such silly behavior.

And second problem, that leads to consumers having to make at least 2 requests in order to get all characters (pagination set aside), one to get those having magical powers and another one to those who haven't.
That is not really good for developer experience, it may actually ruin it.
Obviously, in such situation, most of designers would never do that as beyond crippling developer experience, such design does not make any sense at all from this domain (Masters of the Universe franchise's characters) perspective.

But there are other use cases that are less obvious.

The [Masters of the Universe](https://en.wikipedia.org/wiki/Masters_of_the_Universe) franchise had multiple TV cartoon installments (and no, the live action movie does not exist).
Let's take for granted that the original one made at the beginning of the 80s is the most known and loved one.
Let's take also for granted one that people looking for information about that franchise's characters want to be able to get information about the characters of that specific version.

That means when calling `GET /characters`, it could make sense to filter the results based on the TV show and so add a `tvShow` query parameter that could take values such as `80s_original_that_rules`, `90s_version_that_sucks` or `all`.
Some designer could be tempted to make this query parameter a required one, letting consumers choose which characters list they want.
But the rule of thumb is to request the less possible information to consumers.
So let's avoid this by keeping the `tvShow` parameter optional and using the most expected default value, obviously `80s_original_that_rules`.
That way, consumers could do a successful `GET /characters` without thinking much, the implementation filling the gap returning the results that would please most consumers (characters from the 80s version).
After that, having read the documentation further, consumers may use the other possible values of `tvShow`.

In a more real use case, the problem could come from a date filter on time series data.
Let's say that for performance reasons for instance, the implementation absolutely needs a date to returns a subset of all available data.
In such a case, keep the parameter optional but choose the "best" default date to use if it is not provided by consumers.
It could be today, first day of the month, last whatever processing date or whatever date will make sense from a business rule perspective and that will please most consumers.

Whatever the query parameter, there is most of the time a way to keep it optional... if that parameter is not the sign of something more nasty.

# Required query parameters can be signs of design smells

Indeed besides possibly "ruining" the developer experience, a required parameter can be a sign of design smell.

Let's analyse the `GET /enemies?of=characterId` request which has an `of` required query parameter.
It is supposed to return the enemies of someone, for example Skeletor and Beast Man are enemies of He-Man (`GET /enemies?of=he-man`) while He-Man and Teela are enemies of Beast Man (`GET /enemies?of=beast-man`).
The `of` parameter being required, my API design reviewer senses tell me there's something wrong without even thinking about the purpose of this operation.

My first attempt is usually to check if the required parameter can be turned into an optional one.
Here, returning the enemies of "no one" doesn't make sense.
Returning the enemies of a default character also makes no sense at all.
So that does not smell good.

Indeed, if any character can be seen as an enemy by any other character, the resource that should be manipulated when representing "listing the enemies of someone", is not just "enemies" but the "enemies of someone".
That means the resource path should be something like `/characters/{characterId}/enemies` instead of just `/enemies` (the character).

Based on my experience, when the query parameter cannot be removed that is most of the time the sign of a "wrong resource identified" and the fix is usually adding a level in the resource's path hierarchy.

# Think twice before adding a required query parameter

So the next time you're tempted to make a query parameter required, double check that you're using the right resource and especially not missing a level in your resources hierarchy.
If the parameter actually makes sense, think about what could be the more useful value for most consumers and use it as default when that parameter is not provided.


