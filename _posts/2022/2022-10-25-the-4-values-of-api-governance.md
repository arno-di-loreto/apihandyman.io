---
title: The 4 values of API governance
date: 2022-10-25
author: Arnaud Lauret
layout: post
permalink: /the-4-values-of-api-governance/
category: post
---

API governance means policies, institutions, processes, and indicators. But without the alignment, enablement, collaboration, and guidance values in mind, API governance can quickly become a senseless, kafkaesque, and counter-productive API dictatorship, which will slowly but surely kill the organization, or its APIs at the least. 
<!--more-->

_This post's banner is an illustration from the first page of the Encyclopédie (Encyclopedia or Reasoned Dictionary of Sciences, Arts and Crafts)._  


# API Governance definition
I'm continuing my exploration of API governance definition. In my initial post, I attempted to [define API governance](/attempting-to-define-api-governance/) and ended up with two definitions. The first helped identify the [components of API governance](/the-4-components-of-api-governance/). The second one helped me identify the values to keep in mind when establishing and conducting proper API governance:

> API governance is enabling and facilitating people to work together on the right APIs, the right way to maximize the value created by APIs in alignment with the organization's goals and constraints.

I identify four values for API governance in the definition above:
- Alignment: "right APIs ... in alignment with the organization's goals and constraints."
- Enablement: "enabling and facilitating."
- Collaboration: "work together."
- Guidance: "the right way."

# Alignment

API governance initiatives must never lose sight of their fundamental objective. And it's not defining policies, processes, institutions, and indicators to make people respect the API law. The final aim of API governance is to "maximize the value created by APIs in alignment with the organization's goals and constraints."  

So, every policy, process, indicator, or institution must be carefully weighed regarding how it will contribute to achieving the organization's goals while complying with its constraints. 

Most API design guidelines state, "all APIs must be designed consistently." Why? Consistent APIs are more user-friendly, meaning integration between systems is faster and costs less money. For public APIs, people will be more willing to use and buy them, so more customers.   

The deeper reasons behind each policy, process, indicator, or institution must always lead to the organization's goals and constraints.  If that's not the case, don't bother to put them in place, they'll only bother everyone, slow the organization and possibly cost money for nothing.

# Enablement

API governance is not about being the API police blocking and controlling people, making them lose their time. It's about "enabling and facilitating people to work .. on APIs".

API governance must have minimal overhead and must not require efforts that would prevent people from creating APIs the right way or at all.

And more than that, an API governance initiative must put, or help to put, any possible thing in place to lower the barrier to API creation—for instance, documentation (of policies and processes), tools, or automation. But API governance can go beyond "just APIs," helping to put in place an internal API evangelization program or API design training course, for example.

But it must never do in place of people; it must never take their API ownership. It must "teach them how to fish and not bring them fish every day": favor the spirit of an "API Center of Enablement" that will teach people how to create APIs over an "API Center of Excellence" that could be the unique API factory.

The ultimate goal of any dedicated API governance initiative should even be to disappear: the "API-enabled" people and system being fully autonomous in the end.  

# Collaboration

You rarely work alone when you create APIs and even more when you put API governance in place. Different stakeholders with diverse perspectives will be involved. Even when each has the organization's goals and constraints in mind when defining their policies, processes, and institutions, they may go against each other. If all API stakeholders don't collaborate to ensure that, as a whole, everything fits together and is still aligned with the organization's goals and constraints, be ready for dire consequences. 

For instance, security policies should be carefully defined to avoid as much as possible to unnecessarily crippling user experience. I remember when it was forbidden to use the DELETE HTTP method to expose API documentation to the outside world or return a meaningful error explaining how to solve the problem caused by an API call.

Without collaboration between all stakeholders, there will be no effective API governance and no effective use of APIs.

# Guidance

With API governance, policies have to be defined, among other things. It's a certainty. But these rules and guidelines don't have to be abstruse, with little explanation of how to apply or implement them. People will need some overall guidance to be sure they use those _hundreds_, if not more, of rules and guidelines. People will need clear explanations to fix issues when they violate those rules.

People applying policies need to understand them without effort. They will need "cross concerns recipes": instead of just being an endless separated list of rules (design vs. security, for instance), guidelines can be a list of actionable recipes merging as many concerns as possible, like "how to design a search operation" or "how to upload a file." Some rules can be automated and integrated into design tools or CI/CD, but their error message must be clear and informative, to help users to fix the issues.

If the user experience is a significant concern when creating API, it must also be the case when implementing API governance. Forget that, and be sure your rules will never be applied correctly if applied at all.

# Don't forget the fundamental objectives

I think that's a common flaw of every policy-based system to lose sight of why it is put in place. The people implementing them focus on putting policies in place, possibly institutions, processes, and indicators around them, because that's the objective they have been given; that's what governance is made of, after all.  But with these values in mind, it may be easier to implement the right governance in the right way.