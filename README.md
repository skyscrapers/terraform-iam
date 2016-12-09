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
* [`php_key`]: String(required): Either a base-64 encoded PGP public key, or a keybase username in the form keybase:username

### Output
* [`unique_id`]: The unique ID assigned by AWS
* [`passwords`]: The encrypted password, base64 encoded
* [`arns`]: The ARN assigned by AWS for this user

### Example
```
module "iam_users" {
  source = "github.com/skyscrapers/terraform-iam//user"
  user_names = ["user1", "user2", "user3"]
  pgp_key = "keybase:user"
}
```
