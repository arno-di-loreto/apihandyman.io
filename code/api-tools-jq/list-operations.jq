.paths | # Selects the paths property content
to_entries | # Transforms
             # { "/resources": { "get": {operation data}}} 
             # to 
             # [ { "key": "/resources", 
             #     "value": { "get": {operation data}} ]
map ( # Applies a transformation to each element
  .key as $path | # Stores the path value (.key) 
                  # in a variable ($path) for later use
  .value | # Keeps only the path's content 
           # { "get": {operation data}}
  to_entries | # Transforms 
               # { "get": {operation data}}
               # to
               # [ { "key": "get", 
               #     "value": {operation data}} ]
  map( # Applies a transformation to each element
    select( # Keeps only elements for which the following is true
      (.key != "parameters") # Gets rid of parameters
      and
      ( # Gets rid of x- properties
        .key | 
        tostring | # Converts to string for next step
        test("^x-") | # Matches "^x-" regex (starts with x-)
        not # Negates previous resuls
      )
    ) |
    # Creates a new JSON object
    {
      method: .key,
      path: $path, # Using the variable defined on line 4
      summary: (
        # Ensures the value is "" (instead of null)
        # if there is no summary 
        if .value.summary? != null then 
          .value.summary 
        else 
          ""
        end
      ),
      deprecated: (
        # Ensures the value is true/false instead of null
        # if there is no deprecated property
        if .value.deprecated? != null then 
          .value.deprecated 
        else 
          false
        end
      )
    }
  )[] # Flattens array to avoid having an array 
      # of array of {path, method, summary}
) | # Now we have an array of {path, method, summary}
map( # Applies a transformation to each element
  .method + "\t" + 
  .path + "\t" + 
  .summary + 
  (if .deprecated then " (deprecated)" else "" end)
)
[] # Flattens array for raw output