.paths | # Selects the paths property content
to_entries | # Transforms
             # { "/resources": { "get": {operation data}}} 
             # to 
             # [ { "key": "/resources", 
             #     "value": { "get": {operation data}} ]
map( # Applies a transformation to each element
  .value | # Keeps only the operations { "get": {operation data}} 
  keys | # Gets an object keys ("get")
  map( # Applies a transformation to each element
    select( # Keeps only elements for which the following is true
      (. != "parameters") # Gets rid of parameters
      and
      ( # Gets rid of x- properties
        . | 
        tostring | # Converts to string for next step
        test("^x-") | # Matches "^x-" regex (starts with x-)
        not # Negates previous resuls
      )
    )
  )[] # Flattens array (to avoid having an array of 
      # array of HTTP method)
) |
unique # Keeps only an occurence of each element
[] # Flattens array for raw output