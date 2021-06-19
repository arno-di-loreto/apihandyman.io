# += adds anything to an existing value
# String concatenation
# Equivalent to 
#   .info.contact.name = .info.contact.name + " is awesome"
#   .info.contact.name |= . + " is awesome"
(.info.contact.name += " is awesome") | # Equivalent to .info.contact.name = .info.contact.name + " is awesome"
# Adding a property
(.info.contact += {"x-slack": "api-team" }) |
# Adding a property and updating existing name
(.info.contact += {"x-fax": "555-06-777", name: "The Awesome Banking API team"})

