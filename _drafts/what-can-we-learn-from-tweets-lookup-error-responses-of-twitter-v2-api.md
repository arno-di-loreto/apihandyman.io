---
title: What can we learn from tweets lookup error responses of Twitter v2 API?
author: Arnaud Lauret
layout: post
permalink: /what-can-we-learn-from-tweets-lookup-error-responses-of-twitter-v2-api/
category: post
postman_collection_documentation: https://www.postman.com/apihandyman/workspace/twitter-v2-api-tips-and-tricks/documentation/143378-8f12c1ed-f930-4e0d-8baf-c8a949910229
postman_collection_run: https://god.gw.postman.com/run-collection/143378-8f12c1ed-f930-4e0d-8baf-c8a949910229?action=collection%2Ffork&collection-url=entityId%3D143378-8f12c1ed-f930-4e0d-8baf-c8a949910229%26entityType%3Dcollection%26workspaceId%3D16b83fae-c500-4387-b79c-0c72565d1d0f#?env%5BGuess%20how%20Tweets%20lookup%20parameters%20works%5D=W3sia2V5IjoidHdpdHRlcl90b2tlbiIsInZhbHVlIjoiUFVUIFlPVVIgVE9LRU4gSU4gQ1VSUkVOVCBWQUxVRSBPRiBUV0lUVEVSIFRPS0VOIEVOVklST05NRU5UIFZBUklBQkxFIiwiZW5hYmxlZCI6dHJ1ZSwidHlwZSI6InNlY3JldCJ9XQ==
postman_collection_github: https://github.com/apihandyman/twitter-tips-and-tricks/tree/main/guess-how-tweets-lookup-parameters-work
tools:
  - Postman
---

