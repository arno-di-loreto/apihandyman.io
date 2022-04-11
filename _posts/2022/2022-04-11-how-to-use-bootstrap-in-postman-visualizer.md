---
title: How to use Bootstrap in Postman Visualizer
date: 2022-04-11
series: Postman Tips and Tricks
author: Arnaud Lauret
layout: post
permalink: /how-to-use-bootstrap-in-postman-visualizer/
category: post
postman_workspace: Postman Tips and Tricks
postman_workspace_url: https://www.postman.com/apihandyman/workspace/postman-tips-and-tricks/overview
postman_collection_documentation: https://www.postman.com/apihandyman/workspace/postman-tips-and-tricks/documentation/143378-0c503013-a7a9-4374-bdc2-7307ae777740
postman_collection_run: https://god.gw.postman.com/run-collection/143378-0c503013-a7a9-4374-bdc2-7307ae777740?action=collection%2Ffork&collection-url=entityId%3D143378-0c503013-a7a9-4374-bdc2-7307ae777740%26entityType%3Dcollection
postman_collection_github: https://github.com/apihandyman/postman-tips-and-tricks/tree/main/use-bootstrap-in-visualizer
tools:
  - Postman
---
Postman Visualizer is perfect to tinker with data returned by an API and learn how it works. I found using [HandlebarJS](https://handlebarsjs.com/) HTML templates quite convenient. But I was mindblown when I realized I could take advantage of [Bootstrap](https://getbootstrap.com/) to generate outstanding visualization without much effort. Let's see that with [The 5th Edition Dungeons and Dragons API](https://www.dnd5eapi.co/) in its [GraphQL](https://www.dnd5eapi.co/docs/#overview--graphql) version.
<!--more-->
{% include _postincludes/postman-tips-and-tricks.md %}

# Use vizualiser

With this first request, we'll discover the Dnd GraphQL API by retrieving a list of magic items and how to set up a "standard" visualizer to show them in a simple HTML table.




## Use visualizer with pure HTML

The request body contains a GraphQL query requesting "the name, desc(ription) and rarity name of all magic items". We'll use the exact same query for all requests. Note that I do not recommend using abbreviations in property names (or whatever names) when designing APIs. Abbreviations make APIs harder to use. In that case, it looks really awkward because it seems there are no other abbreviations used in the entire API, all names are cristal clear full names. And yes, spotting the only "mistake" in an otherwise well-designed API is my super-power (or my curse 😅). Hopefully, as Postman loads the GraphQL schema, it proposed me "desc" when I started to type "des(cription)" in my query. (But that's not a reason to underestimate the importance of design for GraphQL APIs.)  



{% capture body %}
{
    magicItems {
        name
        desc
        rarity {
            name
        }
    }
}
{% endcapture %}
{% include api-request.html title="Request" method="POST" url="https://www.dnd5eapi.co/graphql" body=body language="graphql" %}



