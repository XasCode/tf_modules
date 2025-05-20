resource "github_repository_file" "gh_repo_file_dockerfile" {
  repository          = var.repo.github.name
  branch              = var.environment
  file                = "Dockerfile"
  content             = <<-EOT
    ARG VERSION

    FROM golang:$VERSION-alpine

    RUN apk add --no-cache \
      curl \
      musl-dev \
      bash \
      && :

    RUN apk add --no-cache -X http://dl-4.alpinelinux.org/alpine/edge/main \
      'ca-certificates>=20190108-r0' \
      && :

    RUN cd /tmp && \
      curl -sSLO https://github.com/hashicorp/terraform/archive/main.tar.gz && \
      tar xvzf main.tar.gz \
      && :

    RUN cd /tmp/terraform-main && \
      go install

    ENTRYPOINT [ "/go/bin/terraform" ]
    EOT
  commit_message      = "Managed by Terraform"
  commit_author       = "Terraform User"
  commit_email        = "terraform@xascode.dev"
  overwrite_on_create = true

  depends_on = [
    github_repository_file.gh_repo_file_variables
  ]
}
