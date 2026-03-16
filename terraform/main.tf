terraform {
  required_version = ">= 1.0"

  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "~> 2.5"
    }
  }
}

# Створення структури папок проекту
resource "local_file" "deploy_dir" {
  content  = ""
  filename = "${path.module}/deploy/.gitkeep"
}

resource "local_file" "configs_dir" {
  content  = ""
  filename = "${path.module}/configs/.gitkeep"
}

resource "local_file" "logs_dir" {
  content  = ""
  filename = "${path.module}/logs/.gitkeep"
}

# Динамічне створення app_config.json
resource "local_file" "app_config" {
  content = jsonencode({
    project_name = var.project_name
    version      = var.project_version
    author       = var.author
    created_at   = timestamp()
  })
  filename = "${path.module}/configs/app_config.json"
}
