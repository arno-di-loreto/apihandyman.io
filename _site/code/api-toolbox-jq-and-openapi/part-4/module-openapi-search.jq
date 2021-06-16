include "module-openapi";

# Available filters and their default values
# To be used with init_parameters
def default_filters:
{
  deprecated: null,
  method: null,
  code: null,
  scope: null,
  path_contains: null
};

# Filters operations coming from oas_operations
# Each filter is used only if corresponding filters.<name> parameter is provided
def filter_oas_operations(filters):
  map(
    select(
    # Filters on deprecated
    (filters.deprecated == null or 
      (.deprecated | tostring) == filters.deprecated) and
    # Filters on HTTP method
    (filters.method == null or 
      .method == filters.method) and
    # Filters on HTTP status code
    (filters.code == null or 
      (.original.responses | has(filters.code))) and
    # Filters on security scope
    (filters.scope == null or
      (if .value.security? != null then
        [ .value.security | 
          map(to_entries | 
          map(.value)[])[][]] | 
        index(filters.scope) >= 0
      else
        false
      end)
    ) and
    # Filters on path
    (filters.path_contains == null or 
      (.path | contains(filters.path_contains))
    )
  )
);

# Same as oas_operations_to_text but with source
def oas_operations_to_text_with_source: 
  map( # Applies a transformation to each element
    "[" + .source[0:20] + "]\t" +
    .method + "\t" + 
    .path + "\t" + 
    .summary + 
    (if .deprecated then " (deprecated)" else "" end)
  )
  [] # Flattens array for raw output
; # oas_operations_to_text function's end

# To be used with init_parameters
def default_print_parameters:
{
  format: "text_without_source"
  # All values: 
  #  text_with_source, text_without_source, json_flat or null for json
};

# Prints oas_operations (filtered or not) in various format
def print_oas_operations(format):
  if format == "text_with_source" then
      oas_operations_to_text_with_source
  elif format == "text_without_source" then
      oas_operations_to_text
  elif format == "json_flat" then
    .[] # Flattening for multifiles, pipe result into a jq -s
  else
    .
  end
;

