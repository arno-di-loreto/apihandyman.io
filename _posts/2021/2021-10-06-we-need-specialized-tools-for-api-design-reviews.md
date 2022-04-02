---
title: We need specialized tools for API design reviews
series: API Design Reviews
series_number: 3
date: 2021-10-06
author: Arnaud Lauret
layout: post
permalink: /we-need-specialized-tools-for-api-design-reviews/
category: post
codefiles: api-design-reviews/
---

Doing an API design review is not only about that, but it will require, sooner or later, to analyze an interface contract.
Use the wrong tools to do so, and reviews will become a terrible, never-ending burden.
Use the right tools, and you'll become a formidable machine, doing reviews at light speed, never missing the tiniest problem or question.
But, after dozens of reviews, you may realize that, despite using the "right" existing tools, the API space actually lacks API design reviews specialized tools.
<!--more-->
This post is a slightly write up of my "Taking advantage of OpenAPI for API design reviews" talk I gave at the 2021 API Specification Conference.

# ~~Reviewing API designs~~ Helping people

I work with many different teams helping them create and evolve many different APIs.
I can do around 150 API design reviews per year on average.

When I do an API design review, I’m not being the API police.
I’m here to help people create the best possible API in their context.
I’m here to provide guidance and help people grow their design skills so that one day I won’t be needed anymore. 

Though I'm not a API policeman, the closer to our API design guidelines the design is, the better.
Because having consistent APIs make them easier to use.
But that’s not the only thing to look at, an API must be reviewed beyond the guidelines.
It’s important to investigate what it is made for, what needs this API is supposed to fulfil.
And then to check if the design is actually responding to all that.
But not just "responding to all" that but doing it in the best possible fashion.
So, I also check if the design is easy to understand, easy to use and easy to evolve.

And how do I do all that?
Well, by investigating business domain and IT concerns, asking stupid questions (tons of them), making people talk together, listening, showing empathy, challenging beliefs and ideas … and obviously analyzing interface contracts.

# Analyzing an interface contract

Depending on the size and number of APIs you review, the task of reviewing API designs will be more or less complicated.
But if analyzing a single interface contract can be quite complicated by itself, it can be even more complicated if it’s described in a non standard format such as a wiki page or a spreadsheet.
Hopefully most people I’m working with use the OpenAPI specification to describe their APIs. 

## Reading OpenAPI files is a terrible idea

I've seen people making API design reviews by directly reading OpenAPI files such as the one below.
That's not something I actually do, you can give it a try, read this file and tell me what you think.

{% codefile title:"Let's read this OpenAPI file" file:motu-openapi.yaml %}

I don't know how you feel, but reading this raw OpenAPI file do not really help me to make a complete review of the design.
Oh, I can still spot useful but disturbing pieces of information based on the `info` section:

1. Because of version number `1.0.3_build156`, I can guess this file has been generated from code, which is usually not a good sign. Maybe the team has coded everything and just want a green light to deploy their API on the API gateway (Sorry, that's not my job, and too bad, it's probably too late to fix something as everything has already been coded)
2. The "The Masters of the Universe Web Site API" `description` let me think that this API could be been design solely to be the backend of this specific website and thus may not be reusable in other contexts

That's interesting, but when I do an API design review my first move is trying to guess what the API is made for by looking at all of its operations, all GET /this and POST /that and their summaries.
And that is not easy to do just reading the raw OpenAPI file.
Using a code editor, I could close a few sections but even doing so I can't have this overview totally.

I also like to have an overview of the data models in operations' responses, evaluate their complexity, their depth.
But reading a raw OpenAPI file all I have is a flat perspective of each model.
I have to jump from one `$ref` to another to "see" a full schemas ... 
And so ,I actually don't see anything here.
Or worse, just like in the parable of the 3 blind men the elephant, I could see a snake or a wall instead of an elephant.

So, reading a raw OpenAPI file is definitely not for me.
And I highly doubt that anyone could actually do an efficient API design review doing so.

## Not all documentation tools are equals

As far as I remember, I always took advantage of documentation tools to do API design reviews.
I especially use the good old SwaggerUI.
I don't use it only because it was the only one available when I started being an API design reviewer and I don't want to change my habits.
No, I use it because it's the one that fulfils my needs for this specific task.

I actually don't like SwaggerUI API documentation when I learn to use an API, I prefer ReDoc or Stoplight Elements renderings. But reading API documentation is different from reviewing an interface contract.

{% include image.html source="swaggerui-overview.jpg" %}

SwaggerUI allows me to easily get the overview of operations, I can see all GET /this and POST /that and their summaries in a quick glance.
That helps me to confirm the intent of the API, if it was explained to me before, or guess it if not.

{% include image.html source="swaggerui-operation.jpg" %}

Using SwaggerUI I can also check that the returned schema name actually match the resource path.
In ReDoc the name of the returned schema is not shown and when doing a review, that's quite annoying.

Once I've made this first pass, I analyze in depth each operation.
Checking parameters, responses and their schemas.
Regarding the analysis of schemas, I would prefer ReDoc of Stoplight Elements.
Whatever the tool, I can easily spot data models where everything if optional (typical on generated interface contracts).
I can also check schema depth.

When I started doing reviews I had to carefully analyze every bit of the contract in one of those documentation tools.
Especially to ensure that the design was conforming to our API design guidelines.
Checking every single property is in lowerCamelCase, path structure is valid, no HTTP status code is missing, etc, etc, etc, ...

Doing those repetitive (mostly dumb) checks, review after review, hundreds of times, I nearly lost sanity.
And there are not only dumb checks that need to be done.
Checking consistency between schemas for instance is extremely hard to do with regular documentation tools.

