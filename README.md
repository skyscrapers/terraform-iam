<!-- markdownlint-disable MD033 -->

# terraform-iam

Terraform modules to set up a few regularly used IAM resources.

## kms_role

Adds a role and instance profile for KMS access.

### Available variables

* [`kms_key_arn`]: String(required): The ARN of the KMS key
* [`environment`]: String(required): How do you want to call your environment, this is helpful if you have more than 1 VPC.

### Output

* [`role_arn`]: String: The Amazon Resource Name (ARN) specifying the role.
* [`role_unique_id`]: String: The stable and unique string identifying the role.
* [`profile_id`]: String: The instance profile's ID.
* [`profile_arn`]: String: The ARN assigned by AWS to the instance profile.
* [`profile_name`]: String: The instance profile's name.
* [`policy_id`]: String: The role policy ID.
* [`policy_name`]: String:  The name of the policy.
* [`policy_policy`]: String: The policy document attached to the role.
* [`policy_role`]: String: The role to which this policy applies.

### Example

```tf
  module "packer_role" {
    source      = "github.com/skyscrapers/terraform-iam//kms_role"
    kms_key_arn = "${aws_kms_key.kms_key.arn}"
    environment = "staging"
  }
```

## kms_policy

Creates an IAM policy that allows usage of a KMS key.

### Available variables

* [`kms_key_arn`]: String(required): The ARN of the KMS key
* [`environment`]: String(required): How do you want to call your environment, this is helpful if you have more than 1 VPC.

### Output

* [`iam_policy_id`]: String: The generated policy id.
* [`iam_policy_arn`]: String: The generated policy ARN.
* [`iam_policy_name`]: String: The generated policy name.

### Example

```tf
  module "packer_policy" {
    source      = "github.com/skyscrapers/terraform-iam//kms_policy"
    kms_key_arn = "${aws_kms_key.kms_key.arn}"
    environment = "staging"
  }
```

## instance_profile

Adds a role and instance profile.

### Available variables

* [`project`]: String(required): The name of the project. This is helpful if you have more than 1 project
* [`environment`]: String(required): How do you want to call your environment, this is helpful if you have more than 1 VPC.
* [`function`]: String(required): The function of that instance_profile.
* [`aws_iam_role_policy`]: String: The iam_role_policy for that instance.
* [`aws_iam_role`]: String(required): the iam_role for that profile.

### Output

* [`iam_id`]: String: The role profile ID.

### Example

```tf
module "iam" {
  source      = "github.com/skyscrapers/terraform-iam//instance_profile?ref=27b7525e0b6bfaf1eb034daf941a8f44b052b904"
  project     = "${var.project}"
  environment = "${var.environment}"
  function    = "${var.app_name}"

  aws_iam_role = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
      "sqs:*"
      ],
      "Effect": "Allow",
      "Resource": "${module.sqs.sqs_arn}"
      }
    ]
}
EOF
}
```

## codedeploy_role

Add a role that can be attached to codedeploy deployment groups

### Available variables

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| region | Region where codedeploy will run in | string | `"eu-west-1"` | no |

### Output

| Name | Description |
|------|-------------|
| role\_arn | The Amazon Resource Name (ARN) specifying the role. |
| role\_name | The name of the role. |
| role\_unique\_id | The stable and unique string identifying the role. |

### Example

```tf
  module "codedeploy_role" {
    source      = "github.com/skyscrapers/terraform-iam//codedeploy_role"
    region      = "eu-west-1"
  }

```

## User

### Available variables

* [`user_names`]: List(string)(required): List of users that needs to be created
* [`pgp_key`]: String(required): Either a base-64 encoded PGP public key, or a keybase username in the form keybase:username. Used to encrypt the password for safe transport to the user.

### Output

* [`unique_ids`]: List of the unique IDs assigned by AWS to the users
* [`passwords`]: List of the encrypted passwords, base64 encoded. An encrypted password may be decrypted using: `terraform output password | base64 --decode | keybase pgp decrypt`
* [`arns`]: List of the ARNs assigned by AWS to the users

### Example

```tf
module "iam_users" {
  source = "github.com/skyscrapers/terraform-iam//user"
  user_names = ["user1", "user2", "user3"]
  pgp_key = "keybase:user"
}
```

## codedeploy_packer_policy

Add a role that can be attached to packer iam role to access the codedeploy s3 bucket to install the agent

### Available variables

* [`region`]: String:  The region of the codedeploy agent s3 bucket default to us-east-1

### Output

