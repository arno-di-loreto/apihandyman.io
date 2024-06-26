---
title: Modifying OpenAPI files with JQ
series: JQ and OpenAPI
series_number: 3
date: 2020-06-28
author: Arnaud Lauret
layout: post
category: post
permalink: /api-toolbox-jq-and-openapi-part-3-modifying-openapi-files-with-jq/
codefiles: api-toolbox-jq-and-openapi/part-3
category: post
tools:
  - JQ
  - OpenAPI Specification
---

Ever wanted to quickly find, extract or modify data coming from some JSON documents on the command line? JQ is the tool you’re looking for. Thanks to the two previous parts of this JQ and OpenAPI Series, we learned how to extract data from JSON (OpenAPI) files by discovering many filters, creating modules and using command line arguments. Now we will discover how to modify them; how to replace, add or delete elements in processed documents. <!--more-->

{% include _postincludes/api-toolbox-jq-openapi.md %}

{% include _postincludes/api-toolbox-jq-openapi-git.md branch="part-3" %}

We will go on using the `demo-api-openapi.json` OpenAPI file in this post:

{% codefile title:"$filename" file:demo-api-openapi.json %}

# Replacing elements

It's fairly common to tweak OpenAPI files, especially before putting them in an API portal. You may have to replace some server URLs, update version number and replace some descriptions. That can be easily done with JQ. To learn how to replace values, we'll work on the info section of `demo-api-openapi.json` with `=` and `|=` operators . And we will also see how to save the modified file because it wouldn't make any sense to not be able to save our modifications.

{% include docarray.md title="JQ Operators" target=site.data.jq.link_target links=site.data.jq.filters names="assignment_plain,assignment_update" %}

This section's content is also available as an asciinema bash session:

{% include asciinema.html src="/code/api-toolbox-jq-and-openapi/part-3/replace.cast" title="Replacing elements" poster="npt:1:20" %}


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

When I said that anything can be put on the right side, it's virtually anything; including complex filters chains like the one we have learned to create previously in part 1 and 2. Let's see that with a very simple example. The following listing shows how to delete the "-snapshot" suffix from the `.info.version` property using the `sub` filter (which replaces a string by another one inside a string) on the `.info.version` property.

{% code title:"Using filters" language:jq %}
[apihandyman.io]$ jq '.info.version' demo-api-openapi.json
"1.0.0-snapshot"
[apihandyman.io]$ jq '.info.version = (.info.version | sub("-snapshot";""))' demo-api-openapi.json
{
  ...full modified document
}
[apihandyman.io]$ jq '.info.version = (.info.version | sub("-snapshot";""))' demo-api-openapi.json | jq '.info.version'
"1.0.0"
{{site.codeblock_hidden_copy_separator}}

jq '.info.version' demo-api-openapi.json 
jq '.info.version = (.info.version | sub("-snapshot";""))' demo-api-openapi.json
jq '.info.version = (.info.version | sub("-snapshot";""))' demo-api-openapi.json | jq '.info.version' 

{% endcode %}

Did you noticed the parenthesis around the right side of the `=` operator? They are very important. If you forget them, be ready to face more or less unexpected consequences depending on what you do. Here it hopefully break swith an error without silently doing nasty stuff. Indeed, here, without `()`, the result of `.info.version = .info.version`, which is the whole document (a JSON object), is piped into the `sub` filter which expects a string. So always put parenthesis around the right side if there are some piped filters.

