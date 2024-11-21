
module "ec2_instance" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name = "test-instance"

  instance_type               = "t2.micro"
  ami                         = "ami-0e86e20dae9224db8"
  key_name                    = "deployer-key"
  availability_zone           = var.vpc_availability_zones[0]
  user_data                   = file("userdata/user_data.sh")
  associate_public_ip_address = true
  iam_role_name               = "test-role"
  monitoring                  = true
  vpc_security_group_ids      = ["aws_security_group.bastion-instance.id"]
  #vpc_security_group_ids      = [aws_security_group.bastion-instance.id]
  subnet_id = module.vpc.public_subnets[0]

  tags = {
    Name = local.name
  }
}


# module "ec2_instance1" {
#   source = "terraform-aws-modules/ec2-instance/aws"

#   name = "test-instance"

#   instance_type               = "t2.micro"
#   ami                         = "ami-0e86e20dae9224db8"
#   key_name                    = "deployer-key"
#   availability_zone           = var.vpc_availability_zones[0]
#   user_data                   = file("userdata/mysql.sh")
#   associate_public_ip_address = true
#   iam_role_name               = "test-role"
#   monitoring                  = true
#   #vpc_security_group_ids      = [aws_security_group.bastion-instance.id]
#   subnet_id                   = module.vpc.public_subnets[0]

#   tags = {
#     Name = "mysql"
#   }
# }


# module "ec2_instance2" {
#   source = "terraform-aws-modules/ec2-instance/aws"

#   name = "test-instance"

#   instance_type               = "t2.micro"
#   ami                         = "ami-0e86e20dae9224db8"
#   key_name                    = "deployer-key"
#   availability_zone           = var.vpc_availability_zones[0]
#   user_data                   = file("userdata/nginx.sh")
#   associate_public_ip_address = true
#   iam_role_name               = "test-role"
#   monitoring                  = true
#   vpc_security_group_ids      = [aws_security_group.bastion-instance.id]
#   subnet_id                   = module.vpc.public_subnets[0]

#   tags = {
#     Name = "nginx"
#   }
# }

# module "ec2_instance3" {
#   source = "terraform-aws-modules/ec2-instance/aws"

#   name = "test-instance"

#   instance_type               = "t2.micro"
#   ami                         = "ami-0e86e20dae9224db8"
#   key_name                    = "deployer-key"
#   availability_zone           = var.vpc_availability_zones[0]
#   user_data                   = file("userdata/tomcat.sh")
#   associate_public_ip_address = true
#   iam_role_name               = "test-role"
#   monitoring                  = true
#   vpc_security_group_ids      = [aws_security_group.bastion-instance.id]
#   subnet_id                   = module.vpc.public_subnets[0]

#   tags = {
#     Name = "tomcat"
#   }
# }

# module "ec2_instance4" {
#   source = "terraform-aws-modules/ec2-instance/aws"

#   name = "test-instance"

#   instance_type               = "t2.micro"
#   ami                         = "ami-0e86e20dae9224db8"
#   key_name                    = "deployer-key"
#   availability_zone           = var.vpc_availability_zones[0]
#   user_data                   = file("userdata/mc.sh")
#   associate_public_ip_address = true
#   iam_role_name               = "test-role"
#   monitoring                  = true
#   vpc_security_group_ids      = [aws_security_group.bastion-instance.id]
#   subnet_id                   = module.vpc.public_subnets[0]

#   tags = {
#     Name = "memcache"
#   }
# }

# module "ec2_instance5" {
#   source = "terraform-aws-modules/ec2-instance/aws"

#   name = "test-instance"

#   instance_type               = "t2.micro"
#   ami                         = "ami-0e86e20dae9224db8"
#   key_name                    = "deployer-key"
#   availability_zone           = var.vpc_availability_zones[0]
#   user_data                   = file("userdata/rabbitmq.sh")
#   associate_public_ip_address = true
#   iam_role_name               = "test-role"
#   monitoring                  = true
#   #vpc_security_group_ids      = [aws_security_group.bastion-instance.id]
#   subnet_id                   = module.vpc.public_subnets[0]

#   tags = {
#     Name = "rabbitmq"
#   }
# }

# module "ec2_instance6" {
#   source = "terraform-aws-modules/ec2-instance/aws"

#   name = "test-instance"

#   instance_type               = "t2.micro"
#   ami                         = "ami-0e86e20dae9224db8"
#   key_name                    = "deployer-key"
#   availability_zone           = var.vpc_availability_zones[0]
#   user_data                   = file("userdata/backend.sh")
#   associate_public_ip_address = true
#   iam_role_name               = "test-role"
#   monitoring                  = true
#   #vpc_security_group_ids      = [aws_security_group.bastion-instance.id]
#   subnet_id                   = module.vpc.public_subnets[0]

#   tags = {
#     Name = "backened"
#   }
# }