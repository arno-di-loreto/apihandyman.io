---
title: How public web APIs raise software bar
date: 2018-02-26
author: Arnaud Lauret
permalink: /how-public-web-apis-raise-software-bar/
layout: post
category: post
---

While answering some question on my [Design of Web APIs]({% include _book/meap-url.md %}) book's [forum](https://forums.manning.com/posts/list/42828.page), I wrote:

> Now that I have seen brilliant Web APIs that can be used so easily because of their design but also the overall experience some can provide (the famous "DX") I have become far more demanding and challenging with software in general

Yes. Public web APIs definitely raise software bar. The whole software industry should take example on them ... <!--more-->

# The Ideal world of public web APIs

I have been tinkering with web services and web APIs for a while now and it's really interesting how the quite technical concept of remote Application Programming Interface moved my perception of sofware from a purely technical vision to something more human centered. I switched from _code software that solve problems_ to _design software that people use to fulfill their needs_. How some companies envision providing public web APIs is even pushing this vision into _design software that people will love to use_.

How is this possible?

Willingly or in order to make profit or both, we don't care, these companies design APIs that you can understand at first sight and use easily to do what you want. But that's not all, the API comes with all needed material in order to help you seamlessly; reference documentation, tutorial, sandbox, ready to use examples, sdks, ... Everything is _designed_ in order to provide a wonderful experience with a minimal effort. Sometimes, this experience is so perfect, that you are just happy when using this API. Sometimes this experience so invisible that you feel incredibly smart because the whole system let you think that you use it instinctively.

Both provider and consumer benefits from such experience. Consumers are autonomous, don't lose time and money to use the API. They are so happy that may even promote the solution. Providers gain easily customers and lessen the need of support (or at least can focus on support where it's really needed).

Of course, not all public APIs provide such experience. And in some other domains of the software industry, we are at light years of that...

# The crude reality of not so dark corners of the software industry

Some words about me and my job: I am an architect in the banking industry...

> Nobody expects the Architect Inquisition!

... but not the dreaded enterprise architect living in his ivory tower. Throwing utopian or unrealistic edict. Burning the heretics who dare to not apply them. No, definitely not that kind. I come from the trenches, I have been a developer, a project manager, a developer team manager. Now as an architect from the trenches, I have to deal with real world problems and find real world solutions. Always striking a balance between the sanity of our IT system, people building it, people running it and people using it and of course ... money.

In my daily job, I work with a motley collection of software solutions: homemade, open source, vendor ones, as a service, on premise, ... All these software can be roughly separated in two categories: the software I choose on a shelf and the software I design.

To tell the truth, I'm getting tired of software solutions I have to choose on a shelf that are only _created to solve problems_ and not _designed for people to fullfil their needs_.
The gap between some enterprise grade software solutions and some (ideal) public web APIs is sometimes so wide that the Hubble telescope would probably not be able to see something from one end to the other. The cost of using some crappy designed solution is sometime really frightening.
When I choose a software, I mainly these criterias:

- Does it fullfil our business needs?
- How is it complicated/easy to install, run and use it?
- Does it provide an API? what's its quality?
- How does look like its documentation?

If the first question is usually not a problem, the others are too often problematic. And this is usually a huge source of problems, time losed and money losed.

# A open letter to enterprise grade vendor solutions

Dear enterprise grade software solution vendors,

When I use a public web API, I don't know what's happening behind the interface and I don't care. I can also use it easiliy. When I have to install a software on premise, I would like to have something equivalent. Of course I may have to install something and do some configuration. But please, I don't want to be an expert of your product implementation nor its installation. I don't want to lose months to install you product. Do you know that you can _automate_ many things when you use _software_? Do you know that now you can even package your solution to provide "one click" installation in some cloud services? 

When I use a public web API, you know what? I have an API to use. I would be glad if your product provide one. Having an API would definitely ease the job of making my motley collection of software work together.

When I use a public web API, I have some decent and sometimes even pleasant documentation to understand how to use it on my own. I almost never have to talk to someone to get help. So, just stop to provide totally not user friendly, huge and useless documentation that you wouldn't even use yourself. Stop selling support that you cannot afford. I have seen some product coming with a 300 pages PDF as documentation. Yes 300 pages. And that's not the most fun, this document contained some code samples... some of them 20 pages long. Unreadable. Unusable.

When I use a public web API, I sometimes can use it instinctively, because its design conforms to some common pratices. If your solution provides an API (which is a good thing), you would be wise to stick to these common practices. I do not want to have to learn you _very smart but very specific and totally different way of thinking_ to use your API.

When I use a public web API, it may evolve. Such evolution may bring some breaking change. But I am warned and I have time to handle them. I can even use the old and new version at the same time. Some provider even support _all_ past versions seamlessly. I would love do the same thing with your software.

Sincerely,
Your not future customer.

# There's light at the end of the tunnel

Is this situation hopeless? No.

In an ideal world, I would get rid of all these _on premise shitty enterprise proprietary software_ and use only software as a service with API solutions (the brilliant ones, offering an outstanding experience, of course).
But we do not live in an ideal and simple world. If such solutions to your need exist, some obstables may prevent its use: regulations, security, sensitive data, performance, legacy systems...

So beside this solution, the light at the end of the tunnel may come thanks to three things.

- First, as a software solutions designer myself, I now try to promote and create human centered solutions that are simple to build, deploy and operate by following what I've seen in the public web API space. I try to take into account _all_ users of such solutions from dev to end user and also ops.
- Second, when I choose software solutions, I always provide constructive feedback in order to help vendors enhance their solutions whether I select or reject them.
- Third, some vendors start to understand by themselves, like I did, that creating human centered solutions is worth the cost for both vendor and customer.

# But is this really new? 

Fundamentally, what we see in the public web APIs space is only what should be done with any software solution and even with any crafted thing since the beginning of all things.
Would you willingly buy a vegetable peeler that comes with a 200 pages user manual, needs 2 months for installation and is a total pain in the ass to use?
Definitely no.
Then why have we considered such experience totally normal with software for decades?
So, yes public web APIs raise the software bar, but only to the level it should have been since the beginning of time.