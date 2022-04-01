---
title: Lessons learned while demoing API to non-developers
date: 2019-11-22
author: Arnaud Lauret
layout: post
permalink: /lessons-learned-while-demoing-api-to-non-developers/
category: post
---

What would you do if you had to demo API to non-developers in a highly-constrained context? How would you do without curl, Postman or any other API tool usually used? How would you do without your usual fun API examples? I had to do that a few weeks ago and was quite happy by the questions that arose and the solutions found. The whole story definitely deserves a post in order to share what I've learned!<!--more-->

# The request

A part of my job is explaining to developers and non-developers what are APIs and what can be done with them from both technical and business perspectives. I regularly do some presentations or training to do so, especially a very first API 101 session simply consisting in some slides without any hands-on. A few weeks ago, I received a request that seemed quite simple at first: "we want to organize the usual API 101 for non developers ... but this time, it would be great to let them make _code_ some API stuff. And you have less than 45 minutes, probably half an hour". The objective was to make these people grasp a little bit more than usual what APIs are and let them understand their simplicity during this first session.

At first, I was like: "oh no problem, we'll use curl and Postman to make calls to the SWAPI API (an API providing information about the Star Wars movies) or the PokeAPI (providing information Pokemons), it shouldn't take more than 10 minutes during the presentation, so even with half an hour that should be OK. Unfortunately that was not that simple.

# Beware the context when choosing hands-on tools

Problems started with the tooling. Indeed, the people attending this session have standard-for-non-developer laptops. These laptops do not come with Postman or curl, and even if the attendees were admins (highly improbable) on these laptops, installing tools would be far too complicated and would take a too long time in such a short session (and it would probably ruin the "APIs are simple" message).

OK, no problems, only solutions. These machines come with Windows 10 and PowerShell, I'm not familiar with it but I thought "Well, a PowerShell-curl probably exists". Yes it does, there are `Invoke-RestMethod`and `Invoke-WebRequest` that seem to do the job. Unfortunately, I did not succeed to make them work with our f\*\*\*\*\*\* corporate proxy. As far as I've seen, it would have required to make too much complicated stuff and would have taken too much time (I may have missed something).

And there was also this "code some API stuff" idea. One of my colleagues suggested to use [JSFiddle](https://jsfiddle.net/). Brilliant! It's a browser based tool and therefore it requires absolutely no installation. It allows to tinker with HTML, JS and CSS. I first checked that it was not blocked by our corporate proxy ... and yes! It worked. I discovered that JSFiddle (and other similar tools) comes with some useful features (if you pay of course) for training sessions, especially private fiddles. That could be interesting to manage calls to API needing authentication (to safely store credentials). I keep that in a corner of my mind for another time as I didn't want to use secured APIs during this session. I developed a simple example with basic HTML and JavaScript doing an API call.

{% img file:jsfiddle.png label:"Using JSFiddle and HTML/JS code is maybe too complex for non-developers"%}

I thought I could let attendees modify it to make some API calls themselves. From the very beginning I was not comfortable with that. Hopefully, I could test the idea with the persons (non-developers) who made the request and specifically asked for the "code some API stuff". It didn't take us long to realize that was a terrible idea. JSFiddle would look terribly complex and having to modify some JS code would be a nightmare for people who never have done that before.

OK, if attendees could not actually write code in that context, they could at least use their browser to call an API, that's web APIs we had to talk about after all. All that is needed is typing something in the browser's address bar. And people could "code" some API stuff by tweaking the URLs and parameters. We, all agreed that was the best option in our context and it fulfilled the requirements.

But which API to use?

# Take care of finding API examples adapted to the audience

I'm used to use [SWAPI](https://swapi.co/) (Star War API) when demoing APIs in such 101 sessions. It's simple, fun and requires no authentication. But, in that context, I realized that using SWAPI would lead to two problems.

The first problem was simply technical. In such demo I usually use curl to call SWAPI. But in that context I had to use a browser and unfortunately SWAPI is too smart, it handles content negotiation very well. Indeed, when you call SWAPI from a browser, you don't get raw JSON data but an HTML page. But, I wanted to show some ugly raw JSON data and not HTML! So, I found another funny API, the [D&D](http://www.dnd5eapi.co) API. Typing the [http://www.dnd5eapi.co/api/classes](http://www.dnd5eapi.co/api/classes) URL in the browser's address bar shows some beautifully-ugly JSON raw data listing available characters class in the fifth edition of Dungeons & Dragons rule books. I thought it was perfect ... but not at all: that's the seconde problem.

Indeed, the second problem with such fun API is functional. SWAPI or D&D are totally fun from my perspective, but their fields were thousands light-years away of what matters for the attendees. For this demo we needed an API that would resonate with them. I needed an example that makes sense for people in the financial industry. Hopefully, I found a more suitable API: the [Foreign Exchange Rate API](https://exchangeratesapi.io/). This API provides current and historical foreign exchange rates published by the European Central Bank. Basically, if you want to know how much Japan Yen you can get for a Euro, this API is for you. OK, forex is not a field as fun as Star Wars and D&D but this API provides data the attendees are familiar with (especially the ISO 4217 currency codes), it's dead simple and provides enough functions and parameters to let total API beginners have fun with it.

Once the API chosen, I listed the API calls the attendees would have to do and the questions I would ask them during the "API call exercises" part of the session. I was almost done but I wanted to show how this Foreign Exchange Rate API could be used in a simple application along with another API (to show how by combining easily simple API you can do interesting stuff).

# Build an all-in-one demo application

So, I wrote a simple [webapp](https://arno-di-loreto.github.io/simple-api-demo/) (using [JS Fiddle](https://jsfiddle.net/arnaudlauret/8catx91d) and [Github pages](https://github.com/arno-di-loreto/simple-api-demo) by the way) combining the Foreign Exchange Rate API and the [REST Countries](https://restcountries.eu/) API which provide information about countries such as languages, borders, flags, ... It consists in a simple form that let users convert an amount in a source currency to a target currency. It also shows trivia about the selected currencies such as the countries which use them and their flags. The available currencies and exchange rate come from the exchange rate API and the country/currency relationship and country flag come from REST country API.

And then I thought it would be interesting to show the actual API calls that were triggered when using the web application. I first though to use the browser's developer tools. Indeed, using the network panel and filtering to XHR request, you can see the API calls made by the JavaScript code. But again, that would have been too complex just like showing them JSFiddle (IMHO).

{% img file:browser-dev-tools.png label:"Filtering XHR request in browser dev tools? Too scary!" %}

So I came to the idea of adding an API call log directly within the web application. This log shows which called are done and why. API calls are log during the webpage initial loading but also when users interact with it. On each new action, the new call are added to the top of the list and the previous calls are shown in light grey.

{% img file:demo-app.png label:"Demo application including detailed API call log? Far more non-developers friendly!" %}

# Conclusion

So I was totally ready for this special 101 session with a bonus hands-on. And hopefully everything went very well, but even if that presentation was very important (because of the very important people in the audience), I will remember more its preparation as it helped me (re)discover very interesting things. Preparing this unusual session reminded me that whatever you do: beware the context before making any choice. I'm also quite happy to have find this idea of building an all-in-one demo application which explain what happens behind the hood and will reuse and expand this concept in the future.

_PS: Oh, and I almost forgot ... it also reminded me how so many tools are unable to deal with corporate proxies easily. I may write something about that one day._