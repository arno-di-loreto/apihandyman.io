---
title: How to check the presence of an element with Spectral
date: 2022-11-23
author: Arnaud Lauret
layout: post
permalink: /how-to-check-the-presence-of-an-element-with-spectral/
category: post
---

When linting an OpenAPI document (or any other JSON or YAML document with Spectral), the hardest part is ensuring you're not missing your target and so be sure that expected checks will be done. In this post, we'll see how to be sure a Spectral rule will be triggered when checking the presence of an element.
<!--more-->

In an OpenAPI document, the description of the API located in the info section is not mandatory. A document without that information is syntactically valid. But from an API documentation perspective, that can be an issue. So let's create a rule that will enforce providing this information.

_If you're unfamiliar with what Spectral is and need guidance to install and run it, check my [Lint APIs with Spectral post](lint-apis-with-spectral)._

# Relying only on "given" will not work

The following `info-description` rule is intended to check there’s a description of the API in an OpenAPI document. The `given` JSON path targets the `description` property in the `info` object, which is located at the document's root (`$`). The rule's `then` section uses the `truthy` function to check that `description` is present and not empty.

{% code language:"yaml" title:"miss-target.spectral.yaml" %}
rules:
  info-description:
    given: $.info.description
    then:
      function: truthy
{% endcode %}

If we run the Spectral CLI on the following OpenAPI document, we expect to detect an `info-description` problem.

{% code language:"yaml" title:"no-description.openapi.yaml" %}
openapi: '3.0.0'

info:
  title: An API without description
  version: '1.0'

paths: {}
{% endcode %}

Unfortunately, no problem has been detected!

{% code language:"bash" title:"Spectral CLI" %}
> spectral lint -r miss-target.spectral.yaml no-description.openapi.yaml
No results with a severity of 'error' found!
{% endcode %}


# When does a rule is triggered?

What happened? The checks (`then`) of a Spectral rule will be executed only if the `given` path returns a value, which is not the case here. There's no description property in the info object of the OpenAPI document, the `$.info.description` JSON path returns nothing.  So, how can we check that `description` is present?

# Using "field" will work

We need to target the present info object to check that description is present. And `then`, we'll apply the `truthy` function of the `field` "description."

{% code language:"yaml" title:"hit-target.spectral.yaml" %}
rules:
  info-description:
    given: $.info
    then:
      field: description
      function: truthy
{% endcode %}

This time, the problem has been detected!

{% code language:"bash" title:"Spectral CLI" %}
> spectral lint -r hit-target.spectral.yaml no-description.openapi.yaml

/some/path/no-description.openapi.yaml
 3:6  warning  info-description  "info.description" property must be truthy  info

✖ 1 problem (0 errors, 1 warning, 0 infos, 0 hints)
{% endcode %}

# But check parents if needed

But is that enough? What if `info` is not present like in the following OpenAPI sample document? Same issue as at the beginning of this post. Our `info-description` rule will not be triggered so that no problem will be detected. I let you write an `info` rule to ensure the `info` object is present.

{% code language:"yaml" title:"no-info.openapi.yaml" %}
openapi: '3.0.0'

paths: {}
{% endcode %}

But, in that specific OpenAPI use case, we don't have to worry about `info` being absent. Indeed, the `info` object is mandatory in an OpenAPI document, so the document above is syntactically invalid. But you may have noticed that Spectral didn't say anything about this when testing your `info` rule. It's because we didn't ask Spectral to do that OpenAPI syntax check. We'll see how to do so in an upcoming post.