# TITLE: API Toolbox - JQ and OpenAPI - Coloring JQ output
# ROOT: apihandyman.io
# SECTION: jq colors
echo '{ "hello": "world" }' | jq '.hello'
echo '{ "hello": "world" }' | jq '"\e[31m" + .hello + "\e[0m"'
echo '{ "hello": "world" }' | jq '"\u001b[31m" + .hello + "\u001b[0m"'
echo '{ "hello": "world" }' | jq -r '"\u001b[31m" + .hello + "\u001b[0m"'
