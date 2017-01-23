---
title: ...And GraphQL for all? A few things to think about before blindly dumping REST for GraphQL
alternate_title: ...And GraphQL for all?
subtitle: A few things to think about before blindly dumping REST for GraphQL
date: 2017-01-22
author: Arnaud Lauret
layout: post
permalink: /and-graphql-for-all-a-few-things-to-think-about-before-blindly-dumping-rest-for-graphql/
category: posts
full: false
comments: true
---
GraphQL is new. GraphQL is cool. Look! Github dumped REST for it! We MUST do it too!  
Well, why not. GraphQL could be a great tool, but like any tool, you don't choose it *just because*. You choose it because it solves a problem in a given context. You choose it knowing its strengths and weaknesses.  
  
While discovering what is GraphQL we will see what REST API providers should think about before blindly dumping REST for it. From design and implementation to pricing model and analytics down to developers experience and implementations, choosing an API design style will have impact on the whole API lifecycle. Therefore, this choice must be an enligthned one and not based on simple beliefs.<!--more-->

# Informed choice
Before talking about GraphQL, I would like to ask you two really important questions.

The first one is:  
{% img file:metallica-vs-iron-maiden.png label:"Metallica or Iron Maiden. Who is the best heavy metal band?" %}

Iron Maiden of course. You may disagre, that is your absolute right. Metallica could also the best metal band... For you. The answer to this question is only a matter of personnal feelings.
    
The second question is:
{% img file:hammer-vs-screndriver.png label:"Hammer or screwdriver. Which is the best tool?" %}
  
It's a pretty dumb question isn't it? The only possible answer to this question is *it depends*.  
It depends on the tools capabilities and the context (what you want to do, what is your environnement, your budget, your objective).  
  
Without context, my hammer cannot be better than your screwdriver.  
  
Acting as a fanboy may be acceptable when it comes to choose your favorite heavy metal band. But it's definitely not a good idea when it comes to choose a tool, a product or an API style... From design and implementation to pricing model and analytics down to developers experience and backend implementations, choosing an API design style will have impact on the whole API lifecycle.  
  
So before blindly yelling *...and GraphQL for all!* just because Facebook created it and Github decided to use it, remember that GraphQL, just like REST, is only a tool. A tool that you choose with a purpose within a certain context.

Let's dig into GraphQL and see what we should think about from a REST API provider prespective when evaluating it as a possible solution for our API projects.

# What is GraphQL? 
GraphQL is a query language for data created in 2012 by Facebook when switching to native mobile applications.

