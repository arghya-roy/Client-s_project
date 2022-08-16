#!/bin/bash

# #to take last 2 lines content from a file
# var1=$(tail -2 dormant_users.txt)
# echo "${var1}"

# #to take last non empty line content
# var2=$(tac file1.txt |egrep -m 1 .)

# # see matching lines in both files
# grep -F -f dormant_users.txt hrusers.txt
# echo


# # see non-matching lines in both files
# grep -v -f dormant_users.txt hrusers.txt
# echo


# # using wc command to count number of lines
# number_of_lines=`wc --lines < dormant_users.txt`
# echo "${number_of_lines}"
# echo


# #https://stackoverflow.com/questions/10589929/find-the-line-number-where-a-specific-word-appears-with-grep

# #to see line number of 'b' in the file
# sed -n '/b/=' dormant_users.txt
# echo

# #to start at line 10 and print the line number and line for matching 'k', 
# sed -n '10,$ { /k/ { =; p; } }' dormant_users.txt
# echo

# #to start at line 10 and print line for matching 'k'
# sed -n '10,$ { /k/= }' dormant_users.txt


# #copy line 10 to end from file1 to file2
# var2=$(tac file1.txt |egrep -m 1 .)
# echo $var2
# var3=$(sed -n /${var2}/= file1.txt)
# echo $var3
# sed -n 10,${var3}p file1.txt > file2.txt
# echo

# #will produce no output if file1 contains all the lines in file2 and exit with status 0, otherwise it will print something like
# diff -q <(sort -u file2.txt) <(grep -Fxf file2.txt file1.txt | sort -u)


#SCRIPT-

#pick up content of last non-empty line content of dormant_users -
last_non_empty_content_dormant_users=$(awk '/./{line=$0} END{print line}' dormant_users.txt)
echo "Last non empty content of dormant_users is = ${last_non_empty_content_dormant_users}"

#pick up line number of last non-empty line content of dormant_users -
line_number_of_last_non_empty_content_dormant_users=$(sed -n /${last_non_empty_content_dormant_users}/= dormant_users.txt)
echo "Line number of last non empty content of dormant_users is = ${line_number_of_last_non_empty_content_dormant_users}"

#pick up line number of hrusers where last line of dormant_users exists -
line_number_of_hrusers_where_last_line_of_dormant_users_exists=$(sed -n /${last_non_empty_content_dormant_users}/= hrusers.txt)
echo "line number of hrusers where last line of dormant users exists = ${line_number_of_hrusers_where_last_line_of_dormant_users_exists}"

#pick up content of last non-empty line content of hrusers -
last_non_empty_content_hrusers=$(awk '/./{line=$0} END{print line}' hrusers.txt)
echo "Last non empty content of hrusers is = ${last_non_empty_content_hrusers}"

#pick up line number of last non-empty line content of hrusers -
line_number_of_last_non_empty_content_hrusers=$(sed -n /${last_non_empty_content_hrusers}/= hrusers.txt)
echo "Line number of last non empty content of hrusers is = ${line_number_of_last_non_empty_content_hrusers}"

#coping content from line number of hrusers where last line of dormant_users exists to line number of last non-empty line content of hrusers
copy_from=$((${line_number_of_hrusers_where_last_line_of_dormant_users_exists} + 1))
echo "The content of hrusers coping from line number = ${copy_from}"

copy_to=${line_number_of_last_non_empty_content_hrusers}
echo "The content of hrusers coping to line number = ${copy_to}"
sed -n ${copy_from},${copy_to}p hrusers.txt > dormant_users.txt