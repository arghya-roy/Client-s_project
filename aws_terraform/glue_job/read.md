**glue_job_single** file contains codes of glue job configuration for single job.
**glue_job_multiple_with_localtf** file contains codes of glue job configuration for multiple job using locals.tf .
**glue_job_multiple_without_localtf**  file contains codes of glue job configuration for multiple job without using locals.tf 
means it is using map data type in variable.tf as per your requirement.
**glue_from_schema_s3_paqquet-2** contains the code to create two databaes but here I have enabled "aws_s3_bucket_logging" for two source buckets. I hope bucket to store log already exists, you can ask the name of bucket and prefix(sub folder) to your manager then paste the name inside main.tf. you can compare aws_s3_bucket_logging with cloudwatch log group. 
If the bucket to store does not exist then you can create a bucket to store and create prefix(sub folder) inside that bucket using https://stackoverflow.com/questions/50066470/how-to-create-multiple-folders-inside-an-existing-aws-bucket ( 2nd answer will work ). But I think bucket to store log already exists.


Hi kay, I will not be able connect tomorrow and also not available tomorrow in offline also. I will come back to home at monday early morning. So we will continue from monday again. But here I have completed today's tasks ( enable logging to s3 and multiple glue job without locals.tf ) and also have shared those with you. 