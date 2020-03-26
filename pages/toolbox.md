---
title: Toolbox
author: Arnaud Lauret
layout: default
permalink: /toolbox/
---

<div class="row below-main-navbar">
  <div class="container">
    <div class="row row-cols-1 row-cols-md-2">
        {% for tool in site.tools %}
          <div class="col mb-4">
          {% assign surtitle = tool.tool_author | append: "'s" %}
            {% include card.html
                class="card-home" 
                image=tool.thumbnail
                image_alt="Project's screenshot"
                title=tool.title
                surtitle=surtitle
                content=tool.excerpt
                url=tool.tool_url
            %}
          </div>
        {% endfor %}
    </div>
  </div>
</div>
