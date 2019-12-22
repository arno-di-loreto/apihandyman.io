include "module-openapi"; # Looks for a module-operations.jq file

. | 
oas_operations | # Comes from module-operations.jq
map(select( # Filters on operation scopes
  # security is not always present
  if .original.security? != null then
    # Creating an array containg all scopes
    [
      .original.security | 
      map(to_entries | map(.value)[])[][]
    ] | 
    # Index returns the index of a value in array
    # If < 0, it has not been found
    index($scope) >= 0
  else
    false # No security defined, so return false
  end
)) | # Custom filter on returned operations
oas_operations_to_text  # Comes from module-operations.jq