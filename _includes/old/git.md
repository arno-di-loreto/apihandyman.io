{% code language:bash %}
[apihandyman.io]$ git clone {{include.link.url}}
[apihandyman.io]$ cd {{include.link.url | split:"/" | last }}
{% if include.branch %}[apihandyman.io]$ git checkout {{include.branch}}{% endif %}

{{site.codeblock_hidden_copy_separator}}

git clone {{include.link.url}}
cd {{include.link.url | split:"/" | last }}
{% if include.branch %}git checkout {{include.branch}}{% endif %}

{% endcode %}