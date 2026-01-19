
Save this bit for a different article

## Arrays

### Array Slicing with Parameter Expansion
This can be used to extract slices from arrays.
pe06.sh:

```bash#!/usr/bin/env bash
#!/usr/bin/env bash
echo "declare -a ary=( the quick brown fox jumps over the lazy dog )"
declare -a ary=( the quick brown fox jumps over the lazy dog )
# show all words using a for loop
echo
echo "All words in the array:"
i=0
for word in "${ary[@]}"; do
      printf "  %02d: %s\n"  $i $word
      (( ++i ))
done
echo
echo "get a slice of the array with parameter expansion"
slice=("${ary[@]:2:4}")
echo "The slice is: ${slice[@]}"
echo
```


### ${parameter:offset} ${parameter:offset:length}

This expansion appears again, but this time in array context.

pe05-b.sh:

```bash#!/usr/bin/env bash 
#!/usr/bin/env bash

echo "declare -a ary=( the quick brown fox jumps over the lazy dog )"

declare -a ary=( the quick brown fox jumps over the lazy dog )

# show all words using a for loop
echo
echo "All words in the array:"
i=0
for word in "${ary[@]}"; do
	  printf "  %02d: %s\n"  $i $word
	  (( ++i ))
done

echo
echo "get the fourth word with parameter expansion"
word="${ary[@]:3:1}"
echo "The fourth word is: $word"
echo

echo "get the fifth sixth words with parameter expansion"
word="${ary[@]:4:2}"
echo "The fifth sixth words are: $word"
echo 

```

# ${#parameter} Parameter Length




