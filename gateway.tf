resource "aws_internet_gateway" "telebot_gw" {
  vpc_id = aws_vpc.telebot_vpc.id

  tags = {
    Name = "telebot GW"
  }
}
