data "aws_vpc" "vpc" {
  id = var.vpc_id
}

data "aws_subnet" "private_subnets" {
  for_each = toset(var.private_subnets)
  id       = each.value
}

resource "aws_security_group" "default" {
  name        = "${var.workspace_name}-default"
  description = "Default security group for databricks workspace: ${var.workspace_name}"
  vpc_id      = data.aws_vpc.vpc.id

  ingress {
    from_port = 0
    to_port   = 65535
    protocol  = "tcp"
    self      = true
  }

  ingress {
    from_port = 0
    to_port   = 65535
    protocol  = "udp"
    self      = true
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [data.aws_vpc.vpc.cidr_block]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  # TODO: Add your ingress / egress here

  tags = var.tags
}

resource "databricks_mws_networks" "default" {
  provider           = databricks.mws
  account_id         = var.databricks_account_id
  network_name       = "${var.workspace_name}-default"
  security_group_ids = [aws_security_group.default.id]
  subnet_ids         = [for private_subnet in data.aws_subnet.private_subnets : private_subnet.id]
  vpc_id             = data.aws_vpc.vpc.id
}
