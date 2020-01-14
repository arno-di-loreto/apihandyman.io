# Removes all object having a deprecated property set to true

# Before: "objectProperty": { "deprecated": true }
# After: "objectProperty": null
walk(
  if type=="object" and .deprecated == true then 
    del(.) 
  else 
    . 
  end
) | 
# Removes all property set to null ("nullProperty": null) created 
# when deleted objects containing deprecated set to true
walk(
  if type=="object" then 
    with_entries( 
      select( .value != null)
    ) 
  else  # Not an object, just keep it
    .
  end
) |
# Removes all empty property ("emptyProperty": {}) that may have
# been created when removing the null ones
walk(
  if type=="object" then 
    with_entries(
      select(.value != {} )
    )
  else # Not an object, just keep it
    . 
  end
)