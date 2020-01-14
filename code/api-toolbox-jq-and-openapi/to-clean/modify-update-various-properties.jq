# Basic value replacement using =
(.info.description = "New description.") | # modified document
                                           # goes to next step
# Using processing when setting value
(.info.version = (.info.version | sub("-snapshot";""))) |
# Any type of value can be provided on right side of =
(
  .info.contact = { 
                    name: "The Awesome Banking API Team", 
                    url: "www.bankingcompany.com"
                  }
) |
# += adds anything to an existing value
# Here, += used for string concatenation
(.info.description += " Some new content for the description.") |
# Here, += used to add some property in an object
(.info += {"x-property": "example"})
# The fully modified document is returned on output