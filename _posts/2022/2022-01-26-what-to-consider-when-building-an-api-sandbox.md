---
title: What to consider when building an API sandbox
date: 2022-01-26
author: Arnaud Lauret
layout: post
permalink: /what-to-consider-when-building-an-api-sandbox/
category: post
---

Used through the "try it" feature of an API's documentation or directly called by a consumer application, an API sandbox is a great way to let developers play with an API and learn how it works without giving them access to the actual production environment.
But what is an "API sandbox" actually?
Is it just a mock?
It can be that ... or far more than that.
Let's see what could be the features of an API sandbox.
<!--more-->
This post is a sequel to my previous post "[A few concerns to be aware of when adding try it feature to API documentation](/a-few-concerns-to-be-aware-of-when-adding-try-it-feature-to-api-documentation/)".

# What is an API sandbox

An API sandbox is an application or set of applications that simulates an actual API.
Quite often tied to the "try it" feature, which allows to make API calls from an API's documentation, it could also reveal to be quite useful directly called from code created by developers who subscribed to use the API.

Regardless of how it is used, the main purpose of a sandbox is usually to be the playground that help people learn how the API works.
In an ideal world, consumers should be able to write code against the API sandbox and then be able to switch their API calls from the sandboxed version to the real version without any modification (besides configuration).

Usually, the first thought regarding a sandbox is that, if the real API provides a `GET /this` or a `POST /that`, its sandbox counterpart will propose them too, mimicking their behavior in a more or less accurate fashion.
That could make think a sandbox is "just" a basic mock, which is not always the case.

# What are the features of an API sandbox

If an API sandbox is supposed to mimic what the real API does, let's see what happen when consumers interact with a real "task list" API:

- Consumers calling the API to "search tasks" without an access token get an error.
- Obtaining an access token can be done in a machine to machine way or involving an end user authentication, depending on what they want to do.
- Consumers calling the API with an access token tied to wrong scopes get an error. For instance if the access token has not the scope "write access", consumers are not allowed to "create a task".
- When calling the API (with an access token), they get an accurate response which is consistent with their request, either for a success or failure. For instance, if they "search tasks", they get a list of tasks matching their search parameters. If they "create a task", providing a user name and a description, in return they get the input data plus a server generated id. If they forgot to provide the username, or provide a non existing user, or provide a user for which they are not allowed to create a task, they get an error telling them so.
- For a subsequent request, they get a response which is consistent with previous calls. Like seeing their created tasks in the response of "search tasks" or being able to retrieve the created task based on the returned id (with "read task"). 
- Depending on consumer and/or end user profile, consumers may be allowed to do or not to do specific API calls, like reading or deleting a specific task created by other consumer for instance
- And finally an API call or an internal process running without consumer interaction may trigger something that impacts the consumers or the end users outside of the API. For instance, an SMS or an email could be sent to the user identified in the created task or a webhook may be called.

But a sandbox shouldn't only simulate the real API, it should also provide any "meta-feature" that will help people learn how to use it.
And last but not least, the sandbox should be easily "integrable" in the API documentation.

If we sum those 3 dimensions, that mean an API sandbox is supposed to propose the following features:

- Expose the same interface contract as the real API
- Provide useful data
- Simulate implementation and dependencies behaviors
- Save and restore data
- Simulate high level security
- Simulate non API visible dependencies
- Be API first

## Expose the same interface contract as the real API

Using the API, or a fake version of it in this case, really helps to learn how an API work and what you can do with it.
The most minimal API sandbox must expose the same interface contract as the original API.
It must provide all of the operations described in the interface contract.
All those operations, such as `GET /this` and `POST /that`, must respect the paths, parameters, body, data models, HTTP status codes, ... described in the original interface contract.
And the contract must be respected even in case of error (which is often neglected).
Working at this level is usually made working with an API specification such as the OpenAPI Specification.

But "just" simulating the interface contract is usually not enough for a sandbox.

## Provide useful data

It's quite simple to simulate an interface contract based on a specification document using randomly generated and inconsistent data for each call.
But that's not really useful to learn how the API works.
Indeed, if I "search tasks", I would prefer to get a meaningful `description` such as `write a blog post` instead of `lorem ipsum`, or worse `azljkiqjnlkjpoi`, for each element in the list.
Also, once I got my list of tasks, I would be very happy to pick the `id` of one of them,  such as `123`, to do a `GET /tasks/123` ("read task") and get data which is consistent with my previous call.

On top of that, providing useful global data sets allowing to cover various use cases is important.
In our "task list" case, it could be having tasks with all possible types and states or tasks created by various users.
The more real the data, the better the experience and so the learning.
But more important, the less risk of variations between code running against sandbox and production.

But, as I often say, an API is not only about data, an API proposes a service; there's added value logic inside an API.
And just working at data level is sometimes not enough to simulate that.

## Simulate implementation and dependencies behaviors

The implementation of an API holds 3 types of logic a sandbox must try to reproduce as closely to reality as possible:

- Surface controls
- Application level security
- Business rules

