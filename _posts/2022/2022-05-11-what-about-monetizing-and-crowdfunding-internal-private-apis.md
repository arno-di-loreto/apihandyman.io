---
title: Why monetizing and crowdfunding internal/private APIs?
date: 2022-05-11
series: Internal/private APIs and money
series_number: 3
author: Arnaud Lauret
layout: post
permalink: /why-monetizing-and-crowdfunding-internal-private-apis/
category: post
---

Jumping into the API-first train, even only focusing on private/internal APIs, will have an impact on budgets. Organizations need to find ways to redistribute budgets in order to enable any team that needs to provide APIs to do it in the best possible conditions. Is monetizing private/internal API the solution? Would crowdfunding private make sense?
<!--more-->

{% include banner-author-link.md %}
{% include _postincludes/internal-private-apis-and-money.md %}

# What a private/internal API is

In the API world, there are 2 types of APIs. The ones an organization provides to the outside world and the ones that are only used by the organization itself.

When providing APIs to the outside world, APIs are "public APIs" if anyone can use them in a self-service fashion and "partner APIs" if their access is restricted to selected partners or customers.

All other APIs that are only used by the organization which has created them are called "private APIs" or "internal APIs". While it's obvious an API exposed and consumed inside the organization's infrastructure is private, know that an API such as a mobile backend for frontend API exposed on the internet is also private ... as long as it is consumed only by the organization itself.

Note that according to Jeff Bezos' mandate, a private API should be able to become a partner or a public one instantly.

# Private APIs may affect the budget balance

Jumping into the API-first train, even only focusing on private APIs, has many benefits like a better architecture and faster time to market. But it has also more concerning consequences, especially on the budget balance. Indeed as we have seen in the two previous posts of this series, an organization may need to build an API platform, and some teams without much IT may raise their investments in that domain. In the end, the global balance of investing in private APIs will be positive, but money may have to move from one pocket to another.

While budgeting a central API platform may more or less easily pass in the "business as usual shared by all business lines/teams" budget, the teams without much IT desperately need to see their budget increased, especially if they are support teams that do not generate value directly. If they don't get more money, they won't be able to build and provide APIs. The same goes for teams with a more comfortable budget, having their APIs used more means they will need more infrastructure-horse-power and so more money. 

As we are talking about API and the need for money: why not explore the monetization solution?

# What monetizing an API means

Monetizing an API means generating value from its consumption. It often means charging for its use. The most common business model is charging consumers based on the number of API calls they do.

But a monetized API can generate indirect revenue. For instance, a bank will provide access to its "Loan subscription API" to anyone because it will bring new customers and so generate revenue. Consumers make money in the process, they are usually paid for the new customer they bring.

While public or partner API monetization is a no-brainer, monetizing private APIs is quite uncommon. To be precise, we're not talking about taking a private API and making it public, but keeping it private and making other teams inside the organization pay to use it.

# Monetizing private APIs

From the private API provider's perspective, making other teams pay to use their APIs could be interesting to pay for API enhancements, infrastructure maintenance, and scalable infrastructure for instance.

From the consumers' perspective, that's another story. They must understand the value they get from paying to use other teams' APIs. But it's not that complicated to find arguments. For instance, getting real-time data over HTTP is far more interesting than retrieving files over FTP daily (which means data storage and rebuilding an API on top of that; imagine 10 teams doing the same thing). It could also mean no more need to do some error-prone data processing on their side, which means safer business processes and probably less money spent fixing the faulty ones. All that being usually synonym of a faster time-to-market (time-to-delivery). 

But if providers have no money in the first place, they won't be able to build APIs at all.

# Crowdfunding to kickstart private APIs

Indeed, API monetization brings money only once the APIs are consumed. Teams with not much IT budgets will need an initial investment to get started. As their API will probably benefit many inside the organization, why not ask them to participate in that initial investment. Joining budgets (and forces) will definitely help less-IT teams jump into the API-first train.

So, as a future API product owner, you should analyze how others interact with your team to detect the use cases where putting API in place will benefit you and other teams. More often than not, you already know them as they are probably already listed in some "pain points" list. Then contact the other teams to start the API conversation, you may be surprised by the results.

# Invest for the greater good

Will internal/private API monetization and crowdfunding succeed? That depends on the practice and relationships in your organization, but these are options that should be investigated. What is sure is that the organization as a whole will have to invest wisely to ensure the success of its private/internal API-first strategy. The return on investment will be huge, so don't be afraid, at any level, to invest for the greater good in private/internal APIs.