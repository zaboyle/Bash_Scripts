#!/bin/bash

#this script runs all files beginning with the name "test"
#USAGE: $ ./run_test_files.sh <time_limit>
#IMPORTANT: DO NOT HAVE PRINT STATEMENTS IN TEST FILES. THIS WILL
#           CAUSE THE RETURN VALUE OF THE FUNCTION TO INCDLUE CHARACTERS,
#           WHICH WILL INTERFERE WITH THE ASSIGNING OF A PASS OR FAIL VALUE
#REQUIRES: 1) .cpp files containing the word "test" to be in the same directory
#          2) requires change to 'make' call if no makefile is provided. Makefile
#             is recommended due to dependencies of test executables while compiling
#          3) if using a Makefile, must name all executables the same name 
#             as the source file
#help section
if [ $# -eq 0 ]
    then
        echo "Error - must provide time limit argument"
        echo "USAGE: $ ./run_test_files <time_limit (sec)>"
        echo "--->be sure to remove all print statements from test files<---"
        exit
fi

echo "Running all tests..."
echo "Make sure test files do not contain print statements"
echo
echo
#compile all tests with correct individual dependencies
make all;
#this runs all .cpp files in the current directory containing the word "test"
for filename in *test*.cpp; do
    #get the name of the executable we want to call it (remove the .cpp extension)
    file=$(echo "$filename" | cut -f 1 -d '.');
    #compile into an executable (use makefile if available due to dependencies)
	#g++ $filename -o $file;
    #give executable permission
    chmod +x $file;
    #get the exit status of running the executable
	VAR=$(~/../../usr/bin/timeout $1 ./$file)$?
    echo "running "$file"..."
	case $VAR in
	"0")
		echo "PASSED"
		;;
    "1")
		echo "FAILED"
		;;
	"124")
		echo "TIMEOUT"
		;;
	*)
		echo "Exit status is: "$VAR
	esac
done