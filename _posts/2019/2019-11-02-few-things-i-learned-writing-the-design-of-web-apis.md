---
title: Few things I learned writing The Design of Web APIs
date: 2019-11-02
author: Arnaud Lauret
layout: post
permalink: /few-things-i-learned-writing-the-design-of-web-apis/
category: post
---

At last, my book The Design of Web APIs is finished and printed! I gradually got back to a "normal" life since the end of summer as the book entered in its production phase, but it was only when I received the printed copies two weeks ago that I had the feeling that this adventure was really over. And then holding the book in my hands, I wondered if it was worth having spent two years of my life on it, what did I learn spending almost all my free time working on this book? That sounded like a good topic to revive the API Handyman blog.
<!--more-->

# The Design of Web APIs

The [Design of Web APIs]({{site.mybook}}) is my first book. Before that, I have been blogging for 2 years before being contacted by Manning to write a book about the OpenAPI Specification. It's an interesting topic (I spend almost a year writing a extensive [tutorial](http://apihandyman.io/writing-openapi-swagger-specification-tutorial-part-1-introduction/) on version 2) but I had other ideas in mind at that time: _The Design of Everyday APIs_. I wanted to write a book that teaches API design principles and not a book about a given technology, I wanted to make a sort of API design version of The Design of Everyday Things by Don Norman. I discovered this book thanks to [Mike Amundsen](https://twitter.com/mamund), it changed the way I envision software. 

