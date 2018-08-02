

pname=$(basename $0 | cut -f1 -d\. )
oname=${pname}${$}.out

dialog --calendar test 5 20 2>$oname

# change date from dd/mm/yyyy to mm/dd/yyyy
awk -F '/' '{ printf "%2.0f/%2.0f/%2.0f",$2,$1,$3 }' < $oname > $pname
mv $pname $oname

cat $oname
rm $oname

