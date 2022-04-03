---
date: 2021-06-09
author: Arnaud Lauret
layout: post
category: post
permalink: /pink-fluffy-unicorn-api-wtf-or-3-reasons-why-choosing-a-not-meaningful-API-name-can-be-a-problem/
title: Pink Fluffy Unicorn API? WTF? (or 3 reasons why choosing a not meaningful API name can be a problem)
---

It is usually considered a terrible practice to name a property or a function with a meaningless name when writing code.
But surprisingly, when it comes to choosing application or API name, some people tend to choose names in a more artistic way (says the "API Handyman" who can name some tool "OpenAPI Chainsaw").
So let's see 3 reasons why choosing a not meaningful API name can be a problem.

<!--more-->

This post is a follow up of a tweet I did a few weeks ago: _"Pink Fluffy Unicorn" is a cute but totally wrong name for an API unless it actually deals with pink fluffy unicorns. Please choose a meaningful name that tells what the API does_.
Someone asked some arguments to back this statement because they seem to have to deal with such cute but counter-productive if not dangerous naming strategy.
And I realized that I have never formalized my thoughts on this topic, hence this post (thanks so much Twitter people!) 

_Very special thanks to [@mrlapingdesign](https://twitter.com/mrlapindesign) for drawing this post's banner._

# It needs explanations

First and most obvious reason why choosing a not totally meaningful name is a terrible idea: it needs explanations.

When starting a new job in a another company/organization, don't you ever have grumbled when discovering that all internal tools such as the credential manager or the leave management tool have totally awkward not obvious names?
Of course, after someone explained you all that (for the 99th time) and if you use them everyday, you may remember their names.
But your new colleague, who arrived a few months later, will also struggle to understand what does what at the beginning.
And someone will have to explain all that (again, for the 100th time).
And if you don't use them often, you'll forget their name and struggle to find them when you desperately need them.

And that applies to anything, including APIs.
If I'm looking for the API managing users, I will not search for Pink Fluffy Unicorn API.
And if I'm looking for the API managing file transfers, I will not search for Blue Fluffy Unicorn API.
When I see a Pink Fluffy Unicorn API, I have absolutely no clue about what it does by just reading its name, and that is really annoying.

Of course, some may object that I could use our awesome API catalog search engine or read the documentation to see that, so using such a not so meaningful name may not be such a big problem.
Maybe, so let's see the second reason, which is major no-go for me.

# It does not set boundaries

Second reason why choosing a not totally meaningful name is a terrible idea: it does not set boundaries.
And that's a major concerns.
Indeed, a well defined and designed API is supposed to be a independent set of operations covering a meaningful set of related use cases.

If this set of operations don't have a meaningful name such as User but is named Pink Fluffy Unicorn, what stops someone to add new features related to a completely different topic such as file transfers?
What stops someone transforming this well defined API into a big ball of mud, a do-it-all API that will make no sense at all and be more complex to maintain?
What stops someone to create a dangerous mixtures composed of internal facing and external facing operations.
Not its name.
Some experienced API designers and developers having working in the team for quite a long time, taking their time to think, actually knowing the purpose of the Pink Fluffly Unicorn, probably won't do such a mistake but what about beginners or people in a rush?

Using a meaningful name creates boundaries that will make most people think twice before adding new features into an API while a meaningless name will open doors to anything.

# It is possibly a sign of API design smell

{% include quote.html 
    author="Nicolas Boileau-Despréaux"
    source="L'art poétique"
    text="Ce que l'on conçoit bien s’énonce clairement, Et les mots pour le dire arrivent aisément (What is well understood is clearly stated, And the words to say it come easily)" %}

The third reason why choosing a not totally meaningful name is a terrible idea is a corollary to the second one: it can be a sign of API design smell.

Did you choose a meaningless name because you're actually unable to find a meaningful one?
We all know that choosing names is hard, but if you are really struggling to find a meaningful name for your API, your API Designer senses should tell you that there's something wrong. 
That could mean your API is not solving the good problem, or solving too much problems or not enough of them.

Easily finding a meaningful name can comfort your vision of the use case/problems you're trying to solve with it.

# Sometimes you have to deal with it

There are cases where a domain, a team or a tool has a not so meaningful name that you would like to keep for reasons such as not totally changing people habits.
Indeed, some people working there for a long time know what means Pink Fluffy Unicorn.
So how to satisfy newcomers and seasoned colleagues?
In such a case you can use a middle ground approach and name your API(s) "Pink Fluffy Unicorn - Meaningful Name".
That way you ensure seasoned colleagues won't be surprised.
But most important you ensure that your API surface (your APIs) is well defined (not a big ball of mud) and understandable by newcomers.
Icing on the cake, you also ensure that people easily connect APIs together which can be interesting in a big organization or when providing public/partner APIs ("Twilio" doesn't mean anything to me but I can get what the "Twilio Messaging API" does).
