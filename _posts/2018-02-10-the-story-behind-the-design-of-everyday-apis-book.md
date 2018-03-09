---
title: "The story behind The Design of Everyday APIs book"
date: 2018-02-10
author: Arnaud Lauret
layout: post
permalink: /the-story-behind-the-design-of-everyday-apis-book/
category: posts
---

I'm thrilled to announce that I'm writing a book about API design: _The Design of Everyday APIs_. This book is published by _Manning Publications_ and the first two chapters are now available on the Manning Early Access Program or {% include _everydayapis/meap-link.md %}. This book is for everyone who wants to learn API design.
But, what's the story behind this book about API design? To answer this question, let's talk about my other passion: guitar. <!--more-->

{% img file:"guitar-tabs.png" label:"Guitar tabs"%}

I have been playing the guitar for quite a long time. I'm definitely not an outstanding guitar player, I do that just for fun. Even if I have basic knowledge of solfeggio, I mostly use tablatures (or tabs) to learn to play songs. The guitar strings are represented by lines. And numbers on the lines indicate where to put fingers on the fret board. Pretty simple. I can play any song. Well, as long as my fingers dexterity allows it. So, I can play almost any song without even kwnowing which musical note I'm doing. But it can take me a long time to master songs, because I mostly do not get immediately how it works. I cannot play a song without a tablature by just listening to it. I'm also unable to compose music, I'm unable to improvise. And if I want to play another musical instrument like the piano, I would have to relearn everything. All this because I simply (but with dexterity!) move my fingers on a guitar fretboard without really understanding what I'm doing and why. When you really know music, it's quite different. A friend of mine is a music teacher. He knows everything about solfeggio and music theory. He can improvise and compose. He can play any musical instrument as long as he understand how doing notes.

But what has this to do with API design?

{% include _everydayapis/big-banner.html %}

I've been doing distributed software and working with web services and web APIs for a long time now, designing, building, using and providing them. Like many others, I've learned many things from the trenches about API design by practicing ... and doing many mistakes. Mistakes, that I could have probably easily avoided if I had been warned. I have discovered the not so obvious scope of the API designer's job and you know what? Choosing HTTP methods and designing URLs is only a part of it. I have also learned how to design APIs that do exactly what they have been created for. And I have also learned how to shape APIs in order to make them easy-to-understand and easy-to-use.

But I have also learned something beyond these technical tips and tricks. I have learned what really is an API and what it means to design it.

Knowing that `/library/books/the-design-of-everyday-apis/chapters` is a good a way of designing some REST resource's URL is important. Knowing that simply returning a `400 Bad Request` HTTP status code is not enough is important. Knowing that content negociation is a solution to some use case is important. But knowing and understanding the true reasons _why_ we should or shouldn't design API like this or that is far more important. This is guitar tablature vs solfeggio and music theory. Would you be able to improvise when facing a new use case? What would you do when designing a SOAP web services (yes, some people still have to do that), a gRPC API or whatever will come in the future?
I could have been a better API designer faster if I had understood earlier the true essence of API design. There are reasons why designing APIs in certain ways gives outstanding results. Understanding the reasons behind techniques and tips that make APIs great is far more important than just knowing them, because it can help to face any situation and design any type of API. Just like being able to play any musical instrument, improvise and compose. 

{% img file:"cryptic-interface.png" label:"A quite cryptic interface" %}

But is it hard to master the _API design solfeggio_? Hopefully not at all! The _API design solfeggio_ is quite simple to grasp as long as you understand what really is an API and how you can find inspiration from everyday objects.
OK, an API is an _Application Programming Interface_, but it's first and foremost an _interface_ that _people_ will use in their software to interact with your software.
APIs are interfaces like any others. Look at this _UDRC 1138_ control panel, its _interface_. What could be this device's purpose? How use it? hard to guess thanks to its poorly designed interface. Think about the many times you have been puzzled or you have grumbled when using a everyday object like a door, a microwave oven, a remote control, a toy, a web site, a mobile application because its design was flawed. Think about the many times you did not complain and were even quite happy using something. 
What seems ridiculous for everyday objects interfaces is as ridiculous for application programming interface. And the opposite is quite true, what works for everyday objects interfaces works for APIs.

So, while _The Design of Everyday APIs_ book is a practical one showing every aspects of API design and many techniques, tips and tricks to design great APIs. It will also explain _why_ you should design APIs that way and therefore, I hope, give you the eye of the API designer.
I hope you'll enjoy this book and find it useful to design your everyday APIs and build an API designer mindset. As you can read it on {% include _everydayapis/meap-link.md %} while it is written, I look forward to your feedbacks on MEAP forum.

{% slideshare 6ZYXRGEODWQv5M %} 