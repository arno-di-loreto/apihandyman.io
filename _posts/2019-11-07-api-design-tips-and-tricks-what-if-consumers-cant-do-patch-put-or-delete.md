---
title: API Design Tips And Tricks - What if consumers can't do PATCH, PUT or DELETE?
alias: http-method-override
date: 2019-11-07
author: Arnaud Lauret
layout: post
permalink: /api-design-tips-and-tricks-what-if-consumers-cant-do-patch-put-or-delete/
category: post
tags:
  - API Design Tips And Tricks
---

There are quite many APIs out there taking advantage of all standard HTTP methods (`GET`, `POST`, `PATCH`, `PUT` and `DELETE`). Unfortunately, there are still some cases where consumers can't use them all. As far as I know, `GET` and `POST` do not cause any problem at all. But as an API provider, do not take for granted that `DELETE`, `PUT` and the more dreaded `PATCH` HTTP methods can always be used by your consumers. I encountered this problem several times throughout the years and no later than a few weeks ago. Let's see why and how to solve this problem.
<!--more-->

# What could prevent consumers from using PUT, PATCH or DELETE?

I encountered this problem several times, the first one was probably around 2012 and the last one in 2019 a few weeks ago (hence this post). These two experiences, reflect the two possible causes of the inability of consumers to use HTTP methods such as `PATCH`, `PUT` or `DELETE`: network or framework limitations.

## Network limitations

