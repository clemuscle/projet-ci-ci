resource "aws_key_pair" "devops" {
  key_name   = "devops"
  public_key = file("~/.ssh/id_rsa.pub")  # Ensure this path is correct
}

output "ssh_key" {
  value = aws_key_pair.devops.key_name
}