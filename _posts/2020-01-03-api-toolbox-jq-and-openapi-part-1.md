---
title: API Toolbox - JQ and OpenAPI - Part 1 - Using JQ to extract data from OpenAPI files
date: 2019-12-18
author: Arnaud Lauret
layout: post
permalink: /api-toolbox-jq-and-openapi-part-1-using-jq-to-extract-data-from-openapi-files/
codefiles: api-toolbox-jq-and-openapi/part-1
category: posts
series: API Toolbox - JQ and OpenAPI
series_title: Part 1 - Using JQ to extract data from OpenAPI files
tags:
  - API Toolbox
---
Ever wanted to quickly find, extract or modify data coming from some JSON documents? JQ is the tool you're looking for. In this 4 part post, you'll discover why and how I use JQ with OpenAPI Specification files. But more important, you'll get some basic and more advanced example of how to use JQ on any JSON document to get and modify JSON data as you want. In this first part we'll focus on what is JQ, why I use it with OpenAPI files and we'll learn how to invoke JQ and discover some of the many JQ filters that can be used to extract data from JSON.<!--more-->

This 4 part post is the first one of a new API Toolbox category in which I'll talk about the tools I use when doing API related stuff, why I use them and how. This post is also my first one using [Asciinema](https://asciinema.org/), an awesome tool allowing to record and share terminal sessions.

{% include _postincludes/api-toolbox-jq-openapi.md %}

# What is JQ and why I use it (on OpenAPI files)

According to {% include link.md link=site.data.jq.links.main target=site.data.jq.link_target %}, _jq can mangle the data format that you have into the one that you want with_ and also _jq is like `sed` for JSON data - you can use it to slice and filter and map and transform structured data with the same ease that `sed`, `awk`, `grep` and friends let you play with text._

{%img file:jq-openapi-jq.png %}

