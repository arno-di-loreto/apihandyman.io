---
series: Surviving my first (recorded) live coding session
series_title: It was more complicated than just coding and talking
series_number: 2
date: 2021-08-11
author: Arnaud Lauret
layout: post
permalink: /it-was-more-complicated-than-just-coding-and-talking/
category: post
---

Second post about about my first ever (recorded) live coding session.
So, here I was in last post;
ready to record myself coding and talking...
But I didn't told the whole story, it actually was more complicated than that to get there.
I struggled with session's content and length, typing fast enough, not forgetting to do or tell something.
And on top of that I had some brilliant idea to enhance the session visual style but that required more work. 
At some moment, I was totally desperate and I thought I wasn't going to make it.
But I finally succeed to make it and attendees seem to have enjoyed it!
<!--more-->

{% capture alert %}
This live coding session was about the OpenAPI Specification, how to use it efficiently when designing and documenting API.
The idea was to write an OpenAPI Specification document and show the spec basic to advanced features, tips and tricks and use a few tools around all that.

Note that I'll soon start an OpenAPI Tips & Trick series including this session contents and a few other things I couldn't show during this session.
{% endcapture %}

{% include alert.html content=alert level="info" %}

# Realizing it's not working well

In previous post, I showed how I set up OBS and VS code, but I did not told the whole story. 
I didn't end up with the VS Code (plus embedded terminal) at first try.
Actually, in the beginning I planned to do far more stuff and differently, and that didn't worked well.

## Preparing content almost as usual

I actually worked on the content before mingling with OBS, VS Code and all other stuff.
I treated this session's content almost like I usually do for my regular slides-based talks.

Usually, I list the topics I want to talk about and then sort them in order to tell a story with a beginning and an end.
I go deeper into the story by writing a detailed table of content.
Then I write my full speech exactly as I will say it.
It need to be precise because English is my second language and I want to avoid stumble on words.
And after that, I do the slides using a (pop culture) theme that usually had popped in my mind while working topics, toc or speech.

Here, the topics were the OpenAPI Specification features and tools I wanted to show.
Building the story was made first by organizing the features in two categories: interface contract features and documentation features.
Then in each category, I sorted the features from simple/beginner to complex/advanced.
I added some extra entries in both categories to showcase various tools. 
With that, I had my table of content.

Then instead of writing my speech, I wrote an OpenAPI file adding each feature one by one.
I had to think about an example. 
I wanted to keep things simple in order to have a simple CRUD API, but as always I added some pop culture reference ... and ended with the Masters of the Universe API, an API providing information about characters and toys from the franchise.

The OpenAPI file did not came right at first try, I had to rework it several times.
I improved it while working the "how to show that", but it was more complicated than expected.
Indeed, my original plan for "how to show that" had not worked well.

## Too much, too complicated, a bit off topic

