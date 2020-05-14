resource "aws_instance" "instances" {
  count = var.instance_count
  ami = var.ami_id
  instance_type = var.instance_type
  key_name = var.ssh_key_name

  network_interface {
    network_interface_id = aws_network_interface.network_interfaces.*.id[count.index]
    device_index = 0
  }

  tags = merge(map(
    "Name", "${var.application}-${var.project}-${var.environment}-${count.index +1}",
    "Application", var.application,
    "LauchedBy", "Terraform",
    "Environment", var.environment,
    "Team", "OSD",
  ), var.tags)


  root_block_device {
    volume_type = "standard"
    volume_size = var.root_disk_size
  }

  user_data = var.user_data
  iam_instance_profile = aws_iam_instance_profile.instance_profile.name
}


resource "aws_volume_attachment" "volume_attach" {
  count = var.additional_disk_size != 0 ? var.instance_count : 0
  device_name = "/dev/sdf"
  volume_id = aws_ebs_volume.additional_volumes.*.id[count.index]
  instance_id = aws_instance.instances.*.id[count.index]
}

resource "aws_ebs_volume" "additional_volumes" {
  count = var.additional_disk_size != 0 ? var.instance_count : 0
  availability_zone = aws_instance.instances.*.availability_zone[count.index]
  size = var.additional_disk_size

  tags = {
    Name = "${var.application}-${var.project}-${var.environment}-${count.index + 1}"
  }
}

resource "aws_network_interface" "network_interfaces" {
  count = var.instance_count
  subnet_id = random_shuffle.subnets.result[count.index]

  security_groups = [aws_security_group.security_group.id]
  tags = {
    Name = "${var.application}-${var.project}-${var.environment}-${count.index + 1}-nic"
  }
}

resource "random_shuffle" "subnets" {
  input = var.subnets
  result_count = var.instance_count
}