I have been using JQ to transform JSON data when making API calls on the command line for quite a while, but lately I have been using it to manipulate OpenAPI Specification files. This is the use case I will focus on in this post (I'll keep the API calls use case for another post).

The OpenAPI Specification (or OAS) is a standard and programming-language agnostic REST API description format. It can be used during the design of an API to formally describe the API's contract. It can also be used to generate documentation, generate code or to configure tools such as API gateways. An OpenAPI file can be in YAML or JSON format. If you want to learn more about this format, read {% include link.md link=site.data.openapi.links.what target=site.data.openapi.link_target %}. In order to have a good understanding of an OpenAPI document structure, you should check my {% include link.md link=site.data.openapi.links.map target=site.data.openapi.link_target %}.

In my daily job I have to work with OpenAPI files when doing API design reviews. Tools such as SwaggerUI or ReDoc easily provide a user friendly view of OpenAPI files, but when it comes to have a more specific view to check various design concerns, well you need to use something else. I can use JQ when I want to know  which operations can be used with a given Oauth Scope, where a reusable schema is used or checking if an API or multiples APIs are consistent.
I also have to deal with OpenAPI files when working on my company's API catalog. I had to generate API calls body based on OpenAPI files content or modify them to remove deprecated elements in order to avoid showing them in their documentation.

The examples shown in this post are based on my regular use of JQ+OpenAPI but I expanded my original JQ scripts set with other ones in order to show more of JQ's features.

# Installation

If you want to play with JQ and OpenAPI as you read this post, you'll need to install JQ and download this post's related content(JQ scripts, OpenAPI demo file and Asciinema sessions).

## Install JQ

JQ is a portable command line tool that's very easy to install. It's website states that _jq is written in portable C, and it has zero runtime dependencies. You can download a single binary, `scp` it to a far away machine of the same type, and expect it to work_ (`scp` is a file transfer tool). This is actually true, I have tested it on Linux servers, Windows CMS terminal, Windows Gitbash (standalone and inside VS Code) and MacOS terminal: never had a problem with it.

To install JQ on my personnal Macbook, I used `brew install jq`. On my professional Windows laptop, I simply downloaded the binary and added it to my PATH environment variable. Check {%include link.md link=site.data.jq.links.installation target=site.data.jq.link_target%} to see all available versions and ways to install it.

Once installed, open a terminal and run `jq --help` to check if everything is OK.

## Get post's content

All examples shown in this post are based on JQ 1.6 and OpenAPI 3. All examples can be copied using the <i class="fas fa-paste"></i> button and downloaded using the <i class="fas fa-file-code"></i> one on code snippets. All source code can be retrieved from the {% include link.md link=site.data.jq.links.jq_and_openapi_git target=site.data.jq.link_target %}.

{% include git.md link=site.data.jq.links.jq_and_openapi_git branch="part-1" %}

All of this post's examples are run against the same OpenAPI file (`demo-api-openapi.json`) which is a slightly modified version of an example coming from my book, I added a few elements here and there, convert it from YAML to JSON and uglify it.

{% codefile title:"$filename (uglyfied OpenAPI 3.0)" file:demo-api-openapi.json %}

There is also a second OpenAPI file, which is a OpenAPI 2.0 (fka. Swagger) one, it is used when working on multiple files.

{% codefile title:"$filename (uglyfied Swagger 2.0)" file:demo-another-api-swagger.json %}

# Invoke JQ

In this first section, we'll learn how to invoke JQ and its basic principles.

<asciinema-player poster="npt:0:34" title="Let's have some fund with JQ"  rows="24" author="Arnaud Lauret" src="/code/api-tools-jq/jq-openapi.cast"></asciinema-player>

## Beautify and color JSON

As shown in the following listing, the `demo-api-openapi.json` file is quite complex to read when printed on a terminal when using `cat demo-api-openapi.json`. 

{% code title:"Let's see what's inside the demo-api-openapi.json OpenAPI file" language:bash %}
[apihandyman.io]$ cat demo-api-openapi.json
{"openapi":"3.0.0","info":{"title":"Banking API", ...}
# The whole document is printed one a single line
# That's totally unreadable 😱
{% endcode %}

Of course we could open our favorite code editor and beautify it. But this can also be done on the command line thanks to JQ. All we need to do is piping (with `|`) the file content to JQ like this `cat api-openapi.json | jq '.'`. Icing on the cake, the output is colored. Note that you can also simply call JQ with the JSON's filename like this: `jq '.' demo-api-openapi.json`.

{% code title:"Let's pipe this into JQ to see if it's better" language:bash %}
[apihandyman.io]$ cat demo-api-openapi.json | jq '.'
{
  "openapi": "3.0.0",
  "info": {
    "title": "Banking API",
    ...
}
# JSON is beautified and colored 😍
{% endcode %}

{% code title:"JQ can also be called with a file parameter" language:bash %}
[apihandyman.io]$ jq '.' demo-api-openapi.json
{
  "openapi": "3.0.0",
  "info": {
    "title": "Banking API",
    ...
}
# JSON is beautified and colored 😍
{% endcode %}

The first parameter of a JQ command, here `'.'`, is the JQ filter that will be used to process the provided JSON. This `.` filter, named identity, is the most simple one, it only returns what it gets. Obviously, I wouldn't write such a huge blog post to talk about a tool that only beautifies and colors JSON. Let's see some basic JQ filtering in action.

## Extract data from JSON

Even beautified and colored, the file is still quite complex to read. Indeed, the beautified JSON file is 750 lines long. What if we only want to see the info section? It's dead simple, we only need to use the `.info` JQ filter on the file with `jq '.info' demo-api-openapi.json` as shown below. And you probably already guessed how to get only the API's name (called title in OpenAPI): `.info.title`.

{% code title:"Only showing the info section or the API's name (title)" language:bash %}
[apihandyman.io]$ jq '.' demo-api-openapi.json | wc -l
     750
# Beautified JSON is 750 lines long 
[apihandyman.io]$ jq '.info' demo-api-openapi.json
{
  "title": "Banking API",
  "version": "1.0.0-snapshot",
  "description": "The Banking API provides access ...",
  "contact": {
    "name": "The Banking API team",
    "email": "api@bankingcompany.com",
    "url": "developer.bankingcompany.com"
  }
}

[apihandyman.io]$ jq '.info.title' demo-api-openapi.json
"Banking API"
{% endcode %}

The most simple JQ filters simply consist in describing the paths of the element you want to get.

{% img file:jq-openapi-basic-filter.png %}

Being able to simply extract a value from a JSON is quite interesting, but that's only the tip of the tip of the tip the iceberg.

## Generate tailor made JSON

With a JQ filter, you can generate tailor made JSON containing exactly what you want, how you want it. To do so, use the `{}` object constructor and describe what you want in it almost just like you would write a JSON object. The following listing show how to create an object containing the API name, its version and the contact's name. Each value is the result of a JQ filter applied to the JSON provided to the filter. Note that `\` is used to split the command line in order to keep it readable and has nothing to do with JQ.

{% code title:"JQ can totally transform the provided JSON" language:bash %}
[apihandyman.io]$ jq '{name: .info.title, \
                       version: .info.version, \
                       contact: .info.contact.name}' \
                     demo-api-openapi.json
{
  "name": "Banking API",
  "version": "1.0.0-snapshot",
  "contact": "The Banking API team"
}
{% endcode %}

## Generate raw text

JQ is also able to output raw text instead of JSON. To do so, a filter just need to return a value. The following listing shows three attempts of printing text. The first example (line 1) simply prints the API name (`.info.title`) as we already have done before. The output contains no JSON structure, only the requested value as a quoted string (`"Banking API"`). The second one (line 4) tries to outputs tab separated API's name, version and contact's name. Note that the `+` operator is used to concatenate the different values which can come from the provided JSON (`.info.title` for example) but can also be static ones (`"\t"`, the tab separator). Unfortunately, the result is not what is expected, the tabs (`\t`) are not interpreted. In order to actually get raw text that will be fully interpreted by the terminal, the `-r` flag must be provided to JQ. This is what is shown in the last example (line 10): there is no more quotes, and the value are separated by tabs.

{% code title:"JQ can generate raw text (don't forget -r flag)" language:bash %}
[apihandyman.io]$ jq '.info.title' demo-api-openapi.json
"Banking API"

[apihandyman.io]$ jq '.info.title + "\t" + \
                      .info.version + "\t" + \
                      .info.contact.name' 
                     demo-api-openapi.json
"Banking API\t1.0.0-snapshot\tThe Banking API team"

[apihandyman.io]$ jq -r '.info.title + "\t" + \
                         .info.version + "\t" + \
                         .info.contact.name' \
                        demo-api-openapi.json
Banking API     1.0.0-snapshot  The Banking API team
{% endcode %}

## Pipe JQ commands and filters

Piping is a powerful command line concept: the result of a first command can be forwarded to another one using a pipe (`|`) . This is what we have done on our first JQ command: we took the result of a `cat` command (which outputs the content of a file) to provided it to JQ and the output of JQ can be forwarded to another command which could be, for example, another JQ one, as shown in the following listing. 

{% code title:"JQ commands can be chained with pipe (like many other command line ones)" language:bash %}
[apihandyman.io]$ cat demo-api-openapi.json | \
jq '{name: .info.title, version: .info.version, \
     contact: .info.contact.name}' | \
jq -r '.name + "\t" + .version'
Banking API     1.0.0-snapshot
{% endcode %}

JQ also takes advantage of this piping concept. Indeed, JQ filters can be chained using pipe as shown in the following listing. The full JSON document is (implicitly) provided to the first filter which creates an object containing a name, version and title and its result is forwarded, using `|`, to another filter which return a string containing tab separated name and version.

{% code title:"More interesting, JQ filters can be chained too with (also with pipe)" language:bash %}
[apihandyman.io]$ jq -r '{name: .info.title, \
                          version: .info.version, \
                          contact: .info.contact.name} 
                         | \
                         .name + "\t" + .version' \
                        demo-api-openapi.json
Banking API     1.0.0-snapshot
{% endcode %}

## Use JQ files

As a JQ filter chain becomes complex, writing it on the command line can become cumbersome and error prone. Fortunately, JQ comes with a useful `-f file` flag allowing to load filters from a file as shown in the following listing. The new command line gives the same result as the one before, the only difference is that the filters are now loaded from the `basics.jq` file (files containing JQ filters usually have a `.jq` extension).

{% code title:"When JQ scripts become complex, better use a JQ file (-f file.jq)" language:bash %}
[apihandyman.io]$ jq -r -f basics.jq demo-api-openapi.json
Banking API     1.0.0-snapshot
{% endcode %}

{% codefile title:"$filename" file:basics.jq %}

## Work on multiple JSON files

JQ's filename parameter can contain wildcards, allowing to work on multiple files at once. We can, for example, extract the API name of each OpenAPI file using the following command as shown in the following listing (the github repository contains two OpenAPI demo files, both having the `.json` extension). 

{% code title:"Processing multiple files with JQ" language:bash %}
[apihandyman.io]$ jq -r '.info.title' *.json 
Banking API
Another Example API
{% endcode %}

If the filter outputs JSON, the result is a concatenation of the JSONs returned for each file, which is not a valid JSON document, as shown on line 1 of the following listing. In order to get something valid, like an array containing all results, you can pipe this result to a `jq -s '.'` command (line 11) which will magically creates a valid JSON array. The `-s` flag (or `--slurp`) reads the entire input stream into a large array and run the filter just once instead of running the filter for each JSON object in the input.

{% code title:"Pipe to jq -s (or --slurp) to create arrays" highlight:"1,11" language:bash %}
[apihandyman.io]$ jq '{name: .info.title, file: .info.version}' *.json
{
  "name": "Another API",
  "file": "1.2"
}
{
  "name": "Banking API",
  "file": "1.0.0-snapshot"
}

[apihandyman.io]$ jq '{name: .info.title, file: .info.version}' *.json \
                | jq -s '.'
[
  {
    "name": "Another API",
    "file": "1.2"
  },
  {
    "name": "Banking API",
    "file": "1.0.0-snapshot"
  }
]
{% endcode %}

When it comes to work with multiple elements on the command line, you can obviously use xargs and/or find as shown below.

{% code title:"Use JQ with xargs and find" language:bash %}
[apihandyman.io]$ ls *.json | \
                  xargs jq -r '.info.title'
Banking API
Another Example API

[apihandyman.io]$ find . -type f -name "*.json" -exec \
                  jq -r '.info.title' {} \;
Banking API
Another API

[apihandyman.io]$ find . -type f -name "*.json" | \
                xargs jq -r '.info.title'
Banking API
Another API
# Note that find -exec is far less faster than
# find | xargs when working a large number of files
{% endcode %}

Now that we know the basics of JQ, let's try more complex stuff on OpenAPI JSON files.

# Use (some of the many) JQ filters on OpenAPI files

In this section, we'll learn to use some of the many JQ filters by extracting data from OpenAPI files. For each example, you get:

- A command line and result example
- An OpenAPI structure figure and description (based on the {% include link.md link=site.data.openapi.links.map target=site.data.openapi.target_link %})
- The list of (new) JQ filters that will be used
- An explanation of how the result is achieved
- A fully commented JQ file

## List paths

Let's start by extracting the API's paths:

{% code title:"List API's paths" language:bash %}
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

In an OpenAPI file, the available paths are the keys of the `paths` object.

{% img file:jq-openapi-paths.png %}

To get these paths, we'll use the following JQ filters:

{% include docarray.md title="JQ Filters" target=site.data.jq.link_target links=site.data.jq.filters names="object_identifier_index,keys,array_object_iterator" %}

To extract the paths, we only need to use the `keys` filter on the paths object identified by `.paths`. This `keys` filter returns an array containing the keys (property names, hence the paths in our case) of an object. Then we use `[]` on the result to flatten the array in order to get raw text.

{% codefile title:"$filename" file:list-paths.jq %}

## List HTTP methods

Let's go a level deeper to list all HTTP methods used in an API:  

{% code title: "List used HTTP methods" language:bash %}
[apihandyman.io]$ jq -r -f list-http-methods.jq demo-api-openapi.json
delete
get
patch
post
{% endcode %}

In an OpenAPI file, HTTP methods are keys inside a path object. Unfortunately, path objects may have other properties than HTTP methods ones, like `summary`, `description`, `parameters` or `x-` custom properties (we take for granted that there is no `$ref` properties). So we'll need to clean this array to get rid of all other properties than HTTP methods.

{% img file:jq-openapi-http-methods.png %}

To list all of these HTTP methods, we'll use 4 new  JQ filters:

{% include docarray.md title="JQ Filters" target=site.data.jq.link_target links=site.data.jq.filters names="array_construction,map,select,IN" %}

The JQ file that follows can be roughly split in 4 steps:

1. (Line 1) To create the array of path objects properties, we use the array constructor `[filter]` and inside it do the necessary with various filters to get all keys of all path objects. Note how `[]` is used on `.paths` to only keep its properties content without caring about the actual paths names.

1. (Line 11) Then to clean the array of unwanted values, we use the `map` filter which allows to apply a filter to each element of a list. The filter executed by `map` consists in `select(. | IN("value 1", ..., "value N"))`. The `select` filter let pass values for which its parameter filter returns true. In our case, the `select` parameter filter use `IN` which returns true if the provided value is one of its parameter (here, all possible HTTP methods). Note that inside select `.` represents the current element of the array being processed.

1. (Line 23) Then, we apply the `unique` filter to the array of all HTTP methods of all paths in order to keep a single occurrence of each.

1. (Line 27) And eventually the resulting array is flatten with `[]` for raw output.

{% codefile title:"$filename" highlight:"1-4,11-13,23-25,27-28" file:list-http-methods.jq %}

## Count HTTP status codes usage

Now we take another step deeper into the OpenAPI file by listing all HTTP status codes and sorting them by how many times they are used.

{% code title:"Count how many times HTTP status codes are used" language:bash %}
[apihandyman.io]$ jq -r -f list-http-status-codes.jq demo-api-openapi.json
200     10
201     2
204     2
404     2
202     1
400     1
{% endcode %}

In an OpenAPI files, HTTP status codes used to signify how went the API call are located in the `responses` properties of all operations (identified by an HTTP method) which are located inside all paths (identified by a path like `/whatever`) in the `paths` property. In the responses object, each response object is identified by its HTTP status code or by "default". Note that the response object can also contains `x-` custom properties that we'll need to get rid of.

{% img file:jq-openapi-http-status-codes.png %}

To list HTTP status codes and how many times they are used, we'll learn how to use the following new JQ filters:

{% include docarray.md title="JQ Filters" target=site.data.jq.link_target links=site.data.jq.filters names="optional_object_identifier,test,not,group_by,object_construction,length,sort_by,tostring" %}

The JQ file that follows is split in 5 steps:

1. (Line 1) The first step looks like previous example's, but this time we go 2 levels deeper. We also use `?` when getting responses property content because not all properties inside a path object are actual operations. Indeed some of them can be simple string (summary, description), object (servers) or array (parameters) and therefore not have a responses properties. Without `?`, using `.responses` would return an error when used on properties such as summary or description. With `?`, no error but a null value is returned. The same goes for `keys?` which may be fed with a null values having no keys at all.

1. (Line 12) On the second step, we need to get rid of possible `x-` properties. This is done like in previous example with a `map(select(filter))`. In this case, the select's filter checks if the value does not start by `x-` using the `test` filter which return true if the value matches the regex parameter and then `not` to negate this result.

1. (Line 21) Now we have an array containing all HTTP status codes of all operations, we can count how many times each one is used. This is done using `group_by` which group equal values together. It takes an array of something and returns an array of array of something. Each internal array containing equal values. Once that is done we can create on object for each internal array using `map`. It contains the HTTP status code which is the `unique` value of the array and a count which is the `length` of the array.

1. (Line 32) Then we can sort this array of {code, count} by descending count using `sort_by(-.count)`.

1. (Line 37) And eventually we generate the tab separated raw text output with `map` and `[]`.

{% codefile title:"$filename" highlight:"1-3,12-14,21-24,32-34,37-38" file:list-http-status-codes.jq %}

## List operations

Now, let's try something more interesting: extracting the API's operation list. As the following listing shows, we will extract for each operation, its HTTP method, path, summary and indicate if the operation is deprecated.

{% code title:"List operations" language:bash %}
[apihandyman.io]$ jq -r -f list-operations.jq demo-api-openapi.json 
get     /accounts       List accounts
get     /accounts/{id}  Get an account
post    /beneficiaries  Register a beneficiary
get     /beneficiaries  List beneficiaries
delete  /beneficiaries/{id}     Delete a beneficiary (deprecated)
patch   /beneficiaries/{id}     Updates a beneficiary (deprecated)
get     /beneficiaries/{id}     Get a beneficiary
get     /sources        List transfer sources
get     /sources/{id}/destinations      List transfer source's destinations
post    /transfers      Transfer money
get     /transfers      List money transfers
get     /transfers/{id} Get a money transfer
patch   /transfers/{id}
delete  /transfers/{id} Cancel a money transfer
{% endcode %}

Thanks to previous examples, we start to know an OpenAPI file structure. The operation's paths come first, then their HTTP method and a level below, we can access to summary and deprecated properties which are both optional.

{% img file:jq-openapi-operations.png %}

To generate the operations list, we'll learn how to use the following new JQ filters:

{% include docarray.md title="JQ Filters" target=site.data.jq.link_target links=site.data.jq.filters names="to_entries,variable,if_then_else" %}

The following JQ script is split in 3 steps:

1. (Line 1) We start by creating an array of {`key: /path, value: path content}` using `to_entries` on `.paths`. Then we filter this array to get rid of possible x-tensions checking the key value does not start by "x-" using `map`, `select`, `test` and `not` as already seen in a previous example.

1. (Line 10) Then we create an array of {path, method, summary, deprecated} objects. To get rid of possible extensions we reuse the `IN` filter seen previously. The interesting thing in this step is how we define (line 13) and use (line 33) the `$path` variable. Such variable definition is very useful to keep some values for later use without impacting the data flow. Indeed the data coming out of `.key as $ path` is the exactly the same as the one that came in. See also on line 37 and 46 of `if then else` can be used.

1. (Line 56) And to finish, we output tab separated raw text (adding deprecated mention when necessary).

{% codefile title:"$filename" file:list-operations.jq %}

## List x-tensions

It can be of interest to know which extensions are used in an OpenAPI document, where they are located and what are their values.

{% code title:"Listing extensions, their locations and values" language:bash %}
[apihandyman.io]$ jq -r -f list-xtensions.jq demo-api-openapi.json
[
  {
    "name": "x-implementation",
    "path": [
      "paths",
      "/accounts/{id}",
      "get",
      "x-implementation"
    ],
    "ref": "#/paths/~1accounts~1{id}/get/x-implementation",
    "value": {
      "security": {
        "description": "Only accounts belonging to user referenced in security data;\nreturn a 404 if this is not the case\n",
        "source": {
          "system": "security",
          "location": "jwt.sub"
        },
        "fail": 404
      }
    }
  },
  {
    "name": "x-tension-example",
    "path": [
      "paths",
      "/transfers/{id}",
      "x-tension-example"
    ],
    "ref": "#/paths/~1transfers~1{id}/x-tension-example",
    "value": {
      "some": "value"
    }
  },
  {
    "name": "x-implementation",
    "path": [
      "components",
      "schemas",
      "Account",
      "properties",
      "balance",
      "properties",
      "value",
      "x-implementation"
    ],
    "ref": "#/components/schemas/Account/properties/balance/properties/value/x-implementation",
    "value": {
      "description": "The real time balance (not the daily one!)",
      "source": {
        "system": "Core Banking",
        "data": "ZBAL0.RTBAL"
      }
    }
  },
  {
    "name": "x-implementation",
    "path": [
      "components",
      "schemas",
      "Account",
      "properties",
      "balance",
      "properties",
      "currency",
      "x-implementation"
    ],
    "ref": "#/components/schemas/Account/properties/balance/properties/currency/x-implementation",
    "value": {
      "source": {
        "system": "Core Banking",
        "data": "ZBAL0.RTCUR"
      }
    }
  }
]
{% endcode %}

The OpenAPI Specification is extensible, it means that custom data can be added to it for various purpose. The custom data structures can either be called extensions, x-tensions or vendor extension. In order to allow standard parsers to not raise an error, such custom data structure must be added using a specific key name starting by "x-" in order to identify them. The tricky part with extensions in our case, is that they can be located (almost) anywhere in a document, the only sure thing is that they have a key name starting by "x-". To learn more about this, check {% include link.md link=site.data.openapi.links.openapi_2_tutorial_part_9 target=site.data.openapi.link_target %} (note: extension management did not change between version 2.0 and 3).

{% img file:jq-openapi-extensions.png %}

To list all extensions as shown in the terminal listing above, we'll learn how to use the following JQ filters:

{% include docarray.md title="JQ Filters" target=site.data.jq.link_target links=site.data.jq.filters names="paths,addition,map_values,gsub,join,getpath" %}

The following JQ script consist in 3 steps:

1. (Line 1) First, we need to store the full document for later use (to get the extensions value)
1. (Line 5) Then we list all extensions paths by using `paths` which returns all possible paths and removing the ones that do not have a leaf starting with a "x-".
1. (Line 18) And last step, we build an object containing data for each found extension. This data consists in a name, a path, a JSON pointer named ref and the value.
    1. (Line 26) A in-file JSON pointer starts with "#/" and then each level is separated from its neighbour by a "/". This is easily achieved by using `+` and `join`. But a JSON pointer cannot contains "/". That's why we use `map_values` in order to replace them by `~1` with `gsub`. The `map_values` works like `map` but do not return result in an array and therefore allows to do in place modification.
    1. (Line 42) In order to get the extension value we use `getpath` on the saved document. Note how we have to define a `$path` variable to use it in getpath.

{% codefile title:"$filename" file:list-xtensions.jq %}

## List basic API information from multiple files

And last, but not least, for this post, let's gather information from different OpenAPI files as shown below. Note that now jq is used on `*.json` files and its results is piped into another jq with `-s` flag in order to generate an array (as already shown in Invoke JQ section).

{% code title:"Getting some basic information about different APIs" language:bash %}
[apihandyman.io]$ jq -f list-apis.jq *.json | jq -s
[
  {
    "specification": {
      "type": "swagger",
      "version": "2.0",
      "file": "demo-another-api-swagger.json"
    },
    "name": "Another API",
    "version": "1.2",
    "summary": "Does almost nothing",
    "operations": 1
  },
  {
    "specification": {
      "type": "openapi",
      "version": "3.0.0",
      "file": "demo-api-openapi.json"
    },
    "name": "Banking API",
    "version": "1.0.0-snapshot",
    "summary": "The Banking API provides access to the [Banking Company](http://www.bankingcompany.com) services, which include bank account information, beneficiaries, and money transfer management",
    "operations": 14
  }
]
{% endcode%}

For each file, we gather data coming from the info section but we also get the filename.To get that result, we'll learn how to use the following new JQ filters:

{% include docarray.md title="JQ Filters" target=site.data.jq.link_target links=site.data.jq.filters names="input_filename,indices,array_string_slice" %}

The following JQ scripts which generates an array of objects containing information about the specification file itself, the API and its number of operations is composed of 3 parts:

1. (Line 2) Part 1 deals with file information. When working on multiple files, it can be very interesting to know from which file comes the data. It's the case here, hopefully, the `input_filename` returns the name of the file being processed (line 8).
1. (Line 11) Part 2 deals with data coming from the info section. The summary is a shorter version of `.info.description`. If it contains a `<!--more-->` tag (found using `indices`) we split right before it using `.[0:tag position]`. If not we take the first hundred characters (or the whole string if shorter). Note how `elif` is used to have more conditions. 
1. (Line 28) Part 3 concerns counting operations, it is done almost like counting HTTP status codes.

{% codefile title:"$filename" file:list-apis.jq %}

# Summary

That's it for this first JQ and OpenAPI post. You know now how to invoke JQ on one or more files and you know how to use the 30ish following JQ filters. These are only a subset of all available filters, check {% include link.md link=site.data.jq.links.documentation target=site.data.jq.link_target %} to discover them all.

{% include docarray.md title="JQ Filters" target=site.data.jq.link_target links=site.data.jq.filters names="identity,object_identifier_index,optional_object_identifier,keys,object_construction,array_construction,map,select,IN,test,not,group_by,sort_by,length,tostring,to_entries,variable,if_then_else,paths,getpath,map_values,addition,gsub,join,indices,array_object_iterator,array_string_slice,input_filename" %}

You may also have learn a few things about an OpenAPI document structure. If you want to fully master it, look at the {% include link.md link=site.data.openapi.links.map target=site.data.openapi.link_target %}.

{% img file:site.data.openapi.images.map_v3 
       source:site.data.openapi.links.map.url 
       target:site.data.openapi.link_target %}

# What's next

In next post, we'll learn to search into OpenAPI files and simplify JQ code by using command line arguments, functions and modules.