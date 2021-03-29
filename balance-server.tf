resource "aws_instance" "balancer-server" {
  ami                         = "ami-0ca5c3bd5a268e7db"
  instance_type               = var.instance-type
  key_name                    = aws_key_pair.my_keys.key_name
  subnet_id                   = aws_subnet.telebot_subnet.id
  private_ip                  = "20.0.0.103"
  associate_public_ip_address = true

  provisioner "file" {
    source      = "~/DevOps/gmail_aws_digichproject/sh-scripts/apache-balancer.sh"
    destination = "/tmp/apache-balancer.sh"
  }
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/apache-balancer.sh",
      "sudo /tmp/apache-balancer.sh ${aws_instance.be1_server.private_ip} ${aws_instance.be2_server.private_ip}",
    ]
  }
  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("~/.ssh/terraform")
    host        = self.public_ip
  }

  tags = {
    Name = "balancer-server"
  }

  depends_on = [
    aws_instance.be1_server,
    aws_instance.be2_server
  ]

  vpc_security_group_ids = [aws_security_group.balancer-sg.id]
}

resource "aws_security_group" "balancer-sg" {
  name   = "balancer-security"
  vpc_id = aws_vpc.telebot_vpc.id

  tags = {
    Name = "balancer-serv"
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
