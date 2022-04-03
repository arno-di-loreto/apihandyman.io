---
title: 5 reasons why you should treat private APIs like public ones
date: 2021-12-01
author: Arnaud Lauret
layout: post
permalink: /5-reasons-why-you-should-treat-private-apis-like-public-ones/
category: post
---

"Why should we care about our privates APIs?
They're only consumed by us, so let's do minimal work on them.
We'll keep our effort only for the public ones we sell to the outside world."
Such stance will have terrible consequences for an organization, even more if it will never create public APIs.
Let's see 5 reasons why you should treat privates APIs like public ones.
<!--more-->

# What are private and public APIs?

It's not where an API is exposed or if its use is free or paid that define its nature, but by who it is consumed.
Either it is exposed on some intranet or the internet, a private API is an API that is consumed only by the organization that created it.
For instance, a mobile application's backend API is a private API though it is exposed on the internet.
Either free or paid, a public API is an API that has been created to be consumed by others.
It is usually advertized on the organization's website and can be used by almost anyone willing to accept its usage conditions.
Note that a variant of public APIs often called partner APIs are usually less visible and requires more paper work to use them.

# Why treat private like public

As private APIs are only consumed by the organization creating them, they're often treated as second class APIs.
From a business perspective, they are often seen as just IT department concerns.
From an IT perspective, they are often just seen as technical interfaces.
The result is often quick and dirty terrible APIs, but there's more than that.
Let's see that by exploring 5 reasons why you should treat private APIs like public ones.

## Nurturing people's API mindset

When treating private APIs like public APIs, you care about their design.
You care about why you create them, what problems they will solve.
You care about their look and feel.
Designing best in class APIs that will be easy to understand and easy to use is not something that you do easily at first try, you need to do it again and again.
So, slowly but surely, treating private APIs like public ones instills the API mindset and grow the API skills you'll need for your public APIs.
Also, all people working on APIs will be happy because they learn valuable skills, because they do great things.

If you don't treat private like public APIs, you'll have to learn by creating public ones.
How will you feel failing miserably publicly?
What will be the cost of such failure?
And beyond that, how people will feel?
You'll lose skilled people, you'll lose people who want to learn.

## Simplifying architecture

When you don't think about a private API as a public one, you may do short sighted design and architecture decisions often leading to tightly coupled complex systems, systems that can't be used independently, and so systems that can't be reused easily in other contexts.

I remember some team wanting to build a system exposing its features through 3 different technologies: HTTP based API, Kafka Messaging, and shared folders.
And it's not a "pick the one you like" menu, in order to actually interact with the system you had to use all 3.
Why?
Simply because the team they were working for the first integration could use those technologies.
Unfortunately that way of working couldn't be easily replicated with other teams inside the organization... and even less with the outside world.

Thinking to expose the system to an outside third party adds constraints that guides you to create simpler systems.
In that case HTTP based APIs would have been totally sufficient.

## Ensuring a good level of security

Working "with the family", usually leads to a certain lack of concerns about security: "We know the other team, we can trust them".
Yes, but they still can do mistakes.
Considering any consumer as possibly hostile will avoid bad surprise.
It's not because you trust an other team that you should provide them an API that could arm your systems or leak data that shouldn't leave your system.
And what if the API goes from intranet to internet or have to go public?
Will you remember those small arrangements with security?

So, better wonder if you would "do that" when exposing this feature as a public API?
If the answer is no, then don't do it for a private one.

## Reducing costs

If your private APIs are treated like public ones, they are designed to be easy to understand, easy to use and reusable in various contexts.
That means when a new need arise, you may not need to rebuild everything from scratch because you already have one or more APIs that can be reused to fullfil it.
As those APIs are easy to understand and easy to use, the new teams willing to use them will be able to do it quickly without even asking support to the team providing them.
Less time spent on those evolutions, means less money spend for the organization.

## Achieving faster time to market

And last but not least, treating your private APIs like public ones will help you achieving faster time to market for all of your projects.
Indeed, having highly reusable APIs that can be integrated in a few minutes will make short deadlines totally achievable.
Icing on the cake, if the project is to provide one of your organization service as an API, the private API delivering it could probably be exposed as it is.

# Target the ideal private === public

Even if you don't plan to provide public APIs, considering private APIs as first class APIs like public APIs has many benefits that far outweigh the investment.
The ideal target would be to say that [any API can be a public API](https://apievangelist.com/2012/01/12/the-secret-to-amazons-success-internal-apis/), but sometimes you can't without investing too much.
That's especially true when you start building event oriented architecture on top of Kafka.
No problem, keep the spirit and evaluate what will need to be done in case of public exposure, so you'll make the right decision and the additional work will not be a surprise.