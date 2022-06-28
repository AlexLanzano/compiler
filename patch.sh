for i in $1/*.patch; do patch -d $2 -t -p1 < $i; done
