# Terragrunt blueprint
This repository contains a Terragrunt blueprint with a common project structure.

## Features
- [x] AWS Provider
- [x] AWS Dummy Module
- [x] local backend
- [x] gitlab remote backend
- [ ] add some

## Apply aws_dummy
```bash
export AWS_PROFILE=aws_dummy
export AWS_ACCOUNT_ID=123456789

# required if you want to use the gitlab backend
export TF_HTTP_PASSWORD=your_gitlab_token
export TF_HTTP_USERNAME=your_gitlab_user_name

cd deployments/terraform/env/dev/aws_dummy
terragrunt apply
```

## Status
This repository is a work in progress.