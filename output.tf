output "private_ips" {
  value = aws_instance.instances.*.private_ip
}

output "public_ips" {
  value = aws_instance.instances.*.public_ip
}

output "network_interface_ids" {
  value = aws_network_interface.network_interfaces.*.id
}