---
title: API Toolbox - JQ and OpenAPI - Part 2 - Searching into OpenAPI files with JQ's command line arguments, functions and modules
date: 2020-01-10
author: Arnaud Lauret
layout: post
permalink: /api-toolbox-jq-and-openapi-part-2-searching-into-openapi-files/
codefiles: api-tools-jq
category: posts
series: API Toolbox - JQ and OpenAPI
series_title: Part 2 - Searching into OpenAPI files with JQ's command line arguments, functions and modules
published: false
tags:
  - API Toolbox
---
Blah blah part 2 <!--more-->

# Search into an OpenAPI file with JQ command line arguments

## Search deprecated (or not) operations

{% code language:bash %}
[apihandyman.io]$ jq -r --arg deprecated true -f search-operations-deprecated.jq demo-api-openapi.json
delete  /beneficiaries/{id}     Delete a beneficiary (deprecated)
patch   /beneficiaries/{id}     Updates a beneficiary (deprecated)

[apihandyman.io]$ jq -r --arg deprecated false -f search-operations-deprecated.jq demo-api-openapi.json
get     /accounts       List accounts
get     /accounts/{id}  Get an account
post    /beneficiaries  Register a beneficiary
get     /beneficiaries  List beneficiaries
get     /beneficiaries/{id}     Get a beneficiary
get     /sources        List transfer sources
get     /sources/{id}/destinations      List transfer source's destinations
post    /transfers      Transfer money
get     /transfers      List money transfers
get     /transfers/{id} Get a money transfer
patch   /transfers/{id}
delete  /transfers/{id} Cancel a money transfer
{% endcode %}

{% codefile title:"$filename" file:search-operations-deprecated.jq highlight:"27-29"  footer:false %}


## Search operations using a given HTTP method

{% code language:bash %}
[apihandyman.io]$ jq -r --arg method delete -f search-operations-http-method.jq demo-api-openapi.json
delete  /beneficiaries/{id}     Delete a beneficiary (deprecated)
delete  /transfers/{id} Cancel a money transfer
{% endcode %}

{% codefile title:"$filename" file:search-operations-http-method.jq highlight:"27-29"  footer:false %}

## Search operations using a given HTTP status code

{% code language:bash %}
[apihandyman.io]$ jq -r --arg code 404 -f search-operations-http-status-code.jq demo-api-openapi.json
get     /transfers/{id} Get a money transfer
delete  /transfers/{id} Cancel a money transfer
{% endcode %}

{% codefile title:"$filename" file:search-operations-http-status-code.jq highlight:"27-35"  footer:false %}

## Search operations using a given scope

{% code language:bash %}
[apihandyman.io]$ jq -r --arg scope "transfer:admin" -f search-operations-scope.jq demo-api-openapi.json
post    /transfers      Transfer money
get     /transfers      List money transfers
get     /transfers/{id} Get a money transfer
delete  /transfers/{id} Cancel a money transfer
{% endcode %}

{% codefile title:"$filename" file:search-operations-scope.jq %}

## Search x-tensions and their values for a given name

{% code language:bash %}
[apihandyman.io]$ jq --arg name x-tension-example -f search-xtensions.jq demo-api-openapi.json 
[
  {
    "xtension": "x-tension-example",
    "path": [
      "paths",
      "/transfers/{id}",
      "x-tension-example"
    ],
    "value": {
      "some": "value"
    }
  }
]
{% endcode %}

{% codefile title:"$filename" file:search-xtensions.jq %}

# Simplify JQ code with modules and reusable functions

## Create and use an OpenAPI JQ module with reusable functions

{% codefile title:"$filename" file:module-openapi.jq %}

{% codefile title:"$filename" file:module-list-operations.jq %}

{% codefile title:"$filename" file:module-search-operations-http-method.jq %}

{% codefile title:"$filename" file:module-search-operations-scope.jq %}

## Do a multi-criteria search with optional parameters

### Understand and solve the problem with --arg parameters

{% code language:bash %}
[apihandyman.io]$ jq -f bonus-args-problem.jq -n --arg foo something --arg bar "another thing"
{
  "foo": "something",
  "bar": "another thing"
}

[apihandyman.io]$ jq -f bonus-args-problem.jq -n --arg foo something
jq: error: $bar is not defined at <top-level>, line 1:
{ foo: $foo, bar: $bar}                  
jq: 1 compile error

[apihandyman.io]$ jq -f bonus-args-problem-solved.jq -n --arg foo something
{
  "foo": "something",
  "bar": null
}
{% endcode %}

### Create a multi-criteria search with optional parameters

{% codefile title:"$filename" file:bonus-args-problem.jq %}

{% codefile title:"$filename" file:bonus-args-problem-solved.jq %}

{% codefile title:"$filename" file:bonus-search-operations.jq %}
