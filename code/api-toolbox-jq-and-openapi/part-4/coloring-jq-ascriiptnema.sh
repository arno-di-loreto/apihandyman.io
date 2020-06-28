# TITLE: API Toolbox - JQ and OpenAPI - Coloring JQ output
# ROOT: apihandyman.io
# SECTION: colors in terminal
# Before coloring jq's output, I had to learn to color text in terminal with a good old echo
echo 'Hello World'
# Let's do the same in red
echo '\e[31mHello\e World'
# Oops, bash does not output colors by default with echo, we need to add -e flag
echo -e '\e[31mHello World'
# That's better. Now let's keep only Hello in red
echo -e '\e[31mHello\e[0m World'
# Printing Hello in color is done by concatenating:
# \\e escape character
# [31m red color code
# Hello
# \\e escape character
# [0m reset code which makes style back to normal
# SECTION: colors in jq
# Now let's try something similar with jq
echo '{"greeting": "Hello", "who": "World"}' | jq '.greeting + " " + .who'
echo '{"greeting": "Hello", "who": "World"}' | jq '"\e[31m" + .greeting + "\e[0m" + " " + .who'
# 🤔 It looks like jq does not like \\e escape character, let's try its unicode equivalent \\u001b
echo '{"greeting": "Hello", "who": "World"}' | jq '"\u001b[31m" + .greeting + "\u001b[0m " + .who'
# Not working ... 🤦🏻‍♂️ I forgot -r flag
echo '{"greeting": "Hello", "who": "World"}' | jq -r '"\u001b[31m" + .greeting + "\u001b[0m " + .who'
# That's cool but unicode escape character and color codes are terrible to write
# SECTION: color module
# Hopefully I wrote a module with a colored_text function to simplify that
echo '{"greeting": "Hello", "who": "World"}' | jq -r 'include "module-color"; colored_text(.greeting;"red") + " " + .who'
# Here's how it works
# An escape variable contains the unicode escape character
jq -n 'include "module-color";escape'
# A colors variable contains some color code with user friendly name like red or blue
jq -n 'include "module-color";colors["red"]'
jq -n 'include "module-color";colors["blue"]'
# And also the reset code 
jq -n 'include "module-color";colors.reset'
# The colored_text function concatenates all this
jq -n 'include "module-color";escape + colors["red"] + "text" + escape + colors.reset'
# And with -r flag, color obviously appears
jq -r -n 'include "module-color";escape + colors["red"] + "text" + escape + colors.reset'
# And now let's call colored_text:
jq -r -n 'include "module-color";colored_text("text";"blue")'
