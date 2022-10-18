---
title: The 4 components of API governance
date: 2022-10-18
author: Arnaud Lauret
layout: post
permalink: /the-4-components-of-api-governance/
category: post
---

After formally defining API governance relative to IT governance, corporate governance, and governance, let's dive deeper and describe the four components of API governance: policies, institutions, processes, and indicators.
<!--more-->

_This post banner is a part of the "Figurative system of human knowledge", the structure that the Encyclopédie (Encyclopedia or Reasoned Dictionary of Sciences, Arts and Crafts) organised knowledge into._  

# API governance definition
In a previous post titled [Attempting to define API governance](/attempting-to-define-api-governance/), I described API governance as follows:  

> API governance is establishing and overseeing decision-making, policies, practices, processes, and institutions to enable an organization's people to collectively achieve its goals by efficiently taking advantage of private, partner, or public APIs. It aims to align APIs with business and IT strategies, to monitor and maximize the value created from them while identifying and addressing risks and ensuring compliance with regulations.

According to that previous post and this definition, API governance relies on four main components:
- Policies (how)
- Institutions (who)
- Processes (do)
- Indicators (monitor)

# Policies (how)
API governance's policies and common practices are repeatable and shared rules and guides which define **how** APIs and API-related work should be done from a wide range of perspectives. This is probably the most known part of API governance, thanks to API design guidelines. API governance is even, unfortunately, too often reduced to this aspect alone, but those policies and common practices are far more than that. 

They can cover a wide range of topics impacting the creation and management of APIs across their whole lifecycle, from design (the famous API design guidelines) and security to business models and terms of service. Domain standards or regulations could dictate some of those policies and common practices. For instance, [PSD2](https://ec.europa.eu/info/law/payment-services-psd-2-directive-eu-2015-2366_en) Open Banking APIs must follow EU regulators' requirements and may apply a format such as the [Berling Group](https://www.berlin-group.org/) one. And some policies and common practices must also cover API governance itself. For example, it's essential to define guidelines explaining how to create API design guidelines or how to conduct an API design review.

# Institutions (who)

> Institution: an organization founded for religious, educational, professional, or social purposes

The "institutions" mentioned in the API governance's definition represent **who** works on APIs. These are the different sub-organizations (inside the organization putting API governance in place) that directly or indirectly work on APIs. It comprises two groups, the API governance organizational representation and the various API stakeholders.

The most known and visible group involved in API governance is the API governance organizational representation itself. It can be, for example, a dedicated API CoE (Center of Excellence or Enablement), an API guild (a group of API practitioners scattered across the organization), or both. 

The second group, the API stakeholders, are all the sub-organizations (teams, services, business lines, board of directors, ...) involved directly or indirectly in creating APIs. These stakeholders can be, for example:
-   API product teams (the ones actively developing and implementing APIs)
-   Security teams (who need to ensure APIs are secure)
-   API platform teams (who manage CI/CD pipelines and API gateways)
-   Internal API evangelists (who will promote the use of APIs, maybe conduct training sessions)
-   Legal teams (who can be involved in API's terms of services).

# Processes (do)
"Processes" is how (API-related) institutions (including API stakeholders and API governance representation) **do** APIs and API governance. It encompasses how they will collaborate, interact, apply policies, and react to indicators evolution. It also covers how the API governance representation operates and how the policies are created and modified.

Processes may involve various institutions and be purely human-based, automated, or both. They can also be interdependent. For instance, an API review process may involve business, development, and security teams and rely on human reviews and automated linting. People may check that the API will fulfill the proper business needs, that it is implementable, easy to understand and use, and does not unduly expose sensitive operations or data. And machines may verify that the design respects the organization's look and feel and proposes authorized security modes. If a limit, an error, or a missing element is detected in design guidelines during the creation of an API, it will trigger the guidelines revision process. The 100% automated API production deployment process could only run if the API review process is OK. 

# Indicators (monitor)
API governance indicators are used to **monitor** the value created directly or indirectly by APIs and their alignment with the organization's goals and constraints. As API governance participates in that and aims to impact it, it should also be monitored to evaluate its effectiveness.

Like policies, indicators may cover a wide range of perspectives, from pure API statistics, such as the number of APIs consumed by more than one consumer, to business indicators, such as the number of new customers acquired through APIs, and governance indicators, such as the length of the review process.  

# It looks a bit scary, no?
So API governance is composed of policies, institutions, processes, and indicators. But described like this, it looks a bit scary, like API police or an API dictatorship. And that's indeed a risk if governance is not conducted with the right spirit. That also looks like a massive sum of elements to put in place. Are they all needed with all features right from the start? Hopefully, no. Governance can be put in place step by step. 

But these are other stories I'll keep for later posts. In the meanwhile, don't forget that more engaging second definition of API governance coming from my [Attempting to define API governance](https://apihandyman.io/attempting-to-define-api-governance/) post:  

> API governance is enabling and facilitating people to work together on the right APIs, the right way to maximize the value created by APIs in alignment with the organization's goals and constraints.
