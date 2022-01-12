---
title: Nobody cares about API design guidelines
date: 2022-01-12
author: Arnaud Lauret
layout: post
permalink: /nobody-cares-about-api-design-guidelines/
category: post
---

"Did you read our API design guidelines? Yes we did! ... Sorry, but I don’t think so".
Let’s be honest, besides those who write them, nobody cares about API design guidelines.
Some don't read them, some don't agree with them.
Should we punish the offenders?
Though it is sometimes tempting, no.
Should we get rid of API design guidelines?
No, we can’t.
But how can we make people care about it?
<!--more-->

# Why not getting rid of guidelines?

No, we can't get rid of our API design guidelines because "nobody" reads them.
Actually, they're useful and a few people read them.

As an API design reviewer, I constantly have to refer to them during API design review.
I refer to them to support what I say and avoid endless discussions.
Guidelines are our tables of the law and we must follow them.
I don't want to lose my time discussing for the 100th time how should be named the property holding the list in the response of `get /customers`.
I also use them to find solutions to some design questions and to refresh my memories.
Guidelines makes reviewer more comfortable; with them, they don't just give an opinion, they're backed by written rules. 

Also, without guidelines, I could slightly change a design pattern without noticing it.
And I'm not the only reviewer, a single written source of truth ensures that multiple reviewers are consistent (at least for what concerns the stylistic perspective).
Guidelines are there to ensure consistency, that's their primary objective.
It's a major concern when you want to provide the best possible developer experience.
This can't be achieve without them.

So we can't get rid of them, maybe they need to be tweaked?

# Simplify and enhance guidelines

“Be honest, you didn’t read our company API design guidelines.
Why denying it, I’m reviewing your API and I can see you didn’t read them seriously.
Indeed, rule #245 about over-resilient resource has not been applied.”

Sometimes people will try to read guidelines but they can be too complex for mere mortals.
It could be because they are written in some "too smart and complex expert that shows off" style.
If people need 3 PhDs in computer science to understand them, those guidelines are totally wrong, change them to make them understandable by anyone (like you're supposed to do when you design APIs).
It could also be because they go against common practices, what everybody does in the outside world.
If that is so, those guidelines are totally wrong, change them to be consistent with the rest of the world (like you're supposed to do when designing APIs).

Sometimes, guidelines are good but not easily actionable.
Indeed, guidelines composed of hundreds of rules are a nightmare to use, even when those rules are perfectly understandable by anyone.
Providing actionable recipes like "how to search something", "how to manage sensitive data", or "how to deal with long operations" is a must have.
Each recipe included everything, every single rule that must be apply explain in a user friendly way: when and why using this recipe, HTTP method to use, path design, inputs, outputs, how to handle errors.
That actually helps to ensure that guidelines are realistic, if any simple recipe is a nightmare to describe, maybe your rules are too complex.

# Foster agreement

Some people don't agree with guidelines.
Sometimes they're just assholes, sometimes they just need explanation about why rule #245 is that way, and sometimes they're actual good people caring about API design.

For real stubborn/toxic/full of themselves assholes, unfortunately, I don't know if anything can be done.
Fortunately, I don't have met much of them and I always was in a position where I could say "ok, let's not work together then, there are plenty of other people who want to work with me, but if you change your mind, the door is still open".

But sometimes, people you could consider as "assholes" because they don't agree with you are people who just don't get it; they need some explanations.
Once they get it, they're convinced.
That's why it's really important to explain why each rule exists in your guidelines, if there's no reason ... maybe it shouldn't exist.

And last but not least there are a few people who are really good at designing APIs and care about it.
If they don't agree with you, maybe you should listen to them.
Don't be an asshole yourself.
You probably should include them in the loop of your guidelines creation/evolution.
Actually, include more people in the loop brings various sensibility, various experience and this is good for your guidelines.

# Provide more than guidelines

The "guidelines" (wiki, website) are never enough.
Even the best ones.
You'll need to make them available in other more actionable forms.

## OpenAPI Specification templates and fragments

You can provide ready to use specification templates and reusable fragments.
Nothing better than a complete OpenAPI file containing everything you need to "search something", you can take advantage of descriptions to explain your guidelines and point to them.
Designers just have to adapt that template to their use cases.
It's also fairly common to have data structures, parameters, headers that are always the same.
Why not define them once and for all in reusable OpenAPI spec fragments that can be referenced.

## Linter

Even with templates, people can make mistakes.
You'll need to provide a way to lint API descriptions in order to help designers fix most stylistic problems themselves (and learn how your guidelines work in the making).
You can use [Stoplight Spectral](/toolbox/spectral/) to do so.
Warning: having a linter will never, ever, replace API design reviews.
A linter won't tell you if an API is the good ones, if a name is the good one, if using this design patterns was a good idea.

# Make everybody love your guidelines

So, if you want people to care about API design guidelines:

- Keep them simple to understand and to use
- Explain and listen to foster agreement
- Make their use seamless by providing helpers and tools