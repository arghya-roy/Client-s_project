# Documentation about how to create autoscale github runner (builder) on spot Instance of AWS -
source = https://github.com/arghya-roy/terraform-aws-github-runner
## Why Self hosted -
Self-hosted runners offer more control of hardware, operating system, and software tools than GitHub-hosted runners. It provide us with ability to create custom hardware and software configuration with more processing ability to run larger jobs. Runners can be physical, virtual, in a container, on-premises, or in a cloud. In this project, we will be adding auto scaling runner in AWS.
## Overview of this project -

In this case we are going to create self hosted runner in AWS. But the instances would be spot Instance. When GitHub action workflow is triggered then it runs on a self-hosted runner, So in this case GitHub will try to find a runner which can execute the workload. This module reacts to GitHub's `check_run` event or `workflow_job` (here we will use this) for the triggered workflow and creates a new runner if necessary. The advantage of the `workflow_job` event is that the runner checks if the received event can run on the configured runners by matching the labels, which avoid instances being scaled up and never used. `workflow_job` create a webhook on enterprise, org or app level. For receiving the `workflow_job` event by the webhook (lambda), a webhook needs to be created in GitHub.


**API gateway endpoint** - In AWS a `API gateway` endpoint is created that is able to receive the GitHub webhook events via HTTP post. The gateway triggers the webhook lambda which will verify the signature of the event. This check guarantees the event is sent by the GitHub App. The lambda only handles `workflow_job` or with status `queued` and matching the runner labels. The accepted events are posted on a SQS queue. Messages on this queue will be delayed for a configurable amount of seconds (default 30 seconds) to give the available runners time to pick up this build.

**scale up runner**-It is a lambda function which listens to the SQS queue and picks up events. The lambda runs various checks to decide whether a new EC2 spot instance needs to be created. For example, the instance is not created if the build is already started by an existing runner, or the maximum number of runners is reached. It should have access to Create EC2. It also should have access to CloudWatch, SSM and S3.

**Scale down Runner**-Scaling down the runners is at the moment brute-forced, every configurable amount of minutes a lambda will check every runner (instance) if it is busy. In case the runner is not busy it will be removed from GitHub and the instance terminated in AWS. At the moment there seems no other option to scale down more smoothly. It should have access to EC2 to terminate instances.

**action runner binary**-Downloading the GitHub Action Runner distribution can be occasionally slow (more than 10 minutes). Therefore a lambda is introduced that synchronizes the action runner binary from GitHub to an S3 bucket. The EC2 instance will fetch the distribution from the S3 bucket instead of the internet.

**SSM Parameter Store**-Secrets and private keys are stored in SSM Parameter Store. These values are encrypted using the default KMS key for SSM or passing in a custom KMS key.

## To do this we need to do the following steps - 
### 1) Create GitHub App -
1. Clink on the downarrow in the left of your Github profile picture.
2. Click on settings
3. Go to Developer settings
4. Clink on Github app
5. Click on new Github app
7. Give a name
8. Homepage URL (Required) - The full URL to your GitHub App’s website
9. Unchecked webhook active ( make it deactive ) 
10. Repository Permissions:
      - `Actions`: Read-only (to check for queued jobs)
      - `Checks`: Read-only (to receive events for new builds)
      - `Metadata`: Read-only 
      - `Administration`: Read & write (to register runner)
12. organization Permissions:
     - `Self-hosted runners`: Read & write (to register runner)
13. Click on Create Github App.
14. After that it automatically comes on the General page (if not, then follow step number 1 to 4 and click on EDIT of your newly created app).
15. Copy the App ID and Client ID.
16. Click on generate a new client secret.
17. Copy that secret.
18.  Scroll down more
19. Generate a new private key.
20. Save that key.

### 2) Setup terraform module

#### A) Download lambdas

To do this project, the compiled lambdas (.zip files) need to be available either locally or in an S3 bucket. The lambdas can be downloaded manually or using terraform module. To read the files from S3, set the `lambda_s3_bucket` variable and the specific object key for each lambda. In the `download-lambda` directory, run `terraform init && terraform apply`. The lambdas will be saved to the same directory.
For local development you can build all the lambdas at once using `.ci/build.sh` or individually using `yarn dist`.

Download lambda manually - https://github.com/philips-labs/terraform-aws-github-runner/releases <br/>
Download lambda using Terraform module - https://github.com/philips-labs/terraform-aws-github-runner/tree/develop/modules/download-lambda

#### B) Service-linked role ( Do it manually is best practice ) 

To create spot instances the `AWSServiceRoleForEC2Spot` role needs to be added to your account. You can do that manually by following the. To use terraform for creating the role, either add the following resource or let the module manage the the service linked role by setting `create_service_linked_role_spot` to `true`. Be aware this is an account global role, so maybe you don't want to manage it via a specific deployment.

```hcl
resource "aws_iam_service_linked_role" "spot" {
  aws_service_name = "spot.amazonaws.com"
}
```

#### C) Terraform module- 

