---
title: API Toolbox - JQ and OpenAPI - Part 3 - Modifying OpenAPI files with JQ
date: 2020-04-11
author: Arnaud Lauret
layout: post
category: post
permalink: /api-toolbox-jq-and-openapi-part-3-modifying-openapi-files-with-jq/
codefiles: api-toolbox-jq-and-openapi/part-3
category: post
series: JQ and OpenAPI
series_title: Modifying OpenAPI files with JQ
series_number: 3
#published: false
tags:
  - API Toolbox
---

Ever wanted to quickly find, extract or modify data coming from some JSON documents on the command line? JQ is the tool you’re looking for. Thanks to the two previous parts of this JQ and OpenAPI Series, we learned how to extract data from JSON (OpenAPI) files by discovering many filters, creating modules and using command line arguments. Now we will discover how to modify them; how to replace, add or remove elements in processed documents. <!--more-->

{% include _postincludes/api-toolbox-jq-openapi.md %}

{% include _postincludes/api-toolbox-jq-openapi-git.md branch="part-3" %}

We will go on using the `demo-api-openapi.json` OpenAPI file in this post:

{% codefile title:"$filename" file:demo-api-openapi.json %}

# Replacing elements

It's fairly common to tweak OpenAPI files, especially before putting them in an API portal. You may have to replace some server URLs, update version number and replace some descriptions. That can be easily done with JQ. To learn how to replace values, we'll work on the info section of `demo-api-openapi.json` with `=` and `|=` operators . And we will also see how to save the modified file because it wouldn't make any sense to not be able to save our modifications.

{% include docarray.md title="JQ Operators" target=site.data.jq.link_target links=site.data.jq.operators names="assignment_plain,assignment_update" %}

## Replacing a value with =

The following command line shows how to print the `.info.description` property of `demo-api-openapi.json` file (as we have learned to do so in part 1 of this post series):

{% code title:"Printing .info.description original value" language:bash %}
[apihandyman.io] $jq '.info.description' demo-api-openapi.json 
"The Banking API provides access to the [Banking Company](http://www.bankingcompany.com) services, which include bank account information, beneficiaries, and money transfer management.<!--more-->\n\n# Authentication\n\n## How to \n- Register\n- Create an APP\n- Request credentials\n\n# Use cases\n\n## Transferring money to an account or preexisting beneficiary\n\nThe _transfer money_ operation allows one to transfer an `amount` of money from a `source` account to a `destination` account or beneficiary.\nIn order to use an appropriate `source` and `destination`, we recommend to use _list sources_ and _list source's destinations_ as shown in the figure below (instead of using _list accounts_ and _list beneficiaries_).\n\n![Diagram](http://localhost:9090/12.2-operation-manual-diagram.svg)\n\n## Cancelling a delayed or recurring money transfer\n\n- List money transfers: To list existing money transfers and select the one to delete\n- Cancel a money transfer: To cancel the selected money transfer\n"

{{site.codeblock_hidden_copy_separator}}

jq '.info.description' demo-api-openapi.json

{% endcode %}

The next listing shows how modifying this value is as simple, thanks to `=` operator. By adding `="New description"` after the property's path, its content is modified like in any programming language. And now instead of returning the `.info.description` value, jq returns the whole document in which this property's value has been replaced by "New description".

The listing shows also 2 different ways to only show what we need to see. The first one is to use head (which show only the nth first line) and the second one consists in piping the result of jq in another jq command to show only the value of `.info.description`.

