---
date: 2021-04-23
author: Arnaud Lauret
layout: post
category: post
permalink: /reading-thoughtworks-technology-radar-24-from-an-api-perspective-and-nearly-falling-off-my-chair/
title: Reading Thoughtworks Technology Radar 24 from an API perspective (and nearly falling off my chair)
tags:
    - Thoughtworks Technolohy Radar
---

Thoughtworks Technology Radar 24, an opinionated guide to technology frontiers, came out last 15th of April, 2021 and I thought it could be interesting to read it from an API perspective, hence this post sharing my thoughts on it.
As always it is really interesting and full of valuable insights, though I nearly fell off my chair while reading the Tools section (if it's not a click bait, I don't know what it is).
<!--more-->

# What is Thoughtworks Technology Radar

Thoughtworks is a quite famous software consultancy company, brilliant minds such as [Martin Fowler](https://martinfowler.com/) are working there.
Every 6 months, they publish their Technology Radar:

> The Radar is a document that sets out the changes that we think are currently interesting in software development - things in motion that we think you should pay attention to and consider using in your projects. It reflects the idiosyncratic opinion of a bunch of senior technologists and is based on our day-to-day work and experiences. While we think this is interesting, it shouldn’t be taken as a deep market analysis.

Links:
- [Radar FAQ](https://www.thoughtworks.com/radar/faq)
- [Latest Thoughtworks Technology Radar](https://www.thoughtworks.com/radar)
- [Thoughtworks Technology Radar Volume 24 (PDF version)](https://assets.thoughtworks.com/assets/technology-radar-vol-24-en.pdf)

While authors claim it's not a deep market analysis, it's still full of highly valuable insights that you, as a developer, architect, CTO or whatever is your title should have in mind for your next tech related decisions or simply to discover new tools, language, trends, ...

In what follows, I picked up a few topics of the 24th edition of this radar that raise my interest from an API perspective (and if you can't wait to know why I nearly fell off my chair, you can jump to the [penultimate section](#lint-your-openapi-contracts-and-why-i-nearly-fell-off-my-chair)).

# Reminder, there are no silver bullets in architecture

The [Discerning the Context for Architectural Coupling](https://www.thoughtworks.com/radar#discerning-the-context-for-architectural-coupling) theme is a gentle reminder of what I called "design in context".
Never choose a solution just because this is "the" solution, because depending on the context it could be totally wrong.
That works for anything in general and in the API architecture world, that works for instance for "BFF or not" and "REST ot GraphQL or gRPC".

# Smoothly evolve your APIs 

The radar authors strongly think that people should be adopting the [1. API expand-contract](https://www.thoughtworks.com/radar/techniques/api-expand-contract) technique (also called [parallel change](https://www.martinfowler.com/bliki/ParallelChange.html)).
The API expand pattern allows to introduce a breaking in 3 steps:

- Add element
- Deprecate what added element replace
- Remove once consumers have switched 

While it's a totally valid technique, the last step can be tricky if there are many consumers or if there are far from you.
You should read what [Sam Newman said about the cost of change at API Days Interface 2020](/apidays-interface-doing-apis-right-and-doing-right-apis/#versioning-handling-changes).
In my humble opinion, working seriously on design and thinking about how your API may evolve will help you avoid having to use this technique.

I will not say more for now, writing one or more posts about API change and versioning is on my to-do list.

# Share between UI and BFF when owning both

The radar states that the use of [16. UI/BFF shared types](https://www.thoughtworks.com/radar/techniques/ui-bff-shared-types) is increasing and that companies should try this technique on a project that can handle the risk (trial).
That looks like a very good idea as long as both UI and BFF belong to the same team.
So don't ever think about using this technique between UI and regular API, you should be decoupled as much as you can from elements you don't own.

# Compute encrypted data to preserve privacy

The first time I heard about the [20. Homomorphic encryption]() ([technique section]()) was in 2016 at an API conference: The Česká spořitelna bank was using it experimentally to share data with third party.
The idea is that using this technique, the encrypted data are still computable.
You can send them to an untrusted third party who will do some calculation with them and return you the results that you will decrypt.
According to the radar, it became fairly easy to use it.
But while having this technique in mind since 2016 and working in the financial industry, I'm still longing to work an API that will allow me to use it.

# Unleash the power of APIs (while it's possible)

If you want to build an event-driven architecture, you should take a look at [Apache Kafka](http://kafka.apache.org/).
While being a widely adopted distributed event streaming platform, actually managing it does not seem quite simple.
That's why some companies launch their Kafka as a service offers, they run it, you use it.
But as stated in the radar, some companies have gone a little farther and started to offer "Kafka without Kafka".
How is this possible?
Only thanks to APIs.

APIs (whatever their nature, web, messaging or whatever) offer amazing possibilities when it comes to replace the engine behind the interface.
Thanks to these [45. Kafka API without Kafka](https://www.thoughtworks.com/radar/platforms/kafka-api-without-kafka) describes in the [Platforms](https://www.thoughtworks.com/radar/platforms) section, you use a service that looks like Kafka but that is actually not.
It allows companies to provide their technology similar to kafka to people who are used to it without any modification.
From my perspective, the main to understand point here is not about Kafka (though it is actually interesting) but how anyone can provide a service compatible with an existing solution.
What is needed is to simply offer the same interface.
And, for now, that's still "possible but check your lawyers are ready" thanks to the recent legal decision in the [Google vs Oracle API Copyright case](https://apievangelist.com/2021/04/13/My-oracle-vs-google-api-copyright-journey/).

Beware that [Kafka API without Kafka](https://www.thoughtworks.com/radar/platforms/kafka-api-without-kafka) is in "Assess", it's worth exploring to understand how it could affect you.
Note also that such solutions may not be fully compatible all Kafka features

# Let's give a try to Fast API Python framework

I work with data scientists to help them build APIs and they obviously use Python.
So, discovering in the [Languages & Frameworks](https://www.thoughtworks.com/radar/languages-and-frameworks) section of the radar, a new Python web API framework such [Fast API](https://fastapi.tiangolo.com/) having Thoughtworks seal of approval ([86. FastAPI](https://www.thoughtworks.com/radar/languages-and-frameworks/fastapi)), made my day.
Beware, Fast API is still on "Trial" for Thoughtworks, that means "Enterprises should try this technology on a project that can handle the risk".
As I'm starting to work with Python for a complete overhaul of the API Stylebook, a personal project that perfectly can handle such risk, I may give it a try.

# Lint your OpenAPI contracts (and why I nearly fell off my chair)

And last but not least, the radar mentions 2 OpenAPI linters in the [tools](https://www.thoughtworks.com/radar/tools) section:

- [77. Spectral](https://www.thoughtworks.com/radar/tools/spectral)
- [79. Zally](https://www.thoughtworks.com/radar/tools/zally)

The OpenAPI Specification (fka. the Swagger Specification) is a format allowing you to describe a web API contract.
An OpenAPI linter will help you to ensure that the design of an API conforms to your guidelines (or style guide).

I know both of these tools for quite a long time now.
[Zally](https://opensource.zalando.com/zally/) was the first high quality OpenAPI linter I encountered but I find it quite complex to use, there's a cli, a server, a database, you need to use Kotlin to write your rules.
And once I discovered [Spectral](https://github.com/stoplightio/spectral), I totally forgot Zally.

A simple `npm install -g @stoplight/spectral` and you can start.
Writing rules is quite simple, though like any "code", you definitely need to test them.
I use it extensively every day while doing API design reviews, check my [Augmented API Design Reviewer](https://apihandyman.io/the-augmented-api-design-reviewer/) talk to learn more about it.

While being quite happy to see those 2 linter in the radar, there are 2 problems in the radar regarding this topic in my humble opinion.

First, they are in "assess" (worth exploring to see how it will affect you), I definitely think they should be in "adopt" (industry should adopt these items).
Designing API is hard, ensuring consistency is hard and such linters participate in simplifyling designers job and ensure a certain level of consistency in your API surface.
Not that such tools will never, ever replace a human power API design review.

The second problem in the radar is what is said in the Spectral description:

> While this tool is a welcome addition to the API development workflow, it does raise the question of whether a non-executable specification should be so complex as to require an error-checking technique designed for programming languages. Perhaps developers should be writing code instead of specs?

I nearly fell off my chair.

I feel that the authors seem unaware of API design question and to not grasp how you can take advantage of the OpenAPI specification to design your API and how such linter can help you design consistent APIs.
That gives a totally wrong perspectives of OpenAPI and OpenAPI linters in general and Spectral in particular.
I met and still meet many developers who actually are in such state of mind, don't giving a 💩 about API design and everything around (hopefully, I always succeed to change people mind about this topic).
But I find that quite surprising to read such comments in something coming from a company such as Thoughtworks, I would love to know how the authors came to writing this, did I missed something?

Hopefully, I was glad to see the discourse about OpenAPI linters is totally different in the Zally's description and offers the right perspective on the topic.

> As the API specification ecosystem matures, we're seeing more tools built to automate style checks. Zally is a minimalist OpenAPI linter that helps to ensure an API conforms to the team's API style guide. 

Maybe it's due to these particular pandemic times, but it seems that there's a lack of alignment between the 2 authors of these advices. 

# Trust carefully famous companies and people

There's an interesting take-away here, it's not because it's a famous company who do or say something that it is always 100% good (see this [post](/batch-github-api-call-with-csv-and-postman-runner-and-visualizer/) for another example coming from Github).
We all can do mistakes.
So, let me be clear:

- You MUST have an API design first approach
- You MUST write API design guidelines (or style guide) describe the look and feel of your APIs
- You MUST use the OpenAPI (or whatever) specification to describe the result of your work on design
- You MUST use an OpenAPI (or whatever) linter to ensure your APIs conform to your style guides (and Spectral is a very good tool to do that)
- You MUST do an API design review with human beings

(But can you trust me? I'm not that famous)

If you want to learn more about the OpenAPI Specification, API guidelines, API design reviews and Spectral, you should look at my following talks:

- [OpenAPI Trek](https://apihandyman.io/openapi-trek-api-days-london-2016/)
- [The Lord of API Designs](https://apihandyman.io/api-styleguide-the-lord-of-api-designs/)
- [The API Design Reviewer's Starter Set](https://apihandyman.io/api-design-reviewers-starter-set/)
- [The Augmented API Design Reviewer](https://apihandyman.io/the-augmented-api-design-reviewer/)

