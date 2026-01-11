
All objects

jq '.[]'

Spinner Name and Daeta

jq 'to_entries[]'

Spinner Names Only

jq 'keys[]'

Get all Intervals

jq '.[].interval'

Get all Frames flattened

jq '.[].frames[]'

Spinner Name and Each Frame

jq 'to_entries[] | {name: .key, frames: .value.frames[]} '

better:
jq 'to_entries[] | .key as $k | .value.frames[] | "\($k): \(.)"'

Recursively walk everything (true "all elements")

jq '..'


Show JSON paths to every value

jq 'paths'

pretty: 
jq 'paths | join(".")'

Get all frames for a key using a variable
jq '.["Spinner Name"].frames[]'


# read all frames for spinner "dots" into a bash array 'dots'
readarray dots < <(jq --arg k dots '.[$k].frames[]' spinners.json)







