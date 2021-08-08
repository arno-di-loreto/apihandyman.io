---
series: Surviving my first (recorded) live coding session
series_title: Live coding at light speed with VS Code
series_number: 4
date: 2021-08-25
author: Arnaud Lauret
layout: post
permalink: /live-coding-at-light-speed-with-vs-code/
category: post
---

Fourth post about about my first ever (recorded) live coding session.
Blah blah blah
<!--more-->

{% include _postincludes/live-coding-session.md %}

I was already satisfied with the way I was activiting/deactivating the Redoc or Swagger UI renderings using the command palette (<kbd>⌘</kbd><kbd>⇧</kbd><kbd>P</kbd> on MacOs or <kbd>ctrl</kbd><kbd>⇧</kbd><kbd>P</kbd> on Windows) and the "OpenAPI: show preview using X" tasks coming with the OpenAPI extension, but I still needed to speed up coding.

# Copy/Paste and indent

{% include image.html source="copy-paste-indent.gif" %}

At some moment, I had to copy/paste sections of code but that requires fixing indentation, and I was not good at that.
In the beginning I was relying to the Indent Rainbow extension to give me indications on how to indent after pasting, but it was taking too much time.
Hopefully, I found a faster way to fix indentation on copy/paste:

1. Copy the lines, but carefully include the full first list. It's easier to start by the end of selection of go up (do not start selecting at the first word of first line)
1. Put cursor at the beginning of the line where you need to paste
1. Paste
1. Format whole file using <kbd>⌥</kbd><kbd>⇧</kbd><kbd>F</kbd> (MacOS) or <kbd>ctrl</kbd><kbd>⇧</kbd><kbd>F</kbd> (Windows). This will fix indentation based on the line above the one where you pasted. But that only works if the whole pasted block is already correctly indenting (relatively).

# The tip you need when opening/closing terminal

I had hard time showing and hiding the terminal, sometimes it was working and sometimes not and that was making me loosing precious seconds.
I was starting to get mad until I figured out how it works.
Showing and hiding the terminal can be done with <kbd>ctrl</kbd><kbd>`</kbd>.
The problem is if the terminal is shown but has not the focus <kbd>ctrl</kbd><kbd>`</kbd> will just give it focus. 
So be careful about that.

# The magic of code snippets

The trick that made me gain much time while coding is [user defined snippets](https://code.visualstudio.com/docs/editor/userdefinedsnippets).
Thanks to some configuration, just type "some magic keyword" and boom a complex regex or 20 lines of code appears magically.

{% include image.html source="snippets.gif" %}

You can define global or local snippets.
I used local ones defined in `.vscode/supercharged-openapi.code-snippets` which is a json file.
A snippet can be a static text but you can also use variables and even choices list (probably among other awesome things I didn't used yet, check the [document](https://code.visualstudio.com/docs/editor/userdefinedsnippets)).

The following example allows to add a "Read an element" operation in the form of the `GET /somethings/{somethingId}`.
It is triggered when typing "Read" (`prefix`) then hitting the tab key.
There are two variables `$1` and `$2` to provide, note how `$1` appears multiple times.
Once you hit tab, you type the first variable value which is filled wherever there's a `$1` in the body.
Hit tab to set `$2`.
And don't forget to hit tab another time to finish.
If you don't do that last tab, you'll be unable to use another snippet, it took me a moment to figure that.  

{% code language:"json" title:"A snippet with variables" %}
{
	"Read an element": {
		"scope": "yaml",
		"prefix": "Read",
		"body": [
			"/$1s/{$1Id}:",
			"\tget:",
			"\t\tsummary: Read a $1",
			"\t\tparameters:",
			"\t\t\t- name: $1Id",
			"\t\t\t  in: path",
			"\t\t\t  required: true",
			"\t\t\t  schema:",
			"\t\t\t  \ttype: $2",
			"\t\tresponses:",
			"\t\t\t'200':",
			"\t\t\t\tdescription: OK",
			"\t\t\t\tcontent:",
			"\t\t\t\t\tapplication/json:",
			"\t\t\t\t\t\tschema:",
			"\t\t\t\t\t\t\ttype: object"
		]
	},
}
{% endcode %}

Beware of tabs count, the snippet will be magically indented correctly based on where you put it, so there's no need to add extra tabs.
The example above is supposed to go into `paths:` which is at the root level of the document.
So I thought the first line would need a tab (and all the the other ones below too), but no.
The whole body is indented based on first line having no indentation.

Note also that multiple snippets can match a keyword/key sentence, there will be a drop list to let you choose the one you want (with a full view of the body).
Just don't forget to look at the one that is chosen to add the right snippet to your code.

Using snippets generator such as [this one](https://snippet-generator.app/?description=&tabtrigger=&snippet=&mode=vscode) can be useful to turn your code template into a snippet.

# Next problem

Blah blah blah