> We were frustrated with the differences between the data we wanted to use in our apps and the server queries they required.  
> GraphQL was our opportunity to rethink mobile app data-fetching from the perspective of product designers and developers. It moved the focus of development to the client apps, where designers and developers spend their time and attention.  
> *[GraphQL, a data query language. Post by Lee Byron](https://code.facebook.com/posts/1691455094417024/graphql-a-data-query-language/)*

Facebook [open sourced it in 2015](https://code.facebook.com/posts/1691455094417024/graphql-a-data-query-language/) and companies like [Pinterest, Coursera or Github](http://graphql.org/users/) started to use it.

Let's take a look at [Github GraphQL API](https://developer.github.com/early-access/graphql/) to discover GraphQL.

## What you want is what you get
GraphQL motto is 

> What you want is what you get

### Querying data
The Github GraphQL API propose a *viewer* query, returning the connected User data. This query is the equivalent of `GET /user` in the Github REST API. The difference with the REST query is that I can select the properties I want to retrieve.

With this query, I retrieve only the viewer's name and avatarURL. 

```text
{
  viewer {
    name
    avatarURL
  }
}
```
To get server's response I have to POST this query in a JSON object to the GraphQL endpoint:

```
POST https://api.github.com/graphql
{
 "query": "{ me: viewer { name avatarURL} }"
}
````

The result is in JSON format and the requested data are located in the data property. These data mirror perfectly my query.

```json
{
  "data": {
    "viewer": {
      "name": "Arnaud Lauret",
      "avatarURL": "https://avatars0.githubusercontent.com/u/10104551?v=3"
    }
  }
}
```

### Customizing responses
You can create more custom data structures by using aliases.  
Here, `viewer` becomes `me`, `name` becomes `fullname` and `avatarURL` becomes `picture`.

```text
{
  me: viewer {
    fullname: name
    picture: avatarURL
  }
}
````

The result is exactly what I requested:

```json
{
  "data": {
    "me": {
      "fullname": "Arnaud Lauret",
      "picture": "https://avatars0.githubusercontent.com/u/10104551?v=3"
    }
  }
}
```

### Querying sub-resources
Now let's say I want to retrieve some viewer's data and the names of his last two created repositories.

To do that with the Github REST API, I need two calls:

- `GET /user` to get the viewer information
- `GET /user/repos?sort=created&direction=desc` to get the repositories list. Unfortunately the API do not propose a length parameter for the list

The responses will contains all available data, the REST API do not propose to filter returned properties.  
  
With GraphQL, I can do that with a single query: 

```text
{
  me: viewer {
    fullname: name
    picture: avatarURL
    repositories(first: 2, orderBy: {field: CREATED_AT, direction: DESC}) {
      edges {
        node {
          name
        }
      }
    }
  }
}
```

I just have to add the repositories property in my viewer query with the good parameters and indicate the properties I want to get back for each repository. The response contains exactly what I requested.  

```json
{
  "data": {
    "me": {
      "fullname": "Arnaud Lauret",
      "picture": "https://avatars0.githubusercontent.com/u/10104551?v=3",
      "repositories": {
        "edges": [
          {
            "node": {
              "name": "apistylebook-api"
            }
          },
          {
            "node": {
              "name": "restfest-videos-data-postprocessor"
            }
          }
        ]
      }
    }
  }
}
```

### Aggregating queries
Not only can I seamlessly retrieve a resource and its sub resources, I can also make multiple different queries in one API call.  
  
Here I retrieve information about:

- me (the viewer)
- two other users (Kin Lane and Mike Amundsen)
- and a search on repositories

in a single request to the GraphQL server:

```text
{
  me:   viewer                 { name avatarURL }
  kin:  user(login: "kinlane") { name avatarURL }
  mike: user(login: "mamund")  { name avatarURL }
  graphqlRepos: search(first: 2, query: "graphql", type: REPOSITORY) {
  	edges { node { ... on Repository {
      name
      description
    }}}  
  }
}
```

The response contains all requested data:

```json
{
  "data": {
    "me": {
      "name": "Arnaud Lauret",
      "avatarURL": "https://avatars0.githubusercontent.com/u/10104551?v=3"
    },
    "kin": {
      "name": "Kin Lane",
      "avatarURL": "https://avatars1.githubusercontent.com/u/56100?v=3"
    },
    "mike": {
      "name": "Mike Amundsen",
      "avatarURL": "https://avatars2.githubusercontent.com/u/38344?v=3"
    },
    "graphqlRepos": {
      "edges": [
        {
          "node": {
            "name": "graphql",
            "description": "GraphQL is a query language and execution engine tied to any backend service."
          }
        },
        {
          "node": {
            "name": "graphql",
            "description": "An implementation of GraphQL for Go / Golang"
          }
        }
      ]
    }
  }
}
```

### GraphQL is not SQL nor an ETL
GraphQL is really powerful but be warned that it's not SQL nor an ETL, you can select the data you want, agregate queries, change names but not join queries or change the data structure.

You cannot join queries like you would join tables in SQL.

```SQL
SELECT * FROM A, B WHERE A.COL = B.COL
```

You cannot select sub-properties or flatten objects. If I want to retrieve the name of my first repository without the edges and repo level, I cannot change this hierarchy:

```json
{
  "data": {
    "me": {
      "myFirstTwoRepos": {
        "edges": [
          {
            "repo": {
              "name": "apistylebook-api"
            }
          }
        ]
      }
    }
  }
}
```

into this one:

```json
{
  "data": {
    "me": {
      "myFirstTwoRepos":
        [
          {"name": "apistylebook-api"}
        ]
      }
    }
  }
}
```

## Schema, introspection, documentation
All the available data are described within a schema.
This schema let you describe your data model like you would do with OpenAPI/Swagger, Blueprint or RAML specification.
The schema can be queried on runtime like all of the data.

This query let me know what are the properties of the `User` resource which is returned by the viewer and user query

```text
{
  __type(name:"User") {
    fields {
      name
      description
    }
  }
}
```

It can also be used to generate documentation.
screen capture doc

## Ecosystem
GraphQL do not comes alone, it's a part of an ecosystem including:

- Consumer libraries like [Relay](https://facebook.github.io/relay/)
- API explorer [GraphiQL](https://github.com/graphql/graphiql)
- And server libraries in [many different languages like Node, Ruby, Python, Java, Scala or Clojure](http://graphql.org/code/)

## GraphQL in few words

So basically with GraphQL you can

- Retrieve only the data you need on consumer side
- Reduce the data volume returned by the server because you retrieve only what you need  
- Reduce the number of calls to retrieve data by seamlessly retrieving linked resources and agregating queries
- Discover the schema you are querying

And GraphQL comes with a full ecosystem which ease both API provider and consumer job.
  
I have played with the [official node js library](https://www.npmjs.com/package/graphql) to create a GraphQL server and I was really impressed by how it was easy to achieve a proof of concept. You define your schema. You define resolver function for your resources, and bang! it's done.
  
If you want to discover GraphQL you should try the [tutorial available at learngraphql.com](https://learngraphql.com/) and play with the [Github GraphQL API](https://developer.github.com/early-access/graphql/)

# What GraphQL could mean when you're acustomed to REST
This is very cool. My geek side is really excited about GraphQL. But Let's keep a cool head and try to think about what GraphQL could mean for people acustomed to REST APIs? Let's see what are some impacts on the consumer and provider sides.

# GraphQL brings a different developer experience
When people speak of GraphQL and developer experience, the main focus is on *what you want is what you get* which is really a killer feature that can greatly enhance DX in a certain context. But as GraphQL offers a radically different DX than a REST API, some aspects should be investigated to evaluate if these changes can be real issues.

## Being protocol agnostic has consequences on predictability and consistency
GraphQL is protocol agnostic, it means that you can use it with any protocol as long as you can send and retrieve a string. This can be useful but people acustomed to using the HTTP protocol with REST API should then be aware that, when used over HTTP, GraphQL do not use any of its features and it has consequences on DX.

### Reading and writing resources
With a REST API, if I retrieve a user's data with `GET /users/{id}`, I can try to update it with `PATCH /users/{id}` and delete it with `DELETE /users/{id}` without even reading the documentation and it will probably work... like it will work with another another resource in the same API and even with another resource in another REST API.
And icing on the cake: both humans and machines can discover and understand the meaning of each operation.
Using the HTTP protocol enforce a certain consistency and allow predictability.

In a GraphQL API, reading and writing actions are separated in 2 sets of queries.

- query for reading
- mutation for writing

Machines will only be able to understand that a query do not modify underlying system and a mutation does, all other semantic will be based on naming conventions.

If I get a user with the query user:

```text
query {
  user(id: "{id}") {
    name
  }
}
```

Updating or deleting this user with GraphQL will not be as clear as with REST.
How will be named the mutation allowing me to delete a user? `deleteUser`, `removeUser` or `suppressPeople`?
You'll have to dig in the documentation to find out. You cannot guess it because different API providers will have different naming conventions and these naming convention may event not be consistent within an API. 

```text
mutation {
  deleteUser(id: "{id}")
  removeUser(id: "{id}")
  suppressPeople(id: "{id}")
}
````

### Handling errors
Being protocol agnostic also means that everything is going to be `200 OK` when using GraphQL over HTTP, wheither the query was OK or not. With REST APIs we are acustomed to be able to tell what happens just by looking at the HTTP status. Whatever the API, if we receive a `404` HTTP status we known what it means: *resource not found*.

If I try to retrieve a user that do not exists with a GraphQL API:

```text
{
  user(login: "dummy-user-123") {name}
}
```

I get this GraphQL standard error with a text message telling me the user do no exists.:

```json
{
  "data": {
    "user": null
  },
  "errors": [
    {
      "message": "Could not resolve to a User with the login of 'dummy-user-123'.",
      "locations": [
        {
          "line": 2,
          "column": 3
        }
      ],
      "path": [
        "user"
      ]
    }
  ]
}
```

If I forget the login parameter:

```text
{
  user { name }
}
```

I get exactly the same error format:

```json
{
  "data": null,
  "errors": [
    {
      "message": "Field 'user' is missing required arguments: login",
      "locations": [
        {
          "line": 2,
          "column": 3
        }
      ]
    }
  ]
}
```

The message shows me explicitely what the problem is, but I cannot determine the error type programmatically in a generic way. These errors are not really fit to be analyzed automatically by machines. Of course there's obviously a pattern in the message but will this message have the same pattern for another resource or use case? Will this pattern be consistent as the API evolve? And will I find exactly the same pattern in another GraphQL API?

## GraphQL focuses on data and not actions
A well design REST API implementing hypermedia is able to tell you what are the resources connected to the resource you just get but it can also provide the possible affordances to tell you what you can do. With an hypermedia API you'll be able to describe a complex process step by step providing information about the next requests you can do. But be aware that if HTTP protocol ensure a certain consistency across APIs concering resources manipulation, the hypermedia aspect of REST APIs is not standardized even if some format like Siren, Hydra or HAL exist. 

A GraphQL API focus on data, you read data, you write data. But these aspects are totally disconnected and, for now, describing affordance is not a GraphQL feature. You can of course rely on documentation to describe these processes but therefore machines will not be able to handle that automatically. Looking at how it's implemented in REST API, I'm sure that sooner or later we will have such features in GraphQL.

## Cache
Caching data is always a tricky thing. With a REST API, a consumer could rely on HTTP caching system and could rely on HTTP caching data provide in response's header to build it's own cache.
With GraphQL there's no such mecanism, for now, you'll have to rely totally on the client to handle cache. Hopefully client library like Facebook's Relay propose a complex cache system but as GraphQL do not provide information about how long the data are valid, it will be up to the consumer to choose when to refresh the cache.
I'm sure that as GraphQL evolve, we will have better cache mecanism in the future.

## Does GraphQL offer a good or bad DX?
So with GraphQL you gain great flexibility when querying data but you lose a certain predictability and consistency inside an API and across APIs. You may also not clearly see what you can do with these data and GraphQL gives more responsability on the client side to cache these data.
Is this a problem?. Like always, the answer to this question will depend on the context. You just have to think about these elements (and probably others) regarding your context to determine if it's a problem or an advantage.

# GraphQL does not ease API provider job and brings new challenges
Let's see now what GraphQL means on the provider side.

First, let me be clear: 

> If you suck at providing REST API, you WILL suck at providing GraphQL API.  
> *Arnaud Lauret, API Handyman*

GraphQL may bring new challenges and questions on the provider side but it mainly highlights matters that you should master whatever the type of API you provide.

## GraphQL will not solve your API design problems

> What the hell is this `amsus2` field?
> Anonym consumer

After a in-depth analysis of a use case or a problem, you may come to the *logical and enligtened* conclusion that GraphQL is the most appropriate solution instead of REST *regarding the context*. Be warned that GraphQL is not a magic thing that you just put on top of a good old database or existing system and it's over.  
  
Don't dare to think: *We have data, let people decide how to query them and what to make of them!*. Don't forget that a GraphQL API is STILL an API. It's supposed to be a consumer friendly abstraction of a usually complex underlying system.  
  
Remember all the terrible things you've done while designing crappy REST APIs. API without really defined purpose, dumb database mapping, dumb legacy service mapping, dumb internal organization and processes exposition ... 
A GraphQL API, just like a REST one, must be created with a purpose and designed from an outside in perpective and not an inside out one.  
  
If you don't do that, be ready for a total failure.

We have seen while talking about Developer Experience that queries and mutations are disconnected and that consumer can only rely on mutation's name and documentation to know what they're up to. You will have to increase control on design because naming thing consistently is hard and you'll definitely need consistency to help consumers understand how your query and mutations are connected and what mutations actually do. If you know some people who were involved in SOA governance in the SOAP protocol era you may call them because they have faced such things. 

## GraphQL will not solve your API documentation problems
A GraphQL API comes with an integrated documentation system describing the schema that can be queried.
You can discover the available queries and the data returned.

> A5 Amsus2 B B5 B7 B7/D# C C5 C#5 Cadd9 D D5 D#5 E5 Em F#m G  
> *Master of Puppets Guitar Chords*

This is the list of guitar chords you need to play Master Of Puppets. Having only this list, and without being a guitar hero, will you be able to play the song? Well maybe ... after a very long struggle.

An interface contract description, an inventory of queries and objects, was, is and will *NEVER* be the API documentation, it's only a part of it. It's just like providing guitar chords without explaing how to chain them to play a song. How to connect? How is handled rate limiting? How is handle security? How to respond to this use case? Code snippets, SDK, tutorials ...  

API documentation is something that go way beyond the description of its interface contract. Don't forget that the API itself and its documentation are the main ingredients of a good developer experience. Without a good DX, no users, no business.  
  
So don't be fooled by this kind of documentation and note that also applies to REST APIs when you use API description format like OpenAPI, Swagger, RAML of Blueprint. 

## GraphQL may have unexpected side effects and data volumes and server usage
With GraphQL, what you want is what you get. But you always have to explicitely tell what you want, there's no `select * from user` like in SQL. So on each request, consumers have to send a full query.

Where you would have a simple `GET /dashboard` with a REST API, you may end with a huge GraphQL query.
In some use case, you may reach your input bandwidth limit because the number of requests has not really diminished but the requests size has increased. Remember that not everybody has a fully scalable cloud infrastructure with illimited bandwidth.  
  
Proposing a smart system allowing consumers to retrieve in one shot what they want do not mean that it will be used wisely. Some lazy consumers may simply fired huge requests retrieving far more data than they really need. Some huge and complex request may impact all you infrastructure, so you should really think about your GraphQL schema and what runs behind it, because you're giving the full power to consumers.

## GraphQL may force you to rethink API analytics and pricing model
If you were relying on HTTP access logs for rate limiting, API analytics and billing you will have to find a new way to handle that. The most important impact will be on pricing model and billing: how to make people pay when you have a single endpoint allowing to do what you want like you want? Counting queries and mutations can be agood start, you'll maybe have to include data volume and queries depth in your calculations to design a new pricing model. Getting these new variables will probably have impacts on your API tooling, especially your API gateway.
  
## Does GraphQL offer a good or a bad PX (provider experience)?
Providing a GraphQL API will not make you magically a better API provider. You still have to design and document your API, you still have to create the best architecture and infrastructure, you still have to define a pricing model. Providing GraphQL API brings the same challenges has providing REST API with a few subtles differences that you must be aware of to choose the right API style for the right context. 

# Should I choose GraphQL or REST?
In conclusion, GraphQL is really a powerful and interesting technology that impacts deeply both API provider and consumer who are acustomed to REST APIs. It's a new technology that may need some improvments, that will surely come. 
  
You MUST see it as a new tool in your API toolbox alongside REST and Streaming APIs. A new tool that you will choose wisely regarding your context. And don't forget that sometime you'll need a hammer AND a screwdriver to build awesome things.

Now I hope you will be able to the answer this really important question:

> REST or GraphQL.  
> Which one is the best API style?

You're supposed to yell *it depends!*

*This post is a writeup of my [API Days Paris 2017 talk](https://speakerdeck.com/arnaudlauret/dot-dot-dot-and-graphql-for-all-a-few-things-to-think-about-before-blindly-dumping-rest-for-graphql).*