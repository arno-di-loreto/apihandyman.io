# += adds anything to an existing value
# Here, += used for string concatenation
(.info.description += " Some new content for the description.") |
# Here, += used to add some property in an object
(.info += {"x-property": "example"})
# The fully modified document is returned on output