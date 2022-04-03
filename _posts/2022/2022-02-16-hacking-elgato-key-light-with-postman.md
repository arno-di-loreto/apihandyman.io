---
title: Hacking and reviewing Elgato Key Light API with Postman
series: Hacking an Elgato Key Light
series_number: 1
date: 2022-02-16
author: Arnaud Lauret
layout: post
permalink: /hacking-elgato-key-light-with-postman/
category: post
tools:
    - Postman
---

Want to learn how to hack a desktop app calling an API and learn some API design principles?
This post is made for you.
When I got my Elgato Key Light, my first questions were: "can I control it without using the official control center using an API?" and "is the API easy to understand and use?".
Thanks to Postman's proxy feature, I was able to easily hack the API.
But I was also able to review it in the making, and there's some interesting API design learnings to share.
<!--more-->

# Why this post?

I recently joined Postman (the company) and while I have been using Postman (the tool) since its creation, I didn't much used it the last 4 years as I was spending most of my time doing API design reviews and not much using APIs.
I forgot many things, and during that time Postman has evolved a lot!
So, I my goal is to (re)learn how to use (and hack) extensively Postman.
Instead of keeping all that for myself, I'll share my learnings in multiple blog posts.

As I just received an Elgato Key Light to enhance the quality on my video calls and video recordings (that's worth the investment!) and as this device comes with an API, I thought "Hacking my Elgato Key Light" was the perfect topic to start (re)learning how to use Postman.
Everything explained here and in future posts should be reusable "as is" with the other variants of Elgato Lights.
And if you have other connected devices coming with desktop control application, you should be able to do what I'll show you with them.

And as always, this post is not only about using a tool, we'll talk about some API design principles in the making!

# Discovering the Key Light API

To control the Elgato Key Light, you can install the Elgato Control Center on you computer (Mac or Windows), there are also iOS and Android apps.
In order to hack the Elgato Key Light, I need to discover what requests can be done.
To do so, I captured the HTTP traffic going out of the Elgato Control Center desktop application using Postman as a proxy. 

## Setting up Postman Proxy

With Postman, you can intercept HTTP traffic in 2 different ways, the Interceptor that runs in Chrome or the Proxy that can be used to capture any HTTP traffic on your machine.
We will use the second option.

The whole documentation is available here: [Capturing HTTP Request](https://learning.postman.com/docs/sending-requests/capturing-request-data/capturing-http-requests/).
Here's a light recap of what I did on my Mac:

### Configuring Postman

{% include image.html source="postman-proxy-configuration.jpg" %}

- Start Postman
- Create a "Hacking Elgato Key Light" workspace
- Create a new collection "Capture Control Center - Raw" 
- Start proxy with "Capture requests and cookies" in status bar (bottom right)
- Use "Via Proxy"
- Check Save Responses for Requests
- Click "Enable Proxy"
    - Keep 5555 port
    - Click on enable proxy
- Now "Proxy is enabled"
- Save requests to previously created collection and choose "Capture Control Center - Raw"
- Check "Domain name" and "Endpoints" in "Organize requests by"

### Configuring OS

Note: I'm using a Mac, but it shouldn't be that different on Windows.

{% include image.html source="macos-network-configuration.jpg" %}

- Open "Network" in System Preferences
- Select your first network interface
- Click on "Advanced..."
- Go to "Proxies" tab
- Check "Web Proxy (HTTP)"
- Set Web Proxy Server host and port to `localhost` and `5555`
- Remove local adresses patterns from "Bypass proxy settings for these Hosts & Domains"
- Click "OK"
- And don't forget to clik on "Apply"

Now we're ready to capture HTTP traffic.

## Capturing (too much) HTTP traffic

Back in Postman, click on the "Start Capture" button and play with the Elgato Control Center.
You can turn on or off the light, change brightness and temperature.

{% include image.html source="postman-capturing-http-traffic.jpg" %}

Once done, click on Stop and you'll find all requests in the "Capture Control Center - Raw".
Requests are organized by domain and endpoint, each request being materialized as an example.

{% include image.html source="first-capture-collapsed.jpg" %}

That's pretty neat, I have a good overview of the requests done during the capture.
But I have 2 problems:

- First, there are request coming from another application (Chrome)
- Second, there are many request examples as you can see below

{% include image.html source="first-capture-too-much-examples.jpg" %}

While it's not really a problem for the GET requests, it's more annoying to understand what is done with the PUT one.

## Capturing (the right) HTTP traffic

In order to avoid being poluted with too much requests, let's try something more subtil.
First, let's start a new capture but with some changes in the configuration.
To only get traffic for the Key Light, set "URL must contain" to "elgato".
And to keep only PUT requests, add `PUT` to "Methods".

{% include image.html source="capture-filter-configuration.jpg" %}

Then, when using the Elgato Control Center, let's do one thing at a time.

- For instance, turning the light on
- Then go back to Postman, and stop the capture
- Check the request (checkbox before Status)
- And click on "+ Add to collection"
- Create a new "Capture Control Center - Selected" collection

{% include image.html source="capture-selected.jpg" %}

Now go to the newly created collection and rename the cryptic example to "Turn on".
You can do that for "Turn off", "Set temperature to maximum", ...
Everything that comes to your mind.
You can also capture multiple request and select a subset to add them to the collection.

{% include image.html source="capture-selected-collection.jpg" %}

Now we have everything to play with the API, we just have to copy/paste/modify the requests.
If you run into strange 400 errors, check if you don't have a hard coded `content-length` (yes without caps) in your request headers.
They come from the HTTP traffic capture and are not overrided by Postman (because "you" set them).

{% capture alert %}
Don't forget to reset your OS proxy configuration once you've finished!
{% endcapture %}
{% include alert.html level="warning" title="Reset OS proxy configuration" content=alert %}

# Reviewing the Key Light API

Thanks, to the capture HTTP traffic sessions, and taken for granted that the base URL of all requests is `http://device-name.local:9123/elgato`, we know that the Elgato Key Light API proposes the following operations:

- `GET /accessory-info`
- `GET /lights/settings`
- `GET /lights`
- `PUT /lights`

We'll focus this review on `GET /accessory-info` and `GET/PUT /ligths`.

## The neat GET /accessory-info entry point

Looking at this operation's response (below), we see some basic information like the product name and more technical information like some firmware information.
What caught my eye is the `features` list, it contains a `lights` value.
Based on other requests which paths start by `/lights`, I can guess that if one day I get another Elgato product with an API I can give a try to `GET /accessory-info`, look at the values in features, which could be "something" and then try a `GET /something`, `PUT /something` and possibly `GET /something/settings`.
It's not an hypermedia API, but at least it provides some hints that help you to use other Elgato APIs.

{% code language:"js" title:"GET /accessory-info response" %}
{
    "productName": "Elgato Key Light",
    "hardwareBoardType": 53,
    "firmwareBuildNumber": 200,
    "firmwareVersion": "1.0.3",
    "serialNumber": "BW21K1A01548",
    "displayName": "",
    "features": [
        "lights"
    ]
}
{% endcode %}

## The not so neat GET and PUT /lights

The following body is used by the Elgato Control Center when modifying the light status.

{% code language:"js" title:"/lights resource" %}
{
    "numberOfLights": 1,
    "lights": [
        {
            "on": 1,
            "brightness": 50,
            "temperature": 143
        }
    ]
}
{% endcode %}

It is composed of 3 pieces of information:

- `on`: Indicates if the light is on (1) or off (0)
- `brightness`: The brightness level in % from 0 to 100
- `temperature`: A quite cryptic integer representing the light temperature which goes from 2900K (344) to 7000K (143)

### When non human readable status is not a problem

While I usually prefer human readable strings for such status (like "on" and "off"), that's still easy to understand.
Especially in that case where there are only 2 values.
Also, it's fairly common to have on and off represented by 0 and 1, so Elgato follows a common practice, that's good.
And actually, when you have to use those values in code to turn the light on and off, that's actually pretty convenient.
So when designing API, think about understandability by humans, but also usability in code.

### Simple consumer side business rule

Strangely (or not), the application limits the bounds of brightness to [3,100].
But I was able to set brightness to 0 with Postman, it actually turns the light off (without changing the `on` value).
Maybe the API should handle that and manages those boundaries if that's important.
Never let consumer deals with provider's business logic, even [the simplest one](https://apihandyman.io/choosing-between-raw-and-processed-data-when-designing-an-api/), it will be really hard to modify it in ALL consumers and may lead to problems (hopefully I didn't ruin my Key Light).

### Silent error

By the way I also tested to set brightness to 110%.
I didn't got a `400 Bad Request` as I expected but a `200 OK`!
The Key Light didn't exploded hopefully.
Actually, the brightness was not modified, it kept its previous value.
That's a bad design, as a consumer/user, the API didn't warned me that I sent a value that will never ever be accepted.
So better return an explicit error.

### Terribly complex consumer side business rule

That's the worst part of the API, at least until I get more information about light temperature.
To control the temperature, the Elgato Control Center App proposes a slide which goes from 7000K to 2900K (K is for [Kelvin](https://en.wikipedia.org/wiki/Color_temperature)). 
But when it calls the API to change the temperature, it's not 2900, 6000 or 7000 that is sent but 344, 167 or 143.
I check a few values to understand what was the correspondance and realized there was some voodoo-non-linear-maths-physics magic involved.
That means consumers have to know some internal business logic that MUST be provider's business only.
That's a terrible idea, it makes the API really hard to use (and again: what will happen if the business rule has to evolve?).
Hopefully, I'm sure I'll find a way to make that more simple with some Postman magic.

### Convenient partial modification

Last but not least, you're under no obligation to send everything in the `PUT` body.
That may raise some HTTP-extremists' eyebrows, but I find this really convenient.
That way, I can just turn light on without having to know current temperature and brightness with the following body that got rid of `numberOfLights`, `brightness` and `temperature`.
Maybe providing a PATCH would make this request more HTTP-compliant.

{% code language:"js" title:"Turn on" %}
{
    "lights": [
        {
            "on": 1,
        }
    ]
}
{% endcode %}

# Your private API is not so private

By the way, what I've done here is a good reminder about "your private API is not so private".
So be careful about how you design it in order to, at least, block consumers doing things that could harm your providing system and, at best, to provide a simple to understand and simple to use API, even for those who are not supposed to use it.

# To be continued

As you can see "hacking" a desktop application that sends (unsecure and local) HTTP request is quite simple with a proxy (there are other tools than Postman to do so, for instance I remember using [Burp Suite](https://portswigger.net/burp/releases/professional-community-2022-1-1?requestededition=community) a long time ago).
With what we've done we can easily create requests that will do what we want by just copy/pasting/modifying the examples resulting from the HTTP traffic capture.
I'm working on a complete collection allowing to control the Elgato Key Light and doing so I used a few tricks that I'll show in future post(s).
In the meanwhile, you can already see what I've done by clicking on the button below.

[![Run in Postman](https://run.pstmn.io/button.svg)](https://app.getpostman.com/run-collection/143378-88ada3a6-de53-4599-93cf-cc0a5d365cd9?action=collection%2Ffork&collection-url=entityId%3D143378-88ada3a6-de53-4599-93cf-cc0a5d365cd9%26entityType%3Dcollection%26workspaceId%3Df0a96dd6-c7d8-46f7-9e62-4b95f25c4e43#?env%5BElgato%20Key%20Light%5D=W3sia2V5IjoibGlnaHRfbmFtZSIsInZhbHVlIjoiRWxnYXRvIEtleSBMaWdodCAxODc2IiwiZW5hYmxlZCI6dHJ1ZSwidHlwZSI6ImRlZmF1bHQiLCJzZXNzaW9uVmFsdWUiOiJFbGdhdG8gS2V5IExpZ2h0IDE4NzYiLCJzZXNzaW9uSW5kZXgiOjB9LHsia2V5IjoiYmFzZV91cmwiLCJ2YWx1ZSI6Imh0dHA6Ly9lbGdhdG8ta2V5LWxpZ2h0LTE4NzYubG9jYWw6OTEyMy9lbGdhdG8iLCJlbmFibGVkIjp0cnVlLCJ0eXBlIjoiZGVmYXVsdCIsInNlc3Npb25WYWx1ZSI6Imh0dHA6Ly9lbGdhdG8ta2V5LWxpZ2h0LTE4NzYubG9jYWw6OTEyMy9lbGdhdG8iLCJzZXNzaW9uSW5kZXgiOjF9LHsia2V5IjoiYmFzZV91cmxfdGVtcGxhdGUiLCJ2YWx1ZSI6Imh0dHA6Ly9OQU1FLmxvY2FsOjkxMjMvZWxnYXRvIiwiZW5hYmxlZCI6dHJ1ZSwidHlwZSI6ImRlZmF1bHQiLCJzZXNzaW9uVmFsdWUiOiJodHRwOi8vTkFNRS5sb2NhbDo5MTIzL2VsZ2F0byIsInNlc3Npb25JbmRleCI6Mn1d)