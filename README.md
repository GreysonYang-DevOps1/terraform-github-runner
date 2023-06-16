# terraform-github-runner

## Prerequisite

- [ ] [Configured AWS Account and AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html)

- [ ] [Install Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

## Provision AWS Resources by terraform
```
terraform fmt
terraform init
terrafrom validate
terraform plan
terraform apply -auto-approve
```

## Validatation
- [ ] Validate Terraform Output
- [ ] Validate AWS resources from console
- [ ] SSH to EC2

## Destroy provisioned AWS resources and Cleanup
```
terraform apply -destroy -auto-approve
rm -rf .terraform*
rm -rf terraform.tfstate*
rm -rf terraform.backup
```

## TO-DO
```

```