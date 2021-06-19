include "module-openapi";
include "module-args";
include "module-openapi-search";

# Gets operations data
oas_operations
# Filters operations
| filter_oas_operations(init_parameters(default_filters))
# Prints operations
| print_oas_operations(init_parameters(default_print_parameters).format)