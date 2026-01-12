
Examples of determining just where a Bash script is executing from in the directory structure.

Examples of readlink and realpath are used.

The results of one may or may not be what you want or expect.

## Create directory structure

```text
mkdir -p p1/p2/p3
ln -s  p1/p2/p3 t1
```

The test scripts are in `p1/p2/p3`.

## readlink -f

Using readlink -f to determine the script home directory, the directory appears the
save regardless of whether the script it run from `t1/` or `p1/p2/p3/`.

```bash

```text
$  p1/p2/p3/script-home-test.sh
this is p1/p2/p3/script-home-test.sh
home: /home/jkstill/shell/script-home/p1/p2/p3

$  t1/script-home-test.sh
this is p1/p2/p3/script-home-test.sh
home: /home/jkstill/shell/script-home/p1/p2/p3


## realpath -s

With `realpath -s` the script home directory depends on where the script is run from.

```text
$  p1/p2/p3/script-home-realpath-test.sh
this is p1/p2/p3/script-home-realpath-test.sh
home: /home/jkstill/shell/script-home/p1/p2/p3

$  t1/script-home-realpath-test.sh
this is p1/p2/p3/script-home-realpath-test.sh
home: /home/jkstill/shell/script-home/t1

```


