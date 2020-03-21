<table>
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
      <td><a class="btn rounded-0 border-0" href="{{item.url}}" target="{{include.target}}"><i class="fas fa-external-link-alt"></i></a></td>
    </tr>
{% endfor %}
  </tbody>
</table>