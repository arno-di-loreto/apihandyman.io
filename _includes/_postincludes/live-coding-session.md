{%- capture content -%}
I did my first ever (recorded) live coding session at the Manning API confernce.
It was about the OpenAPI Specification, how to use it efficiently when designing and documenting API.
The idea was to write an OpenAPI Specification document and show the spec basic to advanced features, tips and tricks and use a few tools around all that.
This post series aim to share all what I've learned preparing this session.

{% capture alert %}
You can get all VS Code stuff explained in this series in my [supercharged-openapi](https://github.com/arno-di-loreto/supercharged-openapi) github repository.
It is the one that I actually used during the session.
{% endcapture %}
{% include alert.html content=alert level="info" title="Spoiler alert!" %}

Note that I'll soon start an OpenAPI Tips & Trick series including this session contents and a few other things I couldn't show during this session.
{%- endcapture -%}
{%- include series-toc.html content=content -%}