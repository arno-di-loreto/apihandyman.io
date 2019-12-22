include "module-openapi"; # Looks for a module-operations.jq file

. | 
oas_operations | # Comes from module-operations.jq
map(select(.method == $method)) | # Filters on returned operations
oas_operations_to_text  # Comes from module-operations.jq