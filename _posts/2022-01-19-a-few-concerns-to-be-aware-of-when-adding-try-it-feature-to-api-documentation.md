---
title: A few concerns to be aware of when adding try it feature to API documentation
date: 2022-01-19
author: Arnaud Lauret
layout: post
permalink: /a-few-concerns-to-be-aware-of-when-adding-try-it-feature-to-api-documentation/
category: post
---

“That’s neat!
The developer portal/api documentation solution we chose comes with a try it feature.
Everything is out of the box, we’ll have absolutely nothing to do to allow people test our APIs.”
… If only that was true.
Unfortunately, there are a few concerns to be aware of to actually propose a try it feature.  
<!--more-->

# What is a "try it"

When browsing an API documentation, most usually when looking at the reference documentation (the one describing all `GET /this` and `POST /that`), you'll see a "try it" or "send request" button.
Clicking on it, you'll get a form allowing to provide data (query parameters or request body) and then send an API request.
That's pretty useful to learn how an API works without having to write a single line of code.
That greatly contributes in creating a good user experience, either users are developers who will create applications consuming your APIs, but also decision makers who are evaluating them.

# Choosing an API to call

The first question you must explore when working on adding a try it feature to your API documentation is "who you gonna call?".
Not Ghostbusters obviously.
The try it feature can trigger more or less real API call.

Indeed, There could be no actual API call, the website just showing fake data.
It can also make actual API call but not to the real API.
A try it may call a sandbox environment that reproduces or simulates the production environment.
And last but not least, it could trigger a call to the real production API.

You're under no obligation to apply only one of those solutions, the API that will be called may depend on the user profile.
For instance, if the user is not connected maybe they can only get the local fake data and if they are connected gain access to the sandbox environment.
You may also let user choose themselves, once connected, they could choose between sandbox and production environment.

# Managing security

It's rare to provide unsecured APIs, even sandboxed ones.
So, when providing a try it feature, you'll have to find a way to provide a relevant access token before triggering the API call.
Obviously, letting end user manage that all by hand would be a terrible idea.
Better find a way to make that as seamless as possible, if possible without any user's help.

# Providing samples

In order to provide an even better end user experience, it would be interesting to provide ready to use data.
For instance, if I can try `GET /accounts/{accountNumber}`, I would be very happy having a drop list with accounts in various situations.
If can try a `POST /accounts`, a pre-filled body could be great, and a list of pre-filled body even more great. 
Also when dealing with security, providing a way to choose some different user profiles, like "user with a single bank account" or "user with joint bank account and 2 savings" can be quite interesting.
The chosen profile conditioning all requests done through the try it.
Note that I must also be able to send my own request without using sample data.

# Embedding try it

I said in the beginning of this post that the try it feature is often seen in the reference documentation, but it can be elsewhere.
It's especially interesting to put some try it forms in the "recipe documentation", the tutorials explaining how API operations can be used together to achieve some use cases.
Being able to put a try it form anywhere, a little bit à la jupyter notebook, will allow to easily create awesome documentation that users will love.
And being able to do an API call from the home page would be terrific!

# Try it and beyond

I hope you'll find this post useful when you'll think about adding a "try it" to your API documentation.
Note that people may need to try your API outside of its documentation, that's why a working on a good sandbox is important.
But we'll talk more about that in another post.