## Summary

Terraform code to create your Artifactory resource.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| aws\_account\_id | The account ID you are building into. | string | `n/a` | yes |
| region | The AWS region the state should reside in. | string | `"ap-southeast-2"` | no |
| source\_address | Whitelisted source address to allow to connect to Artifactory. | string | `"0.0.0.0/0"` | no |
| instance\_type | Artifactory EC2 instance type. | string | `"t2.medium"` | no |
| key\_name | Key name of the Key Pair to use for the Artifactory instance. | string | `n/a` | no |
| user\_data | The user data to provide when launching the instance. | `string` | `null` | no |
| ami\_centos | CentOS7 AMI ID. This is dependent on the Region. | string | `n/a` | no |

## Outputs

| Name | Description |
|------|-------------|
| artifactory\_sg\_id | The ID of the Artifactory Security Group. |
