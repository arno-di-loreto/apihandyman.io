---
title: Barely surviving my first live (non recorded) demo session
date: 2021-09-29
author: Arnaud Lauret
layout: post
permalink: /barely-surviving-my-first-live-non-recorded-demo-session/
category: post
tools:
  - OBS Studio
  - Visual Studio Code
---

Yesterday, I live demoed how I take advantage of the OpenAPI Specification during an API Design review at the API Specification Conference.
This session was really live, not recorded like my previous one, and that didn't totally went well.
Though I was quite happy to discover new tricks, I had problems preparing this session and worse I also had problems giving it.
Nothing that terrible hopefully, but still terribly annoying and stressful.
I need a cathartic post to talk about all that.
<!--more-->

# Facing OBS browser cache issues

During my previous (and first) live demo session I started to use [OBS](https://obsproject.com/), you can read the whole story [here](/setting-up-everything-to-record-myself-coding-and-talking/#discovering-obs-studio)).
I decided to reuse what I had done, especially my [pseudo-slide-deck system](/slide-deck-like-live-coding-with-titles-and-speaker-s-notes-using-obs-and-vs-code/) in order to have section titles and speaker notes.
To explain this shortly:

- There's a `steps` folder containing `step-1` to `step-X` folders
- Each `step-X` folder contains at least an index.html (the sections title) and todo.html (my speaker's notes) HTML files (plus some other files if needed)
- A next.sh shell script copy the content of the next `step-X` folder to `steps`, I run it when needed with a shortcut in VS Code
- Both "current" HTML files can be loaded and live-reloaded automatically thanks to the [Live Server](https://marketplace.visualstudio.com/items?itemName=ritwickdey.LiveServer) VS Code extension
- The `index.html` file is visible in OBS via a browser source
- The `todo.html` is just opened in a browser (on my iPad in sidecar mode) 

{% include image.html source="tweet.jpg" %}

This time the `index.html`was not containing text but a PNG image with a transparent background (top right corner in the screenshot above).
At my first attempt, I simply gave the same name to all the different images `steps/step-X/title.png`, the HTML containing `<img src="title.png">`.
The problem was that the browser inside OBS was not reloading the image because it was cached.
To solve this problem I simply stored all images in `steps/images` with different names and targeted `steps/images/specific-name.png` in the `img` tag.

# Adding scene switching to my system

In my previous live session, I didn't needed to use scene switching but this time I wanted to be able to switch between a scene showing my Macbook display and another one with only my webcam when needed while still being able to use my "next slide" script.
I did that by configuring the "Title" tab of the Advanced Scene Switcher as follow:

{% include image.html source="scene-switch-title-regex.jpg" %}

The first line targets a terminal window whose title may change, so I used a regex (the `.*` part of the title).
The second line targets my VS Code window.
That configuration means: if I click on my terminal, OBS shows the Camera scene and if click on VS Code, the VSCode scene is shown.
While having the focus on the terminal I was able to launch the `next.sh` command to go to next step if needed.

Then a few hours before the conference, I wanted to add a third scene for the introduction.

{% include image.html source="tweet-intro-scene.jpg" %}

I was able to handle that by simply adding a `scene.txt` in all of my `steps/step-X` folders and then configure the "File" tab of the advanced scene switcher plugin to change the scene based on the content of `steps/scene.txt`.
Depending on the scene, the file may contain "Intro" or "Camera" (the scene's name) or be empty.
In this last case, the scene switcher fallback to "title" mode.

{% include image.html source="scene-switch-file.jpg" %}

# Noticing EpocCam lag in OBS

I my previous ["live" series](/setting-up-everything-to-record-myself-coding-and-talking/#looking-good-enough), I explained how an iPhone could be used as a webcam with EpocCam.
I actually did not used it that time, but I did use my iPhone as Webcam several times for video calls and podcast recordings (yes, video is recorded sometimes for podcasts).
I had absolutely no problem at all.
But this time, I don't know yet why, I faced some lag issue: the video not sync with my audio when using OBS.
I realized that 2 hours before the conference 🤦🏻‍♂️.
So, as I had not much time to figure what the problem was and how to solve it, I decided to use my terrible Macbook webcam ... and plan to buy a descent camera.

# Chaotic session's content preparation

Maybe having 3 totally different conference talk for this year was too much, it take me an awfully long time and dedication to prepare one. 
I had too much work to do these last weeks and not enough time to prepare ... and was not in the mood for it.
That happens sometimes, not being in the mood, but it was not a blog post I could postpone, people were expecting to see this session.

The idea was to design an API having a few design issues that would allow me to showcase how I review a design and my tools. 
I really struggled to prepare this API and was not totally satisfied in the end.
The resulting API looked too much artificial.

I hadn't much time to prepare my speech and do the rehearsal.
Hopefully, lastly I was able to practice quite often "presenting without any notes" while doing API design training sessions.
So though I was not totally confident, I felt I could let go my "word for word" preparation and be more spontaneous.
Once the sections of my talk were defined I did a few tests and was quickly able to evaluate the time for each one, added the timing to my speakers notes and was "ready" for the show.

# Facing technical issue during the session

And the show didn't go so well but not because of my lack of preparation...

I did an audio/video test 30 minutes before my session and there was something wrong.
The person I did the test with told me there was a small random delay with my video (I was sharing my 27 inches display screen showing a fullscreen OBS projector and not using my webcam directly).
I took time to do some tests and I noticed a few things (the platform used was Hopin in Chrome):

- Sharing a just a window instead of the screen was terrible. Huge video lag
- Reducing the resolution of my screen apparently allowed to remove the lag

So here I was ready for the show and I started to talk: "Hello, everyone..." ...
But some friends in the chat told me my audio was "scratching" or doing static sound.
Not knowing what to do, I switched to the MacBook audio instead of my super cool Shure SM7B then switched back to the Shure.
Problem solved ... 30 seconds.
I switched back again to MacBook audio, it was working, "Don't touch anything" someone told me 😅.
I lost 2 to 3 minutes I think, but I started the session.

Everything was working well, though I noticed some lag in VS Code scrolling.
Slowly but surely my MacBook was becoming less responsive.
It seems that both OBS and Chrome were using much CPU, but I suspect there were some other process slowing my Machine (I was telling to myself "it's a f****** gazillion cores MacBook Pro 16, how can it be so slowed down!").
I think the mic problem was caused by high CPU usage.
Whatever, I was unable to fully demoed my final tool (in Excel, yes, Excel) but was able to explain the spirit.

So, it didn't went so well BUT, I don't know how, I succeeded to keep my calm and people were happy with the session's content, so I can live with that.
I'll need to figure what was the problem in order to avoid having it again.
And I'll need to prepare a plan B just in case, because Murphy's law.
Oh, and I must not forget to buy a f****** camera.
But for now, I'll take some rest.