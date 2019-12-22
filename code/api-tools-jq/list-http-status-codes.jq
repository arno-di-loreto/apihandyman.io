.paths | # Selects the paths property content
to_entries | # Transforms
             # { "/resources": { "get": {operation data}}} 
             # to 
             # [ { "key": "/resources", 
             #     "value": { "get": {operation data}} ]
map( # Applies a transformation to each element
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
    .value.responses | # Keeps only the responses content 
                       # { "200": {response data}}
    keys # Keeps only the HTTP status codes "200"
    [] # Flattens the array
  )[] # Flattens the array
) |
unique # Keeps only an occurence of each element
[] # Flattens array for raw output