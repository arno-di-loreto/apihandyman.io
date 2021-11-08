---
title: "We need to talk: OpenAPI 3 is 4 years old, but Swagger 2 is still predominant"
date: 2021-11-10
author: Arnaud Lauret
layout: post
permalink: /we-need-to-talk-openapi-3-is-4-years-old-but-swagger-2-is-still-predominant/
category: post
---

While quickly doing a first scan of latest Postman State of the API Report , I did my Spock face, raising an eyebrow.
Indeed, I read that after JSON Schema, "The next most popular specifications were Swagger 2.0 (54%) and OpenAPI 3.0 (40%)".
To be honest and based on my own experience, it's not totally surprising, I'm still hearing/reading "can you check that Swagger" everyday.
But why the 4 years old OpenAPI 3 is still struggling to surpass the good old Swagger 2?
<!--more-->

# Swagger vs OpenAPI started in 2017

The Swagger Specification and the OpenAPI Specification are not actual competitors, the latter is the most recent version of the former.
It is (or they are) a machine readable format allowing to describe REST(ish) HTTP based APIs.
The Swagger Specification was incidentally created in 2011 during the development of [Wordnik](https://www.wordnik.com/), an online dictionary, because of the need for automation of API documentation and client SDK generation.
At that time, the tip of the Swagger iceberg was Swagger UI, a Web UI for API documentation powered by a JSON file containing a machine readable description of an API; this description being generated thanks to some annotations in the implementation.

But at that time, most people, myself included, were not aware of the underlying API description format until Swagger 2 was released in 2014.
A new tool, Swagger Editor, and the possibility of using human friendly YAML in addition to JSON mae this API description format a thing.
It could be written instead of generated and so be used in a design first approach.
But this format has a wide range of use from documentation generation or gateway configuration to design rules enforcement, and that expands regularly.
That format actually changed my life, API Handyman and my current self would probably not be there without this milestone, but that's another story.

By the end of 2015, SmartBear who now owns the [Swagger brand and tools](https://swagger.io/), donated the Swagger Specification to the [OpenAPI Initiative](https://www.openapis.org/), "a consortium of forward-looking industry experts who recognize the immense value of standardizing on how APIs are described". Besides SmartBear, this organization has founding members such as Google, IBM and Microsoft.
In January 2016, the Swagger Specification was "renamed" the OpenAPI Specification.
Basically, it was still the exact same format with its version indicated with a `swagger: "2.0"` line.

The first true version the OpenAPI Specification, the version 3.0, was released in 2017, a year and a half after the creation of the OpenAPI Initiative.
This evolution came with some welcomed breaking changes, the  most visible one being the version indicator which became `openapi: "3.0"`.
This single modification was officially marking the beginning of a new era, goodbye Swagger Spec, hello OpenAPI Spec.

But the transition was (and is still) not that simple. 

# How is it going in 2021?

4 years later, Postman State of API 2021 report states that after JSON Schema, "The next most popular specifications were Swagger 2.0 (54%) and OpenAPI 3.0 (40%)".
Let's be honest, that's not good, but maybe OpenAPI number is slowly but surely growing?
If we compare the responses to the "Which API specification do you use? (multiple possible answers)" question in Postman's [2020 (page 31)](https://www.postman.com/state-of-api-report-2020.pdf) and [2021 (page 44)](https://www.postman.com/assets/api-survey-2021/postman-state-of-api-2021.pdf) reports, we have the following numbers:

| Year | Swagger | OpenAPI | Delta |
|------|---------|---------|-------|
| 2020 |  43%    |   28%   |  15%  |
| 2021 |  54%    |   40%   |  14%  |

The number of people using Swagger has _increased_ (what the??) by 11% while OpenAPI has increased by 12%, the delta between OpenAPI and Swagger is relatively stable around 15%.
_Note that I had to guess 2020 numbers from the graphics, as they are not explicitly written in this report._

So the OpenAPI community has a problem, there are more people using Swagger in 2021 than in 2020.
Maybe there's no real increase, it may be due to the fact there are more respondent in 2021 than in 2020, giving a more realistic view on reality...
But that would mean the number of OpenAPI users are stagnating.

However I look at the numbers and the hypothesis I could do, I can be sure of one thing: there are more people using Swagger Spec than using OpenAPI Spec and, without more information, it does not seem to want to change.
What can be done about it?
While tempting, I don't think it will be solved with pitchforks and Swagger jars.
So, What can be done about it?
Talk more about the OpenAPI Spec (formerly known as Swagger Spec)?

Solutions to unknown, or maybe nonexisting problems are usually useless solutions.
Indeed, before finding solutions, we need to know what is the actual problem (or the actual problems).

So a first step could be to ask the question: why are you still using Swagger 2 instead of OpenAPI 3?
While I don't have everyone's answer, I can share what I've seen.

# Why Swagger still surpasses OpenAPI

Swagger already had a lot of traction in 2017 when OpenAPI 3 was released, the Swagger tools themselves were (and are still) quite popular.
Many tools were created around the Swagger specification and many tools were supporting it.
This strength actually became a weakness for the transition.

## Tools are slow to evolve

While there were breaking changes brought by OpenAPI 3, there were just a clarification and enhancement of Swagger 2, quite simple to get.
Even converting a Swagger 2 file to OpenAPI 3 is quite simple.
But if that's simple at the spec level itself, it's less simple at tools level.
It actually took time for Open Source and Vendor tools to support the new OpenAPI 3 version.
It also took, and still takes, time for users to upgrade too. 
Some were quick, some were slow, some are still stuck.

For instance, the API gateway I currently use in my company, which was supporting the use of Swagger 2, got OpenAPI 3 (partial) support only in 2019.
But after that, it took us some time to make evolve the tooling we had built around our gateway solution, and so OpenAPI 3 was actually only available in 2020... virtually.
Indeed, if the OpenAPI 3 compliant gateway was in our software catalog and our tools were up to date, our internal customers could only get access OpenAPI 3 features after upgrading their gateways.
It took several months to update them.
And I know places where bumping to the "latest" version of a solution takes even more time and so they are still stuck with Swagger 2 (and they will have to make all their tools compatible with the new OpenAPI 3 version).

Though a few teams were ahead of time, already using OpenAPI 3 during design and downgrading their contract to Swagger 2 for deployment, eagerly waiting for the gateway update, it's not because we propose tools supporting OpenAPI 3 that they will be actually used as soon as they are available (they actually still support Swagger 2).
I work with teams who were waiting the upgrade of the platform... but didn't have the time to make the transition yet.
I work also with teams having a code first approach (and if you read this blog regularly, [you know what I think about it](/6-reasons-why-generating-openapi-from-code-when-designing-and-documenting-apis-sucks/)), upgrading their code to generate OpenAPI 3 instead of Swagger 2 was not a priority at all.
I even have seen teams willing to pass to OpenAPI 3 but blocked by existing frameworks using outdated libraries.
So, in 2021 some teams were at last happily transitioning to OpenAPI 3, some are still waiting and some are totally stuck with Swagger 2.

Switching to OpenAPI 3 requires efforts to everyone on the chain, that's why Swagger 2 is till predominant.
But that's not the only reason.

## Confusion and habits

OpenAPI does not only brings breaking changes, it revealed existing confusion and brought a new name.

Most people were (and some are still) not aware that inside "Swagger" you had the tools (library and UI) AND the specification, two separate concepts.
To make it even more short, for most people "Swagger" is just "Swagger UI".
Do all the people who responded to Postman's question "Do you use Swagger" know the subtile difference?
I hope so as it was under a "API specification" question, but I have no clue.
What I'm sure of, is that in 2021 I still have to explain the OpenAPI/Swagger stuff and not only to business analysts but also developers (and yes I'm working with business analyst on API design).

If naming thing is hard, changing something's name is just a nightmare.
Let's sweep under the rug the "*OpenAPI* Specification" vs the "*Open API* Initiative", or was it the other way round?
Hopefully that's settle now everything is "*OpenAPI*".

"But WTF is OpenAPI?".
In organization who launched their API initiative in the Swagger era (that actually lasted long after OpenAPI 3 release due to what is said above about tools), everyone talks about "Swagger".
They're not designing APIs, they're not defining API contracts, they're writing or generating Swaggers.
They's deploying Swaggers ...
Not OpenAPI.
Even some VENDORS, are still talking about "Swagger", I'm always the annoying customer telling them "That's OpenAPI now, do you support OpenAPI 3 by the way?".

People are used to Swagger and habits die hard.

# What about you?

All this is based on my experience, but how much is this universally "true"?
My experience does not make this an actual scientific fact.
So now it's your turn, why are you still using Swagger 2 instead of OpenAPI 3?

PS: I still keep the idea of pitchforks and Swagger jars, we never know, they could be useful once we'll know more about the actual problems.