* [`iam_policy_arn`]: String: The Amazon Resource Name (ARN) of the policy created.
* [`iam_policy_name`]: String: The name of the policy created.
* [`iam_policy_id`]: String: The id of the policy created.

### Example

```tf
  module "packer_role" {
    source      = "github.com/skyscrapers/terraform-iam//kms_role"
    kms_key_arn = "${aws_kms_key.kms_key.arn}"
    environment = "staging"
  }

  module "codedeploy_packer_policy" {
    source      = "github.com/skyscrapers/terraform-iam//codedeploy_packer_policy"
  }
  resource "aws_iam_role_policy_attachment" "codedeploy_policy_attach_packer" {
    role       = "${module.packer_role.role_name}"
    policy_arn = "${module.codedeploy_packer_policy.iam_policy_arn}"
  }

```

## cloudcheckr_role

Add a role that can be used by cloudcheckr to collect data and stats

### Available variables

* [`external_id`]: String:  The external_id provided in the cloudcheckr console

### Output

* [`role_arn`]: String: The Amazon Resource Name (ARN) of the role created.

### Example

```tf
  module "cloudcheckr_role" {
    source      = "github.com/skyscrapers/terraform-iam//cloudcheckr_role"
    external_id = "..."
  }
```

## cloudwatch_monitoring_policy

Creates an IAM policy that allows sending metrics to CloudWatch. You must attach that policy to a role, user or group.

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| name | Name to differentiate the policy name. Name will be autogenerated if omitted | `string` | `null` | no |

### Outputs

| Name | Description |
|------|-------------|
| iam_policy_arn | ARN of the Cloudwatch monitoring IAM policy |
| iam_policy_id | ID of the Cloudwatch monitoring IAM policy |
| iam_policy_name | Name of the Cloudwatch monitoring IAM policy |### Example

```tf
module "iam_monitoring" {
  source = "github.com/skyscrapers/terraform-iam//cloudwatch_monitoring_policy"
  name   = "my_project"
}

resource "aws_iam_role_policy_attachment" "cloudwatch_policy" {
  role       = aws_iam_role.my_role.name
  policy_arn = module.iam_monitoring.iam_policy_arn
}
```

## packer_policy

Creates an IAM policy that allows usage of a Packer with AWS EC2 EBS volumes.

### Output

* [`packer_policy_id`]: String: The generated policy id.
* [`packer_policy_arn`]: String: The generated policy ARN.
* [`packer_policy_name`]: String: The generated policy name.

### Example

```tf
  module "packer_policy" {
    source      = "github.com/skyscrapers/terraform-iam//packer_policy"
  }
```

## terraform_ci

Creates an IAM user to be used to automate Terraform in CI. This terraform user will have admin access to the AWS account.

### Variables

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| environment | The environment where this user is deployed to. If not set or left empty, it'll fallback to `terraform.workspace` | string | `` | no |
| pgp_key | Either a base-64 encoded PGP public key, or a keybase username in the form `keybase:some_person_that_exists`. Will be used to encrypt the secret access key of the created user | string | - | yes |

### Outputs

