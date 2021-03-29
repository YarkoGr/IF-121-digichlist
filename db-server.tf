resource "aws_instance" "db_mongo" {
  ami                         = "ami-0ca5c3bd5a268e7db"
  instance_type               = var.instance-type
  key_name                    = aws_key_pair.my_keys.key_name
  subnet_id                   = aws_subnet.telebot_subnet.id
  private_ip                  = "20.0.0.100"
  associate_public_ip_address = true

  provisioner "file" {
    source      = "~/DevOps/gmail_aws_digichproject/sh-scripts/mongo.sh"
    destination = "/tmp/mongo.sh"
  }
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/mongo.sh",
      "sudo /tmp/mongo.sh ${aws_instance.db_mongo.private_ip}",
    ]
  }
  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("~/.ssh/terraform")
    host        = self.public_ip
  }

  tags = {
    Name = "db_mongo_serv"
  }

  vpc_security_group_ids = [aws_security_group.db_mongo_sg.id]
}


resource "aws_security_group" "db_mongo_sg" {
  name   = "db_mongo_security"
  vpc_id = aws_vpc.telebot_vpc.id


  tags = {
    Name = "db_mongo_serv"
  }

  ingress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol    = "tcp"
    from_port   = 27017
    to_port     = 27017
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

