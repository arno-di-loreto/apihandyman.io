---
title: API Toolbox - JQ and OpenAPI - Part 2 - Using JQ command line arguments, functions and modules
date: 2020-02-03
author: Arnaud Lauret
layout: post
permalink: /api-toolbox-jq-and-openapi-part-2-using-jq-command-line-arguments-functions-and-modules/
codefiles: api-toolbox-jq-and-openapi/part-2
category: posts
series: JQ and OpenAPI
series_title: Using JQ command line arguments, functions and modules
series_number: 2
published: true
category: posts
tags:
  - API Toolbox
short_summary: Build flexible and easily reusable JQ filters by creating functions and modules and also by using command line arguments.
---
Ever wanted to quickly find, extract or modify data coming from some JSON documents on the command line? JQ is the tool you’re looking for. In the previous part of this JQ and OpenAPI Series, we learned to invoke JQ and how to extract data from JSON documents using some of its many filters. Now we will discover how to build flexible and easily reusable JQ filters by creating functions and modules and also using command line arguments.<!--more--> We will continue working on OpenAPI files, at the end of this second part, we'll have built a multi-criteria OpenAPI search and some reusable filters, especially one that you'll be able to reuse anytime you'll have to deal with JQ command line parameters.

{% include _postincludes/api-toolbox-jq-openapi.md %}

# Get post's content

All examples shown in this post are based on JQ 1.6 and OpenAPI 3. All examples can be copied using the <i class="fas fa-paste"></i> button and downloaded using the <i class="fas fa-file-code"></i> one on code snippets. All source code can be retrieved from the {% include link.md link=site.data.jq.links.jq_and_openapi_git target=site.data.jq.link_target %}.

{% include git.md link=site.data.jq.links.jq_and_openapi_git branch="part-2" %}

# Listing operations using functions and modules

In previous post, we built a filter that lists the operations available in an OpenAPI file. In this first section, we will just refactor the JQ code to make it more readable and reusable using functions and modules. The following listing shows what happens when using the new version of list-operations.jq on the demo OpenAPI file.

{% code title:"Same result as in part 1 but list-operations.jq has changed under the hood" language:bash %}
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

{{site.codeblock_hidden_copy_separator}}

jq -r -f list-operations.jq demo-api-openapi.json

{% endcode %}

It seems nothing has changed, it still outputs operations HTTP methods, paths and summaries, but under the hood, the JQ file used has changed as shown in the following listing.

{% codefile title:"$filename" file:list-operations.jq %}

Let's see how it was created, we'll discover functions and then modules.

## Creating functions

As a reminder, here' the previous version of the `list-operations.jq` file we created in previous part. It is composed of three steps. Steps 1 and 2 build an array of operation object containing a (HTTP) method, path, summary and deprecated indicator. Step 3 aims to print this array as tab separated text. 

{% codefile title:"$filename" file:list-operations-original.jq %}

Let's focus on step 3, which is shown below, and build a function that does the same job.

{% codefile title:"We will create a function for step 3" file:list-operations-original.jq lines:"42-50" %}

Defining a function in JQ is quite simple: at the beginning of the file, add a `def function_name:` put some filters and end by `;` and you're done. The `oas_operation_to_text` which basically contains step 3's filters is shown below.

{% codefile title:"Defining the oas_operation_to_text function" file:list-operations-with-to-text-function.jq lines:"1-10" %}

If defining a function in JQ is quite simple, using it is even more simple. Just call it like any regular JQ filter. The following listing shows how step 3's code has been replaced by the new `oas_operation_to_text` custom filter which is on top of the file.

{% codefile title:"Using the oas_operation_to_text function" file:list-operations-with-to-text-function.jq lines:"53-55" %}

Here's the full modified list-operations.jq file including the `oas_operation_to_text` definition at the beginning and its calling on the last line.

{% codefile title:"$filename" file:list-operations-with-to-text-function.jq highlight:"1-10,55" %}

That's great, using functions big JQ filters are far more readable. But what about being able to reuse these functions?

## Creating a module with reusable functions

Creating JQ _modules_ that define reusable functions is, again, quite simple. Just put some functions in a JQ file and you're done. The following listing shows a `module-openapi.jq` module file defining two functions. There's the `oas_operation_to_text` we have just created and also an `oas_operations` which do the same as steps 1 and 2 of the `list-operations.jq` file (returning an array of operations). Note that there's a light modification (line 43/44), this function returns also the `input_filename` and the original value of each operations (for a later use) besides its HTTP method, path, summary and deprecated flag.

{% codefile title:"$filename" file:module-openapi.jq %}

Let's get back to the new version of `list-operations.jq` (shown below) to see how this module is actually used. The module is include with the `include <module name without extension>;` line. Then any functions defined in it can be used like any other regular JQ filter as shown on line 3 and 4 where `oas_operations` and `oas_operations_to_text` are used.

