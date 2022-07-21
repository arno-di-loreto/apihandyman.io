{% assign names=include.names | split:"," %}

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