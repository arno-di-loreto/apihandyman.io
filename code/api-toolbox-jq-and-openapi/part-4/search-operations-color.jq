include "module-openapi";
include "module-args";
include "module-openapi-search";
include "module-openapi-operations-color";

# Gets operations data
oas_operations
# Filters operations
| filter_oas_operations(init_parameters(default_filters))
# Prints operations
| print_colored_oas_operations
