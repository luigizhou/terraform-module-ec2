variable "environment" {
  type = string
}

variable "region" {
  type = string
}

variable "application" {
  type = string
}

variable "project" {
  type = string
}

variable "instance_count" {
  type = number
  default = 1
}

variable "ami_id" {
  type = string
}

variable "instance_type" {
  type = string
  default = "t3.small"
}

variable "root_disk_size" {
  type = number
  default = 20
}

variable "additional_disk_size" {
  type = number
  default = 0
}

variable "user_data" {
  type = string
  default = ""
}

variable "iam_policy" {
  type = string
  default = null
}

variable "tags" {
  type = map
  default = {}
}

variable "ingresses" {
  type = list(object({
    from_port = number
    to_port = number
    protocol = string
    cidr_blocks = list(string)
    }))
  default = [
    {
      from_port = 22
      to_port = 22
      protocol = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}

variable "subnets" {
  type = list
}

variable "vpc_id" {
  type = string
}

variable "ssh_key_name" {
  type = string
}