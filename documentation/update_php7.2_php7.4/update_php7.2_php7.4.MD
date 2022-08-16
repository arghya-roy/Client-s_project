## Update_php7.2_php7.4 for stage -

### If you create a new branch for staging -
- We have successfully updated php7.2 to php7.4 in develop enviroment. And branch name is feature/<your_jira_ticket_name>.
- So now if we want to apply those in stage environment then we have to create a new branch from feature/<your_jira_ticket_name>.
- As per the gitlab pipeline script the new branch name must be started with **rc/**
- When you create a new branch starting with **rc/** then automatically your pipeline for staging environment will be trigerred and after successfully runs of pipeline updation of php7.2 to php 7.4 for staging will be successfull.
### If you want to do in existing staging branch - ( make sure that existing branch name starts with rc/ )
we can do it in two ways -
#### Merge your feature/<your_jira_ticket_name> branch with existing branch -
- Left panel of your gitlab there is a section called **merge requests**.  Click on there, click on new merge request, select source branch and give your feature/<your_jira_ticket_name> there. and in the destination branch select your existing branch into where you want to merge.
- Click on compare branches and continue.
- Click on create merge request.
- Click on merge. 
- Click on Merge unverified changes
- then automatically your pipeline for staging environment will be trigerred and after successfully runs of pipeline updation of php7.2 to php 7.4 for staging will be successfull.
#### Change everything in existing branch manually -
- clone the repo and `git checkout <your_existing_branch>
- there was a Dockerfile inside fewsnet/infrastructure/base-image/Dockerfile, in case of feature/<your_jira_ticket_name> branch we changed docker pull outrigger/apache-php:php72 to docker pull outrigger/apache-php:php74 and also replaced others 74 with 72. and replace **:72** with **:74** inside **fewsnet/infrastructure/baseimage/build.sh**. And after that ran **fewsnet/infrastructure/baseimage/build.sh API-KEY**.
after that new image called apache-php:74 was pushed inside aws ECR. So for staging no need to do it again.
- Now in your existing branch go to **gitlab-ci** folder. There is a file called build.yml open the file and replace docksal/cli:2.10-php7.2 with docksal/cli:php7.4-build.
- In your existing branch go to **gitlab-ci** folder. There is a file called Dockerfile open the file and replace apache-php:72 with apache-php:74 and also replace other 72 text with 74.
- after that push this to your existing branch.
- then automatically your pipeline for staging environment will be trigerred and after successfully runs of pipeline updation of php7.2 to php 7.4 for staging will be successfull.
## For all the above 3 ways make sure that the pipeline script of feature/<your_jira_ticket_name> exactly same as stable branch. If not then copy the pipeline script from stable and paste it in feature/<your_jira_ticket_name>, after that you can follow any of these ways.

# Above I maintained 3 ways to do it. But among them 1st one (create a new branch for staging) is best practise. Although we can follow 2nd and 3rd but We should follow 1st one. 
