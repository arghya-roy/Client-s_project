#!/bin/bash
if [ -s dormant_users.txt ]; then
    echo "coping"
    cat hrusers.txt >> dormant_users.txt
else
   
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
fi
   