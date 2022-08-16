# Step - 1
# Need to filter cloudtrail event based on event name and event time and resources.

# Step - 2
# If the resource did not use within 7 days then change the storage type.

#List of all folders inside of a folder -
aws s3 ls s3://cf-templates-1sjz7kdmcgmjp-ap-south-1/202204710V-designer/ | awk '{print $2}' | awk -F '/' '/\// {print $1}'

#list of all object inside of a folder -


#list of all files inside folder or outside folder -
aws s3 ls s3://cf-templates-1sjz7kdmcgmjp-ap-south-1 --recursive | awk '{print $4}'

# filter files before a modified date -
aws s3 ls --recursive s3://cf-templates-1sjz7kdmcgmjp-ap-south-1/202204710V-designer/playbook | awk '$1 < "2022-03-30 00:00:00" {print $4}' | sort -n

# format date according to s3 format -
date=$(date '+%Y-%m-%d %H:%M:%S')

# pick up date before 7 days from today -
date -d '168 hour ago' '+%Y-%m-%d %H:%M:%S'

# pick up date before 7 days from today with time 00:00:00 -
initial_date=$(date -d '168 hour ago' '+%Y-%m-%d') &&
final_date="${initial_date} 00:00:00" &&
echo $final_date

# filter files before 7 days of modified date from today -
initial_date=$(date -d '168 hour ago' '+%Y-%m-%d') &&
final_date="${initial_date} 00:00:00" &&
echo $final_date &&
aws s3 ls --recursive s3://cf-templates-1sjz7kdmcgmjp-ap-south-1/202204710V-designer/playbook | awk '$1 < "`${final_date}`" {print $4}' | sort -n

# filter files before 7 days of modified date from today and save output inside a file called demo.txt-
initial_date=$(date -d '168 hour ago' '+%Y-%m-%d') &&
final_date="${initial_date} 00:00:00" &&
echo $final_date &&
aws s3 ls --recursive s3://cf-templates-1sjz7kdmcgmjp-ap-south-1/202204710V-designer/playbook | awk '$1 < "`${final_date}`" {print $4}' | sort -n > demo.txt

# check that modified before 7 days file has been access within last 7 days or not, we will do it by cloudtrail cli -

### pick up path of key using jq 
jq '.requestParameters.key' GetObject.json

### get all logs using cli -
aws logs filter-log-events --log-group-name s3_log_2 --log-stream-names 201043775914_CloudTrail_ap-south-1

### filter only GetObjects log -
aws logs filter-log-events --log-group-name s3_log_2 --log-stream-names 201043775914_CloudTrail_ap-south-1 --filter-pattern ["eventName"="*GetObject*"]

### filter only GetObjects log with time-stamp with 7days before to now- have to add 000 at end to time stamp because it is in milisecond
aws logs filter-log-events --log-group-name s3_log_2 --log-stream-names 201043775914_CloudTrail_ap-south-1 --start-time 1648188352000 --filter-pattern ["eventName"="*GetObject*"]

### filter only GetObjects log with time-stamp with a time interval - have to add 000 at end to time stamp because it is in milisecond
aws logs filter-log-events --log-group-name s3_log_2 --log-stream-names 201043775914_CloudTrail_ap-south-1 --start-time 1648188352000 --end-time 1648786144000 --filter-pattern ["eventName"="*GetObject*"]

### convent second to date 
i=1648188352 &&
date -d @$i +"%d-%m-%Y %T %z"

### convent milisecond to date -
i=$((1648188352000/1000)) &&
date -d @$i +"%d-%m-%Y %T %z"


### remove backslash from json file-
cat demo.json | awk '{gsub(/\\/,"")}1' > demo2.json

### make json perfect -
cat demo.json | awk '{gsub(/\\/,"")}1' | awk '{gsub(/"{/,"{")}1' | awk '{gsub(/}"/,"}")}1' > demo2.json

### send a file from s3 standard to s3 deep archive -
aws s3 cp s3://BUCKET/KEY s3://BUCKET/KEY --storage-class STANDARD_IA
aws s3 cp s3://BUCKET/KEY s3://BUCKET/KEY --storage-class DEEP_ARCHIVE

### copy a file in the same location from s3 standard to s3 standard just to update modifacation time -
aws s3 cp s3://BUCKET/KEY s3://BUCKET/KEY

### to get file_path -
jq '.events[].message.requestParameters.key' demo2.json

### pick log stream name -
aws logs describe-log-streams --log-group-name s3-trail-log-1 --log-stream-name-prefix 201043775914_CloudTrail_ap-south-1 | jq -r '.logStreams[].logStreamName'

### delete multiple lines from txt file -
awk '!seen[$0]++' file_path.txt > path2.txt