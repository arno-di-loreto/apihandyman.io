{% assign names=include.names | split:"," %}

## Specification and schemas

<table>
{% for name in names %}
{% assign item = site.data.openapi-reference.specification[name] %}
    <thead>
    <tr>
      <th>{{item.name}} {{item.type}}</th>
      <th class="text-center" colspan="3">Links</th>
    </tr>
    </thead>
    <tr>
      <td>Specification</td>
      {% for link in item.links.specification %}
      {% assign version = link[0] %}
      <td class="text-center"><a href="{{link[1]}}">{% include openapi-version.html version=version %}</a></td>
      {% endfor %}
    </tr>
    <tr>
      <td>JSON schema</td>
      {% for link in item.links.schema %}
      {% assign version = link[0] %}
      <td class="text-center"><a href="{{link[1]}}">{% include openapi-version.html version=version %}</a></td>
      {% endfor %}
    </tr>
{% endfor %}
</table>

{% assign relatedDiscussions = "" | split: ',' %}
{% for discussion in site.data.openapi-reference.discussions %}
  {% for element in discussion.elements %}
    {% assign elementKey=element[0] %}
    {% if include.names contains elementKey %}
      {% assign relatedDiscussions = relatedDiscussions | push: discussion %}
      {% break %}
    {% endif %}
  {% endfor %}
{% endfor %}

{% if relatedDiscussions.size > 0 %}
## Discussions

<table class="table-documentation-links">
{% for discussion in relatedDiscussions %}
  <thead>
    <tr>
      <th colspan="3" scope="col">{{discussion.title}}</th>
    </tr>
    </thead>
  <tr>
    <td>Components</td>
    <td>Versions</td>
    <td>Issues and pull requests</td>
  </tr>
  <tr>
    <td>
      <ul class="list-group">
      {% for element in discussion.elements %}
        {% assign elementKey=element[0] %}
        {% assign elementName=site.data.openapi-reference.specification[elementKey].name %}
        
        {% if element[1].size == 0 %}
          <li class="list-group-item border-0 p-1"><code>{{elementName}}</code></li>
        {% else %}
          {% for property in element[1] %}
            <li class="list-group-item border-0 p-1"><code>{{elementName}}.{{property}}</code></li> 
          {% endfor %}
        {% endif %}
      {% endfor %}
      </ul>
    </td>
    <td>
      <ul class="list-group text-center">
      {% for version in discussion.versions %}
        <li class="list-group-item border-0 p-1">
          {% include openapi-version.html version=version %}
        </li>
      {% endfor %}
      </ul>
    </td>
    <td>
      <ul>
      {% for link in discussion.links %}
        <li><a href="{{link.url}}">{{link.name}}</a></li>
      {% endfor %}
      </ul>
    </td>
  </tr>
{% endfor %}
</table>

{% endif %}

{% assign relatedSamples = "" | split: ',' %}
{% for sample in site.data.openapi-reference.samples %}
  {% assign sampleKey = sample[0] %}
  {% assign sampleValue = sample[1] %}
  {% for element in sampleValue.elements %}
    {% assign elementKey=element[0] %}
    {% if include.names contains elementKey %}
      {% assign relatedSamples = relatedSamples | push: sampleValue %}
      {% break %}
    {% endif %}
  {% endfor %}
{% endfor %}


{% if relatedSamples.size > 0 %}
{% assign openapiReferenceGithub = "https://github.com/arno-di-loreto/openapi-samples/tree/main/reference/" | append:include.folder | append: "/" %}
## Samples

All examples shown in this post and some others are listed below, they can be found in my [openapi-samples]({{openapiReferenceGithub}}) Github repository.

<table>
{% for sample in relatedSamples %}
  <thead>
  <tr>
    <th>{{sample.name}}</th>
    <th class="text-center" colspan="3">Links</th>
  </tr>
  </thead>
  {% for sampleVariation in sample.samples %}
  <tr>
    <td>{{sampleVariation.name}}</td>
    {% for link in sampleVariation.links %}
      
      <td class="text-center">{% if link[1] %}
      {% assign version = link[0] %}
      <a href="{{openapiReferenceGithub | append: link[1]}}">{% include openapi-version.html version=version %}</a>{% endif %}
      </td>

    {% endfor %}
  </tr>
  {% endfor %}
{% endfor %}
</table>

{% endif %}


