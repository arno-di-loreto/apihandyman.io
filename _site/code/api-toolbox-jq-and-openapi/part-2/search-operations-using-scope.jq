include "module-openapi"; # Looks for a module-openapi.jq file

# Expects a --arg scope value parameter
oas_operations # Comes from module-operations.jq
| map(select( # Filters on operation scopes
    # security is not always present
    if .original.security? != null then
      # Creating an array containg all scopes
      [ .original.security | 
        map(to_entries | map(.value)[])[][] ] | 
      index( # Index returns the index of a value in array
        $scope # $scope value is provided on the command line
              # --arg scope value
      ) >= 0 # If < 0, it has not been found
    else
      false # No security defined, so return false
    end
  ))
| oas_operations_to_text  # Comes from module-operations.jq