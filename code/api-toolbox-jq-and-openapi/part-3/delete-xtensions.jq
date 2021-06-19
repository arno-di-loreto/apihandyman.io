# Lists all available x-tensions' paths
[(
  paths | # Lists ALL possible paths in documents 
          # (each path is represented as an array)
  select( # Keeps only the values for which what follows return true
    .[-1] | # Gets the path leaf (last item in array)
            # Equivalent to .[.|length-1]
    tostring | # Converts to string for next step
    test("^x-") # Matches "^x-" regex (starts with x-)
  )
)] as $xtensions |
# Delete all found x-tensions using their paths
delpaths($xtensions)