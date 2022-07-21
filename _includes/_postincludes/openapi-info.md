{%- assign version=include.version -%}
{%- assign changelog=include.changelog -%}
<table>
<thead><tr>
<th>Property</th><th>Required</th><th>Type</th><th>Description</th>
</tr></thead>
<tr>
<td>title</td><td>✅</td><td><code>string</code></td><td>The name of the API.</td>
</tr>
{%- if version=="3.1" -%}
{%- if changelog -%}
<tr class="table-success">
{%- else -%}
<tr>
{%- endif -%}
<td>summary</td><td></td><td><code>string</code></td><td>A short summary of the API.</td>
</tr>
{%- endif -%}
<tr>
  <td>version</td>
  <td>✅</td>
  <td><code>string</code></td>
  <td>The version of the API (which is distinct from the <a href="#what-is-the-openapi-property">OpenAPI Specification version defined in the <code>{%- if version=="2.0" -%}swagger{%- else -%}openapi{%- endif -%}</code> property</a> or the <a href="#version-is-not-the-interfaces-contract-one">API implementation version</a>).</td>
</tr>
{%- if changelog and version=="2.0" -%}
<tr class="table-primary">
{% elsif changelog and version=="3.0" -%}
<tr class="table-danger">
{%- else -%}
<tr>
{%- endif -%}
  <td>description</td>
  <td></td>
  <td><code>string</code></td>
  <td>A description of the API. Supports markdown ({%- if version=="2.0"-%}<a href="https://github.github.com/gfm/">GFM</a>{%- else -%}<a href="https://spec.commonmark.org/">Commonmark</a>{%-endif-%}) to propose rich text formatting (see "<a href="#using-rich-text-formatting-in-description">Using rich text formatting in description</a>").</td>
</tr>
{%- if changelog and version=="2.0" -%}
<tr class="table-primary">
{% elsif changelog and version=="3.0" -%}
<tr class="table-warning">
{%- else -%}
<tr>
{%- endif -%}
  <td>termsOfService</td>
  <td></td>
  <td><code>string</code>{%- if version!="2.0" -%}&nbsp;(<code>url</code>){%- endif -%}</td>
  <td>{%- if version=="2.0" -%}The Terms of Service for the API.{%- else -%}A URL to the terms of service for the API.{%- endif -%}</td>
</tr>
<tr>
  <td>contact</td>
  <td></td>
  <td>Contact Object</td>
  <td>The contact information for the exposed API.</td>
</tr>
<tr>
  <td>contact.name</td>
  <td></td>
  <td><code>string</code></td>
  <td>The identifying name of the contact person/organization.</td>
</tr>
<tr>
  <td>contact.url</td>
  <td></td>
  <td><code>string</code>&nbsp;(<code>url</code>)</td>
  <td>The URL pointing to the contact information.</td>
</tr>
<tr>
  <td>contact.email</td>
  <td></td>
  <td><code>string</code>&nbsp;(<code>email</code>)</td>
  <td>The email address of the contact person/organization.</td>
</tr>
<tr>
  <td>license</td>
  <td></td>
  <td>License Object</td>
  <td>The license that is applicable to the interface contract which is described in the OpenAPI document. See <a href="#what-is-a-license-for-an-api">What is a license for an API?</a>)</td>
</tr>
<tr>
  <td>license.name</td>
  <td>✅</td>
  <td><code>string</code></td>
  <td>The license name used for the API.</td>
</tr>
{%- if version=="3.1" -%}
{%- if changelog -%}
<tr class="table-success">
{%- else -%}
<tr>
{%- endif -%}
  <td>license.identifier</td>
  <td></td>
  <td><code>string</code></td>
  <td>An <a href="https://spdx.org/spdx-specification-21-web-version#h.jxpfx0ykyb60">SPDX</a> license expression for the API. The <code>identifier</code> field is mutually exclusive of the <code>url</code> field.</td>
</tr>
{%- endif -%}
<tr>
  <td>license.url</td>
  <td></td>
  <td><code>string</code>&nbsp;(<code>url</code>)</td>
  <td>A URL to the license used for the API. {%- if version=="3.1" -%}The <code>url</code> field is mutually exclusive of the <code>identifier</code> field.{%- endif -%}</td>
</tr>
</table>