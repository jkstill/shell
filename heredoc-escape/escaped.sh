#!/bin/bash

typeset -i globalTestNum=0

showTest () {
	(( globalTestNum++ ))
	echo "==== test $globalTestNum ===="
}

:<<'COMMENT'

Show how using the escape character in EOF can be used just once.

This will not be useful where there is a mix of literal $ (v$user) and symbolic ($someEnvVar)

COMMENT

testVar='this is a test'

showTest
cat <<-EOF

	What is displayed?  Var name or value?

	$testVar

EOF

showTest
cat <<-\EOF

	What is displayed?  Var name or value?

	$testVar

EOF


showTest
cat <<-\EOF

	Here is a mix of literal and symbolic $
	This escape \EOF is not useful in this case

	\$testVar = $testVar

EOF


showTest
cat <<-EOF

	Here is a mix of literal and symbolic $
	The escape is removed from EOF, and now the display is correct

	\$testVar = $testVar

EOF


