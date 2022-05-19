---
#series: When budgets and internal API-First strategy collide
date: 2022-04-20
title: When internal API platform billing model collides with API-First strategy
series: Internal/private APIs and money
series_number: 1
author: Arnaud Lauret
layout: post
permalink: /when-internal-api-platform-billing-model-collides-with-apifirst-strategy/
category: post
---

An internal API-first strategy will inevitably raise budgets questions; you must be aware of that. One of them is who will pay for the brand new API platform and how? The success of an internal API-first strategy may depend on the billing model of the API platform.

<!--more-->

{% include banner-author-link.md %}
{% include _postincludes/internal-private-apis-and-money.md %}
# From API-first to API platform

When an organization (a company, a subsidiary, a government agency, ...) has understood the importance of APIs, at least from an internal perspective, it will engage in its internal API-first journey. So, among other things, everything has been done to build a (minimum viable) API platform that exposes internal APIs (also called private APIs). It could be a centralized or semi-centralized infrastructure.  

For instance, the API platform could be composed of a completely centralized API gateway, API portal/catalog, and CI/CD tools used by everyone to publish their APIs. Another way would be to have a central team preparing and packaging the API gateway, its security policies (pieces of code running on the gateway), and CI/CD plugins. It's up to sub-organizations to spin up this package that will magically push all APIs to a centralized API portal.

But, whatever the model used, an API platform means paying for people and infrastructure to maintain and host it. Who will pay for all that, and how? 

# Who will pay for the platform?

Just like they probably already pay for some other mutualized infrastructure, it seems obvious to make the sub-organizations that will expose their APIs on the platform pay. 

But in the beginning, it may be a bit too much for the one or two first users to support the whole cost. Everyone could be reluctant to actually use the platform facing its cost, and so reluctant to start their API-first journey. If the organization itself or the "central API team" can put some dedicated budget to reduce the (visible) cost for first-timers and ease the platform adoption, that's for the best (even if we all know that in the end it will probably be billed to sub-organizations one way or another because central support team usually do not generate revenue directly).

If it's a significant investment at the whole company level, sub-organizations not (yet) working on APIs may give a hand. That may be a hard pill to swallow, but that may motivate some sub-organizations to actually start their API-first journey.

Deciding who will pay is not that easy, but deciding how they will pay is even trickier.

# What's the platform's billing model?

A terrible idea would be to charge based on the number of APIs exposed on the platform. What will happen in that case?

Providers may merge small and well-defined APIs into big ball of mud APIs. Making them harder to understand and harder to use for consumers, and so it may slow their adoption and augment the cost to integrate them. It also has impact on API providers, they will lose time providing support (instead of creating new APIs or adding new features). Bigger APIs are also harder to manage for their providers (Who will own that big API? How harder will it be to make it evolve).

If the platform's pricing model has an impact on the design of APIs, that's the wrong model. It will inevitably cripple the API-First initiative.

Also, such behavior may be an indicator of "we don't completely get what means being API-First" for both people defining such billing model and people taking the decision to merge APIs to reduce costs.

And last but not least, this model is totally irrelevant because the number of APIs does not define the actual usage of an API platform and may lead to totally unfair bills. A small sub-organization may have to expose many APIs that won't be used much, a bigger one may expose a single API heavily used. That leads to charging more for the one using the platform the less and probably having the less budget. 

Instead, the number of APIs calls (that can relate to CPU/RAM/infrastructure usage) could be a fairer way of charging for platform use. But again, some may be tempted to aggregate smaller operations into bigger ones. Also it's not adapted to all types of API (GraphQL for instance). And some small, usually support function related, sub-organization without much budget may expose some heavily used APIs. So the organization will have to find a way to help them maybe providing dedicated budget (more about that in a later post). 

A fair API platform billing model could set aside API metrics and use a ratio based on actual IT budgets or generated revenue to divide the costs. That way every sub-organization can contribute according to their means. And most important, anyone can have access to the platform and so contribute to the success of the API-First initiative.

# Finding a balance

The actual answers to who pays the bill and how will vary depending on the organization. What is sure is that the API platform billing model has a direct impact on an internal API-First strategy. Whoever pays, whatever the pricing model, the platform will have to bring valuable features to help sub-organization in their API-first journey. And it must do that using an adapted billing model that keeps the platform accessible for anyone and that does not impact API design (and so their quality). Without that in mind, the billing model may kill or cripple the organization's internal API-First initiative