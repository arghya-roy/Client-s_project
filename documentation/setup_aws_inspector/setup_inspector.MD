## setup_inspector -
### Step 1 -
- If you are trying to setup inspector on private instances then make sure that NAT Gateway in connected with those instances.
- Then we have to attach **AmazonSSMManagedInstanceCore** with those instances.
- For attachinh that select instance - go to actions - go to security - Modify IAM role - Copy the name of attached role
- Then go to IAM - click on roles -Search by the role which you have copied - check that if AmazonSSMManagedInstanceCore policy already attached or not, if attached then ignore this step
- If not attached then - click on Add permissions - attach policies - search by **AmazonSSMManagedInstanceCore** - Click on attach policies.
- Follow the above steps for those instances to which you want to apply AWS inspector.
### Step 2 - ( If any inspector templete was created before then step 2 will not work, for that you have to follow step 3) -
- Go to  Inspector - expand the left panel - Click on Switch to Inspector Classic - click on get started -  select Network Assessments (Inspector Agent is not required)
and Host Assessments (Inspector Agent is required) - click on advance setup.
- Give a name of assesment target - uncheck all instances - select key as name and give instances names as value ( only those instance name for which you are wanting to apply inspector)
- Check install agents
- Click on next.
- Set duration as per your requirement ( recommended is 1 hour ).
- set  Set up recurring assessment runs after how many days ( default is 7 ).
- click next
- review
- create

### Step 3 - ( If any inspector templete was created before then step 2 will not work, for that you have to follow this) -
- Go to  Inspector - expand the left panel - Click on Switch to Inspector Classic - Click on Assesment targets - Click on create
- - Give a name of assesment target - uncheck all instances - select key as name and give instances names as value ( only those instance name for which you are wanting to apply inspector)
- Check install agents
- Click Save
- Click on Assesment targets - Click on create
- Give templete name
- Select target name which you have given before
- Select Rules packages as per your requirement
- Set duration as per your requirement ( recommended is 1 hour ).
- set  Set up recurring assessment runs after how many days ( default is 7 ).
- 
### Step 3 - ( For run the scanning process )
- Go to  Inspector - expand the left panel - Click on Switch to Inspector Classic - go to  Assessment templates and select your templete and clcik on Run.
- 