> The Design of Everyday Things is a best-selling book by cognitive scientist and usability engineer Donald Norman about how design serves as the communication between object and user, and how to optimize that conduit of communication in order to make the experience of using the object pleasurable. One of the main premises of the book is that although people are often keen to blame themselves when objects appear to malfunction, it is not the fault of the user but rather the lack of intuitive guidance that should be present in the design. ([Wikipedia](https://en.wikipedia.org/wiki/The_Design_of_Everyday_Things))

The Design of Everyday APIs was only a working title, I never have been comfortable with it as I had the feeling that I was borrowing the fame of Don Norman's book. Hopefully it was changed to the more simple and obvious _The Design of Web APIs_.

The title is not the only thing that has changed during the creation of this book. The table of content and the content itself has greatly evolve during these two years to become the book I'm so proud of. But more important, I changed by learning a few things.

# How to actually write a technical book (or other things)

I'm glad I made this book with a publisher and did not self-publish it because the result would probably have been a terrible mess ... if I actually finished it. Having a (good) publisher was great because the people working there helped me in many ways like, for example, fixing typos, challenging the book's content or gently asking me when I planned to finish the next chapter and so help me keeping the pace. But more important, if I know quite a few things about API design and I like story telling, I didn't knew how to actually write a book and my publisher taught me to do so. I'm not a professional writer, I may even be wrong, there are probably thousands of books and blog posts about writing, but here's what I retain after writing this book (and what I try to reuse now when writing anything):

First define what you will actually talk about in your book. To do so, ask yourself:
- Who are your readers? 
- What do they need to know/do before reading the book?
- What will they learn/be able to do by reading it?

Once the book's objective is defined, write the table of content (ToC). It is the backbone of the book, your battle plan. It should tell a story that will help readers to achieve the book's objective.
The first versions can be rough without going to deep into details, just think about the main steps of the story. You'll fill the details by working on each chapter and maybe adjust the ToC.

Then for each chapter:
- Make the elevator pitch of why readers should care about this chapter's content. It shouldn't take more than a few sentences.
- List what readers need to know/do before reading it, basically topics from previous chapters. It may help to spot missed topics.
- List new concept taught
- List the examples used to explain the new concepts
- Sketch the main diagrams that will be used

It's not that easy to do, don't be afraid if it takes time but if if really doesn't work, maybe you should get rid of this chapter and rethink your ToC. With all these elements, it's easier to write the chapter: once you have a good view the content, you "only" need to focus on how to tell the story in an entertaining way. Without them, be ready to face the white page syndrome and rewrite the chapter endlessly.

# There's more than what (you think) you know about the book's topic

By writing a 400 pages book about API design, I ending by knowing far more about this topic than what I knew before starting it. This is not specific to book's writing, I already noticed that after I started to blog.
Writing a book about API design forced me to actually list all the topics that readers need to be aware of and I "discovered" some topics I didn't care much about before starting the book. I had to deeply investigate topics these topics but also ones I thought I knew. And most interesting, I had to find new ways of explaining things, finding examples and drawing diagrams while preparing chapters was of great help to do so. 

# How to receive and provide feedback

I received a lot of feedback during the book's writing. I worked with a development editor and a technical editor who provided feedback on each chapter. There have been 3 readers reviews made on the first third (6 readers), second third (10 readers) and then first complete version of the book (16 readers). There were comments on the forum/live book. And I also got feedback from my friends and colleagues.

The two first readers reviews, especially the second one, left me totally depressed. It was really hard to deal with them because some of them were negative. I even _felt_ that some were too harsh if not mean. I usually consider myself sufficiently adult to be able to get some negative feedback as long as it is argued and there can be a discussion. But, when you get feedback from a dozen readers at once and there is no possible discussion with the PDF file summing up their reviews, that's really hard to manage, at least for me. Hopefully, I could get beyond that thanks to two things.

First, I step back and objectively analyze the reviews to split them in smaller elements. Frankly, I don't remember how I came to do that, probably because my development editor told me to do so or because I usually work like that. But I looked at the reviews and identified every good and bad point, check how many readers talk about them. Doing so I realized that it was not that bad and, even if that always hurt a bit, I agreed with most of the identified problems. I also realized that there was actually only one or two shitty reviewers (sorry, these persons may probably not actually be like that but this is how I felt based on the review) and this lead to my second point.

So, the second thing that help me to go on after the reviews is that I'm lucky to know some authors who have been there and one of them gave me a really good advice. It could be summarized as "you under no obligation to give a shit about what people say". Listen to what people say, take what is of interest for you and your book and leave the rest. And if they are not happy with that, tell them to write their own book.

After these reviews, I realized that I may have been one of these assholes myself. So, I'm really happy that they taught me how to provide better feedback, especially when not face to face, and (I hope) not to be an asshole anymore when providing feedback.

# Be more confident

Hopefully, my development and technical editors feedback were more constructive and encouraging, also were comments from my trusted friends and colleagues. That really gave me confidence. I realized that what I was creating was really good (and I just realized that I became confident enough to actually write that the book is good). Besides having good feedback, I got even more confident seeing how all the book's pieces fit together so well. And being confident about the book's content made me more confident about what I do in my daily job, that's priceless.

# Trust, but verify

When you finish to write a book, the work is not over. The final phase is called the production phase. It mostly deals with copy-editing, graphics-editing, typesetting. 

- Copy-editing consist in fixing typos, grammar and vocabulary and also ensure a certain consistency in your writing. Note that in my case there was a previous ESL (english as second language) copy-editing phase to fix my frenglish. You must check every single modification made to YOUR text in order to be sure that what is written is ok for YOU. Some modifications may not make sense at all or you may simply not like them. It is your right to not accept such modification.
- Graphics-editing is copy-editing for figures. Their texts will be copy-edited and their design may be more or less modified depending on their quality/style/size. In my case, my figures were only finally slightly modified but there has been some bug in the process. For an unknown reason, my figures were being totally remade in a new style that I totally hated. Hopefully, I noticed it and made that stopped. Everyone can make mistakes, that is why there are verifications phases, so don't take them lightly even if you trust the third-parties modifying your work.
- My definition of typesetting is: ajdusting words (split them sometime) and figure positions to avoid empty spaces. If you ever wondered why in some books figures seem in awkward places, in my experience, that is due to typesetting. I had to request a few modifications, but taking typesetting contraints into consideration, in order to avoid such problems on a few figures.

So, you can trust, be never forget to verify. Even if it is hard and boring as hell, you must be very careful when your book is modified by third-parties. You have to exhaustively check ALL modifications. Be confident and never refrain yourself to say no if something seem wrong for you.

# Find a balance between the book and the rest

Finding a balance between the book and the rest, especially my family is something that I didn't do so well at the beginning. If you do write a book, consider defined precisely when you work on it and keep time for your family and possibly for other activities (like reading, playing video games or playing the guitar in my case). That will keep everyone happy (including you) and increase your productivity when writing.

# Never complain when reading others books

And finally, now that I know how hard it is to write a book (and especially to spot all those fucking typos), I will never complain again when I read others books (but I may try to provide some useful and friendly feedback).

# A new beginning

Don't know if so many people will find this post interesting, but I needed to write it to not forget what I've been through. Know that I never regretted starting to write blog posts or the book, so maybe you should think about writing too. Whatever, I'm back on the blog, so stay tune for more API related posts.