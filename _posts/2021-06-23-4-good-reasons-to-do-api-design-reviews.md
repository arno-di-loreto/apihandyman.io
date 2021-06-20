---
date: 2021-06-23
author: Arnaud Lauret
layout: post
permalink: /3-good-reasons-to-do-api-design-reviews/
series: API Design Reviews
series_title: 3 good reasons to do API Design Reviews
series_number: 1
category: post
---

More often than not when people hear "let's do an API design review", they hear "let's check that an API design conforms to API design guidelines".
That's only partially true and reducing API design reviews to that is a terrible mistake.
Actually, doing API design reviews only to do that may even not make any sense at all.
Let's see 3 really good reasons to do API design reviews.

<!--more-->
# I'm gonna need a bigger boat

People following me on Twitter might have expect another post this week.
Indeed, I tweeted something like "lately, I slightly changed the way I summarize my API design reviews, that looks promising and I'm going to write about this next week".
But, that would be putting the cart before the horse and I have so many things to say about API design reviews that I think this topic deserves a (probably long) series.
So before diving into how I summarize API Design Reviews, we'll talk about the reviews themselves and especially why you should (even must) do them.

And we start with what most people think an API design review is ... 

# ~~Check guidelines conformance~~ Ensure consistency

So, more often than not when people hear "API design review", they hear "checking that an API design conforms to API design guidelines".
That's only partially true, the aim of an API design review is actually less about checking guidelines conformance (which is the "how doing a review") and more about ensuring an overall consistency (which is the "why doing a review").

Consistency in API design is important because if all of your APIs and more important all operations, behaviors and data models (and whatever forms an API design) share the same look and feel, that will make your APIs easier to understand and to use.
Once people have learned to use one of your APIs, they feel at home when switching to the next one because it looks and behaves like the previous one.

That's why guidelines are important; they are many good (and wrong) ways to design (REST or other) APIs but you need to choose one (preferably a good one). 
Guidelines define an API design look and feel, and by the way if they are well made, those guidelines are consistent with outside world common practices and so that makes your APIs even more easy to use.

But while guidelines may help to achieve a certain level of consistency at high level, there is still much place to introduce inconsistency.
Indeed, your guidelines will probably not cover every single and more local design concerns.
For instance, it's up to the API owners (the team, not a single person) to ensure that "a cat is always called a cat" (as we say in french).
If it's randomly called a `cat`, `felisCatus` or `felidae` across same domain APIs or worse inside an API, that will puzzle more than one consumer (and owner by the way). 
So API designers must take care to use the same vocabulary throughout a single API and across their domain APIs (who said [ubiquitous language](https://martinfowler.com/bliki/UbiquitousLanguage.html)?).

So, ensuring consistency not only requires to observes API design guidelines but also the rest of the API and other related APIs.
But reducing API design review to "ensuring API design consistency" is a terrible mistake.

# Help people shape the right APIs

If an API is 100% consistent with itself, with outside world common practices, with design guidelines and existing APIs, it unfortunately still can be a terrible API.
Indeed, it can be as simple as choosing the wrong vocabulary (`cat` vs `felisCatus`), making the API hard to understand for non experts.
But it can be also less obvious, like exposing purely internal concerns that shouldn't be exposed to the outside, making the API complex to use (if not dangerous).
It can be even worse: choosing a totally wrong purpose, making the API a total failure.
And everything in between (and beyond).

{% include image.html source="kitchenradar.jpg" caption="The Kitchen Radar 3000 (from my book The Design of Web APIs)" url="https://livebook.manning.com/book/the-design-of-everyday-apis/chapter-2/16" %}

Hopefully, it's not a fatality, a well conducted API design review allows to avoid such dark fates.
Put around a table people having functional knowledge, people knowing how the software work (existing) or should work (new), and people knowing nothing about the topic (usually the reviewer, or Jon Snow) and you should be able to decipher what the API should actually do (to solve someone's problems) and how it should actually looks like.
With all these people discussing during the API design review, the resulting API will be the right API, or at least it shouldn't be that far (do a final check with potential consumers to confirm).

# Improve ~~API~~ design skills

The more you do API design reviews, the more people involved improve their API design skills.
I have witnessed it myself, after a few months, all people involved (including myself as a reviewer) have improved their API design skills.
At the beginning, there can be a lot of basic mistakes (HTTP, guidelines, consistency), but review after review people understand how API design works, how the guidelines works.
In the process, reviewers learn also a lot by confronting their views to others, discovering new patterns, new use cases.
And in the end, reviews can focus more on doing the right APIs than doing the APIs right.

Icing on the cake, API design reviews may have interesting side effects on other areas.
One day someone told me that doing API design improved their software design skills, they changed the way they designed class, methods, databases, ... and even software architecture.
That's also true on the functional perspective, building APIs that are easy to understand, easy to use, easy to evolve, can trigger new ways of thinking that can be applied when designing business processes too.

# API design review is a MUST do

So, API design review is a MUST do.
It will irremediably lead to consistency across APIs.
More important, it will lead to building the right APIs.
And even more important, it will help people grow API design skills that, icing on the cake, can be applied to other areas.

But, there's always a but, that will only work if the API designer review is conducted the right way, especially with the right mindset.
But that's another story (if not stories) I'll keep for one or more later post(s).