---
series: API Design Reviews
series_title: An API design review is based on facts, not opinions
series_number: 2
date: 2021-09-08
author: Arnaud Lauret
layout: post
permalink: /an-api-design-review-is-based-on-facts-not-opinions/
category: post
---

If you're an API design reviewer and, like the Who, you got a feeling inside that you can't explain during an API design review, maybe you're falling in love with the API designer... or more probably: you're on the verge of giving an opinion.
And that is a problem.
What is the role of an API design reviewer?
Distort API designs to their liking or objectively analyze them based on facts?  

<!--more-->

# That annoying feeling

As an API design reviewer, I analyze, more often than, not designs that must be fixed because of wrong needs, some blatant violation of our guidelines, use of totally cryptic vocabulary, unnecessary steps in an API call flow or missing operations, use of non extensible array of string, or a simple typo.
But sometimes, they're just "not good" and I can't really explain it unless by saying I would have done it differently.
Sometimes, it's so different from what I would have done it becomes a really annoying feeling.

If I try to keep a professional stance, I could say It becomes annoying because I feel in my guts that the designers are heading the wrong way and I want to help them avoid falling into some terrible trap... 
But, to be honest, it's just because I want to scream "it's different from my idea, I hate it, that sucks!".

Engaging the discussion on such a feeling and with such a state of mind can lead to a sterile argument, because the designers feel that their design is "good".
And they probably are right to think so, because there's no problem, no trap.
Hopefully, I've learned to avoid such arguments and overcome that really annoying feeling. 

# How to live with it

I do not remember fondly of the time I was a manager, I'm not made for that, but I learned a few things that are still useful in my daily expert/coach job.
I've learned that when you give a task to someone, you don't tell them how to do it, you describe the expected outcomes.
I have also learned that all people do not think/work the same way and so how the task is done can be different from how you would have done it.
The solution could also be different because you don't have all the context when giving the task.
All you have to do is actually evaluate if the expected outcome are there to judge the quality of what has been done.

So, when I have that annoying feeling, just because an API is different from what I would have done, I rethink to what are the expected outcomes of an API design.
An API design is supposed to

- Fulfill the right needs
- Be easy to understand
- Be easy to use
- Be easily evolvable
- Conforms to guidelines and common practices

If the design currently reviewed objectively checks all those items, there's no need to argue.
But you can still propose your alternative design just to propose another perspective, but don't forget to precise that the provided is design is actually correct.
Sometimes designer will says "oh yes, I prefer your version", or maybe make a counter proposition mixing the 2 options and sometimes they'll keep their design.
In that case, don't take that as an insult, be a grown up person, it's actually their API, not yours (and it's normal if that still stings a little, you'll be less an less annoyed as you practice).

Reviewing that checklist may help you to factually figure the real problem you were feeling in your guts.
If something is factually not checked, then you can dig into that based on facts not just an opinion.
And that is the real job of an API design reviewer.

# Help people , don't do their job

So as an API designer reviewer, you may have feelings and opinions like other humans.
But learn to overcome them by factually thinking about what makes an API design objectively good.
Indeed, you're not here to design an API but to help people design it.