This collection is a companion to the [What can we learn from tweets lookup error responses of Twitter v2 API?](https://apihandyman.io/what-can-we-learn-from-tweets-lookup-error-responses-of-twitter-v2-api/) API Handyman blog post. It aims to demonstrate how you can learn to use the Twitter v2 API Tweets lookup functions parameters without reading much of the documentation. It comes with 2 additional bonuses. First, you can reuse that technique with many APIs. Second, you may also learn a few API design, implementation, and documentation principles.

<!--more-->

# Twitter v2 API Tweets Lookup

With Twitter v2 API, you can get tweets using [the lookup operations](https://developer.twitter.com/en/docs/twitter-api/tweets/lookup/introduction) `GET /2/tweets/:tweetid` (single tweet) and `GET /2/tweets?ids=:tweetId1,tweetId2,...tweetId100` (multiple tweets). By not providing or providing parameters with wrong values, we'll be able to understand how these operations work.

## Notes about the collection

The [collection](https://apihandyman.postman.co/workspace/Twitter-v2-API-Tips-and-Tricks~16b83fae-c500-4387-b79c-0c72565d1d0f/documentation/143378-8f12c1ed-f930-4e0d-8baf-c8a949910229) takes advantage of collection and environment variables.

### Environment variables

The collection requires the creation of an environment containing the following variables. (Try to send a request without an environment or the following variables and [you'll get a surprise error message](https://apihandyman.io/we-always-forget-to-select-a-postman-environment/)).

{% include alert.html content="Never store API tokens in initial value. Read [How to use API Keys](https://blog.postman.com/how-to-use-api-keys/) to learn more.
" level="danger" %}

| **VARIABLE** | **DESCRIPTION** |
| --- | --- |
| twitter_token | A Twitter API bearer token (Read [Twitter API documentation](https://developer.twitter.com/en/docs/authentication/oauth-2-0/bearer-tokens) to get one) used in Authorization tab of the collection |

### Collection variables

The collection uses the following collection variables:

| **VARIABLE** | **DESCRIPTION** |
| --- | --- |
| tweet_id | A real working tweet id. Feel free to update with one of your likings. To get this id, go to the Twitter website and open a tweet by clicking on it. You'll see a URL like this one [https://twitter.com/apihandyman/status/1387820661742112771](https://twitter.com/apihandyman/status/1387820661742112771) , the id is number number after status. Used in [Retrieve a single tweet](https://apihandyman.postman.co/workspace/Twitter-v2-API-Tips-and-Tricks~16b83fae-c500-4387-b79c-0c72565d1d0f/documentation/143378-8f12c1ed-f930-4e0d-8baf-c8a949910229?entity=folder-a06061d4-092c-4a71-87b6-a04c925154d1), [Retrieve multiple tweets](https://apihandyman.postman.co/workspace/Twitter-v2-API-Tips-and-Tricks~16b83fae-c500-4387-b79c-0c72565d1d0f/documentation/143378-8f12c1ed-f930-4e0d-8baf-c8a949910229?entity=folder-87eabafa-a6bc-4de0-864d-02cdbe819719), and Wrap up folders. |
| unknown_tweet_id | The id of a tweet that doesn't exists anymore. No need to modify this value. Used by requests of [What happens when a tweet is not found](https://apihandyman.postman.co/workspace/Twitter-v2-API-Tips-and-Tricks~16b83fae-c500-4387-b79c-0c72565d1d0f/documentation/143378-8f12c1ed-f930-4e0d-8baf-c8a949910229?entity=folder-4bdae358-e117-4352-804e-be51496100a8) folder. |
| expansions_default_value | A variable holding all possible values of `expansions` parameter. Used in [Get always dame data folder](https://apihandyman.postman.co/workspace/Twitter-v2-API-Tips-and-Tricks~16b83fae-c500-4387-b79c-0c72565d1d0f/documentation/143378-8f12c1ed-f930-4e0d-8baf-c8a949910229?entity=folder-c5fde22c-0ee1-4e2b-955d-b33ecd5aedb1). |
| tweet_fields_default_value | A variable holding all possible values of `tweet.fields` parameter. Used in [Get always dame data folder](https://apihandyman.postman.co/workspace/Twitter-v2-API-Tips-and-Tricks~16b83fae-c500-4387-b79c-0c72565d1d0f/documentation/143378-8f12c1ed-f930-4e0d-8baf-c8a949910229?entity=folder-c5fde22c-0ee1-4e2b-955d-b33ecd5aedb1). |
| media_fields_default_value | A variable holding all possible values of `media.fields` parameter. Used in [Get always dame data folder](https://apihandyman.postman.co/workspace/Twitter-v2-API-Tips-and-Tricks~16b83fae-c500-4387-b79c-0c72565d1d0f/documentation/143378-8f12c1ed-f930-4e0d-8baf-c8a949910229?entity=folder-c5fde22c-0ee1-4e2b-955d-b33ecd5aedb1). |
| poll_fields_default_value | A variable holding all possible values of `poll.fields` parameter. Used in [Get always dame data folder](https://apihandyman.postman.co/workspace/Twitter-v2-API-Tips-and-Tricks~16b83fae-c500-4387-b79c-0c72565d1d0f/documentation/143378-8f12c1ed-f930-4e0d-8baf-c8a949910229?entity=folder-c5fde22c-0ee1-4e2b-955d-b33ecd5aedb1). |
| place_fields_default_value | A variable holding all possible values of `place.fields` parameter. Used in [Get always dame data folder](https://apihandyman.postman.co/workspace/Twitter-v2-API-Tips-and-Tricks~16b83fae-c500-4387-b79c-0c72565d1d0f/documentation/143378-8f12c1ed-f930-4e0d-8baf-c8a949910229?entity=folder-c5fde22c-0ee1-4e2b-955d-b33ecd5aedb1). |
| user_fields_default_value | A variable holding all possible values of `user.fields` parameter. Used in [Get always dame data folder](https://apihandyman.postman.co/workspace/Twitter-v2-API-Tips-and-Tricks~16b83fae-c500-4387-b79c-0c72565d1d0f/documentation/143378-8f12c1ed-f930-4e0d-8baf-c8a949910229?entity=folder-c5fde22c-0ee1-4e2b-955d-b33ecd5aedb1). |
| token_variable_name | Used by some [pre-script magic that checks an environment is selected](https://apihandyman.io/we-always-forget-to-select-a-postman-environment/). No need to modify this value. |
| token_variable_default_value | Used by some [pre-script magic that checks an environment is selected](https://apihandyman.io/we-always-forget-to-select-a-postman-environment/). No need to modify this value. |

# Retrieve a single tweet
Let's start by retrieving a single tweet, it is done with the `GET /2/tweets/:tweetId request`.

All the following requests use the `tweet_id` collection variable value for the `:tweetId` path parameter. Feel free to replace its value with another one. To get this id, go to the Twitter website and open a tweet by clicking on it. You'll see a URL like this one [https://twitter.com/apihandyman/status/1387820661742112771](https://twitter.com/apihandyman/status/1387820661742112771) , the id is the number `1387820661742112771` after `status/`.

What Twitter [Reference documentation](https://developer.twitter.com/en/docs/twitter-api/tweets/lookup/api-reference/get-tweets-id) says about this operation:

> Returns a variety of information about a single Tweet specified by the requested ID.

By providing only the tweet id (as a path parameter), we'll only get the tweet's default fields `id` and `text` but we will discover there are more information to get.
## Get a tweet with default data

When providing only the id path parameter without any other parameters, we get the default data.
### Request and response
{% code title:Request language:http %}
https://api.twitter.com/2/tweets/{{tweet_id}}
{% endcode %}

{% code title:Response language:json %}
{
    "data": {
        "id": "1387820661742112771",
        "text": "Want to learn how to design Web APIs? You should read my book:\n\n- The Design of Web APIs https://t.co/jocUbds6ki\n- Web APIの設計 https://t.co/2Qlkqtjd5c\n- 웹 API 디자인 https://t.co/ZQP0pYSzOm\n- ПРОЕКТИРОВАНИЕ ВЕБ-API https://t.co/oH0OXxB62D\n\n#apidesign #api https://t.co/qWNBAfzaLp"
    }
}`
{% endcode %}

## Guess which query parameters can be used

More data can be retrieved using some query parameters. You can either read the [documentation](https://developer.twitter.com/en/docs/twitter-api/tweets/lookup/api-reference/get-tweets-id), or be lazy and try to guess them by providing a wrong `dummy` query parameter. The error response returned will tell us that parameter is wrong and list the accepted parameters.
### Request and response
{% code title:Request language:http %}
https://api.twitter.com/2/tweets/{{tweet_id}}?dummy=value
{% endcode %}

{% code title:Response language:json %}
{
    "errors": [
        {
            "parameters": {
                "dummy": [
                    "value"
                ]
            },
            "message": "The query parameter [dummy] is not one of [id,expansions,tweet.fields,media.fields,poll.fields,place.fields,user.fields]"
        }
    ],
    "title": "Invalid Request",
    "detail": "One or more parameters to your request was invalid.",
    "type": "https://api.twitter.com/2/problems/invalid-request"
}`
{% endcode %}

## Guess query parameters possible values

Thanks to previous error, we know the possible query parameters. We can add them all to the request, each of them set with a dummy value. That will generate a new error response telling the possible values for each parameter.

### Request and response
{% code title:Request language:http %}
https://api.twitter.com/2/tweets/{{tweet_id}}?id=dummy
&expansions=dummy
&tweet.fields=dummy
&media.fields=dummy
&poll.fields=dummy
&place.fields=dummy
&user.fields=dummy
{% endcode %}

{% code title:Response language:json %}
{
    "errors": [
        {
            "parameters": {
                "id": [
                    "1387820661742112771",
                    "dummy"
                ]
            },
            "message": "The `id` query parameter value [dummy] is not valid"
        },
        {
            "parameters": {
                "id": [
                    "1387820661742112771",
                    "dummy"
                ]
            },
            "message": "Duplicate parameters are not allowed: the `id` query parameter"
        },
        {
            "parameters": {
                "tweet.fields": [
                    "dummy"
                ]
            },
            "message": "The `tweet.fields` query parameter value [dummy] is not one of [attachments,author_id,context_annotations,conversation_id,created_at,entities,geo,id,in_reply_to_user_id,lang,non_public_metrics,organic_metrics,possibly_sensitive,promoted_metrics,public_metrics,referenced_tweets,reply_settings,source,text,withheld]"
        },
        {
            "parameters": {
                "media.fields": [
                    "dummy"
                ]
            },
            "message": "The `media.fields` query parameter value [dummy] is not one of [alt_text,duration_ms,height,media_key,non_public_metrics,organic_metrics,preview_image_url,promoted_metrics,public_metrics,type,url,width]"
        },
        {
            "parameters": {
                "poll.fields": [
                    "dummy"
                ]
            },
            "message": "The `poll.fields` query parameter value [dummy] is not one of [duration_minutes,end_datetime,id,options,voting_status]"
        },
        {
            "parameters": {
                "place.fields": [
                    "dummy"
                ]
            },
            "message": "The `place.fields` query parameter value [dummy] is not one of [contained_within,country,country_code,full_name,geo,id,name,place_type]"
        },
        {
            "parameters": {
                "user.fields": [
                    "dummy"
                ]
            },
            "message": "The `user.fields` query parameter value [dummy] is not one of [created_at,description,entities,id,location,name,pinned_tweet_id,profile_image_url,protected,public_metrics,url,username,verified,withheld]"
        },
        {
            "parameters": {
                "expansions": [
                    "dummy"
                ]
            },
            "message": "The `expansions` query parameter value [dummy] is not one of [author_id,referenced_tweets.id,referenced_tweets.id.author_id,entities.mentions.username,attachments.poll_ids,attachments.media_keys,in_reply_to_user_id,geo.place_id]"
        }
    ],
    "title": "Invalid Request",
    "detail": "One or more parameters to your request was invalid.",
    "type": "https://api.twitter.com/2/problems/invalid-request"
}`
{% endcode %}

## Try to get a tweet with all data

Thanks to the previous error, we know that `id` is not an actual query parameter, so we will deactivate it. That means `id` shouldn't have been returned in the error response when we provided the `dummy` query parameter. It sounds like an implementation bug, some code may blindly take the list of "parameters" without excluding path parameters.

This little problem sets aside, we had very valuable information for the other parameters, we can set them with values listing all their possible values.

### Request and response
{% code title:Request language:http %}
https://api.twitter.com/2/tweets/{{tweet_id}}?expansions=author_id,referenced_tweets.id,referenced_tweets.id.author_id,entities.mentions.username,attachments.poll_ids,attachments.media_keys,in_reply_to_user_id,geo.place_id
&tweet.fields=attachments,author_id,context_annotations,conversation_id,created_at,entities,geo,id,in_reply_to_user_id,lang,non_public_metrics,organic_metrics,possibly_sensitive,promoted_metrics,public_metrics,referenced_tweets,reply_settings,source,text,withheld
&media.fields=alt_text,duration_ms,height,media_key,non_public_metrics,organic_metrics,preview_image_url,promoted_metrics,public_metrics,type,url,width
&poll.fields=duration_minutes,end_datetime,id,options,voting_status
&place.fields=contained_within,country,country_code,full_name,geo,id,name,place_type
&user.fields=created_at,description,entities,id,location,name,pinned_tweet_id,profile_image_url,protected,public_metrics,url,username,verified,withheld
{% endcode %}

{% code title:Response language:json %}
{
    "errors": [
        {
            "resource_type": "tweet",
            "field": "non_public_metrics.impression_count",
            "parameter": "id",
            "resource_id": "1387820661742112771",
            "title": "Field Authorization Error",
            "section": "data",
            "detail": "Sorry, you are not authorized to access 'non_public_metrics.impression_count' on the Tweet with id : [1387820661742112771].",
            "value": "1387820661742112771",
            "type": "https://api.twitter.com/2/problems/not-authorized-for-field"
        },
        {
            "resource_type": "tweet",
            "field": "non_public_metrics.url_link_clicks",
            "parameter": "id",
            "resource_id": "1387820661742112771",
            "title": "Field Authorization Error",
            "section": "data",
            "detail": "Sorry, you are not authorized to access 'non_public_metrics.url_link_clicks' on the Tweet with id : [1387820661742112771].",
            "value": "1387820661742112771",
            "type": "https://api.twitter.com/2/problems/not-authorized-for-field"
        },
        {
            "resource_type": "tweet",
            "field": "non_public_metrics.user_profile_clicks",
            "parameter": "id",
            "resource_id": "1387820661742112771",
            "title": "Field Authorization Error",
            "section": "data",
            "detail": "Sorry, you are not authorized to access 'non_public_metrics.user_profile_clicks' on the Tweet with id : [1387820661742112771].",
            "value": "1387820661742112771",
            "type": "https://api.twitter.com/2/problems/not-authorized-for-field"
        },
        {
            "resource_type": "tweet",
            "field": "organic_metrics.impression_count",
            "parameter": "id",
            "resource_id": "1387820661742112771",
            "title": "Field Authorization Error",
            "section": "data",
            "detail": "Sorry, you are not authorized to access 'organic_metrics.impression_count' on the Tweet with id : [1387820661742112771].",
            "value": "1387820661742112771",
            "type": "https://api.twitter.com/2/problems/not-authorized-for-field"
        },
        {
            "resource_type": "tweet",
            "field": "organic_metrics.like_count",
            "parameter": "id",
            "resource_id": "1387820661742112771",
            "title": "Field Authorization Error",
            "section": "data",
            "detail": "Sorry, you are not authorized to access 'organic_metrics.like_count' on the Tweet with id : [1387820661742112771].",
            "value": "1387820661742112771",
            "type": "https://api.twitter.com/2/problems/not-authorized-for-field"
        },
        {
            "resource_type": "tweet",
            "field": "organic_metrics.reply_count",
            "parameter": "id",
            "resource_id": "1387820661742112771",
            "title": "Field Authorization Error",
            "section": "data",
            "detail": "Sorry, you are not authorized to access 'organic_metrics.reply_count' on the Tweet with id : [1387820661742112771].",
            "value": "1387820661742112771",
            "type": "https://api.twitter.com/2/problems/not-authorized-for-field"
        },
        {
            "resource_type": "tweet",
            "field": "organic_metrics.retweet_count",
            "parameter": "id",
            "resource_id": "1387820661742112771",
            "title": "Field Authorization Error",
            "section": "data",
            "detail": "Sorry, you are not authorized to access 'organic_metrics.retweet_count' on the Tweet with id : [1387820661742112771].",
            "value": "1387820661742112771",
            "type": "https://api.twitter.com/2/problems/not-authorized-for-field"
        },
        {
            "resource_type": "tweet",
            "field": "organic_metrics.url_link_clicks",
            "parameter": "id",
            "resource_id": "1387820661742112771",
            "title": "Field Authorization Error",
            "section": "data",
            "detail": "Sorry, you are not authorized to access 'organic_metrics.url_link_clicks' on the Tweet with id : [1387820661742112771].",
            "value": "1387820661742112771",
            "type": "https://api.twitter.com/2/problems/not-authorized-for-field"
        },
        {
            "resource_type": "tweet",
            "field": "organic_metrics.user_profile_clicks",
            "parameter": "id",
            "resource_id": "1387820661742112771",
            "title": "Field Authorization Error",
            "section": "data",
            "detail": "Sorry, you are not authorized to access 'organic_metrics.user_profile_clicks' on the Tweet with id : [1387820661742112771].",
            "value": "1387820661742112771",
            "type": "https://api.twitter.com/2/problems/not-authorized-for-field"
        },
        {
            "resource_type": "tweet",
            "field": "promoted_metrics.impression_count",
            "parameter": "id",
            "resource_id": "1387820661742112771",
            "title": "Field Authorization Error",
            "section": "data",
            "detail": "Sorry, you are not authorized to access 'promoted_metrics.impression_count' on the Tweet with id : [1387820661742112771].",
            "value": "1387820661742112771",
            "type": "https://api.twitter.com/2/problems/not-authorized-for-field"
        },
        {
            "resource_type": "tweet",
            "field": "promoted_metrics.like_count",
            "parameter": "id",
            "resource_id": "1387820661742112771",
            "title": "Field Authorization Error",
            "section": "data",
            "detail": "Sorry, you are not authorized to access 'promoted_metrics.like_count' on the Tweet with id : [1387820661742112771].",
            "value": "1387820661742112771",
            "type": "https://api.twitter.com/2/problems/not-authorized-for-field"
        },
        {
            "resource_type": "tweet",
            "field": "promoted_metrics.reply_count",
            "parameter": "id",
            "resource_id": "1387820661742112771",
            "title": "Field Authorization Error",
            "section": "data",
            "detail": "Sorry, you are not authorized to access 'promoted_metrics.reply_count' on the Tweet with id : [1387820661742112771].",
            "value": "1387820661742112771",
            "type": "https://api.twitter.com/2/problems/not-authorized-for-field"
        },
        {
            "resource_type": "tweet",
            "field": "promoted_metrics.retweet_count",
            "parameter": "id",
            "resource_id": "1387820661742112771",
            "title": "Field Authorization Error",
            "section": "data",
            "detail": "Sorry, you are not authorized to access 'promoted_metrics.retweet_count' on the Tweet with id : [1387820661742112771].",
            "value": "1387820661742112771",
            "type": "https://api.twitter.com/2/problems/not-authorized-for-field"
        },
        {
            "resource_type": "tweet",
            "field": "promoted_metrics.url_link_clicks",
            "parameter": "id",
            "resource_id": "1387820661742112771",
            "title": "Field Authorization Error",
            "section": "data",
            "detail": "Sorry, you are not authorized to access 'promoted_metrics.url_link_clicks' on the Tweet with id : [1387820661742112771].",
            "value": "1387820661742112771",
            "type": "https://api.twitter.com/2/problems/not-authorized-for-field"
        },
        {
            "resource_type": "tweet",
            "field": "promoted_metrics.user_profile_clicks",
            "parameter": "id",
            "resource_id": "1387820661742112771",
            "title": "Field Authorization Error",
            "section": "data",
            "detail": "Sorry, you are not authorized to access 'promoted_metrics.user_profile_clicks' on the Tweet with id : [1387820661742112771].",
            "value": "1387820661742112771",
            "type": "https://api.twitter.com/2/problems/not-authorized-for-field"
        }
    ]
}`
{% endcode %}

## Get a tweet with only allowed data

Again, the previous request shows a little problem in the implementation. Some fields we can't access were returned. IMHO, we should get only data relevant for our context, or there should be information about scopes of type of account needed to access those fields.

The Twitter v2 API documentation could be improved by providing such information. An array "field vs scope or account level" would be welcomed. And even better: dynamic documentation showing what you can actually get based on different profiles would be great.

At least, the error message is quite clear, we request fields that we're not allowed to get. So let's remove them to get all the data we can get.

### Request and response
{% code title:Request language:http %}
https://api.twitter.com/2/tweets/{{tweet_id}}?expansions=author_id,referenced_tweets.id,referenced_tweets.id.author_id,entities.mentions.username,attachments.poll_ids,attachments.media_keys,in_reply_to_user_id,geo.place_id
&tweet.fields=attachments,author_id,context_annotations,conversation_id,created_at,entities,geo,id,in_reply_to_user_id,lang,possibly_sensitive,public_metrics,referenced_tweets,reply_settings,source,text,withheld
&media.fields=alt_text,duration_ms,height,media_key,non_public_metrics,organic_metrics,preview_image_url,promoted_metrics,public_metrics,type,url,width
&poll.fields=duration_minutes,end_datetime,id,options,voting_status
&place.fields=contained_within,country,country_code,full_name,geo,id,name,place_type
&user.fields=created_at,description,entities,id,location,name,pinned_tweet_id,profile_image_url,protected,public_metrics,url,username,verified,withheld
{% endcode %}

{% code title:Response language:json %}
{
    "data": {
        "possibly_sensitive": false,
        "id": "1387820661742112771",
        "entities": {
            "hashtags": [
                {
                    "start": 236,
                    "end": 246,
                    "tag": "apidesign"
                },
                {
                    "start": 247,
                    "end": 251,
                    "tag": "api"
                }
            ],
            "urls": [
                {
                    "start": 89,
                    "end": 112,
                    "url": "https://t.co/jocUbds6ki",
                    "expanded_url": "https://www.manning.com/books/the-design-of-web-apis?a_aid=everyday_apis&a_bid=ad5a0fe0",
                    "display_url": "manning.com/books/the-desi…",
                    "images": [
                        {
                            "url": "https://pbs.twimg.com/news_img/1507656545223512065/9kT4sodO?format=jpg&name=orig",
                            "width": 360,
                            "height": 451
                        },
                        {
                            "url": "https://pbs.twimg.com/news_img/1507656545223512065/9kT4sodO?format=jpg&name=150x150",
                            "width": 150,
                            "height": 150
                        }
                    ],
                    "status": 200,
                    "title": "The Design of Web APIs",
                    "description": "The Design of Web APIs is a practical, example-packed guide to crafting extraordinary web APIs. Author Arnaud Lauret demonstrates fantastic design principles and techniques you can apply to both public and private web APIs.",
                    "unwound_url": "https://www.manning.com/books/the-design-of-web-apis?a_aid=everyday_apis&a_bid=ad5a0fe0"
                },
                {
                    "start": 126,
                    "end": 149,
                    "url": "https://t.co/2Qlkqtjd5c",
                    "expanded_url": "https://www.shoeisha.co.jp/book/detail/9784798167015",
                    "display_url": "shoeisha.co.jp/book/detail/97…",
                    "status": 200,
                    "unwound_url": "https://www.shoeisha.co.jp/book/detail/9784798167015"
                },
                {
                    "start": 162,
                    "end": 185,
                    "url": "https://t.co/ZQP0pYSzOm",
                    "expanded_url": "http://www.kyobobook.co.kr/product/detailViewKor.laf?ejkGb=KOR&mallGb=KOR&barcode=9788931463224&orderClick=LEa&Kc=",
                    "display_url": "kyobobook.co.kr/product/detail…",
                    "status": 200,
                    "unwound_url": "http://www.kyobobook.co.kr/product/detailViewKor.laf?ejkGb=KOR&mallGb=KOR&barcode=9788931463224&orderClick=LEa&Kc="
                },
                {
                    "start": 211,
                    "end": 234,
                    "url": "https://t.co/oH0OXxB62D",
                    "expanded_url": "https://dmkpress.com/catalog/computer/web/978-5-97060-861-6/",
                    "display_url": "dmkpress.com/catalog/comput…",
                    "status": 200,
                    "unwound_url": "https://dmkpress.com/catalog/computer/web/978-5-97060-861-6/"
                },
                {
                    "start": 252,
                    "end": 275,
                    "url": "https://t.co/qWNBAfzaLp",
                    "expanded_url": "https://twitter.com/apihandyman/status/1387820661742112771/photo/1",
                    "display_url": "pic.twitter.com/qWNBAfzaLp"
                },
                {
                    "start": 252,
                    "end": 275,
                    "url": "https://t.co/qWNBAfzaLp",
                    "expanded_url": "https://twitter.com/apihandyman/status/1387820661742112771/photo/1",
                    "display_url": "pic.twitter.com/qWNBAfzaLp"
                },
                {
                    "start": 252,
                    "end": 275,
                    "url": "https://t.co/qWNBAfzaLp",
                    "expanded_url": "https://twitter.com/apihandyman/status/1387820661742112771/photo/1",
                    "display_url": "pic.twitter.com/qWNBAfzaLp"
                },
                {
                    "start": 252,
                    "end": 275,
                    "url": "https://t.co/qWNBAfzaLp",
                    "expanded_url": "https://twitter.com/apihandyman/status/1387820661742112771/photo/1",
                    "display_url": "pic.twitter.com/qWNBAfzaLp"
                }
            ]
        },
        "lang": "ja",
        "conversation_id": "1387820661742112771",
        "reply_settings": "everyone",
        "text": "Want to learn how to design Web APIs? You should read my book:\n\n- The Design of Web APIs https://t.co/jocUbds6ki\n- Web APIの設計 https://t.co/2Qlkqtjd5c\n- 웹 API 디자인 https://t.co/ZQP0pYSzOm\n- ПРОЕКТИРОВАНИЕ ВЕБ-API https://t.co/oH0OXxB62D\n\n#apidesign #api https://t.co/qWNBAfzaLp",
        "context_annotations": [
            {
                "domain": {
                    "id": "30",
                    "name": "Entities [Entity Service]",
                    "description": "Entity Service top level domain, every item that is in Entity Service should be in this domain"
                },
                "entity": {
                    "id": "848920371311001600",
                    "name": "Technology",
                    "description": "Technology and computing"
                }
            },
            {
                "domain": {
                    "id": "66",
                    "name": "Interests and Hobbies Category",
                    "description": "A grouping of interests and hobbies entities, like Novelty Food or Destinations"
                },
                "entity": {
                    "id": "848921413196984320",
                    "name": "Computer programming",
                    "description": "Computer programming"
                }
            },
            {
                "domain": {
                    "id": "66",
                    "name": "Interests and Hobbies Category",
                    "description": "A grouping of interests and hobbies entities, like Novelty Food or Destinations"
                },
                "entity": {
                    "id": "849075668352499712",
                    "name": "Web design",
                    "description": "Web design"
                }
            }
        ],
        "created_at": "2021-04-29T17:26:44.000Z",
        "source": "Twitter for Mac",
        "author_id": "2943613557",
        "public_metrics": {
            "retweet_count": 7,
            "reply_count": 2,
            "like_count": 29,
            "quote_count": 4
        },
        "attachments": {
            "media_keys": [
                "3_1387820658030170113",
                "3_1387820658030170124",
                "3_1387820658097336320",
                "3_1387820658076303365"
            ]
        }
    },
    "includes": {
        "media": [
            {
                "url": "https://pbs.twimg.com/media/E0KHiRXWUAE6ua-.jpg",
                "type": "photo",
                "width": 264,
                "media_key": "3_1387820658030170113",
                "height": 331
            },
            {
                "url": "https://pbs.twimg.com/media/E0KHiRXWUAw6fjs.jpg",
                "type": "photo",
                "width": 240,
                "media_key": "3_1387820658030170124",
                "height": 303
            },
            {
                "url": "https://pbs.twimg.com/media/E0KHiRnXMAAVKwT.jpg",
                "type": "photo",
                "width": 563,
                "media_key": "3_1387820658097336320",
                "height": 704
            },
            {
                "url": "https://pbs.twimg.com/media/E0KHiRiWQAU0kLd.jpg",
                "type": "photo",
                "width": 270,
                "media_key": "3_1387820658076303365",
                "height": 369
            }
        ],
        "users": [
            {
                "public_metrics": {
                    "followers_count": 5131,
                    "following_count": 943,
                    "tweet_count": 9634,
                    "listed_count": 224
                },
                "protected": false,
                "pinned_tweet_id": "1387820661742112771",
                "created_at": "2014-12-27T11:25:37.000Z",
                "id": "2943613557",
                "location": "Paris, France",
                "name": "API Handyman",
                "profile_image_url": "https://pbs.twimg.com/profile_images/966654273097490432/WPqaXZkf_normal.jpg",
                "entities": {
                    "url": {
                        "urls": [
                            {
                                "start": 0,
                                "end": 23,
                                "url": "https://t.co/iwBBREWUJM",
                                "expanded_url": "https://apihandyman.io/",
                                "display_url": "apihandyman.io"
                            }
                        ]
                    },
                    "description": {
                        "urls": [
                            {
                                "start": 80,
                                "end": 103,
                                "url": "https://t.co/MARf81Unhv",
                                "expanded_url": "http://bit.ly/designwebapis",
                                "display_url": "bit.ly/designwebapis"
                            }
                        ],
                        "mentions": [
                            {
                                "start": 34,
                                "end": 45,
                                "username": "getpostman"
                            },
                            {
                                "start": 116,
                                "end": 129,
                                "username": "apistylebook"
                            }
                        ]
                    }
                },
                "verified": false,
                "username": "apihandyman",
                "url": "https://t.co/iwBBREWUJM",
                "description": "Arnaud Lauret, doing API stuff at @getpostman, Author of The Design of Web APIs https://t.co/MARf81Unhv. Creator of @apistylebook. Not a very good plumber."
            }
        ]
    }
}`
{% endcode %}

# Retrieve multiple tweets
Now we could directly send a `GET /tweets?ids=xxx` with the parameters we have discovered when retrieving a single tweet and it would work. But just for the sake of science, let's try the same method again and check there are not more parameters than we have discovered.

What Twitter [Reference Documentation](https://developer.twitter.com/en/docs/twitter-api/tweets/lookup/api-reference/get-tweets) says:

> Returns a variety of information about the Tweet specified by the requested ID or list of IDs.

When I see `GET /tweets`, I immediately think "I can search in tweets", and that, for instance, I could get tweets between 2 dates or using a given hashtag, but it's absolutely not the case here. The documentation could be slightly improved by clearly stating this operation is not made to search tweets but just to retrieve up to 100 tweets at once (and avoid calling `GET /2/tweets/:id` 100 times). To search tweets, read "[Search Tweets](https://developer.twitter.com/en/docs/twitter-api/tweets/search/introduction)".
## Trying to get tweets without any parameters

For our first call, we will provide no parameters. If it was a search, I would expect to get the first page of all tweets I'm supposed to get. But this is not a search, this operation allows to read up to 100 tweets based on their ids, I expect to get an error.
### Request and response
{% code title:Request language:http %}
https://api.twitter.com/2/tweets
{% endcode %}

{% code title:Response language:json %}
{
    "errors": [
        {
            "parameters": {
                "ids": []
            },
            "message": "The `ids` query parameter can not be empty"
        }
    ],
    "title": "Invalid Request",
    "detail": "One or more parameters to your request was invalid.",
    "type": "https://api.twitter.com/2/problems/invalid-request"
}`
{% endcode %}

## Discover possible query parameters

So when providing no parameters, we got an error telling us the operation needs an `ids` parameter but not what are all other optional parameters, that's the usual behavior of most if not all APIs. So, let's use the `dummy` parameter trick again. We should get the same parameters as to when retrieving a single tweet (minus the ids variation).
### Request and response
{% code title:Request language:http %}
https://api.twitter.com/2/tweets?dummy=value
{% endcode %}

{% code title:Response language:json %}
{
    "errors": [
        {
            "parameters": {
                "ids": []
            },
            "message": "The `ids` query parameter can not be empty"
        },
        {
            "parameters": {
                "dummy": [
                    "value"
                ]
            },
            "message": "The query parameter [dummy] is not one of [ids,expansions,tweet.fields,media.fields,poll.fields,place.fields,user.fields]"
        }
    ],
    "title": "Invalid Request",
    "detail": "One or more parameters to your request was invalid.",
    "type": "https://api.twitter.com/2/problems/invalid-request"
}`
{% endcode %}

## Discover query parameters possible values

Now let's use the `existing_parameter=dummy` value trick to guess possible values (note that we expected to see the same values as when retrieving a single tweet).

### Request and response
{% code title:Request language:http %}
https://api.twitter.com/2/tweets?ids=dummy
&expansions=dummy
&tweet.fields=dummy
&media.fields=dummy
&poll.fields=dummy
&place.fields=dummy
&user.fields=dummy
{% endcode %}

{% code title:Response language:json %}
{
    "errors": [
        {
            "parameters": {
                "ids": [
                    "dummy"
                ]
            },
            "message": "The `ids` query parameter value [dummy] is not valid"
        },
        {
            "parameters": {
                "tweet.fields": [
                    "dummy"
                ]
            },
            "message": "The `tweet.fields` query parameter value [dummy] is not one of [attachments,author_id,context_annotations,conversation_id,created_at,entities,geo,id,in_reply_to_user_id,lang,non_public_metrics,organic_metrics,possibly_sensitive,promoted_metrics,public_metrics,referenced_tweets,reply_settings,source,text,withheld]"
        },
        {
            "parameters": {
                "media.fields": [
                    "dummy"
                ]
            },
            "message": "The `media.fields` query parameter value [dummy] is not one of [alt_text,duration_ms,height,media_key,non_public_metrics,organic_metrics,preview_image_url,promoted_metrics,public_metrics,type,url,width]"
        },
        {
            "parameters": {
                "poll.fields": [
                    "dummy"
                ]
            },
            "message": "The `poll.fields` query parameter value [dummy] is not one of [duration_minutes,end_datetime,id,options,voting_status]"
        },
        {
            "parameters": {
                "place.fields": [
                    "dummy"
                ]
            },
            "message": "The `place.fields` query parameter value [dummy] is not one of [contained_within,country,country_code,full_name,geo,id,name,place_type]"
        },
        {
            "parameters": {
                "user.fields": [
                    "dummy"
                ]
            },
            "message": "The `user.fields` query parameter value [dummy] is not one of [created_at,description,entities,id,location,name,pinned_tweet_id,profile_image_url,protected,public_metrics,url,username,verified,withheld]"
        },
        {
            "parameters": {
                "expansions": [
                    "dummy"
                ]
            },
            "message": "The `expansions` query parameter value [dummy] is not one of [author_id,referenced_tweets.id,referenced_tweets.id.author_id,entities.mentions.username,attachments.poll_ids,attachments.media_keys,in_reply_to_user_id,geo.place_id]"
        }
    ],
    "title": "Invalid Request",
    "detail": "One or more parameters to your request was invalid.",
    "type": "https://api.twitter.com/2/problems/invalid-request"
}`
{% endcode %}

## Try to get tweets with all data

Providing all possible values we should get the same error as when retrieving a single tweet.

### Request and response
{% code title:Request language:http %}
https://api.twitter.com/2/tweets?ids={{tweet_id}}
&expansions=author_id,referenced_tweets.id,referenced_tweets.id.author_id,entities.mentions.username,attachments.poll_ids,attachments.media_keys,in_reply_to_user_id,geo.place_id
&tweet.fields=attachments,author_id,context_annotations,conversation_id,created_at,entities,geo,id,in_reply_to_user_id,lang,non_public_metrics,organic_metrics,possibly_sensitive,promoted_metrics,public_metrics,referenced_tweets,reply_settings,source,text,withheld
&media.fields=alt_text,duration_ms,height,media_key,non_public_metrics,organic_metrics,preview_image_url,promoted_metrics,public_metrics,type,url,width
&poll.fields=duration_minutes,end_datetime,id,options,voting_status
&place.fields=contained_within,country,country_code,full_name,geo,id,name,place_type
&user.fields=created_at,description,entities,id,location,name,pinned_tweet_id,profile_image_url,protected,public_metrics,url,username,verified,withheld
{% endcode %}

{% code title:Response language:json %}
{
    "errors": [
        {
            "resource_type": "tweet",
            "field": "non_public_metrics.impression_count",
            "parameter": "ids",
            "resource_id": "1387820661742112771",
            "title": "Field Authorization Error",
            "section": "data",
            "detail": "Sorry, you are not authorized to access 'non_public_metrics.impression_count' on the Tweet with ids : [1387820661742112771].",
            "value": "1387820661742112771",
            "type": "https://api.twitter.com/2/problems/not-authorized-for-field"
        },
        {
            "resource_type": "tweet",
            "field": "non_public_metrics.url_link_clicks",
            "parameter": "ids",
            "resource_id": "1387820661742112771",
            "title": "Field Authorization Error",
            "section": "data",
            "detail": "Sorry, you are not authorized to access 'non_public_metrics.url_link_clicks' on the Tweet with ids : [1387820661742112771].",
            "value": "1387820661742112771",
            "type": "https://api.twitter.com/2/problems/not-authorized-for-field"
        },
        {
            "resource_type": "tweet",
            "field": "non_public_metrics.user_profile_clicks",
            "parameter": "ids",
            "resource_id": "1387820661742112771",
            "title": "Field Authorization Error",
            "section": "data",
            "detail": "Sorry, you are not authorized to access 'non_public_metrics.user_profile_clicks' on the Tweet with ids : [1387820661742112771].",
            "value": "1387820661742112771",
            "type": "https://api.twitter.com/2/problems/not-authorized-for-field"
        },
        {
            "resource_type": "tweet",
            "field": "organic_metrics.impression_count",
            "parameter": "ids",
            "resource_id": "1387820661742112771",
            "title": "Field Authorization Error",
            "section": "data",
            "detail": "Sorry, you are not authorized to access 'organic_metrics.impression_count' on the Tweet with ids : [1387820661742112771].",
            "value": "1387820661742112771",
            "type": "https://api.twitter.com/2/problems/not-authorized-for-field"
        },
        {
            "resource_type": "tweet",
            "field": "organic_metrics.like_count",
            "parameter": "ids",
            "resource_id": "1387820661742112771",
            "title": "Field Authorization Error",
            "section": "data",
            "detail": "Sorry, you are not authorized to access 'organic_metrics.like_count' on the Tweet with ids : [1387820661742112771].",
            "value": "1387820661742112771",
            "type": "https://api.twitter.com/2/problems/not-authorized-for-field"
        },
        {
            "resource_type": "tweet",
            "field": "organic_metrics.reply_count",
            "parameter": "ids",
            "resource_id": "1387820661742112771",
            "title": "Field Authorization Error",
            "section": "data",
            "detail": "Sorry, you are not authorized to access 'organic_metrics.reply_count' on the Tweet with ids : [1387820661742112771].",
            "value": "1387820661742112771",
            "type": "https://api.twitter.com/2/problems/not-authorized-for-field"
        },
        {
            "resource_type": "tweet",
            "field": "organic_metrics.retweet_count",
            "parameter": "ids",
            "resource_id": "1387820661742112771",
            "title": "Field Authorization Error",
            "section": "data",
            "detail": "Sorry, you are not authorized to access 'organic_metrics.retweet_count' on the Tweet with ids : [1387820661742112771].",
            "value": "1387820661742112771",
            "type": "https://api.twitter.com/2/problems/not-authorized-for-field"
        },
        {
            "resource_type": "tweet",
            "field": "organic_metrics.url_link_clicks",
            "parameter": "ids",
            "resource_id": "1387820661742112771",
            "title": "Field Authorization Error",
            "section": "data",
            "detail": "Sorry, you are not authorized to access 'organic_metrics.url_link_clicks' on the Tweet with ids : [1387820661742112771].",
            "value": "1387820661742112771",
            "type": "https://api.twitter.com/2/problems/not-authorized-for-field"
        },
        {
            "resource_type": "tweet",
            "field": "organic_metrics.user_profile_clicks",
            "parameter": "ids",
            "resource_id": "1387820661742112771",
            "title": "Field Authorization Error",
            "section": "data",
            "detail": "Sorry, you are not authorized to access 'organic_metrics.user_profile_clicks' on the Tweet with ids : [1387820661742112771].",
            "value": "1387820661742112771",
            "type": "https://api.twitter.com/2/problems/not-authorized-for-field"
        },
        {
            "resource_type": "tweet",
            "field": "promoted_metrics.impression_count",
            "parameter": "ids",
            "resource_id": "1387820661742112771",
            "title": "Field Authorization Error",
            "section": "data",
            "detail": "Sorry, you are not authorized to access 'promoted_metrics.impression_count' on the Tweet with ids : [1387820661742112771].",
            "value": "1387820661742112771",
            "type": "https://api.twitter.com/2/problems/not-authorized-for-field"
        },
        {
            "resource_type": "tweet",
            "field": "promoted_metrics.like_count",
            "parameter": "ids",
            "resource_id": "1387820661742112771",
            "title": "Field Authorization Error",
            "section": "data",
            "detail": "Sorry, you are not authorized to access 'promoted_metrics.like_count' on the Tweet with ids : [1387820661742112771].",
            "value": "1387820661742112771",
            "type": "https://api.twitter.com/2/problems/not-authorized-for-field"
        },
        {
            "resource_type": "tweet",
            "field": "promoted_metrics.reply_count",
            "parameter": "ids",
            "resource_id": "1387820661742112771",
            "title": "Field Authorization Error",
            "section": "data",
            "detail": "Sorry, you are not authorized to access 'promoted_metrics.reply_count' on the Tweet with ids : [1387820661742112771].",
            "value": "1387820661742112771",
            "type": "https://api.twitter.com/2/problems/not-authorized-for-field"
        },
        {
            "resource_type": "tweet",
            "field": "promoted_metrics.retweet_count",
            "parameter": "ids",
            "resource_id": "1387820661742112771",
            "title": "Field Authorization Error",
            "section": "data",
            "detail": "Sorry, you are not authorized to access 'promoted_metrics.retweet_count' on the Tweet with ids : [1387820661742112771].",
            "value": "1387820661742112771",
            "type": "https://api.twitter.com/2/problems/not-authorized-for-field"
        },
        {
            "resource_type": "tweet",
            "field": "promoted_metrics.url_link_clicks",
            "parameter": "ids",
            "resource_id": "1387820661742112771",
            "title": "Field Authorization Error",
            "section": "data",
            "detail": "Sorry, you are not authorized to access 'promoted_metrics.url_link_clicks' on the Tweet with ids : [1387820661742112771].",
            "value": "1387820661742112771",
            "type": "https://api.twitter.com/2/problems/not-authorized-for-field"
        },
        {
            "resource_type": "tweet",
            "field": "promoted_metrics.user_profile_clicks",
            "parameter": "ids",
            "resource_id": "1387820661742112771",
            "title": "Field Authorization Error",
            "section": "data",
            "detail": "Sorry, you are not authorized to access 'promoted_metrics.user_profile_clicks' on the Tweet with ids : [1387820661742112771].",
            "value": "1387820661742112771",
            "type": "https://api.twitter.com/2/problems/not-authorized-for-field"
        }
    ]
}`
{% endcode %}

## Get tweets with only allowed data

So both operations share the same parameters with the same value and the same behavior. That means we can trust the Twitter API and apply patterns seen on an operation on others related ones. A behavior to reproduce on all your APIs.

### Request and response
{% code title:Request language:http %}
https://api.twitter.com/2/tweets?ids={{tweet_id}}
&expansions=author_id,referenced_tweets.id,referenced_tweets.id.author_id,entities.mentions.username,attachments.poll_ids,attachments.media_keys,in_reply_to_user_id,geo.place_id
&tweet.fields=attachments,author_id,context_annotations,conversation_id,created_at,entities,geo,id,in_reply_to_user_id,lang,possibly_sensitive,public_metrics,referenced_tweets,reply_settings,source,text,withheld
&media.fields=alt_text,duration_ms,height,media_key,non_public_metrics,organic_metrics,preview_image_url,promoted_metrics,public_metrics,type,url,width
&poll.fields=duration_minutes,end_datetime,id,options,voting_status
&place.fields=contained_within,country,country_code,full_name,geo,id,name,place_type
&user.fields=created_at,description,entities,id,location,name,pinned_tweet_id,profile_image_url,protected,public_metrics,url,username,verified,withheld
{% endcode %}

{% code title:Response language:json %}
{
    "data": [
        {
            "attachments": {
                "media_keys": [
                    "3_1387820658030170113",
                    "3_1387820658030170124",
                    "3_1387820658097336320",
                    "3_1387820658076303365"
                ]
            },
            "reply_settings": "everyone",
            "created_at": "2021-04-29T17:26:44.000Z",
            "text": "Want to learn how to design Web APIs? You should read my book:\n\n- The Design of Web APIs https://t.co/jocUbds6ki\n- Web APIの設計 https://t.co/2Qlkqtjd5c\n- 웹 API 디자인 https://t.co/ZQP0pYSzOm\n- ПРОЕКТИРОВАНИЕ ВЕБ-API https://t.co/oH0OXxB62D\n\n#apidesign #api https://t.co/qWNBAfzaLp",
            "source": "Twitter for Mac",
            "public_metrics": {
                "retweet_count": 7,
                "reply_count": 2,
                "like_count": 29,
                "quote_count": 4
            },
            "id": "1387820661742112771",
            "author_id": "2943613557",
            "conversation_id": "1387820661742112771",
            "lang": "ja",
            "entities": {
                "hashtags": [
                    {
                        "start": 236,
                        "end": 246,
                        "tag": "apidesign"
                    },
                    {
                        "start": 247,
                        "end": 251,
                        "tag": "api"
                    }
                ],
                "urls": [
                    {
                        "start": 89,
                        "end": 112,
                        "url": "https://t.co/jocUbds6ki",
                        "expanded_url": "https://www.manning.com/books/the-design-of-web-apis?a_aid=everyday_apis&a_bid=ad5a0fe0",
                        "display_url": "manning.com/books/the-desi…",
                        "images": [
                            {
                                "url": "https://pbs.twimg.com/news_img/1507656545223512065/9kT4sodO?format=jpg&name=orig",
                                "width": 360,
                                "height": 451
                            },
                            {
                                "url": "https://pbs.twimg.com/news_img/1507656545223512065/9kT4sodO?format=jpg&name=150x150",
                                "width": 150,
                                "height": 150
                            }
                        ],
                        "status": 200,
                        "title": "The Design of Web APIs",
                        "description": "The Design of Web APIs is a practical, example-packed guide to crafting extraordinary web APIs. Author Arnaud Lauret demonstrates fantastic design principles and techniques you can apply to both public and private web APIs.",
                        "unwound_url": "https://www.manning.com/books/the-design-of-web-apis?a_aid=everyday_apis&a_bid=ad5a0fe0"
                    },
                    {
                        "start": 126,
                        "end": 149,
                        "url": "https://t.co/2Qlkqtjd5c",
                        "expanded_url": "https://www.shoeisha.co.jp/book/detail/9784798167015",
                        "display_url": "shoeisha.co.jp/book/detail/97…",
                        "status": 200,
                        "unwound_url": "https://www.shoeisha.co.jp/book/detail/9784798167015"
                    },
                    {
                        "start": 162,
                        "end": 185,
                        "url": "https://t.co/ZQP0pYSzOm",
                        "expanded_url": "http://www.kyobobook.co.kr/product/detailViewKor.laf?ejkGb=KOR&mallGb=KOR&barcode=9788931463224&orderClick=LEa&Kc=",
                        "display_url": "kyobobook.co.kr/product/detail…",
                        "status": 200,
                        "unwound_url": "http://www.kyobobook.co.kr/product/detailViewKor.laf?ejkGb=KOR&mallGb=KOR&barcode=9788931463224&orderClick=LEa&Kc="
                    },
                    {
                        "start": 211,
                        "end": 234,
                        "url": "https://t.co/oH0OXxB62D",
                        "expanded_url": "https://dmkpress.com/catalog/computer/web/978-5-97060-861-6/",
                        "display_url": "dmkpress.com/catalog/comput…",
                        "status": 200,
                        "unwound_url": "https://dmkpress.com/catalog/computer/web/978-5-97060-861-6/"
                    },
                    {
                        "start": 252,
                        "end": 275,
                        "url": "https://t.co/qWNBAfzaLp",
                        "expanded_url": "https://twitter.com/apihandyman/status/1387820661742112771/photo/1",
                        "display_url": "pic.twitter.com/qWNBAfzaLp"
                    },
                    {
                        "start": 252,
                        "end": 275,
                        "url": "https://t.co/qWNBAfzaLp",
                        "expanded_url": "https://twitter.com/apihandyman/status/1387820661742112771/photo/1",
                        "display_url": "pic.twitter.com/qWNBAfzaLp"
                    },
                    {
                        "start": 252,
                        "end": 275,
                        "url": "https://t.co/qWNBAfzaLp",
                        "expanded_url": "https://twitter.com/apihandyman/status/1387820661742112771/photo/1",
                        "display_url": "pic.twitter.com/qWNBAfzaLp"
                    },
                    {
                        "start": 252,
                        "end": 275,
                        "url": "https://t.co/qWNBAfzaLp",
                        "expanded_url": "https://twitter.com/apihandyman/status/1387820661742112771/photo/1",
                        "display_url": "pic.twitter.com/qWNBAfzaLp"
                    }
                ]
            },
            "possibly_sensitive": false,
            "context_annotations": [
                {
                    "domain": {
                        "id": "30",
                        "name": "Entities [Entity Service]",
                        "description": "Entity Service top level domain, every item that is in Entity Service should be in this domain"
                    },
                    "entity": {
                        "id": "848920371311001600",
                        "name": "Technology",
                        "description": "Technology and computing"
                    }
                },
                {
                    "domain": {
                        "id": "66",
                        "name": "Interests and Hobbies Category",
                        "description": "A grouping of interests and hobbies entities, like Novelty Food or Destinations"
                    },
                    "entity": {
                        "id": "848921413196984320",
                        "name": "Computer programming",
                        "description": "Computer programming"
                    }
                },
                {
                    "domain": {
                        "id": "66",
                        "name": "Interests and Hobbies Category",
                        "description": "A grouping of interests and hobbies entities, like Novelty Food or Destinations"
                    },
                    "entity": {
                        "id": "849075668352499712",
                        "name": "Web design",
                        "description": "Web design"
                    }
                }
            ]
        }
    ],
    "includes": {
        "media": [
            {
                "width": 264,
                "type": "photo",
                "media_key": "3_1387820658030170113",
                "height": 331,
                "url": "https://pbs.twimg.com/media/E0KHiRXWUAE6ua-.jpg"
            },
            {
                "width": 240,
                "type": "photo",
                "media_key": "3_1387820658030170124",
                "height": 303,
                "url": "https://pbs.twimg.com/media/E0KHiRXWUAw6fjs.jpg"
            },
            {
                "width": 563,
                "type": "photo",
                "media_key": "3_1387820658097336320",
                "height": 704,
                "url": "https://pbs.twimg.com/media/E0KHiRnXMAAVKwT.jpg"
            },
            {
                "width": 270,
                "type": "photo",
                "media_key": "3_1387820658076303365",
                "height": 369,
                "url": "https://pbs.twimg.com/media/E0KHiRiWQAU0kLd.jpg"
            }
        ],
        "users": [
            {
                "username": "apihandyman",
                "protected": false,
                "id": "2943613557",
                "created_at": "2014-12-27T11:25:37.000Z",
                "pinned_tweet_id": "1387820661742112771",
                "public_metrics": {
                    "followers_count": 5131,
                    "following_count": 943,
                    "tweet_count": 9634,
                    "listed_count": 224
                },
                "verified": false,
                "entities": {
                    "url": {
                        "urls": [
                            {
                                "start": 0,
                                "end": 23,
                                "url": "https://t.co/iwBBREWUJM",
                                "expanded_url": "https://apihandyman.io/",
                                "display_url": "apihandyman.io"
                            }
                        ]
                    },
                    "description": {
                        "urls": [
                            {
                                "start": 80,
                                "end": 103,
                                "url": "https://t.co/MARf81Unhv",
                                "expanded_url": "http://bit.ly/designwebapis",
                                "display_url": "bit.ly/designwebapis"
                            }
                        ],
                        "mentions": [
                            {
                                "start": 34,
                                "end": 45,
                                "username": "getpostman"
                            },
                            {
                                "start": 116,
                                "end": 129,
                                "username": "apistylebook"
                            }
                        ]
                    }
                },
                "name": "API Handyman",
                "url": "https://t.co/iwBBREWUJM",
                "location": "Paris, France",
                "description": "Arnaud Lauret, doing API stuff at @getpostman, Author of The Design of Web APIs https://t.co/MARf81Unhv. Creator of @apistylebook. Not a very good plumber.",
                "profile_image_url": "https://pbs.twimg.com/profile_images/966654273097490432/WPqaXZkf_normal.jpg"
            }
        ]
    }
}`
{% endcode %}

# What happens when a tweet is not found
Providing non-existing ids is also a good way to understand how an API works (and detect bugs). When reading one or multiple non-existing elements, I would expect to get the following responses

*   `GET /tweets/:id` should return a `404 Not Found` when reading a non-existing id
*   `GET /tweets`should return a `200 OK` with an empty data list when providing an ids list containing only non-existing ids
*   `GET /tweets`should return a `200 OK` with a non-empty data list when providing an ids list containing existing and non-existing ids
    

I didn't get all what I expect, I both add less and more.
## Try to get /tweets/:id with a non-existing tweet

The behavior of this operation goes against Twitter API documentation and more important, against HTTP: don't do that at home, return `404 Not Found` and not `200 OK` with an error. It sounds more like a bug than actual intended behavior. At least the body contains an `error` explaining the problem, but if consumers concentrate on HTTP status code, such error may stay invisible.
### Request and response
{% code title:Request language:http %}
https://api.twitter.com/2/tweets/{{unknown_tweet_id}}
{% endcode %}

{% code title:Response language:json %}
{
    "errors": [
        {
            "value": "1508806917874978822",
            "detail": "Could not find tweet with id: [1508806917874978822].",
            "title": "Not Found Error",
            "resource_type": "tweet",
            "parameter": "id",
            "resource_id": "1508806917874978822",
            "type": "https://api.twitter.com/2/problems/resource-not-found"
        }
    ]
}`
{% endcode %}

## Try to get /tweets?ids= with a non-existing tweet

The behavior is the expected one, we have an empty `data` list. But we also get more, there's an `errors` list indicating the non-found tweets. That's not something I've seen often, but that's a nice behavior. Though they could guess which ids were not found, clearly indicating the ids that have not been found can simplify the life of consumers.

### Request and response
{% code title:Request language:http %}
https://api.twitter.com/2/tweets?ids={{unknown_tweet_id}}
&expansions=author_id,referenced_tweets.id,referenced_tweets.id.author_id,entities.mentions.username,attachments.poll_ids,attachments.media_keys,in_reply_to_user_id,geo.place_id
&tweet.fields=attachments,author_id,context_annotations,conversation_id,created_at,entities,geo,id,in_reply_to_user_id,lang,possibly_sensitive,public_metrics,referenced_tweets,reply_settings,source,text,withheld
&media.fields=alt_text,duration_ms,height,media_key,non_public_metrics,organic_metrics,preview_image_url,promoted_metrics,public_metrics,type,url,width
&poll.fields=duration_minutes,end_datetime,id,options,voting_status
&place.fields=contained_within,country,country_code,full_name,geo,id,name,place_type
&user.fields=created_at,description,entities,id,location,name,pinned_tweet_id,profile_image_url,protected,public_metrics,url,username,verified,withheld
{% endcode %}

{% code title:Response language:json %}
{
    "errors": [
        {
            "value": "1508806917874978822",
            "detail": "Could not find tweet with ids: [1508806917874978822].",
            "title": "Not Found Error",
            "resource_type": "tweet",
            "parameter": "ids",
            "resource_id": "1508806917874978822",
            "type": "https://api.twitter.com/2/problems/resource-not-found"
        }
    ]
}`
{% endcode %}

## Try to get existing and non-existing tweets

We have here the same behavior as in previous request. This really demonstrate how you can return a "partial" success and provide explicit information about what has been wrong. I wonder if it happens on errors regarding other query parameters.

### Request and response
{% code title:Request language:http %}
https://api.twitter.com/2/tweets?ids={{unknown_tweet_id}},{{tweet_id}}
&expansions=author_id,referenced_tweets.id,referenced_tweets.id.author_id,entities.mentions.username,attachments.poll_ids,attachments.media_keys,in_reply_to_user_id,geo.place_id
&tweet.fields=attachments,author_id,context_annotations,conversation_id,created_at,entities,geo,id,in_reply_to_user_id,lang,possibly_sensitive,public_metrics,referenced_tweets,reply_settings,source,text,withheld
&media.fields=alt_text,duration_ms,height,media_key,non_public_metrics,organic_metrics,preview_image_url,promoted_metrics,public_metrics,type,url,width
&poll.fields=duration_minutes,end_datetime,id,options,voting_status
&place.fields=contained_within,country,country_code,full_name,geo,id,name,place_type
&user.fields=created_at,description,entities,id,location,name,pinned_tweet_id,profile_image_url,protected,public_metrics,url,username,verified,withheld
{% endcode %}

{% code title:Response language:json %}
{
    "data": [
        {
            "public_metrics": {
                "retweet_count": 7,
                "reply_count": 2,
                "like_count": 29,
                "quote_count": 4
            },
            "entities": {
                "hashtags": [
                    {
                        "start": 236,
                        "end": 246,
                        "tag": "apidesign"
                    },
                    {
                        "start": 247,
                        "end": 251,
                        "tag": "api"
                    }
                ],
                "urls": [
                    {
                        "start": 89,
                        "end": 112,
                        "url": "https://t.co/jocUbds6ki",
                        "expanded_url": "https://www.manning.com/books/the-design-of-web-apis?a_aid=everyday_apis&a_bid=ad5a0fe0",
                        "display_url": "manning.com/books/the-desi…",
                        "images": [
                            {
                                "url": "https://pbs.twimg.com/news_img/1507656545223512065/9kT4sodO?format=jpg&name=orig",
                                "width": 360,
                                "height": 451
                            },
                            {
                                "url": "https://pbs.twimg.com/news_img/1507656545223512065/9kT4sodO?format=jpg&name=150x150",
                                "width": 150,
                                "height": 150
                            }
                        ],
                        "status": 200,
                        "title": "The Design of Web APIs",
                        "description": "The Design of Web APIs is a practical, example-packed guide to crafting extraordinary web APIs. Author Arnaud Lauret demonstrates fantastic design principles and techniques you can apply to both public and private web APIs.",
                        "unwound_url": "https://www.manning.com/books/the-design-of-web-apis?a_aid=everyday_apis&a_bid=ad5a0fe0"
                    },
                    {
                        "start": 126,
                        "end": 149,
                        "url": "https://t.co/2Qlkqtjd5c",
                        "expanded_url": "https://www.shoeisha.co.jp/book/detail/9784798167015",
                        "display_url": "shoeisha.co.jp/book/detail/97…",
                        "status": 200,
                        "unwound_url": "https://www.shoeisha.co.jp/book/detail/9784798167015"
                    },
                    {
                        "start": 162,
                        "end": 185,
                        "url": "https://t.co/ZQP0pYSzOm",
                        "expanded_url": "http://www.kyobobook.co.kr/product/detailViewKor.laf?ejkGb=KOR&mallGb=KOR&barcode=9788931463224&orderClick=LEa&Kc=",
                        "display_url": "kyobobook.co.kr/product/detail…",
                        "status": 200,
                        "unwound_url": "http://www.kyobobook.co.kr/product/detailViewKor.laf?ejkGb=KOR&mallGb=KOR&barcode=9788931463224&orderClick=LEa&Kc="
                    },
                    {
                        "start": 211,
                        "end": 234,
                        "url": "https://t.co/oH0OXxB62D",
                        "expanded_url": "https://dmkpress.com/catalog/computer/web/978-5-97060-861-6/",
                        "display_url": "dmkpress.com/catalog/comput…",
                        "status": 200,
                        "unwound_url": "https://dmkpress.com/catalog/computer/web/978-5-97060-861-6/"
                    },
                    {
                        "start": 252,
                        "end": 275,
                        "url": "https://t.co/qWNBAfzaLp",
                        "expanded_url": "https://twitter.com/apihandyman/status/1387820661742112771/photo/1",
                        "display_url": "pic.twitter.com/qWNBAfzaLp"
                    },
                    {
                        "start": 252,
                        "end": 275,
                        "url": "https://t.co/qWNBAfzaLp",
                        "expanded_url": "https://twitter.com/apihandyman/status/1387820661742112771/photo/1",
                        "display_url": "pic.twitter.com/qWNBAfzaLp"
                    },
                    {
                        "start": 252,
                        "end": 275,
                        "url": "https://t.co/qWNBAfzaLp",
                        "expanded_url": "https://twitter.com/apihandyman/status/1387820661742112771/photo/1",
                        "display_url": "pic.twitter.com/qWNBAfzaLp"
                    },
                    {
                        "start": 252,
                        "end": 275,
                        "url": "https://t.co/qWNBAfzaLp",
                        "expanded_url": "https://twitter.com/apihandyman/status/1387820661742112771/photo/1",
                        "display_url": "pic.twitter.com/qWNBAfzaLp"
                    }
                ]
            },
            "id": "1387820661742112771",
            "created_at": "2021-04-29T17:26:44.000Z",
            "lang": "ja",
            "context_annotations": [
                {
                    "domain": {
                        "id": "30",
                        "name": "Entities [Entity Service]",
                        "description": "Entity Service top level domain, every item that is in Entity Service should be in this domain"
                    },
                    "entity": {
                        "id": "848920371311001600",
                        "name": "Technology",
                        "description": "Technology and computing"
                    }
                },
                {
                    "domain": {
                        "id": "66",
                        "name": "Interests and Hobbies Category",
                        "description": "A grouping of interests and hobbies entities, like Novelty Food or Destinations"
                    },
                    "entity": {
                        "id": "848921413196984320",
                        "name": "Computer programming",
                        "description": "Computer programming"
                    }
                },
                {
                    "domain": {
                        "id": "66",
                        "name": "Interests and Hobbies Category",
                        "description": "A grouping of interests and hobbies entities, like Novelty Food or Destinations"
                    },
                    "entity": {
                        "id": "849075668352499712",
                        "name": "Web design",
                        "description": "Web design"
                    }
                }
            ],
            "source": "Twitter for Mac",
            "possibly_sensitive": false,
            "author_id": "2943613557",
            "attachments": {
                "media_keys": [
                    "3_1387820658030170113",
                    "3_1387820658030170124",
                    "3_1387820658097336320",
                    "3_1387820658076303365"
                ]
            },
            "text": "Want to learn how to design Web APIs? You should read my book:\n\n- The Design of Web APIs https://t.co/jocUbds6ki\n- Web APIの設計 https://t.co/2Qlkqtjd5c\n- 웹 API 디자인 https://t.co/ZQP0pYSzOm\n- ПРОЕКТИРОВАНИЕ ВЕБ-API https://t.co/oH0OXxB62D\n\n#apidesign #api https://t.co/qWNBAfzaLp",
            "conversation_id": "1387820661742112771",
            "reply_settings": "everyone"
        }
    ],
    "includes": {
        "media": [
            {
                "url": "https://pbs.twimg.com/media/E0KHiRXWUAE6ua-.jpg",
                "media_key": "3_1387820658030170113",
                "type": "photo",
                "height": 331,
                "width": 264
            },
            {
                "url": "https://pbs.twimg.com/media/E0KHiRXWUAw6fjs.jpg",
                "media_key": "3_1387820658030170124",
                "type": "photo",
                "height": 303,
                "width": 240
            },
            {
                "url": "https://pbs.twimg.com/media/E0KHiRnXMAAVKwT.jpg",
                "media_key": "3_1387820658097336320",
                "type": "photo",
                "height": 704,
                "width": 563
            },
            {
                "url": "https://pbs.twimg.com/media/E0KHiRiWQAU0kLd.jpg",
                "media_key": "3_1387820658076303365",
                "type": "photo",
                "height": 369,
                "width": 270
            }
        ],
        "users": [
            {
                "id": "2943613557",
                "verified": false,
                "profile_image_url": "https://pbs.twimg.com/profile_images/966654273097490432/WPqaXZkf_normal.jpg",
                "url": "https://t.co/iwBBREWUJM",
                "created_at": "2014-12-27T11:25:37.000Z",
                "description": "Arnaud Lauret, doing API stuff at @getpostman, Author of The Design of Web APIs https://t.co/MARf81Unhv. Creator of @apistylebook. Not a very good plumber.",
                "name": "API Handyman",
                "username": "apihandyman",
                "location": "Paris, France",
                "entities": {
                    "url": {
                        "urls": [
                            {
                                "start": 0,
                                "end": 23,
                                "url": "https://t.co/iwBBREWUJM",
                                "expanded_url": "https://apihandyman.io/",
                                "display_url": "apihandyman.io"
                            }
                        ]
                    },
                    "description": {
                        "urls": [
                            {
                                "start": 80,
                                "end": 103,
                                "url": "https://t.co/MARf81Unhv",
                                "expanded_url": "http://bit.ly/designwebapis",
                                "display_url": "bit.ly/designwebapis"
                            }
                        ],
                        "mentions": [
                            {
                                "start": 34,
                                "end": 45,
                                "username": "getpostman"
                            },
                            {
                                "start": 116,
                                "end": 129,
                                "username": "apistylebook"
                            }
                        ]
                    }
                },
                "pinned_tweet_id": "1387820661742112771",
                "public_metrics": {
                    "followers_count": 5131,
                    "following_count": 943,
                    "tweet_count": 9634,
                    "listed_count": 224
                },
                "protected": false
            }
        ]
    },
    "errors": [
        {
            "value": "1508806917874978822",
            "detail": "Could not find tweet with ids: [1508806917874978822].",
            "title": "Not Found Error",
            "resource_type": "tweet",
            "parameter": "ids",
            "resource_id": "1508806917874978822",
            "type": "https://api.twitter.com/2/problems/resource-not-found"
        }
    ]
}`
{% endcode %}

# Expansions and xxx.fields silent relationship
Let's see what happens when providing incoherent query parameters. For instance, let's request some `xxx.fields` without requiring `expansions`. In an ideal world, I would love to get the `data,` and some `errors` telling me for instance that requested `user.fields` are not shown because expansion of user data has not been requested.
## Get a tweet with all fields but without expansions

When deactivating `expansions` query parameter, we get some data but not all data and not a single error. Hopefully, the documentation is quite clear on the relation between `expansions` and `xxx.fields`. But this behavior is different from what we have seen when providing wrong values in `ids` query parameter, it's a little bit deceptive. It also puzzled me for a few minutes when I was randomly playing with `user.fields` parameter and not understanding why I had no actual user data (I didn't requested the expansion of user data).

### Request and response
{% code title:Request language:http %}
https://api.twitter.com/2/tweets/{{tweet_id}}?expansions=author_id,referenced_tweets.id,referenced_tweets.id.author_id,entities.mentions.username,attachments.poll_ids,attachments.media_keys,in_reply_to_user_id,geo.place_id
&tweet.fields=attachments,author_id,context_annotations,conversation_id,created_at,entities,geo,id,in_reply_to_user_id,lang,possibly_sensitive,public_metrics,referenced_tweets,reply_settings,source,text,withheld
&media.fields=alt_text,duration_ms,height,media_key,non_public_metrics,organic_metrics,preview_image_url,promoted_metrics,public_metrics,type,url,width
&poll.fields=duration_minutes,end_datetime,id,options,voting_status
&place.fields=contained_within,country,country_code,full_name,geo,id,name,place_type
&user.fields=created_at,description,entities,id,location,name,pinned_tweet_id,profile_image_url,protected,public_metrics,url,username,verified,withheld
{% endcode %}

{% code title:Response language:json %}
{
    "data": {
        "possibly_sensitive": false,
        "id": "1387820661742112771",
        "entities": {
            "hashtags": [
                {
                    "start": 236,
                    "end": 246,
                    "tag": "apidesign"
                },
                {
                    "start": 247,
                    "end": 251,
                    "tag": "api"
                }
            ],
            "urls": [
                {
                    "start": 89,
                    "end": 112,
                    "url": "https://t.co/jocUbds6ki",
                    "expanded_url": "https://www.manning.com/books/the-design-of-web-apis?a_aid=everyday_apis&a_bid=ad5a0fe0",
                    "display_url": "manning.com/books/the-desi…",
                    "images": [
                        {
                            "url": "https://pbs.twimg.com/news_img/1507656545223512065/9kT4sodO?format=jpg&name=orig",
                            "width": 360,
                            "height": 451
                        },
                        {
                            "url": "https://pbs.twimg.com/news_img/1507656545223512065/9kT4sodO?format=jpg&name=150x150",
                            "width": 150,
                            "height": 150
                        }
                    ],
                    "status": 200,
                    "title": "The Design of Web APIs",
                    "description": "The Design of Web APIs is a practical, example-packed guide to crafting extraordinary web APIs. Author Arnaud Lauret demonstrates fantastic design principles and techniques you can apply to both public and private web APIs.",
                    "unwound_url": "https://www.manning.com/books/the-design-of-web-apis?a_aid=everyday_apis&a_bid=ad5a0fe0"
                },
                {
                    "start": 126,
                    "end": 149,
                    "url": "https://t.co/2Qlkqtjd5c",
                    "expanded_url": "https://www.shoeisha.co.jp/book/detail/9784798167015",
                    "display_url": "shoeisha.co.jp/book/detail/97…",
                    "status": 200,
                    "unwound_url": "https://www.shoeisha.co.jp/book/detail/9784798167015"
                },
                {
                    "start": 162,
                    "end": 185,
                    "url": "https://t.co/ZQP0pYSzOm",
                    "expanded_url": "http://www.kyobobook.co.kr/product/detailViewKor.laf?ejkGb=KOR&mallGb=KOR&barcode=9788931463224&orderClick=LEa&Kc=",
                    "display_url": "kyobobook.co.kr/product/detail…",
                    "status": 200,
                    "unwound_url": "http://www.kyobobook.co.kr/product/detailViewKor.laf?ejkGb=KOR&mallGb=KOR&barcode=9788931463224&orderClick=LEa&Kc="
                },
                {
                    "start": 211,
                    "end": 234,
                    "url": "https://t.co/oH0OXxB62D",
                    "expanded_url": "https://dmkpress.com/catalog/computer/web/978-5-97060-861-6/",
                    "display_url": "dmkpress.com/catalog/comput…",
                    "status": 200,
                    "unwound_url": "https://dmkpress.com/catalog/computer/web/978-5-97060-861-6/"
                },
                {
                    "start": 252,
                    "end": 275,
                    "url": "https://t.co/qWNBAfzaLp",
                    "expanded_url": "https://twitter.com/apihandyman/status/1387820661742112771/photo/1",
                    "display_url": "pic.twitter.com/qWNBAfzaLp"
                },
                {
                    "start": 252,
                    "end": 275,
                    "url": "https://t.co/qWNBAfzaLp",
                    "expanded_url": "https://twitter.com/apihandyman/status/1387820661742112771/photo/1",
                    "display_url": "pic.twitter.com/qWNBAfzaLp"
                },
                {
                    "start": 252,
                    "end": 275,
                    "url": "https://t.co/qWNBAfzaLp",
                    "expanded_url": "https://twitter.com/apihandyman/status/1387820661742112771/photo/1",
                    "display_url": "pic.twitter.com/qWNBAfzaLp"
                },
                {
                    "start": 252,
                    "end": 275,
                    "url": "https://t.co/qWNBAfzaLp",
                    "expanded_url": "https://twitter.com/apihandyman/status/1387820661742112771/photo/1",
                    "display_url": "pic.twitter.com/qWNBAfzaLp"
                }
            ]
        },
        "lang": "ja",
        "conversation_id": "1387820661742112771",
        "reply_settings": "everyone",
        "text": "Want to learn how to design Web APIs? You should read my book:\n\n- The Design of Web APIs https://t.co/jocUbds6ki\n- Web APIの設計 https://t.co/2Qlkqtjd5c\n- 웹 API 디자인 https://t.co/ZQP0pYSzOm\n- ПРОЕКТИРОВАНИЕ ВЕБ-API https://t.co/oH0OXxB62D\n\n#apidesign #api https://t.co/qWNBAfzaLp",
        "context_annotations": [
            {
                "domain": {
                    "id": "30",
                    "name": "Entities [Entity Service]",
                    "description": "Entity Service top level domain, every item that is in Entity Service should be in this domain"
                },
                "entity": {
                    "id": "848920371311001600",
                    "name": "Technology",
                    "description": "Technology and computing"
                }
            },
            {
                "domain": {
                    "id": "66",
                    "name": "Interests and Hobbies Category",
                    "description": "A grouping of interests and hobbies entities, like Novelty Food or Destinations"
                },
                "entity": {
                    "id": "848921413196984320",
                    "name": "Computer programming",
                    "description": "Computer programming"
                }
            },
            {
                "domain": {
                    "id": "66",
                    "name": "Interests and Hobbies Category",
                    "description": "A grouping of interests and hobbies entities, like Novelty Food or Destinations"
                },
                "entity": {
                    "id": "849075668352499712",
                    "name": "Web design",
                    "description": "Web design"
                }
            }
        ],
        "created_at": "2021-04-29T17:26:44.000Z",
        "source": "Twitter for Mac",
        "author_id": "2943613557",
        "public_metrics": {
            "retweet_count": 7,
            "reply_count": 2,
            "like_count": 29,
            "quote_count": 4
        },
        "attachments": {
            "media_keys": [
                "3_1387820658030170113",
                "3_1387820658030170124",
                "3_1387820658097336320",
                "3_1387820658076303365"
            ]
        }
    },
    "includes": {
        "media": [
            {
                "url": "https://pbs.twimg.com/media/E0KHiRXWUAE6ua-.jpg",
                "type": "photo",
                "width": 264,
                "media_key": "3_1387820658030170113",
                "height": 331
            },
            {
                "url": "https://pbs.twimg.com/media/E0KHiRXWUAw6fjs.jpg",
                "type": "photo",
                "width": 240,
                "media_key": "3_1387820658030170124",
                "height": 303
            },
            {
                "url": "https://pbs.twimg.com/media/E0KHiRnXMAAVKwT.jpg",
                "type": "photo",
                "width": 563,
                "media_key": "3_1387820658097336320",
                "height": 704
            },
            {
                "url": "https://pbs.twimg.com/media/E0KHiRiWQAU0kLd.jpg",
                "type": "photo",
                "width": 270,
                "media_key": "3_1387820658076303365",
                "height": 369
            }
        ],
        "users": [
            {
                "public_metrics": {
                    "followers_count": 5131,
                    "following_count": 943,
                    "tweet_count": 9634,
                    "listed_count": 224
                },
                "protected": false,
                "pinned_tweet_id": "1387820661742112771",
                "created_at": "2014-12-27T11:25:37.000Z",
                "id": "2943613557",
                "location": "Paris, France",
                "name": "API Handyman",
                "profile_image_url": "https://pbs.twimg.com/profile_images/966654273097490432/WPqaXZkf_normal.jpg",
                "entities": {
                    "url": {
                        "urls": [
                            {
                                "start": 0,
                                "end": 23,
                                "url": "https://t.co/iwBBREWUJM",
                                "expanded_url": "https://apihandyman.io/",
                                "display_url": "apihandyman.io"
                            }
                        ]
                    },
                    "description": {
                        "urls": [
                            {
                                "start": 80,
                                "end": 103,
                                "url": "https://t.co/MARf81Unhv",
                                "expanded_url": "http://bit.ly/designwebapis",
                                "display_url": "bit.ly/designwebapis"
                            }
                        ],
                        "mentions": [
                            {
                                "start": 34,
                                "end": 45,
                                "username": "getpostman"
                            },
                            {
                                "start": 116,
                                "end": 129,
                                "username": "apistylebook"
                            }
                        ]
                    }
                },
                "verified": false,
                "username": "apihandyman",
                "url": "https://t.co/iwBBREWUJM",
                "description": "Arnaud Lauret, doing API stuff at @getpostman, Author of The Design of Web APIs https://t.co/MARf81Unhv. Creator of @apistylebook. Not a very good plumber."
            }
        ]
    }
}`
{% endcode %}

## Fix get a tweet with all fields but without expansions

By adding some magic in the Pre-request Script tab, we can ensure the consistency between `expansions` and `xxx.fields`.

### Pre-request Script

{% code title:"Pre-request Script" language:json %}
// Typically the kind of code you can put in collection Pre-request Script
// Checks the consistency between expansions value and the presence of xxx.fields query parameters
// That sort of control should be done at implementation level and, in the case of Twitter API,
// some errors (warnings) should be returned along with the data 

// What expansions must contain depending on xxx.fields
const fieldsVsExpansions = {
    "user.fields" : ["author_id", "entities.mentions", "in_reply_to_user_id", "referenced_tweets.id.author_id"],
    "tweet.fields": ["referenced_tweets.id"],
    "poll.fields" : ["attachments.poll_ids"],
    "place.fields": ["geo.place_id"],
    "media.fields": ["attachments.media_keys"]
};

// Looking for an enabled expansions query parameter
const expansions = pm.request.url.query.all().find(param => param.key==="expansions" && !param.disabled);
// Checking xxx.fields presence
pm.request.url.query.all().forEach((param) => {
    // Works only with parameter listed in fieldsVsExpansions    
    const fieldVsExpansions = fieldsVsExpansions[param.key];
    if(fieldVsExpansions !== undefined) {
        // No expansions query parameter defined or enabled
        if(expansions === undefined) {
            const message = `${param.key} parameter provided but no expansions parameter containing one of the following values ${fieldVsExpansions} provided`;
            throw new Error(message);
        }
        else {
            const expansionsValues = expansions.value.split(",");
            const expansionValueFound = expansionsValues.some(value => fieldVsExpansions.indexOf(value) >= 0);
            // Expansions query parameter present but does not contains one of the expected values
            if(!expansionValueFound) {
                const message = `${param.key} provided but expansions parameter does not contain one of the following values: ${fieldVsExpansions}`;
                throw new Error(message);
            }
        }
    }
});
{% endcode %}
### Request and response
{% code title:Request language:http %}
https://api.twitter.com/2/tweets/{{tweet_id}}?expansions=author_id,referenced_tweets.id,referenced_tweets.id.author_id,entities.mentions.username,attachments.poll_ids,attachments.media_keys,in_reply_to_user_id,geo.place_id
&tweet.fields=attachments,author_id,context_annotations,conversation_id,created_at,entities,geo,id,in_reply_to_user_id,lang,possibly_sensitive,public_metrics,referenced_tweets,reply_settings,source,text,withheld
&media.fields=alt_text,duration_ms,height,media_key,non_public_metrics,organic_metrics,preview_image_url,promoted_metrics,public_metrics,type,url,width
&poll.fields=duration_minutes,end_datetime,id,options,voting_status
&place.fields=contained_within,country,country_code,full_name,geo,id,name,place_type
&user.fields=created_at,description,entities,id,location,name,pinned_tweet_id,profile_image_url,protected,public_metrics,url,username,verified,withheld
{% endcode %}

{% code title:Response language:json %}
{
    "data": {
        "possibly_sensitive": false,
        "id": "1387820661742112771",
        "entities": {
            "hashtags": [
                {
                    "start": 236,
                    "end": 246,
                    "tag": "apidesign"
                },
                {
                    "start": 247,
                    "end": 251,
                    "tag": "api"
                }
            ],
            "urls": [
                {
                    "start": 89,
                    "end": 112,
                    "url": "https://t.co/jocUbds6ki",
                    "expanded_url": "https://www.manning.com/books/the-design-of-web-apis?a_aid=everyday_apis&a_bid=ad5a0fe0",
                    "display_url": "manning.com/books/the-desi…",
                    "images": [
                        {
                            "url": "https://pbs.twimg.com/news_img/1507656545223512065/9kT4sodO?format=jpg&name=orig",
                            "width": 360,
                            "height": 451
                        },
                        {
                            "url": "https://pbs.twimg.com/news_img/1507656545223512065/9kT4sodO?format=jpg&name=150x150",
                            "width": 150,
                            "height": 150
                        }
                    ],
                    "status": 200,
                    "title": "The Design of Web APIs",
                    "description": "The Design of Web APIs is a practical, example-packed guide to crafting extraordinary web APIs. Author Arnaud Lauret demonstrates fantastic design principles and techniques you can apply to both public and private web APIs.",
                    "unwound_url": "https://www.manning.com/books/the-design-of-web-apis?a_aid=everyday_apis&a_bid=ad5a0fe0"
                },
                {
                    "start": 126,
                    "end": 149,
                    "url": "https://t.co/2Qlkqtjd5c",
                    "expanded_url": "https://www.shoeisha.co.jp/book/detail/9784798167015",
                    "display_url": "shoeisha.co.jp/book/detail/97…",
                    "status": 200,
                    "unwound_url": "https://www.shoeisha.co.jp/book/detail/9784798167015"
                },
                {
                    "start": 162,
                    "end": 185,
                    "url": "https://t.co/ZQP0pYSzOm",
                    "expanded_url": "http://www.kyobobook.co.kr/product/detailViewKor.laf?ejkGb=KOR&mallGb=KOR&barcode=9788931463224&orderClick=LEa&Kc=",
                    "display_url": "kyobobook.co.kr/product/detail…",
                    "status": 200,
                    "unwound_url": "http://www.kyobobook.co.kr/product/detailViewKor.laf?ejkGb=KOR&mallGb=KOR&barcode=9788931463224&orderClick=LEa&Kc="
                },
                {
                    "start": 211,
                    "end": 234,
                    "url": "https://t.co/oH0OXxB62D",
                    "expanded_url": "https://dmkpress.com/catalog/computer/web/978-5-97060-861-6/",
                    "display_url": "dmkpress.com/catalog/comput…",
                    "status": 200,
                    "unwound_url": "https://dmkpress.com/catalog/computer/web/978-5-97060-861-6/"
                },
                {
                    "start": 252,
                    "end": 275,
                    "url": "https://t.co/qWNBAfzaLp",
                    "expanded_url": "https://twitter.com/apihandyman/status/1387820661742112771/photo/1",
                    "display_url": "pic.twitter.com/qWNBAfzaLp"
                },
                {
                    "start": 252,
                    "end": 275,
                    "url": "https://t.co/qWNBAfzaLp",
                    "expanded_url": "https://twitter.com/apihandyman/status/1387820661742112771/photo/1",
                    "display_url": "pic.twitter.com/qWNBAfzaLp"
                },
                {
                    "start": 252,
                    "end": 275,
                    "url": "https://t.co/qWNBAfzaLp",
                    "expanded_url": "https://twitter.com/apihandyman/status/1387820661742112771/photo/1",
                    "display_url": "pic.twitter.com/qWNBAfzaLp"
                },
                {
                    "start": 252,
                    "end": 275,
                    "url": "https://t.co/qWNBAfzaLp",
                    "expanded_url": "https://twitter.com/apihandyman/status/1387820661742112771/photo/1",
                    "display_url": "pic.twitter.com/qWNBAfzaLp"
                }
            ]
        },
        "lang": "ja",
        "conversation_id": "1387820661742112771",
        "reply_settings": "everyone",
        "text": "Want to learn how to design Web APIs? You should read my book:\n\n- The Design of Web APIs https://t.co/jocUbds6ki\n- Web APIの設計 https://t.co/2Qlkqtjd5c\n- 웹 API 디자인 https://t.co/ZQP0pYSzOm\n- ПРОЕКТИРОВАНИЕ ВЕБ-API https://t.co/oH0OXxB62D\n\n#apidesign #api https://t.co/qWNBAfzaLp",
        "context_annotations": [
            {
                "domain": {
                    "id": "30",
                    "name": "Entities [Entity Service]",
                    "description": "Entity Service top level domain, every item that is in Entity Service should be in this domain"
                },
                "entity": {
                    "id": "848920371311001600",
                    "name": "Technology",
                    "description": "Technology and computing"
                }
            },
            {
                "domain": {
                    "id": "66",
                    "name": "Interests and Hobbies Category",
                    "description": "A grouping of interests and hobbies entities, like Novelty Food or Destinations"
                },
                "entity": {
                    "id": "848921413196984320",
                    "name": "Computer programming",
                    "description": "Computer programming"
                }
            },
            {
                "domain": {
                    "id": "66",
                    "name": "Interests and Hobbies Category",
                    "description": "A grouping of interests and hobbies entities, like Novelty Food or Destinations"
                },
                "entity": {
                    "id": "849075668352499712",
                    "name": "Web design",
                    "description": "Web design"
                }
            }
        ],
        "created_at": "2021-04-29T17:26:44.000Z",
        "source": "Twitter for Mac",
        "author_id": "2943613557",
        "public_metrics": {
            "retweet_count": 7,
            "reply_count": 2,
            "like_count": 29,
            "quote_count": 4
        },
        "attachments": {
            "media_keys": [
                "3_1387820658030170113",
                "3_1387820658030170124",
                "3_1387820658097336320",
                "3_1387820658076303365"
            ]
        }
    },
    "includes": {
        "media": [
            {
                "url": "https://pbs.twimg.com/media/E0KHiRXWUAE6ua-.jpg",
                "type": "photo",
                "width": 264,
                "media_key": "3_1387820658030170113",
                "height": 331
            },
            {
                "url": "https://pbs.twimg.com/media/E0KHiRXWUAw6fjs.jpg",
                "type": "photo",
                "width": 240,
                "media_key": "3_1387820658030170124",
                "height": 303
            },
            {
                "url": "https://pbs.twimg.com/media/E0KHiRnXMAAVKwT.jpg",
                "type": "photo",
                "width": 563,
                "media_key": "3_1387820658097336320",
                "height": 704
            },
            {
                "url": "https://pbs.twimg.com/media/E0KHiRiWQAU0kLd.jpg",
                "type": "photo",
                "width": 270,
                "media_key": "3_1387820658076303365",
                "height": 369
            }
        ],
        "users": [
            {
                "public_metrics": {
                    "followers_count": 5131,
                    "following_count": 943,
                    "tweet_count": 9634,
                    "listed_count": 224
                },
                "protected": false,
                "pinned_tweet_id": "1387820661742112771",
                "created_at": "2014-12-27T11:25:37.000Z",
                "id": "2943613557",
                "location": "Paris, France",
                "name": "API Handyman",
                "profile_image_url": "https://pbs.twimg.com/profile_images/966654273097490432/WPqaXZkf_normal.jpg",
                "entities": {
                    "url": {
                        "urls": [
                            {
                                "start": 0,
                                "end": 23,
                                "url": "https://t.co/iwBBREWUJM",
                                "expanded_url": "https://apihandyman.io/",
                                "display_url": "apihandyman.io"
                            }
                        ]
                    },
                    "description": {
                        "urls": [
                            {
                                "start": 80,
                                "end": 103,
                                "url": "https://t.co/MARf81Unhv",
                                "expanded_url": "http://bit.ly/designwebapis",
                                "display_url": "bit.ly/designwebapis"
                            }
                        ],
                        "mentions": [
                            {
                                "start": 34,
                                "end": 45,
                                "username": "getpostman"
                            },
                            {
                                "start": 116,
                                "end": 129,
                                "username": "apistylebook"
                            }
                        ]
                    }
                },
                "verified": false,
                "username": "apihandyman",
                "url": "https://t.co/iwBBREWUJM",
                "description": "Arnaud Lauret, doing API stuff at @getpostman, Author of The Design of Web APIs https://t.co/MARf81Unhv. Creator of @apistylebook. Not a very good plumber."
            }
        ]
    }
}`
{% endcode %}

# Get always same data
And it's not finished yet! You get a final Postman bonus. Why not put the list of Twitter API query parameters values you'll always use in collection variables to ensure consistency between your requests? It will allow you to modify all requests from a single place. You'll find the "default allowed values" for all query parameters in the collection variables. The following requests take advantage of them. Warning, I didn't put again the Pre-request scripts checking the consistency between `expansions` and `xxx.fields`. But I think it could be worth have it at collection level.
## Get a tweet always with same data

So both operations share the same parameters with the same value and the same behavior. That means we can trust the Twitter API and apply patterns seen on an operation on others related ones. A behavior to reproduce on all your APIs.

### Request and response
{% code title:Request language:http %}
https://api.twitter.com/2/tweets/{{tweet_id}}?expansions={{expansions_default_value}}
&tweet.fields={{tweet_fields_default_value}}
&media.fields={{media_fields_default_value}}
&poll.fields={{poll_fields_default_value}}
&place.fields={{place_fields_default_value}}
&user.fields={{user_fields_default_value}}
{% endcode %}

{% code title:Response language:json %}
{
    "data": {
        "conversation_id": "1387820661742112771",
        "lang": "ja",
        "context_annotations": [
            {
                "domain": {
                    "id": "30",
                    "name": "Entities [Entity Service]",
                    "description": "Entity Service top level domain, every item that is in Entity Service should be in this domain"
                },
                "entity": {
                    "id": "848920371311001600",
                    "name": "Technology",
                    "description": "Technology and computing"
                }
            },
            {
                "domain": {
                    "id": "66",
                    "name": "Interests and Hobbies Category",
                    "description": "A grouping of interests and hobbies entities, like Novelty Food or Destinations"
                },
                "entity": {
                    "id": "848921413196984320",
                    "name": "Computer programming",
                    "description": "Computer programming"
                }
            },
            {
                "domain": {
                    "id": "66",
                    "name": "Interests and Hobbies Category",
                    "description": "A grouping of interests and hobbies entities, like Novelty Food or Destinations"
                },
                "entity": {
                    "id": "849075668352499712",
                    "name": "Web design",
                    "description": "Web design"
                }
            }
        ],
        "text": "Want to learn how to design Web APIs? You should read my book:\n\n- The Design of Web APIs https://t.co/jocUbds6ki\n- Web APIの設計 https://t.co/2Qlkqtjd5c\n- 웹 API 디자인 https://t.co/ZQP0pYSzOm\n- ПРОЕКТИРОВАНИЕ ВЕБ-API https://t.co/oH0OXxB62D\n\n#apidesign #api https://t.co/qWNBAfzaLp",
        "reply_settings": "everyone",
        "author_id": "2943613557",
        "id": "1387820661742112771",
        "created_at": "2021-04-29T17:26:44.000Z",
        "source": "Twitter for Mac",
        "attachments": {
            "media_keys": [
                "3_1387820658030170113",
                "3_1387820658030170124",
                "3_1387820658097336320",
                "3_1387820658076303365"
            ]
        },
        "public_metrics": {
            "retweet_count": 7,
            "reply_count": 2,
            "like_count": 30,
            "quote_count": 4
        },
        "entities": {
            "urls": [
                {
                    "start": 89,
                    "end": 112,
                    "url": "https://t.co/jocUbds6ki",
                    "expanded_url": "https://www.manning.com/books/the-design-of-web-apis?a_aid=everyday_apis&a_bid=ad5a0fe0",
                    "display_url": "manning.com/books/the-desi…",
                    "images": [
                        {
                            "url": "https://pbs.twimg.com/news_img/1507656545223512065/9kT4sodO?format=jpg&name=orig",
                            "width": 360,
                            "height": 451
                        },
                        {
                            "url": "https://pbs.twimg.com/news_img/1507656545223512065/9kT4sodO?format=jpg&name=150x150",
                            "width": 150,
                            "height": 150
                        }
                    ],
                    "status": 200,
                    "title": "The Design of Web APIs",
                    "description": "The Design of Web APIs is a practical, example-packed guide to crafting extraordinary web APIs. Author Arnaud Lauret demonstrates fantastic design principles and techniques you can apply to both public and private web APIs.",
                    "unwound_url": "https://www.manning.com/books/the-design-of-web-apis?a_aid=everyday_apis&a_bid=ad5a0fe0"
                },
                {
                    "start": 126,
                    "end": 149,
                    "url": "https://t.co/2Qlkqtjd5c",
                    "expanded_url": "https://www.shoeisha.co.jp/book/detail/9784798167015",
                    "display_url": "shoeisha.co.jp/book/detail/97…",
                    "status": 200,
                    "unwound_url": "https://www.shoeisha.co.jp/book/detail/9784798167015"
                },
                {
                    "start": 162,
                    "end": 185,
                    "url": "https://t.co/ZQP0pYSzOm",
                    "expanded_url": "http://www.kyobobook.co.kr/product/detailViewKor.laf?ejkGb=KOR&mallGb=KOR&barcode=9788931463224&orderClick=LEa&Kc=",
                    "display_url": "kyobobook.co.kr/product/detail…",
                    "status": 200,
                    "unwound_url": "http://www.kyobobook.co.kr/product/detailViewKor.laf?ejkGb=KOR&mallGb=KOR&barcode=9788931463224&orderClick=LEa&Kc="
                },
                {
                    "start": 211,
                    "end": 234,
                    "url": "https://t.co/oH0OXxB62D",
                    "expanded_url": "https://dmkpress.com/catalog/computer/web/978-5-97060-861-6/",
                    "display_url": "dmkpress.com/catalog/comput…",
                    "status": 200,
                    "unwound_url": "https://dmkpress.com/catalog/computer/web/978-5-97060-861-6/"
                },
                {
                    "start": 252,
                    "end": 275,
                    "url": "https://t.co/qWNBAfzaLp",
                    "expanded_url": "https://twitter.com/apihandyman/status/1387820661742112771/photo/1",
                    "display_url": "pic.twitter.com/qWNBAfzaLp"
                },
                {
                    "start": 252,
                    "end": 275,
                    "url": "https://t.co/qWNBAfzaLp",
                    "expanded_url": "https://twitter.com/apihandyman/status/1387820661742112771/photo/1",
                    "display_url": "pic.twitter.com/qWNBAfzaLp"
                },
                {
                    "start": 252,
                    "end": 275,
                    "url": "https://t.co/qWNBAfzaLp",
                    "expanded_url": "https://twitter.com/apihandyman/status/1387820661742112771/photo/1",
                    "display_url": "pic.twitter.com/qWNBAfzaLp"
                },
                {
                    "start": 252,
                    "end": 275,
                    "url": "https://t.co/qWNBAfzaLp",
                    "expanded_url": "https://twitter.com/apihandyman/status/1387820661742112771/photo/1",
                    "display_url": "pic.twitter.com/qWNBAfzaLp"
                }
            ],
            "hashtags": [
                {
                    "start": 236,
                    "end": 246,
                    "tag": "apidesign"
                },
                {
                    "start": 247,
                    "end": 251,
                    "tag": "api"
                }
            ]
        },
        "possibly_sensitive": false
    },
    "includes": {
        "media": [
            {
                "type": "photo",
                "width": 264,
                "url": "https://pbs.twimg.com/media/E0KHiRXWUAE6ua-.jpg",
                "media_key": "3_1387820658030170113",
                "height": 331
            },
            {
                "type": "photo",
                "width": 240,
                "url": "https://pbs.twimg.com/media/E0KHiRXWUAw6fjs.jpg",
                "media_key": "3_1387820658030170124",
                "height": 303
            },
            {
                "type": "photo",
                "width": 563,
                "url": "https://pbs.twimg.com/media/E0KHiRnXMAAVKwT.jpg",
                "media_key": "3_1387820658097336320",
                "height": 704
            },
            {
                "type": "photo",
                "width": 270,
                "url": "https://pbs.twimg.com/media/E0KHiRiWQAU0kLd.jpg",
                "media_key": "3_1387820658076303365",
                "height": 369
            }
        ],
        "users": [
            {
                "location": "Paris, France",
                "created_at": "2014-12-27T11:25:37.000Z",
                "id": "2943613557",
                "verified": false,
                "description": "Arnaud Lauret, doing API stuff at @getpostman, Author of The Design of Web APIs https://t.co/MARf81Unhv. Creator of @apistylebook. Not a very good plumber.",
                "entities": {
                    "url": {
                        "urls": [
                            {
                                "start": 0,
                                "end": 23,
                                "url": "https://t.co/iwBBREWUJM",
                                "expanded_url": "https://apihandyman.io/",
                                "display_url": "apihandyman.io"
                            }
                        ]
                    },
                    "description": {
                        "urls": [
                            {
                                "start": 80,
                                "end": 103,
                                "url": "https://t.co/MARf81Unhv",
                                "expanded_url": "http://bit.ly/designwebapis",
                                "display_url": "bit.ly/designwebapis"
                            }
                        ],
                        "mentions": [
                            {
                                "start": 34,
                                "end": 45,
                                "username": "getpostman"
                            },
                            {
                                "start": 116,
                                "end": 129,
                                "username": "apistylebook"
                            }
                        ]
                    }
                },
                "protected": false,
                "pinned_tweet_id": "1387820661742112771",
                "public_metrics": {
                    "followers_count": 5140,
                    "following_count": 946,
                    "tweet_count": 9726,
                    "listed_count": 224
                },
                "username": "apihandyman",
                "name": "API Handyman",
                "url": "https://t.co/iwBBREWUJM",
                "profile_image_url": "https://pbs.twimg.com/profile_images/966654273097490432/WPqaXZkf_normal.jpg"
            }
        ]
    }
}`
{% endcode %}

## Get tweets always with same data

So both operations share the same parameters with the same value and the same behavior. That means we can trust the Twitter API and apply patterns seen on an operation on others related ones. A behavior to reproduce on all your APIs.

### Request and response
{% code title:Request language:http %}
https://api.twitter.com/2/tweets?ids={{tweet_id}}
&expansions={{expansions_default_value}}
&tweet.fields={{tweet_fields_default_value}}
&media.fields={{media_fields_default_value}}
&poll.fields={{poll_fields_default_value}}
&place.fields={{place_fields_default_value}}
&user.fields={{user_fields_default_value}}
{% endcode %}

{% code title:Response language:json %}
{
    "data": [
        {
            "public_metrics": {
                "retweet_count": 7,
                "reply_count": 2,
                "like_count": 30,
                "quote_count": 4
            },
            "id": "1387820661742112771",
            "source": "Twitter for Mac",
            "lang": "ja",
            "entities": {
                "hashtags": [
                    {
                        "start": 236,
                        "end": 246,
                        "tag": "apidesign"
                    },
                    {
                        "start": 247,
                        "end": 251,
                        "tag": "api"
                    }
                ],
                "urls": [
                    {
                        "start": 89,
                        "end": 112,
                        "url": "https://t.co/jocUbds6ki",
                        "expanded_url": "https://www.manning.com/books/the-design-of-web-apis?a_aid=everyday_apis&a_bid=ad5a0fe0",
                        "display_url": "manning.com/books/the-desi…",
                        "images": [
                            {
                                "url": "https://pbs.twimg.com/news_img/1507656545223512065/9kT4sodO?format=jpg&name=orig",
                                "width": 360,
                                "height": 451
                            },
                            {
                                "url": "https://pbs.twimg.com/news_img/1507656545223512065/9kT4sodO?format=jpg&name=150x150",
                                "width": 150,
                                "height": 150
                            }
                        ],
                        "status": 200,
                        "title": "The Design of Web APIs",
                        "description": "The Design of Web APIs is a practical, example-packed guide to crafting extraordinary web APIs. Author Arnaud Lauret demonstrates fantastic design principles and techniques you can apply to both public and private web APIs.",
                        "unwound_url": "https://www.manning.com/books/the-design-of-web-apis?a_aid=everyday_apis&a_bid=ad5a0fe0"
                    },
                    {
                        "start": 126,
                        "end": 149,
                        "url": "https://t.co/2Qlkqtjd5c",
                        "expanded_url": "https://www.shoeisha.co.jp/book/detail/9784798167015",
                        "display_url": "shoeisha.co.jp/book/detail/97…",
                        "status": 200,
                        "unwound_url": "https://www.shoeisha.co.jp/book/detail/9784798167015"
                    },
                    {
                        "start": 162,
                        "end": 185,
                        "url": "https://t.co/ZQP0pYSzOm",
                        "expanded_url": "http://www.kyobobook.co.kr/product/detailViewKor.laf?ejkGb=KOR&mallGb=KOR&barcode=9788931463224&orderClick=LEa&Kc=",
                        "display_url": "kyobobook.co.kr/product/detail…",
                        "status": 200,
                        "unwound_url": "http://www.kyobobook.co.kr/product/detailViewKor.laf?ejkGb=KOR&mallGb=KOR&barcode=9788931463224&orderClick=LEa&Kc="
                    },
                    {
                        "start": 211,
                        "end": 234,
                        "url": "https://t.co/oH0OXxB62D",
                        "expanded_url": "https://dmkpress.com/catalog/computer/web/978-5-97060-861-6/",
                        "display_url": "dmkpress.com/catalog/comput…",
                        "status": 200,
                        "unwound_url": "https://dmkpress.com/catalog/computer/web/978-5-97060-861-6/"
                    },
                    {
                        "start": 252,
                        "end": 275,
                        "url": "https://t.co/qWNBAfzaLp",
                        "expanded_url": "https://twitter.com/apihandyman/status/1387820661742112771/photo/1",
                        "display_url": "pic.twitter.com/qWNBAfzaLp"
                    },
                    {
                        "start": 252,
                        "end": 275,
                        "url": "https://t.co/qWNBAfzaLp",
                        "expanded_url": "https://twitter.com/apihandyman/status/1387820661742112771/photo/1",
                        "display_url": "pic.twitter.com/qWNBAfzaLp"
                    },
                    {
                        "start": 252,
                        "end": 275,
                        "url": "https://t.co/qWNBAfzaLp",
                        "expanded_url": "https://twitter.com/apihandyman/status/1387820661742112771/photo/1",
                        "display_url": "pic.twitter.com/qWNBAfzaLp"
                    },
                    {
                        "start": 252,
                        "end": 275,
                        "url": "https://t.co/qWNBAfzaLp",
                        "expanded_url": "https://twitter.com/apihandyman/status/1387820661742112771/photo/1",
                        "display_url": "pic.twitter.com/qWNBAfzaLp"
                    }
                ]
            },
            "created_at": "2021-04-29T17:26:44.000Z",
            "text": "Want to learn how to design Web APIs? You should read my book:\n\n- The Design of Web APIs https://t.co/jocUbds6ki\n- Web APIの設計 https://t.co/2Qlkqtjd5c\n- 웹 API 디자인 https://t.co/ZQP0pYSzOm\n- ПРОЕКТИРОВАНИЕ ВЕБ-API https://t.co/oH0OXxB62D\n\n#apidesign #api https://t.co/qWNBAfzaLp",
            "context_annotations": [
                {
                    "domain": {
                        "id": "30",
                        "name": "Entities [Entity Service]",
                        "description": "Entity Service top level domain, every item that is in Entity Service should be in this domain"
                    },
                    "entity": {
                        "id": "848920371311001600",
                        "name": "Technology",
                        "description": "Technology and computing"
                    }
                },
                {
                    "domain": {
                        "id": "66",
                        "name": "Interests and Hobbies Category",
                        "description": "A grouping of interests and hobbies entities, like Novelty Food or Destinations"
                    },
                    "entity": {
                        "id": "848921413196984320",
                        "name": "Computer programming",
                        "description": "Computer programming"
                    }
                },
                {
                    "domain": {
                        "id": "66",
                        "name": "Interests and Hobbies Category",
                        "description": "A grouping of interests and hobbies entities, like Novelty Food or Destinations"
                    },
                    "entity": {
                        "id": "849075668352499712",
                        "name": "Web design",
                        "description": "Web design"
                    }
                }
            ],
            "author_id": "2943613557",
            "attachments": {
                "media_keys": [
                    "3_1387820658030170113",
                    "3_1387820658030170124",
                    "3_1387820658097336320",
                    "3_1387820658076303365"
                ]
            },
            "conversation_id": "1387820661742112771",
            "possibly_sensitive": false,
            "reply_settings": "everyone"
        }
    ],
    "includes": {
        "media": [
            {
                "width": 264,
                "url": "https://pbs.twimg.com/media/E0KHiRXWUAE6ua-.jpg",
                "height": 331,
                "media_key": "3_1387820658030170113",
                "type": "photo"
            },
            {
                "width": 240,
                "url": "https://pbs.twimg.com/media/E0KHiRXWUAw6fjs.jpg",
                "height": 303,
                "media_key": "3_1387820658030170124",
                "type": "photo"
            },
            {
                "width": 563,
                "url": "https://pbs.twimg.com/media/E0KHiRnXMAAVKwT.jpg",
                "height": 704,
                "media_key": "3_1387820658097336320",
                "type": "photo"
            },
            {
                "width": 270,
                "url": "https://pbs.twimg.com/media/E0KHiRiWQAU0kLd.jpg",
                "height": 369,
                "media_key": "3_1387820658076303365",
                "type": "photo"
            }
        ],
        "users": [
            {
                "entities": {
                    "url": {
                        "urls": [
                            {
                                "start": 0,
                                "end": 23,
                                "url": "https://t.co/iwBBREWUJM",
                                "expanded_url": "https://apihandyman.io/",
                                "display_url": "apihandyman.io"
                            }
                        ]
                    },
                    "description": {
                        "urls": [
                            {
                                "start": 80,
                                "end": 103,
                                "url": "https://t.co/MARf81Unhv",
                                "expanded_url": "http://bit.ly/designwebapis",
                                "display_url": "bit.ly/designwebapis"
                            }
                        ],
                        "mentions": [
                            {
                                "start": 34,
                                "end": 45,
                                "username": "getpostman"
                            },
                            {
                                "start": 116,
                                "end": 129,
                                "username": "apistylebook"
                            }
                        ]
                    }
                },
                "description": "Arnaud Lauret, doing API stuff at @getpostman, Author of The Design of Web APIs https://t.co/MARf81Unhv. Creator of @apistylebook. Not a very good plumber.",
                "profile_image_url": "https://pbs.twimg.com/profile_images/966654273097490432/WPqaXZkf_normal.jpg",
                "id": "2943613557",
                "name": "API Handyman",
                "public_metrics": {
                    "followers_count": 5140,
                    "following_count": 946,
                    "tweet_count": 9726,
                    "listed_count": 224
                },
                "verified": false,
                "username": "apihandyman",
                "created_at": "2014-12-27T11:25:37.000Z",
                "protected": false,
                "location": "Paris, France",
                "url": "https://t.co/iwBBREWUJM",
                "pinned_tweet_id": "1387820661742112771"
            }
        ]
    }
}`
{% endcode %}

# Lessons learned
You should now master the Twitter v2 API Tweets lookup parameters and be able to reuse the method shown on any other API operations. And on top of that, you may have discovered the following principles regarding the design, implementation, and documentation of APIs:

*   Returning detailed error information is a must-have. It helps to learn how to use an API and quickly fix problems. Remember how it was simple to discover how to use the API when providing a dummy parameter or an existing parameter with a dummy value.
*   Don't return too much detailed error information that can't be used or warned they can't be used without an action. It can help to avoid unnecessary errors and ease understanding. We could have avoided an error when putting all values of `xxx.fields` including the not allowed ones.
*   Try to create APIs with consistent behavior. Here the query parameter `ids` gets a special treatment allowing to get `errors` info in case of success that `expansions` and `xxx.fields` don't have causing some headaches. If I had to choose, I would prefer more info on the second case.
*   Document the relationships between parameters. Here, it's not shown in error feedback but at least the relationship `expansions` and `xxx.fields` is well documented.
*   Don't deviate from HTTP. Getting a `200 OK` when a path is not found is surprising and source of errors in consumers' code. Note that it's probably a bug.
*   When a function does not behave as people would expect, never refrain to explain it in the documentation and put the link(s) to the other function(s) covering other expected needs. Here the Tweets Lookup documentation could be improved by adding some info about the search function.

