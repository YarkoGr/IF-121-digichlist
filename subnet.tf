resource "aws_subnet" "telebot_subnet" {
  vpc_id            = aws_vpc.telebot_vpc.id
  cidr_block        = "20.0.0.0/24"
  availability_zone = "us-west-2a"


  tags = {
    Name = "telebot subnet"
  }
}
