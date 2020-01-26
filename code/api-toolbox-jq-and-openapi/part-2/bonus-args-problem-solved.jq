# Defines parameters and their default values
def default_parameters:
{
  foo: null,
  bar: null
};

(# Initializes parameters based on provided args
  # If a parameter is not provided, its default value is used
  default_parameters | 
  # Updates values for provided parameters
    # $ARGS contains all --arg parameters
    # if no "name" parameter is provided $name cause an error but
    # $ARGS["name"] returns null without error
  with_entries( .value = $ARGS.named[.key])
) as $parameters | 
# Now we don't care if args are not provided
{ foo: $parameters.foo, bar: $parameters.bar}