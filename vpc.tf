resource "aws_vpc_endpoint" "ecr-api" {
  vpc_id              = var.vpc_id
  service_name        = "com.amazonaws.${var.aws_region}.ecr.api"
  private_dns_enabled = true
  vpc_endpoint_type   = "Interface"
  security_group_ids  = [aws_security_group.allow_tls.id]
  subnet_ids          = var.vpc_private_subnets
}

resource "aws_vpc_endpoint" "ecr-dkr" {
  vpc_id              = var.vpc_id
  service_name        = "com.amazonaws.${var.aws_region}.ecr.dkr"
  private_dns_enabled = true
  vpc_endpoint_type   = "Interface"
  security_group_ids  = [aws_security_group.allow_tls.id]
  subnet_ids          = var.vpc_private_subnets
}

resource "aws_security_group" "allow_tls" {
  name        = "ecr_privatelink_allow_tls"
  description = "Allow TLS inbound traffic for ecr privatelink"
  vpc_id      = var.vpc_id

  ingress {
    description = "TLS from VPC to ecr privatelink"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = var.vpc_cidr_block
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}
