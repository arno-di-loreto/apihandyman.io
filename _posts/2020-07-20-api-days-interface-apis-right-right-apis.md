---
title: Doing APIs right and doing right APIs
date: 2020-07-20
author: Arnaud Lauret
layout: post
category: post
permalink: /apidays-interface-doing-apis-right-and-doing-right-apis/
category: post
series: API Days Interface 2020
series_title: Doing APIs right and doing right APIs
series_number: 2
---

I've attended and spoke at API Days Interface online conference on June 20, July 1 & 2, 2020. Being online made the experience a bit different but after almost 3 days, I felt almost as usual; exhausted and my brain boiling with all what I've heard and seen. In my previous post, I shared my feelings about my first online conference. Now let's talk about the content, I "came back" with a few thoughts on design, governance and architecture and also with a new buzzword ("indieservice") and a new buzzquote ("doing APIs right and doing right APIs"). <!--more-->

{% include _postincludes/api-days-interface-2020.md %}

# Design

## Envisioning API design

- [Mike Amundsen, Author of "Designing and Building Web APIs" and "Restful API Design", Building great web APIs](https://interface.virtualconference.com/#/conference/5f087fcd4b0835001b00cc52)
- [Alianna Inzana, Senior Director, Product Management @SmartBear, /Contract/{Collaboration}/DrivenDevelopment](https://interface.virtualconference.com/#/conference/5f0bde6f86dfb0001b75dfb9)

## OpenAPI Specification 3.1

[Darrell Miller, Board Member of Open API Initiative, The State of Open API Specification](https://interface.virtualconference.com/#/conference/5f0c0b5e86dfb0001b75dfe9)

# Governance

- [Alan Glickenhouse, API Strategist @IBM, Recommendations for API Governance and an API Economy Center of Excellence](https://interface.virtualconference.com/#/conference/5f09bc4b8c46ce001bff21a6)
- [Phil Sturgeon, Architect @Stoplight, Automating style guides for REST, gRPC, or GraphQL](https://interface.virtualconference.com/#/conference/5f0c32ba86dfb0001b75e013)
- [Matthew Reinbold, Director, Platform Services Center of Excellence @Capital One, APIs are Arrangements of Power. Now what?](https://interface.virtualconference.com/#/conference/5f096a054b0835001b00cd16)
- [Erik Wilde, Co-Author of "Continuous API Management", How to Guide your API Program and Platform](https://interface.virtualconference.com/#/conference/5f0972664b0835001b00cd1c)
- [John Phenix, Chief API Architect @HSBC, Automating API Governance](https://interface.virtualconference.com/#/conference/5f09b44c8c46ce001bff21a0)
- [Arnaud Lauret, Author of "The Design of Web APIs", The Augmented API Design Reviewer](https://interface.virtualconference.com/#/conference/5f091a6c4b0835001b00cca7)

## Review automation

## People

# Architecture

[Mary Poppendieck]:https://interface.virtualconference.com/#/conference/5f07f7db516de3001b3b6462 "Where do great architecture come from"
[Sam Newman]:https://interface.virtualconference.com/#/conference/5f0bb86686dfb0001b75df89 "Microservices, APIs, and the Cost Of Change"
[Mark Cheshire]:https://interface.virtualconference.com/#/conference/5f0c005886dfb0001b75dfdd "When to manage Microservices as a Mesh or as APIs?"
[Ronnie Mitra]:https://interface.virtualconference.com/#/conference/5f0bef8086dfb0001b75dfc5 "The Next API Strategy: Going Borderless"

| Speaker | Session |
|---------|---------|
|Mary Poppendieck, _Author of "Lean Software Development: An Agile Toolkit_| [Where do great architecture come from][Mary Poppendieck]
|Sam Newman, _Author of "Building Microservices and Monolith to Microservices"_|[Microservices, APIs, and the Cost Of Change][Sam Newman]
|Mark Cheshire, _Director Product Management for API Management @Red Hat_|[When to manage Microservices as a Mesh or as APIs?][Mark Cheshire]
|Ronnie Mitra, _Author of "Microservice Architecture"_|[The Next API Strategy: Going Borderless][Ronnie Mitra]

## History

## Microservice vs API

Sam Newman gave a definition of a microservice and how it relates to API; this is important to remind because the "microservice" name tend to be used for things that are actually not "microservices" and also because APIs and microservices are too often confused:

- A microservice is independently deployable
- A microservice runs as a separate process
- A microservice's data are hidden inside its boudaries
- A microservice can be called via some form of network call: for example via an API which becomes a mean to hide internal implementation.

So the microservice is not an API and reverse. The API is only an interface to a microservice.
Also, if your "microservices" share a database with others or are wars or ears running inside a Jboss server for example, those are not microservices.

## ~~Versioning~~ Handling changes

Sam Newman gave a deep dive into versioning during his [session][Sam Newman]. He especially explained that versioning is not the real problem. It's not about version 1 and version 2. The real problem is how to handle change, how to handle backward compatibility and incompatibility. And this is even more true when doing microservices which are supposed to be independently deployable: maintaining backward compabitibility is key.

He gave 4 concrete tips to do so.

_I have to admit that I was quite proud of myself because I realized that I always say what he told us during my API Design reviews!_

### Tip #1: Hiding information is key.

If an upstream consumer can reach into your internal implementation then you can't change the implementation without breaking the consumer. Consumer and provided are tightly coupled, making any change risky and even impossible.

{% include image.html source="sam-newman-01-coupling-to-internal-implementation.jpg" caption="Copyright Sam Newman" %}

Modularization is not a new concept that appeared with APIs and microservices. In 1971, D.L. Parnas published _[On the criteria to be used tin decomposing systems into modules](https://kilthub.cmu.edu/articles/journal_contribution/On_the_criteria_to_be_used_in_decomposing_systems_into_modules/6607958)_. He looked at how best to define module boundaries and found that "information hiding" worked best.

Your interface (API) shows what is shared, the rest data and implementation details is your own business. That's why it is really important do have separate models for data, objects and exposed interfaces (as also always say Mike Admundsen).

{% include image.html source="sam-newman-02-information-hiding.jpg" caption="Copyright Sam Newman" %}

If the whole becomes to big, you can split your internal implementation in various sub modules, while keeping the shared interface unique and unmodified. But be warned that only works if the whole set of microservices/modules is handled by the same team.

{% include image.html source="sam-newman-03-multiple-microservices.jpg" caption="Copyright Sam Newman" %}

### Tip #2: Cost of change varies

Not all changes have the same cost. Some changes have critical consequences and some others have very limited impacts.

A modification inside a team, on the set of microservices of the Accounts domain above for example has a very low cost because it only has internal impacts. If the change, like a modification of the shared interface, impacts an other team inside the company the cost is higher. If this shared interface is used by multiple teams inside the company, the cost increases again. And lastly, if this change impacts people outside the company, the cost is even more high.

That means the cost of change increases with the "distance" between the provided and consumer (inside the team, inside the company, outside the company) and the number of consumers. 

{% include image.html source="sam-newman-04-cost-of-change.jpg" caption="Copyright Sam Newman" %}

The cost of change leads to different ways of taking the decision to actually do this change or not. According to Jeff Bezos, Amazon's CEO, there are 2 types of decisions. Type 1 are irreversible decisions, it's impossible to go back, you have to think carefully before taking them. On the opposite type 2 ones are reversible, they don't cost 0 but you can change your mind very easily and you take no risk doing them.

If the change has impacts only inside a team, that's a reversible decision make can be taken locally inside the team. On the opposite, a decision impacting a public facing API provided to people outside the company is an irreversible decision which requires more discussion and a formal approval.Getting the balance right regarding those decisions is key to having an organization that thrives from team autonomy.

### Tip #3: Catch accidental breakages

Even when having found the right balance for decision making, people can still do mistakes like replacing a property by another in an API response (that's actually removing the original property). Such modification breaks the consumers.

That's why it is important to have separate models (as already said in tip #1). Doing such modification requires more work and requires explicit changes that requires you to think about it and so you'll notice it.

But you can't rely only on people actually noticing that, you need testing. And to do tests, you need schema (JSON schema, Protobuf, OpenAPI, ...) to actually check the difference between old and new version (that's also why design first is important).

### Tip #4: Expose multiple endpoints

Once you know you are doing a change impacting others, avoid lock step release. Requireing coordination between consumer and provider is the enemy, the anti-thesis of independen deployability. That means, you must give to to consumer to upgrade/

To do so you can expose multiple separates ervice versions. But there are a few challenges doing so:

- Service discovery
- Doubling infrastructure costs money
- Keeping data consistency between the 2 versions can be hard
- And also bug fixing can be bothering

To solve that you can expose 2 endpoints, one for each version inside the same component. That way, you shift from complex infrastructure issue to a more simpler design/implementation issue.

Switching from one version to another can be as simple as using path, the accept header or a domain.

## ~~Microservices~~ Indieservices

During Q&A, Mehdi Medjaoui asked Newman how he felt about miniservices, macroservices, nanoservices and other {whatever size}services. His reaction made me burst out laughing ([jump at 31:45][Sam Newman] to see it), he looked totally desperate and did a long facepalm.

{% include image.html source="facepalm.gif" alt="Jean Luc Picard doing a facepalm" caption="Sam Newman's reaction (reenactment by Jean-Luc Picard)" %}

More seriously, he stated that the name microservice which imply "size" is actually a problem. He want to go back in time and choose another name focusing on the real important aspect: independent deployability.

Medjaoui proposed indieservices and after 2 second Newman said that would be probably better than microservices.

## Boundaries

[The Next API Strategy: Going Borderless][Ronnie Mitra] by Ronnie Mitra and [Choosing between API gateway and service mesh][Mark Cheshire] by Mark Cheshire sessions gave really good insights about how to define and manage the internal and external boundaries or your system and they resonate with what Sam Newman said about microservices.

### Boundaries as a provider

Mark Cheshire said that at first making the decision between API Management and Service Mesh looks quite simple.

API Management is used for North-South traffic. North being outside the organization and south being inside. With API Management, there's an API Gateway (a proxy) that sits between the provider and its consumers. Consumers can access to APIs exposed on that gateway by registering to a developer portal. Those APIs are considered as products.

Service Mesh is used for East-West traffic, both sides being inside the organization. Service mesh comes as a side car proxy on microservices which handles the communication with other microservices (dealing with discovery, logs/observability, retry, ...).

So it looks like the decision should be made on does the communication take place inside or outide my company. But that's not the case. A company/organization can be split in various domains (however you call them). And these domain boundaries must be treated the same way as enterprise boundary (API Management). Inside the domains you may use service meshes.

{% include image.html source="mark-cheshire-03-domain-boundaries.jpg" caption="Copyright Mark Cheshire/Redhat" %}

What distingues inter and intra-domain traficc is the relation between provider and consumers. Are they in the same team? How many consumers? Explicit contract needed?

{% include image.html source="mark-cheshire-04-inter-vs-intra-domain-traffic.jpg" caption="Copyright Mark Cheshire/Redhat" %}

### Boundaries as a consumer

Ronnie Mitra explained that a system is usually complex and difficult to understand and use. Hiding complexity of microservices, APIs, data and third party providers will ease the use of this complex system.

You can't change someone else's API (_I add: you can't change someone else's API even if they are in the same company as yours, but that's another story I'll tell another day_). In order to avoid building a brittle and tightly couple relation with API providers, you must proxy others APIs with a sub-domain having its own (anti-corruption) model. Reminder: That's basically what you would do for your own API, separating data/object/API model as sais Sam Newman and Mike Amundsen.

Capabilities don't interoperate. You may need to build an layer of orchestration to weave microservices capabilities together. There's a big centralization/decentralization trade-off decision to do here.

Data is all over the place (_especially when splitted across dozens if not hundreds of microservices_). Data need to be collected and catalgues to be useful.

So many APIs and so many components lead to a system that is difficult to understand and manage. You need to build access and management components that represent this system as a monolith.

{% include image.html source="ronnie-mitra-05-borderless.jpg" caption="Copyright Ronnie Mitra" %}

By building all these layers, creating new boundaries, you can create a system so simple that it looks totally borderless.

# Sessions attended

- [Mary Poppendieck, Author of "Lean Software Development: An Agile Toolkit" Where do great architecture come from](https://interface.virtualconference.com/#/conference/5f07f7db516de3001b3b6462)
- [Sam Newman, Author of "Building Microservices and Monolith to Microservices", Microservices, APIs, and the Cost Of Change](https://interface.virtualconference.com/#/conference/5f0bb86686dfb0001b75df89)
- [Mark Cheshire, Director Product Management for API Management @Red Hat, When to manage Microservices as a Mesh or as APIs?](https://interface.virtualconference.com/#/conference/5f0c005886dfb0001b75dfdd)
- [Ronnie Mitra, Author of "Microservice Architecture", The Next API Strategy: Going Borderless](https://interface.virtualconference.com/#/conference/5f0bef8086dfb0001b75dfc5)
- [Alan Glickenhouse, API Strategist @IBM, Recommendations for API Governance and an API Economy Center of Excellence](https://interface.virtualconference.com/#/conference/5f09bc4b8c46ce001bff21a6)
- [Phil Sturgeon, Architect @Stoplight, Automating style guides for REST, gRPC, or GraphQL](https://interface.virtualconference.com/#/conference/5f0c32ba86dfb0001b75e013)
- [Matthew Reinbold, Director, Platform Services Center of Excellence @Capital One, APIs are Arrangements of Power. Now what?](https://interface.virtualconference.com/#/conference/5f096a054b0835001b00cd16)
- [Erik Wilde, Co-Author of "Continuous API Management", How to Guide your API Program and Platform](https://interface.virtualconference.com/#/conference/5f0972664b0835001b00cd1c)
- [John Phenix, Chief API Architect @HSBC, Automating API Governance](https://interface.virtualconference.com/#/conference/5f09b44c8c46ce001bff21a0)
- [Arnaud Lauret, Author of "The Design of Web APIs", The Augmented API Design Reviewer](https://interface.virtualconference.com/#/conference/5f091a6c4b0835001b00cca7)
- [Mike Amundsen, Author of "Designing and Building Web APIs" and "Restful API Design", Building great web APIs](https://interface.virtualconference.com/#/conference/5f087fcd4b0835001b00cc52)
- [Alianna Inzana, Senior Director, Product Management @SmartBear, /Contract/{Collaboration}/DrivenDevelopment](https://interface.virtualconference.com/#/conference/5f0bde6f86dfb0001b75dfb9)
[Darrell Miller, Board Member of Open API Initiative, The State of Open API Specification](https://interface.virtualconference.com/#/conference/5f0c0b5e86dfb0001b75dfe9)


# Doing APIs right and doing right APIs

