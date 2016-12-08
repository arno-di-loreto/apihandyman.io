---
id: 412
title: The ways of the API smartness
date: 2015-03-28T20:32:18+00:00
author: Arnaud Lauret
layout: post
guid: http://apihandyman.io/?p=412
permalink: /the-ways-of-the-api-smartness/
dsq_thread_id:
  - 4867152374
category: Posts
tags:
  - Design
  - Implementation
  - Lifecycle
  - Documentation
  - DX
  - Hypermedia
---
An API must be smart to ensure that consumers will want to use it and remain dumb when they consume it.

> smart
> *smɑːt*
> 1. (of a person) clean, tidy, and well dressed.
> 2. (informal) having or showing a quick-witted intelligence.

Whether an API is dark internal, open external or everything in between (cf. [Mark O'Neil classification](http://www.soatothecloud.com/2015/02/this-week-there-has-been-great.html)), its provider (both human and application) must take whatever steps to ensure that this API (and everything surrounding it) is smart enough so the consumer (both human and application) do not need to be as skilled as the provider concerning the field of this API or what run behind it to use it.

Depending on your API and your needs, you can achieve the API smartness by using some of these ways:

- The (other) API way.
- The RTCFM way.
- The hypster way.
- The mad scientist way.
- The empathic listening way.

Diving into a single of these ways <del>could</del> will take many posts even entire books and maybe movies, and there are probably other ways.
I'm myself only at the beginning of this journey to API smartness, I'll try with this post to give you a glimpse of these ways based on what I have learned and experimented so far.

# The (other) APl way: Application Pleasant Interface
If you follow only one way of the API smartness, this is *the* way.

> Design, mock, test.
> Iterate until you get something pleasant.
> *API design mantra* 

An API is designed by humans to expose data to humans building applications and not for applications only.
An API is an *Application Programming Interface* but it should also be an *Application Pleasant Interface* ([other API acronyms](http://www.acronymfinder.com/API.html)) so the humans who build the application consuming this API do not need to struggle to understand it and its data.

So, whatever the [type](http://www.soatothecloud.com/2015/02/this-week-there-has-been-great.html) of your API, *take time to design it*.

Some directions for this *(other) API* way:

- Aim at least at level 2 of [Richardson Maturity Model](http://martinfowler.com/articles/richardsonMaturityModel.html) by using resources and HTTP protocol.
- Choose a [language](http://apihandyman.io/why-you-must-design-your-private-api-in-english/)
- Do not [expose](http://apihandyman.io/the-beautiful-api-and-the-bestial-back-office/) your back-office.
- Avoid inconsistency by levelling your endpoint, resources and error handling (standardize your API).
- Try to stick to best practices like this describe in [RESTful Web Services Cookbook](http://shop.oreilly.com/product/9780596801694.do) or [NARWHL](http://www.narwhl.com/).
- Avoid *cryptic data*, for example use human readable codes instead of puzzling integer values or at least give labels corresponding to these codes.
- Use API definition/description/modelling language like Swagger, Blueprint or RAML
- Mock your API to test it in early stage.

# The RTCFM way: Read The Consumer Friendly Manual
Even if you achieve the *(other) API* way brilliantly, consumers will probably need a little help to use your API.

> To most developers, writing API documentation is nothing short of torture. But to a few of us, it's a fascinating area. What gets us so excited? 
> *Kin Lane, The API Evangelist, [Why we write API documentation](http://apievangelist.com/2012/01/28/why-we-write-api-documentation/)*
 
API documentation must be exhaustive and consumer friendly:

- Make it human readable: so people using your APIs can actually understand it.
- Make it machine readable: so people using your APIs can build clients automatically and in the future <del>Skynet could destroy humanity</del> applications can talk to your API without someone coding.
- Use API definition/description/modelling language like Swagger, Blueprint or RAML to help you create both human and machine readable documentation.
- Beware to include all aspects of your API. A beautiful Swagger UI or equivalent documentation is sometime not enough, there are other things to document:
  - How connect to your API.
  - Rate limits.
  - Service chaining.
- Keep it light, keep it simple. Consumers do not want to read a documentation as long and hard to understand as *[In search of lost time](http://en.wikipedia.org/wiki/List_of_longest_novels)* to use your API and as difficult as *[The Phenomenology of Spirit](http://en.wikipedia.org/wiki/The_Phenomenology_of_Spirit)*:
  - Use good old diagrams.
  - Write tutorials.
  - Give code snippets.
- If your documentation is *In search of lost time* or *The Phenomenology of Spirit* type, you may have missed something in the API design.

# The hypster way: Hypermedia
This way is a subpath of the (other) API way.

![hypermedia-definition](/images/the-ways-of-the-api-smartness/hypermedia-definition.png "Hypermedia types exist to tell clients how to interact with data, not what the data means.")  
*The best definition of hypermedia* 

Adding [hypermedia](http://apievangelist.com/2014/01/07/what-is-a-hypermedia-api/) will lead your API to level 3 of [Richardson Maturity Model](http://martinfowler.com/articles/richardsonMaturityModel.html) and help consumers to know what they can do with your data on the fly.

This way could be considered experimental by some and is the subject of many debates in the API community ([read, for example, Mike Stowe's post concerning objections to HATEOAS](http://www.mikestowe.com/2014/12/more-objections-to-hateoas.php)).
But you really can use it to solve concrete problems for more informations you can read my posts concerning HAMM (Hypermedia API Maturity Model) [part I](http://apihandyman.io/hypermedia-api-maturity-model-part-i-hypermedia-ness/) and [part II](http://apihandyman.io/hypermedia-api-maturity-model-part-ii-the-missing-links/).

# The mad scientist way: Code on demand
Another subpath of the (other) API way. 

> The final addition to our constraint set for REST comes from the code-on-demand style of Section 3.5.3 (Figure 5-8). REST allows client functionality to be extended by downloading and executing code in the form of applets or scripts
> Roy Fielding,  [Architectural Styles and the Design of Network-based Software Architectures](https://www.ics.uci.edu/~fielding/pubs/dissertation/rest_arch_style.htm)

Maybe one day you'll be confronting a problem that even a good combination of (other) API, RTFCM and Hypster ways cannot solve.
This day, you should try the Konami code on level 3 of Richardson Maturity Model to gain access the the secret lost level 4: code on demand.

This way is highly experimental and I haven't use it (yet...).
You could use it for example to send a "control amount" function to the consumer to validate input on a money transfer locally and avoid some API calls.

You can read [Mike Stowe's post](http://www.mikestowe.com/2015/03/code-on-demand-today.php) about his experiments on this field.

# The empathic listening way
Last but not least, he [empathic listening](http://www.beyondintractability.org/essay/empathic-listening) way.

> One <del>Ring</del> Way to rule them all, One <del>Ring</del> Way to find them,
> One <del>Ring</del> Way to bring them all and in the <del>darkness</del> brightness bind them.
> *J.R.R. Tolkien,  The Lord of the <del>Rings</del> ways of API smartness*

This is the alpha and omega way. Whatever the ways you choose to take, you'll have to follow this way.

> Empathic listening (also called active listening or reflective listening) is a way of listening and responding to another person that improves mutual understanding and trust. 
> It is an essential skill for third parties and disputants alike, as it enables the listener to receive and accurately interpret the speaker's message, and then provide an appropriate response.
> Richard Salem, [The benefits of empathic listener](http://www.beyondintractability.org/essay/empathic-listening)

You must listen to consumers because everything cannot be perfect the first time.
You'll have to listen to them, learn from them and then adapt.
You'll also have to listen to *you* because a provider must be his *first* own consumer.

# Another classification?
In a nutshell, the ways of API smartness are:

- The (other) API way. Design a Application Pleasant Interface for your data.
- The RTCFM way. Read The Consumer Friendly Manual. Document all aspects of your API.
- The hyptser way. Add Hypermedia to explain what you can do with the API's data.
- The mad scientist way. Use code on demand to lend some of your business intelligence to the consumer.
- The empathic listening way. Listen, learn and adapt. The alpha and omega way.

![repertoire-bibliographique-universel](/images/the-ways-of-the-api-smartness/repertoire-bibliographique-universel.png "Répertoire bibliographique universel")  
*Répertoire bibliographique universel, Paul Otlet
"<a href="http://commons.wikimedia.org/wiki/File:Mundaneum_Tir%C3%A4ng_Karteikaarten.jpg#/media/File:Mundaneum_Tir%C3%A4ng_Karteikaarten.jpg">Mundaneum Tiräng Karteikaarten</a>" by <a href="//commons.wikimedia.org/wiki/User:Zinneke" title="User:Zinneke">Zinneke</a> - <span class="int-own-work" lang="en">Own work</span>. Licensed under <a title="Creative Commons Attribution-Share Alike 3.0" href="http://creativecommons.org/licenses/by-sa/3.0">CC BY-SA 3.0</a> via <a href="//commons.wikimedia.org/wiki/">Wikimedia Commons</a>.*

As I was writing this post, I was wondering if these *ways* could be used for a sort of (meta) classification/evaluation/maturity model of API and API providers including RMM, HAMM and other things... I feel like some sort of [Paul Otlet](http://www.catalogingtheworld.com/) for APIs... I'll think about it.