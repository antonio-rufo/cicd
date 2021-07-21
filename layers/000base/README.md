## Summary

Terraform code to create you the default VPC.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| aws\_account\_id | The account ID you are building into. | string | n/a | yes |
| region | The AWS region the state should reside in. | string | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| subnet_az1 | The ID of Subnet in AZ1. |
| subnet_az2 | The ID of Subnet in AZ2. |
| subnet_az3 | The ID of Subnet in AZ3. |
