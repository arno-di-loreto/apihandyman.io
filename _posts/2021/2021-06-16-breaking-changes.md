---
date: 2021-06-16
author: Arnaud Lauret
layout: post
category: post
permalink: /handling-breaking-ch-ch-changes/
title: Handling breaking ch-ch-changes
---

In (Ch-ch-) Changes, David Bowie sang "Every time I thought I'd got it made, it seemed the taste was not so sweet", that's a good metaphor for API design.
An API will irremediably evolve because it will lack some features or because of mistakes, and so sooner or later, you may have to introduce a "breaking change".
That's usually when people start to run in circle, scream and shout "Oh! Please no! Please, not a breaking ch-ch-change".
But, what is it actually? How to handle it? And should you always be afraid of it?

<!--more-->

# What is a breaking change

A breaking change is non backward-compatible modification that requires consumers to modify their code in order to continue using an API (or at least modify the part of their code using the modified part of the API).
There are many different ways to introduce breaking changes in APIs, some are obvious, some are not.

The most common obvious way to introduce a breaking change is to rename or remove something in the interface contract.
Rename `GET /usrs` to `GET /users` or remove the `isAdmin` property from the User data model and there's a huge risk that it will break some if not all of the API's consumers.
There are also less obvious interface contract's breaking changes. Turning an optional parameter into a required one or adding new values to enumerations that consumer is supposed to interpret. And there are even less obvious and far more treacherous breaking changes:

{% include quote.html 
    author="Hyrum Wright"
    source="Hyrum's Law"
    url="https://www.hyrumslaw.com/"
    text="With a sufficient number of users of an API, it does not matter what you promise in the contract: all observable behaviors of your system will be depended on by somebody."
%}

{% include image.html source="xkcd.png" caption="XKCD: Workflow" url="https://xkcd.com/1172/" %}

A breaking change can happen without actually modifying the API's interface contract.
Change a business rule so that given the same conditions a user's "asshole level" is set to orange instead of green when analyzing their last comments and that may break something. 
Pushing the concept to the extreme, that also means some consumers could depend on an API's long response time and optimizing the API's implementation to make things go faster on provider's side could put them at risk.
That's probably going a little bit too far, but keep that in mind, just in case.

So a breaking change is a change that could literally break something on the consumer side.
That does not sound good but is it actually always that bad?

# Evaluating the cost of breaking change

As an architect, my favorite answer to any question is "it depends".
And in that case, it applies yet another time.
Depending on the context, the cost of a breaking change vary.

If the API is in early stage and not even yet consumed, you can break whatever you want without even thinking about it.
If the API is consumed only by a single application that you build yourself, you can most probably do it with not much work.
On the opposite, if the API is consumed by many consumers that are "far" from you, another team, another business unit or worse partners or customers.
The cost will be high.

The less consumers and the more you control them, the less will cost a breaking change. 
The more consumers and the less you control them, the more will cost a breaking change.

# How to avoid it

Before requiring consumers to update their code, maybe you should think twice and find a way to avoid that.
Here are 3 ways to more or less "avoid" introducing breaking changes.

## Don't do it

First, triple check that you actually desperately need to make this breaking change.
Evaluate the value it brings versus its cost.
You want to fix some mistake (like a typo or a terrible name) to make a perfectly clean API?
That's nice but probably counter-productive, perfection is not of this world, especially in API design.
Live with it for the time being, you may be able to fix that when introducing actually awaited new features that your consumers will be totally crazy about.
In the meanwhile, you may try to limit problems by improving the documentation if that help.

## Make it backward-compatible

If there are good reason to introduce this change, maybe there's a way to make it in a non-breaking way.
The usual strategy to do that is only to "add" in a clever way.

Instead of modifying an existing operation, you may simply add a new one.
Why not adding a `POST /administrators` instead of modifying `POST /users` to introduce the new administrator user type?
On the inputs, always add optional properties/parameters with default values.
Let's say you have a "create user" features and want introduce different service level (regular vs gold).
Instead of required `serviceLevel` that will hold `regular` or `gold`, set it optional with `regular` as default value.
On the output, it's simpler, just add, it doesn't really matter if the new data is always returned or not.

There's more often than not a way to turn a backward-incompatible change into a backward-compatible one, it may not lead to the best design but sometimes you have to make compromises.

## Use breaking change proof design

The third way to avoid breaking change is a little bit different: it's about to preemptively ensure that breaking changes have less risk to happen by choosing a breaking change proof design.

You can work on data types, avoid using booleans or arrays of atomic (string, number, ...) for instance.
A `isAdmin` property is less extensible than a `role: "admin"` one, indeed, there may be more roles than admin and non admin users in the future.
Which is less extensible than a `roles: ["admin"]`, because a user may have more than one role in the future.
Which is less extensible than a `roles: [{ type: "admin"}]`, because a role may need more features such as a start and end date for example.

You can work building self sufficient features by adding data or new operations.
When accessing a user, consumer may need to know what their role mean, at the beginning they can hardcode that an admin user can do everything while a non admin one can only read data for example.
But if you provide the role description along with its type, you may seamlessly introduce new user types.
When creating a user, consumer need to know the available types of user they can create, they can hardcode that based on an enumeration provided in your documentation or they could call a `GET /userTypes` and get up to date data.

And last but not least, you can also lessen the risk of breaking changes by hiding as much as possible what happens inside your API, inside your domain.
The less the outside world know about your internal business rules and way of working, the less coupled with consumers you'll be.

# How to handle it

When the breaking change cost is low or when it is unavoidable even though its cost is high, you have to actually handle it.
Here are a few good practices and tips to have in mind in such a situation.

## Synchronized modifications

The most simple way to handle breaking change is to synchronize modified API and consumers deployment.
This strategy will only work when you have full control on consumers.
While it is fairly easy to do that with a web application, it can be more trick for rich clients such as mobile application as end users may not want to update them if they are not forced to do it.
My rule of thumb: always implement a "force update" in your mobile application, let it check regularly or at startup if it is still up to date and if not refuse to start and request update to user.
That will allow you to synchronize its update with the underlying API. 

## Wait for the right moment

A corollary to the "make it backward compatible even that is not totally clean" strategy is to wait for the right moment.
I always recommend to the team I work with to let their API live and evolve possibly introducing API design compromises.
Then after a while, once they have sufficient experience with the domain of the API and if there's a killer new feature to introduce, that's the right moment to clean all this mess and break everything.

## Create a separated new API and migrate (or not)

Breaking everything does not actually mean removing the previous version of the API.
You can create a new one and then request consumers migrate to the new version.
There are many things to say about that, we'll talk more about API versioning and its implication in a later post.

## Include breaking change policy in your terms of services

And last tip, don't forget to include your breaking change policy in your terms of service: how you define a breaking change, when you'll warn people about an upcoming one and how long time they'll have to migrate to a new API version if they have to.
Depending on your context, you may not want to let consumers stay on an outdated previous version for too long but think about their context, below a year could be tricky for many consumers as their budget are annualized.

Note while that's a must have for a public/partner API that you sell to people outside of your organization, it that could be interesting to define terms of service including such policy for your private APIs too.