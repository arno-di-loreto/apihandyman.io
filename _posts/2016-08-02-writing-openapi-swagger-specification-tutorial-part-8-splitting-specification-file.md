---
id: 1172
title: Writing OpenAPI (Swagger) Specification Tutorial - Part 8 - Splitting specification file
date: 2016-08-02T19:45:17+00:00
author: Arnaud Lauret
layout: post
guid: http://apihandyman.io/?p=1172
permalink: /writing-openapi-swagger-specification-tutorial-part-8-splitting-specification-file/
dsq_thread_id:
  - 5034655247
category: posts
tags:
  - OpenAPI
  - Swagger
  - API Specification
  - Documentation
  - API First
series: Writing OpenAPI (Swagger) Specification Tutorial
series_title: Splitting specification file
series_number: 8
codefiles: writing-openapi-swagger-specification-tutorial
---
With [previous posts]((http://apihandyman.io/category/openapi-swagger-specification/)) we have learned to produce an [OpenAPI specification](https://openapis.org/) containing all OpenAPI specification subtleties. Some specification files may become quite large or may contain elements which could be reused in other APIs. Splitting a specification file will help to keep it maintainable by creating smaller files and also help to ensure consistency throughout APIs by sharing common elements.<!--more--> 

{% include _postincludes/writing-openapi-swagger-specification-tutorial.md %}

In previous parts we've learned to create highly accurate API description which can become quite large or may contain elements that can be reused, in this eighth part we'll learn how to split an OpenAPI specification file into smaller and reusable elements.

# JSON Pointers
In [part 3 - Simplifying spefication file](http://apihandyman.io/writing-openapi-swagger-specification-tutorial-part-3-simplifying-specification-file/) we have learned how to simplify the specification by creating reusable elements. In the example below, the `Person` definition is defined once in `definitions` and used as

- A body parameter in `POST /persons`
- A response schema in `GET /persons/{username}`
- A sub-elements in `Persons` definition
  
{% codefile file:simple_openapi_specification_06_with_definitions.yaml highlight:"65-74, 78, 60, 40" footer:false %}
  
To use the `Person` definition in these different places, we use a JSON Pointer (defined by [RFC6901](https://tools.ietf.org/html/rfc6901)):

{% codefile file:simple_openapi_specification_06_with_definitions.yaml lines:"78" footer:false %}

This pointer describes a path in the document, pointing to `Person` in `definitions` which is as the root (`#`) of the *current* document.
 
But JSON pointers are not only meant to point something *within* the current document, they can be used to reference something in *another* document.

# Basic splitting

Let's see how we can split the [file](https://gist.github.com/arno-di-loreto/5a3df2250721fb154060#file-simple_openapi_specification_06_with_definitions-yaml
) we created in part 3

## Referencing a local file

We can create a `person.yaml` file containing the `Person` definition:

{% codefile file:simple_openapi_specification_23_person.yaml  footer:false %}

Then we can remove the `Person` definition in `definitions` and replace all existing references to person `#definitions/Person` by a reference to `Person` in the `person.yaml` file:

{% codefile file:simple_openapi_specification_24_local_reference.yaml highlight:"40, 60, 68" footer:false %}

## Editing splitted local files with the online editor
Tools will look for the referenced file (`person.yaml`) in the same directory as the file containing the reference.
But when you use the [online editor](http://editor.swagger.io) it does not make sense, such local reference cannot be resolved.

{% img file:openapi8-editor-error.png %}

Fortunately the editor propose a configuration allowing to set a server to resolve these local references. This configuration is accessible in the *Preferences->Preferences* menu:

{% img file:openapi8-editor-preferences.png %}

The *Pointer Resolution Base Path* configuration is on the bottom of the configuration screen:

{% img file:openapi8-editor-preferences-pointer-original.png %}

All you need to do is put the referenced yaml files into a web server (with [CORS](https://en.wikipedia.org/wiki/Cross-origin_resource_sharing) activated) and modify the editor's configuration to point this server.

### http-server a lightweight web server
You can use [http-server](https://www.npmjs.com/package/http-server) a lightweight node.js web server:

{% code language:bash %}
npm install --global http-server
{% endcode %}

You now can start a web service on any folder:

{% code language:bash %}
http-server --cors path/to/yaml/folder
{% endcode %}

or

{% code language:bash %}
cd path/to/yaml/folder
http-server --cors .
{% endcode %}

By default, `http-server` listens on 8080 port, files will be accessble through `http://localhost:8080/<path to file within folder>`. 

The `--cors` flag is used to activate CORS directive and allow XHR request to this local webserver from the online editor page.
**Without** CORS activated, the editor will not be able to download files.

### Modifying online editor configuration
Once the web server is started you can modifiy the editor to set the URL to `http://localhost:8080/`:

{% img file:openapi8-editor-preferences-pointer-modified.png %}

Files referenced with `$ref: <filename>#/example` will be downloaded from  `http://localhost:8080/<filename>`.

Once this is done, you may need to do a force refresh (clean cache) of the editor's the page to get the green bar.

{% img file:openapi8-editor-noerror.png %}

### Cache

When you add a reference to a new file (that was not already reference), this new file may not be downloaded automatically resulting in errors (`Reference could not be resolved: newfile.yaml`). You may need to refresh the editor's page with cache cleaning to solve this error.

## Folders

You're under no obligation to put all sub-files on a "root" level, you can store them in differents sub-folders.

### Reference to a file in a folder

Let's move the `person.yaml` file into a sub-folder `folder`, the new reference will be like this:

{% codefile file:simple_openapi_specification_25_local_reference_folder.yaml lines:"40" footer:false %}

### File referencing a file from an upper folder
You can also reference a file outside the current folder. Let's create a `persons.yaml` file into a `another-folder` folder:

{% codefile file:simple_openapi_specification_26_persons.yaml footer:false %}

This file reference the `person.yaml` file using `..` to get to the upper level.

To use `persons.yaml`, we proceed just like with `person.yaml`. We remove the `Persons` definition from the main file and we replace its reference `#/definitions/Persons` by `another-folder/persons.yaml#Persons`.

Here's the full file with all definitions externalized (the `definitions` section has been removed):
{% codefile file:simple_openapi_specification_25_local_reference_folder.yaml highlight:"31,40,60" footer:false %}

## Referencing a remote files
As you may have guess while modifying the references in the specification and editor configuration, it is also possible to reference a remote file.

### Remote files
All we need to do is to put the full file's URL in the reference:

{% code language:yaml %}
$ref: https://myserver.com/mypath/myfile.yaml#/example
{% endcode %}

Remember that the server **MUST** have CORS activated to allow the editor to download the file.

We have launched a web server on 8080 port, so all we have to do is add `http://localhost:8080/` to the references to `Person`:

{% codefile file:simple_openapi_specification_27_remote_reference.yaml lines:"40" footer:false %}

### Remote files containing local references
What happen if the remote file reference a local file? (`Main file -> Remote file -> Local file`).

The parser will seek this "local" file on the remote server providing the remote file.

If we replace the local to `Persons` by a remote reference...

{% codefile file:simple_openapi_specification_27_remote_reference.yaml lines:"31" footer:false %}

... the `person.yaml` file referenced "locally" in the `persons.yaml` file will be loaded from `http://localhost:8080` which has served the `persons.yaml`. 

### Remote files containing remote references
If a remote file contains a remote reference (`Main file -> Remote file -> Remote file
`), it will be resolved like in *2.4.1 Remote files*.

We can replace the `person.yaml` file local reference by a remote reference in `persons.yaml`:

{% codefile file:simple_openapi_specification_28_persons_remote.yaml footer:false %}

## Multiple items in a single sub-file
We have put `Person` and `Persons` definitions in separate files: this is not an obligation. You can put more than one item in a single file, you only need to use the right JSON Pointer.

### Person and Person in a single file
If we concatenate `person.yaml` and `persons.yaml` into a single file called `definitions.yaml`:

{% codefile file:simple_openapi_specification_29_definitions.yaml highlight:"15" footer:false %}

Note that in `Persons` the reference to `Person` is now `#/Person`.

In the main file we only need to change the filename when reference these two definitions:

{% codefile file:simple_openapi_specification_30_subfile_multiple.yaml lines:"31" footer:false %}

{% codefile file:simple_openapi_specification_30_subfile_multiple.yaml lines:"40" footer:false %}

### Organizing content in a sub-file
Within the sub-file you can organize the content as you wish. Here `Person` is in `SomeDefinitions` and Persons is in `OtherDefinitions`:

{% codefile file:simple_openapi_specification_31_organized_definitions.yaml highlight:"1,13,17" footer:false %}

Note that in `Persons` the reference to `Person` is now `#/SomeDefinitions/Person`.

In the main file we have to modify the path to get the item in the sub-file for these two definitions:

{% codefile file:simple_openapi_specification_32_subfile_organized.yaml lines:"31" footer:false %}

{% codefile file:simple_openapi_specification_32_subfile_organized.yaml lines:"40" footer:false %}

## Definitions, Responses, Parameters
What we have done with `Person` and `Persons` definitions can be done with any reusable items (i.e. using `$ref`) such as responses and parameters in the Open API Specification file.

# OpenAPI chainsaw massacre
Thanks to [Mohsen Azimi's post](http://azimi.me/2015/07/16/split-swagger-into-smaller-files.html) I've discovered that using sub-files for definitions, responses and parameters which obviously use $ref JSON Pointers is not the only way of using sub-files. You can use sub-files for almost anything in the specification. 

We will split the [huge file](https://gist.github.com/arno-di-loreto/5a3df2250721fb154060#file-simple_openapi_specification_22_documentation_with_gfm-yaml) created in [previous post about documentation](/writing-openapi-swagger-specification-tutorial-part-7-documentation/).

## Let the chainsaw massacre begin
Let's start with the `info` section:

{% codefile file:simple_openapi_specification_22_documentation_with_gfm.yaml lines:"1-25" footer:false %}

We can put its whole content in a file called `info.yaml`:
{% codefile file:simple_openapi_specification_34_chainsaw_info.yaml footer:false %}

And reference it just like this in `info`:
{% codefile file:simple_openapi_specification_33_chainsaw.yaml lines:"1-4" highlight:"4" footer:false %}

## The wizard of resolution
We can do the same thing with `paths`, `definitions`, `responses` and `parameters`: copy the section content in a sub-file ([paths.yaml](https://gist.github.com/arno-di-loreto/5a3df2250721fb154060#file-simple_openapi_specification_35_chainsaw_paths-yaml), [definitions.yaml](https://gist.github.com/arno-di-loreto/5a3df2250721fb154060#file-simple_openapi_specification_36_chainsaw_definitions-yaml), [responses.yaml](https://gist.github.com/arno-di-loreto/5a3df2250721fb154060#file-simple_openapi_specification_37_chainsaw_responses-yaml) and [parameters.yaml](https://gist.github.com/arno-di-loreto/5a3df2250721fb154060#file-simple_openapi_specification_38_chainsaw_parameters-yaml)) and reference it in the main file:

{% codefile file:simple_openapi_specification_33_chainsaw.yaml lines:"29-39" highlight:"30,33,36,39" footer:false %}

If you remember previous posts, these sections references each other in many ways, for example in `paths.yaml`:

{% codefile file:simple_openapi_specification_35_chainsaw_paths.yaml lines:"144-146" highlight:"146" footer:false %}

The `username` parameter is no longer in the main file and is not in the `paths.yaml` file but in the `parameters.yaml` file:

{% codefile file:simple_openapi_specification_38_chainsaw_parameters.yaml lines:"1-6" highlight:"1" footer:false %}

How could the main file be considered valid in the editor (or in any tool parsing the file)? It's simply because the sub-files are loaded and then the whole content (file + sub-files) is validated.

## A less rough split
We can use JSON pointers for almost anything in the specification as as long as the $ref JSON pointer reference something corresponding to the expected object (or value) in the OpenAPI specification.

### Referencing object in custom structure
And as seen earlier in this post we can put many items in a sub-file.

The `documentation.yaml` file contains the data for `externalDocs` and `tags` (note the custom structure on line 1 and 6):
{% codefile file:simple_openapi_specification_39_chainsaw_documentation.yaml highlight:"1,6" footer:false %}

These data are referenced this way in the main file:
{% codefile file:simple_openapi_specification_33_chainsaw.yaml lines:"6-10" highlight:"7,10" footer:false %}

The `security.yaml` file contains the data for `securityDefinitions` and `security` (note the custom structure on line 20): 
{% codefile file:simple_openapi_specification_41_chainsaw_security.yaml highlight:"20" footer:false %}

### Referencing a string or a simple list
It also work for simpler value like a string or a list of string. The `schema`, `host` and `basepath` values can be moved into a single file `security.yaml` (note the custom structure on line 3 and 4):

{% codefile file:simple_openapi_specification_39_chainsaw_endpoint.yaml highlight:"3,4" footer:false %}

And referenced like this
{% codefile file:simple_openapi_specification_33_chainsaw.yaml lines:"12-17" highlight:"13,15,17" footer:false %}

### Reusing a value
As long as the API consumes and produces the same media types, we define a single value in the `mediatypes.yaml` file:
{% codefile file:simple_openapi_specification_40_chainsaw_mediatypes.yaml footer:false %}

And then we reference this single value in both `produces` and `consumes`: 
{% codefile file:simple_openapi_specification_33_chainsaw.yaml lines:"19-22" highlight:"20,22" footer:false %}

# A smarter split
The API we built with the previous parts could be divided in four parts:

- Common items like headers, media types, security, definitions, parameters and responses
- Persons operations, parameters, responses and definitions
- Legacy operations
- Images operations

We can create 4 sub-files and reference them from a main file.

## commons.yaml
In the `commons.yaml` file we put every items that can be reused across other files:

{% codefile file:simple_openapi_specification_43_smarter_commons.yaml footer:false %}

## images.yaml
In the `images.yaml` file we put both `/images` and `/images/{id}` paths informations:

{% codefile file:simple_openapi_specification_44_smarter_images.yaml highlight:"3,29,31,33,36,58,62,64,66" footer:false %}

Note that all references to common items point to `commons.yaml`.

## legacy.yaml
Same for the `/js-less-consumer-persons` path we put in `legacy.yaml` file in `js-less-consumer-persons`:
{% codefile file:simple_openapi_specification_45_smarter_legacy.yaml highlight:"3,42,46,50,52" footer:false %}

## persons.yaml
All persons items go in the `persons.yaml`:

- each path go in its own named section (like `persons-username` for `/persons/{username}`)
- all persons specific definitions goes in `definitions` (and can be referenced with `#definition/name`)
- all persons specific responses goes in `responses` (and can be referenced with `#responses/name`)
- all persons specific parameters goes in `parameters` (and can be referenced with `#parameters/name`)

{% codefile file:simple_openapi_specification_46_smarter_persons.yaml footer:false %}

## full main file
Here's the full main file where we reference the 4 sub-files:
{% codefile file:simple_openapi_specification_42_smarter.yaml footer:false %}

# Valid sub-files
If we put the last [persons.yaml](simple_openapi_specification_46_smarter_persons.yaml) file content in the editor, it ends with these errors:

{% img file:openapi8-editor-subfile-error.png %}

Splitting a huge Open API Specification file to keep it maintainable is a great idea but if you cannot validate sub-files against the specification, you gain almost nothing.

## Making commons.yaml valid
If we put the [commons.yaml](https://gist.github.com/arno-di-loreto/5a3df2250721fb154060#file-simple_openapi_specification_43_smarter_commons-yaml) file created earlier in the editor we get these errors:

- Missing required property: swagger
- Missing required property: info
- Missing required property: paths
- Additional properties not allowed: defaultHeaders,defaultMediatypes,defaultSecurity

Let's see how we can fix these errors.

### Missing swagger property
We just need to add this line on file's top:

{% codefile file:simple_openapi_specification_48_valid_commons.yaml lines:"1" footer:false %}

### Missing info property
We add an short `info` section after `swagger`:

{% codefile file:simple_openapi_specification_48_valid_commons.yaml lines:"3-6" footer:false %}

### Missing paths property
As we do not define any path in this file we just need to add an empty `paths` section:

{% codefile file:simple_openapi_specification_48_valid_commons.yaml lines:"39" footer:false %}

### Property defaultSecurity not allowed
As the `defaultSecurity` correspond to the OpenAPI `security` section we just need to rename it:

Invalid `commons.yaml` file: 

{% codefile file:simple_openapi_specification_43_smarter_commons.yaml lines:"20-23" highlight:"20" footer:false %}

Valid `commons.yaml` file:

{% codefile file:simple_openapi_specification_48_valid_commons.yaml lines:"28-31" highlight:"28" footer:false %}

### Property defaultMediatypes not allowed
`defaultMediaType` is not a valid OpenAPI property:

{% codefile file:simple_openapi_specification_43_smarter_commons.yaml lines:"25-27" highlight:"25" footer:false %}

We will use `produces` and `consumes` to define the default media types. But as we want to define a single set of media type we will use this trick:

{% codefile file:simple_openapi_specification_48_valid_commons.yaml lines:"33-37" highlight:"37" footer:false %}

In the future if we want to define different sets of media types for produces and consumes, we'll be ready.

### Property defaultHeaders not allowed
`defaultHeaders` is not a valid OpenAPI property:

{% codefile file:simple_openapi_specification_43_smarter_commons.yaml lines:"29-36" highlight:"29" footer:false %}

We will use a dummy response definition `DefaultHeaders` to declare these default headers:

{% codefile file:simple_openapi_specification_48_valid_commons.yaml lines:"67-77" highlight:"71-77" footer:false %}

Of course we need to update common responses to use these headers:

{% codefile file:simple_openapi_specification_48_valid_commons.yaml lines:"78-87" highlight:"81,87" footer:false %}


## Making persons.yaml valid
Just like with `commons.yaml`, if we put `persons.yaml` content in the editor we get some errors:

- Missing required property: swagger
- Missing required property: info
- Reference could not be resolved: commons.yaml#/defaultHeaders
- Missing required property: paths
- Additional properties not allowed: persons-username-collecting-items,persons-username-friends,persons-username,persons

### Missing swagger and info properties
We just add `swagger` and `info` like for `commons.yaml`:
{% codefile file:simple_openapi_specification_49_valid_persons.yaml lines:"1-9" footer:false %}

### commons.yaml#/defaultHeaders reference could not be resolved
As the `commons.yaml` structure has been modified concerning default headers we need to replace these references:

{% codefile file:simple_openapi_specification_46_smarter_persons.yaml lines:"21" footer:false %}

by this one:

{% codefile file:simple_openapi_specification_49_valid_persons.yaml lines:"32" footer:false %}

### Missing paths and additional properties not allowed
We have defined custom properties for each path relative to *persons* operations, therefore there is no `paths` section and our custom properties (like `persons`) are not allowed by the OpenAPI specification.

{% codefile file:simple_openapi_specification_46_smarter_persons.yaml lines:"1-7" footer:false %}

We need to add a `paths` section and put all our path in it using the correct path value as key:
{% codefile file:simple_openapi_specification_49_valid_persons.yaml lines:"11-18" footer:false %}

### New errors: Security definition could not be resolved

Once this is done, 2 new errors appear:

- Security definition could not be resolved: OauthSecurity
- Security definition could not be resolved: LegacySecurity

Now that we have a valid structure, the paths have been parsed and the parser detected missing security definitions. To solve this error, we add these definitions by referencing the `commons.yaml` file:

{% codefile file:simple_openapi_specification_49_valid_persons.yaml lines:"8-9" footer:false %}

## images.yaml and legacy.yaml
For `images.yaml` and `legacy.yaml` we do exactly the same things as we've done with `persons.yaml`.

Here the `images.yaml` file modified (partial view):
{% codefile file:simple_openapi_specification_51_valid_images.yaml lines:"1-12" footer:false %}

Here the `legacy.yaml` file modified (partial view):
{% codefile file:simple_openapi_specification_52_valid_legacy.yaml lines:"1-12" footer:false %}

## Updating the main file
Now that we have modified all sub-files, if we try to edit the main file we get these errors

- Reference could not be resolved: commons.yaml#/defaultMediatypes
- Reference could not be resolved: commons.yaml#/defaultSecurity
- Reference could not be resolved: persons.yaml#/persons
- Reference could not be resolved: images.yaml#/images-imageId
- Reference could not be resolved: persons.yaml#/persons-username
- Reference could not be resolved: persons.yaml#/persons-username-friends
- Reference could not be resolved: persons.yaml#/persons-username-collecting-items
- Reference could not be resolved: images.yaml#/images
- Reference could not be resolved: legacy.yaml#/js-less-consumer-persons

These errors are of 2 types:

- those due to the `commons.yaml` structure modification
- and those due to the `persons.yaml`, `images.yaml` and `legacy.yaml` paths structure modifications

### Modifiying commons.yaml references
Before:
{% codefile file:simple_openapi_specification_42_smarter.yaml lines:"59-68" highlight:"60,62,68" footer:false %}

After:
{% codefile file:simple_openapi_specification_47_valid.yaml lines:"59-68" highlight:"60,62,68" footer:false %}

### Modifying paths references
This is the trickyest part of this tutorial. To reference the `/persons` path in `persons.yaml` we used `persons.yaml#/persons`:

{% codefile file:simple_openapi_specification_42_smarter.yaml lines:"70-72" highlight:"72" footer:false %}

But `persons.yaml` structure has changed from :

{% codefile file:simple_openapi_specification_46_smarter_persons.yaml lines:"1-7" footer:false %}

to:
{% codefile file:simple_openapi_specification_49_valid_persons.yaml lines:"11-18" footer:false %}

The new reference should be something like `persons.yaml#/paths//persons` but if we try it, the editor shows an error *Reference could not be resolved: persons.yaml#/paths//persons*. The `/` in `/persons` needs to be escaped, how can we do that?

> Evaluation of each reference token begins by decoding any escaped character sequence.  This is performed by first transforming any occurrence of the sequence '~1' to '/'
> *[RFC6901](https://tools.ietf.org/html/rfc6901)*

Before modification:
{% codefile file:simple_openapi_specification_42_smarter.yaml lines:"70-84" highlight:"72,74,76,78,80,82,84" footer:false %}

After modification (all `/` in reference name have been replaced by `~1`):
{% codefile file:simple_openapi_specification_47_valid.yaml lines:"70-84" highlight:"72,74,76,78,80,82,84" footer:false %}

And now the main file and all its sub-files are considered valid by the editor.

# Conclusion
You are now ready to split any OpenAPI specification file into valid sub-files in any possible ways. In this 8th part you've learned how to use JSON pointers in almost any places in an OpenAPI specification to references items from other files and how to create valid sub-files containing partial informations. In the next final part (at last) we will learn how to extend the OpenAPI specification (coming soon).