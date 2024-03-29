---
title: When unicorn poop hits the fan (or how APIs can improve how we build software)
date: 2021-04-14
author: Arnaud Lauret
layout: post
category: post
permalink: /when-unicorn-poop-hits-the-fan-or-how-apis-can-improve-how-we-build-software/
---

Do you know what happens when you throw unicorn poop into a fan?
It makes everything better, everyone and everything around looks perfect, covered with joy and happiness.
Working seriously on (public or private) APIs can lead to the same kind of effect on how we build software.
Why?
Because modern web APIs raises the bar of software design and developer experience and so raises awareness and expectations regarding these topics for software in general.
<!--more-->

_Very special thanks to [@mrlapindesign](https://twitter.com/mrlapindesign) for the unicorn poop hits the fan post's banner._

# From API design to software design and architecture

I help people to design their web APIs in order to help them achieve the creation of APIs that fulfill actual needs and will be easy to understand, easy to use, reusable and evolvable.
But my true aim is actually to help them grow their API design skills so they won't need my help anymore.
I have seen API designers improving their skills, switching their stance from design beginners (if not skeptical) just seeking a "validated API design badge", having basic questions like "should we use a POST or a GET" or "is it /resources or /resource?", to fully aware design experts focusing on needs, able to challenge their own designs, to evaluate pros and cons of various design options and to bring interesting solutions to new design challenges not covered by guidelines.
This is already great, but there's more to that.
From time to time, I meet someone saying "working on API design improved the way I build software", and that is a sign of "API unicorn poop" actually hitting the fan.

Working seriously on API design not only improves the design of our APIs but it helps to better design object data models, database tables, and also messages (Kafka messages deserves to be designed too you know).
And beyond data, you can use your API design skills to write better code, better methods or functions, because API design teaches to question inputs and outputs but also needs and business rules in order to produce something that is useful and simple.
At upper scale, it also improves our vision of the domain we are working on, helping us to organize it in pieces of software that make more sense for us and the outside world, and so improving the architecture of the system.

Working on API design actually improves the whole software stack behind the interface.
But modern web APIs are not only about interface contract design

# From developer experience to everyone experience

Modern web APIs comes with the concept of DX, Developer eXperience.
It's basically UX, user experience, focusing on developers who choose to use APIs and write code to actually use them.
A good API design is mandatory to provide a good developer experience.
And that is important not only for public APIs, but also private ones.
Unfortunately, it's not because an API has one of the best in class design that people will want to use it, will be happy to use it.
How many promising APIs have been totally crippled by terrible registration process, terrible documentation or loony non-standard security or simply because people were not aware those APIs actually exists.
How you find APIs, how simple is their registration process, how clear is the documentation, how standard is their security, how short is the "time to first call", all those aspects are what will make a terrible or wonderful developer experience.

Hit by the "API unicorn poop", you'll think about the people who will come after you to work on what you build, you'll think about the people who may have to run and monitor what you build (not everyone as turn to "full develops, you build it, you run it", and even so, you'll think about your team).
You'll start to work on documentation, automation, ... you'll do whatever is possible to ensure that anyone can start to work in a matter of minute if not seconds.
Writing documentation, you'll work harder on its content, its design in order to ensure it is actually user-friendly and people find what they need instantly.
You may even start to wonder if it's reasonable to use 123 different technologies in your picoservices architecture, that could be a real HR nightmare to find people actually mastering that obscure framework or language you choose to use just because.

Basically, working seriously on APIs DX, you'll start to think about user experience of everyone who will have to work one way or another with what you build, whatever it is.

# Raising expectations, starting a virtuous circle

Obviously and hopefully, some people in the software industry did not wait the Web API train to think about design and developer experience, but there was still a lot to do in this area when Web APIs became a thing and there's still much to do even after that.
Now working on design and developer experience became a de facto standard when providing public APIs, then it started to contaminate private APIs and I believe it will irremediably contaminate everything in software beyond interface contracts.

If I was pessimistic, I would say that companies creating software for themselves or others should sense they can save or earn much money by creating software that fulfill actual needs, are easy to understand, easy to use and reuse, can evolve easily, and offer a overall descent experience.
But I prefer to see that from a more optimistic perspective, having been shown empathy and be very happy with that, people will raise their standard, change their perspective and in return build software along with an experience that are as good as the one they've encountered.

So, please, next time you create a technology, framework, build an application/system for your company, or simply write code, throw unicorn poop in the fan, think about design and developer experience; if you don't do it for others, do it at least for you.

<blockquote class="blockquote">
  <p class="mb-0">You'll thank me later</p>
  <footer class="blockquote-footer"><cite title="Source Title">Adrian Monk</cite></footer>
</blockquote>