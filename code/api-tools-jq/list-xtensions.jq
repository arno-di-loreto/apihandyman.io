[ # Creates an array
  paths | # Lists all possible paths in documents 
          # (each path is represented as an array)
  select( # Keeps only the values for which what follows return true
    .[-1] | # Gets the path leaf (last item in array)
            # Equivalent to .[.|length-1]
    tostring | # Converts to string for next step
    test("^x-") # Matches "^x-" regex (starts with x-)
  ) |
  .[-1] # Keeps only the leaf (x-tension name)
] |
unique # Keeps only an occurence of each element
[] # Flattens array for raw output