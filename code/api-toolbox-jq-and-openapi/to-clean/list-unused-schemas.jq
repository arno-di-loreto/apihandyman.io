(
  # Defined schemas
  (
    .components.schemas | # select reusable schemas structure
    keys | # keeps only the schema names
    map("#/components/schemas/" + .) # return an array with schema refs
  )
  # Minus operator to substract used schemas from defined schemas
  -
  # Actually used schemas
  ([ # Creating an array
    .. | # selects all nodes
    select(type=="object") | # keeps only object
    select(has("$ref")) | # keeps only object having $ref property
    .["$ref"] # the $ref property (.$ref connot be used because of $) 
  ] | unique) # Keeps only one occurence
) | map(split("/") - ["#"])
[] # Flattens array for raw output