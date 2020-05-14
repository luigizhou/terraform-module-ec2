
resource "aws_security_group" "security_group" {
  name = "${var.application}-${var.project}-${var.environment}-sg"
  description = "Managed by Terraform"

  vpc_id = var.vpc_id

  tags = {
    Name = "${var.application}-${var.project}-${var.environment}-sg"
  }
}



resource "aws_security_group_rule" "egress" {
  type = "egress" 
  from_port = 0
  to_port = 65535
  protocol = "all"
  ## Provide a whitelist. For the moment everything is open
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.security_group.id
}

# resource "aws_security_group_rule" "between_nodes" {
#   type = "ingress"
#   from_port = 0
#   to_port = 65535
#   protocol = "all"
#   self = true
#   security_group_id = aws_security_group.security_group.id
# }

resource "aws_security_group_rule" "ingress_rules" {
  count = length(var.ingresses)
  type = "ingress"
  from_port = var.ingresses[count.index].from_port
  to_port = var.ingresses[count.index].to_port
  protocol = var.ingresses[count.index].protocol
  cidr_blocks = var.ingresses[count.index].cidr_blocks
  security_group_id = aws_security_group.security_group.id
}
