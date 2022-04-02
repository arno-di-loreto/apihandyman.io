---
title: API design and architecture lessons from a frying pan
date: 2022-01-05
author: Arnaud Lauret
layout: post
permalink: /api-design-and-architecture-lessons-from-a-frying-pan/
category: post
---

In the kitchen, I'm the dishwasher.
And lately, washing our new frying pans has got me thinking about design and API architecture issues.
This post is dedicated to the person who complained that my book contained too many analogies.
Sorry, but no matter what I do, read, look at, listen to, I'm always trying to see if I can make connections to APIs.
And housework is no exception.
<!--more-->

Washing dishes is a household task that I actually enjoy.
It allows me to satisfy my compulsive urge to sort things, in this case cutlery, glasses, plates or dishes.
This may be one of the characteristics of my mind that make me rather good at doing API design reviews.
It also allows me to listen to music.
But also and most importantly, it allows me to cogitate. 

# Pans

For some time now, we have had new frying pans.
They have everything that makes a good pan, a thick bottom, a body covered with enamel (a nice change from Teflon), and a solid handle with a good grip. They are even oven safe.
In use, nothing to complain about.
When washing, it's a different story.
If cleaning the enamelled steel is not a problem, cleaning the outside edge is a pain.

{% include image.html source="pan.jpg" %}

And yes, when you use a frying pan, you also dirty the outside edge, there are often splashes or drips, especially on the handle.
And on these pans, cleaning the 2 millimeter gap between the handle and the edge of the pan is quite complicated with a sponge.
In the end, we manage to do it with a small brush, but we could do without this difficulty (relative, of course).
A handle placed a little lower or stuck to the edge of the pan, or simply no edge would have avoided this inconvenience.
The fact that an object, kitchen utensil or other, is an eyesore to clean is unfortunately quite common.
It seems that the designers of these products forget that in addition to using them for what they were designed for, they need to be cleaned.

# APIs

"But what does this have to do with APIs?" you might ask.
There is not one but (at least) two analogies here.

The first one is that when you design an API, you have to think about all the profiles (or users) that will use it, otherwise you might forget to include important features.
If we stop at uses, we will think about "cooking" but not necessarily "washing the dishes".
Going through the prism of users reduces the risk of forgetting features.
Here, the first users of a frying pan that we think of are necessarily the cooks.
But, in a kitchen, there are also pearl divers (the persons who wash dishes) who will also "use" the pans but in very different ways.

The other way to look at it would be to think of the users of the API vs. the maintainers of the system exposing the API.
Cooks can be thought of as the users of a pan and pearl divers as the maintainers of the system.
While it is now pretty much accepted that the user experience of APIs is important (although there is still a way to go for private APIs), I have too often seen convoluted and complex implementations that make the life of maintainers impossible.
Too many modules, too many different technologies, unnecessarily sharp technologies, non mastered technologies, maintenance procedures not completely automated, ...
In short, we forget the experience of the system maintainers.
Icing on the cake, in addition to bothering them, such systems are more complex to evolve and more fragile.

So the next time you design an API and its underlying architecture, think about washing frying pans and think about all the users.