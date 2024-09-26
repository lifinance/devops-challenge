variable "aws_region" {
  description = "The AWS region"
  type        = string
  default     = "us-east-1"
}
variable "instance_type" {
  description = "instance type"
  default     = "t2.micro"
  type        = string
}
variable "vpc_availability_zones" {
  description = "value"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
}
variable "business_division" {
  type    = string
  default = "li-fi"
}
variable "environment" {
  type    = string
  default = "dev"
}