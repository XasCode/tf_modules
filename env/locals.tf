locals {
  corp = element(split("/", var.parent.path), length(split("/", var.parent.path)) - 2)
}