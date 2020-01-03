# Defines bash color constants
# See https://misc.flogisoft.com/bash/tip_colors_and_formatting
def colors:
 {
  "red": "\u001b[31m",
  "green": "\u001b[32m",
  "yellow": "\u001b[33m",
  "blue": "\u001b[34m",
  "darkgray": "\u001b[90m",
  "disabled": "\u001b[30;100m", # Black on darkgray
  "reset": "\u001b[0m"
};

# Defines the colors to apply for each method
def http_method_colors:
 {
 "delete": "red",
 "post": "green",
 "patch": "yellow",
 "put": "yellow",
 "get": "blue"
};

# Colors text with the given color
# colored_text("some text"; "red")
# will output 
# \u001b[31msome text\u001b[0m
# WARNING parameters are separated by ; not ,
def colored_text(text; color):
  colors[color] + text + colors.reset;

# Colors a HTTP method (using colored_text)
# colored_http_method("get")
def colored_http_method(method):
  colored_text(method; http_method_colors[method]);

# Prints operations in SwaggerUI like style
def oas_operations_to_colored_text:
  map( # Applies a transformation to each element
    if .original.deprecated then
      colored_text(
        .method + "\t" + .path + "\t" + .summary + " (deprecated)"; 
        "disabled"
      )
    else
      colored_http_method(.method) + "\t" + 
      .path + "\t" 
      + colored_text(.summary; "darkgray")
    end
  )
  [] # Flattens array for raw output
;