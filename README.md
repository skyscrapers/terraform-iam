# terraform-iam
Terraform modules to set up a few regularly used IAM resources.

## kms_role
Adds a role and instance profile for KMS access.

### Available variables:
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
```
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
```
  module "packer_policy" {
    source      = "github.com/skyscrapers/terraform-iam//kms_policy"
    kms_key_arn = "${aws_kms_key.kms_key.arn}"
    environment = "staging"
  }
```

## instance_profile
Adds a role and instance profile.

### Available variables:
 * [`project`]: String(required): The name of the project. This is helpful if you have more than 1 project
 * [`environment`]: String(required): How do you want to call your environment, this is helpful if you have more than 1 VPC.
 * [`function`]: String(required): The function of that instance_profile.
 * [`aws_iam_role_policy`]: String: The iam_role_policy for that instance.
 * [`aws_iam_role`]: String(required): the iam_role for that profile.

### Output
 * [`iam_id`]: String: The role profile ID.

### Example
```
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
/

### Output
* [`role_arn`]: String: The Amazon Resource Name (ARN) specifying the role.
* [`role_name`]: String: The name of the role.
* [`role_unique_id`]: String: The stable and unique string identifying the role.

### Example
```
  module "codedeploy_role" {
    source      = "github.com/skyscrapers/terraform-iam//codedeploy_role"
    region      = "eu-west-1"
  }

```

## User

### Available variables:
* [`user_names`]: List(required): List of users that needs to be created
* [`pgp_key`]: String(required): Either a base-64 encoded PGP public key, or a keybase username in the form keybase:username. Used to encrypt the password for safe transport to the user.

### Output
* [`unique_id`]: The unique ID assigned by AWS
* [`passwords`]: The encrypted password, base64 encoded. The encrypted password may be decrypted using: `terraform output password | base64 --decode | keybase pgp decrypt`
* [`arns`]: The ARN assigned by AWS for this user

### Example
```
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
```
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
```
  module "cloudcheckr_role" {
    source      = "github.com/skyscrapers/terraform-iam//cloudcheckr_role"
    external_id = "..."
  }


```


## CloudWatch Monitoring role
Adding role for cloudwatch monitoring to allow instance to send custom metrics

### Available variables
* [`instance_role`]: String(required): The name of the instance role to attach the policies to.
* [`app`]: String(optional): The name of the application to be used in role name.
* [`project`]: String(optional): The name of the project to be used in role name.
* [`environment`]: String(optional): The name of the enviroment to be used in role name.


### Example
```
module "iam-monitoring" {
  source        = "github.com/skyscrapers/terraform-iam//cloudwatch_monitoring_role"
  environment   = "${terraform.workspace}"
  project       = "${var.project}"
  app           = "api"
  instance_role = "${aws_iam_role.role.name}"
}
```

## packer_policy
Creates an IAM policy that allows usage of a Packer with AWS EC2 EBS volumes.

### Output
* [`packer_policy_id`]: String: The generated policy id.
* [`packer_policy_arn`]: String: The generated policy ARN.
* [`packer_policy_name`]: String: The generated policy name.

### Example
```
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
| keybase_username | Either a base-64 encoded PGP public key, or a keybase username in the form `keybase:some_person_that_exists`. Will be used to encrypt the secret access key of the created user | string | - | yes |

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
