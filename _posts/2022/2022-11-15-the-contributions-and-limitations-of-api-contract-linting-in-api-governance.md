---
title: The contributions and limitations of API contract linting in API governance
date: 2022-11-15
author: Arnaud Lauret
layout: post
permalink: /the-contributions-and-limitations-of-api-contract-linting-in-api-governance/
category: post
---

As API governance often rhymes with “policy enforcement,” API contract linting can be seen as the panacea of API governance: it can be used to ensure API contracts conform to pre-defined rules.
But both API linting and API governance are more than that.
Let’s discover the contributions and limitations of API contract linting in API governance. 
<!--more-->

# API linting and API governance

Linting an API contract consists in analyzing its interface to “detect bugs, stylistic errors, and suspicious constructs” (like the original [linting](https://en.wikipedia.org/wiki/Lint_(software))). That can be done, for instance, with a tool called [Spectral](/lint-apis-with-spectral/) to analyze [OpenAPI](/what-is-the-openapi-specification/) documents, which contain standard and machine-readable API definitions.

As explained in previous articles, API governance aims to maximize the value created by APIs in alignment with the organization’s goals and constraints. It does this by enabling and facilitating people to work together on the right APIs in the right way. How can a linter contribute or not to that vision?

# It helps create APIs (almost) right

A linter, like Spectral, can participate in creating APIs right, following the organization’s guidelines, but incompletely. 

For instance, it’s simple to check in an OpenAPI document that:
- All schema properties are camel-cased.
- Each operation returns a successful response.
- Each operation returns the usual errors like 401 and 500.
- Error responses use the standard Error schema.

Such simple aspects will always be right once checked with Spectral (and fixed).

If we go a bit further, it is also possible to check that:
- An operation returning a list proposes pagination and search filters.
- An operation with a "search customers" summary operation is designed with the correct "search" pattern.

But this will have some limits. Most of the time, it will still be up to humans to choose the correct design pattern.
If the linter can detect it, it is at least possible to check it is fully used.

# It can’t help to create the right APIs

If a linter, such as Spectral, can more or less tell if an API has the correct look and feel, it will probably never be able to tell:
- If "name" is the right piece of data to request or return to achieve some business rules.
- If "search customers" is the proper operation to add to an existing API to fulfill some needs.
- If the "customer directory" API is the correct API to create to fulfill some local needs or to help the organization achieve its goals.

An API contract linter will never replace an API review done by human beings to ensure the API created is the right one, aligned with the organization’s goals.

# It’s a policy enforcer, a guide, and an enabler

An API contract linter can be used as an enforcer (a person or group that compels observance of or compliance with a law, rule, or obligation) enforcing API governance policies.
Linting can be integrated into CI/CD processes to check and block the build and deployment of APIs having a contract considered invalid.
But you can use it in more clever and constructive ways.

It can guide API designers if it is integrated earlier into the API design process and tools.
It will help API designers make design decisions seamlessly without losing momentum.
Designers will learn and follow the rules as time passes without realizing it.

It’s an enabler. It facilitates API design reviewers' tasks. No more hours, even days, lost painfully checking that all property names of all schemas are camel-cased.
They can even create more fine and custom rules to detect patterns that should be discussed during an API design review.

# Not the panacea, but still quite helpful

So, API contract linting will only take care of some parts of API governance, but what it can do is pretty interesting.
It helps to create APIs almost right, sharing a similar look and feel.
As a last resort, it can be the guardian before deployment, but before that, it can be a teacher, guiding API designers and facilitating the work of API design reviewers.
