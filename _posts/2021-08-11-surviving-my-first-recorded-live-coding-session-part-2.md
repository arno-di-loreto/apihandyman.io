---
title: Preparing session content and realizing it's not working well
series: Surviving my first (recorded) live coding session
series_number: 2
date: 2021-08-11
author: Arnaud Lauret
layout: post
permalink: /preparing-session-content-and-realizing-its-not-working-well/
category: post
---

Second post about my first ever (recorded) live coding session.
So, here I was in my [previous post](/setting-up-everything-to-record-myself-coding-and-talking/): ready to record myself coding and talking without any slides...
But I didn't told the whole story, I actually struggled a lot before actually being able to record myself coding and talking.
In the beginning, I had planned to do far more stuff and differently than what people had seen.
In this post, I'll talk about how I prepared content and realized that it was not working well.
<!--more-->

{% include _postincludes/live-coding-session.md %}

# Preparing content almost as usual

I actually worked on the content before tinkering with OBS, VS Code and all other stuff.
I treated this session's content almost like I usually do for my regular slides-based talks.

Usually, I list the topics I want to talk about and then sort them in order to tell a story with a beginning and an end.
I go deeper into the story by writing a detailed table of content.
Then I write my full speech exactly as I will say it.
It need to be precise because (Fr)English is a second language for me and I want to avoid stumble on words.
After that, I do the slides using a (pop culture) theme that usually had popped in my mind while working on topics, toc or speech.

Here, the topics were the OpenAPI Specification features and tools I wanted to show.
Building the story was made first by organizing the features in two categories: interface contract features and documentation features.
Then in each category, I sorted the features from simple/beginner to complex/advanced.
I added some extra entries in both categories to showcase various tools. 
With that, I had my table of content.

Then instead of writing my speech, I wrote an OpenAPI file adding each feature one by one.
I had to think about an example. 
I wanted to keep things simple in order to have a simple CRUD API, but as always I added some pop culture reference ... and ended with the Masters of the Universe API, an API providing information about characters and toys from the franchise.

The OpenAPI file did not came right at first try, I had to rework it several times.
I improved it while working the "how to show that", but it was more complicated than expected.
Indeed, my original plan for "how to show that" had not worked well.

# Too much, too complicated, a bit off topic

The plan was to write the OpenAPI document using [Stoplight Studio](https://stoplight.io/studio/), not for its GUI feature that allows to NOT write OpenAPI code (and that I use everyday).

{% include image.html source="stoplight-studio.png" %}

But because it provides a cool renderer that updates itself smartly as you write code.
Indeed when using renderers such as [Redoc](https://github.com/Redocly/redoc) or [Swagger UI](https://github.com/swagger-api/swagger-ui), even embedded in VS Code (using the really good [42 Crunch OpenAPI Editor extension](https://marketplace.visualstudio.com/items?itemName=42Crunch.vscode-openapi)), the experience is not so good.
For instance in Swagger UI, if you had opened an operation and selected the schema panel, modify something and the page is reloaded, still on the operation but you'll have to re-switch to schema panel yourself.
There's no such problem in Studio.

I also wanted to show how the API I was designing would work.

{% include image.html source="postman.png" %}

Studio comes with an embedded mock server powered by [Stoplight Prism](https://stoplight.io/open-source/prism/).
Prism is quite cool, feed it an OpenAPI file and it will magically generate a (basic) API mock server simulating the API described in the OpenAPI file.
The idea was to call this mocked API in [Postman](https://www.postman.com/) one of the best API GUI playground out there.

I made a few test, writing code in Studio, importing the created OpenAPI file in Postman so it generated a ready to use collection targeting the Prism mock.
Mostly to showcase various ways of using an OpenAPI document.

While all those tools are great and all this actually worked ... it was too long, too complicated to switch between tools.
And on top of that, my research for the best zoom level to use in order to keep code readable ended with being unable to have both code and rendering visible in Studio.
All that actually helped me realized that I was probably also going a bit off topic in the way of presenting things.

# Focusing on the real topic

What I wanted to show was more the OpenAPI Specification itself and its inner possibilities rather than showing tools using it just to show them using it.
I needed to focus on the real topic of the session and do that efficiently using tools only to showcase the features I was using.

So, that's why I chose to

- Use only [VS Code](https://code.visualstudio.com/), showing only OpenAPI code most of the time without anything else
- Show rendering with [Redoc](https://github.com/Redocly/redoc) or [Swagger UI](https://github.com/swagger-api/swagger-ui) only when actually needed (using [42 Crunch OpenAPI Editor extension](https://marketplace.visualstudio.com/items?itemName=42Crunch.vscode-openapi))
- Use [Stoplight Prism](https://stoplight.io/open-source/prism/) and [httpie](https://httpie.io/) in VS Code embedded terminal only to illustrate OpenAPI features I was actually using with dummy API calls

That way I was able to do everything inside VS Code with a clean (but stylish, see [previous post](/setting-up-everything-to-record-myself-coding-and-talking/)) interface focusing on code.

{% include image.html source="code-only.png" %}

Being able to open two terminals side by side revealed to be convenient when comparing API calls result to talk about inconsistencies.

{% include image.html source="two-terminals.png" %}

# Still not working well and terrible new idea

But even taking those decisions, it was still hard to deliver the session smoothly and in the given time frame.
There was still probably too much content.
Also, it was taking me an awfully long time to type everything or do copy/paste and fix indentation.
I was struggling to switch between writing code and going to the terminal.

I realized that I was often forgetting things to do or not doing them the right way.
During a rehearsal that was starting very well, I lost all my means because I forget to do a modification and so was totally puzzled, not understanding at all why it was not working suddenly. 

It was not going well and as it was difficult to work on specific sections of the sessions to train myself or improve the content, I was starting to loose my temper and my confidence.

And as if I didn't have enough problems, I had a terrible new idea.
I was really missing having titles like on my slides.
I feared attendees would be lost without visual indication about what was happening.
I decided to do something about that.

In the next posts, I'll explain how I solved all those problems.