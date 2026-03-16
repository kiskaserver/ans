output "project_structure" {
  description = "Created project directories"
  value = [
    local_file.deploy_dir.filename,
    local_file.configs_dir.filename,
    local_file.logs_dir.filename,
  ]
}

output "config_file_path" {
  description = "Path to the generated app_config.json"
  value       = local_file.app_config.filename
}
