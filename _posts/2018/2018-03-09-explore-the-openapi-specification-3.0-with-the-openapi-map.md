---
title: Explore the OpenAPI Specification 3.0 with the OpenAPI Map
date: 2018-03-09
author: Arnaud Lauret
permalink: /explore-the-openapi-specification-3.0-with-the-openapi-map/
layout: post
category: post
tools:
  - OpenAPI Specification
  - OpenAPI Map
---

So you want to explore in depth the OpenAPI Specification version 3.0? You should take the OpenAPI Map with you!<!--more-->

The OpenAPI Specification Visual Documentation is dead, long live the [OpenAPI Map](http://openapi-map.apihandyman.io/)! Very special thanks to [Marsh Gardiner](https://twitter.com/earth2marsh) for helping me find this name.

# What is the OpenAPI Map?

Just in case you missed previous releases, the OpenAPI Map is a representation of the OpenAPI Specification documentation as a tree. Using it, you can see how an OpenAPI document is organized and discover all OpenAPI objects and properties dark secrets.

{% img file:"/images/commons/openapi/openapi-map.png" label:"OpenAPI Map" source:"http://openapi-map.apihandyman.io/" %}

# Updated 3.0.0-rc0 to 3.0

Besides changing the tool's name, I have replaced the OAS 3.0.0-rc0 version by 3.0 (3.0.1 precisely). You can now fully explore the OpenAPI Specification 3.0 version. This update from 3.0.0-rc0 to 3.0 was a bit longer than expected. There were quite some changes between the early 3.0.0-rc0 version and 3.0 official release. The version 3.0 is now fully documented and includes a complete changelog from version 2.0.

# Other enhancements

- The Open API Map shows version 3.0 by default
- Version 2.0 is still available via the navigation bar and you can now even access it directly using this link: [http://openapi-map.apihandyman.io/?version=2.0](http://openapi-map.apihandyman.io/?version=2.0).
- Mandatory properties labels are now in red, no more need to pass mouse over a property to see it [Issue #10](https://github.com/arno-di-loreto/openapi-map/issues/10).

# Source available on Github

You can fork this project on [github](https://github.com/arno-di-loreto/openapi-map). I have updated the readme in order to help people understand how it works but it may need some further updates. So do not hesite to tell me if you need help to use it.