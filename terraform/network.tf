resource "aws_vpc" "main" {
  cidr_block=var.vpc_cidr_block
  tags={
    Name="main-vpc"
  }
}

resource "aws_subnet" "main" {
  count=length(var.subnet_cidr_block)
  vpc_id=aws_vpc.main.id
  cidr_block=element(var.subnet_cidr_block, count.index)
}

resource "aws_security_group" "main" {
  name_prefix="my-sg-"
  description="Allow traffic for ALB and ECS"
  vpc_id=aws_vpc.main.id

  ingress{
    from_port=80
    to_port=80
    protocol="tcp"
    cidr_blocks=["0.0.0.0/0"]
  }

  ingress {
    from_port=443
    to_port=443
    protocol="tcp"
    cidr_blocks=["0.0.0.0/0"]
  }

  egress {
    from_port=0
    to_port=0
    protocol="-1"
    cidr_blocks=["0.0.0.0/0"]
  }
}