---
title: OpenAPI
alternate_title: OpenAPI Specification
author: Arnaud Lauret
layout: post
permalink: /openapi/
menu: true
sort: 1
---

This page lists the OpenAPI Specification resources available on apihandyman.io.

# But what is the OpenAPI Specification?

The OpenAPI Specification (or OAS) is a standard and programming-language agnostic REST API description format.
Formerly known as the _Swagger Specification_, this format has been donated to the [Open API Initiative (or OAI)]([https://www.openapis.org/]) which is a Linux Foundation Collaborative Project.

There are two versions of the OpenAPI Specification:

- [Version 2.0](https://github.com/OAI/OpenAPI-Specification/blob/master/versions/2.0.md) which is basically Swagger 2.0 Specification
- [Version 3.0](https://github.com/OAI/OpenAPI-Specification/blob/master/versions/3.0.1.md) which is the first evolution after the donation of the Swagger Specification to the Open API Initiative

The OpenAPI Specification is a community driven format, anyone can contribute to it through its github [repository]([https://github.com/OAI/OpenAPI-Specification]).

# OpenAPI Specification version 2.0 Tutorial

Learn all OpenAPI Specification 2.0 secrets with this 9 parts tutorial:

{% assign sorted = site.posts | where:"series", "Writing OpenAPI (Swagger) Specification Tutorial" | sort:"series_title"  %}
<ul>
  {% for my_page in sorted %}
    {% if my_page.series_title == page.series_title %}
    <li><strong>{{ my_page.series_title }}</strong></li>
    {% else %}
    <li><a class="page-link" href="{{ my_page.url | prepend: site.baseurl }}">{{ my_page.series_title }}</a></li>
    {% endif %}
  {% endfor %}
</ul>

# OpenAPI Map for version 2.0 & 3.0

If you're a bit lost in the OpenAPI Specification documentation, take a look at the *[OpenAPI Map](http://openapi-map.apihandyman.io/):*

{% img file:"/images/commons/openapi/openapi-map.png" label:"OpenAPI Map" source:"http://openapi-map.apihandyman.io/" %}