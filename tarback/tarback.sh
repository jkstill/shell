:

DIR=$1

DEST=~/tarback

[ -z "$DIR" ] && {
	echo please supply a directory name to backup
	exit 1
}

[ -r "$DIR" ] || {
	echo unable to read $DIR
	exit 3
}

TAR="tar cvfz "
DATE=$(date +%Y-%m-%d_%H%M)
BASEDIR=$(basename $DIR)
TARFILE=${BASEDIR}_${DATE}.tgz

[ -x $DEST ] || { mkdir $DEST; }

[ -x $DEST ] || { 
	echo unable to create $DEST
	exit 2
}

CMD="$TAR $DEST/$TARFILE $DIR"

echo $CMD
$CMD

echo 
echo File: $DEST/$TARFILE
echo