Surface controls are all the parameters/properties presence, format and value checks.
Is the mandatory `username` present? Is the task `type` value in allowed values list?
Most of the time, those controls can be directly tied to the interface contract description.
But due to limitations or lack of knowledge of the specification used (do you know that you can specify a regex pattern for a string property in OpenAPI for instance), that sometimes requires more work.

Application level security are those controls an implementation will do to ensure that consumer and possible end user don't see or do  more than they should.
They are based on access token information (consumer, scopes, end user, roles) and business data.
For instance, "is this user allowed to modify this specific task?" or "what are the specific tasks this user can see?".

And last but not least, the business rules.
They are the heart of the implementation: what is done to fullfil what the API is supposed to do.
These are the controls and actions made by the implementation based on business logic and data.
For instance, "Does this user for who I'm supposed to create a tasks exists?", "I read the task for this id", "the time of a tasks is the sum of time of all subtask" or "everything is OK, I insert a task in this table of the database".

Note that an implementation can rely on dependencies.
Depending on your context you may or may not have to work on simulating what is happening in those dependencies.
If our simple "task list" API use case implementation is composed of a basic whatever-language monolithic server application and a database, no dependency problem.
But what it relies on a "user" component to check if a user exists for instance?
Do we need to simulate that component?
And how?
Do we create a single sandbox or one per component?

Also what if this component exposes a "user" API that can be used by the same consumers?
Should the "task list" sandbox do what is necessary to propagate data to the "user" sandbox to have a consistent `tasksCount` property while calling "read user"?

Whatever the complexity of the implementation algorithms and architecture, data needs to be saved in the end more often than not in order to provide a realistic and consistent behavior.

## Save, protect and restore data

Being able to retrieve a previously created or modified task means that the corresponding data have been saved.
If we go on along that line, data can be modified or deleted.
And if the data can be created, modified, or deleted, it may mean in the end that the data will be, not corrupted (the implementation is supposed to prevent that), but seriously messed up.
The quite useful task list containing all types and statuses combinations could not be there anymore for instance.
So maybe some data should be protected against modification and deletion, but that could possibly make the API less realistic.
Another option could be to provide a way to restore the sandbox into an initial clean state when needed.

If data can be modified, in a broad sense, how long should it be kept?
Forever or only for a given amount of time?
Maybe data should be restored automatically to its initial state at some point.

Also, allowing to modify sandbox data for whatever reason should be done not forgetting that, at a given moment, various consumers may work with the sandbox independently.
They should be able to do that without being bothered by what others do (and reverse).
Being able to actually separate who is doing what could be interesting in order to prevent problems, and working on security could help on that topic (among other things).

## Simulate high level security

What I call "high level security" concerns what is usually handled by an API gateway and an identity provider.
That means deciding which consumer can access which API (even which operation inside an API), obtaining an access token to make API calls with or without end user authentication, and control those access tokens.
For instance, a consumer may be allowed to "read task" but not to "modify task".
Note that, it does not mean that this consumer may read all tasks, it will be up to the implementation to check if a specific consumer is allowed to read a specific task (see Simulate implementation and dependencies behaviors above).

Simulating the implementation is already quite a burden, so why bother adding such complexity to a sandbox?

Even when your API uses standard security, such as Oauth 2 or OpenId connect, don't take for granted that everyone knows all possible "give me an API access token" dances.
There always will be beginners who never have used them before, and even those who have encountered such way of securing APIs may need a refresh.
So, having an API sandbox allowing to to test how to get an access token is welcomed.

Also, in order to test various use cases, consumers may need an access token attached to specific scopes and possibly specific end user.
Being able to get ready to use or taylor made access token would be of great help.

And finally, just being able to differentiate which consumer makes an API call to the sandbox may help regarding the partitioning of saved/restored data.

## Simulate non API visible dependencies

Depending on the kind of service provided, consumers may interact with the system exposing it in other ways than calling the API.
For instance, what if the user identified in a task is notified by an email or an SMS upon its creation?
What if, when task is closed (however it is done), the consumer which has created it is notified through a webhook call?
Providing to consumers a kind of administration console logging what should happen outside of the API would help to show all that.

All those features being implemented would make a terrific sandbox, but it's not over yet, there's one last feature to think about.

## Be API First

Some of the previous features imply the consumers interact with the sandbox for doing other things than what the original API and surrounding elements are supposed to do:

- Knowing which are the available use cases (useful data)
- Getting a ready to use access token, which may require to know who are the predefined users (high level security)
- Knowing if something happened outside of the API (non API visible dependencies)

Being API first and providing one or more APIs to deal with these "meta-functions" is a must have for such an advanced sandbox.
Such "sandbox API" could be used to build great API documentation (always in sync seamless "try it" providing everything people need, like the possible use cases for an operation).
And why not let it be "consumed by consumers" too (or at least other apps developed by their developers), if they need to reset their sandbox state they would probably be happy to do that programmatically.

# So much work?

As you can see, providing an accurate and complete sandbox may require to care about many features.
Hopefully, you don't always need such level of accuracy.
In a next post, we'll see various tools and architecture patterns that could help you achieve the right level of API sandbox.
