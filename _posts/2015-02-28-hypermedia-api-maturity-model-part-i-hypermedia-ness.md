---
id: 279
title: 'Hypermedia API maturity model - Part I - Hypermedia-ness'
date: 2015-02-28T15:34:42+00:00
author: Arnaud Lauret
layout: post
guid: http://apihandyman.io/?p=279
permalink: /hypermedia-api-maturity-model-part-i-hypermedia-ness/
dsq_thread_id:
  - 4866765231
category: Posts
tags:
  - Design
  - Hypermedia
  - Series
series: Hypermedia API maturity model
series_title: Part I - Hypermedia-ness
---
When we talk about hypermedia for an API, we're talking about making it discoverable or browsable. Adding hypermedia to an API *potentially* brings flexibility, loose coupling, better human readability on the fly and even machine readability on the fly. 
But nowadays, the hypermedia area for APIs is still a work in progress and it can be implemented in many ways leading to different levels of *hypermedia-ness*.<!--more-->

# Hypermedia API maturity model v1.0.0-alpha.1
Leonard Richardson [described](http://www.crummy.com/writing/speaking/2008-QCon/act3.html) a phased approach of [REST API](http://www.ics.uci.edu/~fielding/pubs/dissertation/rest_arch_style.htm) known as Richardson Maturity Model (RMM, Martin Fowler wrote a great [post](http://martinfowler.com/articles/richardsonMaturityModel.html) to explain it). This model ends with level 3, *hypermedia controls*, where it deals with hypermedia API.
I tried to build a *hypermedia API maturity model* to evaluate the level of *hypermedia-ness* of an API. This model is based on current techniques and systems commonly described (*and sometime used*) to implement REST/JSON hypermedia APIs.

## Level 0: RTFM
On level 0, an API do not implement hypermedia (such an API is RMM level < 3).
If you want to know how resources are linked and what you can do with them, you'll have to [read the documentation](http://en.wikipedia.org/wiki/RTFM).

Let's take a dummy non-hypermedia API dealing with locations and photos as an example for next levels. This API allows you to:

- Get a specific location details

{% highlight text %}
GET https://api.dummy.com/locations/IDL1
{% endhighlight %}

{% highlight Json %}
{
  "id": "IDL1", 
  "name":"a location"
}
{% endhighlight %}

- Add a photo to a location

{% highlight text %}
POST https://api.dummy.com/photos
{% endhighlight %}
{% highlight Json %}
{
  "locationId": "IDL1",
  "url": "http://im.gur/myphoto"
}
{% endhighlight %}

- Get photos for a location

{% highlight text %}
GET https://api.dummy.com/locations/IDL1/photos
{% endhighlight %}
{% highlight Json %} 
[
 {"id": "IDP1"}, 
 {"id": "IDP2"},
 ..., 
 {"id": "IDPn"}
]
{% endhighlight %}

- Get a specific photo details

{% highlight text %}
GET https://api.dummy.com/photos/IDP1
{% endhighlight %}
{% highlight Json %}  
{
  "id": "IDP1", 
  "locationId": "IDL1",
  "url": "https://media.dummy.com/xlvc265z"
}
{% endhighlight %}

- Delete a specific photo

{% highlight text %}
DELETE https://api.dummy.com/photos/IDP1
{% endhighlight %}

## Level 1: Where you can go
On level 1, you define relations/links between your resources. You can do this by using:

- [JSON-LD](http://json-ld.org/)
- [HAL](http://stateless.co/hal_specification.html)
- [jsonapi.org](http://jsonapi.org/format/)

Let's see what we can do using jsonapi.org on our dummy API:

- Get a specific location details

{% highlight text %}
GET https://api.dummy.com/locations/IDL1
{% endhighlight %}
{% highlight Json %}
{
  "links": { "self": "https://api.dummy.com/locations/IDL1"},
  "linked":[ 
   {
     "type": "photos",
     "links": { "self": "https://api.dummy.com/locations/IDL1/photos"}
   }
  ],
  "id": "IDL1",
  "name": "a location"
}
{% endhighlight %}

- Get photos for a location

{% highlight text %}
GET https://api.dummy.com/locations/IDL1/photos 
{% endhighlight %}
{% highlight Json %}
{
  "links" : 
  {
    "self":"https://api.dummy.com/locations/IDL1/photos",
    "next":"https://api.dummy.com/locations/IDL1/photos?page=2" 
  },
  "data":
  [ 
    {
      "links" : { "self": "https://api.dummy.com/photos/IDP1" },
      "id": "IDP1"
    }, ...
  ]
}
{% endhighlight %}

- Get a specific photo details

{% highlight text %}
GET https://api.dummy.com/photos/IDP1 
{% endhighlight %}
{% highlight Json %}
{
  "links": { "self": "https://api.dummy.com/photos/IDP1"},
  "linked":
  [
    {
      "type": "location",
      "links": { "self": "https://api.dummy.com/locations/IDL1"}
    }
  ],
  "id": "IDP1",
  "locationId": "IDL1",
  "url": "https://media.dummy.com/xlvc265z"
}
{% endhighlight %}

As you can see we have added links (*URL related to primary data*)  and linked (*linked resources*) values to existing data. These new data:

- Make the API browsing easier.
- Allow to see the relations between locations and photos.
- Bring a *potential* flexibility as you can modify the provided links without impacting the consumers hoping those consumers *use* the provided links... 

But there's no clue concerning adding or deleting a photo. You'll still have to read documentation to find informations about these operations.

## Level 2: What you can do
On level 2, you add HTTP methods and description to the links to explicitly tell what you can do. You can do this using:

- [NARWHL](http://www.narwhl.com/)
- [JSON-LD+Hydra](http://www.hydra-cg.com/)
- [Siren](https://github.com/kevinswiber/siren)

Let's see how it looks with NARWHL:

- Get a specific location details

{% highlight text %}
GET https://api.dummy.com/locations/IDL1
{% endhighlight %}
{% highlight Json %}
{
  "_links":
  [
    {   
      "rel": "self",
      "href": "https://api.dummy.com/locations/IDL1",
      "method": "GET"
    },
    {
      "rel": "https://api.dummy.com/photos/definitions",
      "href": "https://api.dummy.com/locations/IDL1/photos",
      "method": "GET"
    }, 
    {
       "rel": "https://api.dummy.com/photos/definitions#add",
       "href": "https://api.dummy.com/photos",
       "method": "POST"
    }
  ],
  "id": "IDL1",
  "name": "a location"
}
{% endhighlight %}

- Get photos for a location

{% highlight text %}
GET https://api.dummy.com/locations/IDL1/photos 
{% endhighlight %}
{% highlight Json %}
{
  "_links":
  [
    {    
      "rel":"self",
      "href":"https://api.dummy.com/locations/IDL1/photos",
      "method": "GET"
    },
    {
      "rel": "next",
      "href":"https://api.dummy.com/locations/IDL1/photos?page=2",
      "method": "GET"
    }, 
    {
      "rel": "https://api.dummy.com/photos/definitions#add",
      "href": "https://api.dummy.com/photos",
      "method": "POST"
    }
  ],
  "data": 
  [
    {
      "_links":
      [
        {
          "rel" : "self",
          "href" : "https://api.dummy.com/photos/IDP1",
          "method" : "GET"
        }   
      ],
      "id": "IDP1"
    }, ...
  ]
}
{% endhighlight %}

- Get a specific photo details

{% highlight text %}
GET https://api.dummy.com/photos/IDP1 
{% endhighlight %}
{% highlight Json %}
{ 
  "_links":
  [
    {
      "rel": "self",
      "href": "https://api.dummy.com/photos/IDP1",
      "method" : "GET"
    },
    {
      "rel": "https://api.dummy.com/locations/definition",
      "href": "https://api.dummy.com/locations/IDL1",
      "method": "GET"
    },
    {
      "rel" : "https://api.dummy.com/photos/definitions#delete",
      "href" : "https://api.dummy.com/photos/IDP1",
      "method" : "DELETE"
    }
  ],
  "id": "IDP1",
  "locationId": "IDL1",
  "url": "https://media.dummy.com/xlvc265z"
}
{% endhighlight %}

With NARWHL, all links are defined within *_links* values and for each of them you explicitly define the HTTP method to use with the *method* value.
I have to admit that I prefer the more explicits concepts of *class* or *type* brought by Siren or Hydra to describe the action/operation you can do instead of the [rel value based on IANA relation types](http://www.narwhl.com/hypermedia-linking/) (I probably miss something about this).

However you represent these informations (action description, href, method):

- You explicitly know on this level all you can do on the fly. You can fully browse this API as the add and delete photos operations are now explicitely handled.
- The *potential* flexibility for the consumers concerns now every possible action within the API (hoping again the consumers really use the provided links...).

But you still need documentation for the add photo operation as there's no information concerning the expected inputs.

## Level 3: What you need to do it
On level 3, you add a full description (and maybe some values) of the needed inputs for an action. You can generally do this by using the same systems as on level 2:

- [NARWHL](http://www.narwhl.com/)
- [JSON-LD+Hydra](http://www.hydra-cg.com/)
- [Siren](https://github.com/kevinswiber/siren)
- [Collection+JSON](http://www.amundsen.com/media-types/collection/) 

Let's see how NARWHL handle this on the "add photo" operation:
{% highlight text %}
GET https://api.dummy.com/locations/IDL1
{% endhighlight %}
{% highlight Json %}
{
  "_links": 
  [
    {   
      "rel":"self",
      "href":"https://api.dummy.com/locations/IDL1",
      "method": "GET"
    },
    {
      "rel": "https://api.dummy.com/photos/definitions",
      "href": "https://api.dummy.com/locations/IDL1/photos",
      "method": "GET"
    }, 
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
  "id": "IDL1",
  "name": "a location"
}
{% endhighlight %}

With NARWHL, by adding *parameters* value you give a description (and some default values) of the needed inputs for the operations.
Collection+JSON, Siren and Hydra use a more precise way of describing these inputs. You can see more examples using HAL, JSON-LD, Hydra, Collection+JSON and Siren in Kevin Sookocheff's [post](http://sookocheff.com/posts/2014-03-11-on-choosing-a-hypermedia-format/) comparing some hypermedia systems. As Kevin's post do not talk about NARWHL and jsonapi.org I have focused this post's examples on these ones.

Whatever, with this last level we have action/operation descriptions, href, method and input description: we known exactly what we can do and how to do it on the fly.

## Hypermedia API maturity model v1.0.0-alpha.1 in 4 lines

- Level 0: RTFM.
- Level 1: Where you can go.
- Level 2: What you can do.
- Level 3: What you need to do it.

# Frequently asked questions
When you start defining or classifying things, some people tends to overreact, arguing over which level is better than the other, what is the perfect way of doing things, counting how many API evangelists can stand on the header of a GET request and then they start wearing funny costumes and act in utterly surreal stupid way to boldly defend a so-called *truth*...

{% img file:apiinquisition.png %}

> My friends/colleagues/parents are yelling at each other about "is hypermedia evil or not?". 
> Should I call the API inquisition to settle this conflict?

No, tell them to read [this API Evangelist's post](http://apievangelist.com/2014/08/05/the-hypermedia-api-debate-sorry-reasonable-just-does-not-sell/) instead.
If they are still yelling at each other after that, you can call the API inquisition.

> My API is level 0.
> Will the API inquisition come and put me on trial?

No, implementing hypermedia in your API is definitely not an obligation.
Hypermedia should be implemented only if a real need is covered by it.
And don't be scared, hypermedia can be added later to your existing API when needed.

> My API is only level 1 or 2.
> Will the API inquisition come put me on trial?

No, implementing hypermedia in your API must cover a real need.
If you're satisfied with level 1 or 2 it's OK, and you can evolve to a higher level later.

> My API is level 3.
> Will I be praised to the skies?

If you have implemented it to cover a real need, maybe.
If it's just a show off and you don't know what to do with it, the API inquisition will come and put you on trial. 

> It seems that Collection+JSON do not fit completely in this model.
> Did I miss something?

That's right Collection+JSON does not fit exactly in my model's progression system because the templating mechanism puts it on level 3 but it does not explicitly define what HTTP method you can use (so it's not level 2).
I think I will settle this problem on my next post by transforming the progression system into a multiclass system (like in [Dungeons & Dragons](http://www.dnd-wiki.org/wiki/Multiclass)) hoping the API inquisition will not come and put me on trial for that. 

# To be continued...
Now I'm able to evaluate the level of hypermedia-ness of an API based on common systems/techniques but this is only the tip of the hypermedia iceberg. The main point of hypermedia is finally not how you will implement it and what level of hypermedia-ness you achieve, but for what *purpose* you will implement it.
In next post *Hypermedia API maturity model - Part II - The missing links*, I'll explain why I have crossed the path hypermedia API, what is missing in actual systems/techniques to fulfil all my needs and propose a revised version of this hypermedia API maturity model based on all this (mess).

*Images credits*:
- [Southbound lane on Jianguo Rd Exit of Kaohsuing IC on the Taiwan No2 National Highway](http://upload.wikimedia.org/wikipedia/commons/f/f6/Southbound_lane_on_Jianguo_Rd_Exit_of_Kaohsuing_IC_on_the_Taiwan_No2_National_Highway.JPG), [Howard61313](http://commons.wikimedia.org/wiki/User:Howard61313).
- [The spanish inquisition, The Monty Python](http://en.wikipedia.org/wiki/The_Spanish_Inquisition_%28Monty_Python%29)