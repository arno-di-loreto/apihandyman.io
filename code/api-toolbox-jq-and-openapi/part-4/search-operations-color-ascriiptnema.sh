# TITLE: API Toolbox - JQ and OpenAPI - Coloring JQ output
# ROOT: apihandyman.io
# SECTION: colored search
# In part 2 we learned to do a search on OpenAPI files
jq -r -f search-operations.jq demo-api-openapi.json
# That's cool, but a little bit boring, let's do the same with colors
jq -r -f search-operations-color.jq demo-api-openapi.json
# That's better!
# Both modules use the same filters and functions
# They only differ when it comes to print the search result
diff search-operations.jq search-operations-color.jq | bat
# The new function comes from the include appearing in diff
# It takes advantage of the colored_text function when concatenating http methods, paths and summaries
# Colors to use for each HTTP method are set in a variable
jq -r -n 'include "module-openapi-operations-color";http_method_colors["put"]'
# They are used with colored_text
jq -r -n 'include "module-openapi-operations-color";include "module-color"; "put" | colored_text(.;http_method_colors[.])'
# Summaries are printed in darkgray
jq -r -n 'include "module-color"; colored_text("summary";"darkgray")'
# Note that deprected operations are colored with the "disabled" colors
jq -r -n 'include "module-color"; colored_text("deprecated";"disabled")'
