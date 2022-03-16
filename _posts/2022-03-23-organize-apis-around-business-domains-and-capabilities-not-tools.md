---
series: 3 dimensions to consider for a successful API-First strategy
series_title: Organize APIs around business domains and capabilities, not tools
series_number: 2
date: 2022-03-23
author: Arnaud Lauret
layout: post
permalink: /organize-apis-around-business-domains-and-capabilities-not-tools/
category: post
---

People don't want drills, they want to make holes. APIs are interfaces exposed by pieces of software, our modern tools. But it would be a terrible idea to think of APIs just as interfaces to tools. APIs must be organized around our business domains and capabilities.
This post is the second of the “3 dimensions to consider for a successful API-First strategy” series.

<!--more-->

_Post banner [photo](https://images.unsplash.com/photo-1426927308491-6380b6a9936f?ixid=MnwxMjUwMnwwfDF8c2VhcmNofDIzfHxvcmdhbml6YXRpb258ZW58MHx8fHwxNjQ3MDA2Mjc1&ixlib=rb-1.2.1?ixlib=rb-0.3.5&fm=jpg&crop=entropy&cs=tinysrgb&fit=max&w=800&q=70) by [Barn Images](https://unsplash.com/@barnimages?utm_source=milanote&utm_medium=referral&utm_campaign=api-credit)._

{% include _postincludes/3-dimensions.md %}

In this second post, we'll talk about organizing APIs around business domains and capabilities and not tools. This perspective is critical in order to build APIs that will be easy-to-understand, easy-to-use, easy-to-evolve, and limit coupling.

{% include image.html source="organize-around-business-not-tools.png" %}

# Wrong organization around tools

APIs are Application Programming Interfaces, they allow pieces of software to interact with each other. They allow tools to talk to each other, great! But let's be honest, people don't want to use your tools. And you don't want to give them access to your tools. Both of you'll regret it. What terrible things will irremediably happen when giving access to API "A" that brutally maps tool "A"? 

People may have a hard time grasping what they can do with this "A" API just because its name does not mean anything. Choosing the right name for an API is far more important than you may think, especially for internal APIs. You should Read my [Pink Fluffy Unicorn API? WTF? (or 3 reasons why choosing a not meaningful API name can be a problem)](/pink-fluffy-unicorn-api-wtf-or-3-reasons-why-choosing-a-not-meaningful-API-name-can-be-a-problem/) to discover more about this topic.

Even if you give a meaningful name to the API of Tool A, you'll still have problems. Indeed, API giving direct access to tools does not usually provide a user-friendly interface. They can be quite cryptic and usually requires a high level of expertise. Most of the time they're made to make the tool work, not let people fulfill their needs. People can also be overwhelmed by the amount of function available. 

As people have hard times using them, they will lose time. You'll also lose time too accompanying them, answering all of their questions. It costs a lot of time and so a lot of money to use them. If people have the choice they will probably not use them.

And if people use such "Tool API" that increases the coupling between systems, because they require a high level of expertise. What will happen when the vendor tool evolves? Everyone using it will be impacted, it will be a total nightmare to coordinate everyone. 

If you read the previous post in this series, that should sound familiar: the API of a tool is usually a terrible system API and must be hidden at all costs, only used by a handful of trusted and expert consumers.

# Business domain driven design

To fulfill what it's supposed to do, an organization takes advantage of various capabilities offered by its business domains. For a company selling products, the apparent business domains are doing the company "stuff" such as sales or R&D., and there are also less obvious support business domains like HR or accounting. Each domain will rely on people and their tools to function.

A business domain may expose one or more APIs, depending on the domain's composition. As this matter is often related to microservices, know that size does not matter when deciding if you should put all capabilities of a domain inside a single or many APIs. What matters is that each API is a meaningful and independent set of operations. Meaningful because it offers capabilities that make sense together and are helpful to the "outside world" outside the domain. Independent because the API can be used without any other one. That does not forbid using an API in conjunction with others, but if that's always necessary, there's probably something wrong with how the domains are organized or split.

A business API may rely on more than one tool's system APIs. That's pretty convenient to hide you have two different software solutions to do the same thing. Such architecture often happens with fusion and acquisition. It can also come from organizational constraints. Two separate teams doing the same tasks but targeting different regions or customers may use various tools (because of actual regulation constraints or lack of tooling governance).

A business domain is under no obligation to expose all of its capabilities (and so its APIs). There are tools that people from the outside will never see; that's absolutely fine. A business domain is also under no obligation to expose its capabilities precisely as they work inside. The less a domain shows what is happening in its black box, the better; it reduces coupling between systems.

A business domain may rely on other domains, but a bi-directional relationship is usually problematic, especially when it concerns a specific business process. That usually leads to less reusable APIs.

Taking advantage of methods such as [domain-driven design](https://en.wikipedia.org/wiki/Domain-driven_design) or [event storming](https://en.wikipedia.org/wiki/Event_storming) can be helpful to figure out how to divide an organization or a domain.

# Whatever the layer, APIs belong to a domain

This second organizational perspective (the first one being the API layers), shows that system APIs and business APIs both belong to business domains. Is that also the case of experience APIs? Yes, experience APIs can belong to a consumer-oriented or provider-oriented business domain.
A backend-for-frontend (BFF) built by a mobile application team belongs to this team's domain (a "consumer domain"). A tailor-made product experience API may belong to its underlying domain or to an entirely independent one.
So all types of APIs belong to a business domain, the only visible ones being business and experience APIs.

{% include image.html source="all-apis-belong-to-a-domain.png" %}

In the next post, we'll talk about the third and probably most important dimension of API organization: Ownership.