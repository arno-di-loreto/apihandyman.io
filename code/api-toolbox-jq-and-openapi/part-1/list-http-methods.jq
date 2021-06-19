# 1 - Creates an array of all HTTP methods
#     inside paths["/whatever"]
#-----------------------------------------
# It returns ["get", "post","summary","x-example", "post"]
[
  .paths[] # Selects the paths["/whatever"] properties content
           # to keeps only the operations
  | keys[] # Keeps only the keys (HTTP methods and few other things)
           # and flattens array
]
# 2 - Cleans keys to keep only HTTP method
#-----------------------------------------
# It returns ["get", "post", "post"]
| map( # Applies a filter to each element
  select( # Keeps only elements for which the following is true
   # With IN, which returns true if the value is one of its
   # parameters, we can get rid of x- , parameters
   # description and summary properties
   IN("get", "put", "post", "delete", 
      "options", "head", "patch", "trace")
  )
)
# 3 - Keeps an occurrence of each HTTP method
#--------------------------------------------
# It returns ["get", "post"]
| unique # Keeps only an occurence of each element
# 4 - Generates raw string
#-------------------------
[] # Flattens array for raw output