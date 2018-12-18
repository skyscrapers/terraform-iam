variable "environment" {
  description = "The environment where this user is deployed to. If not set or left empty, it'll fallback to `terraform.workspace`"
  default     = ""
}

variable "keybase_username" {
  description = "Either a base-64 encoded PGP public key, or a keybase username in the form `keybase:some_person_that_exists`. Will be used to encrypt the secret access key of the created user"
}
