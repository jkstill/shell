
# Tokenize on the command line

Sometimes it is necessary to tokenize the output of a command.

Consider the following; I want to see only the v$ (oracle internal view) objects that appear in some scripts.

```bash

$  find . -name "*.pl"| xargs grep -i 'v\$'
./vsql-idx-old.pl:from gv$sql_plan
./deprecated/ct-index-insert.pl:        # first look in gv$sql
./deprecated/ct-index-insert.pl:        # How to get full sql text statement from v$sql (Doc ID 437304.1)
./deprecated/ct-index-insert.pl:from gv$sql
./deprecated/ct-index-insert.pl:        from gv$sql_plan
./deprecated/ct-index-insert.pl:        # first look in gv$sql_plan
./index-compare-old.pl: select value block_size from v$parameter where name = 'db_block_size'
./vsql-idx.pl: Scan gv$sql_plan for rows with a timestamp GT than the value found in last-timestamp.txt.
./vsql-idx.pl:  from gv$sql_plan
./vsql-idx.pl:  # first look in gv$sql_plan
./vsql-idx.pl:  from gv$sql_plan gsp
./vsql-idx.pl:  join gv$sql gs on gs.sql_id = gsp.sql_id
./vsql-idx.pl:  my $sql = q{select sql_fulltext from gv$sqlstats where sql_id = ? and inst_id = ?};
./t.pl:my $sql = q{select dbms_lob.substr(sql_fulltext,1,} . $MAX_LOB_LEN . q{) sql_fulltext from gv$sqlstats where sql_id = ? and inst_id = ?};
./token-test-2.pl: Scan gv$sql_plan for rows with a timestamp GT than the value found in last-timestamp.txt.
./token-test-2.pl:      from gv$sql_plan gsp
./token-test-2.pl:      join gv$sql gs on gs.sql_id = gsp.sql_id
./token-test-2.pl:      my $sql = q{select sql_fulltext from gv$sqlstats where sql_id = ? and inst_id = ?};

```

What I really wanted though was just the names, not the lines.

There is a good dicussion on this topic at Stack Overflow

[How to split words at the Unix Command Line?](https://stackoverflow.com/questions/15501652/how-split-a-file-in-words-in-unix-command-line)

A couple of the methods are quite good.

## tr

The venerable _tr_ program accomplishes this task with aplomb.

This method will probably work on any unix like system, as _tr_ has been part of the core Unix utility set for as long as I can remember (1983) and for many years prior.

The method shown in the Stack Overflow discussion:

```bash

tr -s '[[:punct:][:space:]]' '\n' < file

```

For my purposes, it works better without the _[[:punct:]]_ set, as '$' is punctuation, and part of the word I am looking for.

```bash

$ find . -name "*.pl" -print0 | xargs -0  grep -i 'v\$' | tr -s '[[:space:]]' '\n' | sort | uniq -c | grep -i 'v\$'
      4 gv$sql
      9 gv$sql_plan
      3 gv$sqlstats
      1 v$parameter
      1 v$sql

```

Breaking down the command:

Find all perl scripts in all directories, beginning with the current directory.

The '-print0' argument ends each output line with a null rather than a linefeed.
In the next stop this will allow xargs to deal with files that may have spaces in the name.
(.shist files anyone?)

``` bash
$ find . -name "*.pl" -print0 
```

xargs is now invoked to run grep on each of the files found.
The '-0' argument is required when _find -print0_ is used.

``` bash
 | xargs -0  grep -i 'v\$' 
```

Now use _tr_ to split the input on spaces and add a linefeed after each split

``` bash
 | tr -s '[[:space:]]' '\n' 
```

Now use _sort | uniq_ to get a count showing how many times the term was found

``` bash
 | sort | uniq -c 
```

Now finally show just the terms wanted.

``` bash
 | grep -i 'v\$'
```


## fmt

_fmt_ was also discussed, and this is a new one to me.

The command line is similar, replacing _tr_ with _fmt_:

```bash

$ find . -name "*.pl"| xargs grep -i 'v\$' | fmt -1 | sort | uniq -c | grep -i 'v\$'
      4 gv$sql
      9 gv$sql_plan
      3 gv$sqlstats
      1 v$parameter
      1 v$sql
```

While this also works, I would lean toward the ubiquity of _tr_, as _fmt_ is a relatively new program in the GNU Coreutils and may not found on AIX, HPUX, etc.




