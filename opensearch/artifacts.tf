locals {
  authentication = {
    username = random_pet.master_user_username.id
    password = random_password.master_user_password.result
    hostname = aws_opensearch_domain.main.endpoint
    port     = 443
  }
  infrastructure = {
    arn = aws_opensearch_domain.main.arn
  }

  security = {}
}

resource "massdriver_artifact" "authentication" {
  field    = "authentication"
  name     = "${var.md_metadata.name_prefix} - OpenSearch Authentication"
  artifact = jsonencode(
    {
      infrastructure = local.infrastructure
      authentication = local.authentication
      security       = local.security
      specs = {
        aws = {
          region = var.network.specs.aws.region
        }
        opensearch = {
          version = element(split("_", aws_opensearch_domain.main.engine_version), 1)
        }
      }
    }
  )
}
