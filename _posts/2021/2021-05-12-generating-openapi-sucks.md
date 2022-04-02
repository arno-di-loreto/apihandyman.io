---
date: 2021-05-12
author: Arnaud Lauret
layout: post
category: post
permalink: /6-reasons-why-generating-openapi-from-code-when-designing-and-documenting-apis-sucks/
title: 6 reasons why generating OpenAPI from code when designing and documenting APIs sucks
tools:
    - OpenAPI Specification
---

When working with OpenAPI Specification documents to design and document APIs, there are two approaches: either you write it (directly using a text editor or indirectly using an API design GUI), either you generate it from the implementation's code (using annotations).
Generating OpenAPI Specification documents from code has major drawbacks that you should be aware of in order to choose this approach knowingly.

<!--more-->

If you know me, have seen me talking at conferences, have read my posts or my book, you know what is my favorite approach (spoiler: the "write it" one).
But as an API design reviewer I work with many different teams: some use the first approach and others the second one and some use both.
Slowly but surely, the write it approach is gaining ground.
I am pleased to see new teams I have never work with before are already convinced that writing OpenAPI (when design and documenting) is a better approach for them.
And I am even more pleased to see some who were using the "generate it" approach switching to other other one, convinced by my reasons and the problems their encountered.
I thought it could be interesting to share the 6 main reasons why people would stop to use the "generate it" approach and switch to the "write it" one, hence this post.

# Complicates design

The first reason is that generating OpenAPI from code complicates design.
Indeed, you need to write actual implementation's code to get something.
You need a fully functional development environment to code and build a more or less empty API's implementation's skeleton. 

And not everybody who work on the design of an API can write code.
That may be strange to your eyes, but there are places where developers of an API's implementation are not the one who will actually design the API, business analysts may have that role.
They work closely with developers but they are the one who actually write the API's contract.
There are places where those people may work more closely together, contributing to the same OpenAPI document, that would be quite complicated to do that with a generated one if one of them don't code.

Some would argue that "writing" OpenAPI is like writing code.
Until not so long ago, you would need to know the syntax to actually write it, but that's not true anymore.
There are API design GUI that allows anyone (with basic HTTP knowledge) to describe an API without having to write a single line of YAML (or JSON for the most masochistic).

# Forces to choose development stack

The second reason is an annoying side effect of having to write actual implementation's code to get something.
To write code, you actually have to choose a development stack.
When you are working on a totally new software solution making such decisions too early during the overall solution's design phase may reveal to be a problem.
Indeed, you may realize that the chosen stack was not the more adapted one once you have a full view on what the API is supposed to do and so the written code must be thrown to garbage.
Obviously if that's just "yet another API in familiar environment", that reason is null and void.

# Lessens design quality

Having to write code, especially on an existing application, risks to lessen the API design quality because it may lead to being "inside out" or also less accurate.

An inside out API design brutally exposes what is happening under the hood resulting in less easy to understand, less easy to use, less easy to evolve APIs.
Seeing existing functions, existing databases, you may be tempted to expose them as is without rethinking them.
That will lead to consumers needing to know how your implementation works when they shouldn't, leading to tight coupling with them crippling the possibility of evolutions on your side.

Being polluted by existing implementation or purely development oriented concerns, not only will you expose the engine that should be hidden but you may take shortcuts resulting in less accurate design.
Indeed, for instance, you may choose wrong resources, wrong operations, wrong granularity for an operation or data model or you may simply miss that you should have created a totally new API; all that simply because you were too close to the existing code or data.
Such design will obviously also be less easy to understand, less easy to use, less easy to evolve APIs.

# Casts doubt upon implementation

The big argument of the generate it approach is "no need to synchronize spec and code anymore!".
Yes that's true, but that also means you don't have an independent source of truth for your API's contract.
Whats was agreed on during the design phase may not be what is actually implemented in the end.
Without a source of truth independent from actual code, there's no way to test that what is implement is actually ok.
A long time ago, having working with third party contractors building applications for my company that revealed to be a major problem.
And even when working with the family, some errors or modifications may happen inadvertently.

# Complicates writing documentation

Developers who love to write documentation raise your hands!

Not so many hands risen (that's a pity, but that's another story).

This reason is similar to the first one "Complicates design".
When working on APIs, people who write the documentation may not be the one who write the code (and note also they may not be the one who do the design).
Doc writers may not want to write code and developers may not want to have people mingling with their codebase.

# Lessens documentation quality

You may not know it but pushing the OpenAPI Specification to its limits allows to write totally awesome API documentation that everyone will love (writing about that is on my to do list).
That's especially interesting for private APIs, indeed you may not want to do the same level of effort regarding developer portal and producing content.
A complete OpenAPI shown in Redoc, Stoplight Elements or even SwaggerUI will do the trick at almost 0 cost.

But producing such specification requires to uses all the OpenAPI Specification subtleties and unfortunately not all (if not no) generator allows that (and not all developers are willing to do such effort in their code, because previous reason).
You may possibly tweak what the generator does to achieve some interesting modifications but at what cost?
Whatever you do, generating code irremediably results in less expressive and less complete OpenAPI documents.

# So generating OpenAPI sucks?

That's not what I said, what you should retain from this is is that there are *concerns to be aware of* when generating OpenAPI Specification *from code when designing and documenting API*.
OK, the post's title says "suck", that's a clickbait (for totally honorable reasons 😅).
Actually and as always, it's not a matter of right or wrong, it's a matter of choosing a solution to a given problem according to a context and living with the consequences.

If in your context, people who design, code, and document are the same or are ok to work with code.
And if people working on design are sufficiently experimented to not be polluted by existing code and data.
And if you're confident that there will be no variation during implementation.
And if you don't need all OpenAPI subtleties for your API documentation (and frankly, for private APIs, you can live with that).
You may generate your OpenAPI documents from code.
If not, you may have to rethink your strategy or if it's too complicated decide knowingly to live with the risks listed in this post.

And regarding "generating OpenAPI" in general there are use cases where it's incredibly interesting to do it.
But that's another story.