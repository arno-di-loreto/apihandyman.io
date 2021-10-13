---
title: Excuse my French API, or being an English as a second language API designer
date: 2021-10-13
author: Arnaud Lauret
layout: post
permalink: /excuse-my-french-api-or-being-an-english-as-a-second-language-api-designer/
category: post
---

This post is dedicated to all English as a Second, or Foreign, Language (ESL, EFL) API designers. 
Et tout spécialement mes compatriotes français!
Designing APIs is already not that easy when you design them using your native language.
But, it’s even more difficult when using a second one.
So let’s see how to avoid design frenglish, itaglish or whateverglish APIs.
<!--more-->

# Why should I care about english

Your API is public, well unless your a government that MUST use local language because of some law, use english.
Why?
English is the lingua franca of software.
Using it will make your API easily understandable by most people using APIs on earth.
That's quite a huge market you don't want to miss.

Your API is private?
My very first post was about [why (private) APIs should be designed in English](https://apihandyman.io/why-you-must-design-your-private-api-in-english/).
To make it short: your private API will not be private forever, so better use english just like for public APIs.

Ok, APIs MUST be design in english, but why should we really care about translations?
Well, it would be a pity to ruin the success of your API just because people actually don't understand what it is talking about.
And once your API is consumed ... it will be hard to fix its awkward whateverglish design.
So you better take care about english translation.

# When should I use english during design process

In order to avoid loosing time when designing an API, I use the following path:

1. Analyse needs and decompose them to identify a list of goals/jobs to be done, the function that will compose the API using natural language and native language
1. Identify business concepts (resource) and action that apply to them (still using natural language and native language)
1. Translate the business concepts and action in english
1. Design resource paths (in english) and choose HTTP methods corresponding to actions
1. Model data in native language
1. Translate data in English

It’s the actual method I describe in my book that allows to avoid HTTP heated discussion while investigating needs, I just added extra steps for translation.
The idea is the same, keeping the translation complexity AFTER the actual need investigation and design in order to avoid being polluted during that very important steps.
It’s easier to think and discuss using a language you master than English. 

# API Design translation tips & tricks

Here are a few tips and tricks that should help you avoid terrible translation mistakes.

## Use US english

The lingua franca of software is not just "English", but US English, don't forget that during translation.

## Hire professional translators

For public APIs, if you're not sure about your english, don't think to much: hire professional translators.
For private APIs, that could be overkill but remember that sooner or later [your private APIs mays become public](https://apievangelist.com/2012/01/12/the-secret-to-amazons-success-internal-apis/).

## Take advantage of more or less official translations

If you're lucky enough you can find official translations for your domain.
You could take advantage of glossary but also be inspired by existing APIs or standard.
For instance, if you work in banking/finance, you should take a look at the ISO20022 standard.

## Use online dictionary wisely

Unfortunately, you won't always find the ready to use translation and you'll have to use one of the many online your language to english dictionaries.
But depending on the one you use and how you use it, the result may not be as good as expected.
Here's how I proceed:

1. I translate full sentences giving more context about the words I want to translate, using either https://www.linguee.fr/ (beware of the translations examples coming from non-english websites shown in Linguee's results) and https://www.deepl.com/ (from the Linguee creator, pretty good one).
1. I check the definition of the english word found using a US English dictionary such as https://www.lexico.com/. If you don't do that, you may have some really bad surprises
1. I do a final check by looking for the word I found using Google. Reading documents using the found word can help to choose between various options

As you can see, the idea is to never, ever just rely on word for word translation.

## Translate (or not) acronyms

There are two types of acronyms, the ones that can be translated and the ones that can't.
For instance, in french we use TVA for "Taxe sur la Valeur Ajoutée", which can easily be translated into "Value Added Tax", giving the VAT acronym.
VAT is being a well know acronym, across many countries, you can actually use it in your API design instead of TVA.

But what about more specific concepts that only exists in your country?
I'w working with teams creating APIs in the employee savings domain.
This domain deals with highly specific concept; the PERCO, "Plan d'Epargne pour la Retraite COllectif", for instance.
If I translate this literally, I get "Group Retirement Savings Plan" or GRSP ... which means nothing for people outside of France AND for french people.
In that case, it would be better to keep the french acronym in the design, adding a description might help non french people to understand what this means.

But just think about this last option: not using this highly specific acronym?
Could it be replaced by a more generic word like "saving plan"?
This is not something that will always work, but it's worth the try because keeping acronym that are specific to your country could be a burden for your design and annoy many users.
