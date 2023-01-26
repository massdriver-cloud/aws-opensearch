resource "aws_cloudwatch_log_group" "main" {
  for_each          = var.logging
  name_prefix       = "/aws/opensearch/${var.md_metadata.name_prefix}/${each.key}/"
  retention_in_days = each.value
  kms_key_id        = data.aws_kms_alias.opensearch.arn
}

locals {
  # TODO: too permissive, compute from var.logging group above
  cloudwatch_resource_arns = ["arn:aws:logs:*"]
}


data "aws_iam_policy_document" "opensearch-cloudwatch_policy" {
  statement {
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:PutLogEventsBatch"
    ]

    resources = local.cloudwatch_resource_arns

    principals {
      # TODO: strip es?
      identifiers = ["opensearchservice.amazonaws.com", "es.amazonaws.com"]
      type        = "Service"
    }
  }
}

resource "aws_cloudwatch_log_resource_policy" "opensearch_log_publishing_policy" {
  policy_document = data.aws_iam_policy_document.opensearch-cloudwatch_policy.json
  policy_name     = var.md_metadata.name_prefix
}
