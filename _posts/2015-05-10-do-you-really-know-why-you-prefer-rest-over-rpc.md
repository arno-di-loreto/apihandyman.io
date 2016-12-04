---
id: 516
title: Do you really know why you prefer REST over RPC?
date: 2015-05-10T15:42:20+00:00
author: Arnaud Lauret
layout: post
guid: http://apihandyman.io/?p=516
permalink: /do-you-really-know-why-you-prefer-rest-over-rpc/
dsq_thread_id:
  - 4866783411
categories:
  - API design
---
A few weeks ago I've seen an interesting flock of tweets initiated by this question:

<center><blockquote class="twitter-tweet" lang="en"><p lang="en" dir="ltr">Is my hatred of having http endpoints with the same path but different behaviors based on the verb totally irrational? Because I HATE it</p>&mdash; Camille Fournier (@skamille) <a href="https://twitter.com/skamille/status/588713316358475776">April 16, 2015</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script></center>

This question and the tweets that followed put my brain on quite an animated discussion...

<center>![voices-inside-my-head](/wp-content/uploads/2015/05/voices_inside_my_head.jpg
 "Voices inside my head")
</center>

After this internal discussion, I realized that this question (and all the tweet debate that follows it) could help me highlight a dark corner of my librainry: why should I considered REST's request style (resource oriented) better than RPC's (operation oriented)? Is RPC's request style so evil? Is REST's the panacea?  

# What RPC's and REST's requests styles look like
Before comparing the two request styles let's see what they look like.

