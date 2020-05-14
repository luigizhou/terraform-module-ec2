
resource "aws_iam_instance_profile" "instance_profile" {
  name = "${var.application}-${var.project}-${var.environment}-instance-profile"
  role = aws_iam_role.iam_role.name
}

resource "aws_iam_role" "iam_role" {
  name = "${var.application}-${var.project}-${var.environment}-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
  EOF
}

resource "aws_iam_role_policy" "iam_policy" {
  count = var.iam_policy != null ? 1 : 0
  name = "${var.application}-${var.project}-${var.environment}-policy"
  role = aws_iam_role.iam_role.id

  policy = var.iam_policy
}
