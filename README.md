<<<<<<< HEAD
# azure-terraform-4-tier-network-architecture
=======
# Azure Virtual Network – 4-Tier Architecture using Terraform

![Azure](https://img.shields.io/badge/Cloud-Microsoft%20Azure-0078D4?logo=microsoftazure&logoColor=white)
![Terraform](https://img.shields.io/badge/IaC-Terraform-7B42BC?logo=terraform&logoColor=white)
![Language](https://img.shields.io/badge/Language-HCL-623CE4)
![Status](https://img.shields.io/badge/Status-Learning%20Project-orange)

## 📌 Project Overview

This project demonstrates how to provision an **Azure Virtual Network (VNet) with a four-tier subnet architecture using Terraform**.

The infrastructure is defined using Terraform configuration files, allowing network resources to be managed through Infrastructure as Code (IaC).

The project covers virtual network provisioning, subnet segmentation, Network Security Groups (NSGs), configurable input variables, local values, resource naming conventions, and Terraform outputs.

This is a hands-on Azure networking project designed to practise Terraform and cloud infrastructure automation.

## 🎯 Project Objectives

- Provision Azure networking infrastructure using Terraform.
- Create an Azure Resource Group and Virtual Network.
- Implement four logical subnet tiers: Web, Application, Database, and Bastion/Management.
- Create and associate Network Security Groups with the subnets.
- Configure inbound NSG rules using Terraform `for_each` and local maps.
- Use input variables and local values to manage configuration and resource naming.
- Export useful infrastructure details through Terraform outputs.
- Apply Infrastructure as Code practices to Azure networking.

## 🏗️ Architecture

The project separates network workloads into four logical tiers.

| Tier | Purpose | Example workloads |
|---|---|---|
| Web Tier | Entry point for web traffic | Web servers, reverse proxies |
| Application Tier | Application processing | Application services and APIs |
| Database Tier | Data services | Database servers and data platforms |
| Bastion / Management Tier | Administrative access | Management hosts and access services |

**Note:** This repository provisions networking resources and NSG rules. The workload examples above describe intended uses; the application servers, database servers, and Bastion service itself are not provisioned by the listed Terraform files.

## 🛠️ Technologies Used

- Microsoft Azure
- Terraform
- AzureRM Terraform Provider
- Random Terraform Provider
- Azure Virtual Network and Subnets
- Network Security Groups (NSGs)
- Terraform Variables and Local Values
- Terraform Outputs
- Git and GitHub

## 📂 Repository Structure

```text
azure-terraform-4-tier-network-architecture/
│
├── .gitignore
├── .terraform.lock.hcl
├── README.md
│
├── c1-versions.tf
├── c2-generic-input-variables.tf
├── c3-locals.tf
├── c4-random-resources.tf
├── c5-resource-group.tf
│
├── c6-01-vnet-input-variables.tf
├── c6-02-virtual-network.tf
├── c6-03-web-subnet-and-nsg.tf
├── c6-04-app-subnet-and-nsg.tf
├── c6-05-db-subnet-and-nsg.tf
└── c6-06-bastion-subnet-and-nsg.tf
    c6-07-vnet-outputs.tf
```

### File descriptions

| File | Responsibility |
|---|---|
| `c1-versions.tf` | Terraform and provider requirements |
| `c2-generic-input-variables.tf` | Business division, environment, resource group name, and location |
| `c3-locals.tf` | Resource naming prefix and common tags |
| `c4-random-resources.tf` | Random string generation |
| `c5-resource-group.tf` | Azure Resource Group |
| `c6-01-vnet-input-variables.tf` | VNet and subnet input variables |
| `c6-02-virtual-network.tf` | Azure Virtual Network |
| `c6-03-web-subnet-and-nsg.tf` | Web subnet, NSG, and inbound rules |
| `c6-04-app-subnet-and-nsg.tf` | Application subnet, NSG, and inbound rules |
| `c6-05-db-subnet-and-nsg.tf` | Database subnet, NSG, and inbound rules |
| `c6-06-bastion-subnet-and-nsg.tf` | Bastion/Management subnet, NSG, and inbound rules |
| `c6-07-vnet-outputs.tf` | VNet and Web subnet/NSG outputs |

## 🔐 Network Security Configuration

The current configuration defines the following inbound TCP ports:

| Tier | Ports configured |
|---|---|
| Web | 80, 443, 22 |
| Application | 80, 443, 8080, 22 |
| Database | 3306, 1433, 5432 |
| Bastion / Management | 22, 3389 |

These rules are generated using Terraform maps and `for_each`, reducing repeated resource definitions.

**Security consideration:** The current rules use `*` for source and destination address prefixes. This allows traffic from any source address at the NSG rule level. Before using this configuration in a real environment, restrict inbound sources to approved CIDRs, required upstream subnets, or other appropriate network boundaries. Avoid exposing SSH (22), RDP (3389), or database ports directly to the internet.

## ⚙️ Prerequisites

Before deploying this project, install:

- [Terraform CLI](https://developer.hashicorp.com/terraform/install)
- [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli)
- [Git](https://git-scm.com/downloads)

You also need:

- An active Azure subscription.
- Permissions to create Resource Groups, Virtual Networks, Subnets, NSGs, and security rules.
- Valid input values for the Terraform variables.

## 🚀 Deployment Guide

### 1. Clone the repository

```bash
git clone -b clean-main https://github.com/dhirajnimkande23/azure-terraform-4-tier-network-architecture.git

cd azure-terraform-4-tier-network-architecture
```

### 2. Authenticate with Azure

```bash
az login
```

Select your subscription:

```bash
az account set --subscription "<YOUR_SUBSCRIPTION_ID>"
```

Verify the active subscription:

```bash
az account show
```

### 3. Configure input variables

The configuration requires values for the business division, environment, Resource Group, VNet, and subnet settings.

Create a local `terraform.tfvars` file using the variable declarations in the repository.

Example format:

```hcl
business_division       = "example"
environment             = "dev"
resource_group_name     = "network-lab"
resource_group_location = "Central India"

vnet_name          = "vnet-4tier"
vnet_address_space = ["10.0.0.0/16"]

web_subnet_name    = "web-subnet"
web_subnet_address = ["10.0.1.0/24"]

app_subnet_name    = "app-subnet"
app_subnet_address = ["10.0.11.0/24"]

db_subnet_name    = "db-subnet"
db_subnet_address = ["10.0.21.0/24"]

bastion_subnet_name    = "bastion-subnet"
bastion_subnet_address = ["10.0.100.0/24"]
```

These are illustrative values, not verified values from the original deployment. Ensure subnet ranges do not overlap and match your network design.

Do not commit your real `terraform.tfvars` file if it contains sensitive information. Use a sanitized `terraform.tfvars.example` file for documentation.

### 4. Initialize Terraform

```bash
terraform init
```

This downloads the required providers and initializes the working directory.

### 5. Format and validate the configuration

```bash
terraform fmt -recursive
terraform validate
```

Resolve any reported configuration errors before continuing.

### 6. Review the execution plan

```bash
terraform plan
```

Review the proposed Resource Group, VNet, subnet, NSG, and security-rule changes before deployment.

### 7. Deploy the infrastructure

```bash
terraform apply
```

Review the plan and confirm the operation when prompted.

### 8. Review Terraform outputs

```bash
terraform output
```

The current output configuration exports the VNet name and ID, Web subnet name and ID, and Web subnet NSG name and ID.

## 🧹 Destroy the Infrastructure

To remove resources managed by this Terraform configuration, first review the destruction plan:

```bash
terraform plan -destroy
```

If the plan is correct and the resources are safe to remove, run:

```bash
terraform destroy
```

**Warning:** This removes managed Azure resources and can cause service interruption or data loss. Use only in the intended environment.



## 📚 Learning Outcomes

This project provides hands-on practice with:

- Azure Virtual Network design and subnet segmentation.
- Network Security Group configuration.
- Terraform input variables and local values.
- Dynamic security-rule creation using `for_each`.
- Terraform provider management and dependency locking.
- Infrastructure deployment and lifecycle commands.
- GitHub source control for Infrastructure as Code.

## 👨‍💻 Author

**Dhiraj Nimkande**

Cloud & DevOps Engineer | Microsoft Azure | Terraform | Kubernetes | CI/CD

- GitHub: [dhirajnimkande23](https://github.com/dhirajnimkande23)
- LinkedIn: [Dhiraj Nimkande](https://www.linkedin.com/in/dhiraj-nimkande/)

---

⭐ If you find this project useful, consider starring the repository.
>>>>>>> origin/clean-main
