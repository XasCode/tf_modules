locals {
  corp = element(split("/", var.parent.path), 1)
}