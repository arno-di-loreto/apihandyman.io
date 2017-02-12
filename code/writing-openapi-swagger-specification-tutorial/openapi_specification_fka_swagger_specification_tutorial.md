# Open API Specification (fka Swagger Specification) tutorial
All these Gist files are explained on my [Open API Specification (fka Swagger Specification) tutorial](http://apihandyman.io/writing-openapi-swagger-specification-tutorial-part-1-introduction/) on [API Handyman blog](http://apihandyman.io).

## The tutorial
This tutorial is composed of several posts, here are the posts links and files used for each one:

- Part 1: [Introduction](http://apihandyman.io/writing-openapi-swagger-specification-tutorial-part-1-introduction/)
  - [A JSON specification](#file-simple_openapi_specification_00_yaml_vs_json-json)
  - [A YAML specification](#file-simple_openapi_specification_01-yaml)
- Part 2: [The basics](http://apihandyman.io/writing-openapi-swagger-specification-tutorial-part-2-the-basics/)
  - [An almost empty specification](#file-simple_openapi_specification_01-yaml)
  - [Adding one operation](#file-simple_openapi_specification_02_with_operation-yaml)
  - [Adding query_parameters to an operation](#file-simple_openapi_specification_03_with_query_parameters-yaml)
  - [Defining a path parameter](#file-simple_openapi_specification_04_with_path_parameter-yaml)
  - [Defining a body parameter](#file-simple_openapi_specification_05_with_body_parameter-yaml)
- Part 3: [Simplifying specification file](http://apihandyman.io/writing-openapi-swagger-specification-tutorial-part-3-simplifying-specification-file/)
  - [What we've learned last time](#file-simple_openapi_specification_05_with_body_parameter-yaml)
  - [Reusable definitions](#file-simple_openapi_specification_06_with_definitions-yaml)
  - [Reusable response: you're doing it wrong](#file-simple_openapi_specification_07_with_responses_wrong-yaml)
  - [Reusable response: you're doing it less wrong](#file-simple_openapi_specification_08_with_responses_less_wrong-yaml)
  - [Reusable response: this time it's OK](#file-simple_openapi_specification_09_with_responses-yaml)
  - [Reusable operation path parameter: You're doing it wrong](#file-simple_openapi_specification_10_with_single_path_parameter_wrong-yaml)
  - [Reusable operation path parameter: this time it's OK](#file-simple_openapi_specification_11_with_single_path_parameter-yaml)
  - [Defining a parameter once for a path: You're doing it wrong](#file-simple_openapi_specification_12_with_parameters_wrong-yaml)
  - [Defining a parameter once for a path: this time it's OK](#file-simple_openapi_specification_13_with_parameters-yaml)
- Part 4: [Advanced data modeling](http://apihandyman.io/writing-openapi-swagger-specification-tutorial-part-4-advanced-data-modeling)
  - [Advanced data modeling](#file-simple_openapi_specification_14_advanced_data_modeling-yaml)
- Part 5: [Advanced input and output modeling](http://apihandyman.io/writing-openapi-swagger-specification-tutorial-part-5-advanced-input-and-output-modeling/)
  - [Advanced input and output modeling](#file-simple_openapi_specification_15_advanced_input_and_output_modeling-yaml)
- Part 6: [Defining security](http://apihandyman.io/writing-openapi-swagger-specification-tutorial-part-6-defining-security/)
  - [Basic Authentication](#file-simple_openapi_specification_17_defining_security_basic-yaml)
  - [API Key](#file-simple_openapi_specification_18_defining_security_apikey-yaml)
  - [Oauth 2](#file-simple_openapi_specification_19_defining_security_oauth2-yaml)
  - [Multiple securities](#file-simple_openapi_specification_20_defining_security_multiple-yaml)
- Part 7: [Documentation](http://apihandyman.io/writing-openapi-swagger-specification-tutorial-part-7-documentation/):
  - [Documentation](#file-simple_openapi_specification_21_documentation-yaml)
  - [Documentation with GFM](#file-simple_openapi_specification_22_documentation_with_gfm-yaml)
- Part 8: [Splitting specification file](http://apihandyman.io/writing-openapi-swagger-specification-tutorial-part-8-splitting-specification-file/):
  - Basic splitting
    - [person.yaml sub-file](https://gist.github.com/arno-di-loreto/5a3df2250721fb154060#file-simple_openapi_specification_23_person-yaml)
    - [Using person.yaml locally](https://gist.github.com/arno-di-loreto/5a3df2250721fb154060#file-simple_openapi_specification_24_local_reference-yaml)
    - [persons.yaml sub-file](https://gist.github.com/arno-di-loreto/5a3df2250721fb154060#file-simple_openapi_specification_26_persons-yaml)
    - [Using person.yaml and persons.yaml in folders](https://gist.github.com/arno-di-loreto/5a3df2250721fb154060#file-simple_openapi_specification_25_local_reference_folder-yaml)
    - [Using remote file](https://gist.github.com/arno-di-loreto/5a3df2250721fb154060#file-simple_openapi_specification_27_remote_reference-yaml)
    - [Using a remote reference in persons.yaml](https://gist.github.com/arno-di-loreto/5a3df2250721fb154060#file-simple_openapi_specification_28_persons_remote-yaml
    - [Multiple items in a sub-file](https://gist.github.com/arno-di-loreto/5a3df2250721fb154060#file-simple_openapi_specification_29_definitions-yaml)
    - [Using these multiple items from a main file](https://gist.github.com/arno-di-loreto/5a3df2250721fb154060#file-simple_openapi_specification_30_subfile_multiple-yaml)
    - [Organizing items in sub-file](https://gist.github.com/arno-di-loreto/5a3df2250721fb154060#file-simple_openapi_specification_31_organized_definitions-yaml)
    - [Using these organized items](https://gist.github.com/arno-di-loreto/5a3df2250721fb154060#file-simple_openapi_specification_32_subfile_organized-yaml)
  - Chainsaw split:
    - [Main file](https://gist.github.com/arno-di-loreto/5a3df2250721fb154060#file-simple_openapi_specification_33_chainsaw-yaml)
    - [Info sub-file](https://gist.github.com/arno-di-loreto/5a3df2250721fb154060#file-simple_openapi_specification_34_chainsaw_info-yaml)
    - [Paths sub-file](https://gist.github.com/arno-di-loreto/5a3df2250721fb154060#file-simple_openapi_specification_35_chainsaw_paths-yaml)
    - [Definitions sub-file](https://gist.github.com/arno-di-loreto/5a3df2250721fb154060#file-simple_openapi_specification_36_chainsaw_definitions-yaml)
    - [Responses sub-file](https://gist.github.com/arno-di-loreto/5a3df2250721fb154060#file-simple_openapi_specification_37_chainsaw_responses-yaml)
    - [Parameters sub-file](https://gist.github.com/arno-di-loreto/5a3df2250721fb154060#file-simple_openapi_specification_38_chainsaw_parameters-yaml)
    - [Documentation sub-file](https://gist.github.com/arno-di-loreto/5a3df2250721fb154060#file-simple_openapi_specification_39_chainsaw_documentation-yaml)
    - [Endpoint sub-file](https://gist.github.com/arno-di-loreto/5a3df2250721fb154060#file-simple_openapi_specification_39_chainsaw_endpoint-yaml)
    - [Media types sub-file](https://gist.github.com/arno-di-loreto/5a3df2250721fb154060#file-simple_openapi_specification_40_chainsaw_mediatypes-yaml)
    - [Security sub-file](https://gist.github.com/arno-di-loreto/5a3df2250721fb154060#file-simple_openapi_specification_41_chainsaw_security-yaml)
  - A smarter split
    - [Main file](https://gist.github.com/arno-di-loreto/5a3df2250721fb154060#file-simple_openapi_specification_42_smarter-yaml)
    - [Commons sub-file](https://gist.github.com/arno-di-loreto/5a3df2250721fb154060#file-simple_openapi_specification_43_smarter_commons-yaml)
    - [Images sub-file](https://gist.github.com/arno-di-loreto/5a3df2250721fb154060#file-simple_openapi_specification_44_smarter_images-yaml)
    - [Legacy sub-file](https://gist.github.com/arno-di-loreto/5a3df2250721fb154060#file-simple_openapi_specification_45_smarter_legacy-yaml)
    - [Persons sub-file](https://gist.github.com/arno-di-loreto/5a3df2250721fb154060#file-simple_openapi_specification_46_smarter_persons-yaml)
  - Valid subfiles:
    - [Main file](https://gist.github.com/arno-di-loreto/5a3df2250721fb154060#file-simple_openapi_specification_47_valid-yaml)
    - [Commons sub-file](https://gist.github.com/arno-di-loreto/5a3df2250721fb154060#file-simple_openapi_specification_48_valid_commons-yaml)
    - [Persons sub-file](https://gist.github.com/arno-di-loreto/5a3df2250721fb154060#file-simple_openapi_specification_49_valid_persons-yaml)
    - [Images sub-file](https://gist.github.com/arno-di-loreto/5a3df2250721fb154060#file-simple_openapi_specification_51_valid_images-yaml)
    - [Legacy sub-file](https://gist.github.com/arno-di-loreto/5a3df2250721fb154060#file-simple_openapi_specification_52_valid_legacy-yaml)
- Part 9: Extending the OpenAPI specification (coming soon)

## The OpenAPI Specification
If you're a bit lost in the [specification](https://github.com/OAI/OpenAPI-Specification/blob/master/versions/2.0.md), take a look at my [*visual documentation:*
<center>![OpenAPISpecificationVisualDocumentation](http://apihandyman.io/wp-content/uploads/2016/02/OpenAPI-Specification-Visual-Documentation.png "OpenAPI Specification Visual Documentation")
</center>](http://openapi-specification-visual-documentation.apihandyman.io/)