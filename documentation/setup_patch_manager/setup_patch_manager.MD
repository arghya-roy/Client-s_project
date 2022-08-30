## setup_patch_manager -
### Step 1 -
- If you are trying to patch private instances then make sure that NAT Gateway in connected with those instances.
- Then we have to attach **AmazonSSMManagedInstanceCore** with those instances.
- For attachinh that select instance - go to actions - go to security - Modify IAM role - Copy the name of attached role
- Then go to IAM - click on roles -Search by the role which you have copied - check that if AmazonSSMManagedInstanceCore policy already attached or not, if attached then ignore thos step
- If not attached then - click on Add permissions - attach policies - search by **AmazonSSMManagedInstanceCore** - Click on attach policies.
- Follow the above steps for those instances to which you want to apply patch manager.
### Step 2 -
- Check instance id and their crossponding Amazon linux version ( version 1 and version 2 ).
### Step 3 -
- Go to ec2 - click on tags - click on manage tags
- **For amazon linux version 1 -**
- Go to add tag section - **key=Patch Group** and **value=patchv1** and select only tose instances which are using amazon linux version 1 - Click on add tag
- **For amazon linux version 2 -**
- Go to add tag section - **key=Patch Group** and **value=patchv2** and select only tose instances which are using amazon linux version 2 - Click on add tag
### Step 4 -
- **For amazon linux version 1 -**
- Open System manager - patch manager - view predifined patch baselines - create patch baselines - create patch baseline for operating system amazon linux 1 - in product, Severity, Classification section click on their dropdown and select **ALL**.
- select Approve patches after a specified number of days and give number of days.
- Click on create patch baseline 
- **For amazon linux version 2 -**
- Open System manager - patch manager - view predifined patch baselines - create patch baselines - create patch baseline for operating system amazon linux 2 - in       product, Severity, Classification section click on their dropdown and select **ALL**.
- select Approve patches after a specified number of days and give number of days.
- Click on create patch baseline 
### Step 5 -
- **For amazon linux version 1 -**
 - Open System manager - patch manager - view predifined patch baselines - select the patch baseline you created for amazon linux version 1 - click on actions - Modify patch groups - give patchv1 and click on ADD then close
 - again select the patch baseline you created for amazon linux version 1 - clcik on configure patching - Click on Select a patch group - select patchv1
 - click on Schedule in a new Maintenance Window
 - give your CRON schedule
 - Select Scan and install in patching operation.
 - Click on configure patching 
- **If you want to change reboot optiion** - Go to system manager - Maintenance Windows - You can see your newly created maintence window, click on that - Scroll down and at the parameter section select NoReboot in reboot option.
- **For amazon linux version 2 -**
 - Open System manager - patch manager - view predifined patch baselines - select the patch baseline you created for amazon linux version 2 - click on actions - Modify patch groups - give patchv1 and click on ADD then close
 - again select the patch baseline you created for amazon linux version 2 - clcik on configure patching - Click on Select a patch group - select patchv2
 - click on Schedule in a new Maintenance Window
 - give your CRON schedule
 - Select Scan and install in patching operation.
 - Click on configure patching 
- **If you want to change reboot optiion** - Go to system manager - Maintenance Windows - You can see your newly created maintence window, click on that - Scroll down and at the parameter section select NoReboot in reboot option.
