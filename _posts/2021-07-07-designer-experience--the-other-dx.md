---
title: API Designer Experience, the other DX
date: 2021-07-07
author: Arnaud Lauret
layout: post
permalink: /api-designer-experience-the-other-dx/
category: post
---

Nobody expects the API inquisition!
Literally.
When creating public or private APIs, an organization must work hard on creating the best possible developer experience or DX.
That requires to ensure that API designers "do their job well": creating APIs that fulfill actual needs and are easy to understand and use.
This is the aim of governance which may help creating the best APIs or may slowly killing the organization, depending on the designer experience, the other DX, it provides.

<!--more-->

# What usually is DX

In the API world, DX stands for Developer eXperience.
It consists in providing APIs that fullfil their needs but that also are easy to understand and easy to use in a matter of minutes if not seconds.
Developers should be able to understand the purpose of an API in 3 seconds, identify the operation in 30 seconds and be able to make their first API call within 3 minutes.
That latter time including creating an account, getting credentials and then calling the API.

Achieving such a great DX does not only rely on the API itself, its purpose and its design.
It relies also on everything that comes around: 

- The way people will find it
- Its various documentations from high level description (that allows to understand what the API does) to instruction manual (ready to use recipes) and reference documentation (describing all operations and how the API works)
- And the tools provided (in a broad sense: account creation and management, credentials, billing, ...)

Working on DX is basically aiming at making developers life simpler.
That's the usual DX, but there's another one, that an organization creating public but also private APIs, should care about.

# The other DX: Designer eXperience

Those APIs are actually designed in order to make them easy to understand and easy to use.
Succeeding in consistently and in the long run creating such APIs at scale requires governance.
Governance implies defining rules, controls and processes that will ensure that all APIs will share a common look and feel, be consistent and have the same level of quality.

The problem with governance is that sometimes it is so focused on rules, controls and processes that people, and especially API designers, actually dealing with it are totally forgotten resulting in the most terrible Design eXperience, the other DX.

# Create user friendly design guidelines

API design guidelines are the set of rules that will define the look and feel of an organization's APIs.
They can be compared to an organization's graphic charter and also to [design system](https://en.wikipedia.org/wiki/Design_system), but instead of defining its visual identity that will be used when creating websites or mobile apps for instance, it defines its APIs identity.
These guidelines are mandatory to build a good developer experience because consistent APIs are easier to understand and use.

But they also matter for people who will design APIs. Defining a common design base allows each designer to avoid wasting time and trying to find a solution to a design problem that has already been solved. But that will only work if those guidelines apply the same principles used to create APIs: guidelines must be simple to understand, simple to use and fulfill actual designers needs.

So do not reinvent the wheel, do not reuse your possibly outdated and highly specific practices, follow outside world standards and common practices. Define rules only when that is actually necessary, if you’re unable to explain a rule, don’t put it in your guidelines. Design rules must exist only to help people not unnecessarily constrain them.

Do not write your guidelines in an "incomprehensible super expert that loves to hear themselves” style. Make them simple to use, just like you would do when creating API documentation. Once you have defined rules, create use case oriented design patterns describing in one place all rules that actually apply to a specific use case.

And listen to people. Accept changes, evolutions. Rules are not set in stone, you must never hesitate to make them evolve by adjusting or completing them based on API designers and implementers feedback.

# Conduct user friendly design ~~reviews~~ workshops

But even with the user friendly-est guidelines are not enough, designers may make mistakes and most important a consistent style is only a fraction of what makes an API a good one.
Consistency goes beyond style, inside an API one must ensure that all data models are consistent for example, as we say in french, a cat must always be called a cat for instance.
And worse, one can create an API complying a 100% to guidelines that will be a terrible one.
Indeed, guidelines do not guarantee that an API will meet the right need in an efficient way. 
Do we have the right vision of the need? Is the resulting API really user friendly? Easy to understand, easy to use for someone outside the organization (another team or a partner or a customer)? 

So, irremediably coming along with guidelines, there are the mandatory API design reviews.
It is important that several people can look at and challenge a design.
An API must be analyzed from different perspectives: business, technical, developer experience to guarantee its success.
And it is important that at least one "external" person, or one who can act as if, participates in this analysis, because we can quickly fall into the creation of specialist APIs like Kitchen Radar if we are not careful. 

But beware, this exercise can quickly turn into a counterproductive trial if you are not careful.
A design review is not about policing and beating up on people because their design is “breaking the law”,  "non-compliant" or worse "sucks" from the reviewer's perspective.
An API design reviewer is not the inquisition of API design.
Actually, nobody expects the API inquisition, literally. 

An API design review must be seen more as a design workshop.
Being an API design reviewer is more about being a consultant, helping people identify their needs, choosing the best possible representation, helping them make decisions adapted to their context, explaining the consequences of going in one direction or another.
Once everything is analyzed and explained, API designer reviewers must let designers choose because they are the owners of their APIs.

API design reviewers must help designers and respect API ownership.

# Build user friendly organization, processes and tools

Just like a terrible registration process can ruin the best API's developer experience, there are other aspects of API governance to take care of to ensure creating the best possible developer experience.
Indeed, if guidelines and reviews are the most obvious aspects of API governance participating in building the better or the worst designer experience, wrong human organization, processes and tools can cripple all efforts.

When possible, prefer decentralized organization, aim on training all designers in order to make them the most autonomous possible.
It's far better for the organization that people add to their expertise than having a small set of not always available experts.
That can be done gradually by identifying local experts that will be trained and then help and train other themselves.

When defining processes, never lose sight that governance is there to enable designers to the right thing simply.
If it takes weeks if not month to do an API design review, it's a terrible designer experience.
If processes lead to designers losing ownership, it's an even more terrible design experience.

When creating tools, ensure they are user friendly.
Take advantage of standard/common practices, using the OpenAPI specification instead of wiki pages or spreadsheet to describe an API for instance.
Ensure also they are the most open possible, providing APIs for instance, so designers can use them in a wide range of context because not all teams build APIs in the same way.

# Fear the consequences of terrible Designer eXperience

Just in case you think that's not something you should care about because you think governance should be strong and only care about ensuring nobody breaks the law, let's briefly talk about the consequences of not caring about this other DX.

A terrible designer experience will irremediably lead to designers not learning how to actually create good APIs, they may even loose interest in designing APIs and delegate that to the governance zealot henchmen.
It will irremediably lead to terrible APIs created by outsider experts only caring about not breaking the law and totally not caring about creating actually good APIs.
Terrible private APIs mean higher costs, increase of technical debt, less flexible IT, longer time to market.
Terrible public APIs mean not used APIs...
And in the end, people who actually care will just leave the organization that may just collapse in the end.

So, don't underestimate the importance of the other DX, Designer eXperience.
