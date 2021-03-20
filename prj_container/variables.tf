variable "name" {
  description = "Project name."
  type        = string
}

variable "parent" {
  description = "Path and name identifier for the parent of this project."
  type = object({
    path = string
    name = string
  })
}
