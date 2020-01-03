include "module-openapi"; # Looks for a module-openapi.jq file

# Available filters and their default values
def default_filters:
{
  deprecated: null,
  method: null,
  code: null,
  scope: null
};

def init_filters_with_args:
  default_filters | 
  with_entries( .value = $ARGS.named[.key])
;

def filter_oas_operations(filters):
  map(
    select(
    # Each filter is actually used only if
    # corresponding --arg parameter is provided
    # Filters on deprecated
    (filters.deprecated == null or 
      (.deprecated | tostring) == filters.deprecated) and
    # Filters on HTTP method
    (filters.method == null or 
      .method == filters.method) and
    # Filters on HTTP status code
    (filters.code == null or 
      (.original.responses | has(filters.code))) and
    # Filter on security scope
    (filters.scope == null or
      (if .value.security? != null then
        [ .value.security | 
          map(to_entries | 
          map(.value)[])[][]] | 
        index(filters.scope) >= 0
      else
        false
      end)
    )
  )
);

def search_oas_operations(filters):
  oas_operations |
  filter_oas_operations(filters)
;