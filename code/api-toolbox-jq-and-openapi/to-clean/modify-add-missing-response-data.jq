(
  .paths[][] |
  select(type == "object") |
  select(has("responses")) | 
  .responses
) |= with_entries(
  if (.key | test($coderegex)) and (.value | has("content") | not) then
    .value += {
      content: {
        "application/json": {
          schema: {
            "$ref": ("#/components/schemas/" + $schema)
          }
        }
      }
  }
  else
    .
  end
)