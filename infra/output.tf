output "instance_ip_addr" {
  description = "ip address of the instance"
  value       = module.ec2_instance.public_ip
}

output "aws_vpc" {
  value = module.vpc.vpc_id
}

output "arn" {
  value = module.ec2_instance.arn
}

output "igw_arn" {
  value = module.vpc.igw_arn
}

output "azs" {
  value = module.vpc.azs
}
output "name" {
  value = module.vpc.name
}