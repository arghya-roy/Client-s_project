### At first clone the repo -
## terraform init
go to .terraform/modules/github-runner/examples/default <br/>
### Create a file name terraform.tfvars -
touch terraform.tfvars <br/>
### Open the file -
you can put only those value here which variables are decleared in .terraform/modules/github-runner/examples/default/variable.tf <br/>
example - <br/>
github_app_key_base64 = "XXXXXXXX" <br/>
### If you want to edit values of those variables which variables are not decleared in .terraform/modules/github-runner/examples/default/variable.tf -
example - <br/>
instance_types -  <br/>
You can edit this variable in any of two way - <br/>
1) go to .terraform/modules/github-runner/examples/default/main.tf <br/>
  inside module "runners" { } put   instance_types = ["value1", "value2"] <br/>
  This one is best way. <br/>

2) go to .terraform/modules/github-runner/modules/runners <br/>
   create a file named terraform.tfvars <br/>
   open that file - <br/>
   instance_types = ["value1", "value2"] <br/>
   ( don't forget to remove instance_types = ["value1", "value2"] from main.tf if you are using this way) <br/>
## Then do terraform apply

### In above I have given only one example. to edit other things we have to follow same ways.
