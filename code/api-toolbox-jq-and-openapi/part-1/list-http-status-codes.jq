# 1 - Selects all properties of all responses
#--------------------------------------------
# It returns ["404", "200", "200", "x-example"]
[
  .paths[][].responses? # ? avoid getting an error if
                        # responses does not exist
  | keys? # ? avoid getting an error if . is not an
          # object and has no keys
  | .[] # [ ["404", "200"], ["200", "x-example"] ] ⤵️
      #                     ["404", "200", "200", "x-example"]
]
# 2 - Removes x- properties
#--------------------------
# It returns ["200", "404", "200"]
| map( # Applies a filter to each element
  select( # Keep elements for which what follows return true
    test("^x-") # Returns true if value match the regex parameter
    | not # Returns the opposite of a boolean value
  )
) 
# 3 - Counts how many times each code is used
#--------------------------------------------
# It returns [ {"code": "404", "count": 1}, 
#              {"code": "200", "count": 2} ]
| group_by(.) # ["404", "200", "200"] ➡️ [["400"],["200", "200"]]
| map( # Applies a filter to each element
  { # Creates an object
    code: .[0], # ["200", "200"] ➡️ ["200"] ➡️ "200"
    count: length # ["200", "200"] ➡️ 2
  }
)
# 4 - Sorts by descending count
#------------------------------
# It returns [ {"code": "200", "count": 2}, 
#              {"code": "404", "count": 1} ]
| sort_by(-.count) # Sort array by parameter value
# 5 - Generates tab separated string output
#------------------------------------------
| map( # Applies a filter to each element
  .code + 
  "\t" + 
  (.count | tostring) # count is a number
                      # it must be converted to string
                      # to be concatenated to other string
)[] # Flattens array for raw output