The plan was to write the OpenAPI document using [Stoplight Studio](https://stoplight.io/studio/), but not for its GUI feature that allows to NOT write OpenAPI code, but because it provides a cool renderer that updates itself smartly as you write code.
Indeed when using renderers such as [Redoc](https://github.com/Redocly/redoc) or [Swagger UI](https://github.com/swagger-api/swagger-ui), even embedded in VS Code (using the really good [42 Crunch OpenAPI Editor extension](https://marketplace.visualstudio.com/items?itemName=42Crunch.vscode-openapi)), the experience is not good.
For instance in Swagger UI, if you had opened en operation and selected the Schema pane, modify something and you'll to re-switch to schema pane yourself.
Studio comes also with an embedded mock server based on [Stoplight Prism](https://stoplight.io/open-source/prism/) that I wanted to use in [Postman](https://www.postman.com/).
I made a few test, writing code in Studio, importing the created OpenAPI file in Postman so it generated a ready to use collection targeting the Prism mock.
Mostly to showcase various usage of an OpenAPI document.

While all those tools are great and all this actually worked ... it was too long, too complicated to switch between tools.
And on top of that, my research for the best zoom level to use in order to keep code readable ended with being unable to have both code and rendering visible in Studio.
All that actually helped me realized that I was probably also going a bit off topic in the way of presenting things.

## Focusing on the real topic

What I wanted to show was more the OpenAPI Specification itself and its inner possibilities rather than showing tools using it just to show them using it.
I needed to do that efficiently using tools only to showcase the features I was using.

So, that's why I chose to

- Use only VS Code, showing only OpenAPI code most of the time
- Show rendering with Swagger UI and Redoc only when actually needed (using [42 Crunch OpenAPI Editor extension](https://marketplace.visualstudio.com/items?itemName=42Crunch.vscode-openapi))
- Use Prism and [httpie](https://httpie.io/) in VS Code embedded terminal only to illustrate features I was actually using with dummy API calls

## Still not working well and terrible new idea

But even taking those decisions, it was still hard to deliver the session smoothly and in the given time frame.
There was still probably too much content.
Also, it was taking me an awfully long time to type everything or do copy/paste and fix indentation.
I was struggling to switch between writing code and going to the terminal.

I realized that I was often forgetting things to do or not doing them the right way.
During a rehearsal that was starting very well, I lost all my means because I forget to do a modification and so was totally puzzled not understanding why it was not working. 

It was not going well and as it was difficult to work on specific sections of the sessions, to train/improve, I was starting loose my temper and my confidence.

And as if I didn't have enough problems, I had a new terrible idea.
I was really missing having titles like on my slides, I feared attendees would be lost without visual indication about what was happening.
I decided to do something about that.

What follows explain how I solved all those problems.

{% capture alert %}
You can get all VS Code stuff explained in this post in my [supercharged-openapi](https://github.com/arno-di-loreto/supercharged-openapi) github repository.
It is the one that I actually used during the session.
{% include image.html source="github.png" %}
{% endcapture %}

{% include alert.html content=alert level="info" %}


# Adding titles to avoid loosing attendees

OK, that was not the most important problem, but I care a lot about how my presentations look like: how they can be beautiful but also readable. 
So though this was a no slides session, I wanted to provide some indications about what was happening.
I needed to show some title, like "Describe once (EXPERT): Read/Write with same schema", as I have on my regular slide.
But this time, I was not showing pre-made slides using Google Slides but coding in VS Code.
How to add good looking titles in that context?
By taking advantage of both OBS and VS Code features.

## Showing titles above VS Code

{% include image.html source="magic.jpg" %}

In OBS, you can add various sources in a scene, I already had 3:

- An Image source: the foreground Manning provided to me
- A Video Capture Device source: my webcam (or my IPhone)
- A Display Capture Source: my MacBook display cropped on VS Code window titled "Supercharged OpenAPI" (By the way, regarding capturing VS Code, during my tests I also tried the Window Capture source and was not really satisfied with it. There was a huge lag, especially when I was scrolling.)

But there are other types of sources, as you can see in the screen capture above, the one that caught my eye when trying to find a solution for my idea was the Browser source.
I created a simple HTML file with "WTF it works!" (yes, I tend to curse in my code when testing) then started a [simple web server](https://www.npmjs.com/package/http-server). 
In the configuration window, I set up the URL, width, height, and there's some custom CSS that comes by default, I didn't modify it and hit OK.
Then I positioned the new source on top of the zone for my screen, above the Display Capture Source (the new source hides the VS Code window title) but below the Image source.

So I had my title, but it was a static one.

## Updating titles POC

I thought I could find a configuration to trigger refresh at regular interval in OBS, but there's actually no such configuration.
Hopefully, I remembered that while I was reading some post about useful VS Code extensions, the [Live Server](https://marketplace.visualstudio.com/items?itemName=ritwickdey.LiveServer) extension caught my eye.
This extension allows to start a web server in your workspace and it includes a live refresh out of the box.
That means a webpage loaded through this web server will be updated automatically in the browser when something change in the workspace.
So once the extension installed and started, I modified the Browser source configuration in OBS to target this web server, and I was still able to see the "WTF it works!" title.
Then I modified the HTML file by replacing the title with "WTF it has been updated!", hit save ...
And the title has been updated in OBS seamlessly!

Now that my proof of concept (POC) worked, I needed to show the real titles and switch to the next one when needed but without the attendees noticing anything.

## Updating titles magically during the session

What I did is quite ugly, it's a very first solution that would deserve to be improved (it will be improved!).
But it works.

### First, write some ugly shell

In a `steps` folder, I created sub-folders named `step-1` to `step-19` (because there were 19 steps in my TOC ... at that time) and then put an index.html file in each one.
Obviously, each file contained the title to be shown at each step (title coming from my TOC).

Then I wrote the ugliest possible bash script named `next.sh` (in `steps`).
In its most basic version, this script did the following:

- Checking if a `current.txt` file exist, if not creating it and putting `0` in it
- Reading the `current.txt` file, adding `1` to its value and updating it
- Copying the content of {% raw %}`step-{new value}`{% endraw %} to workspace root

So, running the `steps/next.sh` script (don't forget to `chmod u+x` it, like I always do) I could change title from step X to step X+1.  
But how to run this script while doing the session?
I couldn't open a terminal and run it when needed, that wouldn't be very convenient.

### Second, automate with VS Code task

Hopefully, I already partially knew how to solve that because in order to optimize my Jekyll workspace for the apihandyman.io blog I use [VS Code Custom tasks](https://code.visualstudio.com/docs/editor/tasks#_custom-tasks) to run bach scripts.
So I created a `.vscode` folder (it holds VS Code stuff) and added the following `tasks.json` file. 
This file define the custom tasks that will be available when this workspace/folder is opened in VS Code.

{% code title:".vscode/tasks.json" language:"json" %}
{
  "version": "2.0.0",
  "tasks": [
    {
      "label": "Next step",
      "type": "shell",
      "command": "steps/next.sh",
      "presentation": {
        "reveal": "never",
        "panel": "shared"
      },
      "problemMatcher": []
    }
  ]
}
{% endcode %}

Now instead of opening a terminal and typing a command line to run the script, I could open VS Code command palette (<kbd>⌘</kbd><kbd>⇧</kbd><kbd>P</kbd> on MacOs or <kbd>ctrl</kbd><kbd>⇧</kbd><kbd>P</kbd> on Windows) and choose `Tasks: Run task`, then choose the "Next step" one.
That actually runs the shell command `steps/next.sh` and that is done silently thanks to the `presentation.reveal: never`.
In the beginning, I actually set `presentation.reveal: always` to be sure that something was actually happening.
That's better but still cumbersome, I didn't want people watching me do that even if that's really quick.

### Third, add a little bit of shortcut magic

VS Code allows to customize keyboard shortcuts and even define one to trigger a task (check [documentation here](https://code.visualstudio.com/docs/editor/tasks#_binding-keyboard-shortcuts-to-tasks)).
Note that unlike tasks that can be configured inside a workspace, key bindings are only defined globally.

{% include image.html source="shortcuts.png" %}

To show shortcuts configuration use <kbd>⌘</kbd><kbd>K</kbd><kbd>⌘</kbd><kbd>S</kbd> on MacOs or <kbd>ctrl</kbd><kbd>K</kbd><kbd>ctrl</kbd><kbd>S</kbd> on Windows.
Then click on the file icon on top right corner to see the json content of your custom configuration (`keybindings.json` file).

In order to trigger my "Next step" task when typing <kbd>ctrl</kbd><kbd>m</kbd>, I modified my configuration as follow:

{% code title:"keybindings.json" language:"json" %}
// Place your key bindings in this file to override the defaults
[
    {
        "key": "ctrl+m",
        "command": "workbench.action.tasks.runTask",
        "args": "Next step"
    }
]
{% endcode %}

Note that before choosing <kbd>ctrl</kbd><kbd>m</kbd>, I actually tested a few other shortcuts before finding one that was not already used.
To check if a key binding already exists, type it in the text field above the lists as shown in the screenshot above.

That way, I could be like "blah blah blah, and now _next topic_" ... while magically changing the title with <kbd>ctrl</kbd><kbd>m</kbd>.

## Styling titles

I could change my title but it was simple black text on white background, I wanted something with more style and if possible matching VS Code Style.
Hopefully, while configuring VS Code to use the [Synthwave x Fluoromachine theme](https://marketplace.visualstudio.com/items?itemName=webrender.synthwave-x-fluoromachine), I discovered that VS Code theming relies on good old CSS and that this theme CSS was located in `$HOME/.vscode/extensions/webrender.synthwave-x-fluoromachine-0.0.12/synthwave-x-fluoromachine.css`.
I copy/pasted the file in my workspace and added it to my index.html files then used some css classes defined for this theme: `monaco-editor` on body then `mtk6`, `mtk7` and `mtk8` on the various elements in my title, et voilà!
I had shiny neon styled titles.

{% code title:"Styling index.html" language:"html" %}
<html>
    <head>
        <link rel="stylesheet" href="index.css">
    </head>
    <body class="monaco-editor">
        <h1>
            <span class="mtk7">@apihandyman</span>
            <span class="mtk6"> Supercharged OpenAPI</span>
            <span id="section" class="mtk8">A basic OpenAPI File</span>
        </h1>
    </body>
</html>
{% endcode %}

I was quite satisfied until I realized that the blue text (`mtk6`) had not the neon effect (attention to details is both my super power and my curse).
I'm definitely not a CSS expert, but I'm damn good at copy/pasting.
So, I compared its definition with the two other `mtk`, and notice a difference: the `text-shadow` of the blue class had less parameters.
The neon effect is actually achieved by adding shadows of different colors. 
So I added the missing values, struggle a bit to choose the various colors but I ended with the following `text-shadow` that looked great!

{% code title:"Styling index.html" language:"html" %}
text-shadow: 0 0 2px #100c0f, 0 0 3px #61e2ff, 0 0 5px #61e2ff, 0 0 10px #03edf933;
{% endcode %}

# Adding speaker's note to avoid forgetting something

When I do a "regular" presentation, you may not notice when seeing on stage or watching me on a video, but I heavily rely on my speaker's notes.
There's my full speech there on each slide with some other information such as timing or "CLICK" when there are animation or transition to trigger at a specific moment in a sentence.
The more I practice a talk, the less I need them but I'm relieved to just know they are there if needed.

Unfortunately, there are no "speaker's notes" in VS Code and I was struggling to not forget something to say or to do.

## The Todo+ attempt

{% include image.html source="todo-v1.png" %}

My first attempt in order to void forgetting something was to use the [Todo+](https://marketplace.visualstudio.com/items?itemName=fabiospampinato.vscode-todo-plus) extension.
I created a steps.todo file basically containing my TOC.
The idea was to have the Todo+ panel opened while coding the OpenAPI file.
But that was not really convenient because it was visible to attendees and occupying space that I desperately needed.
It was also not really convenient as, in order to keep the todo list usable for me, I had to open/close tasks folders.

## The todo.html + iPad solution

{% include image.html source="todo-v2.jpg" %}

My second idea was to use almost the same trick as for the titles.
I added a todo.html in each `steps/step-x` folder.
That way when I was using the "Next step" task, not only it was copying the `index.html` file of the step to the root folder, it was also copying the `todo.html` file too.
Having a browser showing `http://localhost:5500/todo.html` allowed to me have speaker's notes updated at each step just like titles.

In order to keep those notes out of the way but still allowing me to look at them without loosing eye contact with my main screen and its web cam, I used the "sidecar" feature of my iPad.
All that is needed is to plug the iPad to the Macbook with a USB cable then go to display preferences, choose the iPad as an Airplay display.
Don't forget to position it relatively to other screens as it is in reality in order to keep moving mouse to it simple.
And you're done you have a third (or second) display screen.
Note that sidecar can be used over wifi but I never had satisfying result with it (maybe my wifi is not fast enough).

I choose to use the same style as for the titles though is was only visible to my eyes.
I also used various emojis to type the actions to do:

- ✏️ (pen) to write code
- ⌨️ (keyboard) to use the terminal
- 📺 (old TV) to show a rendering og the file (with Redoc or SwaggerUI) 
- 💬 (Speech bubble) to say something

# Coding at light speed

I was already satisfied with the way I was activiting/deactivating the Redoc or Swagger UI renderings using the command palette (<kbd>⌘</kbd><kbd>⇧</kbd><kbd>P</kbd> on MacOs or <kbd>ctrl</kbd><kbd>⇧</kbd><kbd>P</kbd> on Windows) and the "OpenAPI: show preview using X" tasks coming with the OpenAPI extension, but I still needed to speed up coding.

## Copy/Paste and indent

{% include image.html source="copy-paste-indent.gif" %}

At some moment, I had to copy/paste sections of code but that requires fixing indentation, and I was not good at that.
In the beginning I was relying to the Indent Rainbow extension to give me indications on how to indent after pasting.
But after that I found a faster way to fix indentation on copy/paste:

1. Copy the lines, but carefully include the full first list. It's easier to start by the end of selection of go up (do not start selecting at the first word of first line)
1. Put cursor at the beginning of the line where you need to paste
1. Paste
1. Format whole file using <kbd>⌥</kbd><kbd>⇧</kbd><kbd>F</kbd> (MacOS) or <kbd>ctrl</kbd><kbd>⇧</kbd><kbd>F</kbd> (Windows). This will fix indentation based on the line above the one where you pasted. But that only works if the whole pasted block is already correctly indenting (relatively).

## The tip you need when opening/closing terminal

I had hard time showing and hiding the terminal, sometimes it was working and sometimes not and that was making me loosing precious seconds.
I was starting to get mad until I figured out how it works.
Showing and hiding the terminal can be done with <kbd>ctrl</kbd><kbd>`</kbd>.
The problem is if the terminal is shown but has not the focus <kbd>ctrl</kbd><kbd>`</kbd> will just give it focus. 
So be careful about that.

## The magic of code snippets

The trick that made me gain much time while coding is [user defined snippets](https://code.visualstudio.com/docs/editor/userdefinedsnippets).
Thanks to some configuration, type "some keyword" and boom a complex regex or 20 lines of code appear magically.

{% include image.html source="snippets.gif" %}

You can defined global or local snippets.
In used local ones define in `.vscode/supercharged-openapi.code-snippets` which is a json file.
A snippet can be a static text but you can also use variables and even choices list (probably among other awesome things I didn't used yet, check the [document](https://code.visualstudio.com/docs/editor/userdefinedsnippets)).

The following example allows to add a "Read an element" operation in the form of the `GET /somethings/{somethingId}`.
It is triggered when typing "Read" then hitting the tab key.
There are two variables `$1` and `$2` to provide, note how `$1` appears multiple times.
Once you hit tab, you type the first variable value which is filled wherever there's a `$1` in the body.
Hit tab to set `$2`.
And don't forget to hit tab another time to finish.
If you don't do that last tab, you'll be unable to use another snippet.  

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

Using generated such as [this one](https://snippet-generator.app/?description=&tabtrigger=&snippet=&mode=vscode) can be useful to turn your code template into a snippet.

# Achieving training almost as usual

It's not specific to this coding session, but when I prepare a talk there are always parts that needs more training than others.
It is quite easy when working on slides to just jump to the first slide of the part I need to work on, and again, and again until satisfied.
I can go 1 or 2 slides back if I want.
And I can work on parts almost randomly depending on my mood.
While training, I can also adapt content to shorten/remove some element because it's too long.

It was not that easy to do that here.

## Jumping back and forth to any step

Jumping to any part of the presentation was complicated here in the beginning because when I wanted to practice a specific part I had to re-prepare the OpenAPI file to put it in the state needed for this part. 
If I wanted to go "1 or 2 slides" back I had to carefully remember what to remove in my OpenAPI file.

At first I thought using branches or tagged commits, but based on a previous experience (for my JQ and OpenAPI series) I knew this was not going to work here.
And I already had a good part of the solution: I just had to create a `motu.yaml` file in each `steps/step-X` folder.
That trick also allowed to magically add code (actual code or comments) when switching to a new step, that was really convenient. 
That also ensured that I when switching to a new step, the OpenAPI file was in the expected status even if I had to skip something in previous step.

I also added new bash scripts and new tasks to be able to go to previous step and restart.
That way I could easily go to the step I wanted to practice.
After a while, once content has been stabilized I also added other scripts and tasks and ended with the followings:

| Task          | Script triggered    | Description
| --------------|---------------------|-------------
| Go to step    | `steps/go.sh $step` | Copy `steps/step-{$step}` content to root level (does nothing if step doesn't exist). The `$step` can be either a number or the step's name coming from the todo.html files, `"More accurate data description (4/15)"` for instance. The tasks shows the list of available steps (hardcoded in `tasks.json` file)
| Next step     | `steps/next.sh`     | Copy `steps/step-{current step + 1}` content to root level (does nothing if step doesn't exist)
| Previous step | `steps/previous.sh` | Copy `steps/step-{current step - 1}` content to root level (does nothing if step doesn't exist)
| Reload step   | `steps/reload.sh`   | Copy `steps/step-{current step}` content to root level (useful to check modifications done on current step)
| Reset step    | `steps/reset.sh`    | Copy `steps/reset` content to root level (to restart from the beginning)
| Clean before commit | `steps/clean.sh` | Remove `index.css`, `index.html`, `todo.html`, `motu.yaml` files from root folder

I only defined key bindings for Next and Previous step tasks.

## Removing stuff was a pain

As I was able to work on each step, I could easily evaluate the best possible time for each step.
And so I came  to the conclusion that I was still not fitting into the time frame, though I had an extra 5 minutes granted by conference organizers, saperlipopette! (french polite curse word).
Thanks to my list of steps and their timing, I had a better vision of what I should modify and so I:

- shorten some steps, by for instance starting with a pre-filled basic OpenAPI files or adding snippets
- remove some steps not bringing interesting information (like spending 30s explaining the various use of the OpenAPI Spec)
- remove some steps that were kind of duplicating other steps or not bringing interesting information

The modifications were easy to do on my list ... but doing it with my pretty dumb system and its `steps/step-X` folders containing many files, some of them (the todo.html) including "step X/Y".
It was a bit laborious to fix all that.
If I was not in a rush I would have redo everything in order to make such modification simpler ...
But sometimes it is better to leave well enough alone (the best is the enemy of good as we say in french), it took me less time to do that the ugly way than rethink the entire system.

# Recording and recovering

And after all that, working weekends and nights (I have a day job and a blog to handle), I was able to do the recording at last, and that went well on second take (the first one was 95% good but I forget something just in the end... saperlipopette again).
By the way, final tips: don't forget to put you phone AND you computer in do not disturb mode in order to avoid unwanted notifications when giving or recording a presentation.
I was happy, but totally exhausted, just like if I had spoke and attended at a in person 2 days conference and suffered jet lag, it took me more than a week to recover.
But this was worth the cost, attendees were happy and I hope that these 2 posts will help others doing coding sessions! 