The first time I encountered such problem, it was around 2012. I was building my first "RESTish" API. At that time I was a total beginner regarding REST APIs (and made quite a few mistakes, but that's another story). I had read a some books and blog posts about such APIs and discovered that you had to use the HTTP semantic when designing them. So, here I was, carefully choosing the adequate HTTP method depending on what I wanted to do: `GET` to read something, `POST` to create something, `PUT` to replace/update something and `DELETE` to delete something (yep, I did not used `PATCH` at that time).

This API was supposed to be used by various consumers including a website built by another team in another company belonging to the same group as mine. This consumer had to pass through various internal network zones of the group to access our APIs. Unfortunately, on their side all their reverse proxies and firewalls only allowed the use of `GET` and `POST`. Why? Because for a very long time that was all what websites (or most HTTP based software) needed to operate, so anything else was forbidden (usually for security purpose).

## Framework limitations

The last time, I encountered this problem was a few weeks ago in 2019. I am now a little bit more experienced (I even wrote a book about web API design, but that's another story you can read [here](/few-things-i-learned-writing-the-design-of-web-apis)) and a part of my job is helping people design APIs.

One of the team I'm working with is building an API that is supposed to be used in some famous SAAS CRM solution. As their API deals with some updates, it uses the `PATCH` HTTP method as said in our API design guidelines. Unfortunately, the team in charge of calling this API from the SAAS solution encountered some unexpected problems. The SAAS solution's development framework only knows `GET`, `POST`, `PUT` and `DELETE`, it's impossible to make a call to an external API using `PATCH`.

Some other cases of "framework limitations" I encountered were due to the use of ancient on-premise COTS (Commercial-Off-The-Shelf) facing the same problem as this SAAS solution and also the use of old browsers.

Whatever the reason, that's a real problem: some consumers may simply be unable to use all of the API features. There are two ways to solve the problem: solving the root cause and if that is not possible find a design workaround.

# First solution: solve the root cause

Solving the root cause regarding the network limitations shouldn't be a problem. Indeed, I think that it is probably not a problem anymore, so there's nothing to solve. But just in case and more for historical purpose, here's how to handle it. There are probably two categories of people to talk to: the security people and the network people. Back in 2012, when I was building my first API, I encountered the same problem as my colleagues. Our mobile application couldn't use our brand new API because our reverse proxies also only allowed `GET` and `POST`. To solve this problem, I just had to explain to those people that our mobile application actually needed `PUT` and `DELETE` to work properly and show them how other companies were doing to demystify the "new" HTTP methods. Thanks to that, I learned one important thing: before considering any design modification due to some contextual problems, I always check if the problem cannot be solve.

Unfortunately, my 2012 fellow colleagues, didn't had the same chance. Modifying the reverse proxies configuration was more complicated for them and would have took a longer time than what we had. And more recently, my colleagues also couldn't fix the root cause: the framework's bug or missing feature has been known by the SAAS company for at least 3 years and still hasn't been solve. So I had to find a design workaround.

# Last resort solution: find a design workaround

How to modify an API design which takes advantage of the HTTP method semantics in order to be used by consumers which cannot use all the API's HTTP method? There are two ways to do so: the bad one and the clever one.

The bad way of modifying the API design to solve this problem would be to simply get rid of the HTTP semantic and simply use `POST` for everything (or possibly `GET` to read and `POST` for the rest). Not using HTTP method semantic is not the problem here, the problem is to heavily modify a design for only a handful of consumers. In Star Trek II The Wrath of Khan (1982), Mr Spock says "Logic clearly dictates that the needs of the many outweigh the needs of the few.", and he is totally right (at least when it comes to designing APIs). It means, that to solve this problem, the design must be modified in a sufficiently clever way that allows the handful of HTTP restricted consumers to use the API without bothering the vast majority which can shamelessly use all of HTTP methods.

So, let's do it the clever way. The minimal set of HTTP methods that can be used by any HTTP consumer is composed of `GET` and `POST`. As we need to find a replacement to methods such as `PUT`, `PATCH` or `DELETE` which are not safe (they may change resources), the only possible solution is to use `POST` to simulate them (because `GET` is safe). In order to be able to make the difference between a regular `POST` and a `POST` simulating let's say a `PATCH` request, a parameter indicating the real HTTP method must be provided. This can be done by providing a HTTP header named `X-HTTP-Method`, `X-Method-Override` or `X-HTTP-Method-Override` (I prefer the last one, it seems to be used more than the others) which value is `PATCH`.

A consumer which is not restricted in its use of HTTP methods will do a regular `PATCH` request as follows:

```
PATCH /some-resources/some-id HTTP/1.1

{
  "some": "data"
}
```

A consumer which cannot do a `PATCH` request, will send a `POST` request along with the parameter stating the "true" HTTP method to be used:

```
POST /some-resources/some-id HTTP/1.1
X-HTTP-Method-Override: PATCH

{
  "some": "data"
}
```

And now, what if I tell you that some (really annoying) consumers limited to `GET` and `POST` are also unable to send custom HTTP headers? Better be ready to also allow them to pass the overridden HTTP method as a query parameter such as `_httpMethod` or `_method`.

```
POST /some-resources/some-id?_httpMethod=PATCH HTTP/1.1

{
  "some": "data"
}
```

Such design trick is implemented in many APIs and products offering APIs, but don't be fooled by its simplicity, there are some consequences that you must be aware of.

# Consequences

Using this trick will have consequences on security, API gateway configuration, documentation and logs.

## Security

First above all: security. Let's say that an API provides the following operations:

- `POST /resources` which creates some resource, requires the `create` Oauth scope
- `DELETE /resources` which allows to massively delete some resources, requires the `delete` Oauth scope

If the HTTP method override is implemented without caution (at the actual implementation or on the API gateway securing the API), a consumer which only has the `create` scope could unduly massively delete resources by sending a `POST /resources?_httpMethod=DELETE` request. So do not forget that security controls must be adapted when adding such mechanism: when an overridden call comes, the relevant security control must be made (in this case, check if the consumer has the `delete` scope).

## API Gateway configuration

If an API gateway sits in front of the API's implementation (to deal with high level security), it is usually configured by providing the sets of available operation (as an OpenAPI file if the API gateway provider is smart). If you need to use the HTTP method override trick, you'll have to update your configuration.

Let's says the API provides the following operations:

- `POST /resources`
- `DELETE /resources`
- `PUT /resources/{resourceId}`

In that case, to support HTTP method override, you'll need to declare:

- A modified `POST /resources` with the additional query (`_httpParam` for example) and/or header (`X-HTTP-Method-Override`) parameters to handle overridden `DELETE /resources` requests
- An unmodified `DELETE /resources`
- An unmodified `PUT /resources/{resourceId}`
- A new `POST /resources/{resourceId}` to handle overridden `PUT /resources/{resourceId}` requests

Note that security and gateway configuration could be simplified by implementing directly the trick at the gateway level once and for all. That way, backend API implementation would not have to deal with that (I'll probably make a post about dos and don'ts or API gateways).

## Logs

Such design modification will obviously impacts your API calls logs and dashboards, you'll have to separate true `POST` requests from the overridden `PATCH`, `PUT` and `DELETE` ones or find a way to log them cleverly to avoid doing so. Note that you should not totally hide these overridden request, it is always useful to know if this feature is actually used and how.

## Documentation

And finally do not forget to update your documentation. The better is to fully explain the trick once and for all and add links to this explanation when needed. If your reference documentation relies on the same OpenAPI file used for your gateway, you should get rid of trick-specific parameters and operations (the ones you add for the gateway configuration for example) to keep it readable.

# Conclusion: always analyze consumers contexts

While a bit annoying, such a problem teaches us a good lesson: always analyze consumers contexts in order to propose an accurate design.

_And if you wonder what this post banner means: it's a toy version of the french Peugeot 405 made by french toy company Majorette. The HTTP status code 405 means Method not allowed._