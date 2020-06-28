<table class="table table-sm">
  <thead>
    <tr>
      <th span="3">{{include.title}}</th>
    </tr>
  </thead>
  <tbody>
{% assign names=include.names | split:"," %}
{% for name in names %}
{% assign item = include.links[name] %}
    <tr>
      <td><code>{{item.examples | join:"</code><br><code>" }}</code></td>
      <td>{{item.description | capitalize}}</td>
      <td><a href="{{item.url}}" target="{{include.target}}"><i class="fas fa-external-link-alt"></i></a></td>
    </tr>
{% endfor %}
  </tbody>
</table>