---
id: 639
title: API Days Paris 2015 with a lightsaber
date: 2015-12-11T23:22:17+00:00
author: Arnaud Lauret
layout: post
guid: http://apihandyman.io/?p=639
permalink: /api-days-paris-2015-with-a-lightsaber/
dsq_thread_id:
  - 4867363066
category: posts
tags:
  - Design
  - Lifecycle
  - Documentation
  - Hypermedia
  - Conference
  - API Days
  - API Days Paris
---
API Days Paris just finished this Thursday, leaving me both *sad and exhausted* and *happy and full of energy*.

Sad and exhausted because this awesome and intense API conference is over.  
Happy and full of energy because this awesome and intense API conference exists.<!--more-->

Two days about automating IT business and the whole society with APIs.  
Two days about humanity, society, philosophy and technology.  
Two days listening and talking to great people from the *APIverse*.  
Two days of discussion and discovery.  
Two days hanging with old and new friends.   
Two days tweeting like a berserk. 

# API Days Paris 2015 in a few numbers and words

This year API Days Paris numbers are: 

- 1 light saber
- 1 REST Fest hack day
- 2 long days
- 3 short nights
- 3 custom Commitstrips
- 4 tracks
- 73 talks and workshops
- 800 attendees
- 1600 tweets (around 450 by myself!)
- Thousands of "bouchées", petit four, ... and drinks

Behind the numbers, the main topics I've took away are:

- Man vs Machine
- Composite Enterprise
- Hypermedia APIs
- Design efficient APIs
- Event driven efficient APIs
- Automation

# Man vs Machine

