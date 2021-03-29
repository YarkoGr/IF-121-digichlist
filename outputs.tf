output "db_private_ip" {
  value = aws_instance.db_mongo.private_ip
}
output "be1_private_ip" {
  value = aws_instance.be1_server.private_ip
}
output "be2_private_ip" {
  value = aws_instance.be2_server.private_ip
}
output "balancer_public_ip" {
  value = aws_instance.balancer-server.public_ip
}
