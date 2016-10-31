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
