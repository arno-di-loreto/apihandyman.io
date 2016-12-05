---
id: 353
title: Hypermedia API maturity model – Part II – The missing links
date: 2015-03-15T22:58:35+00:00
author: Arnaud Lauret
layout: post
guid: http://apihandyman.io/?p=353
permalink: /hypermedia-api-maturity-model-part-ii-the-missing-links/
dsq_thread_id:
  - 4866765237
categories:
  - API design
  - Hypermedia API
---
Hypermedia is not only a conceptual and philosophical subject of interesting and animate debates among the API community, it's also a concrete solution we can use to cover concrete needs.
In this second part of hypermedia API maturity model (HAMM) series I will talk about my own experience to expose two missing (in my humble opinon) notions in common implementations and include these *missing links* in an updated version of the HAMM.
*If you have not read part I you can read it [here](/hypermedia-api-maturity-model-part-i-hypermedia-ness/).*

# Crossing the hypermedia path
Hypermedia in general and the concepts described in this post in particular are not only concepts but also concrete solutions to needs that I had to deal with on a project. 

This project consisted in designing and building an API offering the same functionalities as my company's web site as a prelude of a complete rewriting of this web site. This was also a first step in the (re)building of our API platform which will be used by all our websites and mobile applications.
n.b. This API is, for now, a <del>*ninja*</del> *dark internal* API (cf. [Mark O'Neil API's categorization](http://www.soatothecloud.com/2015/02/this-week-there-has-been-great.html)).

I wanted to offer a good user experience with our API and in particular to limit business logic implementation in consumers.
Based on:

- An analysis of the web application and what runs behind it from functionnal and technical point of view
- My experience making evolve this web application and its mobile counterpart (which offers less functionnalities)

I determined that if I wanted to offer the expected good user experience with this API, I needed some things, among many others, like:

- the possibility of activate/deactivate some functionalities on the fly
- some kind of habilitations system as
  - two users can have different rights on the same /resources/ID
  - one user can have different rights on on two resources of the same type /resources/ID1 and /resources/ID2
  - two resources /resources/ID1 and /resources/ID2 of the same type may not share the same possibilities (actions)
- giving informations about how to chain actions on complex processes 
- handling different processes on different consumers for the same action (mainly based on security matters)
- and most important: being proactive and exhaustive when informing the consumer (and therefore the end user) about the points above.

As I was documenting myself about REST APIs, I (re)discovered the notion of *hypermedia* for REST APIs in [Richardson's Maturity Model](http://martinfowler.com/articles/richardsonMaturityModel.html).

![power-of-hypermedia](/images/hypermedia-api-maturity-model-part-ii-the-missing-links/heman-power-of-hypermedia.png "By the power of Hypermedia The Api will hande this")  
*Me, figuring that hypermedia can handle this (re-enactment)*.

If in the web application, all of these needs are handled (from the user point view) mostly via hypermedia (the user browse from page to page by clicking on links) why wouldn't we do the same with the API?

# The missing links

All those needs can be summarised by:

- Inform at runtime about what you can do
- Inform at runtime about what you can't do and why.
- Inform at runtime about how to do it

The first item, as seen in [part I](/hypermedia-api-maturity-model-part-i-hypermedia-ness/), is well covered by common hypermedia techniques, but I did not found informations for the two others, they are the missing links.

*This concepts have not been implemented in reality exactly as described in this post because as I was writting I had new ideas concerning representations of this informations, but the spirit is still the same.*

## What you can't do and why

All hypermedia systems I've seen so far focus on what you *can* do. On each resource you get a list of things you *can* do. But what happens when you *can't* do something?

There are two common answers to this question:

- If it's impossible to do, it's not in the list (you can try to do it but you'll get an error)
- If it's impossible to do, it's in the list but you'll get an error when you'll try to do it (because it's impossible to do).

For many use case, these answers will fit perfectly.

But sometimes not.

![higway-to-hell](/images/hypermedia-api-maturity-model-part-ii-the-missing-links/whatyoucantdo.png "Highway to Hell")

Sometimes it would be better for user experience to explicitly say that a thing is impossible to do *before* someone actually try to do that thing. 

### Status property

Let's take the dummy API described in part I and work with the *add photo* operation for *location* resource (still using NARWHL).

How it looks like in last post:
[code gutter="false"]
GET https://api.dummy.com/locations/IDL1
[/code]
[code language="js"]
{
  "_links": 
  [
    ... 
    {
      "rel": "https://api.dummy.com/photos/definitions#add",
      "href": "https://api.dummy.com/photos",
      "method": "POST",
      "parameters" :
      {
        "locationId" : "IDL1",
        "url" : "http://example.com/your/photo" 
      }
    }
  ],
  ...
}
[/code]

Now I add a *status* property to indicate if the operation is possible or not and explain why if it's not possible:

- The *status.usable* property indicates if the operation is possible or not.
- The *status.cause* property indicates the origin (*details[].name*) of the impossibility.
- The *status.details* array contains all the elements used to evaluate *status.usable*.

In this case, the *usability* is based on two notions: *availability* and *authorization*.


### The operation in unavailable due to maintenance
[code gutter="false"]
GET https://api.dummy.com/locations/IDL1
[/code]
[code language="js"]
{
  "_links": 
  [
    ... 
    {
      "rel": "https://api.dummy.com/photos/definitions#add",
      "href": "https://api.dummy.com/photos",
      "method": "POST",
      "parameters" :
      {
        "locationId" : "IDL1",
        "url" : "http://example.com/your/photo" 
      },
      "status": 
      { 
          "usable":"false", 
          "cause" : "available" , 
          "details" : 
          [ 
              { 
                  "name": "available",
                  "value" : "false"
                  "reason": "Temporarly down for programmed maintenance"
                  "extraValues": 
                  [ 
                      {"name" : "endDate", "value": "1426432120002"}, 
                      {"name" : "cause", "value": "maintenance"} 
                  ]
              }
              {
                  "name": "authorized",
                  "value": "true"
              }
          ] 
      }
      
    }
  ],
  ...
}
[/code]

### The operation in unauthorized for this resource (location)
[code gutter="false"]
GET https://api.dummy.com/locations/IDL1
[/code]
[code language="js"]
{
  "_links": 
  [
    ... 
    {
      "rel": "https://api.dummy.com/photos/definitions#add",
      "href": "https://api.dummy.com/photos",
      "method": "POST",
      "parameters" :
      {
        "locationId" : "IDL1",
        "url" : "http://example.com/your/photo" 
      },
      "status": 
      { 
          "usable":"false", 
          "cause" : "available" , 
          "details" : 
          [ 
              { 
                  "name": "available",
                  "value" : "true"
              }
              {
                  "name": "authorized",
                  "value": "false",
                  "reason": "Maximum number of photos reached for this location",
                  "extraValues": 
                  [  
                      {"name" : "cause", "value": "locationMaximumNumberOfPhotos"} 
                  ]
              }
          ] 
      }
      
    }
  ],
  ...
}
[/code]

### The operation in unauthorized for the user
[code gutter="false"]
GET https://api.dummy.com/locations/IDL1
[/code]
[code language="js"]
{
  "_links": 
  [
    ... 
    {
      "rel": "https://api.dummy.com/photos/definitions#add",
      "href": "https://api.dummy.com/photos",
      "method": "POST",
      "parameters" :
      {
        "locationId" : "IDL1",
        "url" : "http://example.com/your/photo" 
      },
      "status": 
      { 
          "usable":"false", 
          "cause" : "available" , 
          "details" : 
          [ 
              { 
                  "name": "available",
                  "value" : "true"
              }
              {
                  "name": "authorized",
                  "value": "false",
                  "reason": "Daily maximum upload volume reached for this user",
                  "extraValues": 
                  [  
                      {"name" : "cause", "value": "userDailyMaximumUpload"}  
                  ]
              }
          ] 
      }
      
    }
  ],
  ...
}
[/code]


### Everything is OK
[code gutter="false"]
GET https://api.dummy.com/locations/IDL1
[/code]
[code language="js"]
{
  "_links": 
  [
    ... 
    {
      "rel": "https://api.dummy.com/photos/definitions#add",
      "href": "https://api.dummy.com/photos",
      "method": "POST",
      "parameters" :
      {
        "locationId" : "IDL1",
        "url" : "http://example.com/your/photo" 
      },
      "status": 
      { 
          "usable":"true",  
          "details" : 
          [ 
              { 
                  "name": "available",
                  "value" : "true"
              }
              {
                  "name": "authorized",
                  "value": "true"
              }
          ] 
      }
      
    }
  ],
  ...
}
[/code]


## How you do things
Actual techniques for hypermedia implementation I've seen for now can tell you what actions you can do with a resource and what you need to do it but sometimes you need more information for processes involving more than one action.

![djiloriann-ikea-manual](/images/hypermedia-api-maturity-model-part-ii-the-missing-links/djiloriann.png "Djiloriann Ikea manual")  
*[Djiloriann manual, www.collegehumor.com](http://www.collegehumor.com/post/6500868/sci-fi-ikea-manuals)*

For example, when you use Twitter API, if you want to tweet with one media you have to 

- upload a media using POST media/upload (you'll get an ID in return)
- then tweet using POST update/statuses with this ID in media_ids attribute 

This is cleary explain in the documentation, but what about machine readability? 
For machine readibility an evolution of swagger or blueprint or RAML could handle this but what if this process could change depending on the consumer/user/whatever rule you want?
You need information at runtime about this.

### The process property
The process property describes how actions are chained and what is next step:

- process.type: the name of the process
- process.step: the next step
- process.steps: lists all steps of the process

Let's see what we can do with the *media tweet* case.

### First we get the tweetWithMedia action
This action could placed be in *_links* property of GET https://api.twitter.com/1.1/.
[code language="js"]
{
  "_links": 
  [
    ... 
    {
      "process" : 
      {
          "type": "tweetWithMedia",
          "step": "uploadMedia",
          "steps" : [ "uploadMedia", "updateStatus"]
      },
      "href": "https://twitter.com/1.1/media/upload.json",
      "method": "POST",
      "parameters" :
      {
        ... 
      },
    }
  ],
  ...
}
[/code]

We get a first step: we have to upload a media.

### So we do the POST https://api.twitter.com/1.1/media/upload.json

[code language="js"]
{
  "_links": 
  [
    ... 
    {
      "process" : 
      {
          "type": "tweetWithMedia",
          "step": "updateStatus",
          "steps" : [ "uploadMedia", "updateStatus"]
      },
      "href": "https://api.twitter.com/1.1/statuses/update.json",
      "method": "POST",
      "parameters" :
      {
        "media_ids": "1234567890123456789",
        ... 
      },
    }
  ],
  ...
}
[/code]

In return we get the next step *updateStatus* for process *tweetWithMedia* with property *media_ids* containing the id of the uploaded media.

### So finally, we do POST https://api.twitter.com/1.1/statuses/update.json
This is the last step, process *tweetWithMedia* is over so it's not present anymore in *_links*.

*I'm not really satisfied with that implementation of the *how you do it* item but the spirit is here.*

# Hypermedia API maturity model v1.0.0-alpha-2
It's now time to update HAMM with these two new items and find a way to handle Collection+JSON that would not fit in v1.0.0-alpha-1 version.

With this update, HAMM consists now in 5 characteristics, each one gets a score:

- Where you can go, score 1 (00001)
- What you can do, score 2 (00010)
- What you need to do things, score 4 (00100)
- What you can't do and why, score 8 (01000)
- How you do things, score 16 (10000)

You get the level of hypermedianess by adding the scores of the characteristics you comply with.
You can also *decode* a level to know what are its characteristics.

With systems referenced in previous post we have:

- JSON-LD, HAL, jsonapi.org: level 1 (where you can go)
- Collection+JSON: level 5 (where you can go + what you need to do things)
- Siren, JSON-LD+Hydra and NARWHL: level 11 (where you can go, what you can do, what you need to do things)

# This is the end?
This is it for now about the HAMM version 1.0.0.alpha-2, this is still a work in progress I'll write other posts about this later.
Thank you for reading, I hope it's not over complicated. I'm really looking forward to your comments here or on Twitter about all this. Does anybody encounter the same needs? What do you think about HAMM? Did I miss something in common hypermedia systems?