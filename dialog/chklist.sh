
pname=$(basename $0 | cut -f1 -d\. )
oname=${pname}${$}.out

dialog --separate-output --checklist 'Please choose' 20 40 5  \
	tag1 item1 off \
	tag2 item2 off \
	tag3 item3 on \
	tag4 item4 off \
	tag5 item5 off 2>$oname

cat $oname

rm $oname

