---
title: 7 ways leading to wrong ownership and killing APIs
date: 2021-03-28
author: Arnaud Lauret
layout: post
category: post
permalink: /7-ways-leading-to-wrong-ownership-and-killing-apis/
---

After hundreds of API design reviews, I can tell that the most neglected aspect of API governance is ownership.
Unfortunately, that's probably the most important one.
Without true ownership, your APIs will probably be totally wrong.
Without true ownership, your employees will be terribly sad or leave.
Without true ownership, your company may even die.
As an API design reviewer, I believe that my role is also to warn the teams I'm working with about this topic and help them to fix the problem.

<!--more-->

# Ownership done wrong

In this post, I'll share with you 7 ways leading to wrong ownership that I have actually witnessed. 

## Letting consumers dictate their will

That's a very classic one.
After decades of building point to point web services that serve for highly specific needs and highly specific consumers, teams may be tempted to go on as before and just say yes to every single request of any consumer resulting in non reusable and totally bloated APIs.
In such cases, it's often hard at the beginning to switch to a true API provider stance and be the actual owner of the APIs.
You'll have to make consumers understand that as an API provider you can't just make an API only for them exactly as they wish.
Reversing roles, and so becoming the true owner, is often a simple matter of explaining that _who can do more, can do less_ and that your more generic API design is actually able to fullfil many specific needs.

## Mapping API to micro-organization

It's not unusual to have a business domain split across different small teams, each one working on a specific part because of process or technology.
The problem is that some may be tempted to build an API per team resulting in many micro-APIs.
By doing so you may needlessly expose your internal organization (who said Conway's law?) and build micro-APIs that are worthless without each others.
For example, if a team works on the "Customer Creation API" and the other one on "Customer modification and read API", it will be cumbersome to use those 2 APIs if that separation does not make any sense from a business perspective and even more if most consumers actually need both set of operations.
In that case, you'll have to find organizational and technical ways to expose and maintain a unified API façade that will be meaningful for consumers.
That especially means that ownership encompass the 2 subsets of operations.
And by the way, that could be a signal that your human organization is not the good one.

## Not being the golden source

In big companies replicating data is unfortunately very common, not all companies are aware of Jeff Bezos mandate (which basically says do APIs for between team communication or you're fired).
That means that more often than not, data is replicated and sometimes enhanced the same ways dozens of times.
At some extent, some team may be tempted to expose APIs providing data they don't actually own.
Depending on whom these APIs are exposed to that could be a real problem.
If it's just a quick win used inside a team while waiting the true owner build they're own APIs that could be OK.
If not, data officers and even actual provider may not really happy with that.
But most important, not being the actual owner, the team building the API may not work enough on design and just build an ugly technical connector because they don't really care about it.

## Outsourcing implementation

I have never seen a successful API resulting from owner delegating implementation to someone else.
In best cases, there's so much delegation that owner don't actually own the API, it's designed in a totally independent and usually bad way.
In worst cases, the owner may have strong views on how the API should look like (and that's totally normal) but these views are not shared by the people who will actually build the API resulting in conflicts and the API is not released before the owner actually find a way to be able to build the API themselves.

## Delegating design to developers without business knowledge

I can't count how many times I had to work on API design reviews with developers without business knowledge.
That's terrible for API design because they are unable to answer my business oriented questions and make decisions.
API design is not really a matter of POST /this and which database is used underneath, it's first and foremost a matter of needs and business rules.
An API must be owned by both business AND developers, they must work together on design.

## Delegating API stuff to center of expertise

This one is quite close to previous case.
As APIs become more and more important for companies, especially big ones, they're tempted to build an API center of excellence or any other type of structure concentrating all API related expertise.
If that leads to teams fully delegating APIs building to these experts, that will only lead to terrible APIs as if those experts actually know how to build and design APIs, they probably know nothing of the business domain.
A center of expertise should only exist to help, empower and train non-experts in order to make them self-sufficient on a new topic.

## Suffering from dictatorial API governance

And last, but not least, a dictatorial or even just a little bit too strong governance has a subtle but terrible effect: it inevitably disempowers people, takes API ownership from them.
Why?
Simply because, having extremist API design reviewers that actually don't help people design their API but just yell at them and actually constrain them so much that they can't design anything themselves lead to only one thing: "OK, Mr Inquisitor, design it for me, so I can move on and deliver my stuff".
Not only people loose ownership but they also loose the will to learn and improve, the consequences at scale for the company will be terrible.
People who actually build APIs will not grow their expertise (and be sad or leave).
And the resulting API will be of low quality, probably less usable, reusable, evolvable.
In the 21st century, I believe that it that could kill a company in the long run.

# What ownership actually requires

So how to be sure that an "organization" actually is the true owner of an API?
It must:

- Be the actual owner of data, services, domain, components
- Represent a meaningfull business domain leading to meaningful and self sufficient API(s)
- Know domain from business perspective
- Kown domain from technical perspective
- Be able to design (maybe with some help but without over delegating)
- Be able to make decisions
- Be able to actually implement

An "organization" can be a team or a group of teams but be warned that making different teams working together may not be that easy, maybe you should rethink your human organization to solve that problem.

