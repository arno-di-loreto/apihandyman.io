(
  .paths[][] |
  select(type == "object") |
  select(has("responses")) | 
  .responses |
  select(has("500") | not)
) += {
  "500":{
    description: "Unexpected error",
    content: {
      "application/json": {
        schema: {
          "$ref": "#components/schemas/ProviderError"
        }
      }
    }
  }
}