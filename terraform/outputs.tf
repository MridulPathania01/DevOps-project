output "ecs_cluster_name" {
  value=aws_ecs_cluster.main.name
}

output "ecs_service_name" {
  value=aws_ecs_service.app_service.name
}

output "alb_dns_name" {
  value=aws_lb.app_lb.dns_name
}