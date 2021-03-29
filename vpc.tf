resource "aws_vpc" "telebot_vpc" {
  cidr_block           = "20.0.0.0/16"
  enable_dns_hostnames = true

  tags = {
    Name = "talabot vpc"
  }
}
