resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = tls_private_key.ed25519-example.public_key_openssh
}

resource "tls_private_key" "ed25519-example" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
resource "local_file" "TF-key" {
  content  = tls_private_key.ed25519-example.private_key_pem
  filename = "deployer-key.pem"
}