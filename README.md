# Starter Kit Terraform

## Overview

This repo aims to help user to start with terraform on azure by providing studends a small project ecosystem and a case study to implement.

## Case Studies

The current case studies aims to deploy a windows datacenter 2019.

The architecture we aim to build is the 



## Pre-requisites

In order to be efficient right away and make sure you have the right tooling, we based our starter kit on a **devcontainer**
running all the good stuff!
Therefore PLEASE use it!😎

## Quick start

- Open the repository using the devcontainer in Visual Studio Code

- Run the following command to get the source code and install the necessary node modules after having forked the repository.

  ```bash
  npm install
  ```

- Login to Azure

  ```bash
  az login
  az account set --suscription <subscription ID> # if you have several subscriptions in your tenant
  ```

- Create you git branch

  ```bash
  git checkout -b <branch>
  ```

- Start coding your infrastructure in the .infra folder

  The folder comes with an example of code and structure. No backend is provided but you can update this configuration by updating the providers.tf file by changing "local" key word to "azurerm".

  ```json
   backend "azurerm" {}
  ```

  And adding a backend.tfvars file in the .infra folder with the configuration of your azure container.

  ```json
  resource_group_name  = "demo"
  storage_account_name = "abcd1234"
  container_name       = "tfstate"
  key                  = "dev.terraform.tfstate"

  # rather than defining this inline, the Access Key can also be sourced
  # from an Environment Variable - more information is available below.
  access_key = "abcdefghijklmnopqrstuvwxyz0123456789..."
  ```

  Then you can update the package.json file `terraform:plan` script to use that storage.

  ```json
  ...
  "terraform:plan": "cd  .infra && terraform init -reconfigure -upgrade -backend-config backend.tfvars && terraform plan -var-file terraform.tfvars  -out plan.out",
  ...
  ```

- Generate terraform.tfvars file with the following command and update variables

```bash
  npm run terraform:generate-tfvars
```

- Plan your terraform deployment

  ```bash
  npm run terraform:plan
  ```

- Apply your terraform deployment

  ```bash
  npm run terraform:apply
  ```

- Destroy your terraform deployment (for cleanup)

  ```bash
  npm run terraform:destroy
  ```

- Add and Commit your code

  ```bash
  git add .
  npm run commit
  git push
  ```

## Semantic versioning

In order to be able to build automation processes around the versioning we need consistency our git messages management.
[Commitizen](https://www.npmjs.com/package/commitizen) will help us use git in a conventinal manner.
To commit your code, you can use the following commands.

```bash
npm run commit
# or
npx cz
```

## Automatic tagging and versioning

The starter kit uses husky for git hooks management and [standard-version](https://www.npmjs.com/package/standard-version) for automatic tagging, package.json version and CHANGELOG updates
based on the git tree.
The following command executes the preceding actions based on the configuration contained in the package.json file.

```bash
npm run release
```
