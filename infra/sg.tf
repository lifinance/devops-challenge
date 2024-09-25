
locals {
  ports = [80, 22, 443]
}
resource "aws_security_group" "bastion-instance" {
  name        = "webserver"
  vpc_id      = module.vpc.vpc_id
  description = "Inbound Rules for WebServer"

  dynamic "ingress" {
    iterator = port
    for_each = local.ports
    content {
      description = "description ${port.key}"
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  dynamic "egress" {
    iterator = port
    for_each = local.ports
    content {
      description = "description ${port.key}"
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

}