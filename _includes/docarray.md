<table class="table-documentation-links">
  {% if include.title %}
  <thead>
    <tr>
      <th colspan="3" scope="col">{{include.title}}</th>
    </tr>
  </thead>
  {% endif %}
  <tbody>
{% assign names=include.names | split:"," %}
{% for name in names %}
{% assign item = include.links[name] %}
    <tr>
      <td><code>{{item.examples | join:"</code><br><code>" }}</code></td>
      <td>{{item.description | capitalize}}</td>
      <td><a class="btn-documentation" href="{{item.url}}" target="{{include.target}}" aria-label="open documentation in a new tab" data-toggle="tooltip" data-placement="right" title="Open documentation in a new tab">{% include svg/documentation.svg %}</a></td>
    </tr>
{% endfor %}
  </tbody>
</table>