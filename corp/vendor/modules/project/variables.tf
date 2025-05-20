variable "name" {
  description = "Project name."
  type        = string
  validation {
    condition = length(var.name) < 23
    error_message = "Length of project name must be 23 characters or less to guarantee project_id is less than or equal to the 30 character limit."
  }
}

variable "parent" {
  description = "Path and name identifier for the folder containing the project."
  type = object({
    path = string
    name = string
  })
}

variable "billing_account" {
  description = "The account to bill project resources to."
  type = string
}

variable "envs" {
  type = list(string)
}

variable "environment" {
  type = string
}

variable "snapshots" {
  type = object({
    days_in_cycle = number
    start_time = string
    max_retention_days = number
    storage_locations = list(string)
  })
  default = {
    days_in_cycle = 1
    start_time = "00:00"
    max_retention_days = 4
    storage_locations = ["us"]
  }
}
