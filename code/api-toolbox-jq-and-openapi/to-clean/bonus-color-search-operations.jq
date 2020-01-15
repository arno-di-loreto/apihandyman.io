include "module-openapi";
include "bonus-module-search-openapi";
include "bonus-module-color-openapi";

# Sets filters values for the ones provided with --arg
init_filters_with_args as $filters |
# Filters operations
search_oas_operations($filters) |
# Prints operations matching filters
oas_operations_to_colored_text