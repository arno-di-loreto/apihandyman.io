---
title: Analyzing a software solution from an API perspective
date: 2021-09-15
author: Arnaud Lauret
layout: post
permalink: /analyzing-a-software-solution-from-an-api-perspective/
category: post
---

I regularly participate to CFP (Call For Proposals) aiming to choose a software solution.
My role is to analyze solutions from an API perspective.
And I do that even if there's no specific API concern regarding the context in which the CFP is made.
Why doing so and what to look at?
This should be of interest for people having to choose a solution but also to people proposing them.
Indeed, some (corporate) software solution vendors should take this seriously ...
Unless they want to finish at the bottom of the list. 
<!--more-->

# Why systematically include the API perspective

Before explaining what to look at when analyzing a software solution from an API perspective, maybe we should talk about why doing so even when there is no obvious and/or specific API concern.

Most companies having IT systems couldn't build those IT systems without APIs.
Indeed, most IT systems are composed or more than one brick, more than one software solution.
Some of them being built, some other being bought and deployed on premise or used as a service (SAAS).
But either built or bought, installed or used as a service, a company will have to connect all these pieces of software together.
And what can be used to connect all these pieces across a local network or the internet?
APIs.

Oh, some may think that this new piece of software, especially a SAAS one which magically solves some needs, will be used totally independently from any other of the IT system's bricks.
And that may actually be the case ... in the beginning.
But in the end, for one reason or another it WILL need to be connected to other pieces of software. 
It's not a risk, it's a certainty.

And if that solutions does not provide APIs ...
That may hinder severely an important project, critical for the company.
A pity as one of the competing solutions seen during the CFP 2 years ago actually provided APIs ...

# What to look at

Note that this post is based on my "corporate solutions" evaluation experience, you may find totally unexpected elements that would be total science fiction for true API companies like Twilio or Stripe.
So, here are the various topics I look at when analyzing a software solution from an API perspective:

- Are there APIs?
- What is the quality of documentation?
- What is the quality of the design?
- How the API is secured?
- Do the APIs cover 100% of features?
- Can the APIs fulfill hypothetical needs?
- What is the overall developer experience?
- What is the pricing model?
- What are the terms of use?
- Does the company shows an API Mindset?

## Are there APIs?

Very first and obvious verification: is there one or more APIs coming with the solution?
That looks like a dead simple question, but you can't imagine how it is difficult sometimes to verify this.
Sometimes, it's because the information is deeply hidden somewhere on the company's website.
That's why my first move is simple to google "company name API".

But it's not that rare to look at (or google) the company's website or product's webpage and find absolutely no information about APIs.
And there are 2 reasons.
First one, there's absolutely no API at all.
That puts the company to the bottom of the list.
Second one, there are APIs, but you can't see them unless you ask the sales people.
That's really annoying, and will make the company loose points in the rankings.

## What is the quality of documentation?

A good API documentation is not only a documentation that explains what you can do with the API (use case documentation), what are all the available operations (reference documentation), or how to get an access token.
A good API documentation starts by being at least visible publicly!
That sounds crazy right?
Unfortunately what we're used too with most API companies is not yet that obvious for many companies providing corporate solutions.
Having to contact sales to get an access to documentation is really annoying (and that makes you loose points in the rankings).

And beyond access and content, the form is important too.
I prefer to get a bare Swagger 2.0 (OpenAPI 2.0) JSON file sent by email than an indigestible PDF accessible on the website.
Actually, a documentation that does not comes with a standard OpenAPI (or Swagger) file is quite annoying for me because I need it to make some automatic controls on the design.

## What is the quality of the design?

Having access to the documentation I can evaluate the quality of the design.
Does it respect common practices, it is easy to use, easy to understand.
I practically do an API design review, I'm not looking for perfection but just a good looking API.

## How the API is secured?

What I want is APIs using state of the art security mechanism.
Unfortunately, some companies don't seem to care about security, providing good old basic authentication for instance.
And that puts the company to the bottom of the list.

## Do the APIs cover 100% of features?

Once I know what the API is capable of, I can check if it actually cover 100% of the product features.
It's not that rare to see solutions that propose APIs only covering a subset of all of their features.
That could be a real problem unless the company shows a roadmap to achieve the 100% (but beware of promises...).

## Can the APIs fulfill hypothetical needs?

Once I know what the API does (thanks to the documentation), I can imagine some hypothetical but realistic needs that would require to connect the solution to others.
I speak with the business people involved in the CFP to get some ideas.
Then I evaluate if it's possible and the complexity of such project (if the product lacks of useful APIs/operations you may have to do a lot of work for a simple project).

## What is the overall developer experience?

Doing all that (checking documentation, analyzing design and imagining hypothetical needs), I'm able to start evaluating the developer experience.
If doing all that was simple, the experience is good, if not, the experience is terrible.
When I see a company providing a state of the art self-service developer portal, that's a total nirvana (that doesn't happen often unfortunately)
Being able to actually test the API at this stage is a plus (even if there's no true dev portal).

## What is the pricing model?

When evaluating a solution's API, you have to look beyond the API itself and especially how much it would cost to use them.
That's probably the most difficult information to find when dealing with corporate software vendors: it's almost never shown publicly.

Be aware that most of the time, especially for SAAS solutions but also for on premise (totally crazy!), using the API is not included in the pricing proposal (because the request sent for the CFP usually don't include the API perspective).
Using the hypothetical needs, you should be able to get an idea of what could cost using the solution's API.

## What are the terms of use?

Another thing that is really important to check is the terms of use.
I check what is the API evolution policy (how are handled breaking changes, the delay to update).
There can be too strict limitations regarding the number of API calls, making the solution to your hypothetical needs highly complex to build because you would need to add some cache systems for instance.
But my concerns are not only technical.
For instance a software solution may grant you access to some data that you can't resell without a huge bump on the bill.

## Does the company shows an API Mindset?

And finally I evaluate the company's API mindset.
I prefer a company publicly showing it's work-in-progress-well-designed API than a company hiding its mess hoping customers will not notice it before it's too late (and that actually exist, I put them to the bottom of the list).
I love when a company actually communicates about its API strategy or its roadmap, it's not mandatory to actually talk about APIs you just need to show that you want to be part of an ecosystem, that your products can easily be connected to others.

# Analyze this

For those who have to choose solutions, I hope you found that interesting and that it will help you to choose the right solutions from an API perspective.
For solution vendors, now you know what puts you to the bottom of the list when you see me on a CFP (and so, how to avoid that).
