---
id: 471
title: The API crash test project
date: 2015-04-05T23:43:28+00:00
author: Arnaud Lauret
layout: post
guid: http://apihandyman.io/?p=471
permalink: /the-api-crash-test-project/
dsq_thread_id:
  - 4866870392
category: Posts
---
As I was writing my HAMM and ways of API smartness posts, I wanted more.
As I was discussing with smart people about APIs, I wanted ever more.
I want to delve deeply into the API ways.<!--more-->

# The API crash test project
My brain is boiling with ideas and there are so many existing concepts, techniques, best (and bad) practices concerning APIs.
For now, I have used some more or less inconsistent fictional examples for my posts and even if my examples are mainly based on what I've experiment, I'm not satisfied with that.

I want something more practical to try out the things I see and imagine.
I want something more clear to make my posts more easier to understand.
I want something more concrete to help people understand/choose/find their way(s) in this fascinating/crazy/complex/boiling API world.

{% img file:apicrashtestcomic.png %}

So, I came up with the concept of *API crash test*.

> An API [crash test](http://en.wikipedia.org/wiki/Crash_test) is a form of constructive testing usually performed to ensure safe design standards in usefulness and usage compatibility for various modes of API designs or related systems and components

To realize these *crash tests*, I will define a concrete *product* and use it in my posts and experiments to test many API related things.

{% img file:apicrashtestprojectoverview.png label:"A big fuzzy draft overview of the API crash test project."%}
  
The main objective is to work on the designing of (hypermedia) APIs based on this product, but through this project I also want to work on:

- Defining a product.
- Documenting every aspect of the project for internal (provider) and external use (consumer), for human and machine needs.
- Designing software architectures.
- Implementing services.
- Exposing APIs.
- Consuming APIs.
- Handling code on demand.
- Organizing my work around all this :o).
- And probably many other things I've not think of at this time.

By using a more or less *invariant* concept, I hope that:

- It will be more easy to test new features as I already have a solid existing base (both conceptual and technical) with my past experiments
- It will help me compare the results of tests carried out not a the same moment.
- It will be more easy to upgrade past tests to handle new features.

> The journey of a thousand miles begins with a single step.
> *Lao Tzu*

Of course I cannot define a *panacea* product able to cover every API related things at first try.
I will start with a basic version of this concrete product and make it evolve with my needs.

I will share with you *all* my experiments on this blog and github, the good ones *and* the bad ones as I believe that we can learn many things from our mistakes (and from others' mistakes). 

# How will I use it?
In my HAMM posts I showed some examples of hypermedia implementations.
With the API crash test project, I would have implemented the API based on my product and gives you the hability to test and compare all hypermedia implementations with a system like this: 

{% img file:testinghypermediatypes.png %}

Another example. Let's say that I want to test some kind of backend as a service or an API framework. I'll take then my crash test API definition and see how I can implement it with these things.

# The product
With my wife, we're *serial car boot buyers*. We love to roam the countryside to find old things (70's/80's toys, books, vinyls, tableware, furnitures).
We use shared Evernote notebook and Google sheet to track all the things we buy, list the things we have or we want, and manage our budget. 
For the last two years I think about an application (and a API) to handle all this, I started and abandonned many times... but with this new project I have a good opportunity to settle this.
I'll give a more complete description of this *product* in later posts.

# To somewhere and beyond
I need some time to build the basic components of this project so I'll probably have to write a few post without a concrete usable platform but I'l try at least to use the concepts of my product in my examples. I will write posts about the construction of this platform.

I don't know where all this gonna lead me, but I feel like this is going to be a great journey and I hope you'll enjoy it too!