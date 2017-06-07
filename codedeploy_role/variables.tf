variable "region" {
  description = "Region where codedeploy will run in"
  default = "eu-west-1"
}
variable "sns_notify" {
  default = false
}