{% code title:"Do not forget parenthesis" language:jq %}
[apihandyman.io]$ jq '.info.version = (.info.version | sub("-snapshot";""))' demo-api-openapi.json | jq '.info.version'
"1.0.0"
[apihandyman.io]$ jq '.info.version = .info.version | sub("-snapshot";"")'  demo-api-openapi.json
jq: error (at demo-api-openapi.json:0): object ({"openapi":...) cannot be matched, as it is not a string

{{site.codeblock_hidden_copy_separator}}

jq '.info.version = (.info.version | sub("-snapshot";""))' demo-api-openapi.json
jq '.info.version = .info.version | sub("-snapshot";"")'  demo-api-openapi.json

{% endcode %}

And again, when I said that anything could be put on the right side, it's really anything. Even anything from from anywhere. For example, the following command line put the modified version number into the description.

{% code title:"Using anything from anywhere" language:jq %}
[apihandyman.io]$ jq '.info.description' demo-api-openapi.json
"The Banking API provides access to the [Banking Company](http://www.bankingcompany.com) services, which include bank account information, beneficiaries, and money transfer management.<!--more-->\n\n# Authentication\n\n## How to \n- Register\n- Create an APP\n- Request credentials\n\n# Use cases\n\n## Transferring money to an account or preexisting beneficiary\n\nThe _transfer money_ operation allows one to transfer an `amount` of money from a `source` account to a `destination` account or beneficiary.\nIn order to use an appropriate `source` and `destination`, we recommend to use _list sources_ and _list source's destinations_ as shown in the figure below (instead of using _list accounts_ and _list beneficiaries_).\n\n![Diagram](http://localhost:9090/12.2-operation-manual-diagram.svg)\n\n## Cancelling a delayed or recurring money transfer\n\n- List money transfers: To list existing money transfers and select the one to delete\n- Cancel a money transfer: To cancel the selected money transfer\n"
[apihandyman.io]$ jq '.info.description = (.info.version | sub("-snapshot";""))' demo-api-openapi.json | jq '.info.description'
"1.0.0"
{{site.codeblock_hidden_copy_separator}}

jq '.info.description' demo-api-openapi.json
jq '.info.description = (.info.version | sub("-snapshot";""))' demo-api-openapi.json | jq '.info.description'

{% endcode %}

## Replacing a value with |=

deleting "-snapshot" from the version number can be done in a more elegant way using the `|=` operator, as shown in the following listing. Thanks to this operator, when using `.` on the right side, you only get what was passed on the left side and so you may not need to use `|` (reminder `. | some_filter` is equivalent to `some_filter`).

{% code title:"Using |= instead of =" language:jq %}
[apihandyman.io]$ jq '.info.version' demo-api-openapi.json
"1.0.0-snapshot"
[apihandyman.io]$ jq '.info.version |= sub("-snapshot";"")' demo-api-openapi.json
{
  ...full modified document
}
[apihandyman.io]$ jq '.info.version |= sub("-snapshot";"")' demo-api-openapi.json | jq '.info.version'
"1.0.0"
{{site.codeblock_hidden_copy_separator}}

jq '.info.version' demo-api-openapi.json 
jq '.info.version |= sub("-snapshot";"")' demo-api-openapi.json
jq '.info.version |= sub("-snapshot";"")' demo-api-openapi.json | jq '.info.version' 

{% endcode %}

That works with objects, let's invert email and url values in the contact object. As you can see, url value is accessed with `.url` as only the contact object value is available on the right side (same for email); if we had used `=` we should have used `.info.contact.url`. Note also how name is kept unmodified by just using `name`.

{% code title:"|= operator works on object too" language:jq %}
[apihandyman.io]$ jq '.info.contact' demo-api-openapi.json
{
  "name": "The Banking API team",
  "email": "api@bankingcompany.com",
  "url": "developer.bankingcompany.com"
}
[apihandyman.io]$ jq '.info.contact |= { name, url: .email, email: .url }' demo-api-openapi.json
{
  ...full modified document
}
[apihandyman.io]$ jq '.info.contact |= { name, url: .email, email: .url }' demo-api-openapi.json | jq '.info.contact'
"1.0.0"
{{site.codeblock_hidden_copy_separator}}

jq '.info.contact' demo-api-openapi.json 
jq '.info.contact |= { name, url: .email, email: .url }' demo-api-openapi.json
jq '.info.contact |= { name, url: .email, email: .url }' demo-api-openapi.json | jq '.info.contact'

{% endcode %}

## Chaining modifications

Obviously, jq allows to do more than one modification at a time. You probably already guessed how to do so, you just need to pipe all modifications one after another as shown below on line 12 and 16. Here, we replace `.info.description` value by "New description." using `=` and then `|` the result to another modification consisting in deleting "-snapshot" from `.info.version` using `|=` and `sub`. The final result shows both modifications.

{% code language:jq %}
[apihandyman.io]$ jq '.info' demo-api-openapi.json
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
[apihandyman.io]$ jq '(.info.description = "New description.") | (.info.version |= sub("-snapshot";""))' demo-api-openapi.json
{
  ...full modified document...
}
[apihandyman.io]$ jq '(.info.description = "New description.") | (.info.version |= sub("-snapshot";""))' demo-api-openapi.json | jq '.info'
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

# Adding elements

JQ does not only allow to replace existing values, it allows also to add elements thanks to the `+=` operator which can be used on many kind of value and `|=` which can be used on objects.

{% include docarray.md title="JQ Operators" target=site.data.jq.link_target links=site.data.jq.filters names="assignment_arithmetic_update, assignment_update" %}

This section's content is also available as an asciinema bash session:

{% include asciinema.html src="/code/api-toolbox-jq-and-openapi/part-3/add.cast" title="Adding elements" poster="npt:1:20" %}

## Appending to a string with +=

The `+=` operator is used in various programming language; `a+=x` usually means `a=a+x` and jq is no exception. But if such operator is usually to be used with numbers, jq allows to use it with other types such as string as shown in the listing below. As comparison, line 3 and 5 shows how to add the " is awesome" string to `.info.contact.name` using `=` and `|=`. And line 5 shows how to do the same modification using `+=`.

{% code title:"Appending to a string" language:jq %}
[apihandyman.io]$ jq '.info.contact.name' demo-api-openapi.json 
"The Banking API team"
[apihandyman.io]$ jq '.info.contact.name = .info.contact.name + " is awesome"' demo-api-openapi.json | jq '.info.contact.name'
"The Banking API team is awesome"
[apihandyman.io]$ jq '.info.contact.name |= . + " is awesome"' demo-api-openapi.json | jq '.info.contact.name'
"The Banking API team is awesome"
[apihandyman.io]$ jq '.info.contact.name += " is awesome"' demo-api-openapi.json | jq '.info.contact.name'
"The Banking API team is awesome"

{{site.codeblock_hidden_copy_separator}}

jq '.info.contact.name' demo-api-openapi.json 
jq '.info.contact.name = .info.contact.name + " is awesome"' demo-api-openapi.json | jq '.info.contact.name'
jq '.info.contact.name |= . + " is awesome"' demo-api-openapi.json | jq '.info.contact.name'
jq '.info.contact.name += " is awesome"' demo-api-openapi.json | jq '.info.contact.name'

{% endcode %}

## Adding properties to object with +=

More interesting, `+=` can be used on objects; that means it can be used to add properties to existing objects. The following listing shows how a Slack channel name can be added to `.info.contact`. All that is needed is to put an object with the desired properties on the right side of `+=`.

Note that this new property name is prefixed with `x-`; indeed the standard OpenAPI Contact object does not have such property but the OpenAPI specification allows to add custom ones. They must be prefixed by `x-` so parsers can detect them and do not consider them as errors. Note also that as this name contains a `-` is must b quoted.

{% code title:"Adding properties" language:jq %}
[apihandyman.io]$ jq '.info.contact' demo-api-openapi.json
{
  "name": "The Banking API team",
  "email": "api@bankingcompany.com",
  "url": "developer.bankingcompany.com"
}
[apihandyman.io]$ jq '.info.contact += {"x-slack": "api-team" }' demo-api-openapi.json | jq '.info.contact'
{
  "name": "The Banking API team",
  "email": "api@bankingcompany.com",
  "url": "developer.bankingcompany.com",
  "x-slack": "apiteam"
}

{{site.codeblock_hidden_copy_separator}}
jq '.info.contact' demo-api-openapi.json
jq '.info.contact += {"x-slack": "apiteam" }' demo-api-openapi.json | jq '.info.contact'
{% endcode %}

## Adding and updating properties with +=

Another interesting aspect of `+=` is that it can be used to replace values inside an object as shown below. The jq command on line 7 still adds a `x-slack` property to `.info.contact` but it also updates the existing name to "The Awesome Banking API team".

{% code title:"Adding and updating properties" language:jq %}

[apihandyman.io]$ jq '.info.contact' demo-api-openapi.json
{
  "name": "The Banking API team",
  "email": "api@bankingcompany.com",
  "url": "developer.bankingcompany.com"
}
[apihandyman.io]$ jq '.info.contact += { name: "updated name", "x-slack": "apiteam" }' demo-api-openapi.json | jq '.info.contact'
{
  "name": "The Awesome Banking API team",
  "email": "api@bankingcompany.com",
  "url": "developer.bankingcompany.com",
  "x-slack": "apiteam"
}

{{site.codeblock_hidden_copy_separator}}

jq '.info.contact' demo-api-openapi.json
jq '.info.contact += { name: "The Awesome Banking API team", "x-slack": "apiteam" }' demo-api-openapi.json | jq '.info.contact'

{% endcode %}

## JQ module

Before going further and to add real stuff on an OpenAPI file, here's a jq module summarizing what we have learned about `+=`.

{% codefile title:"$filename" file:add.jq %}

## Adding missing 500 response when needed with +=

So far, we have replaced/add to known elements (`.info.version`) inside the demo OpenAPI file. Whatever the operator used (`=`, `|=` or `+=`,), we only provided them a static reference to update. But jq is more clever than that, we already have seen that we can but anything on the right side of an operator, it's the same on the left side.

Let's say we have an OpenAPI file in which some operations lack the definition of 500 (unexpected server error) responses. We could use `+=` on their responses list to add the missing 500 response. 

{% img file:jq-openapi-http-status-codes.png %}

The path to each operations responses list is `.paths.<some path>.<some http method>.responses`, unfortunately, path and http method will never be the same and some operations may have a 500 response defined. We could manually and painfully list all the response without 500 and then write a jq file to update them all... Hopefully we won't. We can let jq search and update the responses lists when needed.

First we need to identify the operation missing a 500 reponse. This is done with the following jq filters.

{% code title:"Selecting responses list without 500" language:jq %}
.paths[][] |
select(type == "object") |
select(has("responses")) | 
.responses |
select(has("500") | not)
{% endcode %}

Note that we cannot simply use `paths[][].responses` because of path parameters list and some x-tension not containing a responses property, hence the two `select`. Without `select(type == "object")`, we have have a _Cannot index array with string "responses"_ error because the path parameters list. And without `select(has("responses"))`we would have some `null` elements in out final list.

Once we get, at last, to the responses we keep only the one not having already a 500 property using `select`, `has` and `not`.

The following listing shows the result of this filters combination:

{% code title:"Selecting responses list without 500 command line" language:bash %}
[apihandyman.io]$ jq '.paths[][] | select(type=="object") | select(has("responses")) | .responses | select(has("500") | not) ' demo-api-openapi.json 
...
{
  "200": {
    "description": "The money transfer has been update"
  }
}
{
  "204": {
    "description": "The money transfer has been deleted"
  },
  "404": {
    "description": "The money transfer does not exist"
  }
}

{{site.codeblock_hidden_copy_separator}}

jq '.paths[][] | select(type=="object") | select(has("responses")) | .responses | select(has("500") | not) ' demo-api-openapi.json

{% endcode %}

Now that we are able to list the elements to fix, let's put these filters on the left side of `+=` and put the missing data on the right as we have just learned :

{% codefile title:"$filename" file:add-missing-500.jq %}

As shown in the two following listings, the get /accounts operation does not have a 500 but it is hopefully easily fixed by applying `add-missing-500.jq` on the file. Note that all other operations lacking a 500 are also fixed as the new 500 property is added to each element identified by the filters on the left side of `+=`.

{% code title:"Before" language:bash %}
[apihandyman.io]$ jq '.paths["/accounts"].get.responses' demo-api-openapi.json 
{
  "200": {
    "description": "User's accounts",
    "content": {
      "application/json": {
        "schema": {
          "required": [
            "properties"
          ],
          "properties": {
            "items": {
              "type": "array",
              "items": {
                "$ref": "#/components/schemas/Account"
              }
            }
          }
        }
      }
    }
  }
}

{{site.codeblock_hidden_copy_separator}}

jq '.paths["/accounts"].get.responses' demo-api-openapi.json 

{% endcode %}

{% code title:"After" language:bash %}
[apihandyman.io]$ jq -f add-missing-500.jq demo-api-openapi.json | jq '.paths["/accounts"].get.responses'
{
  "200": {
    "description": "User's accounts",
    "content": {
      "application/json": {
        "schema": {
          "required": [
            "properties"
          ],
          "properties": {
            "items": {
              "type": "array",
              "items": {
                "$ref": "#/components/schemas/Account"
              }
            }
          }
        }
      }
    }
  },
  "500": {
    "description": "Unexpected error",
    "content": {
      "application/json": {
        "schema": {
          "$ref": "#components/schemas/ProviderError"
        }
      }
    }
  }
}

{{site.codeblock_hidden_copy_separator}}

jq -f add-missing-500.jq demo-api-openapi.json | jq '.paths["/accounts"].get.responses'

{% endcode %}

## Adding missing response content when needed with |= and complex update filter

In the `demo-api-openapi.json` file some operations may have basic `401` and `403` responses but without any schema (missing `content` property). Let's fix that with a jq module inpired by previous one but using `|=` with a more complex filters on the left and accepting a regex HTTP status code and a schema model name.

{% img file:jq-openapi-response-content.png %}

The following jq module is composed of a `|=` main statement. On its left side, it selects all responses list. On its right side, it works on each key/value of all responses list using `with_entry`. If the key (HTTP status code) matches the regex (`$coderegex`) provided as a command line argument and does not already contain a `content` property, it add a `content` to the value. If not, it leaves the value as is is by returning `.`.

{% codefile title:"$filename" file:add-missing-response-content.jq %}

Here's the responses list of post /beneficiaries before modification:

{% code title:"Before" language:bash %}
[apihandyman.io]$ jq '.paths["/beneficiaries"].post.responses' demo-api-openapi.json 
{
  "201": {
    "description": "Beneficiary added"
  },
  "401": {
    "description": "Unauthorized"
  },
  "403": {
    "description": "Forbidden"
  }
}

{{site.codeblock_hidden_copy_separator}}

jq '.paths["/beneficiaries"].post.responses' demo-api-openapi.json 

{% endcode %}

Once `add-missing-response-content.jq` is applied on the OpenAPI file, the responses matching the `40.` regex (`coderegex` command line argument) have been modified to add a content with application/json media type referencing the schema provided with `schema` command line argument. And as seen previously that has been done to all operations responses.

{% code title:"Before" language:bash %}
[apihandyman.io]$ jq --arg coderegex 40. --arg schema ConsumerError -f add-missing-response-content.jq demo-api-openapi.json | jq '.paths["/beneficiaries"].post.responses'
{
  "201": {
    "description": "Beneficiary added"
  },
  "401": {
    "description": "Unauthorized",
    "content": {
      "application/json": {
        "schema": {
          "$ref": "#/components/schemas/ConsumerError"
        }
      }
    }
  },
  "403": {
    "description": "Forbidden",
    "content": {
      "application/json": {
        "schema": {
          "$ref": "#/components/schemas/ConsumerError"
        }
      }
    }
  }
}

{{site.codeblock_hidden_copy_separator}}

jq --arg coderegex 40. --arg schema ConsumerError -f add-missing-response-content.jq demo-api-openapi.json | jq '.paths["/beneficiaries"].post.responses'

{% endcode %}

Note that the selection of elements to modify with `$coderegex` could be fully made on right side (you could try to modify the module to do so).

# Deleting elements

Last but not least, deleting elements. We'll learn to use the following jq operators and function:

{% include docarray.md title="JQ Operators and Functions" target=site.data.jq.link_target links=site.data.jq.filters names="assignment_plain,assignment_update,del,walk,delpaths" %}

This section's content is also available as an asciinema bash session:

{% include asciinema.html src="/code/api-toolbox-jq-and-openapi/part-3/delete.cast" title="Deleting elements" poster="npt:0:28" %}

## Dumbly deleting contact with = or |=

If we want to get rid of the contact property in info, we can do a replacement using `=` or a more clever `|=` as we have seen before. The idea is to keep all other properties (`title`, `version`, and `description`). Note how the `|=` syntax is simpler.

{% code title:"Keeping title, version and description to delete contact" language:bash %}
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
[apihandyman.io]$ jq '.info = { info: .info.title, version: .info.version, description: .info.description }' demo-api-openapi.json | jq '.info'
{
  "info": "Banking API",
  "version": "1.0.0-snapshot",
  "description": "The Banking API provides access ..."
}
[apihandyman.io]$ jq '.info |= { title, version, description }' demo-api-openapi.json | jq '.info'
{
  "info": "Banking API",
  "version": "1.0.0-snapshot",
  "description": "The Banking API provides access ..."
}

{{site.codeblock_hidden_copy_separator}}

jq '.info' demo-api-openapi.json
jq '.info = { info: .info.title, version: .info.version, description: .info.description }' demo-api-openapi.json | jq '.info'
jq '.info |= { title, version, description }' demo-api-openapi.json | jq '.info'

{% endcode %}

## Efficiently deleting contact with del

That works because there's not too many properties to keep inside info. But if you work on a more complex object this could become quite boring to delete an element. Hopefully, there is a `del` function that can be used to actually delete an element. It can be used with `|=` but also alone. The `del` function takes a path expressions so it can be directly used on `.info.contact` to delete this property.

{% code title:"Actually deleting contact" language:bash %}
[apihandyman.io]$ jq '.info |= del(.contact)' demo-api-openapi.json | jq '.info'
{
  "title": "Banking API",
  "version": "1.0.0-snapshot",
  "description": "The Banking API provides access ..."
}
[apihandyman.io]$ jq 'del(.info.contact)' demo-api-openapi.json | jq '.info'
{
  "title": "Banking API",
  "version": "1.0.0-snapshot",
  "description": "The Banking API provides access ..."
}

{{site.codeblock_hidden_copy_separator}}

jq '.info |= del(.contact)' demo-api-openapi.json | jq '.info'
jq 'del(.info.contact)' demo-api-openapi.json | jq '.info'

{% endcode %}

## deleting deprecated operations or properties with walk and del

The OpenAPI 3 specification allows to tell that some operations ans even properties are deprecated by adding a `deprecated: true`. It can be useful to be able to delete all those deprecated elements.
That can be done quite easily with `walk` and `del` functions.

{% include docarray.md title="JQ Functions" target=site.data.jq.link_target links=site.data.jq.filters names="del,walk" %}

The `walk` function is very useful, it will basically walk through all nodes inside the provided document and apply the filters provided as parameter. The following jq module is split in 3 steps and uses `walk` on each of them:

- First we delete all object values having a deprecated property set to true
- Then we delete the keys having a null value created by first step
- And eventually, we delete all keys whose value became an empty object because of second step

{% codefile title:"$filename" file:delete-deprecated.jq %}

Here's the module in action (note for this demonstration we focus only on deprecated operations and reuse the  search operations module from part 2):

{% code title:"Deleting deprecated elements" language:bash %}
[apihandyman.io]$ jq -r --arg deprecated true -f search-operations.jq demo-api-openapi.json
[demo-api-openapi.jso]  delete  /beneficiaries/{id}     Delete a beneficiary (deprecated)
[demo-api-openapi.jso]  patch   /beneficiaries/{id}     Updates a beneficiary (deprecated)

[apihandyman.io]$ jq -f delete-deprecated.jq demo-api-openapi.json | jq -r -f search-operations.jq --arg deprecated true

{{site.codeblock_hidden_copy_separator}}

jq -r --arg deprecated true -f search-operations.jq demo-api-openapi.json
jq -f delete-deprecated.jq demo-api-openapi.json | jq -r -f search-operations.jq --arg deprecated true

{% endcode %}

## Deleting x-tensions with paths and delpaths

Another simple way of deleting elements is to use `paths` and `delpaths`, we can use them to remove all x-tensions (custom properties starting whose names start with `x-`) from an OpenAPI file.

{% include docarray.md title="JQ Functions" target=site.data.jq.link_target links=site.data.jq.filters names="paths,delpaths" %}

First we list all paths to those x-tensions. The `paths` function returns an array of all paths to all elements inside a document. Each path is an array, for example the path to contact is `["info","contact"]` (hence `paths` returns an array of array). As we only want x-tensions, we filter this lists of paths to keep only the ones having their leafs prefixed by `x-`. Once we have this array of paths, we can use it as a parameter for delpaths and we're done!

{% codefile title:"$filename" file:delete-xtensions.jq %}

{% code title:"Deleting x-tensions" language:bash %}
[apihandyman.io]$ jq -r -f list-xtension-paths.jq demo-api-openapi.json 
[
  [
    "paths",
    "/accounts/{id}",
    "get",
    "x-implementation"
  ],
  ...
]

[apihandyman.io]$ jq -f delete-xtensions.jq demo-api-openapi.json | jq -r -f list-xtension-paths.jq 
[]

{{site.codeblock_hidden_copy_separator}}

jq -r -f list-xtension-paths.jq demo-api-openapi.json
jq -f delete-xtensions.jq demo-api-openapi.json | jq -r -f list-xtension-paths.jq

{% endcode %}

## Deleting unsused schemas with delpaths

We're under no obligation to use `paths` when using `delpaths`, we can build the paths ourselves.

{% include docarray.md title="JQ Filters and Functions" target=site.data.jq.link_target links=site.data.jq.filters names="recursive_descent,delpaths" %}

The following module removes unused schemas from an OpenAPI file. Unused schemas are defined in `components.schemas` but never referenced in a `$ref` property. 

To build the paths list, we first create a list of all possible $ref values using the keys of components.schemas. Then we substract all actually used $ref. Note the use of `..`to get all document's nodes and `unique` to keep only one occurrence of each used $ref. Once we have a list of `#/components/schemas/name` strings, we transform them in paths by splitting on `/` and removing `#`. And eventually we use delpaths on the resulting array of paths. Note that delpaths accept a parameter which is not strictly an array of array, indeed the unsused schema paths list is only a succession of individual arrays not enclosed inside an array.

{% codefile title:"$filename" file:delete-unused-schemas.jq %}

{% code title:"Deleting unused schemas" language:bash %}
[apihandyman.io]$ jq -r -f list-unused-schemas.jq demo-api-openapi.json 
[
  "components",
  "schemas",
  "ProviderError"
]
[
  "components",
  "schemas",
  "UselessSchema"
]

[apihandyman.io]$ jq -f delete-unused-schemas.jq demo-api-openapi.json | jq -r -f list-unused-schemas.jq

{{site.codeblock_hidden_copy_separator}}

jq -r -f list-unused-schemas.jq demo-api-openapi.json
jq -f delete-unused-schemas.jq demo-api-openapi.json | jq -r -f list-unused-schemas.jq

{% endcode %}

# Summary

And we're done with part 3, you should now be able to modify any OpenAPI or any JSON file as you like using the following operators and functions:

{% include docarray.md title="JQ Filters, Operators and Functions" target=site.data.jq.link_target links=site.data.jq.filters names="assignment_plain,assignment_update,assignment_arithmetic_update,del,walk,paths,recursive_descent,delpaths" %}

# What's next

With what you have learned in the first 3 parts, you should be able to achieve anything you want with jq. And known that we only scratched the surface, check jq's documentation to discover all of its features. The next and final part is a little bonus in which you'll learn to colorize jq terminal output just for fun.