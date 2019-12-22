include "module-openapi"; # Looks for a module-operations.jq file

. | 
oas_operations | # Comes from module-operations.jq
oas_operations_to_text  # Comes from module-operations.jq