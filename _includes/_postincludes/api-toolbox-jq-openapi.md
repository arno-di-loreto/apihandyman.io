# JQ and OpenAPI post series

{% include link.md link=site.data.jq.links.documentation target=site.data.jq.link_target %} is quite complete and there are many tutorials and Stackoverflow answers, so why bother writing this series? First reason, I regularly meet people working with APIs and/or JSON files who actually don't know JQ exists and how it could save their life (or at least their time). Second reason, I often use it with OpenAPI specification files and I found that showing how JQ can be used on such a widely adopted and familiar JSON based format could help to learn how to use it (and also writing this post actually helped me to improve my JQ skills!).

This JQ and OpenAPI series is composed of the following posts:
{% assign sorted = site.posts | where:"series", page.series | sort:"series_title"  %}
<ul>
  {% for my_page in sorted %}
    {% if my_page.series_title == page.series_title %}
    <li><strong>{{ my_page.series_title }}</strong></li>
    {% else %}
    <li><a class="page-link" href="{{ my_page.url | prepend: site.baseurl }}">{{ my_page.series_title }}</a></li>
    {% endif %}
  {% endfor %}
  <li>Part 3 - Modifying OpenAPI files with JQ (coming soon)</li>
  <li>Part 4 - Bonus: coloring JQ's raw output (coming soon)</li>
</ul>