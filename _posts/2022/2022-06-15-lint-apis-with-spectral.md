---
title: Lint APIs with Spectral
date: 2022-06-15
author: Arnaud Lauret
layout: post
permalink: /lint-apis-with-spectral/
category: post
tools:
  - OpenAPI Specification
  - Spectral
---

Are you struggling to design consistent APIs? On the verge of losing sanity while checking every single property of every schema is camelCased? Never remembering the parameters to use for pagination? Spectral is the tool you need: it will lint JSON Schema, AsyncAPI, and OpenAPI documents and do those checks for you.
<!--more-->

{% include banner-author-link.md %}

# Spectral is a JSON and YAML linter

[Spectral](https://github.com/stoplightio/spectral) is an open-source JSON and YAML linter created by [Stoplight](https://stoplight.io/). Imagine ESLint or SonarQube but for JSON and YAML.

{% include quote.html text="Lint, or a linter, is a static code analysis tool used to flag programming errors, bugs, stylistic errors and suspicious constructs." source="Wikipedia" url="https://en.wikipedia.org/wiki/Lint_(software)" %}

Spectral checks that a JSON or YAML document respects some out-of-the-box or user-defined rules. Linting JSON or YAML documents allows ensuring different documents, possibly created by different persons are consistent with each other; that they share a similar look and feel. It makes them easier to read, and easier to maintain. Beyond styling, linting can also help avoid the use of wrong patterns.

As Spectral works on any JSON or YAML document, it can be used on formats like Kubernetes configuration file, Postman collection, Github action, JSON Schema, AsyncAPI, or OpenAPI. For instance, using Spectral, you can check that in a Github action file, all jobs have `snake_case` names or that any job's step using [`github-pages-deploy-action`](https://github.com/marketplace/actions/deploy-to-github-pages) defines a `commit-message`. Linting a Postman collection, you can check that every request comes with at least an example.

# How Spectral works

Using Spectral requires defining a ruleset and then using Spectral CLI to lint (analyze) a document with it.

## Creating a ruleset

A Spectral ruleset can be defined in a JSON or YAML document. The following code snippet shows the content of a YAML Spectral ruleset file named `rules.spectral.yaml`. It defines a `title-no-api` rule that checks the name of an API (defined in an OpenAPI document) does not contain the word "API".

{% code language:"yaml" title:"rules.spectral.yaml" highlight:"3,7,9" %}
rules:
  # Rule's name
  title-no-api:
    # Rule's description
    description: The title must not contain the word API
    # JSON Path to target
    given: $.info.title
    # Control applied on the target's value
    then:
      function: pattern
      functionOptions:
        notMatch: /\b(api)\b/i
{% endcode %}

Each Spectral rule works like this one, hence "given some path then do some controls":

- The "target" of the rule is defined in `given` using a [JSON Path](https://jsonpath-plus.github.io/JSONPath/docs/ts/) expression. The  `$.info.title` path targets the `title` property of the `info` object which is located at the root (`$` ) of the OpenAPI document, hence the name of the API.
- The control that is done to the value of all the elements matching the given JSON path is defined in `then` by providing a `function` name and some options (`functionOptions` ) if required by the function. The `pattern` function used here ensures that the title doesn't match a regular expression.

## Linting a document

To install Spectral, run the following command (check the [documentation](https://github.com/stoplightio/spectral#-installation-and-Usage) for other installation methods):

{% code language:"bash" title:"Installing Spectral CLI" %}
apihandyman> npm install -g @stoplight/spectral-cli

{{site.codeblock_hidden_copy_separator}}

npm install -g @stoplight/spectral-cli
{% endcode %}

Linting a document named `openapi.yml` with the `rules.spectral.yaml` created previously is done has follow:

{% code language:"bash" title:"Linting a document" %}
apihandyman> spectral lint openapi.yaml -r rules.spectral.yaml

/path/to/documents/openapi.yaml

 4:10  warning  title-no-api  The name of the API must not contain the word API  info.title

✖ 1 problem (0 errors, 1 warning, 0 infos, 0 hints)

{{site.codeblock_hidden_copy_separator}}

spectral lint openapi.yaml -r rules.spectral.yaml
{% endcode %}

For each problem, you get:

- The problem's location (`4:10` )as line and character numbers
- The triggered rule's severity (`warning`, the default level when the rule doesn't define it)
- The triggered rule name ( `title-no-api` )
- The description of the problem
- The path that triggered the rule( `info.title` )

And indeed, the document that has been linted, contains the word "API" on line 4 in `info.title`  as shown below:

{% code language:"yaml" title:"openapi.yaml" highlight:"4" %}
openapi: "3.1.0"

info:
  title: Demo API
  version: "1.0"

paths: {}
{% endcode %}

# Spectral is an API linter

Spectral comes with handy and ready-to-use rules and functions that will make JSON Schema, OpenAPI, and AsyncAPI documents easier. But even without them, Spectral is an awesome tool when working on APIs.

Spectral really speeds up designing APIs your organization's way and reviewing them. Using Spectral, you won't lose time ensuring that the name of an API does not contain the word "API," that all of your JSON schema properties are in camelCase, that every operation returning a list proposes the right pagination parameters, or that every operation returns at least a 2XX response. It can also tell you're using a non-evolvable data structure such as a list of string or non-user-friendly required query parameters. Triggered Spectral rules will tell you what is wrong and how to fix it.

That means API designers and API reviewers lose less time on designing APIs the right way, with the right look and feel, and spend more time on creating the right APIs. Spectral also makes APIs more user-friendly, participating in the building of a great developer experience (DX).

# With great powers comes great responsabilities

Spectral is a powerful tool that can be of great help to design consistent, evolvable,  and user-friendly APIs easily, in the long run, and at scale. But that will happen only if you know how to fully take advantage of it.

Spectral is a powerful tool that comes with a few challenges such as mastering JSON Path, mastering the functions, creating your own functions only when needed, designing user-friendly rules, governing rules, or being sure your rules actually work.
Spectral is a powerful tool that can be used in some not obvious ways to take even more advantage of it: it can output JSON and it's also a library. 

Hopefully, these are topics that will be covered in upcoming posts.