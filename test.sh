if ! [ $(find . -name $1) ]
then
	echo "error, file not found"
	exit
fi
