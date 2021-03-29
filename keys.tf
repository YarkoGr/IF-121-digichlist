resource "aws_key_pair" "my_keys" {
  public_key = file("/home/slavko/.ssh/terraform.pub")
}
