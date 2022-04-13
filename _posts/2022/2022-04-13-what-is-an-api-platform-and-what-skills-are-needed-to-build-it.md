---
title: What is an API platform and what skills are needed to build it
date: 2022-04-13
author: Arnaud Lauret
layout: post
permalink: /what-is-an-api-platform-and-what-skills-are-needed-to-build-it/
category: post
---

LEGO is looking for an [associate API Engineer](https://www.lego.com/en-us/careers/job/60676511) for their API platform. LEGO+APIs! That looks awesome! But what is an API platform and what skills do you need to build it? Does the LEGO job offer list them all? Do you have them all? This post answers those questions and may help you apply to such offers or post the appropriate job offers to build your own API platform.
<!--more-->

{% include banner-author-link.md %}

# What is an API platform

An API Platform represents all of the infrastructures and tools a company will put in place in order to allow everyone inside the company to provide APIs easily and securely. It will allow also anyone inside the company and possibly (almost) anyone outside of the company to consume APIs also easily and securely. 

The interest of such a platform (like any other platform) is to avoid reinventing the (API) wheel in every line of business or team. It's an accelerator of API exposition and consumption.

Note that an "API platform" is not a single tool, it is usually composed of many tools that could be in-house ones, open-source ones, commercial ones (SAAS or on-premise). 

Let's see a few domains where an API platform can help to understand what it is.

## API Exposition

An API platform will allow API providers to easily expose their APIs (usually on API gateways) in a place easily accessible by anyone inside the organization (intranet) and possibly anyone outside of it (internet). That means providers have access to tools they can plug into their CI/CD and they must have access to the administration interfaces if needed (if that can be avoided, that would be great). 

## API Security

An API platform ensures a certain level of safety and consistency regarding API security. Indeed, if the platform is well done, API providers won't have to work on Oauth, OpenId Connect, or any other high-level security framework. It could be handled by the API gateway(s) and Identity providers and the team managing them. The platform could also provide a virus scan system for file upload (because sometimes you'll need to get files through your APIs). But whatever the high-level security measures the platform can provide, [this does not absolve API providers to care about security](https://apihandyman.io/an-api-gateway-alone-will-not-secure-your-api/). 

## API Consumption

An API platform should make consumers' life easier. Requesting access to an API and obtaining credentials must be simple.  From the providers' perspective, they must be sure to stay in control of who consumers their API and how.

## API Monitoring

An API platform must enable API providers to monitor their APIs. Know what are the request done, by who, the responses times, ... It's critical for both software and business perspectives. Providers needs to now how their implementation behave to prevent problems but also study how consumers use their APIs to enhance their business proposal, adding new features, fixing problems.

## API discovery and documentation

But before consuming an API, people must be able to find it (easily again). Thanks to a central API catalog, such a  platform can also allow having an exhaustive vision of the API surface of the company, making APIs easier to find and consume. Beyond the catalog, the platform may provide more or less advanced API documentation systems. API documentation can take advantage of API specifications such as OpenAPI, and AsyncAPI which both take advantage of JSON Schema. The documentation could be more interactive and provide a "try it" feature, Postman collections, and "Run in Postman" buttons. But not all the documentation can be generated, the platform must allow providers human contributions.

## API design and governance

An API platform can also help to enhance your API surface and ensure a certain level of quality and consistency. Indeed either for existing or new APIs, an API platform may provide tools helping to ensure a certain consistency and avoid a few mistakes in their design. Linter such as Stoplight Spectral could be used in CI/CD pipelines. The platform may integrate with API design tools (taking advantage of such linters). It may also provide tools or plug into tools helping with governance processes.

## API-First

Obviously, all tools used by the platform MUST propose APIs (look at my [recommendations regarding the choice of software solutions](https://apihandyman.io/analyzing-a-software-solution-from-an-api-perspective/)). Without APIs, it will be complicated to integrate them together.

But more than that, an API platform MUST offer most (if not all) of its features through APIs. For instance providing a tool that lint an API description (OpenAPI or AsyncAPI) solely in the form of a web application, the UI code holding the lining logic, is a critical mistake to avoid at all costs. It makes it totally un-reusable in CI/CD or other tools used by API providers.

Being 100% API first will bring flexibility to the platform itself and also flexibility in how people will use it and help adoption.

## People-first and product-first

A good API platform must never be a burden for its users and go against them, limit them. That seems obvious to say, but unfortunately, just like with API governance, terrible things can be done with API platforms. Being API-first can help avoid that, but that's not enough. People building the platform must understand the needs of API providers and consumers. The platform must be a product (or set of products) that pleases and helps its users. The people owning the platform may have some other objectives, but they MUST never go against their users ones.

# The LEGO job offer

Now that we have a better vision of what is an API platform, let's look at the  [LEGO associate API engineer job offer](https://www.lego.com/en-us/careers/job/60676511) (_you can find the job description at the end of this post if the link is dead_). 

Small digression beyond API platforms, this offer shows this company takes API very seriously from an IT perspective and seems possibly engaged in becoming API-First. The job offer talks about an "API journey" and "Digital Platforms department", which could be a sign of an API-first strategy, but I wasn't able to confirm it by looking at other API job offers, because this is the only one. But it's sure that APIs are important from an IT perspective.

The offer doesn't go into too much detail about what an API platform for LEGO is, but in broad strokes, it looks pretty good. They are building an API platform "that must be the preferred platform [...] when exposing APIs and events". They must "create and maintain tools and infrastructure that can be reused and shared across all our product domains."

It's really interesting to see they put APIs and events at the same level, I really think that is the future of API-in-a-broad-sense platforms.

The LEGO API management team has a product vision, they want to build something that brings value to their users. That's the right mindset!

Regarding the expected skills, people are expected to have knowledge of API development, infrastructure, and security. They must know how to code, have created and hosted APIs, and have experience with CI/CD (Continuous Integration/Continuous Development) and IaC (infrastructure as code). Having some experience with API gateways, event brokers, Kubernetes, Oauth, and identity providers is welcomed.

This skill list could gain adding some precisions and a few items:

- The "Experience in creating and hosting an API" could be enhanced like this "Experience in creating (design, implementation), hosting and consuming APIs (DX)".
- The list of "must-have" skills could be completed by "Experience with API specifications such as OpenAPI, AsyncAPI, JSON Schema"
- The list of nice-to-have skill could be completed by experience with
    - API governance practices and process
    - API tools such as Stoplight Studio, Spectral, Postman, curl, ...

# Not-so-obvious skills

Beyond knowing how to code and build infrastructure, building an outstanding API platform for API builders requires knowledge of what API providers and API consumers use and their practices.

## API Specifications

Building an efficient API platform requires taking advantage of API specifications such as OpenAPI, AsyncAPI, or JSON Schema. Knowing them will give you some ideas about how to make your platform more efficient, more integrable, and interoperable without reinventing the wheel. Usually, if you have built APIs seriously, you should have used those specifications.

## API Tools

Building an efficient API platform required knowing what tools people building API are using. Why they use them and how. Those tools could take advantage of API specifications or not. But building an API platform without such knowledge will lead to reinventing the wheel and loose time. It will also cripple flexibility because without knowing the existence of tools used by API builders, the platform team may not think to provide integration for those tools. Without knowledge of the possibility offered by those tools, you may miss some huge opportunities to bring value to the users of the platform.

Having built or consumed APIs is usually a good way to acquire this knowldege.

## API Design

Knowing the importance and the challenges of designing APIs can be of great help to build an outstanding platform. For instance, how many times, I have seen platform people ruin API designers' efforts by doing too much control at the API gateway level, bypassing smart error handling the original API contract was supposed to provide. Or the terrible "you can't return 4xx errors, that will make or monitors bug". Having created API yourself may have helped you acquire such knowledge. Knowing how to design APIs, will also help you create great APIs for the platform (and will help you eat your own dog food as your APIs will be exposed ... on the platform you build!).

Creating APIs is the obvious way of getting such knowledge. But consuming APIs will also teach you a few things: you'll quickly learn to make the difference between good and bad APIs.

## API Governance

Having some knowledge of what is API governance, the processes, and the tools that it requires can really help build outstanding API platforms. With such knowledge, you'll have tons of ideas to facilitate API providers' life and also avoid stepping on the API governance team's toes and even help them (if they are a separate team from yours).

That knowledge is not that common in my opinion. It requires to have work in organizations that takes API really seriously. A candidate with such knowledge is highly valuable.

## All users experience

Being kind and helpful to people will help you to build the best user experiences.

When talking about API and user experience almost everyone thinks about developer experience or DX. It is the experience the API consumers have when using APIs. It concerns design but also security, how to subscribe to an API, getting credentials, revoking them, accessing documentation, playing with a sandbox, getting the right to use API in production, ... It's essential to know what API consumers expect to provide them the best platform.

Beyond that, API's DX has raised the bar of software quality in general.  And in the case of an API platform, the consumers are not the only users. The providers are users too. Their experience must not be neglected.

For that aspect, the LEGO proposal which emphasizes the product vision is interesting. People having worked in product mode are keener to have that vision. Put IT API creators having only worked on their own APIs may not have that vision.

# APUX ( API Platform User Experience)

What is important regarding an API platform is that when building it you must take care of ALL users' experience and so have experience on both provider and consumer sides.

So I would have made a few additions to this job offer. To keep it short, the only items that really miss are the "API Specifications" and "consuming API", all the rest can be guessed from the updated proposition. Especially now that you have read this post.

I'm sure a candidate bringing the not-so-obvious skills and knowledge I've described will be in a good position to get the job. And if you are building a platform yourself and looking for people to help you, you know what to look for.

# Appendices: The original LEGO job description

Excerpt of LEGO's [associate API Engineer](https://www.lego.com/en-us/careers/job/60676511) job offer.

**Do you want to be a part of our building and maintaining the new API platform to be used across the LEGO group?**

Bring your energy and a willingness to learn into the APIs journey and help us build the platforms for all the software engineering teams across the business.

**Core Responsibilities**

• Be part of a team where we build our future API platform and the tooling around it. It is to be the preferred platform for our colleagues when exposing APIs and events.
• With our skilled engineers team you will ensure that we deliver an API platform for the rest of the LEGO group.
• Be a part of the full lifecycle in software development; understanding feature requests, development, testing and ensuring that our products are operating as expected in our live production environment.
• See the value in automating operational tasks and are an aspiring site reliability engineer (SRE).

**Play your part in our team succeeding**

The API Management team is one of the pillars of our newly established Digital Platforms department. The goal is to create and maintain tools and infrastructure that can be reused and share across all our product domains.

We apply platform engineering and product management practices to ensure we build what brings the most value to our customers (the other software engineers) and ensure a close feedback loop.

We are eager to collaborate and love to share and receive feedback from both our colleagues and customers.

**Do you have what it takes?**

• Experience in creating and hosting an API
• Proficient with one or more general purpose programming language like TypeScript, C#, Java…
• Experience with CI/CD in a tool like GitHub actions, Jenkins, Team City…
• Experience with IaC, could be CDK, Pulumi, Terraform...

Nice to have experience with:

• An event broker like Pulsar, RabbitMQ or Kafka
• An API Gateway like Kong, AWS API Gateway, …
• OAuth and Identity providers
• Kubernetes