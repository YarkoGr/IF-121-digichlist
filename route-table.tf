resource "aws_route_table" "telebot_vpc_us_west_public" {
  vpc_id = aws_vpc.telebot_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.telebot_gw.id
  }

  tags = {
    Name = "telebot Public Subnet Route Table."
  }
}

resource "aws_route_table_association" "telebot_vpc_us_west_public" {
  subnet_id      = aws_subnet.telebot_subnet.id
  route_table_id = aws_route_table.telebot_vpc_us_west_public.id
}
