gcloud functions deploy ContentCompletion --region=us-west1 --trigger-event providers/cloud.pubsub/eventTypes/topic.publish --trigger-resource WeeklySync --runtime=nodejs16 --source=gs://genentech_functions/ContentCompletion.zip

gcloud functions deploy Creators --region=us-west1 --trigger-event providers/cloud.pubsub/eventTypes/topic.publish --trigger-resource WeeklySync --runtime=nodejs16 --source=gs://genentech_functions/Creators.zip

gcloud functions deploy PathwayProgress --region=us-west1 --trigger-event providers/cloud.pubsub/eventTypes/topic.publish --trigger-resource WeeklySync --runtime=nodejs16 --source=gs://genentech_functions/PathwayProgress.zip

gcloud functions deploy SearchTerms --region=us-west1 --trigger-event providers/cloud.pubsub/eventTypes/topic.publish --trigger-resource DailySync --runtime=nodejs16 --source=gs://genentech_functions/SearchTerms.zip

gcloud functions deploy Skills --region=us-west1 --trigger-event providers/cloud.pubsub/eventTypes/topic.publish --trigger-resource WeeklySync --runtime=nodejs16 --source=gs://genentech_functions/Skills.zip

gcloud functions deploy Users --region=us-west1 --trigger-event providers/cloud.pubsub/eventTypes/topic.publish --trigger-resource WeeklySync --runtime=nodejs16 --source=gs://genentech_functions/Users.zip

gcloud functions deploy Views --region=us-west1 --trigger-event providers/cloud.pubsub/eventTypes/topic.publish --trigger-resource DailySync --runtime=nodejs16 --source=gs://genentech_functions/Views.zip