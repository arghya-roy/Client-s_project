# # Converting current time to second -
# current_time_to_second=$(date +%s)
# echo "current_time_to_second is ${current_time_to_second}"

# # Converting current time to milisecond -
# current_time_to_milisecond=$((current_time_to_second * 1000))
# echo "current_time_to_milisecond is ${current_time_to_milisecond}"

# # Time before 1 days in seconds -
# time_before_1_days_in_seconds=$(date -d '168 hour ago' '+%s') &&
# echo "time_before_1_days_in_seconds is ${time_before_1_days_in_seconds}"

# # Time before 1 days in miliseconds -
# time_before_1_days_in_miliseconds=$((time_before_1_days_in_seconds * 1000)) &&
# echo "time_before_1_days_in_miliseconds is ${time_before_1_days_in_miliseconds}"

# ### Filter GetObject eventName from cloudwatch log for last 1 days -

# #set variables to filter -
# log_group_name=s3-trail-log-1
# log_stream_name_prefix=201043775914_CloudTrail_ap-south-1
# start_time=$time_before_1_days_in_miliseconds
# end_time=$current_time_to_milisecond

# # filter and store the JSON output in a another file named output_initial.json -
#  aws logs filter-log-events --log-group-name $log_group_name --log-stream-name-prefix $log_stream_name_prefix --start-time $start_time --end-time $end_time --filter-pattern ["eventName"="*GetObject*"] > /tmp/output_initial.json

# # cut backslashes, extra quation from optput_initial.json and store it to output_final.json -
#  cat /tmp/output_initial.json | awk '{gsub(/\\/,"")}1' | awk '{gsub(/"{/,"{")}1' | awk '{gsub(/}"/,"}")}1' > /tmp/output_final.json

# # pick up file name which has been accessed within 7 days and store those in a variable file named file_path.txt -
# jq -r '.events[].message.requestParameters.key' /tmp/output_final.json > /tmp/file_path_initial.txt


# awk '!seen[$0]++' /tmp/file_path_initial.txt > /tmp/file_path_final.txt
# bucket_name=p2developer-proxy-dropbox-0
# for item in `cat /tmp/file_path_final.txt`
# do
# file_name=`echo "${item}" | sed 's/ *$//g'`
# echo
# echo "file_name is ${file_name}"
# echo
# aws s3 cp s3://$bucket_name/$file_name s3://${bucket_name}/${file_name} --storage-class STANDARD
# done
if aws s3 ls
then
  echo "file copied 01"
else
  echo "file copied 02"
fi
