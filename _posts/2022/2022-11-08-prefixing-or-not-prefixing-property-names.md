---
title: Prefixing or not prefixing property names?
date: 2022-11-08
author: Arnaud Lauret
layout: post
permalink: /prefixing-or-not-prefixing-property-names/
category: post
---

Adding a prefix to a name should be carefully weighed because it impacts the overall design of an API, some code, or a specification and its usability for humans and machines. The discussion related to `apiResponses`, `pathResponses`, and `responses` properties in the early design of OpenAPI v4 is a perfect example of that concern.
<!--more-->

# The context
Version 4 (aka. [Moonwalk](https://github.com/OAI/moonwalk)) of the [OpenAPI Specification](https://apihandyman.io/what-is-the-openapi-specification/) is in its early discussion stage. It breaks everything, and the direction taken is quite promising! This post takes its source in a [discussion related to `apiResponses`, `pathResponses`, and `responses` properties](https://github.com/OAI/moonwalk/discussions/34).

In OpenAPI 3 (and 2), operations' responses can only be set at the operation level (in `responses`). Though reusable responses can be created (in `components.responses`), that still means you have to define, for instance, the `401` and `500` responses key and reference the predefined responses (with a `$ref = '#/components/responses/<name>'`) for each operation. That's a bit annoying.

{% code language:"yaml" title:"Responses in OpenAPI 3.1" %}
openapi: "3.1.0"
# ...
paths:
  /resources:
    get:
      responses:
        401:
          $ref: "#/components/responses/Unauthorized"

components:
  responses:
    Unauthorized:
      description: Missing or invalid access token
      # ... 
{% endcode %}


In OpenAPI v4, the new design would allow defining responses at API (`apiResponses`), path (`pathResponses`), and operation (`responses`) levels. That way, the 401 and 500 responses could be set at the API level in `apiResponses` once and for all operations.

{% include image.html source="moonwalk-responses.jpg" caption="Responses in OpenAPI 4 Moonwalk" %}

# The issue and solutions

[Matthew Trask](https://twitter.com/matthewtrask) was faster than me to start a discussion and point there was something wrong with `apiResponse`, `pathResponse`, and (just)`responses` naming. "Confusing" and "verbose" were his words; I would add "inconsistent." 

## No prefix at any level
As the three `apiResponses`, `pathResponses`, and `responses` describe the same thing (responses) but at different levels (API, path, operation), I expect them to be all named `responses`. It's the context/location that tells at which level they apply (parent property name or sibling properties giving a clue about the level).

I use that "avoiding prefix as much as possible" naming strategy because:

-   Having the same name used for a "thing" favors consistency, understanding, and usability. It's human-friendly but also (dumb-)machine-friendly: "whatever the level, no need to think, just look for `response`" vs. "which level is this? then `{level}Response`".
-   Having shorter names enhance usability and readability.

That is well and good, but what if we keep them named as they are?

## The unexpected consequences of adding a prefix
Keeping a name such as `apiResponses` vs `response` implicitly defines a naming pattern that should be applied across all the specification: `<location>Thing` vs. `thing`.

So, if, for any reason, the `apiResponses`, `pathResponses` would be kept that way, for the sake of consistency, I would argue that:

-   `responses` which is at the operation level should be renamed `operationResponses`.
-   the `parameterSchemas` which appears at the path and operation levels should be respectively renames `pathParameterSchemas` and `operationParameterSchemas`.
-   the `contentSchema` properties which appears on request and response should be renamed `requestContentSchema` and `responseContentSchema`.
-   and so on ...

So adding such a prefix may have consequences across the whole design, it's like when throwing 💩 in a fan.

## But why would someone do such a "terrible" mistake?
The OpenAPI Specification v4 is in the early stage, and the current naming is probably just a "typo," or a consequence of "that looks clearer on the diagram."  Maybe it's just because in current version 3 the property at response level already exists and is (just)`responses`. 

That can happen to anyone, that's why requesting feedback, doing reviews (and defining guidelines) is important. That helps to fix simple mistakes that have lightly annoying to terrible consequences that you'll have to live with for eons (well, until the next major version).

# API design skills are useful

I love to see how what I've learned designing and reviewing hundreds if not thousands of API can be used in other disciplines like designing a format for instance. The concerns you have to take care of when designing APIs are not new and not only related to APIs. But API becoming first class citizen has put those concerns, such as consistency or user-experience, to the front. And now that's a concern in everything I do.