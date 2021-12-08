---
title: And what if I’m wrong? Overcoming fears and doubts while designing APIs
author: Arnaud Lauret
layout: post
permalink: /and-what-if-im-wrong-overcoming-fears-and-doubts-while-designing-apis/
category: post
date: 2021-12-08
---

F******* impostor syndrome, it’s not easy to say that I’m an API design expert, but I am.
Along my path to expertise, I failed, I did mistakes; that helped me to learn a lot.
I also have been afraid, I had doubts.
And you know what?
Though I'm now an expert, that’s still the case when I help people to design their APIs.
But, I learned to live with that.
I learned to live with the “what if I’m wrong” question. 
<!--more-->

# Designing is doubting

So yes, even after all these years, despite being an expert, I still can fear to be wrong, I still can doubt while designing APIs.
And that feeling is even stronger when I help others to design APIs, my mistakes could impact others.

What can be wrong in API Design?
What would an expert or anyone else doubt when designing an API?
Everything.
Needs, business rule, API granularity, operation granularity, operation goal, behavior, data structures, names, types, enumerations …
All those problems can be categorized in the following categories:

- Needs and subject matter: Everything related to the business side of the API. What problem are we trying to solve, what the API is supposed to do, is it a "this" or a "that, what becomes "this" after we've done "that" ...
- Architecture and modeling: Everything related to the representation of the business intent as a programming interface. One or 2 APIs, list or tree, sync or async, do we need a different representation of "this" in those different contexts, ...
- Look and feel: Cousin to previous topic, everything related to consistency. Path structure, when using header parameters, is it "/resource" or /resources, is it birthDate or dateOfBirth ...

With experience, training, reading, there are less and less fears and doubts, but they're will always be there.
The best way to deal with doubts is actually to get rid of them.

# Ensuring that I’m not wrong

Look and feel concerns are the easier to deal with ... if you have API design guidelines.
Indeed, having rules defining the look and feel of your APIs will help you deal with most doubts.
But beware, look and feel concerns can sometimes [hide in details](/choosing-between-birthdate-and-dateofbirth-has-important-implications-for-your-api/), so always wonder if the decision you make have greater impacts.
If so, and if there's no actual solution in your guidelines, it will be time to add it so the next time you won't doubt.

Guidelines can also be of great help for architecture and modeling.
Indeed, guidelines are not just made to say with HTTP method or HTTP status code use.
They can define more complex design patterns and tell when to use them, like "when should we use an async pattern".
But guidelines can't contain all responses to all business specific problems.
For those problems, you can take advantage of existing APIs or existing API in your domain, you can also refer to standards, common practices or well known API to validate your choices.

Regarding needs, the only way to deal with doubt is talking to SMEs (Subject Matter Experts).
I can't count how many times doubts were solved by talking to an SME or better making 2 SMEs talk together, the designer asking a few question to "heat up" the discussion.
Actually, don't ever design API without working closely with SME.

But in the end, there still can be some uncertainty because of some unknowns (known unkowns or unknown unknowns), the “what if I’m wrong question” still stands.

# Evaluating the consequences if I’m wrong

In that case, in order to be comfortable, I evaluate the consequences of being wrong.
If I had to make a choice between solution A and solution B and chose B, I evaluate what would be the path from A to B.
Will this introduce a breaking change?
If the answer is no, that's perfect, no more doubts.
If it's yes, I wonder what is the [cost of this change](/apidays-interface-doing-apis-right-and-doing-right-apis/#tip-2-cost-of-change-varies)?
Sometimes it's fairly minimal, like when it's a private API consume by a single consumer managed by the same team providing the API.

Evaluating consequences doesn't always take away all my doubts, but knowing them and sharing them with the team so that everyone accepts them greatly reduces the worries.
Yes, but that mean I still can be wrong ... so what if I'm wrong?

# Failing

“You’ll fail, you’ll do mistakes”: that’s what I say when I start teaching API Design to someone. 
Absolutely not to put them off, but to explain that failure will happen, that it is part of the job.
Though you can drastically reduce them by doubting, removing your doubts and evaluating the consequences of being wrong, some mistakes will happen.
Just knowing that will make your life easier.
And practicing doubting will help you solve your mistakes more easily.


