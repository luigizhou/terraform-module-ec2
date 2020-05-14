region = "eu-west-1"
project = "onboarding"
environment = "dev"
vpc_id = "vpc-0a27940d7ee3144db"
application = "test"
subnets = [
  "subnet-070d7e096865894c5",
  "subnet-0c9f28e6a7bb097a8",
  "subnet-0a9a305ba128e674d",
]
ami_id = "ami-02df9ea15c1778c9c"
root_disk_size = 20
tags = {
  example = "example"
}
ingresses = [{
  from_port = 22
  to_port = 22
  protocol = "TCP"
  cidr_blocks = ["0.0.0.0/0"]
}]
ssh_key_name = "test"