{% codefile title:"$filename" file:list-operations.jq %}

## Managing modules locations

{% include asciinema.html src="/code/api-toolbox-jq-and-openapi/part-2/module-location.cast" title="Managing JQ modules location" poster="npt:1:20" %}

The following listings shows different ways of managing reusable modules location with JQ (see [modules](https://stedolan.github.io/jq/manual/#Modules) in the JQ's documentation for a complete description of what can be done).
It starts by a a first command done inside the `jq-and-openapi` folder.
It simply returns the first operation's summary of the `demo-api-openapi.json` file using the `oas_operations[0]` filter composed of the `oas_operations` function and the `[]` array filter.
As you can see, there's no need to create a JQ file to use a module, just use the `include` directive in the `'<filter>'` argument on the command line.
Then we go a level up, and obviously redoing the same exact command does not work anymore: the `module-openapi.jq` cannot be found in the current folder as it is in the `jq-and-openapi` one.
Hopefully, you can use the `-L <path list>` argument to tell JQ where to look for modules.

{% code title:"Indicating where to find modules with -L argument" language:bash %}
[apihandyman.io]$ jq -r 'include "module-openapi"; oas_operations[0].summary' demo-api-openapi.json
List accounts
[apihandyman.io]$ cd ..
[apihandyman.io]$ jq -r 'include "module-openapi"; oas_operations[0].summary' jq-and-openapi/demo-api-openapi.json
jq: error: module not found: module-openapi

jq: 1 compile error
[apihandyman.io]$ jq -r -L jq-and-openapi 'include "module-openapi"; oas_operations[0].summary' jq-and-openapi/demo-api-openapi.json
List accounts

{{site.codeblock_hidden_copy_separator}}

jq -r 'include "module-openapi"; oas_operations[0].summary' demo-api-openapi.json
cd ..
jq -r 'include "module-openapi"; oas_operations[0].summary' jq-and-openapi/demo-api-openapi.json
jq -r -L jq-and-openapi 'include "module-openapi"; oas_operations[0].summary' jq-and-openapi/demo-api-openapi.json

{% endcode %}

If there are modules that you use extensively, it would be interesting to put them in a `~/.jq` folder. Therefore, no longer need for the `-L` argument as shown below. JQ looks for the modules mentioned in `include` directives in this folder automatically. 

{% code title:"Using ~/.jq default folder to store modules" language:bash %}
[apihandyman.io]$ mkdir ~/.jq
[apihandyman.io]$ cp jq-and-openapi/module-openapi.jq ~/.jq
[apihandyman.io]$ jq -r 'include "module-openapi"; oas_operations[0].summary' jq-and-openapi/demo-api-openapi.json
List accounts

{{site.codeblock_hidden_copy_separator}}

mkdir ~/.jq
cp jq-and-openapi/module-openapi.jq ~/.jq
jq -r 'include "module-openapi"; oas_operations[0].summary' jq-and-openapi/demo-api-openapi.json

{% endcode %}

Note that `~/.jq` can also be a file. In that case, you don't even need to `include` anything, as shown below. Any function defined in this file is usable inside any of your filters. I personally do not recommend to do this because that makes your filters dependencies invisible (and can also result in a quite huge unmaintainable `.jq` file).

{% code title:"Using ~/.jq default file to store functions" language:bash %}
[apihandyman.io]$ rm -rf ~/.jq
[apihandyman.io]$ cp jq-and-openapi/module-openapi.jq ~/.jq
[apihandyman.io]$ jq -r 'oas_operations[0].summary' jq-and-openapi/demo-api-openapi.json
List accounts

{{site.codeblock_hidden_copy_separator}}

rm -rf ~/.jq
cp jq-and-openapi/module-openapi.jq ~/.jq
jq -r 'oas_operations[0].summary' jq-and-openapi/demo-api-openapi.json

{% endcode %}

# Searching operations using command line arguments

Now that we have a reusable module that provides functions to list operations of an OpenAPI specification file and print them as tab separated text, let's work on a multiple-criteria and multiple-file search.

## Passing an argument to JQ filters

In order to make this search flexible, we'll need to be able to accept search arguments coming from outside our filter in order to avoid having to modify it on each different search. Passing arguments to JQ is done with `--arg <name> <value>` as shown below. Inside the filter, you can access a `--arg` with `$<name>`. In this case `$foo` returns `bar`. Note also in this example the `-n` flag which is used to tell JQ to not expect any JSON input. That's pretty useful to make demos of some JQ's features but also to generate JSON from scratched based on some arguments values.

{% code title:"Passing an argument with --arg (and discovering -n flag)" language:bash %}
[apihandyman.io]$ jq -n --arg foo bar '{foo: $foo}'
{
  "foo": "bar"
}
{{site.codeblock_hidden_copy_separator}}

jq -n --arg foo bar '{foo: $foo}'

{% endcode %}

## Searching operations accessible for a scope

The following listing shows which operations are accessible to a consumer when it is given the `transfer:admin` security scope. The scope value is provided to the filter using `--arg <name> <value>`.

{% code title:"Searching operations using a given scope" language:bash %}
[apihandyman.io]$ jq -r --arg scope transfer:admin -f search-operations-using-scope.jq demo-api-openapi.json 
post    /transfers      Transfer money
get     /transfers      List money transfers
get     /transfers/{id} Get a money transfer
delete  /transfers/{id} Cancel a money transfer

{{site.codeblock_hidden_copy_separator}}

jq -r --arg scope transfer:admin -f search-operations-using-scope.jq demo-api-openapi.json 

{% endcode %}

In an OpenAPI file, you'll find the scopes that will grant access to an operation in its security property under a `{name}`.
According the OpenAPI Specification, _each name MUST correspond to a security scheme which is declared in the Security Schemes under the Components Object. If the security scheme is of type "oauth2" or "openIdConnect", then the value is a list of scope names required for the execution. For other security scheme types, the array MUST be empty_. 

{% img file:jq-openapi-scopes.png %}

For our use case, we just need to list all values (scopes) under all `security.{name}` of each operation and keep the operations for which the provided scope is found in this list. The following listing shows how this is achieved in the `search-operations-using-scope.jq`.

- First (line 4), it lists existing operations using the `oas_operations` function (coming from `module-openapi` included on line 1)
- Then (line 5), it filters the returned operations based on their scopes by working on each of the `original` operation's data coming from the OpenAPI file. To do so:
  - It first checks if there's a `security` property (line 7)
  - Then creates a list of scopes (line 9 and 10)
  - And (line 11 to 14), if the `index` of `$scope` (provided through the `--arg scope <value>`) is greater than 0 (meaning it is in the list), the operation is returned
- And finally (line 19), it prints the remaining operations as tab separated values using the `oas_operations_to_text` function (coming from `module-openapi` included on line 1)

{% codefile title:"$filename" file:search-operations-using-scope.jq %}

That's cool, but there's a little problem. When using the `search-operations-using-scope.jq` without providing the scope value, it does not work: JQ complains that `$scope` is not defined, as shown below.

{% code title:"What happens when scope is not provided" language:bash %}
[apihandyman.io]$ jq -r -f search-operations-using-scope.jq demo-api-openapi.json
jq: error: $scope is not defined at <top-level>, line 12:
        $scope # $scope value is provided on the command line        
jq: 1 compile error

{{site.codeblock_hidden_copy_separator}}

jq -r -f search-operations-using-scope.jq demo-api-openapi.json

{% endcode %}

Does that mean we can't do a multi-criteria search because it requires to be able to provide multiple _optional_ parameters? Of course not, that problem can be solved.

## Solving the command line argument "problem"

{% include asciinema.html src="/code/api-toolbox-jq-and-openapi/part-2/solving-argument-problem.cast" title="Solving the command line argument problem" poster="npt:1:20" %}

The following listing shows how to safely access a command line named argument using the `$ARGS.named` filter. If `$name` causes an error if no `--arg name value` is provided on the command line, `$ARGS.named['name']` will return `null` without causing any.

{% code title:"Using $ARGS.named" language:bash %}
[apihandyman.io]$ jq -n --arg foo hello --arg bar world '{foo: $foo, bar: $bar}'
{
  "foo": "hello",
  "bar": "world"
}
[apihandyman.io]$ jq -n --arg foo hello '{foo: $foo, bar: $bar}'
jq: error: $bar is not defined at <top-level>, line 1:
{foo: $foo, bar: $bar}                 
jq: 1 compile error
[apihandyman.io]$ jq -n --arg foo hello '{foo: $ARGS.named["foo"], bar: $ARGS.named["bar"]}'
{
  "foo": "hello",
  "bar": null
}

{{site.codeblock_hidden_copy_separator}}

jq -n --arg foo hello --arg bar world '{foo: $foo, bar: $bar}'
jq -n --arg foo hello '{foo: $foo, bar: $bar}'
jq -n --arg foo hello '{foo: $ARGS.named["foo"], bar: $ARGS.named["bar"]}'

{% endcode %}

That's very handy, but what if I want to set an argument to a default value if it is not provided? I just need to use the following `module-args` module. It defines a `init_parameter(default_values)` function returning an object containing parameters set to the value coming from `--arg <name>` or a default value it is not provided. To do so, for each entry (key/value) of a `default_values` object parameter, it checks if the named arguments (`$ARGS.named`) contains the key and if so, sets the output value to the one provided on the command line. If not, it keeps the default one. By the way, that means that JQ functions can also use parameters besides their regular input. But note that you don't need to prefix their name by `$` to access them.

{% codefile title:"$filename" file:module-args.jq %}

The following listing shows how this function can be used. Just call the `init_parameter` function with an object containing the default values and put its result in a variable (here `$parameter`) for later use (`$parameter.foo` for example). Here the default value of `foo` is `default foo` and `bar`'s is `null`. Only `bar` is provided, so the output contains `foo`'s default value and `bar` command-line-provided value.

{% code title:"Optional parameters with default values" language:bash %}
[apihandyman.io]$ jq -n --arg bar "bar from command line" 'include "module-args"; init_parameters({foo: "default foo", bar: null}) as $parameters| {foo: $parameters.foo, bar: $parameters.bar}'
{
  "foo": "default foo",
  "bar": "bar from command line"
}

{{site.codeblock_hidden_copy_separator}}

jq -n --arg bar "bar from command line" 'include "module-args"; init_parameters({foo: "default foo", bar: null}) as $parameters| {foo: $parameters.foo, bar: $parameters.bar}'

{% endcode %}

## Searching operations on multiple criteria and multiple files

{% include asciinema.html src="/code/api-toolbox-jq-and-openapi/part-2/search-demo.cast" title="Searching operations demo" poster="npt:1:20" %}

Now that we know how to provide multiple optional parameters, let's do a multi-criteria search. The following listing shows the `get` operations on paths containing `sources` across all available `*.json` files. The first value on each line is the filename (limited to 20 characters).

{% code title:"Operations on path containing source with method get" language:bash %}
[apihandyman.io]$ jq --arg path_contains sources --arg method get -r -f search-operations.jq *.json
[demo-another-api-swa]  get     /resources
[demo-api-openapi.jso]  get     /sources        List transfer sources
[demo-api-openapi.jso]  get     /sources/{id}/destinations      List transfer source's destinations

{{site.codeblock_hidden_copy_separator}}

jq --arg path_contains sources --arg method get -r -f search-operations.jq *.json

{% endcode %}

Here's the `search-operations.jq` file who does that. It reuses functions we have seen before, `oas_operations` from the `module_openapi.jq` file and `init_parameters` from the `module-args.jq` file. It also uses new functions `filter_operations`, `default_filters`, `print_oas_operations` and `default_print_parameters` from `module-openapi-search.jq`. There are 3 steps: getting operations data, filtering them and finally printing them. There's nothing new on the first step, we already have used this function. Let's see what is happening on the second and after that the third step.

{% codefile title:"$filename" file:search-operations.jq %}

The following listing shows the new functions used to filter operations. The `default_filters` only returns the search filters default value to be used in conjunction with `init_parameters` and so get cleans values from optional command line arguments. The `filter_oas_operation` expects a `filter` object whose structure is the same as the one returned by default filters. This operations runs a `map(select())` on the operations list. Each filter is triggered if `filters.<name>` is not null. There's nothing really new regarding JQ's filters besides line 41. The filtering on paths is done using the `contains` filter which we hadn't seen before.

{% codefile title:"Filtering operations ($filename)" file:module-openapi-search.jq lines:"3-44" %}

The following listing shows the new functions used to print the operations. It uses the same mechanism as the filter functions regarding the command line arguments.

{% codefile title:"Printing operations ($filename)" file:module-openapi-search.jq lines:"46-77" %}

Here's the full file:

{% codefile title:"Filtering operations ($filename)" file:module-openapi-search.jq %}

# Summary

That concludes this second path of the JQ and OpenAPI series. Here's the summary of what we have seen in this post:

## Functions and modules

- Creating a function is done with `def name: <filters>;`
- To invoke a function just use its `name` like for any regular filter
- Functions can have parameters `def name(parameter)`
- Inside a function a parameter can be used with `parameter` (without $) 
- A module is a JQ file containing reusable functions
- A module is loaded using the `include filename_without_extension` directive
- Use `-L` command line parameter to tell JQ where to find modules
- Put your favorite modules in `~/.jq` folder so JQ can find them without using `-L`

## Command line arguments

- Passing a named argument to JQ filters is done with `--arg name value`
- A named argument value can be retrieved with `$name`
- Using `$name` will provoke an error if no `--arg name value` is provided
- All named arguments are available with `$ARGS.named`
- `$ARGS.named[name]` returns null (wihout error) if no `--arg name value` is provided

## The null argument

- The `-n` (`--null`) arguments tells JQ to not expect input JSON

## New filters

{% include docarray.md title="JQ Filters" target=site.data.jq.link_target links=site.data.jq.filters names="index,contains,$ARGS.named" %}

# What's next

In next post, we'll learn to modify OpenAPI files with JQ.