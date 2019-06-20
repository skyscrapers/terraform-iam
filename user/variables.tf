variable "user_names" {
  type = list(string)
}

variable "pgp_key" {
  description = "(Required) Either a base-64 encoded PGP public key, or a keybase username in the form keybase:username"
}

