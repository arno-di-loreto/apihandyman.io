# Files are easier to read and can be commented
# Creates an object
{
  name: .info.title, 
  version: .info.version, 
  contact: .info.contact.name
} |
# Outputs tab separated name and version
# + can be used to concatene almost everything
# (as you will see in later examples)
# Don't forget the -r flag
.name + "\t" + .version