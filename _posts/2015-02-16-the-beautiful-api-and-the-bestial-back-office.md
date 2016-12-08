---
id: 227
title: The beautiful API and the bestial back-office
date: 2015-02-16T00:18:26+00:00
author: Arnaud Lauret
layout: post
guid: http://apihandyman.io/?p=227
permalink: /the-beautiful-api-and-the-bestial-back-office/
dsq_thread_id:
  - 4866925040
category: Posts
tags:
  - Design
  - Implementation
---
When you design an API (even an internal/private one) upon an existing back office (to plug a mobile application on it for example), you should take care of one thing: an API is a display, not a window.
An API's purpose is to expose your data and data processing but an API is only a *representation* and you're under no obligation to directly expose the crude reality.

> What happens in <del>Vegas</del> back office stays in <del>Vegas</del> back office
> (*[famous tag line](http://theweek.com/articles/459434/brief-history-happens-vegas-stays-vegas)*)

This is even more true if you have a *bestial* back-office. It's definitely not a good idea to expose it as it is, you really must hide it behind a *beautiful* API. It might even brings unexpected benefits.

*Disclaimer: The events depicted in this post are fictitious. Any similarity to any person or software living or dead is merely coincidental. All inappropriate expressions have been replaced by [fonz](http://en.wikipedia.org/wiki/Fonzie) words. No toys were harmed during the making of this post.* 

# A bestial back office
You own coolvintageornottoys.com the famous cool vintage-or-not toys database and exchange platform.
This website consists of some kind of a more or less monolithic web application plugged on some kind of service oriented architecture.
How your data and the way you process them look like is the result of years of evolution in a close environment leading to a functional but maybe complex system including some fancy things like these...

![a-bestial-back-office-title](/images/the-beautiful-api-and-the-bestial-back-office/a-bestial-back-office-page-01.png "A bestial back-office title")
![crypto-data-begins](/images/the-beautiful-api-and-the-bestial-back-office/a-bestial-back-office-page-02.png "Crypto data begins")
![crypto-data-returns](/images/the-beautiful-api-and-the-bestial-back-office/a-bestial-back-office-page-03.png "Crypto data returns")
![inconsistent-interfaces-wars](/images/the-beautiful-api-and-the-bestial-back-office/a-bestial-back-office-page-04.png "Inconsistent interfaces wars")
![inconsistent-interfaces-strikes-back](/images/the-beautiful-api-and-the-bestial-back-office/a-bestial-back-office-page-05.png "Inconsistent interfaces strikes back")
![the-return-of-inconsistent-interfaces](/images/the-beautiful-api-and-the-bestial-back-office/a-bestial-back-office-page-06.png "The return of inconsistent interfaces")
![consumer-over-delegation](/images/the-beautiful-api-and-the-bestial-back-office/a-bestial-back-office-page-07.png "Consumer over-delegation")

... *functional but maybe complex system*, that's a pretty euphemism. 

# The window: a bestial API
You think it's time to have a cool mobile application.
You've read some things about this and it seems that a mobile application needs an API, so you decide to build one.
This is a very good idea...

![a-bestial-API-title](/images/the-beautiful-api-and-the-bestial-back-office/a-bestial-api-page-01.png "A bestial API title")
![a-bestial-API](/images/the-beautiful-api-and-the-bestial-back-office/a-bestial-api-page-02.png "A bestial API")

... but not this way.

Exposing your back-office as it is *may* sound a simple, quick and cheap way to create an API (*for those who have think about it a little before starting coding...*) especially for a private/internal API, but this is a very short term strategy.
In fact, in the end it will reveal complex, you will spend a lot of time, a lot of money and gain absolutely nothing:

- Your API will reflect perfectly your bestial back-office and nobody outside of your company will understand it and be able to use it (and probably inside too...).
- The development of your mobile application will be a nightmare. The guys you will hire to develop it will screw up because they will not understand how does this *fonzing* API works and because they will have to re-code in the application what should be back-office business logic.
- You will not be ready for other consumers. What had happened for your mobile application will happen again and again with all other consumers of your API.
- You will face high cross-maintenance costs as all your API consumers include heavy business logic.
- Opening your API will be useless (because nobody will be able to use it) and potentially dangerous (if your system's integrity relies on the consumer).
- Your back-office will not gain anything in the process.

# The display: a beautiful API
Exposing your back-office as it is is definitely not a good idea, but you may ask if it is really possible to create a beautiful API upon all this mess. The answer is yes.

I will not detail fully the designing of such an API and how to plug it on your existing back office. There are many ways to do this and many posts to write about these things and this is not the point of this post.
A *[montage](http://en.wikipedia.org/wiki/Montage_%28filmmaking%29)* will show you a quick overview of one way of doing it to help the understanding of the potentials unexpected benefits of building a beautiful API to hide your bestial back-office.

*Beautiful API design and implementation [montage](http://en.wikipedia.org/wiki/Montage_%28filmmaking%29) starts.*

To design a beautiful API offering the same functionalities as your website for your mobile application, you could:

- Lists your web site functions and data.
- Rationalize and simplify those functions and data.
- Define rules for your API (data naming, data format, URI definition, HTTP method usage, error handling, ...). You could use some things like Rob Zazueta's [NARWHL](http://www.narwhl.com/) or Steve Klabnick and Yehuda Katz [json:api](http://jsonapi.org/).
- Design your API based on these refined data, functions and new rules.

Then you could plug your newly design beautiful API to your bestial back office by:

- Mapping your API to back-office functions/services.
- Extracting business logic from your web application if necessary.
- Refactoring some services (aggregation, web application business logic integration, ...). It would be a good idea to define rules for your new components (you may reuse some rules defined for your API).
- Using a service mediation layer and/or gang of 4 facade pattern to adapt services interfaces.

*Beautiful API design and implementation [montage](http://en.wikipedia.org/wiki/Montage_%28filmmaking%29) ends.*

And now that you have a beautiful API in front of your bestial back office, there are obvious benefits brought by the API itself:

- Your API is not only beautiful but it is understandable, usable and reusable by anyone.
- The creation of your mobile application will be fast and easy.
- You're ready for whatever comes next (opening your API, new consumers, ...).

# An happy ending
But what about the unexpected benefits?

> Beast was disappeared, and she saw, at her feet, one of the loveliest princes that eye ever beheld
> *(The beauty and the beast, Jeanne-Marie LePrince de Beaumont)*

Like in the fairy tale, the beautiful API has *improved* the bestial back-office:

- You have a rationalized vision of your back-office that will help you for future evolutions or refactoring.
- Some parts of your back-office may have been (beautifully) refactored in the process.
- Some lost knowledge may have been rediscovered.
- You have defined rules (naming, format, error handling, ...) you could apply to all your new back office components.
- What about a web site refactoring to plug it to your new API and minimize business logic cross maintenance?

> His subjects received him with joy; he married Beauty, and lived with her many years; and their happiness, as it was founded on virtue, was complete.
> The end.
> *(The beauty and the beast, Jeanne-Marie LePrince de Beaumont)*

This is not a fairy tale, it's reality. Building an API can really help you improve your back-office.
And whatever the case an API *must* be beautiful (or fear the wrath of your consumers and API believers).
I know, beauty is in the eye of the beholder, but that's a subject for another post...