resource "aws_ecs_task_definition" "this" {
  family                   = var.task_family
  requires_compatibilities = ["EC2"]
  network_mode             = "bridge"
  cpu                      = var.task_cpu
  memory                   = var.task_memory
  execution_role_arn       = var.execution_role_arn

  container_definitions = jsonencode([
    {
      name      = "app"
      image     = var.app_image
      essential = true
      cpu       = 512
      memory    = 1024
      portMappings = [{
        containerPort = 80
        hostPort      = 80
        protocol      = "tcp"
        appProtocol   = "http"
      }]
      environment = [
        { name = "RAILS_ENV",          value = var.env_rails_env },
        { name = "DB_USER",            value = var.env_db_user },
        { name = "DB_PASSWORD",        value = var.env_db_password },
        { name = "DB_HOST",            value = var.env_db_host },
        { name = "DB_PORT",            value = var.env_db_port },
        { name = "DB_NAME",            value = var.env_db_name },
        { name = "REDIS_URL",          value = var.env_redis_url },
        { name = "RAILS_MASTER_KEY",   value = var.env_rails_master_key },
        { name = "SECRET_KEY_BASE",    value = var.env_secret_key_base }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = "/ecs/${var.task_family}"
          awslogs-region        = var.region
          awslogs-stream-prefix = "app"
        }
      }
      dependsOn = [
        {
          containerName = "redis"
          condition     = "START"
        }
      ]
    },
    {
      name      = "redis"
      image     = var.redis_image
      essential = false
      cpu       = 256
      memory    = 512
      portMappings = [{
        containerPort = 6379
      }]
    }
  ])
}