## The HTTP request
Both RPC and REST use [HTTP protocol](http://en.wikipedia.org/wiki/Hypertext_Transfer_Protocol) which is a request/response protocol.

A basic HTTP request consists of:

- A verb (or method)
- A resource (or endpoint)

Each HTTP verb:

- Has a meaning
- Is idempotent or not: *A request method is considered "idempotent" if the intended effect on the server of multiple identical requests with that method is the same as the effect for a single such request* (see [RFC7231: Idempotent methods](http://tools.ietf.org/html/rfc7231#section-4.2.2)).
- Is safe or not: *Request methods are considered "safe" if their defined semantics are essentially read-only* (see [RFC7231: Safe methods](http://tools.ietf.org/html/rfc7231#section-4.2.1)).
- Is cacheable or not

Verb      | Meaning                                                 | &nbsp;Idempotent&nbsp;| &nbsp;Safe&nbsp; | &nbsp;Cacheable&nbsp;
---       | ---                                                     | ---        | ---  | ---
GET       | Reads a resource                                        | Yes        | Yes  | Yes
POST      | Creates a resource or triggers a data-handling process  | No         | No   | Only cacheable if response contains explicit freshness information
PUT       | Fully updates (replaces) an existing resource or create a resource | Yes        | No   | No
PATCH     | Partially updates a resources                           | No         | No   | Only cacheable if response contains explicit freshness information
DELETE    | Deletes a resource                                      | Yes        | No   | No

*The table above shows only the HTTP verbs used commonly by RPC and REST APIs.*

## RPC: The operation request style

The [RPC](http://www.acronymfinder.com/RPC.html) acronym has many meanings and [Remote Procedure Call](http://en.wikipedia.org/wiki/Remote_procedure_call) has many forms.  
In this post, when I talk about RPC I talk about *WYGOPIAO: What You GET Or POST Is An Operation*.

With this type of RPC, you expose *operations* to manipulate data through HTTP as a *transport protocol*.
  
As far as I know, there are no particular rules for this style but generally:

- The endpoint contains the name of the operation you want to invoke.
- This type of API generally only uses GET and POST HTTP verbs.

[code gutter="false"]
GET /someoperation?data=anId

POST /anotheroperation
{
  "data":"anId"; 
  "anotherdata":"another value"
}
[/code]


How do people choose between GET and POST? 

  - For those who care a little about HTTP protocol this type of API tends to use GET for operations that don't modify anything and POST for other cases. 
  - For those who don't care much about HTTP protocol, this type of API tends to use GET for operations that don't need too much parameters and POST for other cases.
  - Those who really don't care or who don't even think about it choose between GET and POST on a random basis or always use POST.

## REST: The resource request style

*I will not explain in detail what REST is, you can read Roy Fielding's [dissertation](https://www.ics.uci.edu/~fielding/pubs/dissertation/top.htm) and [The REST cookbook](http://restcookbook.com/) for more details.*  

To make it short and focus on the matter of this post, with a REST API you expose data as resources that you manipulate through HTTP protocol *using the right HTTP verb* :

- The endpoint contains the resource you manipulate.
- Many use the CRUD analogy to explain REST requests principles. The HTTP verb indicates what you want to do (Create/Read/Update/Delete) with that resource as defined earlier in this post and by [RFC7231 (Hypertext Transfer Protocol (HTTP/1.1): Semantics and Content)](http://tools.ietf.org/html/rfc7231#section-4.3) and [RFC5789 (PATCH Method for HTTP)](http://tools.ietf.org/html/rfc5789).

[code gutter="false"]
GET /someresources/anId

PUT /someresources/anId
{"anotherdata":"another value"}
[/code]

## Examples
Here are some of my [CarBoN API](/the-api-crash-test-project/) requests presented in RPC and REST ways:

Operation                      | RPC (operation)                           | REST (resource)
---                            | ---                                       | ---
Signup                         | POST /signup                              | POST /persons
Resign                         | POST /resign                              | DELETE /persons/1234
Read a person                  | GET /readPerson?personid=1234             | GET /persons/1234
Read a person's items list     | GET /readUsersItemsList?userid=1234       | GET /persons/1234/items
Add an item to a person's list | POST /addItemToUsersItemsList             | POST /persons/1234/items
Update an item                 | POST /modifyItem                          | PUT /items/456
Delete an item                 | POST /removeItem?itemId=456                | DELETE /items/456

# Comparing RPC's and REST's requests styles
I've selected some items to compare RPC's and REST's requests styles:

- Beauty
- Designability
- API definition language
- Predictability and semantic
- Hypermediability
- Cacheability
- Usability

## Beauty

Even if this item is irrelevant, as beauty is in the eye of the beholder, both styles can produce beautiful API as they can produce ugly ones.

Operation                      | RPC                           | REST
---                            | ---                           | ---
Read a person *pretty version* | GET /readPerson?personid=1234 | GET /persons/1234
Read a person *ugly version*   | GET /rdXbzv01?i=1234          | GET /xbzv01/1234

**So that's a draw for this one.**

## Designability
Is it easier to design RPC ou REST endpoints?

Designing a RPC API may seem easier:

- when you have to deal with an existing system as it is generally operation oriented but you'll have to simplify and clean this vision to expose it.  
- when you deal mainly with processes and operations (as transform them into REST resources is not always trivial).

The design of an RPC API needs the designers to be strict to achieve a consistant API as you do not really have constraints.

Designing a REST API may seem easier when you deal mainly with data.

But even if in some certain case , designing a REST API seems a little harder than an RPC one, it gives you a *frame* that let you achieve more easily a consistent API. 

And in both case you'll have to deal with naming consistency.

Both style have pros and cons depending on the context but I don't find that one style is more easier to design than the other. As *I* don't really see a winner, **that's another draw.**

## API definition languages
You can perfectly describe both styles with API definition languages like Swagger, RAML or blueprint.

**So that's a draw, again.**

## Predictability and semantic

With RPC the semantic relies (mostly) on the endpoint and there are no global shared understanding of its meaning.
For example, to delete an *item* you could have:

- GET (or POST) /deleteItem?itemId=456
- GET (or POST) /removeIt?itemId=456
- GET (or POST) /trash?itemId=456

To resign from the service you could have:

- POST (or GET) /resign
- POST (or GET) /goodbye
- POST (or GET) /seeya

With RPC you rely on your human interpretation of the endpoint's meaning to understand what it does *but* you can therefore have a fine human readable description of what is happening when you call this endpoint. 

With REST the semantic relies (mostly) on the HTTP verb. The verb's semantic is globally shared. The only way to delete an *item* is:

- DELETE /items/456

If a user want to stop using your service, you'll do this (not so obvious) call:

- DELETE /users/1234

REST is more predictable than RPC as it relies on the shared semantic of HTTP verbs. You don't know what happen exactly but you have a general idea of what you do. 

**REST wins (but shortly).**

## Hypermediability
In both style you end making HTTP request, so there is no problem do design an hypermedia API with any of these styles.

**This is a draw.**

## Cacheability
I've often seen (http) caching used as a killer reason to choose REST over RPC.  
But after reading HTTP RFCs, I do not agree with this argument (maybe I missed something).
Of course if your RPC API only use POST for all requests, caching may be a little tricky to handle (but not impossible).
If you use GET and POST wisely, your RPC API will be able to obtain the same level of cacheability as a REST API.

**This is a draw.**

## Usability
From a developer point of view both styles are using HTTP protocol so there's basically no difference between RPC and REST request.
No difference on the documentation (machine of human readable) level too.

**This is a draw.**

## Totalling points

Item                        | Who wins?
---                         | ---
Beauty                      | Draw
Designability               | Draw
API definition language     | Draw
Predictability and semantic | REST
Hypermediability            | Draw
Cachability                 | Draw
Usability                   | Draw

# Do REST really wins?
REST *wins* thanks to the *predictability and semantic* item.  
So, is the resource approach better than the operation one?

No.

RPC and REST are only different approaches with pros and cons and both are valueable *depending on the context*. You can even mix these two approaches in a single API.

The *context*, that's the key. There are no panacea solution, don't follow fashion blindly, you always have to think within a context and must be *pragmatic* when *choosing* a solution.  

At least, I know now why I *like* the resource approach: its predictability and the frame given by the full use of HTTP protocol. What about you?

One last word to leave you with food for thought: in this time of advent of functionnal programming, having operation request style could make sense...