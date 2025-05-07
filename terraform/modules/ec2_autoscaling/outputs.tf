output "cluster_name" {
  value = aws_ecs_cluster.this.name
}

output "asg_name" {
  value = aws_autoscaling_group.ecs.name
}

