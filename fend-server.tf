resource "aws_instance" "fe" {
  ami                         = "ami-0ca5c3bd5a268e7db"
  instance_type               = var.instance-type-medium
  key_name                    = aws_key_pair.my_keys.key_name
  subnet_id                   = aws_subnet.telebot_subnet.id
  private_ip                  = "20.0.0.104"
  associate_public_ip_address = true

  provisioner "file" {
    source      = "~/DevOps/gmail_aws_digichproject/sh-scripts/front-end.sh"
    destination = "/tmp/front-end.sh"
  }
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/front-end.sh",
      "sudo /tmp/front-end.sh ${aws_instance.balancer-server.public_ip}",
    ]
  }
  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("~/.ssh/terraform")
    host        = self.public_ip
  }


  tags = {
    Name = "fe-server"
  }

  depends_on = [
    aws_instance.balancer-server
  ]

  vpc_security_group_ids = [aws_security_group.fe-sg.id]
}

resource "aws_security_group" "fe-sg" {
  name   = "fe-security"
  vpc_id = aws_vpc.telebot_vpc.id

  tags = {
    Name = "fe-server"
  }

  # ingress {
  #   protocol    = "-1"
  #   from_port   = 0
  #   to_port     = 0
  #   cidr_blocks = ["0.0.0.0/0"]
  # }
  ingress {
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
