# A Multi-Cloud Application

## Getting Started

This folder contains the scaffolding Terraform code to deploy your project. Once you select the appropriate cloud providers, you will need to research specific Terraform modules for your select service and add those modules to the provided Terraform scaffolding. 

### Resources
See the documentation here:
- For [Azure](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)
- For [AWS](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)

### Dependencies

```
- Terraform
- Azure access
- AWS access
```

### Installation

**NOTE:** This project assumes you have already set up your labs from the course and created your personal git copies of the repositories:

1. Open the AWS portal from the classroom
    1. Open AWS CloudShell
    2. Run the following commands to install Terraform:
        1. `sudo yum install -y yum-utils`
        2. `sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo`
        3. `sudo yum -y install terraform`
    2. Clone your git repo
2. Open the Azure portal from the classroom
    1. Open the Azure Cloud Shell
        1. Select PowerShell when prompted. Then click Advanced Setup on the next screen
        2. You can leave the resource group selected, but you’ll need to put in a name for the storage account and file share for your console. Name your storage account all lowercase with no dashes or punctuation. And less than 24 characters. Something like tscottocloudcstorage and tscottofileshare. Then click Create. Allow the console to provision. 
    2. Clone your git repo


## Project Instructions

### Requirements
Your goal is to select a cloud provider for each of the 4 required services - SQL server, S3 storage, web app and NoSQL database. Also don't forget to consider cost and flexibility of pricing options.

1. Select a cloud provider for SQL server
    1. Must utilize at least 2 vCPU
    2. 150GB of storage
    3. We will be migrating an existing SQL server instance
    4. We would like to bring our own SQL licensing
2. Select a cloud provider for S3 storage
    1.  Must have full S3 API capability
    2.  Global replication
3. Select a cloud provider for the NoSQL database
    1. Global availability
    2. Highly scalable pricing
4. Select a cloud provider for the Web app
    1. Existing dotnet application

**NOTE:** There are container groups contained here in the scaffolding for both AWS and Azure. They are not part of the design itself. They are there to test your functionality once you have deployed your work.

### Instructions
1. With the requirements in mind, your team decided to use AWS S3 due to full S3 API compatibility. The team decided on Azure SQL and a dotnet web app due to Microsoft being the creators of both those technologies. You have the highest compatibility and support from Microsoft with both SQL and dotnet. Your team also wants to use AWS DynamoDB. Do some research using search engines, docs, and pricing calculators from both AWS and Azure to justify why your team chose AWS DynamoDB over Azure's counterpart. Limit your response to less than 150 words. Spend no more than 30 mins on this part. Add your explanation to your README.md file in your final repo submission.

2. Create a diagram based on your design for all 4 services. 

4. Using the [above linked](#resources) references, add the appropriate modules to the given cloud provider Terraform scafolding files:
    1. AWS - `starter/aws/main.tf`
    2. Azure - `starter/azure/main.tf`
5. Edit the appropriate environment variables for the containers to test your install
    1. Find the following environment variables in the Terraform scaffolding and change their values to reflect your name:
        1. AWS_S3_BUCKET: `udacity-<your_name>-aws-s3-bucket`
        2. AWS_DYNAMO_INSTANCE: `udacity-<your_name>-aws-dynamodb`
        3. AZURE_SQL_SERVER: `udacity-<your_name>-azure-sql`
        4. AZURE_DOTNET_APP: `udacity-<your_name>-azure-dotnet-app`
7. Edit the Azure DNS for the container. Find this line in `starter/azure/main.tf` and replace `<your_name>` with your name:
    ```
      dns_name_label      = "udacity-tscotto-azure"
    ```
6. Services you select will be added after commented line `####### Your Additions Will Start Here ######` in the respective cloud provider `main.tf` file.
7. After you have added the modules, applies the changes to the files and push your changes to your github repositories
8. Pull a fresh copy of your github repository into your AWS and Azure Cloud Shells
9. In each shell, run the following:

    For AWS:
    ```
    cd cd11573-multicloud-computing-project/starter/aws
    terraform apply
    ```

    For Azure:
    ```
    cd cd11573-multicloud-computing-project/starter/azure
    terraform apply
    ```

    And type `yes` and enter when asked if you want to apply the changes
10. Wait for the changes to apply. This can take up to 20 min.
11. Verify the changes took effect:

    For Azure:
    1. In Azure go the search bar and type `container-instances` and click the icon that comes up
    2. Click `udacity-continst`
    3. Copy the URL from the field FQDN
    4. Paste that URL into another tab in your browser and add `:3000` onto the end of the URL. It will look something like this: `udacity-tscottoazure.westeurope.azurecontainer.io:3000`. Go to that URL. You should see this text in your browser (note the name will be yours):

                This is my app running on Azure accessing an S3 bucket in AWS: udacity-tscotto-s3-bucket

                And also accessing a dynamodb instance in AWS: udacity-tscotto-aws-dynamodb
    
    For AWS:
    1. In AWS go the search bar and type `load balancer` and click Load Balancers under the EC2 heading
    2. Click `udacity-lb`
    3. Copy the URL from the field DNS
    4. Paste that URL into another tab in your browser. It will look something like this: `udacity-lb-266017657.us-east-2.elb.amazonaws.com`. Go to that URL. You should see this text in your browser (note the name will be yours):

                This is my app running on AWS accessing an Azure SQL instance: tscotto-udacity-sql

                And also a dotnet app in Azure: udacity-tscotto-azure-dotnet-app
12. Please take a screenshot of a running web applications in a browser
13. Complete!
14. Clean up resources

    For AWS:
    ```
    cd cd11573-multicloud-computing-project/starter/aws
    terraform destroy
    ```

    For Azure:
    ```
    cd cd11573-multicloud-computing-project/starter/azure
    terraform destroy
    ```

    And type `yes` and press enter when asked if you want to destroy the resources
15. Please take a screenshot of the cloud console showing the successful Terraform destroy command


## Standout Suggestions

1. Deploy more than 2 services in either cloud provider
2. Create an additional environment variable to demonstrate even more connectivity between additional services
3. Create another demonstration application similar to the one used in the project and show it accessing cloud resources

## Troubleshooting Tips:
In AWS you may only be able to run 1 or 2 exercises at a time. If you get an error in the AWS console about not having enough space or out of space, please run the following commands:
- `cd ~`
- `rm -rf *`

## License

[License](LICENSE.txt)
