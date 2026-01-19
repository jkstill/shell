
# Parameter Expansion in Bash

Reference:
[Bash Parameters](https://man7.org/linux/man-pages/man1/bash.1.html#PARAMETERS)

Following are some examples to go the with the explanations of Parameter Expansion in Bash, as seen in the link previous.

This is in no way a complete explanation of Parameter Expansion, but rather a few useful examples.

Read the man page for more details, and you will see that parameter expansion is a very powerful feature of Bash.

Most examples here are in reference to the following:

- setting default values for variables
- string manipulation

A full treatment of parameter expansion is beyond the scope of this document, and it would be quite a lengthy document indeed.

This document and scripts are found at: (Parameter Expansion)[https://github.com/jkstill/shell/tree/main/parameter-expansion]

## Use Default Values

- ${parameter:-word} 

If parameter is unset or null, the expansion of word is substituted.  Otherwise, the value of parameter is substituted.

You can use this to provide default values for variables that may not be set.

pe01.sh:

```bash
#!/usr/bin/env bash

DEBUG="${DEBUG:-'NO'}"
echo "DEBUG: $DEBUG"
```

Now run the script without setting DEBUG:

```bash
$ chmod u+x pe01.sh

$ ./script.sh
DEBUG: NO
```
Now run the script with DEBUG set:

```bash
$ DEBUG='YES' ./script.sh
DEBUG: YES
```

## Assign Default Values

- ${parameter:=word}

Assign Default Values.  If parameter is unset or null, the expansion of word is assigned to parameter, 
and the expansion is the final value of parameter. 
Positional parameters and special parameters may not be assigned in this way.

I have used this method to set default values for variables that may not be set.

pe02.sh:

```bash
#!/usr/bin/env bash
echo "Before: VAR='$VAR'"
VAR="${VAR:="default_value"}"
echo "After: VAR='$VAR'"
```
Now run the script without setting VAR:

```bash
$ ./pe02.sh
Before: VAR=''
After: VAR='default_value'
```
Now run the script with VAR set:

```bash
$ VAR='custom_value' ./pe02.sh
Before: VAR=''
After: VAR='custom_value'
```

I have also used '${parameter:-word}' to provide default values without assigning them.

The difference is that '${parameter:=word}' assigns the default value to the variable if it is not set.

This can be illustrated as follows:

p01-b.sh:

```bash
#!/usr/bin/env bash

echo "MYDEBUG: $MYDEBUG"
DEBUG="${MYDEBUG:-'NO'}"
echo "DEBUG: $DEBUG"
echo "MYDEBUG: $MYDEBUG"
```

When you run this script without setting MYDEBUG, you will see that DEBUG gets the default value, but MYDEBUG remains unset:

```bash
$ ./p01-b.sh
MYDEBUG:
DEBUG: NO
MYDEBUG:
```

pe02-b.sh is nearly the same, but uses ':=' instead of ':-':

```bash
#!/usr/bin/env bash

echo "MYDEBUG: $MYDEBUG"
DEBUG="${MYDEBUG:='NO'}"
echo "DEBUG: $DEBUG"
echo "MYDEBUG: $MYDEBUG"
```
```
When you run this script without setting MYDEBUG, you will see that both DEBUG and MYDEBUG get the default value:

```bash
$ ./pe02-b.sh
MYDEBUG:
DEBUG: NO
MYDEBUG: NO
```

## Display Error if Null or Unset

- ${parameter:?word} 

Display Error if Null or Unset.  If parameter is null or unset, the shell writes the expansion of 
word (or a message to that effect if word is not present) to the standard error and, if it is 
not interactive, exits with a non-zero status.  An interactive shell does not exit, but does not 
execute the command associated with the expansion.  Otherwise, the value of parameter is substituted.

This can be used to ensure that required variables are set before proceeding.

pe03.sh:

```bash
#!/usr/bin/env bash
: "${MY_ORACLE_HOME:?MY_ORACLE_HOME is not set or is null}"
echo "MY_ORACLE_HOME is set to '$MY_ORACLE_HOME'"

```
Now run the script without setting REQUIRED_VAR:

```bash
$ ./pe03.sh
./pe03.sh: line 3: MY_ORACLE_HOME: MY_ORACLE_HOME is not set or is null
```

Now run the script with REQUIRED_VAR set:

```bash
$  MY_ORACLE_HOME=$ORACLE_HOME ./pe03.sh
MY_ORACLE_HOME is set to '/u01/app/oracle/product/19c'
```

## Use Alternate Value

- ${parameter:+word} Use Alternate Value

Use Alternate Value.  If parameter is null or unset, nothing is substituted, otherwise the expansion 
of word is substituted.  The value of parameter is not used.

This can be used to provide an alternate value when a variable is set.

One possible use is to determine if variables have been set.

pe04.sh:

```bash
#!/usr/bin/env bash

A_OK=0
A_OK="${A:+1}"

B_OK=0
B_OK="${B:+1}"

echo "A_OK = $A_OK"
echo "B_OK = $B_OK"


# test if both A and B are set
if [[ $A_OK -eq 1 && $B_OK -eq 1 ]]; then
	 echo "Both A and B are set."
	 exit 0
fi
# test if only A is set
if [[ $A_OK -eq 1 && $B_OK -eq 0 ]]; then
	 echo "Only A is set."
	 exit 1
fi
# test if only B is set
if [[ $A_OK -eq 0 && $B_OK -eq 1 ]]; then
	 echo "Only B is set."
	 exit 2
fi

# test if neither A nor B is set
if [[ $A_OK -eq 0 && $B_OK -eq 0 ]]; then
	 echo "Neither A nor B is set."
	 exit 3
fi
```

Now run the script with different combinations of A and B set:

```bash
$  A=OK B=OK ./pe04.sh
A_OK = 1
B_OK = 1
Both A and B are set.

$  A= B=OK ./pe04.sh
A_OK =
B_OK = 1
Only B is set.

$  A=OK B= ./pe04.sh
A_OK = 1
B_OK =
Only A is set.

$  A= B= ./pe04.sh
A_OK =
B_OK =
Neither A nor B is set.
```

This seems a bit convoluted, but it works. This is not a parameter expansion that I can recall using.

Perhaps you have a better use for it?

## String Handling

Up until now, the examples have followed the order seen in the Bash documentation.

Now though there are several string handling parameter expansions would be better grouped together.

### Substring Expansion

- ${parameter:offset} 
- ${parameter:offset:length} 

Substring Extraction.  Expands to up to length characters of the value of parameter starting at the character specified by offset.  

The first character is at offset 0.  If length is omitted, the substring continues to the end of the value of parameter.  
If offset evaluates to a negative number, the starting position is determined by counting backward from the end of the value.  
If length evaluates to a negative number, then that many characters are omitted from the end of the value.    
This can be used to extract substrings from variables.

The explanation in the Bash documentation is is much longer than this due to the robust nature of this feature, and I will not reproduce it all here.

pe05.sh:

```bash
#!/usr/bin/env bash
myString="Hello, World!"
# count from the 7th position, get 5 characters
subString1="${myString:7:5}"
# count backwards from the end, get 5 characters
subString2="${myString: -6:5}"
echo "  myString: $myString"
echo "subString1: $subString1"
echo "subString2: $subString2"
```

Now run the script:
```bash
$ ./pe05.sh
Original String: Hello, World!
Substring1: World
Substring2: World
```

### Parameter Length

- ${#parameter}

Parameter Length.  Expands to the length of the value of parameter.  

pe06.sh:

```bash
#!/usr/bin/env bash

myString="Hello, World!"
stringLength=${#myString}

echo "The length of the string is: $stringLength"
```

Now run the script:
```bash
$ ./pe06.sh
The length of the string is: 13
```

### Remove matching prefix/suffix pattern

- ${parameter#word}
  - Remove Smallest Prefix Pattern
- ${parameter##word}
  - Remove Largest Prefix Pattern
- ${parameter%word}
  - Remove Smallest Suffix Pattern
- ${parameter%%word}
  - Remove Largest Suffix Pattern


Keep the following in mind when using these expansions:

`%` and `%%` remove from the end of the string (suffix)

`#` and `##` remove from the beginning of the string (prefix)

When there is a single symbol (`%` or `#`), the smallest matching pattern is removed.

When there are double symbols (`%%` or `##`), the largest matching pattern is removed.

Even with explanations, using these expansions can be confusing. It does take some practice to get used to them.

The following filename is used in these examples: 'benoit-01_backup_20240615-153045.tar.gz'

#### Remove the largest prefix pattern

```bashbash
myFile="benoit-01_backup_20240615-153045.tar.gz"
noPrefix="${myFile##*_}"
echo "noPrefix: $noPrefix"
```
This will remove everything up to and including the last underscore, resulting in:
```
noPrefix: 20240615-153045.tar.gz
```

#### Remove the smallest prefix pattern

```bash
myFile="benoit-01_backup_20240615-153045.tar.gz"
noPrefix="${myFile#*_}"
echo "noPrefix: $noPrefix"

```
This will remove everything up to and including the first underscore, resulting in:
```
noPrefix: backup_20240615-153045.tar.gz
```

#### Remove the largest suffix pattern

```bashbash
myFile="benoit-01_backup_20240615-153045.tar.gz"
noSuffix="${myFile%%.*}"
echo "noSuffix: $noSuffix"
```
This will remove everything from the first dot to the end, resulting in:
```
noSuffix: benoit-01_backup_20240615-153045
```
#### Remove the smallest suffix pattern

```bash
myFile="benoit-01_backup_20240615-153045.tar.gz"
noSuffix="${myFile%.*}"
echo "noSuffix: $noSuffix"
```
This will remove everything from the last dot to the end, resulting in:

```
noSuffix: benoit-01_backup_20240615-153045.tar
```

#### Extract information from the filename

pe08.sh:

```bash
#!/usr/bin/env bash

myFile="benoit-01_backup_20240615-153045.tar.gz"

# get the greatest suffix after the first dot
extension="${myFile#*.}"

echo "extension: $extension"

# get the filename without the extension
filename="${myFile%%.*}"
echo "filePart: $filename"

IFS='_' read -r server fileType timeStamp <<< "$filename"

echo "server: $server"
echo "fileType: $fileType"
echo "timeStamp: $timeStamp"
```

Results:

```bash
$  ./pe08.sh
extension: tar.gz
filePart: benoit-01_backup_20240615-153045
server: benoit-01
fileType: backup
timeStamp: 20240615-153045
```

#### Example Script

The following script will use matching prefix and suffix patterns to derive information from a backup file name.

pe07.sh:
```bash
#!/usr/bin/env bash

# desconstruct a backup filename into its components

echo
echo Assume a server name of benoit-01.example.com
echo
echo The file name is created with this template: 
echo '$(hostname -s)_backup_$(date +%Y%m%d-%H%M%S).tar.gz'
echo
echo "filename example: benoit-01_backup_20240615-153045.tar.gz"
myFile="benoit-01_backup_20240615-153045.tar.gz"

noSuffix1="${myFile%.*}"
# Remove largest suffix pattern
noSuffix2="${myFile%%.*}"

# get the suffix and remove the dot
suffix1="${myFile#${noSuffix1}}" && suffix1="${suffix1:1}"
suffix2="${myFile#${noSuffix2}}" && suffix2="${suffix2:1}"

suffix=''; noSuffix=''

[[ $noSuffix1 == $noSuffix2 ]] && {
	suffix="$suffix1"
	noSuffix="$noSuffix1"
} || {
	# for instance with .tgz and .tar.gz
	suffix="$suffix2"
	noSuffix="$noSuffix2"
}

# extract the server name
serverName="${noSuffix%%_*}"

# extract the type of file, ie. 'backup'
# remove the server name and the underscore
restOfFile="${noSuffix#${serverName}_}"
# remove from remaining string everything after the first underscore 
fileType="${restOfFile%%_*}"

# extract the backup timestamp
# remove everything up to the last underscore
backupTimestamp="${noSuffix##*_}"

cat <<-EOF

         Filename: $myFile
      Server name: $serverName
        File type: $fileType
 Backup timestamp: $backupTimestamp
        Extension: $suffix

EOF

```
Now run the script:

```bash
$  ./pe07.sh

Assume a server name of benoit-01.example.com

The file name is created with this template:
$(hostname -s)_backup_$(date +%Y%m%d-%H%M%S).tar.gz

filename example: benoit-01_backup_20240615-153045.tar.gz

         Filename: benoit-01_backup_20240615-153045.tar.gz
      Server name: benoit-01
        File type: backup
 Backup timestamp: 20240615-153045
        Extension: tar.gz

```

This may seem like a lot of work for something that could be done with 'cut' or 'awk', but it is a good illustration of the power of parameter expansion.

In many cases, using tools like 'cut' or 'awk' may be fine for quick and dirty scripts, but using parameter expansion can be more efficient and portable.

Consider if the script needs to process a few thousand files, the overhead of calling external commands can add up.


The `pe07.sh` was modified by adding a loop around the code code, and it will run for 100,000 iterations.

The pure bash version runs in ~ 3 seconds.


```bash
$  ./pe07-parameter-expansion.sh

Assume a server name of benoit-01.example.com

The file name is created with this template:
$(hostname -s)_backup_$(date +%Y%m%d-%H%M%S).tar.gz

filename example: benoit-01_backup_20240615-153045.tar.gz

real	0m3.037s
user	0m2.996s
sys	0m0.005s

         Filename: benoit-01_backup_20240615-153045.tar.gz
      Server name: benoit-01
        File type: backup
 Backup timestamp: 20240615-153045
        Extension: tar.gz

```

The same logic implemented with 'cut' and 'awk' runs in several (as yet unknown) minutes.

The linux tools version took slightly longer, at 24 minutes and 22 seconds.

```bash
$  ./pe07-linux-tools.sh

Assume a server name of benoit-01.example.com

The file name is created with this template:
$(hostname -s)_backup_$(date +%Y%m%d-%H%M%S).tar.gz

filename example: benoit-01_backup_20240615-153045.tar.gz

real	24m22.601s
user	14m49.115s
sys	18m5.258s

         Filename: benoit-01_backup_20240615-153045.tar.gz
      Server name: benoit-01
        File type: backup
 Backup timestamp: 20240615-153045
        Extension: tar.gz
```


There are many methods that could be used for this. 

Yet another method is found in `pe07-function.sh`, which uses `read -a -r` to split the filename into an array.

At 25 seconds, there is still a significant performance difference this and using parameter expansion.

```bash
$  ./pe07-function.sh

Assume a server name of benoit-01.example.com

The file name is created with this template:
$(hostname -s)_backup_$(date +%Y%m%d-%H%M%S).tar.gz

filename example: backups/db/benoit-01_backup_20240615-153045.tar.gz

real	0m25.181s
user	0m14.395s
sys	0m8.924s

         Filename: benoit-01_backup_20240615-153045.tar.gz
      Server name: benoit-01
        File type: backup
 Backup timestamp: 20240615-153045
        Extension: tar.gz
```

## Conclusion

Parameter expansion is a powerful feature of Bash that can be used for a variety of tasks, including setting default values, string manipulation, and error handling.
By mastering parameter expansion, you can write more efficient and robust shell scripts.


