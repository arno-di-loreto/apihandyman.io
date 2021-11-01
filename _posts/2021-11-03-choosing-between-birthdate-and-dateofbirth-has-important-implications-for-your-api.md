---
title: Choosing between birthDate and dateOfBirth has important implications for your API
date: 2021-11-03
author: Arnaud Lauret
layout: post
permalink: /choosing-between-birthdate-and-dateofbirth-has-important-implications-for-your-api/
category: post
---

On LinkedIn, someone asked me what to choose between `birthDate` or `dateOfBirth`.
That looks like a very simple question, but it's absolutely not.
Choosing between two names is the tree that hides the forest.
Besides having impacts on understandability, choosing a name can have impacts on naming patterns, data, or privacy which are quite important topics for APIs. 
<!--more-->

_Banner photography: [Contrasting Tree Types Coexist in a Forest](https://commons.wikimedia.org/wiki/File:Contrasting_Tree_Types_Coexist_in_a_Forest.jpg) by [Wingchi](https://commons.wikimedia.org/wiki/User:Wingchi). [Creative Commons Attribution-Share Alike 2.5 Generic](https://creativecommons.org/licenses/by-sa/2.5/deed.en)_

# Is that US english?

As the `birthDate` or `dateOfBirth` question followed my Excuse my French API post, and as it is a debate I often have with other ESL API designers, I wanted to check what is said in US english: "birth date" (`birthDate`), "birthdate" (`birthdate`) or "date of birth" (`dateOfBirth`).
While "birth date" does not seem that common (compared to "birthdate"), they are all acceptable terms to represent "the date on which a person was born" (Oxford US english dictionary).
OK, but which one is the "good" one?
Well, assuming that "date of birth" seems to be used on official documents, it could make sense to use this option.
But is it as simple as that?

# Type as prefix or suffix

The initial "`birthDate` or `dateOfBirth`" question leads to another question: when explicitly typing a property, by adding its type to its name, should it be a prefix or a suffix?
As I'm a bit obsessed with consistency, once I've seen a `dateOfBirth` property, I expect to see all other date properties using the `dateOf` pattern, `dateOfSubcription` for instance.
And if it's `birthDate`, I'll expect to see `subscriptionDate`.
But more than that, as I am a consistency extremist, I may expect all "typed" properties to use the same pattern, for instance `subscriptionNumber` or `numberOfsubscription`.
In such a case choosing one form or another can have major impacts on your API (or APIs) look and feel.
OK, but which one is the "good" one?

Using a suffix, is actually the most common pattern: I've seen much `userId` and not a single `idOfUser`.
But that's not the only reason why I would recommend to use the suffixed version.
Using a suffix put the generic part of a name at the end of it and the specific one at the beginning.
Using suffixes, I get the most important information first when reading names.
But more important, when properties are sorted by name, it's easier to see functionally related properties because they are close to each others, while properties get sorted by type when using prefixes

- Prefix:
    - dateOfSubscription
    - idOfBankAdvisor 
    - idOfUser
    - numberOfSubscription
- Suffix:
    - bankAdvisorId
    - subscriptionDate
    - subscriptionNumber
    - userId

The suffix pattern also leads to shorter and less complex names: what if I want to represent a "user's date of birth"?
With the suffix option, that's a `userBirthDate` (or `userBirthdate`), with the suffix that's a `dateOfBirthOfUser` which is a bit pompous, or possibly a `userDateOfBirth` which screws the prefix idea and kills the hierarchy of information in the name.

# Data format and/or value

As an API designer or an API design reviewer, I always double check what is the format and value of a property.
In that case, if it's the first time a `whateverDate` or `dateOfWhatever` is added into an API, it's time to choose a date format that will be applied to all other dates.
Will you use a Unix timestamp (number of seconds since 1st January of 1970) or an ISO8601 string.
And in the ISO case, will you use the time precision with timezone or not?
If that format already has been defined, you'll obviously have to use it.

And that's not only for dates but for any data.
If we're talking about a `userId`, what is the actual value of a user's id?
Is this the id column in the `USER` table or something else?
Maybe a more well known value, shared by various systems using the API.
For a `currency`, is this a internal currency code? a label? (in which language?) An ISO code?

I will not answer all those questions here, I'll keep that for other post, the one thing to remember here is that a property is more than just a name.
And speaking of that, thinking beyond just names, we didn't talk about "why date of birth"?

# Back to needs: what about privacy?

{% include quote.html 
    source="French saying"
    text="The tree hides the forest" %}

Indeed, all the above and especially the naming discussion is only the tree that hides the forest, it lured us away from a real and important problem.
As an API designer or API design reviewer, seeing such "personal data" (as europeans say in GDPR data privacy regulation) or "personal identifiable information" (PII in the US), I always wonder if we actually need it in the API before discussing its name.
Maybe "date of birth" can be replaced by a fuzzier "birthday" (month and day but without year) or just an "age".
Maybe it can be removed if it is not absolutely needed.

# Choosing a name is sometimes more than what it seems

So, in that case I may simply not have to choose between `birthDate` or `dateOfBirth` because the property would not be needed.
Designing APIs, delivering API design training sessions or doing API design reviews taught me that such seemingly simple question can have important implications for an API.
As you have seen, choosing a name is sometimes more than just choosing a name.
Always expand the discussion, never get stuck at a too narrow "just name" level, evaluate the local but also global implications of your choice to include or not a data, to define its value/format, and how to name it using a pattern and/or hierarchy.
