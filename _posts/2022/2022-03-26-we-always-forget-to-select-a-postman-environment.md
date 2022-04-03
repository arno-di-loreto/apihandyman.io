---
title: We always forget to select a Postman environment
date: 2022-03-26
author: Arnaud Lauret
layout: post
permalink: /we-always-forget-to-select-a-postman-environment/
category: post
postman_collection_documentation: https://www.postman.com/apihandyman/workspace/postman-tips-and-tricks/documentation/143378-215afe9b-9b7d-459d-b020-361dbf1c5bf4
postman_collection_run: https://www.postman.com/apihandyman/workspace/postman-tips-and-tricks/documentation/143378-215afe9b-9b7d-459d-b020-361dbf1c5bf4
postman_collection_github: https://github.com/apihandyman/postman-tips-and-tricks/tree/main/dont-forget-to-select-an-environment
tools:
  - Postman
---

When using Postman, it's a best practice to store API token values in environment secret variables.
Environment variables can also be used to store other variables uses in scripts.
But when opening a collection, we often forget to select an environment and spend a few seconds if not minutes or more trying to figure out what the problem is with a request. Just to realize in the end that we just forgot to select an environment.
How can this be avoided?
<!--more-->

{% include _postincludes/postman-tips-and-tricks.md %}

This post demonstrates how to take advantage of `pm.environment.name` in Pre-Scripts to prevent sending a request and have a clear error message when an environment is not selected. The use case that will be used to demonstrate all that is retrieving a tweet with Twitter v2 API. The aim of this collection being error handling, you'll need to have an actual access to Twitter v2 API only if you want to make the request succeed.

# How it works

The magic is mostly handled in the Pre-request script regarding checking an environment is selected. But what happens there allows to have more precise error message on 401 errors in Test script.

## Collection Pre-request Script

{% code language:"javascript" title:"Pre-request Script"%}
/*******************************************/
/*  Checks a valid environment containing  */
/*  a specific variable used as bearer     */
/*  token is selected                      */
/*******************************************/

/* The name and default value of the variable used in Authorization
   and checked here is defined at collection level.
   That way, this code snippet can be easily copied to other
   collections */
const tokenVariableName = pm.collectionVariables.get("token_variable_name");
const tokenVariableDefaultValue = pm.collectionVariables.get("token_variable_default_value");
// The message indicating how to solve the problem
let message;
// Get selected environment name (undefined if none is selected)
const selectedEnvironment = pm.environment.name;
// Get token environment variable value (undefined if none exists or if current value is empty) 
const tokenVariableValue = pm.environment.get(tokenVariableName);

if(selectedEnvironment === undefined) {
    message = `No environment containing a ${tokenVariableName} variable has been selected`;
}
else if(tokenVariableValue === undefined) {
    message = `Selected environment (${selectedEnvironment}) does not contain a ${tokenVariableName} variable`;
}
else if(tokenVariableValue.length === 0) {
    message = `Selected environment (${selectedEnvironment}) contains a ${tokenVariableName} variable but its current value is empty`;
}
else if(tokenVariableValue === tokenVariableDefaultValue) {
    message = `Selected environment (${selectedEnvironment}) contains a ${tokenVariableName} variable but its current value is the default one (${tokenVariableDefaultValue})`;
}

if(message) {
    throw new Error(message);
}
{% endcode %}

The collection level Pre-Request script checks that an environment is selected by verifying the value of `pm.environment.name` .

It also checks a specific variable is defined and has a correct value. The name of that variable is defined in the `token_variable_name` collection variable. The script also verifies the the variable has a value and that value is not the default one.

If there's anything wrong with one of the checks, the request is not sent and a red message explaining exactly what the problem is appears on screen thanks to `throw new Error(message)`.

## Collection Tests

{% code language:"javascript" title:"Test Script"%}
if(pm.response.code === 401) {
    const selectedEnvironment = pm.environment.name;
    const tokenVariableName = pm.collectionVariables.get("token_variable_name");
    const tokenVariableValue = pm.environment.get(tokenVariableName);
    const message = `Selected environment (${selectedEnvironment}) contains` +
                    `a ${tokenVariableName} variable but its value is` +
                    `probably not valid`;
    pm.test("Unauthorized request (401)", function() {
        pm.expect.fail(message);
    });
}
{% endcode %}

The collection level Tests script take for granted that the Pre-Request script has done its job. As there was an environment selected and it contains the expected variable which is not empty or does not have a default value, the test script can guess the token sent is invalid when receiving a 401 Unauthorized response.

