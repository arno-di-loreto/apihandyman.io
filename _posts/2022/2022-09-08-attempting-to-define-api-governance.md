---
title: Attempting to define API governance
date: 2022-09-08
author: Arnaud Lauret
layout: post
permalink: /attempting-to-define-api-governance/
category: post
---

In the collective unconscious, API governance often rhymes with API police. Reducing API governance to the need for order caused by the chaos of an organization's myriad APIs is too reductive, and it risks not looking at the problem at hand from the right angle. Why not define API governance relatively to IT governance, corporate governance, and governance to better understand what it is?
<!--more-->

_This post's banner is a detail of the frontispiece of the "Encyclopédie ou Dictionnaire raisonné des sciences, des arts et des métiers" (Encyclopedia or Reasoned Dictionary of Sciences, Arts and Crafts) drawn by Charles-Nicolas Cochin and engraved by Bonaventure-Louis Prévost._

# The origin of API governance
It's not that easy to find a definition of API governance. My ideas on the topic were not entirely clear, so I decided to work on its definition relative to other governance. I think API governance should be seen as a direct descendant of IT governance which descends from corporate governance, which descends from governance.

Governance is managing and overseeing an organization's control and the _system_ for doing this. It is also the decision-making among the actors involved in a collective problem by which stable practices, social norms, customs, or institutions (an organization founded for religious, educational, professional, or social purposes) are established, reinforced, and reproduced.

Corporate governance is externally and indirectly guiding, controlling, and evaluating a company and the system for doing this. It provides the structure through which the company's objectives, the means to achieve them, and how to monitor performance are defined. It implies balancing all organization's stakeholders' interests. Responsibility, accountability, ethical behavior, corporate strategy, compliance, and risk management are the main areas of governance. Other areas are, for example, environmental awareness or talent acquisition. It differs from management; the people exercising governance, the governing agents, don't have direct control and are not part of what they govern.

Information Technology (IT) governance is a subset of corporate governance that focuses on taking advantage of IT efficiently to enable the organization to achieve its goals, to maximize the creation of value. It aims to align business and IT strategies while identifying and addressing risks, ensuring compliance with regulations, and monitoring performance. 

# How API governance relates to its ascendants
Like any governance, API governance refers to the decision-making among the actors involved in a collective problem (creating APIs helping the organization achieve its goals), by which stable practices, processes, policies, or institutions (organizations created for educational or professional purposes) are established, reinforced, and reproduced. For example, defining security, API design or API cataloging policies, having an API design review process, or creating an API center of enablement are part of API governance. These elements aim to facilitate, guide, and standardize the creation of the right APIs in the right way to help the organization to achieve its goals (and bring order to the API chaos in the making).

Like Corporate governance, API governance is _externally and indirectly_ guiding, controlling, and evaluating a company's APIs and the system for doing this. API governance is not creating APIs (API product management) or managing APIs (API management). People will make and manage APIs taking advantage of the institutions and following the processes and rules defined by API governance. The resulting APIs are being evaluated with the indicators defined by API governance. Though often people directly involved in the creation of APIs participate in governance (it is even highly recommended to ensure realistic governance), API governance agents should act as if they don't have direct control over APIs.

Like corporate governance or IT governance, API governance implies balancing _all_ stakeholders' interests and the company's objectives. The primary API stakeholders are the API providers (all members of API product teams) and the present and future API consumers. But many of the organization's stakeholders are interested in APIs, for example, the security teams, the infrastructure teams, the business line managers, and even the board members or regulators.

Like IT governance, API governance is about what should be done and how it should be done and is both driven by IT and business. It requires aligning both IT and business. It covers all aspects of APIs, from their business inception and business model definition to design, implementation, exposition, and cataloging to (API) talent management (API design skills, internal API evangelization). It covers all types of APIs, whatever their visibility, so it concerns all public, partner, and private APIs. It's about everything that will help maximize all APIs' value.

# Attempting to define API governance
Now that all that is said, how to define API governance?

## Paraphrasing other governances definitions
As a descendant of governance, corporate governance, and IT governance, and paraphrasing their definitions, API governance could be defined as follow:

> API governance is establishing and overseeing decision-making, policies, practices, processes, and institutions to enable an organization's people to collectively achieve its goals by efficiently taking advantage of private, partner, or public APIs. It aims to align APIs with business and IT strategies, to monitor and maximize the value created from them while identifying and addressing risks and ensuring compliance with regulations.

## Trying to simplify the definition
Simplifying the previous definition leads to this:

> API governance is enabling and facilitating people to work together on the right APIs, the right way to maximize the value created by APIs in alignment with the organization's goals and constraints.

# The tree that hides the forest
I'm pretty satisfied with those definitions, although they do not provide all the tiny details of API governance. I feel the global ideas they describe are relevant and cover the topic from a high-level perspective. I'll keep the small details for other posts.

# Sources
- Governance:  [Merriam-Webster dictionary](https://www.merriam-webster.com/dictionary/governance), [Cambridge dictionary](https://dictionary.cambridge.org/dictionary/english/governance),  [Wikipedia](https://en.wikipedia.org/wiki/Governance), [Huffy, 2011](https://en.wikipedia.org/wiki/Governance#cite_note-Hufty_2011-2); [Lijun, 1988](https://en.wikipedia.org/wiki/Governance#cite_note-13)
- Corporate Governance: [Wikipedia](https://en.wikipedia.org/wiki/Corporate_governance),  [Investopedia](https://www.investopedia.com/terms/c/corporategovernance.asp), [GRC glossary](http://www.grcglossary.org/terms/governance)
- IT Governance: [Wikipedia](https://en.wikipedia.org/wiki/Corporate_governance_of_information_technology), [Gartner](https://www.gartner.com/en/information-technology/glossary/it-governance), [Thoughtworks](https://www.thoughtworks.com/insights/articles/lightweight-technology-governance)
- API Governance:  [Some thoughts on API Governance (API Evangelist, 2021)](https://apievangelist.com/2021/11/13/some-thoughts-on-api-governance/), [What is API governance (Erik Wilde, 2020)](https://youtu.be/lakFsqIiiLU),  [Human Centered API Governance (Arnaud Lauret, 2021)](https://apihandyman.io/human-centered-api-governance/) 