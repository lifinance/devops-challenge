
module "ec2_instance" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name = "test-instance"

  instance_type               = "t2.micro"
  ami                         = "ami-0e86e20dae9224db8"
  key_name                    = "deployer-key"
  availability_zone           = var.vpc_availability_zones[0]
  user_data                   = file("user_data.sh")
  associate_public_ip_address = true
  monitoring                  = true
  vpc_security_group_ids      = [aws_security_group.bastion-instance.id]
  subnet_id                   = module.vpc.public_subnets[0]

  tags = {
    Name = local.name
  }
}