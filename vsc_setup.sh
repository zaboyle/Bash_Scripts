#Visual Studio Code C++ Debugging setup script

#===========
#HOW TO USE:
#
#   run script with first argument as filename you wish to debug
#   general format:
#
#           $ sh vsc_setup.sh <filename>
#
#example:
#           $ sh vsc_setup.sh main.cpp
#
#OR
#    to create a shortcut for this script, insert the following into
#    your .bashrc or .bash_profile files:
#
#           alias <shortcut_name>="sh <path/to/location/of/file>"
#
#   if you have done this, you can now run the command as:
#     
#           <shortcut_name> <filename>
#
#IMPORTANT:
# the debugging session must be done by opening the folder the .cpp file
# is in. Do this via file->openFolder
#
#===========================================

#do not allow these files to be created if the input file
#doesn't exist in this directory
if ! [ $(find . -name $1) ]
then
    echo "Must specify a file in your directory.\n"
    exit
fi

#if no .vscode directory exists, make one
mkdir -p .vscode

#L represents launch file
#T for tasks file
L=".vscode/launch.json"
T=".vscode/tasks.json"

#the filename
FILE=$1
#cuts off the file extension from the inpputted file
EXECUTABLE=${1%.*}.exe
#REPLACE THESE WITH YOUR PATHS
PATH_TO_GDB="C:/MinGW-CPTR-124/bin/gdb.exe"
PATH_TO_GPP="C:/MinGW-CPTR-124/bin/g++.exe"

#make the launch file. If one already exists, it will be overwritten
echo "{\n\t\"version\": \"0.2.0\",\n\t\"configurations\": [\n\t\t{" > $L
echo "\t\t\t\"name\": \"(gdb) Launch\",\n\t\t\t\"type\": \"cppdbg\",\n\t\t\t\"request\": \"launch\"," >> $L
echo "\t\t\t\"program\": \"\${workspaceRoot}/$EXECUTABLE\",\n\t\t\t\"args\": [\n\t\t\t\t\"comma-separated-list-of-args-here\"\n\t\t\t]," >> $L
echo "\t\t\t\"stopAtEntry\": false,\n\t\t\t\"cwd\": \"\${workspaceFolder}\",\n\t\t\t\"environment\": []," >> $L
echo "\t\t\t\"externalConsole\": true,\n\t\t\t\"MIMode\": \"gdb\",\n\t\t\t\"miDebuggerPath\": \"$PATH_TO_GDB\"," >> $L
echo "\t\t\t\"preLaunchTask\": \"build $EXECUTABLE\",\n\t\t\t\"setupCommands\": [\n\t\t\t\t{" >> $L
echo "\t\t\t\t\t\"description\": \"Enable pretty-printing for gdb\",\n\t\t\t\t\t\"text\": \"-enable-pretty-printing\"," >> $L
echo "\t\t\t\t\t\"ignoreFailures\": true\n\t\t\t\t}\n\t\t\t]\n\t\t}\n\t]\n}" >> $L

#make the task file. If one already exists, it will be overwritten
echo "{\n\t\"version\": \"2.0.0\",\n\t\"tasks\": [\n\t\t{\n\t\t\t\"label\": \"build $EXECUTABLE\"," > $T
echo "\t\t\t\"type\": \"shell\",\n\t\t\t\"command\": \"$PATH_TO_GPP\",\n\t\t\t\"args\": [" >> $T
echo "\t\t\t\t\"-g\",\n\t\t\t\t\"$FILE\",\n\t\t\t\t\"-o\",\n\t\t\t\t\"$EXECUTABLE\"\n\t\t\t]," >> $T
echo "\t\t\t\"group\": {\n\t\t\t\t\"kind\": \"build\",\n\t\t\t\t\"isDefault\": true\n\t\t\t}," >> $T
echo "\t\t\t\"problemMatcher\": \"\$msCompile\"\n\t\t}\n\t]\n}" >> $T
