---
title: "API Toolbox - JQ and OpenAPI - Part 4 - Bonus: Coloring JQ's raw output"
date: 2020-07-06
author: Arnaud Lauret
layout: post
category: post
permalink: /api-toolbox-jq-and-openapi-part-4-bonus-coloring-jqs-raw-output/
codefiles: api-toolbox-jq-and-openapi/part-4
category: post
series: JQ and OpenAPI
series_title: "Bonus: Coloring JQ's raw output"
series_number: 4
#published: false
tags:
  - API Toolbox
tools:
  - JQ
  - OpenAPI Specification
---

Ever wanted to quickly find, extract or modify data coming from some JSON documents on the command line? JQ is the tool you’re looking for. The three previous parts of this JQ and OpenAPI Series, taught us to extract data from JSON (OpenAPI) files and modify them using many filters, creating modules and using command line arguments. To finish this series, we'll learn to color JQ's raw terminal output and do a colored version of part 2's search operations. <!--more-->

The screen capture below shows what we already have seen in part 1, JQ "colors its output" by default, but what it actually does is JSON syntax highlighting. What we want to do now is coloring raw terminal output, the one you get when using the `-r` flag and outputing text instead of JSON. After reading this post, you'll be able to create JQ module doing output such as the colored version of search operations you see below.

{% img file:syntax-vs-coloring.png %}

{% include _postincludes/api-toolbox-jq-openapi.md %}

{% include _postincludes/api-toolbox-jq-openapi-git.md branch="part-4" %}

# Coloring JQ's raw terminal output

Before working on the colored version of the search operation jq module, we need to learn how to ouput basic raw colored text. As in previous posts, the content of this section is available as an Asciinema session.

{% include asciinema.html src="/code/api-toolbox-jq-and-openapi/part-4/coloring-jq.cast" title="Coloring JQ's output" poster="npt:1:20" %}

## Printing colored text in terminal

When I got this idea of coloring jq's raw output, I was not familiar with colored printing in terminal, so I started to tinker with the echo command as shown below. Line 1 simply prints Hello World without colors (in white). Line 2's purpose is only to show what happens if you don't provide the -e flag to echo: no colors. Line 3 prints Hello World in red. And eventually, line 4 prints Hello in red and World in white.

{% img file:colored-echo.png %}

{% code title:"Colored echo" language:bash %}
echo Hello World
echo '\e[31mHello World'
echo -e '\e[31mHello World'
echo -e '\e[31mHello\e[0m World'
{% endcode %}

As you can see, printing in color requires to use cryptic character sequences. Basically, to print some text in color you need to concatenate:

- The escape character `\e`
- A color code like `[31m` (red)
- The text to color
- The escape character `\e`
- The "reset" color code `[0m` which remove any style modification previously set

