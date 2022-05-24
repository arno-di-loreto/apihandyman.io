---
title: The 3 benefits of creating OpenAPI-based tools (the right way)
date: 2022-05-25
author: Arnaud Lauret
layout: post
permalink: /the-3-benefits-of-creating-openapibased-tools-the-right-way/
category: post
tools:
  - OpenAPI Specification
---

Supporting The OpenAPI Specification (fka. Swagger Specification) format when creating Web API tools is a must-have.
Not for the sake of the format itself but rather because of the benefits you'll get from it. But those benefits will come only if OpenAPI is used the right way. 

<!--more-->

{% include banner-author-link.md %}

# Avoid wasting time

Taking advantage of an existing format allows avoid wasting time when creating Web API tools.
Indeed, if you need to represent or describe Web APIs, why try to reinvent a new custom format, hence a square wheel, when the wheel already exists.
It will also allow users not to waste time as they already know and use the format.

But that works at its best only if you use as many features of the specification as possible according to your context and if you extend the specification only when needed.
Supporting the latest version, which usually brings new features, may help you avoid customization.
The more complete and close to the standard, the better for creators and users.

You will also gain time when updating your tool to support newer versions by clearly viewing which parts of the specification you use and how you use it.

# Be highly interoperable

Beyond avoiding wasting time, using a standard significantly improves interoperability: the ability of software to exchange and make use of information. In this connected world where what matters is not what you own but what you connect to, using a standard such as OpenAPI opens so many possibilities for your tools that it would be a shame not to take advantage of this format.

But your tool will be highly interoperable only if it supports well the format: 

- Support JSON and YAML formats 
- Support multi-files specification which takes advantage of external references ($ref)
- Fully take advantage of all of the format features interesting in your context and only extend when needed (customization may lower interoperability)

And that must be done not only for the version of OpenAPI available at the time the tool is created.
Web API tools must support the most used versions and support the latest version quickly (don't make users wait for several years).   

# Be more attractive

An interoperable tool that can be easily plugged into an existing ecosystem becomes attractive for users.
But users will come only if they are aware your tool leverages the OpenAPI specification and how. 

So, it's mandatory to demonstrate how the OpenAPI Specification is used to create striking features. Think use-case-oriented documentation, posts, or videos. Actually, the idea is to showcase those striking features more than the specification itself. It's also essential to provide detailed reference documentation explaining which parts of the specification are used and how and which are not used for power users. That way, users know exactly what the possibilities are.

# Leveraging OpenAPI is good for everyone

Leveraging the OpenAPI Specification (or any other standards, like AsyncAPI or JSON Schema for instance) in your tools is good for you, for your users, for the OpenAPI community, and for API community in general.
So, what are you waiting for to use it (the right way)?
I look forward hearing from you and add your tools to my toolbox.