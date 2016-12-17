---
id: 196
title: Why you must design your private API in english
date: 2015-02-07T20:21:47+00:00
author: Arnaud Lauret
layout: post
guid: http://apihandyman.io/?p=196
permalink: /why-you-must-design-your-private-api-in-english/
dsq_thread_id:
  - 4866765229
category: Posts
tags:
  - Design
---
> Why you must design your private API in english.  
> Pourquoi vous devez concevoir votre API privée en anglais.  
> Perché è necessario progettare la vostra API privata in inglese.  
> Por qué debe diseñar su API privada en Inglés.  
> Deshalb müssen Sie Ihre private API in Englisch entwerfen.  
> なぜあなたは英語であなたのプライベートAPIを設計する必要があります.  

As you might have guess, this post targets people designing APIs in non english speaking countries.
When you design an API there are many little things that you risk to forget or not take into account, especially when this API is private/internal, and later you may bitterly regret it.
*Choosing* a language for your API is one of them.<!--more-->

# The eNut project
You work for *Complètement Noix Cie* (*Totally Nut Co*) a small family nutgrowing company in France.
This company launches the project *eNoix* (*eNut*) based on patent [US 2427486 A](http://www.google.com/patents/US2427486) which will cut nuts collection costs by 300%.
You have to design a private API to control and monitor this totally awesome device. You'll have to deal with nuts, squirrels and .... Wait! Stop!
Before designing anything you have to choose a language for your API.

# Choosing a language to design an API?
I'm not talking about internationalization or choosing a programming language ...
I'm talking about choosing a human language for the interface: english, french, italian, spanish, german, japanese... 

> Jean-Philippe wants to get a list of squirrels, how does he get it?  
> GET /squirrels  
> GET /ecureuils  
> GET /scoiattoli  
> GET /ardillas  
> GET /eichhornchen  
> GET /リス  

The choice should be quite simple because this should be a single-choice question instead of a multiple-choice question.
The only possible response should be english.

The only possible response **IS** english.

> But this API is private and will only be used by squirrels or us or people understanding our language. Why should we care to design it in english instead of (whatever language you speak)?  
> *(me some time ago, I could just kick myself)*

There are two reasons rhyming with "*ization*": standardization and externalization.

# Follow the standards
> Stop building super custom APIs.  
> *([Steve Klabnick](http://www.steveklabnik.com/), API Days Paris 2014)*

Even if your API is private, it must be *standard*, the more your conform to standards the more your API is simple to design and to use.
In IT field, standard generally means *english*.
You could for example want to:

  - use [{json:api}](http://jsonapi.org/) format which define some attributes in english.
  - use [schema.org](http://schema.org/) schemas for some of your data. Everything is in english.
  - use [Hydra](http://www.hydra-cg.com/) to build a powerful hypermedia API (and use automatic tools to create a console for your API), english attributes again.
  - integrate other APIs with yours. These APIs will probably be in english (for example the famous [Poké API](http://pokeapi.co/)). Depending on the integration level, the combination of two APIs using different languages might  be weird and hard to understand.

And even if *now* you don't need any of these *english* things, you may need one *someday*.

Using a language other than english for your API might complicate its design and evolution when you want to integrate existing things and lead to a *too-much-custom-two-languages* API.
Too much custom APIs are hard to understand and use so imagine one with two languages.

# Assume that your API will not be private forever
> Anyone who doesn’t do this will be fired.  
> *(Jeff Bezos, [about service interface externalization and other things](http://apievangelist.com/2012/01/12/the-secret-to-amazons-success-internal-apis/))*

When you create an API you must always design it as it will be externalized, exposed to the outside world (read this [post from API Evangelist](http://apievangelist.com/2012/01/12/the-secret-to-amazons-success-internal-apis/) about Amazon's internal APIs).

- You may need developers outside of your company to build the application which will consume it on the eNoix (iNut) device
  - They can be foreigner and not speak your language (try to explain a french API to indian developers…).
  - Even if they speak your language, they may have problems understanding your *too-much-custom-two-languages* API.
- You may work for a small entity in a big multinational group, your API may be used or taken as a model by other entities and/or in other countries.
- You may want to show what you have done to the world because it's cool.
- And because it's cool, everybody wants to use it, so you want to open it.

The success of this externalization may be tempered by your *non-english* API.

# API design's commandment
> English shalt be the language thou use to design an API, and the language of the API designing shalt be english.  
> *(Book of <del>Armaments</del> API Design)*

But even if you design your API in english, you can at least write documentation in your language… and in english.

If my poor argumentation do not convince you to design your API in english, I hope that at least you will *choose* a language for your API in full knowledge of the facts and not build your API without thinking about it.

If someone has a really good reason to not design an API in english (or others good reasons to design in english), let me know, I'll be happy to discuss on this subject.

*Image credit: [The tower of Babel, Peter Bruegel](http://en.wikipedia.org/wiki/The_Tower_of_Babel_%28Bruegel%29).*