If you want to learn more about coloring text in terminal, I highly recommend reading [bash:tip_colors_and_formatting](https://misc.flogisoft.com/bash/tip_colors_and_formatting), I learned everything I know about this topic reading this post.

## Coloring JQ raw output

Let's try to replicate this colored echo example with jq. Line 1 is equivalent to our first non-colored `echo "Hello World"`. We provide a JSON object with `greeeting` and `who` properties and concatenate them. On line 2 we add the escape charaecters and color codes to print the `greeting` value in red. But jq returns two "Invalid espace" errors (one for each `\e` escape character. It seems jq does not like it. Hopefully there are multiple variant of this escape character. And replacing `\e` by its unicode equivalent `\u001b` do the trick: jq is able to concatenate all values (line 3). But the text is printed as a JSON string; simply because I did not put the -r flag. Line 4 shows `jq -r` printing colored raw text.

{% img file:colored-jq.png %}

{% code title:"Colored jq" language:bash %}

echo '{ "greeting": "Hello", "who":"World" }' | jq '.greeting + " " + .who'
echo '{ "greeting": "Hello", "who":"World" }' | jq '"\e[31m" + .greeting + "\e[0m " + .who'
echo '{ "greeting": "Hello", "who":"World" }' | jq '"\u001b[31m" + .greeting + "\u001b[0m " + .who'
echo '{ "greeting": "Hello", "who":"World" }' | jq -r '"\u001b[31m" + .greeting + "\u001b[0m " + .who'

{% endcode %}

## Defining a colored_text function

Printing colored text with jq is is working almost like with echo. We just need to use the unicode escape character instead of `\e`. But to be honest it's quite complicated to write this escape character and color codes are not user friendly at all. So, let's write some jq function in a `module-color.jq` file to make colored printing easier. The idea is to have a `colored_text("some text"; "red")` function that prints "some text" in "red" (or "blue").

First, let's define a variable holding the not-easy-to-type-and-remember unicode escape character. To use it, just include the jq file (see part 2) in which its defined and use its name.

{% codefile title:"Escape character variable ($filename)" file:module-color.jq lines:6 nodownload:true %}

{% code title:"Using escape variable" language:bash %}
[apihandyman.io] $ jq -n 'include "module-color";escape'
"\u001b"

{{site.codeblock_hidden_copy_separator}}

jq -n 'include "module-color";escape'

{% endcode %}

Then, we define a map with user-friendly color names as keys and ugly color codes as values. Each value of a map can be accessed with `map.key` or `map["key"]` syntax as shown in the bash snippet below.

{% codefile title:"User friendly colors map ($filename)" file:module-color.jq lines:"9-18" nodownload:strue %}

{% code title:"Using escape variable" language:bash %}
[apihandyman.io] $ jq -n 'include "module-color";colors.red'
"[31m"
[apihandyman.io] $ jq -n 'include "module-color";colors["blue"]'
"[34m"

{{site.codeblock_hidden_copy_separator}}

jq -n 'include "module-color";colors.red'
jq -n 'include "module-color";colors["blue"]'

{% endcode %}

Now that the variables are defined, we need to define a function that do all the needed concatenation to generate a string containing some `text` in color `color`:

{% codefile title:"What the function does ($filename)" file:module-color.jq lines:"25-26" nodownload:strue %}

{% img file:colored-text-function.png %}

{% code title:"Using colored_text function" language:bash %}

jq -n 'include "module-color";colored_text("some text"; "red")'
jq -r -n 'include "module-color";colored_text("some text"; "red")'
jq -n 'include "module-color";colored_text("some text"; "blue")'
jq -r -n 'include "module-color";colored_text("some text"; "blue")'

{% endcode %}

Here's the complete module:

{% codefile title:"Complete $filename module" file:module-color.jq %}

# Coloring OpenAPI search operations output

Now that we know how to output colored raw text, creating a colored version of search operation should be quite easy.

{% img file:search-operations.png %}

This section's content is available as an Asciinema session:

{% include asciinema.html src="/code/api-toolbox-jq-and-openapi/part-4/search-operations-color.cast" title="Colored search operations" poster="npt:1:20" %}

## Analyzing original search operations

The original non-colored search-operaions module shown below is quite simple thanks to what we have learned in part 2 of this series. It consists in three steps:

- Retrieving operations data by reorganizing the data coming from an OpenAPI JSON file with `oas_operation`
- Filters returned operation based on optionnal --arg parameters with `filter_oas_operations`
- Print the result in JSON or text with `print_oas_operations`

{% codefile title:"$filename" file:search-operations.jq highlight:10 %}

What we actually need to do to created a colored version of this module is copying it and modifythe last step to call a new function that will output text with some cryptic color codes. 

## Creating a new print colored oas function

As we have created a useful function that prints colored text, let's include its module to be able to use it:

{% codefile title:"Including colored_text function ($filename)" file:module-openapi-operations-color.jq nodownload:true lines:1 %}

The colored version of the `print_oas_operations` function, will print HTTP method in colors. In order to avoir having a complex `if then elif else end` statement, we proceeed like for color codes; we create a map but now each key is an HTTP method and its value is its user friendly color. So `delete` value is `red` for example.

{% codefile title:"Defining HTTP colors ($filename)" file:module-openapi-operations-color.jq nodownload:true lines:4-11 %}

And then in the `print_colored_oas_operations` to generate a string for each operation we `colored_text` on the various elements. Note on line 22 how the HTTP method color is easily chosen. Note also that deprecated operations are printined in black on dark gray using the `disabled` color.

{% codefile title:"Generating string for each operation ($filename)" file:module-openapi-operations-color.jq nodownload:true lines:16-25 %}

Here's the complete module:

{% codefile title:"Complete $filename module" file:module-openapi-operations-color.jq %}

## Creating a new search operations in color module

And lastly, we create a new module that will be used with the -f parameter. The only difference with its uncolored counterpart is on line 4 (including the jq file containing the `print_colored_oas_operation`) and line 11 (actually calling the new function instead of `print_oas_operation`). Reminder, here's the command line to use it `jq -r -f search-operations-color.jq demo-api-openapi.json`.

{% codefile title:"$filename" file:search-operations-color.jq highlight:4,11 %}

Obviously, it is quite possible to merge the colored and uncolored search operations to have a single module taking format parameters to print how you want. I let you work on that to apply everything you have learned so far.

# Conclusion

That concludes for now this JQ and OpenAPI series, I may add some other posts if I create interesting JQ+OpenAPI modules. Thanks to what you have learned about JQ, you should be able to do whatever you want on any OpenAPI file and even on any JSON document, especially the one you may retrieve with `curl`; that may be a good topic for another series by the way ...
