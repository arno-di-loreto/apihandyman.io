{ 
  # 1 - Information about the file itself
  #--------------------------------------
  specification: {
    # Determines the type of specification and the version used
    type: (if has("openapi") then "openapi" else "swagger" end),
    version: (if has("openapi") then .openapi else .swagger end),
    file: input_filename # The file name because we work
                         # on multiple files
  },
  # 2 - Information about the API (.info)
  #--------------------------------------
  name: .info.title,
  version: .info.version,
  summary: (
    # indices returns an array containing all indices of the
    # provided string found in the input value
    (.info.description | indices("<!--more-->")[0]) as $more |
    if $more != null then 
      .info.description[0:$more]
      # summary cannot be longer than 100 characters
    elif (.info.description | length) <= 100 then
      .info.description
    else
      .info.description[0:100] + "[...]"
    end
  ),
  # 3 - Number of operations (an operation is get /path for example)
  #-----------------------------------------------------------------
  operations: (
    [ # Creates an array containing all HTTP methods
      # to count the number of operations
      .paths[] | # Returns the content of eah path object
      keys[] | # Returns the keys of the returned object
               # and flattens the array
      select( # Keeps only the value for which what follows is true
         IN("get", "put", "patch", "post", 
            "delete", "head", "options")
      )
    ] | length # Return the length of the array,
               # hence the number of operations
  )
}