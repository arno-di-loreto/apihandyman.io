# Basic value replacement using =
(.info.description = "New description.") | # modified document
                                           # goes to next step
# Using processing when setting value
(.info.version = (.info.version | sub("-snapshot";"-no-snapshot"))) |
# Any type of value can be provided on right side of =
(
  .info.contact = { 
                    name: "The Awesome Banking API Team", 
                    email: "www.bankingcompany.com"
                  }
) |
# |= can also be used to only work on what is provided on left side
(.info.version |= sub("-no-snapshot";"")) |
# It works on objects too
(
  .info.contact |= { 
                    name, # unmodified 
                    url: .email, # path of value inside .info.contact
                    email: "api@bankingcompany.com"
                  }
)