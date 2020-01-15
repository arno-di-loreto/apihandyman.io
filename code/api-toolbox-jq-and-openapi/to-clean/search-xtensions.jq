# Creates an array
[
  # Defining some variable before actually processing document
  (
    paths | # Lists ALL possible paths in documents 
            # (each path is represented as an array)
    select( # Keeps only the values for which 
            # what follows return true
      .[-1] | # Gets the path leaf (last item in array)
              # Equivalent to .[.|length-1]
      tostring | # Converts to string for next step
      test("^x-") # Matches "^x-" regex (starts with x-)
    )
  ) as $xtensions | # Store result in $xtension variable
  # Actually processing the document
  { # jq will create an object for each item 
    # in $xtension (it's kind of magic :-)
    xtension: $xtensions[-1], # Here $xtensions is an item,
                              # [-1], gets the x-tension's 
                              # name (path's leaf)
    path: $xtensions, #  The x-tension path
    value: getpath($xtensions) # The getpath function returns 
                               # the value for a path in the 
                               # document
  }
] |
# Returns all: --arg name all
if $name == "all" then
  .
# Optional filtering: --arg name x-implementation
else
  map(select(.xtension == $name))
end