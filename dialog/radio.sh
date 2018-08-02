

pname=$(basename $0 | cut -f1 -d\. )
oname=${pname}${$}.out
tname=${pname}${$}.tmp

dialog --radiolist 'Please choose' 20 40 5  \
	tag1 item1 off \
	tag2 item2 off \
	tag3 item3 off \
	tag4 item4 off \
	tag5 item5 off 2>$oname

cat $oname
rm $oname



