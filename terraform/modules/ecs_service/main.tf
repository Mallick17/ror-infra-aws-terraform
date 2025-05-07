resource "aws_ecs_service" "this" {
  name            = var.service_name
  cluster         = var.cluster_id
  task_definition = aws_ecs_task_definition.this.arn
  desired_count   = var.desired_count
  launch_type     = "EC2"

  deployment_controller {
    type = "ECS"
  }

  deployment_minimum_healthy_percent = 100
  deployment_maximum_percent         = 200

  enable_ecs_managed_tags = true
  propagate_tags           = "SERVICE"

  placement_constraints {
    type = "memberOf"
    expression = "attribute:ecs.availability-zone in [${join(",", var.availability_zones)}]"
  }
}