## Beyond linting

Hopefully, Stoplight Spectral just came out at that time.
I will not go in all the details here (You can watch my ["Augmented API Design Reviewer" talk](/the-augmented-api-design-reviewer/) for that), but to make it short, Spectral is a JSON/YAML linter.
You can define rules that Spectral will run against a document to spot if some elements are breaking them.
You can check path structure, property names case, if all expected HTTP status codes are defined on all operations, or if all 4xx and 5xx error response return a data model matching your standard error schema.

For instance the following ruleset contains a single that scans all properties to detect if some of them have a name containing a number:

{% codefile title:"Spectral Demo Ruleset" file:demo-ruleset.yaml %}

You can run the following command after installing Spectral to see it in action:

{% code title:"Using escape variable" language:bash %}
[apihandyman.io] $ Spectral lint -r https://apihandyman.io/code/api-design-reviews/demo-ruleset.yaml https://apihandyman.io/code/api-design-reviews/motu-openapi.yaml
OpenAPI 3.x detected

https://apihandyman.io/code/api-design-reviews/motu-openapi.yaml
 358:26  warning  property-name-no-number  Property name must not contain number (maybe you can use an array) #/components/schemas/Episode_Single/properties/alternate_name_1
 360:26  warning  property-name-no-number  Property name must not contain number (maybe you can use an array) #/components/schemas/Episode_Single/properties/alternate_name_2

✖ 2 problems (0 errors, 2 warnings, 0 infos, 0 hints)

{{site.codeblock_hidden_copy_separator}}

Spectral lint -r https://apihandyman.io/code/api-design-reviews/demo-ruleset.yaml https://apihandyman.io/code/api-design-reviews/motu-openapi.yaml

{% endcode %}

What's the problem with property names containing numbers?
What's the problem with `alternate_name_1` and `alternate_name_2` properties in the `Episode_Single schema` for instance?
If there's a 1 and 2, why not a 3? And a 4?
So better put those alternate names in a list, that way no problem, there can be 1 to 4 ... or 5.
But that's if those alternate names 1 and 2 actually are just "alternate names" and not "production name" and "some other name". 
If so, I would rename them accordingly.

As you can see linting an OpenAPI file is not only about doing dumb checks (even if only just that actually changed my life), you can use Spectral to spot possible design patterns and business domain concerns.

The problem with linting an OpenAPI file is that you can end with hundreds of problems detected.
Actually, running my usual ruleset (working on open sourcing it) on this post's demo OpenAPI file would return almost 200 problems.
A raw list of 200 problems is not really usable.
And Spectral can't handle all of my checks, I still need to analyze the contract with my very eyes.

And so I realized that I needed to render OpenAPI files and Spectral results in a new way.

## Looking for new perspectives

This research of new perspectives actually started with a command line like this one:

{% code title:"Using escape variable" language:bash %}
[apihandyman.io] $  Spectral lint -q -f json -r https://apihandyman.io/code/api-design-reviews/demo-ruleset.yaml https://apihandyman.io/code/api-design-reviews/motu-openapi.yaml | jq .

{{site.codeblock_hidden_copy_separator}}

Spectral lint -q -f json -r https://apihandyman.io/code/api-design-reviews/demo-ruleset.yaml https://apihandyman.io/code/api-design-reviews/motu-openapi.yaml | jq .

{% endcode %}

You can tell Spectral to return its results as JSON and pipe it to [jq](https://apihandyman.io/toolbox/jq/) and do whatever you want with them. Just don't forget the `-q` flag, if not there are some non JSON data screwing everything.

So I tinkered with JQ, extracting data from Spectral results and turning them into csv.
Then I did the same with OpenAPI files (see my series about [OpenAPI + JQ](/api-toolbox-jq-and-openapi-part-1-using-jq-to-extract-data-from-openapi-files/)), I extracted operations and schemas into csv.

Then all these csv files are imported into ... an Excel file (Google Sheet or Apple Number are no match, and don't even dare to talk about OpenOffice/Libroffice alternatives).

For the Spectral problems, I can easily filter problems by type or level, I can do text search.
And I can easily get stats using a pivot table.

{% include image.html source="linter.jpg" %}

{% include image.html source="linter-stats.jpg" %}

For the operations, I can at last have "my overview" as I need it, I can see all operations in a quick glance.
I can see all parameters, response data model or used HTTP status code.
I can easily compare paths (and spot typos).

{% include image.html source="operations.jpg" %}

Having the schemas put flat in Excel is a very powerful tool.
I can see all schema names easily.
By sorting the data by property names, I can easily spot inconsistencies.
I can check number/integer properties and check if they are not-easy-to-interpret codes, more easily spotted when there's an enum (line 68 in the above capture).

{% include image.html source="schemas.jpg" %}

The possibilities are endless.
Well I exaggerate a bit, but you can do crazy stuff with just csv files and an Excel file.

Obviously, though I added some shell scripts and VS Code action around that to quickly analyze an OpenAPI file and open my Excel report, this is not really industrial.
My JQ stuff works only a basic files, I would need to replace that by more robust code.
Same for Excel, I hope to replace it by something else one day...

# And that's just for analyzing the contract

I hope that what was shown here will give you some ideas about how analyze OpenAPI files but more important, I hope you'll understand that we, API designer reviewers, need specialized tools to do our job.
We cannot just rely on raw OpenAPI files or documentation tools.
We need tools that take advantage of this machine readable format, tools such as Spectral, but we need new way of rendering OpenAPI files and linter results.

And I didn't talked about how to formalize the result of such analysis ... we need specialized tools for that too. But that's another story I'll tell another time.
