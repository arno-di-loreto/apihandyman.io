# Initializes parameters based on provided named arguments (--arg).
# If an argument is not provided, its default value is used.
# default_values example:
# {
#   argument: "default value",
#   anotherArgument: null,
# }
def init_parameters(default_values):
  default_values | 
  # Updates values for provided parameters
  with_entries(
    # $ARGS contains all --arg parameters
    if $ARGS.named[.key] != null then 
      .value = $ARGS.named[.key] 
    else 
      .value = .value
    end
  )
;