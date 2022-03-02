---
title: Underestimated and unexpected IT challenges of API initiatives
date: 2022-03-02
author: Arnaud Lauret
layout: post
permalink: /underestimated-and-unexpected-it-challenges-of-api-initiatives/
category: post
---

As an IT member, you convinced your boss that APIs were a thing and IT department should take them seriously.
Congratulations! 
That's good, very good.
Not only for you and your IT but for your whole organization.
All you need to do now is choose an API gateway solution and you're done...
So you think.
The API journey, even just at IT level, is full of pitfalls. 
<!--more-->

# IT is often where APIs start

There are still plenty of companies, government agencies and various organizations that didn't yet really took the API train.
But when they finally take it, it's often thanks to some IT initiative.
Because, hey, APIs originally are software stuff.

IT led API initiatives are not always perfect, but they can lead to not so minor and cool enhancements, and even initiate an organization's total transformation, making it truly API-First.
Indeed, at worst taking APIs seriously at IT level will make your IT systems become modular, make them capable of fulfilling new needs easily, achieving faster time to market.
And at best, some IT people can start to advocate at business and exec level that APIs could be worth of interest outside of IT.
When those people hear that company could make more business with APIs, they may listen, they may be contaminated by the API frenzy.
But that's another story.
Let's just focus on the challenges that can happen when a company's IT start to take APIs seriously.

# Some challenges

I'll share here what I've witnessed myself on various API journeys.
This post is not intended to be exhaustive and provide solutions to all challenges.

## API management setup and management

When someone says APIs, API management vendors come out of the woodwork, promising wonders.
Their API management solutions will solve all of your organization's API problems so easily!
Since you were not born yesterday and you know that magic-software-that-solves-all-problems don't exist, you guess it could be a little bit exaggerated.

But what you may not realize is that even if API management solutions can actually help you to expose securely your APIs and manage their consumers.
Also possibly gave you an idea of your existing APIs through the provided developer portal (well, once those APIs have been exposed on the gateway).
Integrating and managing this solution can be far more complicated than you thought in the beginning.

Who will be allowed to develop on this solution? 
(Yes, you'll need to develop on this solution).
How to manage this solution lifecycle? (It will need to be updated regularly).
How to connect it to your identity providers?
How to connect it to CI/CD to automatically expose interface contracts?
How to ensure that only API owner can actually deploy their APIs throught CI/CD?
Will there be a single or multiple instance of API gateway(s)?
Will there be a single API management solution or multiple ones?
By who and how consumers will be managed? (defining which application can consumer which API)
How consumers will get their credentials securely (and possibly automatically)?
How will they be securely renewed regularly?

Nothing unsolvable, but better study well this matter to have all aspects in mind when starting the API management part of your API initiative.

##  Ensuring existing systems capacity and security

Let's APIfy this system!
That means, let's add more load on this system which was quite protected in the guts of our IT. 
Very often, APIs come as an addition to the load of a system, so better triple check the current status and if the system can absorb the new load without failing.
That may also open systems that were quite protected, are you sure those new APIs don't create security issues?

## Acquiring API design skills

APIs are originally an IT matter.
We, the IT, have been connecting pieces of software together for decades.
So, obviously, we know perfectly how to do APIs, and how to do them well.

While it can be sometimes true, it's more often false.
Not that people are totally bad at designing APIs, systems are actually running well.
But those APIs are technical connectors usually requiring a high level of expertise of the underlying system.

Most of the time there's not much work to do, a few design reviews a bit of training and hello beautiful APIs.
People magically realize the value of working on design (and icing on the cake it can have huge impact on code and architecture quality).
But sometimes, changing mindsets on the importance of design is really hard because some developers/tech leads/architects are quite stubborn to stay polite.

Also a side note, I can understand that seasoned developers never having seen another company for the last 3 decades may not be aware of the importance of designing an API to make it easy to understand and easy to use, or may not know how to do it.
But I'm quite annoyed to see that university/engineering school absolutely don't teach API design, at least in France (don't know if this matter is covered by boot camps or in other countries).

## Avoiding dictatorial governance

Creating consistent API is important for usability and security among many other things.
That requires defining rules and organizing a bit of controls, all that can resumed in two words: API governance.
If care is not taken, it can turn really bad in scary dictatorship, everyone fearing the API police.
It can totally screw your IT led API initiative and cripple the future business led API initiative.
If you want to learn more about this, [watch my "Human Centered API Governance" session](/human-centered-api-governance/).

## Including API design in software lifecycle

When I was conducting API design review, I can't count how many times I received a "can you check this design please, we push it in production tomorrow" email.
Not only IT people will probably need to acquire design skills but also modify a bit their software lifecycle to include a design phase BEFORE development.
It can be complicated when people are doing "agile" development (yeah "agile", because it can be anything and everything).
Not because of process, but because it requires to change habits, change mindsets, just like on design.

Honestly it's quite simple as long as you don't fall into the "Big Design Up Front" ([thank to my colleague Kevin for putting a name on something I couldn't name](https://swiber.dev/launch-a-winning-strategy-for-api-design-first#big-design-up-front)) and ruin agile efforts.
Adding a short design phase during the sprint before development or right at the beginning work pretty well (it takes only a few hours).

## Acquiring provider and consumer stances

When starting the API journey, even just at IT level, you have to realize that to create good APIs, they must be own by someone.
And those API owners have to acquire the provider stance.
I've seen teams so used to say yes to everything, resulting in highly specific software only working for the team requesting the evolutions, they continue to work the same way with APIs.
That must be changed.
API owner must learn, not to say no (well sometimes it's needed), but to take request and put them in place for the greater good of their API product and ALL of its present and future consumers.
On the other side, API consumers must learn to request new features without going crazy if it's not exactly made as they would have imagined.

## Making business and IT work together for a bright public API future

And last but not least.
Purely IT led API initiative, without any business perspective involved will only succeed to put a technical infrastructure in place.
One way or another people having business knowledge, subject matter experts (SMEs) must be involved when defining the boundaries of APIs, what they do and how they do it.
Both perspectives, IT and business, must be taken into account to define APIs that literally represent "this domain for dummies" (and we don't care if those "dummies" are inside or outside the organization).
Those APIs must be easy to understand and easy to use by anyone, reusable in various contexts, and easy to evolve.

If you don't do that, what do you think will happen when some high level business exec realizes the importance of APIs from a business perspective and take for granted that if IT has done APIs they can be provided easily to the outside world?
They will not be happy, but more than that, a huge part of what was invested in the IT led API initiative will have been done for nothing.
The company will lose time and have a longer time to market

# Oops, I did it again

Even when I try to talk about API from an IT perspective, I can't do it without talking about their business perspective and their impact on organization.
That's because even if there are purely IT challenges, in the end, an IT led API initiative can benefit the whole organization from a busines perspective.
It's because APIs (and IT in general) and business are totally intertwined, that's the spirit of being API-First.

