provider "aws" {
  region=var.region
  access_key=var.aws_access_key
  secret_key=var.aws_secret_key
}

# VPC and Subnets

resource "aws_subnet" "subnet_1" {
  vpc_id=aws_vpc.main.id
  cidr_block="10.0.3.0/24"
  availability_zone="ap-south-1a"
}

resource "aws_subnet" "subnet_2" {
  vpc_id=aws_vpc.main.id
  cidr_block="10.0.6.0/24"
  availability_zone="ap-south-1b"
}
# Internet Gateway
resource "aws_internet_gateway" "main" {
  vpc_id=aws_vpc.main.id
}

# Route Table for Public Subnets
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block="0.0.0.0/0"
    gateway_id=aws_internet_gateway.main.id
  }
}

# Associate the Public Route Table with Subnets
resource "aws_route_table_association" "subnet_1" {
  subnet_id=aws_subnet.subnet_1.id
  route_table_id=aws_route_table.public.id
}

resource "aws_route_table_association" "subnet_2" {
  subnet_id=aws_subnet.subnet_2.id
  route_table_id=aws_route_table.public.id
}

# Security Group
resource "aws_security_group" "app_sg" {
  name="app-sg"
  description="Allow inbound traffic"
  vpc_id=aws_vpc.main.id

  ingress {
    from_port=80
    to_port=80
    protocol="tcp"
    cidr_blocks=["0.0.0.0/0"]
  }
}

# IAM Role for ECS Task Execution
resource "aws_iam_role" "ecs_task_execution" {
  name="ecs-task-execution-role"

  assume_role_policy=jsonencode({
    Version="2012-10-17"
    Statement=[
      {
        Action="sts:AssumeRole"
        Principal={
          Service ="ecs-tasks.amazonaws.com"
        }
        Effect="Allow"
        Sid=""
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_policy" {
  policy_arn="arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
  role=aws_iam_role.ecs_task_execution.name
}

# ECS Cluster
resource "aws_ecs_cluster" "main" {
  name="ecs-cluster"
}

# ECS Task Definition
resource "aws_ecs_task_definition" "app" {
  family="app-task"
  network_mode="awsvpc"
  requires_compatibilities=["FARGATE"]
  execution_role_arn=aws_iam_role.ecs_task_execution.arn
  container_definitions=jsonencode([
    {
      name="app-container"
      image="https://hub.docker.com/repository/docker/mridulpathania/flask-backend"
      cpu=128
      memory= 256
      essential=true
      portMappings=[
        {
          containerPort=80
          hostPort=80
          protocol="tcp"
        }
      ]
    }
  ])
  cpu="256"
  memory="512"
}

# ECS Service
resource "aws_ecs_service" "app_service" {
  name="app-service"
  cluster=aws_ecs_cluster.main.id
  task_definition=aws_ecs_task_definition.app.arn
  desired_count=1
  launch_type="FARGATE"

  network_configuration {
    subnets=[aws_subnet.subnet_1.id, aws_subnet.subnet_2.id]
    security_groups=[aws_security_group.app_sg.id]
  }
}

# Application Load Balancer
resource "aws_lb" "app_lb" {
  name="app-lb"
  internal=false
  load_balancer_type="application"
  security_groups=[aws_security_group.app_sg.id]
  subnets=[
    aws_subnet.subnet_1.id,
    aws_subnet.subnet_2.id 
  ]
  enable_deletion_protection=false
}

# Application Load Balancer Target Group
resource "aws_lb_target_group" "app_tg" {
  name="app-tg"
  port=80
  protocol="HTTP"
  vpc_id=aws_vpc.main.id
}

# ALB Listener
resource "aws_lb_listener" "app_listener" {
  load_balancer_arn=aws_lb.app_lb.arn
  port=80
  protocol="HTTP"

  default_action {
    type="forward"
    target_group_arn=aws_lb_target_group.app_tg.arn
  }
}
