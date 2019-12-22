---
title: API Toolbox - JQ command-line JSON processor
date: 2019-12-18
author: Arnaud Lauret
layout: post
permalink: /api-toolbox-learning-to-process-json-on-command-line-with-jq-and-openapi/
codefiles: api-tools-jq 
category: posts
tags:
  - API Toolbox
---

Intro, new series API Toolbox<!--more-->
Aims to show JQ basic and advanced principles by processing OpenAPI files.

# Discovering JQ basics by processing an OpenAPI file

What is OpenAPI, what is JQ ...

<asciinema-player poster="npt:0:34" title="Let's have some fund with JQ"  rows="24" author="Arnaud Lauret" src="/code/api-tools-jq/colored-operation-list.cast"></asciinema-player>


<asciinema-player poster="npt:0:34" title="Asciinema test"  rows="24" author="Arnaud Lauret" src="/code/api-tools-jq/test.cast"></asciinema-player>

## JQ basics

{% code language:bash highlight:"1,9" %}
[apihandyman.io]$ cat demo-api-openapi.json
"openapi":"3.0.0","info":{"title":"Banking API","version":"1.0.0","description":"The Banking API provides access to the [Banking Company](http://www.bankingcompany.com) services, which include bank account information, beneficiaries, and money transfer management.\n\n# Authentication\n\n## How to \n- Register\n- Create an APP\n- Request credentials\n\n# Use cases\n\n## Transferring money to an account or preexisting beneficiary\n\nThe _transfer money_ operation a ...
[... the whole document is printed one a single line ...]

[apihandyman.io]$ echo '{"foo": "bar"}' | jq '.'
{
  "foo": "bar"
}

[apihandyman.io]$ cat demo-api-openapi.json | jq '.'
{
  "openapi": "3.0.0",
  "info": {
    "title": "Banking API",
[... the whole document is printed ...]
}

[apihandyman.io]$ jq '.' demo-api-openapi.json
{
  "openapi": "3.0.0",
  "info": {
    "title": "Banking API",
[... the whole document is printed ...]
}

{% endcode %}

## Extracting data from JSON

{% code language:bash %}
[apihandyman.io]$ jq '.info' demo-api-openapi.json
{
  "title": "Banking API",
  "version": "1.0.0",
  "description": "The Banking API provides access to the [Banking Company](http://www.bankingcompany.com) services, which include bank account information, beneficiaries, and money transfer management.\n\n# Authentication\n\n## How to \n- Register\n- Create an APP\n- Request credentials\n\n# Use cases\n\n## Transferring money to an account or preexisting beneficiary\n\nThe _transfer money_ operation allows one to transfer an `amount` of money from a `source` account to a `destination` account or beneficiary.\nIn order to use an appropriate `source` and `destination`, we recommend to use _list sources_ and _list source's destinations_ as shown in the figure below (instead of using _list accounts_ and _list beneficiaries_).\n\n![Diagram](http://localhost:9090/12.2-operation-manual-diagram.svg)\n\n## Cancelling a delayed or recurring money transfer\n\n- List money transfers: To list existing money transfers and select the one to delete\n- Cancel a money transfer: To cancel the selected money transfer\n",
  "contact": {
    "name": "The Banking API team",
    "email": "api@bankingcompany.com",
    "url": "developer.bankingcompany.com"
  }
}

[apihandyman.io]$ jq '.info.title' demo-api-openapi.json
"Banking API"
{% endcode %}

## Generating tailor made JSON

{% code language:bash %}
[apihandyman.io]$ jq '{name: .info.title, version: .info.version, contact: .info.contact.name}' demo-api-openapi.json
{
  "name": "Banking API",
  "version": "1.0.0",
  "contact": "The Banking API team"
}
{% endcode %}

## Generating raw text

{% code language:bash %}
[apihandyman.io]$ jq '.info.title + "\t" + .info.version' demo-api-openapi.json
"Banking API\t1.0.0\tThe Banking API team"

[apihandyman.io]$ jq -r '.info.title + "\t" + .info.version' demo-api-openapi.json
Banking API	1.0.0	The Banking API team
{% endcode %}

## Piping processings

{% code language:bash %}
[apihandyman.io]$ jq -r '{name: .info.title, version: .info.version, contact: .info.contact.name} | .name + "\t" + .version' demo-api-openapi.json
Banking API	1.0.0
{% endcode %}

## Using JQ files (or jq modules)

{% codefile file:basics.jq %}

{% code language:bash %}
[apihandyman.io]$ jq -r -f basics.jq demo-api-openapi.json
Banking API	1.0.0
{% endcode %}

# Exploring an OpenAPI file with JQ

## List paths

{% code language:bash %}
[apihandyman.io]$ jq -r -f list-paths.jq demo-api-openapi.json 
/accounts
/accounts/{id}
/beneficiaries
/beneficiaries/{id}
/sources
/sources/{id}/destinations
/transfers
/transfers/{id}
{% endcode %}

{% codefile file:list-paths.jq %}

## List HTTP methods

{% code language:bash %}
[apihandyman.io]$ jq -r -f list-http-methods.jq demo-api-openapi.json
delete
get
patch
post
{% endcode %}

{% codefile file:list-http-methods.jq %}

## List HTTP status codes

{% code language:bash %}
[apihandyman.io]$ jq -r -f list-http-status-codes.jq demo-api-openapi.json
200
201
202
204
400
404
{% endcode %}

{% codefile file:list-http-status-codes.jq %}

## List operations

{% code language:bash %}
[apihandyman.io]$ jq -r -f list-operations.jq demo-api-openapi.json 
get     /accounts       List accounts
get     /accounts/{id}  Get an account
post    /beneficiaries  Register a beneficiary
get     /beneficiaries  List beneficiaries
delete  /beneficiaries/{id}     Delete a beneficiary (deprecated)
get     /beneficiaries/{id}     Get a beneficiary
get     /sources        List transfer sources
get     /sources/{id}/destinations      List transfer source's destinations
post    /transfers      Transfer money
get     /transfers      List money transfers
get     /transfers/{id} Get a money transfer
patch   /transfers/{id}
delete  /transfers/{id} Cancel a money transfer
{% endcode %}

{% codefile file:list-operations.jq %}

## List x-tensions

{% code language:bash %}
[apihandyman.io]$ jq -r -f list-xtensions.jq demo-api-openapi.json
x-implementation
x-tension-example
{% endcode %}

{% codefile file:list-xtensions.jq %}

# Searching into an OpenAPI file with JQ

## Find deprecated (or not) operations

{% code language:bash %}
[apihandyman.io]$ jq -r --arg deprecated true -f search-operations-deprecated.jq demo-api-openapi.json
delete  /beneficiaries/{id}     Delete a beneficiary (deprecated)

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

{% codefile file:search-operations-http-method.jq highlight:"27-29"  footer:false %}


## Find operations using a given HTTP method

{% code language:bash %}
[apihandyman.io]$ jq -r --arg method delete -f search-operations-http-method.jq demo-api-openapi.json
delete  /beneficiaries/{id}     Delete a beneficiary (deprecated)
delete  /transfers/{id} Cancel a money transfer
{% endcode %}

{% codefile file:search-operations-http-method.jq highlight:"27-29"  footer:false %}

## Find operations using a given HTTP status code

{% code language:bash %}
[apihandyman.io]$ jq -r --arg code 404 -f search-operations-http-status-code.jq demo-api-openapi.json
get     /transfers/{id} Get a money transfer
delete  /transfers/{id} Cancel a money transfer
{% endcode %}

{% codefile file:search-operations-http-status-code.jq highlight:"27-35"  footer:false %}

## Find operations using a given scope

{% code language:bash %}
[apihandyman.io]$ jq -r --arg scope "transfer:admin" -f search-operations-scope.jq demo-api-openapi.json
post    /transfers      Transfer money
get     /transfers      List money transfers
get     /transfers/{id} Get a money transfer
delete  /transfers/{id} Cancel a money transfer
{% endcode %}

{% codefile file:search-operations-scope.jq %}

## Find x-tensions and their values for a given name

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


{% codefile file:search-xtensions.jq %}

# Modifying an OpenAPI file with JQ

## Removing x-tensions

{% code language:bash %}
[apihandyman.io]$ cat demo-api-openapi.json | jq -r -f list-xtensions.jq 
x-implementation
x-tension-example

[apihandyman.io]$ cat demo-api-openapi.json | jq -r -f list-xtensions.jq | wc -l
       2

[apihandyman.io]$ cat demo-api-openapi.json | jq -f modify-remove-xtensions.jq | jq -r -f list-xtensions.jq | wc -l
       0
{% endcode %}

{% codefile file:modify-remove-xtensions.jq %}

## Remove deprecated elements

{% code language:bash %}
[apihandyman.io]$ cat demo-api-openapi.json | jq -r -f search-operations-deprecated.jq 
delete  /beneficiaries/{id}     Delete a beneficiary (deprecated)

[apihandyman.io]$ cat demo-api-openapi.json | jq -r -f search-operations-deprecated.jq | wc -l
       1

[apihandyman.io]$ cat demo-api-openapi.json | jq -f modify-remove-deprecated.jq | jq -r -f search-operations-deprecated.jq | wc -l
       0
{% endcode %}

{% codefile file:modify-remove-deprecated.jq %}

## Add missing response data

# Simplifying code with JQ modules and functions

## Create an OpenAPI JQ module with reusable functions

{% codefile file:module-openapi.jq %}

## Use the OpenAPI JQ module and its functions

{% codefile file:module-list-operations.jq %}

{% codefile file:module-search-operations-http-method.jq %}

{% codefile file:module-search-operations-scope.jq %}

# Bonuses

## Managing optional command line --arg

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

{% codefile file:bonus-args-problem.jq %}

{% codefile file:bonus-args-problem-solved.jq %}

## Multi-criteria operations search

{% codefile file:bonus-search-operations.jq %}

## Colored OpenAPI operations list

{% codefile file:bonus-module-color-openapi.jq %}

{% codefile file:bonus-color-search-operations.jq %}

# Conclusion
API Toolbox will return with curl and JQ

😳😱🤩😍🥳