Ok, this digression on design aside, according to how GraphQL works and to the [documentation](https://www.dnd5eapi.co/docs/#get-/api/magic-items/-index-), that means we'll get a list of objects `data.magicItems` containing a string `name`, an array of string `desc`, and an object `rarity` containing a string `name`.



{% code language:"json" title:"Response" %}
{
    "data": {
        "magicItems": [
            {
                "name": "Ammunition, +1, +2, or +3",
                "desc": [
                    "Weapon (any ammunition), uncommon (+1), rare (+2), or very rare (+3)",
                    "You have a bonus to attack and damage rolls made with this piece of magic ammunition. The bonus is determined by the rarity of the ammunition. Once it hits a target, the ammunition is no longer magical."
                ],
                "rarity": {
                    "name": "Varies"
                }
            },
            {
                "name": "Adamantine Armor",
                "desc": [
                    "Armor (medium or heavy, but not hide), uncommon",
                    "This suit of armor is reinforced with adamantine, one of the hardest substances in existence. While you're wearing it, any critical hit against you becomes a normal hit."
                ],
                "rarity": {
                    "name": "Uncommon"
                }
            }
        ]
    }
}
{% endcode %}



The visualization magic stands in the Test script. It defines a basic [HandlebarJS](https://handlebarsjs.com/) template and then passes it to the Postman visualizer along with the data to use (the list of magic items). The template contains an HTML table with an `{% raw %}{{#each}}{% endraw %}` loop on its rows. On each row, we have the name, rarity name, and the first line of description of each magic item. 



{% code language:"js" title:"Test script" highlight:"1,3,14,26" %}
{% raw %}
const handlebarData = pm.response.json().data.magicItems;

const handlebarTemplate = `
    <h1>DnD Magic Items</h1>
    <table>
    <thead>
        <tr>
            <th scope="col">Name</th>
            <th scope="col">Rarity</th>
            <th scope="col">Description</th>
        </tr>
    </thead>
    <tbody>
        {{#each .}}
        <tr>
            <th scope="row">{{name}}</th>
            <td>{{rarity.name}}</td>
            <td>{{desc.[0]}}</td>
        </tr>
        {{/each}}
    </tbody>
    </table>
`;

// Set visualizer
pm.visualizer.set(handlebarTemplate, handlebarData);
{% endraw %}
{% endcode %}



After sending the request, the HTML result is visible by clicking on the "Visualize" button in the response's "Body" tab.

{% include image.html source="use-bootstrap-in-visualizer-1.png" %}

# Add Bootstratp to template

By default, the visualization is already easier to read than the JSON data. But let's add Bootstrap JS and CSS to have better styling.




## Add Bootstrap JS and CSS

Adding Bootstrap to the template only requires adding the link to CSS and JS (found in [Boostrap Quick Start](https://getbootstrap.com/docs/5.1/getting-started/introduction/#quick-start)) at the beginning of our template in the Test script of our request.



{% code language:"js" title:"Test script" highlight:"4-6" %}
{% raw %}
const handlebarData = pm.response.json().data.magicItems;

const handlebarTemplate = `
    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@latest/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@latest/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
    <!-- Content -->
    <h1>DnD Magic Items</h1>
    <table>
    <thead>
        <tr>
            <th scope="col">Name</th>
            <th scope="col">Rarity</th>
            <th scope="col">Description</th>
        </tr>
    </thead>
    <tbody>
        {{#each .}}
        <tr>
            <th scope="row">{{name}}</th>
            <td>{{rarity.name}}</td>
            <td>{{desc.[0]}}</td>
        </tr>
        {{/each}}
    </tbody>
    </table>
`;

// Set visualizer
pm.visualizer.set(handlebarTemplate, handlebarData);
{% endraw %}
{% endcode %}



{% include image.html source="use-bootstrap-in-visualizer-2.png" %}



## Style table and fix font size

Unfortunately, the table is not totally styled the Boostrap way and the font is rather small. Let's fix that by:

*   Adding a `div` with a `font-style: larger` style around the header and table
*   Adding the `table` class to the table
    


{% code language:"js" title:"Test script" highlight:"8,10" %}
{% raw %}
const handlebarData = pm.response.json().data.magicItems;

const handlebarTemplate = `
    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@latest/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@latest/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
    <!-- Content -->
    <div style="font-size: larger;"> <!-- adding style to increase font size -->
        <h1>DnD Magic Items</h1>
        <table class="table"> <!-- Adding table css class to get Bootstrap styling -->
        <thead>
            <tr>
                <th scope="col">Name</th>
                <th scope="col">Rarity</th>
                <th scope="col">Description</th>
            </tr>
        </thead>
        <tbody>
            {{#each .}}
            <tr>
                <th scope="row">{{name}}</th>
                <td>{{rarity.name}}</td>
                <td>{{desc.[0]}}</td>
            </tr>
            {{/each}}
        </tbody>
        </table>
`;

// Set visualizer
pm.visualizer.set(handlebarTemplate, handlebarData);
{% endraw %}
{% endcode %}



{% include image.html source="use-bootstrap-in-visualizer-3.png" %}



## Use more Boostrap features (and beyond)

And once Boostrap is in place the only limit is your imagination. And if you added Bootstrap CSS and JS imagine what other things you could include.

The template has been modified as follows:

*   The [table header is dark](https://getbootstrap.com/docs/5.1/content/tables/#variants) and sticky (thanks to some custom CSS)
*   The [table has striped rows](https://getbootstrap.com/docs/5.1/content/tables/#striped-rows)
*   Rarity is a [badge](https://getbootstrap.com/docs/5.1/components/badge/) whose color depends on rarity value (thanks to HandlebarJS `{% raw %}{{lookup}}{% endraw %}` helper)
    


{% code language:"js" title:"Test script" highlight:"1-10,21-25,30,31" %}
{% raw %}
// Defining which Bootstrap color apply on rarity badge
const rarityColors = {
    Varies: "bg-light text-danger",
    Common: "bg-secondary",
    Uncommon: "bg-primary",
    Rare: "bg-success",
    "Very Rare": "bg-info",
    Legendary: "bg-warning",
    Artifact: "bg-danger", 
}
// Handlebar data now holds the list of magic items and rarity colors
const handlebarData = {
    data: pm.response.json().data.magicItems,
    rarityColors: rarityColors
}
const handlebarTemplate = `
    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@latest/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@latest/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
    <!-- Why not using some custom css? -->
    <style>
        .sticky{
            position:sticky;
            top: 0 ;
        }
    </style>
    <!-- Content -->
    <div style="font-size: larger;">
        <h1>DnD Magic Items</h1>
        <table class="table table-striped table-hover"> <!-- Striped table -->
        <thead class="table-dark sticky"> <!-- Sticky (custom css) Dark header (Bootstrap) -->
            <tr>
                <th scope="col">Magic Item Name</th>
                <th scope="col">Rarity</th>
                <th scope="col">Description</th>
            </tr>
        </thead>
        <tbody>
            {{#each data}}
            <tr>
                <th scope="row">{{name}}</th>
                <!-- Rarity badge color changes depending on its value -->
                <td><span class="badge rounded-pill {{lookup ../rarityColors rarity.name}}">{{rarity.name}}</span></td>
                <td>{{desc.[0]}}</td>
            </tr>
            {{/each}}
        </tbody>
        </table>
`;

// Set visualizer
pm.visualizer.set(handlebarTemplate, handlebarData);
{% endraw %}
{% endcode %}



{% include image.html source="use-bootstrap-in-visualizer-4.png" %}



# Take advantage of variables

In order to avoid redefining custom, Bootstrap, or other CSS and JS for each template, you can take advantage of a collection variable to store them.




## Add Bootstrap JS and CSS using a variable

Here, the Bootstrap CSS and JS, and custom style tag have been put in the `cssjs` collection variable.



{% code title:"Collection variable <code>cssjs</code> value" language:"html" %}
    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@latest/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@latest/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
    <!-- Why not using some custom css? -->
    <style>
        .sticky{
            position:sticky;
            top: 0 ;
        }
    </style>
{% endcode %}



It is then loaded by `pm.collectionVariable("cssjs")` in the Test script and passed to the HandlebarJS template and used like any other data.



{% code language:"js" title:"Test script" highlight:"17,20" %}
{% raw %}
// Defining which Bootstrap color apply on rarity badge
const rarityColors = {
    Varies: "bg-light text-danger",
    Common: "bg-secondary",
    Uncommon: "bg-primary",
    Rare: "bg-success",
    "Very Rare": "bg-info",
    Legendary: "bg-warning",
    Artifact: "bg-danger", 
}
// Handlebar data now holds the list of magic items and rarity colors
const handlebarData = {
    data: pm.response.json().data.magicItems,
    rarityColors: rarityColors,
    // Now bootstrap and custom css are store in a variable
    // That way, they can easilty reused
    cssjs: pm.collectionVariables.get("cssjs"), 
}
const handlebarTemplate = `
    {{{cssjs}}}
    <!-- Content -->
    <div style="font-size: larger;">
        <h1>DnD Magic Items</h1>
        <table class="table table-striped table-hover">
        <thead class="table-dark sticky">
            <tr>
                <th scope="col">Magic Item Name</th>
                <th scope="col">Rarity</th>
                <th scope="col">Description</th>
            </tr>
        </thead>
        <tbody>
            {{#each data}}
            <tr>
                <th scope="row">{{name}}</th>
                <td><span class="badge rounded-pill {{lookup ../rarityColors rarity.name}}">{{rarity.name}}</span></td>
                <td>{{desc.[0]}}</td>
            </tr>
            {{/each}}
        </tbody>
        </table>
`;

// Set visualizer
pm.visualizer.set(handlebarTemplate, handlebarData);
{% endraw %}
{% endcode %}


              
            
          