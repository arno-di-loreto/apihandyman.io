---
title: Choosing between raw and processed data when designing an API
date: 2022-02-09
author: Arnaud Lauret
layout: post
permalink: /choosing-between-raw-and-processed-data-when-designing-an-api/
category: post
issue: https://github.com/arno-di-loreto/apihandyman.io/issues/287
---

Look how trees are represented in Piet Mondrian's paintings shown in this post's banner.
On the left they are represented in a figurative way, on the right totally abstracted.
This is what we'll discuss in this post, not figurative vs abstract painting, but raw vs processed data in API design.
Choosing between raw or processed data, date of birth vs age for instance, has a direct impact on developer experience but also on provider's.
<!--more-->

{% capture content %}
{% include image.html source="mondrian-composition.jpg" caption="Composition II in Red, Blue, and Yellow, 1930" src="https://commons.wikimedia.org/wiki/File:Piet_Mondriaan,_1930_-_Mondrian_Composition_II_in_Red,_Blue,_and_Yellow.jpg" %}
[Piet Mondrian](https://en.wikipedia.org/wiki/Piet_Mondrian), is one of the pioneers of abstract art, but started with figurative painting.
You may know him by his compositions such as the one above.
This post banner is composed of two of his paintings.
On the left side : [Grazing cows in a polder](https://commons.wikimedia.org/wiki/File:Mondriaan_-_grazende_kalfjes.jpg) (oil on canvas, between 1901 and 1903), on the right side: [Blossoming apple tree](https://commons.wikimedia.org/wiki/File:Blossoming_apple_tree,_by_Piet_Mondriaan.jpg) (oil on canvas, 1912).
{% endcapture %}
{% include alert.html level="info" title="About Piet Mondrian" content=content %}

# A not so simple question

Here's a question that I often ask when doing API design training sessions.
Let's say we are designing an API to "manage Users" (not the best crystal clear need ever, but it's just a basic example).
To fullfil some goal/job to be done, users' age must be returned.
As the underlying system stores users' date of birth, what should we do?

- Return date of birth only (hence raw data)
- Return age only (hence processed data)
- Return both date of birth and age (hence raw and processed data)

{% include alert.html title="Be sure of the needs!" level="warning" content="We will not discuss that here, but in real condition, you must be sure about WHY the age is needed and HOW it will be used. Always be careful and triple check that the need that has been identified is the right one." %}

# Raw data and (terrible) consumer side business logic

We could return date of birth only.
Indeed, calculating an age, the number of years between today and a date is not that complicated.

{% code language:js title:"How to NOT calculate age in JS" %}
const birthDate = Date.parse('2004-04-10');
const today = Date.now();
const differenceInMs = today - birthDate;
const differenceInYears = differenceInMs / 1000 / 3600 / 24 / 365; // 17.847940055048202
const age = Math.round(differenceInYears); // 18
{% endcode %}

It's not that complicated to calculate an age, but some people can still make errors, as shown in the JS code snippet above.
If "users" were citizens, such error could give the right to vote to someone who is not 18 yet (we can vote at 18 in France).
That means returning raw data may lead to consumers implementing some business logic the wrong way and so can lead to more or less terrible errors.

Oh, you could check that consumers actually do it well ...
But, honestly don't do that.
It may possibly work with one or two consumers close to you, but how will you manage that with dozens of consumers that are actual customers?
Spoiler: you won't.

And even if by chance all consumers could calculate the "age" well, what will happen if you, as the API provider, want to change that business logic?
What if, in the beginning, the "age" was supposed to be the raw number of years as a float number and now you changed your mind and want it rounded without decimals (yes rounded because some business logic reason).
It will be complicated to tell all consumers to change that in their own code.

And even if consumers are willing to update their code, they may simply be unable to implement that business logic.
During some recent session, one of the attendees raised a very good point: unfortunately people die.
I never have thought of that!
If the API manages "users" (whatever it means) who can die, deriving age from the date of birth will not work.
And just in case it crossed your mind, don't even dare to think returning date of death along date of birth.

So it seems better to return processed data such as an age than raw data such as a date of birth.
But avoiding consumers implementing business logic is not the only reason you would return processed data instead of raw data.

# Sensitive raw data? Processed data to the rescue!

Indeed, there's another possible problem here if we return the date of birth to fulfill our "age" need.
A date of birth could be considered a sensitive piece of data in some places, it even could help identify a user.

Just in case you're not aware of that: privacy matters whatever you build; and APIs are no exception.
And if you don't care, some regulations like [GDPR](https://en.wikipedia.org/wiki/General_Data_Protection_Regulation) will force you to care about it.

So in such a situation, having to deal with sensitive raw data, it could be interesting to process it and make it less sensitive.
Here, returning an age instead of the date of birth would solve the problem.
Note that if it's so sensitive, you may also have to rethink about why you actually store it, but that's another story.

So again, returning the age (processed data) instead of date of birth (raw data) seems to be a good idea.

# Processed + Raw data for more usages

But don't forget that your API must be usable for various use cases.
If we set aside the possible sensitivity of date of birth, maybe it could be interesting to return both values.
Indeed, date of birth could make sense for other possible use cases.
Refrain to return just what is needed for the first identified use cases.
Always expand your vision to a broader context.
How many times I've seen web services and APIs dealing with totally dumb subsets of business concepts, missing data that are important in general whatever you do ...
But data that were not needed for the first use case 🤦🏻‍♂️.

# Raw vs process data impacts developer and provider experiences

Obviously, this raw vs processed data question is not only for age vs date of birth.
You can apply this reasoning for any piece of data.

Think carefully before returning raw data that will be processed on the consumer side.
Remember that an API is supposed to be "YOUR stuff for dummies", do not delegate YOUR business logic to consumers.
It may make your API harder to use for consumers, they need your expertise to use it, and so that cripples developer experience.
They can do mistakes, and even if they don't, you won't be able to modify that consumer side business logic easily, and so that cripple your provider experience.

But do not do it too much either, check that how the data will be processed is actually YOUR job.
If not careful, you could end with a very specialized API working for a specific consumer.
And so this API will be hard to reuse in broader contexts by other consumers.
Again that impacts both developer and provider experience.

Also think about the sensitivity of the raw data you need to return.
Think about it not only fearing regulators but also for your users safety and yours, the less sensitive data, the better.
Returning processed data hiding the original raw data will avoid you many headaches, hence have a better provider experience.

And last but not least, it's not because processed data is returned that you must remove the original raw data.
It could be useful for other purposes and so enhance developer experience.