---
title: 5 ways to update a boolean status with a REST API
date: 2021-11-24
author: Arnaud Lauret
layout: post
permalink: /5-ways-to-update-a-boolean-status-with-a-rest-api/
category: post
---

Last week, someone sent me a direct message on Twitter asking the following question:
Let's say you have a resource with an activated boolean property, how would you design the operation(s) allowing to activate or deactivate it? 
As this is a use case I often encounter during API design reviews or API design workshops, I thought it would be interesting to share my usual answer(s) with everyone.
<!--more-->

# Always go beyond the question

Before diving into the formal design of a whole API or a single operation, I discuss the actual need(s) in order to be sure about the problem we're trying to solve.
Providing guidance focusing only on the form is the best way to end with a terrible design even if its form is theoretically correct.
In such a case, "a resource that needs to be activated or deactivated", I would search why it needs to be activated/deactivated, are these the actual terms everyone involved use, what is the flow of actions around this specific step.
That could lead to a new vision of the need that could be something else than "activating/deactivating a whatever".

And more prosaically, as boolean are not extensible, I would also search to know if there are there really only 2 states (activated/deactivated).
If that's not the case or if there may be other states in the future, I would recommend to replace the `activated` boolean property by a `status` string (having activated or deactivated values) for instance.

For this post, let's say we work on a User API allowing to "manage" (whatever it means) users and that we need to add a "user activation/deactivation" or "modify user's status" feature.

# Solution 1: Updating the whole resource

Either you say that a user being active (or activated? That's not the exact same meaning ...) depends on a boolean `activated` property or a `status` string property, you could change its value to activate or deactivate the user by:

- Replacing the whole resource with a `PUT /users/{userId}`
- Partially update it with `PATCH /users/{userId}`.

I will not go into all of PUT/PATCH subtleties, I keep that for future posts, but be aware that between choosing the body format, and the fact that [there are some places where PATCH cannot be used](/api-design-tips-and-tricks-what-if-consumers-cant-do-patch-put-or-delete/), using PATCH HTTP method can be tricky.

While being (apparently) straightforward and quite simple to put in place, this "update whole resource" approach as several cons depending on the importance of this "user activation/deactivation" feature:

- It hides a possibly important feature of the API behind a "simple" resource's replace/update. While I always try to avoid having too much operations inside an API, that strategy could make the API too coarse grained, less simple to understand, and less simple to use.
- Hiding a possibly critical feature (activating/deactivating the user) among less critical ones (like maybe changing their `mood`) could lead to security concerns. The security controls of the critical part of this "do-it-all" operation can become more complex to handle, complex to understand for consumers, or even worse: they can be neglected.
- Introducing an "apparently wide scoped resource replace" could be a bit deceptive if it's only aim is to activate/deactivate the user.
- Later, if the first intent was only to activate/deactivate the user, managing other properties' updates can become tricky because of higher security level implemented from the beginning

So if, updating the whole resource may not be a good idea, let's try to make this "user activation/deactivation" feature more visible in the API.

# Solution 2: Using dedicated action resources

Who has never been tempted to add some "action resources" in a REST API, fearing the API inquisition ...
Well, a resource can actually be anything so if your API design guidelines indicates that's a possibility, why not using that design pattern.
So the user could be activated with `POST /users/{resourceId}/activate` and deactivated with `POST /resources/{resourceId}/deactivate`, both having nothing in their requests bodies.

That's make the API pretty simple to understand, but I see 2 cons:

- Personally, I often fear that introducing actions resources could lead to some dreaded terrible RPC where HTTP protocol semantic is set aside with operations like `POST /users/{userId}/delete` or worse `GET /users/{userId}/delete`. I'll probably write one post about that later.
- If there are multiple status, you could end with as many operations as statuses, in such a case, maybe an "IMHO too much RPCesque" `POST /users/{userId}/updateStatus` taking the new value in the body would avoid that.

So, if we're not fan of action resources, how could we make this "user activation/deactivation" visible using "standard" resources, representing business entities and not actions.

# Solution 3: Using a fine grain update à la OData

Why not handle this à la [OData](https://www.odata.org/)?
With OData, it is possible to update a single property of a resource, here `activated` for a user, with something like `PUT /User('userId')/activated`.
As our API is not an OData one, we could adapt the idea to `PUT /users/{userId}/activated` (or `PUT /users/{userId}/status` if we work with a multiple value status).

This strategy:

- Makes the operation visible
- Makes the operation quite simple to secure
- Keeps HTTP semantic

To reduce the risk of having too fine grained APIs, holding too many operations, I would only use it for specific properties updates that represents features needing high visibility and/or more dedicated security checks and I would keep the whole resource PUT/PATCH for more regular/less critical/less interesting properties updates.

But, what if I want to track the activated/deactivated status?

# Solution 4: Adding to a sub collection resource

Sometimes the evolution/change log of the value of a resource's property, hence the `activated` or `status` property of a user in our case, is as important as the value itself. In such a case, we could add a `POST /users/{userId}/statuses` operation, that literally adds a status (activated or deactivated or whatever) to the user.

Note that it works better with the `status` option than with the `activated` one.
Indeed `POST /users/{userId}/activateds` looks awkward and I even doubt it's actual english.
An alternative could be `POST /users/{userId}/activations` but it feels awkward to add a "false" activation.

A `GET /users/{userId}/statuses` could return the change log of a user's status as a list of objects containg a value and a date, while `GET /users/{userId}` would still contain the `status` property holding the current (latest) status of the user.

This solution has the same advantage as solution 3 plus it allows to track evolutions of the value.
But what if you choose solution 3 but realize later that you need 4?
Well, you could keep the original `PUT /users/{userId}/status`, modify it's implementation to actually add a new status, and add the `GET /users/{userId}/statuses`.
You could also tag the original PUT as deprecated and add the 2 new operations (add + list).

Both solution 3 and 4 are the one that I probably use most, but there's a last option that could be interesting to investigate.

# Solution 5: Adding to an independent collection resource

If, for whatever actually relevant business domain reason, it is interesting to totally decorrelate user status management from user, this feature could be managed with an independent collection (list) resource.
A `PUT /activated-users/{userId}` could be used to "put" the user in the "activated list".
Deactivating a user could be done by removing a user from this list with a `DELETE /activated-users/{userId}`.
And a `GET /activated-users` could give you a list of activated users, maybe providing a representation that is slightly different from what `GET /users` would return.

In this use case it doesn't work very well:

- Listing active users would be easily done by adding query filters to `GET /users`.
- We lose a bit the "visible relation" between users and their statuses that was more obvious with `/users/{userId}/statuses`
- It's not possible to handle more statuses (without ending with too many operations)

But it's still interesting to have this pattern in mind as it may work in some other contexts.

# Do not hesitate to ask questions

Now you know 5 different ways to handle operations such as "update a whatever's kind of status", it's up to you to choose the solution that work for your use case in your context (and try to be consistent inside your API and across your APIs).

That's the second post I write thanks to someone's question.
To be honest, I find it quite interesting to answer those questions in a blog post, so do not hesitate to send yours!
I cannot guarantee, I will respond to all them but it's worth the try.