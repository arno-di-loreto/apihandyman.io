---
title: API Toolbox - JQ and OpenAPI - Part 3 - Modifying OpenAPI files with JQ
date: 2020-01-10
author: Arnaud Lauret
layout: post
permalink: /api-toolbox-jq-and-openapi-part-2-searching-into-openapi-files/
codefiles: api-tools-jq
category: posts
series: API Toolbox - JQ and OpenAPI
series_title: Part 3 - Modifying OpenAPI files with JQ
published: false
tags:
  - API Toolbox
---

Blah blah part 3 <!--more-->

# Modify OpenAPI files with JQ

## Modify various values in info

{% code language:bash %}
cat demo-api-openapi.json | jq '.info'
{
  "title": "Banking API",
  "version": "1.0.0-snapshot",
  "description": "The Banking API provides access to the [Banking Company](http://www.bankingcompany.com) services, which include bank account information, beneficiaries, and money transfer management.\n\n# Authentication\n\n## How to \n- Register\n- Create an APP\n- Request credentials\n\n# Use cases\n\n## Transferring money to an account or preexisting beneficiary\n\nThe _transfer money_ operation allows one to transfer an `amount` of money from a `source` account to a `destination` account or beneficiary.\nIn order to use an appropriate `source` and `destination`, we recommend to use _list sources_ and _list source's destinations_ as shown in the figure below (instead of using _list accounts_ and _list beneficiaries_).\n\n![Diagram](http://localhost:9090/12.2-operation-manual-diagram.svg)\n\n## Cancelling a delayed or recurring money transfer\n\n- List money transfers: To list existing money transfers and select the one to delete\n- Cancel a money transfer: To cancel the selected money transfer\n",
  "contact": {
    "name": "The Banking API team",
    "email": "api@bankingcompany.com",
    "url": "developer.bankingcompany.com"
  }
}

cat demo-api-openapi.json | jq -f modify-update-various-properties.jq | jq '.info'
{
  "title": "Banking API",
  "version": "1.0.0",
  "description": "New description. Some new content for the description.",
  "contact": {
    "name": "The Awesome Banking API Team",
    "url": "www.bankingcompany.com"
  },
  "x-property": "example"
}
{% endcode%}

{% codefile title:"$filename" file:modify-update-various-properties.jq %}

## Remove x-tensions

{% code language:bash %}
[apihandyman.io]$ cat demo-api-openapi.json | jq -r -f list-xtensions.jq 
x-implementation
x-tension-example

[apihandyman.io]$ cat demo-api-openapi.json | \
jq -r -f list-xtensions.jq | wc -l
       2

[apihandyman.io]$ cat demo-api-openapi.json | \
jq -f modify-remove-xtensions.jq | jq -r -f list-xtensions.jq | wc -l
       0
{% endcode %}

{% codefile title:"$filename" file:modify-remove-xtensions.jq %}

## Remove deprecated elements

{% code language:bash %}
[apihandyman.io]$ cat demo-api-openapi.json | \
jq -r --arg deprecated true -f search-operations-deprecated.jq
delete  /beneficiaries/{id}     Delete a beneficiary (deprecated)
patch   /beneficiaries/{id}     Updates a beneficiary (deprecated)

[apihandyman.io]$ cat demo-api-openapi.json | \
jq -r --arg deprecated true -f search-operations-deprecated.jq | wc -l
       2

[apihandyman.io]$ cat demo-api-openapi.json | \
jq -f modify-remove-deprecated.jq | \
jq -r -f --arg deprecated true  search-operations-deprecated.jq | wc -l
       0
{% endcode %}

{% codefile title:"$filename" file:modify-remove-deprecated.jq %}

## Add missing response data

{% codefile title:"$filename" file:modify-add-missing-response-data.jq %}