Note that `github_app.key_base64` needs to be a base64-encoded string of the `.pem` file i.e. the output of `base64 app.private-key.pem`. The decoded string can either be a multiline value or a single line value with new lines represented with literal `\n` characters.

```terraform
module "github-runner" {
  source  = "philips-labs/github-runner/aws"
  version = "REPLACE_WITH_VERSION"

  aws_region = "eu-west-1"
  vpc_id     = "vpc-123"
  subnet_ids = ["subnet-123", "subnet-456"]

  environment = "gh-ci"

  github_app = {
    key_base64     = "base64string"
    id             = "1"
    webhook_secret = "webhook_secret"
  }

  webhook_lambda_zip                = "lambdas-download/webhook.zip"
  runner_binaries_syncer_lambda_zip = "lambdas-download/runner-binaries-syncer.zip"
  runners_lambda_zip                = "lambdas-download/runners.zip"
  enable_organization_runners = true
}
```

Run terraform by using the following commands

```bash
terraform init
terraform apply
```

The terraform output displays the API gateway url (endpoint) and secret, which you need in the next step.

The lambda for syncing the GitHub distribution to S3 is triggered via CloudWatch (by default once per hour). After deployment the function is triggered via S3 to ensure the distribution is cached.

Create a second terraform workspace and initiate the above module, or adapt one of this - https://github.com/philips-labs/terraform-aws-github-runner/tree/develop/examples

### 3) Edit GitHub App -  
1. Clink on the downarrow in the left of your Github profile picture.
2. Click on settings
3. Go to Developer settings
4. Clink on Github app
5. Click on the EDIT of newly Created App.
6. **Go to General**
7. Checked webhook active ( make it active )
8. Provide the webhook url ( which you got from output of step 2) 
9. Provide the webhook secret ( which you got from output of step 2).
10. Go to Permissions & Events.
11. Scroll down
12. Click on "Subscribe to Events" subsection, check "Workflow Job".
13. **Go to the Install App**
14. install the App in your organization, either in all or in selected repositories.

### Alternative of step 3 ( step 3 - Edit GitHub App)

1. Create a new webhook on repo level for repo level for repo level runner, or org (or enterprise level) for an org level runner.
2. Provide the webhook url ( which you got from output of step 2) 
3. Provide the webhook secret ( which you got from output of step 2).
4. Content type - Application/Json
5. Go to Which events would you like to trigger this webhook?
6. Click on Let me select individual events. <br/>
7. **Come to the github app** <br/>
1. Clink on edit section of newly created app.
8. In the "Permissions & Events" section and then "Subscribe to Events" subsection, check "Workflow Job".
9. In the "Install App" section, install the App in your organization, either in all or in selected repositories.


### **How to find it's component in AWS console?**

### API Gateway -
1. Go to Services
2. Go to Networking & Content Delivery
3. Then click on API Gateway
4. Here you can see your API Gateway <br/>
**Stages** <br/>
1. Click on the API name.
2. Open the deploy section.
3. Click on stages. <br/>
**Routes** <br/>
1. Click on the API name.
2. Open the Develop section.
3. Click on Routes.

### Lambda Functions -
1. Go to Services
2. Go to Compute
3. Click on Lambda
4. Then click on function
5. Here you can all created lambda functions.

### Simple Queue Service -
1. Go to services
2. Go to Application Integration
3. Click on Simple Queue Service
4. Click on Queues
5. Here you can see yours SQS

### Amazon EventBridge -

1. Go to services
2. Go to Amazon EventBridge
3. Click on Rules
4. Here you can see yours Rules

### S3 Bucket -

1. Go to services
2. Go to Storage
3. Click on S3
4. Here you can see the bucket named gh-ci*
5. After opening that bucket you can find your action runner binary.

### Roles -
1. Go to services
2. Go to Security, Identity, & Compliance
3. Click on IAM
4. Click on roles
5. You can see all roles for lambda function starting with gh-ci*
6. You can see the role for spot instance named AWSServiceRoleForEC2Spot
7. By clicking on each role you can policies attached to that role.

### User -
1. Go to services
2. Go to Security, Identity, & Compliance
3. Click on IAM
4. Click on users
5. You can see the user named s3.

### Spot Instances - 
1. Go to services
2. Go to compute
3. Click on EC2
4. Click on instance and you can see all running spot instances.

### Log groups -
1. Go to services
2. Go to Management & Governance
3. Go to CloudWatch
4. Click on Log groups
5. Here you can see all log groups

### Launch template - 
1. Go to services
2. Go to compute
3. Click on EC2
4. In the left clink on Launch Templates
5. You can see your launch templates

### Security Group - 
1. Go to services
2. Go to compute
3. Click on EC2
4. In the left clink on Security Group
5. Here you can see your security group named gh-ci-*

### SSM Parameter - 
1. Go to search 
2. Search by 'Systems Manager'
3. Click on Parameter Store
4. Here you can see your all Parameters

### Resource Groups -
1. Go to search
2. search by Resource Groups
3. Click on Saved Resource Groups
4. You can see the resource groups


