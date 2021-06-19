include "module-color";

# Colors to apply for each HTTP method
def http_method_colors:
 {
 "delete": "red",
 "post": "green",
 "patch": "yellow",
 "put": "yellow",
 "get": "blue"
};

# Prints operations in SwaggerUI like style
def print_colored_oas_operations:
  map( # Applies a transformation to each element
    if .original.deprecated then
      colored_text(
        .method + "\t" + .path + "\t" + .summary + " (deprecated)"; 
        "disabled"
      )
    else
      colored_text(.method;http_method_colors[.method]) + "\t" + 
      .path + "\t" + 
      colored_text(.summary; "darkgray")
    end
  )
  [] # Flattens array for raw output
;