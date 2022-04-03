---
title: "3 common APIfication problems: complexity, security, capacity"
date: 2021-09-22
author: Arnaud Lauret
layout: post
permalink: /3-common-apification-problems-complexity-security-capacity/
category: post
---

API all the things! 
Whatever the reason, IT optimization or digital transformation, it's nowadays fairly common to APIfy an existing system, making it available through APIs.
What is also very common is to not totally grasp the implications of doing so and especially overlooking complexity, security and capacity concerns.
<!--more-->

# Context

Though (Web) APIs have been there for quite a long time, though the API economy is in the air for almost as long, there are still some companies that take the API train today.
It could be because they want to refresh their IT systems, to replace old JSP web sites by brand new JS/HTML SPAs (Single Page Applications) for instance.
They could also want to participate to the API economy, by providing their services through APIs. 

Unfortunately, not all companies can rebuild themselves from scratch to provides those APIs, they have to deal with existing systems that sometimes cannot be replaced easily.
And so they have to keep them.
Hopefully, that does not mean they can't do new stuff with it, that means they will have to compose with them, maybe to build around them.
(Actually it is sometimes more interesting from an architecture perspective to work on such system than just to build brand new stuff, you can learn a lot doing so.)
But APIfying existing system must be done having 3 concerns in mind: complexity, security and capacity.

# Complexity

Building APIs to provide access to an existing system is unfortunately prone to actually create APIs that just give access to an existing system.
That means the APIs will just be technical connectors brutally exposing underlying complexity.

If the system that needs to be exposed is a good old corporate software solution, some may be tempted to give a direct access to its APIs (hoping it has some).
Unfortunately, corporate software usually provide terrible APIs that are awfully complex and require to be an expert of both the related business domain and the software solution itself to use them.
And that's definitely not how modern APIs should be.

Old systems can be the result of years if not decades of IT, business and organization evolutions, they may simply not make any sense at all for people outside of the team owning them or outside the organization.
I have seen places where 2 different software solutions would handle the same business domain because of historical and organizational constraints.
Years of evolutions in a close environments may have lead to creating a local business dialect only understood inside the organization.
That must not be shown to the outside

And these are only a few examples of the complexity that could be exposed to the outside, if care is not taken.
Always try to look at what you want to expose with a fresh eye, focusing on an outside-in business perspective approach.
Then find the means to plug this new perspective to the existing system whatever the means: API redesign, adding new layers, adapting architecture or organization, ... 

# Security

An other major problem too often neglected when exposing existing systems is security.

A typical example would be to bluntly reuse existing purely internal (SOAP) web service, restify them and use them in a JS/HTMl SPA ... 
Totally forgetting that the replaced good old web applications was actually handling all of the security like "is this user allowed to make a wire transfer from this bank account?" or "is this user allowed to make a 1 million euros wire transfer?".
You can't delegate such controls outside of your walls.
(Note that I never have actually seen this specific use case. It's purely hypothetical. Really. Please, no questions.).

Exposing an existing system requires to rethink security to ensure that the consumers won't be able to harm it.
And by security I mean regular access controls but also business controls.

# Capacity

And last but not least problem: capacity.
You must ensure that the existing system is actually able to handle the new solicitations coming through the new APIs.

It's not that rare to see old systems that were made to only run at office hours.
But exposing them through APIs may requires to do some modifications to make them available 24/7.
In last resort you may include those constraints in your SLA but in 2021 that may seem awkward depending on your business domain and who the consumers of your APIs are.

And more tricky: the infrastructure.
Exposing an existing system requires to know its capacity and its current charge.
How many of this new solicitations through APIs can it handle?
Aren't you putting the other usages of the system at risk by opening the new API channel?
Can you easily add more horse power?
Systems that have been creating prior the cloud era are probably still hosted on not easily extensible infrastructure or worse may have an architecture that makes them not extensible to handle more requests.

# Only solutions

All that looks very pessimistic.
But you must be aware of it in order to avoid screwing your API initiative and find the solutions to solves those problems.
And don't be afraid, based on my experience, there are always solutions.
I have worked on systems that ended mixing non extensible mainframe, not easily extensible unix servers and unlimited horse power cloud infrastructure. 
Oh, it's a little bit more complicated than just building from scratch, but that's how you can actually have fun as an architecture-problem-solver.