## way 1 - If you want to use default role with your IAM user then create a IAM user And Assign `Deployment Manager Editor` Role. After that using that IAM user You can deploy the code of deployment manager.

## way 2 - If you want to add custom role -
- Go to IAM and Admin
- From the left panel click on Roles.
- Click on create role
- Give a role name and click on add permission
- assign the following permissions 
- `deploymentmanager.deployments.create`
- `deploymentmanager.deployments.delete`
- `deploymentmanager.deployments.update`
- `deploymentmanager.deployments.get`
- `deploymentmanager.manifests.get`
- `deploymentmanager.operations.get`
- `deploymentmanager.resources.list`
- Click on create
- Now come to your IAM user and assign the role which you have created just now. ( Search by the role name which you have given while creating custom role)

# If you need my opinion then I will suggest you to go with way 1.