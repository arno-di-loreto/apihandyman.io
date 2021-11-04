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

# Swagger vs OpenAPI

The Swagger Specification and the OpenAPI Specification are not actual competitors, the latter is the most recent version of the former.
It is (or they are) a machine readable format allowing to describe REST(ish) HTTP based APIs.
The Swagger Specification was incidentally created in 2011 during the development of [Wordnik](https://www.wordnik.com/), an online dictionary, because of the need for automation of API documentation and client SDK generation.
At that time, the tip of the Swagger iceberg was Swagger UI, a Web UI for API documentation powered by a JSON file containing a description of an API.
This description being generated thanks to some annotations in the implementation.

But at that time, most people, myself included, were not aware of the underlying API description format until Swagger 2 was released in 2014.
A new tool, Swagger Editor, and the possibility of using human friendly YAML in addition to JSON make this API description format a thing.
It could be written instead of generated and so be used in a design first approach.
But this format has a wide range of use from documentation generation or gateway configuration to design rules enforcement, and that expands regularly.
That format actually changed my life, API Handyman and my current self would probably not be there without this milestone, but that's another story.

By the end of 2015, SmartBear who now owns the [Swagger brand and tools](https://swagger.io/), donated the Swagger Specification to the [OpenAPI Initiative](https://www.openapis.org/), "a consortium of forward-looking industry experts who recognize the immense value of standardizing on how APIs are described". Besides SmartBear, this organization has founding members such as Google, IBM and Microsoft.
In January 2016, the Swagger Specification was "renamed" the OpenAPI Specification.
Basically, it was still the exact same format with its version indicated with a `swagger: "2.0"` line.

The first true version the OpenAPI Specification the version 3.0, was released in 2017, a year and a half after the creation of the OpenAPI Initiative.
This evolution came with some welcomed breaking changes, the  most visible one being the version indicator which became `openapi: "3.0"`.
This single modification was officially marking the beginning of a new era, goodbye Swagger Spec, hello OpenAPI Spec.

But the transition was (and is) not that simple. 

# Why Swagger still surpasses OpenAPI

Swagger already had a lot of traction in 2017 when OpenAPI 3 was released, the Swagger tools themselves were (and are still) quite popular.
And more and more tools were created around the Swagger specification and more tools were supporting it.
This strength actually became a weakness for the transition.

## Tools are slow to evolve

It actually took time for Open Source and Vendor tools to support the new OpenAPI 3 version.
It also took, and still takes, time for users to upgrade too. 
Some were quick, some were slow.

For instance, the API gateway I currently use in my company, which was supporting the use of Swagger 2, added OpenAPI 3 (partial) support only in 2019, I think.
But after that it took us some time to make evolve the tooling we had built around our gateway solution, and so OpenAPI 3 was actually only available in 2020... virtually.
Indeed, if the OpenAPI 3 compliant gateway was in our software catalog and our tools were up to date, our internal customers could only get access OpenAPI 3 features after upgrading their gateways.
It took several months to update them.
And I know places where bumping to the "latest" version of a solution takes even more time and so they are still stuck with Swagger 2 (and they will have to make all their tools compatible with the new OpenAPI 3 version).

And it's not because we propose tools supporting OpenAPI 3 that it will be actually used.
Some teams were ahead of time, already using OpenAPI 3 during design and downgrading their contract to Swagger 2 for deployment, eagerly waiting for the gateway update.
But I work with teams who didn't wanted to do that and were waiting the upgrade of the platform.
I work also with team having a code first approach (and if you read this blog regularly, [you know what I think about it](/6-reasons-why-generating-openapi-from-code-when-designing-and-documenting-apis-sucks/)), upgrading their code to generate OpenAPI 3 instead of Swagger 2 was not a priority.
Some can work on it in 2021, some are still stuck on Swagger 2.

Switching to OpenAPI 3 requires efforts to everyone on the chain, that's the first reason why Swagger 2 is till predominant.
But there's another reason.

## Confusion and habits

OpenAPI does not only brings breaking change it revealed existing confusion and brought a new name, adding to the confusion.

Most people were (and some are still not) aware that inside "Swagger" you had the tools (library and UI) AND the specification, two separate concepts.
For most people "Swagger" is actually "Swagger UI".
Do all the people who responded to Postman's question "Do you use Swagger" know the subtile difference?
I hope so as it was under a "API specification question" but I have no clue.
What I'm sure of, is that I still have to explain the OpenAPI/Swagger stuff and not only to business analyst but also developers.

If naming thing is hard, changing something's name is just a nightmare.
Let's sweep under the rug the "OpenAPI Specification" vs the "Open API Initiative", or was it the other way round?
Hopefully that's settle now everything is "OpenAPI".
But WTF is OpenAPI?
Even some VENDORS, are still talking about "Swagger".
And in organization who initiated API initiative in the Swagger era (that actually lasted until long after OpenAPI 3 release due to what is said above about tools), everyone talks about "Swagger".
They're not designing APIs, they're not defining API contracts, they're writing or generating Swaggers.


# What could be done?

What about a Swagger jar?