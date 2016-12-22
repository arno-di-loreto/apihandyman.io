---
id: 545
title: Starting a Swagger journey beyond generated Swagger UI
date: 2015-10-07T21:56:37+00:00
author: Arnaud Lauret
layout: post
guid: http://apihandyman.io/?p=545
permalink: /starting-a-swagger-journey-beyond-generated-swagger-ui/
dsq_thread_id:
  - 4866807412
category: posts
tags:
  - Design
  - Swagger
  - OpenAPI
  - Documentation
---
When watching a movie, have you ever noticed how characters *interact* with computers? If someone wants to destroy a computer, what does he or she smash?  
The computer's screen...<!--more-->

{% img file:spock-smash-computer.gif %}

With *Swagger*, it's almost the same thing. Many people focus only on *generated Swagger UI* and only see Swagger as a useful way to generate documentation from an API implementation.

But reducing Swagger to an auto-generated interactive API documentation is a *terrible mistake*.

> Swagger is a simple yet powerful representation of your RESTful API.  
> [Swagger.io](https://swagger.io)

... and it's *far* from the truth.

In this first post of a new series, I will tell you how I've stopped being a *computer's screen smasher* and started my *Swagger journey*.

# Lessons from the trenches of an API project
When I started to work on my company's new API project, Swagger was only Swagger UI, *the thing that generate interactive API documentation using annotation in a java application*. 

It was only a by-product of the project.

But after working for a while on this project, some concerns, not all related to the generated Swagger UI, arise. 

## Documentation tightly coupled with implementation

{% img file:indianajones.png label:"Documentation (Henry Jones Sr) tightly coupled with implementation (Henry Jones Jr)"%}

Even if our new API is not an open one, it is used by people outside our company so I started to take a closer look at the generated documentation to check if everything was ok. It was... on the surface:

- Swagger UI was working
- Users could browse the documentation
- Users could test the API through this interactive documentation

But when taking a closer look at this generated documentation, some problems appear.

{% img file:modelview.png label:"Pet Store Swagger model view example"%}
  
Even if the resulting API was matching the specification, the model view of Swagger UI reveal some holes in the specification and was not satisfying:

- The model names were reflecting poorly named java classes.
- The model hierarchy was not consistent and poorly designed.
- Some attributes format were not the good ones.

There were also some typing errors and missing informations in operations or attributes descriptions.

Nothing serious, but to correct the generated documentation, we had to modify the application, rebuild it and deploy it. This tight coupling between the generated API documentation and its implementation was annoying in our context.

## From API last to API first
Even if our new API is not a ROAST one (really dumb SOAP to pseudo REST conversion), it is still tightly coupled to our SOA as it was designed last and with not much hindsight. 
Just like a by-product, just like a necessary evil.

{% twitter https://twitter.com/H4CKTECH/status/646610528907993088 align=center %}

I wanted to change that and make the API a first class citizen in our system just like our website or mobile application.
I wanted to really have an API first approach with tools to help us design faster and mock to test easily the design to ensure a good quality from the start.

## A good Word specification is the one you didn't wrote
Wether you design your API last or first, you need something to describe it. We were using Word and Excel documents to describe our API, just like we've always done with our SOA.
Working with such documents has never been an easy task:

- Templates are not constraining enough and lead to inconsistent documentations.
- If you change your template, you have to modify all previously written ones manually (and of course you don't do it).
- It takes far too long time to write a simple description.
- Have you ever try to compare to different versions of a word document?
- These documents are only (barely) readable by humans and you cannot use them with programs.
- Documentation is written twice: on design time and on development time.

I wanted to get rid of all this and have something more fast, more simple, more consistent, more maintainable, more *documentation as code* and both human and machine readable.

# Eureka! Swagger 2.0
Hopefully, it was at that time that Swagger 2.0 was released with the [YAML editor](http://editor.swagger.io) and its [tools](http://swagger.io/swagger-2-0-tooling-released/).
Thanks to this new version, I realized my mistake, I realized that Swagger was *not only* generated Swagger UI.

> Eureka!  
> *[API handyman taking a bath][eureka]*

[eureka]: https://en.wikipedia.org/wiki/Eureka_(word)

Swagger is an *API definition language* and there are [so many tools](http://swagger.io/open-source-integrations/) using it.

{% img file:swaggereditor-petstore.png label:"Swagger API definition in Swagger Editor" %}
  
By *really* using Swagger and its ecosystem I thought we could:

- Write better and more consistent API definition once and faster, especially with the YAML editor.
- Decouple API documentation from its implementation.
- Have machine readable documentation useable with many existing tools (like mock generator, Postman and many others).
- Treat documentation as code.
- Facilitate the API first approach and the building of an API governance.
- And also do many other things I couldn't imagine at that time...

# To boldly go ... 
So this is how I started my Swagger journey, with so many ideas in mind and so many hopes. But I was confident and I knew I would not be alone on this journey as the [Swagger community](http://swagger.io/community/) is large and friendly.
On the next post, I'll explain how I use *standard* Swagger tools to write API definitions.