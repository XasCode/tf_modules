resource "github_repository_file" "gh_repo_file_dockerfile" {
  repository          = var.repo.github.name
  branch              = var.environment
  file                = "Dockerfile"
  content             = <<-EOT
    FROM alpine:3.12.0 as scanner_builder

    ARG VERSION

    RUN apk add --no-cache \
      curl \
      musl-dev \
      bash \
      && :

    RUN apk add --no-cache -X http://dl-4.alpinelinux.org/alpine/edge/community \
      'go>=1.11.5-r0' \
      && :

    RUN apk add --no-cache -X http://dl-4.alpinelinux.org/alpine/edge/main \
      'ca-certificates>=20190108-r0' \
      && :


    RUN cd /tmp && \
      curl -sSLO https://github.com/ssllabs/ssllabs-scan/archive/master.tar.gz && \
      tar xvzf master.tar.gz && \
      cd ssllabs-scan-master && \
      GOPATH=~ \
      CGO_ENABLED=0 \
      GOOS=linux \
      LIBRARY_PATH=/usr/lib/x86_64-linux-gnu:$LIBRARY_PATH \
      go build \
        -a \
        -tags netgo \
        -ldflags '-extldflags "-static" -s' \
        -buildmode exe \
        ssllabs-scan-v3.go
    EOT
  commit_message      = "Managed by Terraform"
  commit_author       = "Terraform User"
  commit_email        = "terraform@xascode.dev"
  overwrite_on_create = true

  depends_on = [
    github_repository_file.gh_repo_file_variables
  ]
}
