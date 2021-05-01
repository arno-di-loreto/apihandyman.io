{%- capture intro -%}
When designing APIs, choosing HTTP status codes is not always that obvious and prone to errors, I hope this post series will help you to avoid common mistakes and choose an adapted one according to the context.
{%- endcapture -%}
{%- if include.style == "intro" -%}
{{intro}}
{%- else -%}
{%- capture alert -%}
<div class="alert alert-info">
I never remember in which RFCs HTTP status codes are defined.
To get a quick access to their documentation, I use <a class="alert-link" href="https://webconcepts.info/concepts/http-status-code/">Erik Wilde's Web Concepts</a>.
</div>
{%- endcapture -%}
{%- capture thanks -%}
Very special thanks to all Twitter people participating to the <a href="https://twitter.com/search?q=%23choosehttpstatuscode&src=typed_query">#choosehttpstatuscode</a> polls and discussions
{%- endcapture -%}
{%- assign content = intro | append:alert | append:thanks -%}
{%- include series-toc.html content=content -%}
{%- endif -%}