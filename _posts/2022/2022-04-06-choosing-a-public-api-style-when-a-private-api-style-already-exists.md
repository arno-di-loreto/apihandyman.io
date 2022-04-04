---
title: Choosing a public API style when a private API style already exists
date: 2022-04-06
author: Arnaud Lauret
layout: post
permalink: /choosing-a-public-api-style-when-a-private-api-style-already-exists/
category: post
---

"What will be the style of our public/partner APIs? Should we reuse our existing private APIs style? Should we restart from scratch and use a totally different style?" This discussion happens quite often in organizations starting their public API journey (and if it did not happen, it must happen.) This discussion can have important consequences that must be carefully evaluated.
<!--more-->

{% include banner-author-link.md %}
_In case you don't get the reference: The API Handyman is represented with a 80s mullet haircut, "business up front, party in the back"._

# From look and feel to life and death

After taking private APIs more or less seriously, your organization is ready for the next step on its API journey: providing APIs to the outside world. It could be partner APIs, provided to a few selected partners or customers who have been through a good old "let's meet and sign some papers" process. It could also be public APIs that will be consumed in a self-service fashion by almost anyone.

In either case: the DX (developer experience) offered by those APIs will be critical to their success. An API's DX is determined by multiple factors from its purpose to how it's simple to make API calls and everything in between (and beyond). Among all those factors, the design of an API plays a critical role in DX. A well-designed API will be easy to understand and easy to use. Such APIs will have a higher adoption rate and requires less support. On the opposite, terribly-designed public/partner APIs will not be used, and if they are used they will require a high level of support.

A good way to avoid miserably failing your public/partner API initiative is to ensure that your APIs share a common style, a common "look and feel". But that's not enough, this common style must participate in the creation of "easy-to-understand-easy-to-use" APIs. Indeed you can create terrible APIs that all look the same. And last but not least, if that style ease designers' job that is more than welcomed. A complicated style will only lead to terrible APIs because only a few experts will be capable of applying it.

Hence the importance of the question, of which "style" to use for public/partner APIs. The style, the "look and feel" of your APIs have a major impact on their life and death.

Choosing the API Style of public/partner APIs is a choice that must not be done by default (without choosing) but knowingly. Because once APIs start to be consumed by third parties, it's extremely difficult to modify anything.

# Usual scenarios

When that question arises (and remember it MUST arise) in a context where private APIs already exist, I often present the possibilities with the 3 following scenarios.

- Keeping existing style as it is
- Simplify existing style to target common practices
- Redefined from scratch a totally new style targeting common practices or a standard

The first option is to simply stick to the existing style. That's a totally valid option if the existing style leads to easy-to-understand and easy-to-use APIs hence is free of bizarre local specificities and close to outside world common practices. If that's not the case, I recommend studying the second scenario. Indeed, APIs that are uniform between themselves but go against common practices will be hard-to-understand and hard-to-use.

The second scenario consists in taking the existing style and trying to simplify it in a backward-compatible fashion if that's possible. The idea is to limit the breaking changes to what is absolutely necessary, or at least keep a certain spirit of the original style. It could simply consist in removing certain edge cases from the guidelines. But if there are too many changes to do, maybe it would be better to restart from scratch with the third option.

The third option consists in redefining the public/partner API style from scratch without taking care of the existing API style. It could even be interesting to see if there are no standards to take advantage of (I'll write a dedicated post on that topic).

The problem is that if we stop here, we only envision that question from the public/partner API perspective: "Let's choose the style that will work the best with the outside world". The choice cannot be made without evaluating the impacts on the whole organization and all of its APIs.

# Different styles or same style

Behind the "which style will we use for our public/partner APIs?" question lies an even more critical one: "will we have the same or a different style for public/partner vs private APIs?".

In my opinion, the question is definitely no in the long run. While it's totally understandable to have a transitional period where existing private APIs may not be updated until needed. It could cost a lot of money to update all existing private APIs to the new style. I highly recommend applying the new public/partner style to private APIs as soon as possible, starting at least with any new API.

Indeed, using different styles for private and public/partner APIs forbid applying the Jeff Bezos mandate, you can't turn a private API into a public/partner one easily. You'll need a bit of work to transform the private style into the public/partner one.

That also prevents eating your own dog food at two levels. First, if your public/partner APIs are not private, you won't use them, you won't discover their flaws, and you won't improve them. Second level: the style itself. It will be less used and so less improved. Only a few experts will learn to design APIs the public/partner way, they won't have many opportunities to grow their skill and propose style improvements as there are usually that less public/partner APIs created than private ones.

That may to an extent promote a counter-productive organizational repartition between the team creating public/partner APIs and the other creating private APIs. That would severely cripple the API-First initiative at the organization level. Indeed, why should we care about our private APIs if the public/partner team will clean the mess when necessary?

And even if you take the strict "2 styles" path, the public/partner style will win in the long run. People of your organization will use the public/partner APIs and be fed up with how they are different (and better) than private APIs. People will be fed up with spending time and money adapting API for public-facing consumers. People building private APIs will be fed up with being considered second-class citizens (vs people building public/partner APIs). People will question the legitimacy of that "2 styles" decision.

# Choose knowingly

So don't take the public/partner API style question lightly. This question is critical for the success of your public/partner API initiative but it will also have a huge impact on your whole organization's API-first initiative.