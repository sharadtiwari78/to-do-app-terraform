
# Provisioning the Amazon EKS cluster using Terraform
This repository contains the terraform file code, which we can use to provision the **Amazon EKS** cluster as part of Project 4 of our **10WeeksofCloudOps** series! In this comprehensive hands-on project, we dive deep into the world of **GitOps and ArgoCD**, demonstrating how to implement these essential DevOps practices step by step by **dockerizing** the application and provisioning the infrastructure using **Terraform**(this repo).

## Architecture Diagram

![Architecture Diagram](https://cdn-images-1.medium.com/max/800/1*T5IRoSoiqT8qnYLUprsRUQ.png)


## Installation of Terraform
Follow the below steps to Install the Terraform and another dependency.

1️⃣ Clone the repo

``` git clone https://github.com/sharadtiwari78/to-do-app-terraform.git ```

2️⃣ Let's install dependency to deploy the application

``` 
cd to-do-app-terraform
terraform init
```

3️⃣ Edit the below file according to your configuration

`vi to-do-app-terraform/backend.tf`

add below code

```
terraform {
  backend "s3" {
    bucket = "10weeksofcloudops-sharad"
    key    = "state/todo/terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "terraform-dynamoDB"
  }
}
```

Let's set up the variable for our Infrastructure and create one file with the name of terraform.tfvars inside to-do-app-terraform/terraform.tfvars and add the below conntent into that file.

```
project_name    = "To-Do-App"
vpc_cidr        = "10.0.0.0/16"
private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
public_subnets  = ["10.0.51.0/24", "10.0.52.0/24"]

```

Please note that the above file is crucial for setting up the infrastructure, so pay close attention to the values you enter for each variable.

It's time to build the infrastructure

The below command will tell you what terraform is going to create.

`terraform plan`

Finally, HIT the below command to create the infrastructure...

`terraform apply`

type yes, and it will prompt you for permission or use --auto-approve in the command above.


**This project contains Three GitHub repositories**

➡️ [App Code] (https://github.com/sharadtiwari78/to-do-application)

➡️ [Terraform code] (https://github.com/sharadtiwari78/to-do-app-terraform)

➡️ [Manifest Repo] (https://github.com/sharadtiwari78/to-do-app-eks-manifest)
