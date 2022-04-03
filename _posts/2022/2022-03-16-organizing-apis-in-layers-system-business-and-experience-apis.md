---
title: "Organizing APIs in System, Business, and Experience Layers"
series: 3 dimensions to consider for a successful API-First strategy
series_number: 1
date: 2022-03-16
author: Arnaud Lauret
layout: post
permalink: /organizing-apis-in-layers-system-business-and-experience-apis/
category: post
---

Either for historical, organizational, or technical reasons, not all APIs are at the same level, especially in organizations that do not start their API-First journey from scratch. APIs can be organized into three different layers: system APIs, business APIs, and experience APIs. This post is the first of the "3 dimensions to consider for a successful API-First strategy" series.
<!--more-->

{% include banner-author-link.md %}

{% include _postincludes/3-dimensions.md %}

In this first post, we'll talk about organizing APIs in layers (system, business, experience). That allows uncovering some architecture questions such as "how can I APIfy my IT mess" while instilling the importance and benefits of "don't make me think" APIs.

{% include image.html source="api-layers.png" %}

# System APIs Layer

The lowest or most hidden API layer is the system APIs layer. System APIs aim to simplify access to software solutions, but just from a technical perspective.

If you have a good old mainframe system, you may build (or buy) an HTTP access layer façade to put it on top of it to facilitate access to its COBOL programs. Not-so-old Commercial-Off-The-Shelf software products (COTS) are unfortunately known to provide terrible APIs (when they provide some).  Software-As-A-Service (SAAS) solutions usually provide APIs. They usually are less terrible than COTS ones but not always, unfortunately.

These different APIs are system APIs. They give direct access to the heart of a system, can be tainted by the provider's technical perspective, or often require a high level of technical or business/subject matter expertise and possibly some knowledge of the underlying implementation. 

They MUST stay private and never be exposed publicly to the outside world. Exposing them to other teams inside the organization should be done cautiously. If that can be avoided, that would be much better. 

They offer a terrible DX. It takes an awfully long time to integrate them into other systems for the uninitiated consumers. Their provider will also lose time in the making as they will have to accompany closely consumers, answers to their many questions. 

Using them leads to a detrimental tight coupling because they require a high level of expertise. Such coupling must only exist with very few other systems. 

And the icing on the cake, they are prone to cause security issues. That's less true for SAAS but almost a certainty for COTS. More often than not they do not propose standard security like OAuth 2, instead, you may have a basic auth with static login and password. Hopefully, that could possibly be solved by adding an API gateway on top of it. But that will never solve permissions/rights issues that will inevitably arise. 

So, system APIs are not what we could call "good" APIs nowadays but at least they exist! They at least allow other systems (you own) to be plugged into the system that exposes them. And no worries if they are complex and not totally secured, that's the job of the next layer to simplify all that.

# Business APIs Layer

Business APIs aim to propose a computerized version of an organization's (either a company's, a business unit's, or a team's) added value skills, knowledge, and expertise. (Maybe I should talk about "subject matter" APIs?)

Note that "business" means the organization's business in a broad sense, hence "what they do". For instance, an insurance company may provide APIs allowing to subscribe to a home insurance contract. On the "opposite" of the spectrum, if the organization's job is providing databases-as-a-service because it's a cloud provider or an infrastructure team, a business API may allow creating databases.

This API layer is the only mandatory one. Those business APIs can be private or public (or partner), consumed inside or outside the organization. They can exist on their own or be built on top of system APIs or other business APIs.

Their main purpose is to expose the "organization stuff for dummies". They require a low level of expertise to be used. They hide as much as possible the internal mess, especially those ugly system APIs, to make them easy to use and reduce coupling with consumers. 

They are totally secured, they especially have to fix possible holes that exist in their underlying system APIs. They can be reused in many different contexts. That's possible because they focus on fulfilling business needs from the outside-of-the-organization-providing-them perspective.  

In an ideal world, as they are secured and easy to use, they can be used by anyone inside or outside of the organization (see Jeff Bezos mandate).

Such vision has a nice side effect on costs of development and time-to-market. It takes a few minutes for anyone inside the organization to use a business API without the need of bothering the provider with thousands of questions (like with system APIs). Pushed to the extreme, a private API can be turned into a profitable (public or partner) product in a matter of minutes.

But even if they are supposed to be highly reusable, sometimes, these business APIs can be not enough when used alone or need to be tweaked for specific needs.

# Experience APIs Layer

Experience APIs are created to adapt and orchestrate business APIs for specific technical or business needs.

The most known examples of experience APIs are BFFs, not Best Friends Forever but Backend For Frontends. Usually, for performance concerns, some mobile application development teams create such BFFs to transform and aggregate API calls and avoid mobile applications triggering multiple calls. It's not uncommon to have GraphQL experience APIs built on top of REST business APIs.

Sometimes such experience APIs do not do that many modifications to their underlying APIs. They just act as a buffer of change, allowing to decouple consumers from business APIs. That could be useful when a modification made on a business APIs must not be reported on consumers outside of the organization. But that possibly leads to an API anti-pattern: not eating your own API dog food.

Experience APIs can also be created for pure business concerns. An organization may want to create a totally new product by aggregating various business APIs. Such experience APIs are supposed to be created quickly. Someone has an idea, boom an experience API is created minutes later to test it. What may have started as a proof of concept must in the end become a new business API in case of success.

Experience APIs must be used with caution when they are not BFFs owned by the consumers. Indeed without care, an organization could end with as many specific variations of its business APIs as it has consumers or partners. That's a nightmare to maintain (talk to that about software vendors who customize their products for their customers).

# The API layer cake

So, as you can see, not all APIs are equals, they're not on the same level. It's critical to understand that existing raw APIs (the system ones) are not to be accessible by many, are too complex and possibly unsecured. Building business-oriented easy-to-use API façades are a good way to put lipstick on the API pig. Those business APIs will provide a cleaner API surface, allowing anyone to build anything on top of them. In last resort, for highly specific needs, you can build experience APIs providing tailor-made features. But don't fall into the one partner/consumer equals one experience API trap.

Here's a recap of the 3 API layers:



| API Layer | Purpose | Public APIs| Private APIs| Security | Usability | Reusability |
|-----------|---------|--------|---------|----------|-----------|-------------|
| System APIs | Technically simplifies access | Never | Reduce at all cost | ⭐️ | ⭐️ | ⭐️ |
| Business APIs | You stuff for dummies | Yes | Yes | ⭐️⭐️⭐️⭐️⭐️ | ⭐️⭐️⭐️⭐️⭐️ | ⭐️⭐️⭐️⭐️⭐️ |
| Experience APIs | Adapt and/or aggregate | No for BFFs, Yes for Products | Yes | ⭐️⭐️⭐️⭐️⭐️ | ⭐️ to ⭐️⭐️⭐️⭐️⭐️ | ⭐️ to ⭐️⭐️⭐️⭐️⭐️ |

In next post, we'll discuss the importance of [organizing APIs around business domains and capabilities, not tools](/organize-apis-around-business-domains-and-capabilities-not-tools/).