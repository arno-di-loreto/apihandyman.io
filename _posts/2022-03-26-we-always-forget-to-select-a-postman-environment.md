---
title: We always forget to select a Postman environment
date: 2022-03-26
author: Arnaud Lauret
layout: post
permalink: /we-always-forget-to-select-a-postman-environment/
category: post
---

When using Postman, it's a best practice to store API token values in environment secret variables.
Environment variables can also be used to store other variables uses in scripts.
But when opening a collection, we often forget to select an environment and spend a few seconds if not minutes or more trying to figure out what the problem is with a request. Just to realize in the end that we just forgot to select an environment.
How can this be avoided?
<!--more-->
This post is actually my first "Postman Collection Post", I'll share the tips and tricks I learn while using Postman.

The [Don't forget to select an environment](https://www.postman.com/apihandyman/workspace/postman-tips-and-tricks/documentation/143378-215afe9b-9b7d-459d-b020-361dbf1c5bf4) collection demonstrates how to take advantage of `pm.environment.name` in Pre-Scripts to prevent sending a request and have a clear error message when an environment is not selected. The use case that will be used to demonstrate all that is retrieving a tweet with Twitter v2 API. The aim of this collection being error handling, you'll need to have an actual access to Twitter v2 API only if you want to make the request succeed.

[![Run in Postman](/images/commons/run-in-postman.svg)](https://god.gw.postman.com/run-collection/143378-215afe9b-9b7d-459d-b020-361dbf1c5bf4?action=collection%2Ffork&collection-url=entityId%3D143378-215afe9b-9b7d-459d-b020-361dbf1c5bf4%26entityType%3Dcollection%26workspaceId%3D028152cd-d2f2-497f-a533-72e3d50e1b48)

(Click on the "View complete collection documentation" link in lower right corner to see documentation in full screen)