{% code title:"Modifying .info.description" language:bash %}
[apihandyman.io] $jq '.info.description="New description"' demo-api-openapi.json
{
...full modified document ...
}
[apihandyman.io] $jq '.info.description="New description"' demo-api-openapi.json | head -n6 
{
  "openapi": "3.0.0",
  "info": {
    "title": "Banking API",
    "version": "1.0.0-snapshot",
    "description": "New description",
[apihandyman.io] $jq '.info.description="New description"' demo-api-openapi.json | jq '.info.description'
"New description"

{{site.codeblock_hidden_copy_separator}}

jq '.info.description="New description"' demo-api-openapi.json
jq '.info.description="New description"' demo-api-openapi.json | head -n6
jq '.info.description="New description"' demo-api-openapi.json | jq '.info.description'

{% endcode %}

Anything can be put on the right side of the `=` operator as shown in the following listing. The command line allows to replace the value of `.info.contact` by another JSON object.

{% code title:"Modifying an entire object value" language:bash %}

[apihandyman.io] $jq '.info.contact' demo-api-openapi.json
{
  "name": "The Banking API team",
  "email": "api@bankingcompany.com",
  "url": "developer.bankingcompany.com"
}
[apihandyman.io] $jq '.info.contact = { name: "The Awesome Banking API Team", url: "www.bankingcompany.com" }' demo-api-openapi.json | jq '.info.contact'
{
  "name": "The Awesome Banking API Team",
  "url": "www.bankingcompany.com"
}

{{site.codeblock_hidden_copy_separator}}

jq '.info.contact' demo-api-openapi.json
jq '.info.contact = { name: "The Awesome Banking API Team", url: "www.bankingcompany.com" }' demo-api-openapi.json | jq '.info.contact'

{% endcode %}

## Saving (a copy of) modified file

But those command lines did not actually saved the modified files; indeed the modified content is just printed in the terminal. Unfortunately jq does not come with in-place modification like `sed`. But that's not really a problem, we can use a good old `>` to save result in another file as shown below (and once really sure of what we have done, we can replace the original one).

{% code title:"Saving modified file" language:bash %}
[apihandyman.io] $jq '.info.description="New description"' demo-api-openapi.json > demo-api-openapi-mod.json 
[apihandyman.io] $jq '.info.description' demo-api-openapi-mod.json
"New description"

{{site.codeblock_hidden_copy_separator}}

jq '.info.description="New description"' demo-api-openapi.json > demo-api-openapi-mod.json
jq '.info.description' demo-api-openapi-mod.json

{% endcode %}

## Using filters when replacing a value

When I said that anything can be put on the right side, it's virtually anything; including complex filters chains like the one we have learned to create previously in part 1 and 2. Let's see that with a very simple example. The following listing shows how to remove the "-snapshot" suffix from the `.info.version` property using the `sub` filter (which replaces a string by another one inside a string) on the `.info.version` property.

{% code title:"Using filters" language:jq %}
[apihandyman.io]$jq '.info.version' demo-api-openapi.json
"1.0.0-snapshot"
[apihandyman.io]$jq '.info.version = (.info.version | sub("-snapshot";""))' demo-api-openapi.json
{
  ...full modified document
}
[apihandyman.io]$jq '.info.version = (.info.version | sub("-snapshot";""))' demo-api-openapi.json | jq '.info.version'
"1.0.0"
{{site.codeblock_hidden_copy_separator}}

jq '.info.version' demo-api-openapi.json 
jq '.info.version = (.info.version | sub("-snapshot";""))' demo-api-openapi.json
jq '.info.version = (.info.version | sub("-snapshot";""))' demo-api-openapi.json | jq '.info.version' 

{% endcode %}

Did you noticed the parenthesis around the right side of the `=` operator? They are very important. If you forget them, be ready to face more or less unexpected consequences depending on what you do. Here it hopefully break swith an error without silently doing nasty stuff. Indeed, here, without `()`, the result of `.info.version = .info.version`, which is the whole document (a JSON object), is piped into the `sub` filter which expects a string. So always put parenthesis around the right side if there are some piped filters.

{% code title:"Do not forget parenthesis" language:jq %}
[apihandyman.io]$jq '.info.version = (.info.version | sub("-snapshot";""))' demo-api-openapi.json | jq '.info.version'
"1.0.0"
[apihandyman.io]$jq '.info.version = .info.version | sub("-snapshot";"")'  demo-api-openapi.json
jq: error (at demo-api-openapi.json:0): object ({"openapi":...) cannot be matched, as it is not a string

{{site.codeblock_hidden_copy_separator}}

jq '.info.version = (.info.version | sub("-snapshot";""))' demo-api-openapi.json
jq '.info.version = .info.version | sub("-snapshot";"")'  demo-api-openapi.json

{% endcode %}

And again, when I said that anything could be put on the right side, it's really anything. Even anything from from anywhere. For example, the following command line put the modified version number into the description.

{% code title:"Using anything from anywhere" language:jq %}
[apihandyman.io]$jq '.info.description' demo-api-openapi.json
"The Banking API provides access to the [Banking Company](http://www.bankingcompany.com) services, which include bank account information, beneficiaries, and money transfer management.<!--more-->\n\n# Authentication\n\n## How to \n- Register\n- Create an APP\n- Request credentials\n\n# Use cases\n\n## Transferring money to an account or preexisting beneficiary\n\nThe _transfer money_ operation allows one to transfer an `amount` of money from a `source` account to a `destination` account or beneficiary.\nIn order to use an appropriate `source` and `destination`, we recommend to use _list sources_ and _list source's destinations_ as shown in the figure below (instead of using _list accounts_ and _list beneficiaries_).\n\n![Diagram](http://localhost:9090/12.2-operation-manual-diagram.svg)\n\n## Cancelling a delayed or recurring money transfer\n\n- List money transfers: To list existing money transfers and select the one to delete\n- Cancel a money transfer: To cancel the selected money transfer\n"
[apihandyman.io]$ jq '.info.description = (.info.version | sub("-snapshot";""))' demo-api-openapi.json | jq '.info.description'
"1.0.0"
{{site.codeblock_hidden_copy_separator}}

jq '.info.description' demo-api-openapi.json
jq '.info.description = (.info.version | sub("-snapshot";""))' demo-api-openapi.json | jq '.info.description'

{% endcode %}

## Replacing a value with |=

Removing "-snapshot" from the version number can be done in a more elegant way using the `|=` operator, as shown in the following listing. Thanks to this operator, when using `.` on the right side, you only get what was passed on the left side and so you may not need to use `|` (reminder `. | some_filter` is equivalent to `some_filter`).

{% code title:"Using |= instead of =" language:jq %}
[apihandyman.io]$jq '.info.version' demo-api-openapi.json
"1.0.0-snapshot"
[apihandyman.io]$jq '.info.version |= sub("-snapshot";"")' demo-api-openapi.json
{
  ...full modified document
}
[apihandyman.io]$jq '.info.version |= sub("-snapshot";"")' demo-api-openapi.json | jq '.info.version'
"1.0.0"
{{site.codeblock_hidden_copy_separator}}

jq '.info.version' demo-api-openapi.json 
jq '.info.version |= sub("-snapshot";"")' demo-api-openapi.json
jq '.info.version |= sub("-snapshot";"")' demo-api-openapi.json | jq '.info.version' 

{% endcode %}

That works with objects, let's invert email and url values in the contact object. As you can see, url value is accessed with `.url` as only the contact object value is available on the right side (same for email); if we had used `=` we should have used `.info.contact.url`. Note also how name is kept unmodified by just using `name`.

{% code title:"|= operator works on object too" language:jq %}
[apihandyman.io]$jq '.info.contact' demo-api-openapi.json
{
  "name": "The Banking API team",
  "email": "api@bankingcompany.com",
  "url": "developer.bankingcompany.com"
}
[apihandyman.io]$jq '.info.contact |= { name, url: .email, email: .url }' demo-api-openapi.json
{
  ...full modified document
}
[apihandyman.io]$jq '.info.contact |= { name, url: .email, email: .url }' demo-api-openapi.json | jq '.info.contact'
"1.0.0"
{{site.codeblock_hidden_copy_separator}}

jq '.info.contact' demo-api-openapi.json 
jq '.info.version |= sub("-snapshot";"")' demo-api-openapi.json
jq '.info.version |= sub("-snapshot";"")' demo-api-openapi.json | jq '.info.version' 

{% endcode %}

## Chaining modifications

Obviously, jq allows to do more than one modification at a time. You probably already guessed how to do so, you just need to pipe all modifications one after another as shown below on line 12 and 16. Here, we replace `.info.description` value by "New description." using `=` and then `|` the result to another modification consisting in removing "-snapshot" from `.info.version` using `|=` and `sub`. The final result shows both modifications.

{% code language:jq %}
[apihandyman.io]$jq '.info' demo-api-openapi.json
{
  "title": "Banking API",
  "version": "1.0.0-snapshot",
  "description": "The Banking API provides access to the [Banking Company](http://www.bankingcompany.com) services, which include bank account information, beneficiaries, and money transfer management.<!--more-->\n\n# Authentication\n\n## How to \n- Register\n- Create an APP\n- Request credentials\n\n# Use cases\n\n## Transferring money to an account or preexisting beneficiary\n\nThe _transfer money_ operation allows one to transfer an `amount` of money from a `source` account to a `destination` account or beneficiary.\nIn order to use an appropriate `source` and `destination`, we recommend to use _list sources_ and _list source's destinations_ as shown in the figure below (instead of using _list accounts_ and _list beneficiaries_).\n\n![Diagram](http://localhost:9090/12.2-operation-manual-diagram.svg)\n\n## Cancelling a delayed or recurring money transfer\n\n- List money transfers: To list existing money transfers and select the one to delete\n- Cancel a money transfer: To cancel the selected money transfer\n",
  "contact": {
    "name": "The Banking API team",
    "email": "api@bankingcompany.com",
    "url": "developer.bankingcompany.com"
  }
}
[apihandyman.io]$jq '(.info.description = "New description.") | (.info.version |= sub("-snapshot";""))' demo-api-openapi.json
{
  ...full modified document...
}
[apihandyman.io]$jq '(.info.description = "New description.") | (.info.version |= sub("-snapshot";""))' demo-api-openapi.json | jq '.info'
{
  "title": "Banking API",
  "version": "1.0.0",
  "description": "New description.",
  "contact": {
    "name": "The Banking API team",
    "email": "api@bankingcompany.com",
    "url": "developer.bankingcompany.com"
  }
}

{{site.codeblock_hidden_copy_separator}}

jq '.info' demo-api-openapi.json
jq '(.info.description = "New description.") | (.info.version |= sub("-snapshot";""))' demo-api-openapi.json
jq '(.info.description = "New description.") | (.info.version |= sub("-snapshot";""))' demo-api-openapi.json | jq '.info'

{% endcode %}

## JQ module

Here's a JQ module demonstrating the various use of `=` and `|=` we have seen (use `jq -r replace.jq demo-api-openapi.json` to see it in action).

{% codefile title:"$filename" file:replace.jq %}

# Adding elements to existing values

{% include docarray.md title="JQ Operators" target=site.data.jq.link_target links=site.data.jq.operators names="assignment_arithmetic" %}

{% code language:json title:"Before modification" %}
{
  "title": "Banking API",
  "version": "1.0.0",
  "description": "New description.",
  "contact": {
    "name": "The Awesome Banking API Team",
    "url": "www.bankingcompany.com"
  }
}
{% endcode%}

{% code language:json title:"After modification" %}
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

## Concatenating a string to an existing one

{% code language:jq %}
# += adds anything to an existing value
(.info.description += " Some new content for the description.")
{% endcode %}

## Adding properties to object

{% code language:jq %}
# Here, += used to add some property in an object
(.info += {"x-property": "example"})
{% endcode %}

## Adding missing response data


## Full JQ module

{% codefile title:"$filename" file:add.jq %}

# Removing elements

## Removing "dumbly"

.info.contact |= { name, url}

## Removing elements efficiently

## Removing deprecated elements

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

## Removing x-tensions

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

# Summary

## Operators

## Functions

# What's next
