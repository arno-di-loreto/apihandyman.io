# Selecting all responses list
( 
  .paths[][] |
  select(type == "object") |
  select(has("responses")) | 
  .responses
) 
|= # Updating selected values
  with_entries( # transforms key: value into { key: key, value: value}
  # $coderegex is provided with --arg coderegex 40.
  if (.key | test($coderegex)) and (.value | has("content") | not) then
    .value += { # Actually updating the value
      content: {
        "application/json": {
          schema: { # $schema is provided with --arg schema ConsumerError 
            "$ref": ("#/components/schemas/" + $schema)
          }
        }
      }
  }
  else
    . # unmodified element
  end
)