## Collection variables

In order to make the code easily reusable across various collection, some collection variable are used:

| **VARIABLE** | **VALUE** | **DESCRIPTION** |
| --- | --- | --- |
| token_variable_name | twitter_token | The name of variable used in the token field in collection Authorization configuration. |
| token_variable_default_value | PUT_YOUR_TOKEN_IN_CURRENT_VALUE | The default value of the variable (hence, the one in INITIAL VALUE) |

## Environment variables

This collection requires the creation of an environment containing the following variables. This workspace comes with ready-to-use environment to test the various behaviors of the scripts (see Test cases below).

{% capture content %}
Never store API tokens in initial value. Read [How to use API Keys](https://blog.postman.com/how-to-use-api-keys/) to learn more.
{% endcapture %}
{% include alert.html content=content level="danger" %}

| **VARIABLE** | **TYPE** | **INITIAL VALUE** | **CURRENT VALUE** |
| --- | --- | --- | --- |
| twitter_token | secret | PUT_YOUR_TOKEN_IN_CURRENT_VALUE | A Twitter API bearer token (Read [Twitter API documentation](https://developer.twitter.com/en/docs/authentication/oauth-2-0/bearer-tokens) to get one) |

# Test cases

Use one of the following test cases to see the collection level Pre-Script and Tests scripts in action.

{% capture content %}
Note that you can make the environment drop list larger to see full environment names.
{% endcapture %}
{% include alert.html content=content level="info" %}

## No environment selected

![](https://apihandyman.io/postman-images/postman-tips-and-tricks/dont-forget-to-select-an-environment/use-case-0.png)

1.  Set environment drop list on "No Environment" (It's the default value when opening the collection)
2.  Send the `Get a tweet` request
    

## Empty environment

![](https://apihandyman.io/postman-images/postman-tips-and-tricks/dont-forget-to-select-an-environment/use-case-1.png)

1.  Create an environment (don't create any variable)
2.  Select the environment
3.  Send the `Get a tweet` request
    

## Wrong name

![](https://apihandyman.io/postman-images/postman-tips-and-tricks/dont-forget-to-select-an-environment/use-case-2.png)

1.  Create an environment
2.  Add a `twitter_tokenn` variable to your environment (yes, 2 n's, it does not match the `token_variable_name` collection variable value)
3.  Set INITIAL VALUE to `PUT_YOUR_TOKEN_IN_CURRENT_VALUE` (it matches `token_variable_default_value` collection variable value)
4.  Save the environment
5.  Select the environment
6.  Send the `Get a tweet` request
    

## Default value

![](https://apihandyman.io/postman-images/postman-tips-and-tricks/dont-forget-to-select-an-environment/use-case-3.png)

1.  Create an environment
2.  Add a `twitter_token` variable to your environment (it matches the `token_variable_name` collection variable value)
3.  Set INITIAL VALUE to `PUT_YOUR_TOKEN_IN_CURRENT_VALUE` (it matches `token_variable_default_value` collection variable value)
4.  Save the environment
5.  Select the environment
6.  Send the `Get a tweet` request
    

## Invalid token

![](https://apihandyman.io/postman-images/postman-tips-and-tricks/dont-forget-to-select-an-environment/use-case-4.png)

1.  Create an environment
2.  Add a `twitter_token` variable to your environment (it matches the `token_variable_name` collection variable value)
3.  Set INITIAL VALUE to `PUT_YOUR_TOKEN_IN_CURRENT_VALUE` (it matches `token_variable_default_value` collection variable value)
4.  Set CURRENT VALUE to `INVALID_TOKEN`
5.  Save the environment
6.  Select the environment
7.  Send the `Get a tweet` request
    

## Valid token

![](https://apihandyman.io/postman-images/postman-tips-and-tricks/dont-forget-to-select-an-environment/use-case-5.png)

1.  Read [Twitter API documentation](https://developer.twitter.com/en/docs/authentication/oauth-2-0/bearer-tokens) to get a bearer token
2.  Create an environment
3.  Add a `twitter_token` variable to your environment (it matches the `token_variable_name` collection variable value)
4.  Set INITIAL VALUE to `PUT_YOUR_TOKEN_IN_CURRENT_VALUE` (it matches `token_variable_default_value` collection variable value)
5.  Put the bearer token value in `twitter_token` variable current value (NOT the initial value!)
6.  Save the environment
7.  Select the environment
8.  Send the `Get a tweet` request