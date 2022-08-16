The first step is to setup GitHub App. see link here for the setup “https://github.com/philips-labs/ terraform-aws-github-runner#setup-github-app-part-1“. Note the "App ID", "Client ID" parameters and the “.pem” key generated.

Clone the Terraform AWS GitHub Runner repo, “git clone git@github.com:philips-labs/terraform-aws-github-runner.git“

Change directory into the cloned folder and navigate to examples/default/, and make necessary edits based on the requirements or desired Infrastructure setup. (This step can be ignore if we want to use the default values).

Convert the app.private-key.pem to base64. copy the content of base64 and content of github app id then paste it in the variable.tf

Go to examples/default/lambdas-download/main.tf and give version = "v0.40.0" (this is latest we can use other also)

do terraform init and terraform apply

go to examples/default

run “terraform init”, to initialize terraform and run “terraform plan” to preview the changes that is about to be made on the Infrastructure.

Once the preview is inline with the desired intentions, run “terraform apply” to apply the changes.

We can see that the AWS services for this module have been created successfully.

After running “terraform apply” note the terraform output values for API gateway url (endpoint) and secret. Copy those values so we can use it in our next step of GitHub App setup.

If secret value is not showing directly then do terraform output -raw webhook_secret

After that we will edit the setup of the GitHub App using the output from the previous step. See instructions in link, “https://github.com/philips-labs/terraform-aws-github-runner#option-2-app “
