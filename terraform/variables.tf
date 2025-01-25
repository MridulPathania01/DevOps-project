# Variables for general configurations
variable "aws_access_key" {
  description="AWS Access Key"
  
  sensitive = true
}

variable "aws_secret_key" {
  description="AWS Secret Key"
  
  sensitive = true
}

variable "region" {
  description="AWS Region"
  default="ap-south-1"
}

variable "docker_image_url" {
  description="Docker Image URL"
  default="https://hub.docker.com/repository/docker/mridulpathania/flask-backend"
}

variable "api_key" {
  description= "API Key"
  
  sensitive = true
}



# Networking configurations
variable "vpc_cidr_block"{
  default="10.0.0.0/16"
}

variable "subnet_cidr_block"{
  default=["10.0.1.0/24", "10.0.2.0/24"]
}

# Task definitions
variable "task_cpu"{
  default=256
}

variable "task_memory" {
  default=512
}