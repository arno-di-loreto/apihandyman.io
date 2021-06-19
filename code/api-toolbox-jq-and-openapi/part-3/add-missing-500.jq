# First we select the elements to modify
(
  .paths[][] |
  select(type == "object") |
  select(has("responses")) | 
  .responses |
  select(has("500") | not)
)
# Then each of them is modified 
+= {
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
# The fully modified document is returned