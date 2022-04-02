---
title: Why do we need API design guidelines?
date: 2022-02-23
author: Arnaud Lauret
layout: post
permalink: /why-do-we-need-api-design-guidelines/
category: post
---

Why do we need API design guidelines?
Why do I need this boring set of constraining rules telling me how to design APIs?
Why can't I design APIs the way I like (which is the best one by the way).
What would I (and my organization) gain taking advantage of API design guidelines?
<!--more-->

_That's yet another interesting question coming from the Internet, if you have such API questions don't hesitate to ping me, I may be able to respond through a blog post._

# Consistent APIs

The first reason why you need API design guidelines is to ensure a certain level of consistency throughout your whole API surface.

Creating consistent APIs, APIs that share the same look and feel, is key to build a great developer experience.
Indeed, once someone has learned to use one of your APIs, using another one that looks and behaves in the same fashion as this first API is fairly easy.
Just like when you use any app on your smartphone, they share common behaviors of the operating system.
Just like when you use a mobile app, desktop app or website of a given company, those different "applications" in a broad sense share a look and feel defined by the company providing those services.
With consistency, you can speed up learning, people can guess how things work.

If you think that achieving consistency in API design can be done without really thinking about, without defining rules, let me tell you about a simple exercise that I do when teaching the fundamentals of (REST) API design.
I love this exercise, because it never misses to make attendees realize they definitely need API design guidelines to design consistent APIs.
I ask the attendees to choose the paths to represent a "list of users" and "a user", the only constraint is that those paths must be valid from a REST perspective, hence being able to represent a resource in a unique way.
We often end with the following responses:

- `/users` and `/users/{userId}`
- `/users` and `/user/{id}` ([seriously don't do that](https://apihandyman.io/resources-rules-and-resource-sucks-or-is-it-the-other-way-around/))
- `/user` and `/user/{userId}`
- `/user` and `/user-{reference}`
- `/utilisateurs` and `/utilisateurs/{referenceUtilisateur}` (that's french)

All those path are technically valid from a pure REST perspective, each one allows to represent the list of users and a single user.
They are technically valid but each response is different from the others, these solutions are inconsistent.
Even people working in the same organization working on the exact same use case can achieve inconsistent designs. 
That's why you need API design guidelines.
They are many possible variations when having to design API, you need to choose a single way to "style" your APIs and write it down in your guidelines.

# Less discussions

But what is the "right" way to represent a "list of users", `/users` or `/user`?
I have an [opinion](https://apihandyman.io/resources-rules-and-resource-sucks-or-is-it-the-other-way-around/) on that topic, you may have another one.
Without having settle this debate once and for all, be prepared to face endless debates about very basic API design concerns such as this one.
Seriously, it's not fun to waste time on such discussions.
I prefer `/users`, but if the guidelines created before I arrive in the company say it's `/user`, so be it.
What really matter is what the API does, that's on that topic we should "waste" our time, not choosing between turquoise and cyan.

But that does not mean you should never discuss guidelines.
Honestly, if the guidelines if my company says `/users` and `/user/{userId}` which is a total non-sense, leading to poor DX, we'll have to discuss that again.
But be professional, if the existing rules are just different from what you're used to but make sense and create consistent APIs, don't be an asshole, accept difference.

# Simpler API design

Not all designers are seasoned one, not all designers have been working in the organization for years.
Without guidelines, beginner designers will, at best loose their time chasing the response to the question `/users` or `/user`, or which HTTP status code use in "that" context, and at worst, randomly choose a way of designing APIs based on today's humor.
[Well-structured-designer-friendly API design guidelines](https://apihandyman.io/nobody-cares-about-api-design-guidelines/) accompanied with a touch of automation (who said [Spectral](https://apihandyman.io/toolbox/spectral/)) will speed up their learnings of the way of designing APIs in general and in your organization.

And guidelines are not only of interest for beginners. 
Seasoned designers may also loose their time looking for solutions to complex problems such as "how to handle long operations" or "how to handle gateway message size limitations", problem which could be solved once and for all and put into the guidelines.

# Simpler API design review

API designer reviewers are masters in API design able to spot the tiniest "imperfection" in a design, a not so clear naming, a design pattern that could cripple evolutions, ... (Actually API design reviewers a far more than that, but that's another story).
But just like designers, though being "API Design Jedi Masters", reviewers can be new to the organization, they can forget some specific point.
So having a source of truth to refer to is a great help for reviewers to comfort their reviews and also having pacified discussions with designers (because "sorry, that's not what you're used to, but this is how we do here").

# The source of automation

And last but not least, I mentioned automation (API design linting) with [Spectral](https://apihandyman.io/toolbox/spectral/)): API design guidelines will be the source of any automated control of API design.
Jumping right into writing some code controlling your design conforms to your organization's way of designing APIs is a terrible idea.
It would be just like writing an OpenAPI document, focusing on `GET /this` and `POST /that` without being sure of what the API is supposed to do, without being able to describe in natural language the needs that the API must fulfil.
Also, even a must have in your toolbox, tools such as Spectral, will not be able to capture all that you can put in your design guidelines (such as when choose solution A over B).

# You need API design guidelines

So the question it not really "do you need API design guidelines?" but "what are you waiting for to create API design guidelines?".
It's never too late to do so, indeed, you can create guidelines even when you already have existing APIs.
But that's another story.