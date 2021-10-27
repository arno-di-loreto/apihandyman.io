---
title: We are not Amazon or Github, but maybe we should ... or not
date: 2021-10-27
author: Arnaud Lauret
layout: post
permalink: /we-are-not-amazon-or-github-but-maybe-we-should--or-not/
category: post
---

One day I can say "Amazon did that, we should do it too" and may be quite displeased to hear "but, we're not Amazon".
And the next one, I can be quite displeased to hear "Github did that, we should do it too" and respond  "it's not because Github did it, that we should do it too". 
Why such inconsistency?
<!--more-->

# Why we should be like Amazon

Almost 20 years ago (😱), in 2002, Jeff Bezos, now former CEO of Amazon, sent a mandate to all Amazon employees.
This mandate is one of the centerpiece of my API conference bingo with Conway's law.
In substance, it was saying 2 things:

- All teams MUST communicate through "service interfaces" (they were not called API at that time)
- All those "service interfaces" MUST be design from the ground with externalization in mind. Each one could be put in customers hands at any moment after its creation.

While there's not much debate about "APIfying all the things" in 2021, the second item is the one that usually triggers the "but we're not Amazon" remark.
It actually means you make no difference between internal and external API.
Why should you do that and not keep creating highly specific/ugly/terrible internal APIs or use different look and feel for internal vs external APIs, and only work hard on public APIs? 

There are many reasons, here are a few of them:

- Sooner or later, you'll provide APIs to "others": some external contractors, the team next to you, another business unit, a partner, or a customer. It's not a possibility, it's a fact.
- That'll improve your internal API quality: Thinking that someone outside of your organization will consume your API can help people to actually focus on its design and really make it usable by anyone.
- That'll reduce the risk of public API failure: You'll learn by working hard on private APIs, if you wait to go public to learn, you'll regret it; nobody will want to use your terrible APIs.
- That'll reduce your time to market: It'll take a few seconds to go public with a clean private API while it may take weeks if not months to rethink/clean/hide the mess before exposing it to the outside. And that could impact not only the design of your API but also its architecture.
- That'll ease maintenance: It's not that easy to make a single API and its implementation evolve but imagine the same implementation exposed 2 times. That multiply problems by 2.

So, that's why I say "we should do like Amazon", we should treat private APIs like public APIs and actually only create one and use it in both contexts.

Note that this famous mandate ends by "those who don't do that will be fired", that's level 0 of management. 
Threatening people like this is totally stupid and MUST never be done.
In this case, it's even more stupid because this idea is just brilliant.

To read more about the memo and how it went public, you should read this [post of my good friend Kin Lane, the API Evangelist](https://apievangelist.com/2012/01/12/the-secret-to-amazons-success-internal-apis/).
I suggest you read also Jeff Lawson's "Ask Your Developer" book, the first chapters do a great job in explaining this "API all the things" spirit and the origin of the mandate (and though I didn't finished it yet, that's a great book).

# Why we shouldn't be like Github

Ok, we "should do like Amazon", but why be not be like Github and do GraphQL APIs?
In 2016, Github announced their [GraphQL API](https://github.blog/2016-09-14-the-github-graphql-api/).
That obviously triggered many "Github is doing GraphQL API, let's do it too".

In such context, I ask "what problem are you trying to solve?".
Do you have ten of thousands consumers doing gazillions of API call combinations?
Do you have a product that people basically need to address like a database?
No?
And do you understand the implication of providing a GraphQL API regarding security, performance and scalability?
No?

Then, maybe you should stick to a good old REST API.
I'm not against GraphQL, it's there in my toolbox, but I will only use it if that's a relevant solution to a clearly identified problem.
That's why I say "We're not Github".

# The 42 answer of architects: it depends

As you can see, I'm not just saying we should or shouldn't do like Amazon or Github.
We can't just decide to do something because some company has done it.
We can't just decide to not do something because (we think) we're completely different from some company who has done it.
The question is not "should we do like X" but "should we use the same solution as X to solve a problem in our context".
Behind any choice, there must be a context, a problem, a reasoning, not just blind and thoughtless hype.

PS: If you wonder what's this strange Stackoverflow keyboard on this post's banner read [this](https://stackoverflow.blog/2021/09/28/become-a-better-coder-with-this-one-weird-click/)