| Name | Description |
|------|-------------|
| access_key_id | Access Key Id of the created terraform user |
| secret_access_key | The encrypted Secret Access Key of the created terraform user, base64 encoded |
| user_arn | The ARN assigned by AWS for this user |
| user_name | The user's name |
| user_path | Path in which the user is created |
| user_unique_id | The [unique ID](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_identifiers.html#GUIDs) assigned by AWS |

### Example

```tf
module "terraform_ci_user" {
  source  = "github.com/skyscrapers/terraform-iam//terraform_ci"
  pgp_key = "keybase:some_person_that_exists"
}
```

## base_roles

Creates some base IAM roles:

* `admin` with `AdministratorAccess` policy attached
* `ro` with `ReadOnlyAccess` policy attached

### Variables

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| admin_role_principal_ids | List of AWS principal ids (or ARNs) that'll be allowed to assume the admin role in the ops account | list | - | yes |
| readonly_role_principal_ids | List of AWS principal ids (or ARNs) that'll be allowed to assume the readonly role in the ops account | list | - | yes |
| roles_path | Path of the roles created | string | /ops/ | no |

### Outputs

| Name | Description |
|------|-------------|
| admin_role_arn | Admin role ARN |
| ro_role_arn | Readonly role ARN |

### Example

```tf
module "base_roles" {
  source                      = "github.com/skyscrapers/terraform-iam//base_roles"
  readonly_role_principal_ids = ["109034686754"]
  admin_role_principals_arns  = ["arn:aws:iam::109034686754:role/something"]
}
```

## sso

This Terraform module configures the AWS Single Sign-on in the master account. The SSO identity source and SSO groups must be created manually through the AWS console. Populating the groups with users is also outside the scope of this module.

This module manages:

* The different permission sets and their attached policies
* The assignments between permission sets, groups and accounts

The main configuration point of the module is the `permission_sets` variable, where each permission set is assigned a set of policies and mapped to a list of AWS accounts.

### Requirements

No requirements.

### Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

### Modules

No modules.

### Resources

| Name | Type |
|------|------|
| [aws_ssoadmin_account_assignment.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssoadmin_account_assignment) | resource |
| [aws_ssoadmin_managed_policy_attachment.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssoadmin_managed_policy_attachment) | resource |
| [aws_ssoadmin_permission_set.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssoadmin_permission_set) | resource |
| [aws_ssoadmin_permission_set_inline_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssoadmin_permission_set_inline_policy) | resource |
| [aws_iam_policy_document.combined](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.eks_viewer](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_identitystore_group.groups](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/identitystore_group) | data source |

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_permission_sets"></a> [permission\_sets](#input\_permission\_sets) | n/a | <pre>map(object({<br>    description      = string<br>    group            = string<br>    managed_policies = list(string)<br>    inline_policies  = list(string)<br>    eks_access       = bool<br>    account_ids      = list(string)<br>  }))</pre> | n/a | yes |
| <a name="input_sso_instance_arn"></a> [sso\_instance\_arn](#input\_sso\_instance\_arn) | n/a | `string` | n/a | yes |
| <a name="input_sso_instance_id"></a> [sso\_instance\_id](#input\_sso\_instance\_id) | n/a | `string` | n/a | yes |
| <a name="input_default_ps_session_duration"></a> [default\_ps\_session\_duration](#input\_default\_ps\_session\_duration) | n/a | `string` | `"PT8H"` | no |

### Outputs

| Name | Description |
|------|-------------|
| <a name="output_account_assignments"></a> [account\_assignments](#output\_account\_assignments) | n/a |
| <a name="output_permission_set_arns"></a> [permission\_set\_arns](#output\_permission\_set\_arns) | n/a |

### Example

```tf
data "aws_ssoadmin_instances" "main" {}

module "sso_config" {
  source = "github.com/skyscrapers/terraform-iam//sso"

  permission_sets = {
    Developer = {
      description = "Non-privileged developer users"
      group       = "Developers"
      eks_access  = true
      managed_policies = [
        "arn:aws:iam::aws:policy/ViewOnlyAccess"
      ]
      inline_policies = [
        data.aws_iam_policy_document.s3_access.json
      ]
      account_ids = [
        "012345678912",
        "987654321098",
      ]
    }
    ...
  }
  sso_instance_arn = tolist(data.aws_ssoadmin_instances.main.arns)[0]
  sso_instance_id  = tolist(data.aws_ssoadmin_instances.main.identity_store_ids)[0]
}
```

From the above:

* `group` maps to the SSO group where this Permission Set applies. See section below about important [Design considerations](#design-considerations)
* `eks_access`: if the Permission Set is going to be mapped into K8s RBAC, it needs to have read access to the EKS AWS service. This flag ensures that
* `managed_policies`: list of AWS managed policies ARNs
* `inline_policies`: list of policies to assign inline to the Permission Set. These must be references to policies defined as `aws_iam_policy_document` data sources. Note that a Permission Set can only have a single inline policy, but you can define multiple here since there's some logic inside the Terraform module that will merge them into a single one
* `account_ids`: the AWS account ids where to apply the Permission Set with the assigned group

### Design considerations

For each Permission Set that is assigned to an account, AWS SSO creates an IAM role in that account. For example, if the `Developer` Permission Set is used in an account for one or more groups, AWS will create an IAM role named `AWSReservedSSO_Developer_1234567890...` in that account.

We user IAM roles in each of the infrastructure accounts to authenticate to Kubernetes (EKS) clusters, and these roles are mapped to internal k8s groups that are then used to assign different RBAC permissions.

To be able to grant meaningful RBAC permissions in K8s to users, the used IAM roles must identify the group the user belongs to. This is why we made the decision to map each SSO group to a single Permission Set with the same name. This way the information of the group a user belongs to is carried over to the K8s authorization level, and the correct RBAC permissions can be assigned to each group.
