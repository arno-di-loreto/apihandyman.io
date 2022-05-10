---
title: When internal API development and hosting costs collide with API-First strategy
series: Internal/private APIs and money
series_number: 2
date: 2022-04-27
author: Arnaud Lauret
layout: post
permalink: /when-internal-api-development-and-hosting-costs-collide-with-apifirst-strategy/
category: post
---

An often unintended consequence of an internal API-first strategy is having teams with not much IT jumping, willingly or not, in the API train. That inevitably will raise budget questions which answers will determine the success of the API-first strategy.

<!--more-->

# Jumping into the API train

When engaging on the API-first journey, they are often parts (business lines, departments, teams, ...) of the organizations that are left behind. The focus is often put on the parts that directly create value. The ones that could take advantage of APIs to provide new services to direct customers or the ones that will possibly provide APIs to the outside world. But (big) organizations often rely on more or less hidden support teams to operate. Those support functions could be HR, the risk department (if you're a bank), or some teams managing central data repositories.

Depending on their nature and relationships with other parts of the organization, they will more or less willingly jump into the API train. The HR department may need to choose better software solutions that provide APIs and hide them behind API façades though they never do developments. The risk department which was providing data through database extractions could be overwhelmed with "please create an API providing risk processing services" requests. The central data repositories department which was also relying on data extraction may want to create many APIs rapidly to enhance their services by providing real-time data.

# Less IT, harder API

Jumping into the API train means new developments and new infrastructures to host the APIs. Depending on the size of your IT, it may be more or less complicated. That may not be a big problem for the ultra-hyper-visible-making-much-money departments, but for those support departments, APIs have a huge impact on how they operate their small IT. The API train ticket may be too high for them.

The capacity to deliver new developments depends on many factors but one important one is how many people you can allocate to work on something. And often those support departments don't have many people working on IT. So they may have to rob Peter to pay Paul and choose between some existing initiative and the new API one. 

More than the number of people, there are also skills to take care of. Indeed sometimes such departments never have built APIs or even web applications. Train them will take time, and so money. In the beginning, delivering APIs will take a longer time, and so much money. Hiring new developers even temporarily will cost money.

And even if development capacities and skills are there, the support departments often have a limited budget for their infrastructure. Why? Because they didn't need much infrastructure before APIs came to change everything. Hosting a simple new application (an API in that case) may be a huge problem.

# How to help them?

Engaging in becoming API-first, even at an internal level, may lead to a huge transformation. Some departments which were not "very IT", will more or less forcibly need to invest more in IT. That requires the whole organization to help them. Here are a few ideas:

- If the public-facing API-first initiative generates new revenue it may be used to increase the budget of the hidden support departments. 
- Providing a ready-to-use API platform for free or very low cost (see [When internal API platform billing model collides with API-First strategy](https://apihandyman.io/when-internal-api-platform-billing-model-collides-with-apifirst-strategy/)) will help them not raise too much their infrastructure costs.
- Providing temporary development support (provided by the "central API team") for free could help deliver the awaited APIs faster. It could also them grow their API skills in the making. But that should only be done if the department keeps control of what is built and if what is built is done like they're used to.

There is another option that could be used, but I keep it for another post.

# No money, no API

What is sure is that if those small-budget departments are not helped with their development and infrastructure, they will probably continue operating like before without APIs or take an awfully long time to deliver much-awaited APIs. Some other departments with more budget may decide to build APIs they are not supposed to build because of that (that's a terrible idea, read [Don't organize APIs against ownership](https://apihandyman.io/dont-organize-apis-against-ownership/)). All that may hinder the success of the organization's API-first initiative.