[Christan Fauré](https://twitter.com/ChristianFaure) stated we fear that automation means less jobs. We must put humanity at the center of automation and question what we want automate, de-automate, not automate.
As letters were the root of humanism, APIs are the root of digital humanism. But we need a fertile ground for our API strategy.

> Culture eats strategy at breakfast  
> *Peter Drucker*

We must change our culture, our social automatisms to create this fertile ground.
Do not oppose automation and creativity, stay creative when working on API projects. Let the human drive these projects.

[Steven Willmott](https://twitter.com/@njyx) wondered if automation is a good thing? It depends, and the question should be does automation creates or consumes value?

> Software is eating the world.  
> *Marc Andreessen*

Both Willmot and Bernard Stiegler stated that automation MUST creates new jobs, create value.

Willmott also pointed that we should not teach everybody to be engineers. Not everybody needs it. We are building solutions for humans.

[Louis Dorard](https://twitter.com/louisdorard) explained that machine alone is not the only answer.
Human, machine learning and automation enable a new level of human productivity.
As always, choosing between machine alone, human alone or human + machine will depend on the context. 
 
[Ashley Hathaway](https://twitter.com/Ash_Hathaway) reassured us, Skynet and HAL9000 are not upon us.
We need all the people, the whole is greater than the sum of its parts. Providing tools to developers to make things happens.

[Daniel Benoilid](https://twitter.com/Foulefactory) said that Human can empower APIs.

# Composite Enterprise
[Kirsten Moyer](https://twitter.com/krmoyer) told us that if the business model doesn't change, its not digital transformation. APIs will be the most common reference platform for mapping next generation business models.

These business models will need technology. [Peter Matthews](https://twitter.com/peterm57) stated that digital disruptors understand the benefits of technology.

[Neha Sampat](https://twitter.com/nehasf/) predicted that CEOs will start to ask about APIs (not APPS).

{% include twitter.html url="https://twitter.com/TheMarkONeill/status/674520144647950336" %}

Traditional IT becomes irrelevant, companies have to think out of the box. API management becomes *business* critical. Delivering, visualizing, metrics,...

[Saul Caganoff](https://twitter.com/scaganoff) warned us that enterprises must become digital or others will become for them. Even if the Web is now programmable, enterprises need to enable composite enterprise. 
There are many SAAS services (infrastructure,commodity,functionnal,industry) and a growing ecosystem of iPaas and cloud bpm. 

{% include twitter.html url="https://twitter.com/apihandyman/status/674510402449973248" %}

But unique business value will come out of how companies operate/orchestrate all this stated both Caganoff and Sempat.

# Hypermedia APIs
Like last year, Hypermedia was a huge concern.

## Hypermedia 101

REST Fest alumnis [Shelby Switzer](https://twitter.com/switzerly), [Benjamin Young](https://twitter.com/bigbluehat) and [Darrel Miller](https://twitter.com/darrel_miller) gave a clear 101 on REST (hypermedia) APIs. Identifying resources, manipulate through representation, self descriptive message, and hypermedia.
Finding the right balance between cache, linked and embedded resources will provide network efficiency.   
Darrel reminded us the importance of hypermedia:

> Hypermedia contraint is greater than the sum of rest constraints  
> [Aristotle Pagaltzis](http://plasmasturm.org/) in [The REST Architectural Style List](https://groups.yahoo.com/neo/groups/rest-discuss/conversations/topics/12077)

## Pragmatic Hypermedia

When [Jason Harmon](https://twitter.com/jharmn) asked the audience who was doing hypermedia API, not so many hands raised. People have to be pragmatic: implementing hypermedia must be questionned. First concern must be the value added for developers.  

Both Jason and REST Fest alumnis agreed on the fact that making an API predictable by just having a good design (use right HTTP verbs, status, consistent paths structures, ...) will already enhance developer experience.  
But providing an hypermedia API will definitely improve developer experience.
  
With an hypermedia API, developers only have to follow the links and will be aware of what they can do or not by analyzing the hypermedia controls without the need of business knowledge.
 
## Hypermedia Enterprise

For [Saul Caganoff](https://twitter.com/scaganoff) enterprise need to focus on the S in REST: State.
Enterprise needs hypermedia to handle business processes with their APIs.
A business process is a path through the state model.

# Design efficient APIs
There are situations where REST/web APIs should be questioned. Any tool MUST be chosen wisely.

## REST vs SparQL
For [Ruben Verborgh](https://twitter.com/RubenVerborgh) we need simple server and clever clients enabled by hypermedia APIs and especially the use of *[linked data]()*.
When evaluating API design and implementation, the question is not *is it good or bad* but how you can impact positively and meaningfully noth server and consumer (CPU, network). 
 
Verborgh compare the usage of classic REST API and SparQL on both consumer and server side. The [SparQL query language](https://en.wikipedia.org/wiki/SPARQL) can be seen as the GraphQL of linked data.
REST API tend to generate many calls but can be easily cached, and tend also to be not enough adaptive to the client need. 
On the other SparQL enable the creation of tailor made APIs but consumes many resources on the server side.
  
The conclusion is: if you have the money use GraphQL or SparQL, if not, be clever.

## Think design carefully
[Ross Garrett](https://twitter.com/gssor) reminded us that you don't get a prize on level 3 of [Richardson' Maturity Model](http://martinfowler.com/articles/richardsonMaturityModel.html) as stated [Leonard Richardson](https://twitter.com/leonardr) himself at last [REST Fest](http://www.restfest.org/videos/2015/9/22/five_in_five_talk_by_leonard_richardson).

Web APIs can sting you. As many request as resources, data redundancy, scalability, payload size, all this has an impact on user experience and has a cost. Don't over-deliver data, don't forget HTTP status 304 and think carefully your design. 

[Eric Horesnyi](https://twitter.com/EricHoresnyi) promote the use of [JSON PATCH](https://tools.ietf.org/html/rfc6902) to diminished data volume. 

## Be adaptive
[Hugo Hache](https://twitter.com/hugo_hache) reminded us that some of API consumers are mobile.  

Latency, bandwidth, network absence, you have to be adaptive on both server and client.
Parallelizing request or nesting resource? 4 little request replaced by 1 bigger, is more efficient when considering latency.

Server should be able to modulate response size on client demand.

# Event driven efficient APIs

{% include twitter.html url="https://twitter.com/apihandyman/status/674545678094311424" %}

A new trending topic arose: Events.

## Events become first-class citizen

[Neha Sampat](https://twitter.com/nehasf/), [Saul Caganoff](https://twitter.com/scaganoff),[Ross Garrett](https://twitter.com/gssor) and [Eric Horesnyi](https://twitter.com/EricHoresnyi) agree about the importance of events. 

{% include twitter.html url="https://twitter.com/APIdaysGlobal/status/674512699322159104" %}

Caganoff stated that there's a duality between business processes transitions and events.
Events can be handle through webhooks and syndication.

## Stream And Think Reactive
Internet is an hostile environment especially mobile internet (latency, drop connection), [Ross Garrett](https://twitter.com/gssor) ask us to stop polling, diminish payload. There is no one size does fit all solution, but new solutions are not adopted easily (HTTP2 push, MQTT).

[Eric Horesnyi](https://twitter.com/EricHoresnyi) compared streaming technologies: web socket vs server side events. They are almost the same from the consumer point of view, the differences lie on the server side.

- SSE is HTTP standard, HTTP2 compliant, infrastructure is ready for it 
- Web Socket is TCP, error handling is not defined, protocol upgrade

Both Horesnyi and Garret asked us to think Reactive.

{% include twitter.html url="https://twitter.com/mittsh/status/674544340350406656" %}

# Automation

## Automation and documentation
[Jakub Nesetril](https://twitter.com/jakubnesetril) pointed that APIs can rapidly be inconsistent, incompatible, infuriating especially when you have more than one API.
Generated documentation will not solve *API last* or *API after* thought strategy.

Both Nesetril and myself stated that there's a need for API production lifecycle tools. Tools which can help to create a worflow covering design, prototype, implementation (TDD), delivery of documents, feedback.

I described an ideal automated world where API and documentation live in a perfect harmony. [Jennifer Riggins](https://twitter.com/jkriggins) wrote a blog post about my [Document-API-topia](http://blog.smartbear.com/documentation/the-utopia-of-api-documentation/).

Design needs the definition of style guides, many companies have published their guides. But these style guides needs to be enforced into design tools. Apiary propose such tools, [Jason Harmon](https://twitter.com/jharmn) work on [checkstyle tools for Swagger definitions](https://github.com/jasonh-n-austin/swagger-api-checkstyle).

## Easy automation

{% include twitter.html url="https://twitter.com/apihandyman/status/674547578625740800" %}

[Luis Borger Quina and Philippe Sultan](https://twitter.com/apidaze) told us that bots are the new apps and no UI is the new UI. 
Slack, IFFTT, Zapier enable easy automation.

[Julien Mession](https://twitter.com/agence_buzzaka) explained that taking time to build APIs for devops is worth the cost and that it's easy to test API in devops context.
Webhooks and APIs facilitate closing the gaps between tools.

# Very special thanks and see you at next API conference

First and foremost I would like to thank [Mehdi Medjaoui](https://twitter.com/medjawii), [Mark Boyd](https://twitter.com/mgboydcom) and the [API Days](https://twitter.com/APIdaysGlobal) staff for creating such an awesome event and giving me the opportunity to share my Document-API-topia.

I would also like to thank [Jennifer Riggins](https://twitter.com/jkriggins) and [Paul Bruce](https://twitter.com/paulsbruce) for helping preparing my talk.
Heartfelt thanks to [Kin Lane](https://twitter.com/kinlane) for being such a huge inspiration.

And finally big thank to all speakers and attendees for making this event so awesome.

Looking forward to next API conference to see y'all again!

# Slidedecks

Here are some slide decks:

- [Automating developer adoption (Nicolas Garnier)](http://fr.slideshare.net/Mailjet/automating-developer-adoption)
- [State of Web API Languages (Jérôme Louvel)](http://fr.slideshare.net/restlet/apidays-2015-the-state-of-web-api-languages-55963530)
- [Hypermedia and Civi Hacking (Shelby Switzer)](http://slides.com/switzerly/hypermedia-civic-hacking#/)
- [More power to API clients (Yann Simon)](http://fr.slideshare.net/yann_s/introduction-to-graphql-at-api-days)
- [Simple Servers Clever Clients (Ruben Verborgh)](http://fr.slideshare.net/RubenVerborgh/hypermedia-apis-that-make-sense) 
- [APIs and the creation of wealth in the digital economy (Steven Willmott)](http://fr.slideshare.net/3scale/apis-and-the-creation-of-wealth-in-the-digital-economy-apidays-paris-2015-keynote)
- [Bold Predictions for the 2016 API economy (Neha Sampat)](http://fr.slideshare.net/NehaSampat1/bold-predictions-for-the-2016-api-economy)
- [Automating business process with APIs (Saul Caganoff)](http://fr.slideshare.net/scaganoff/automating-business-processes-with-apis)
- [Document-API-topia (Arnaud Lauret)](https://speakerdeck.com/arnaudlauret/document-api-topia)
- [Build a successful API Overnight : Kill the Unicorn ! (Olivier Etienne)](https://speakerdeck.com/nikz/building-successful-apis-overnight)
- [Future of AI-powered automation in business (Louis Dorard)](http://www.slideshare.net/louisdorard/future-of-aipowered-automation-in-business)
- [When RESTful maybe considered harmful (Ross Garrett)](https://speakerdeck.com/rossgarrett/api-days-paris-when-restful-maybe-considered-harmful)
- [Bots are the new app. Disrupting communications with slackbots (Luis Borges-Quina and Philippe Sultan)](http://fr.slideshare.net/lmbcgq/ottspott-by-apidaze-api-days-paris-2015)
