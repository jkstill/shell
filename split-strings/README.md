
Splitting Strings in Bash
=========================

Cutting a one or more elements out of a delimited string is a common task in shell scripting.

It is easily done with cut, awk, IFS, or tr.

Here though we want to split a string into an array.
--------------------------------

Given a string of csv data like this as read from a file

```bash
item1,item2,item3,item4
apple,banana,cherry,date
```

we can split it into an array using the following methods.

Using IFS and read
----------------------

```bashbash
#!/bin/bash
IFS=',' read -r -a array < <( tail -n +2 data.csv | head -n 1 )
for element in "${array[@]}"; do
    echo "$element"
done
```

Using IFS and a loop
----------------------  

```bash
#!/bin/bash
input="$( tail -n +2 data.csv | head -n 1 )"
echo "input: $input"

IFS=',' 
for element in $input
do
    echo "$element"
done
unset IFS

```

Using mapfile (Bash 4+)
----------------------
mapfile reads lines from standard input into an array.

There is really no need to use mapfile for this task, but here is how you could do it.

```bash
#!/bin/bash

input="$( tail -n +2 data.csv | head -n 1 )"

IFS=',' read -r -a array <<< "$input"

mapfile -t array < <(printf '%s\n' "${array[@]}")

for element in "${array[@]}"; do
    echo "$element"
done
```

mapfile is more useful when reading multiple lines into an array, such as reading all lines from a file, or the files in a directory.

```bash
#!/bin/bash
mapfile -t lines < <(ls -1)
for line in "${lines[@]}"; do
    echo "$line"
done
```


Bash Parameter Expansion
------------------------
```bashbash
#!/bin/bash

input="apple,banana,cherry,date"

# split string into array on commas
# the space is necessary to create the array correctly
array=(${input//,/ })

for element in ${array[@]}; do
    echo "$element"
done

```








