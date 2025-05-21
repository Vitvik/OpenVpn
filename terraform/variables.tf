variable "region" {
  type = string
 // default = "eu-west-1"
  description = "The AWS region to deploy resources in."
}

variable "public_key" {
  description = "SSH public key"
  type        = string
}