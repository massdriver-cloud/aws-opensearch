resource "aws_cloudwatch_log_group" "main" {
  for_each          = var.logging
  name_prefix       = "/aws/opensearch/${var.md_metadata.name_prefix}/${each.key}/"
  retention_in_days = each.value
  kms_key_id        = data.aws_kms_alias.opensearch.target_key_arn
}

data "aws_iam_policy_document" "opensearch-cloudwatch_policy" {
  statement {
    # TODO: restrict
    # actions = ["logs:CreateLogStream", "logs:PutLogEvents", "logs:PutLogEventsBatch"]
    actions = ["logs:*"]

    # TODO: restrict
    # resources = [for lg in aws_cloudwatch_log_group.main : lg.arn]
    resources = ["*"]

    principals {
      # TODO: restrict
      # identifiers = ["opensearchservice.amazonaws.com"]
      identifiers = ["opensearchservice.amazonaws.com", "es.amazonaws.com"]
      type        = "Service"
    }
  }
}

resource "aws_cloudwatch_log_resource_policy" "opensearch_log_publishing_policy" {
  policy_document = data.aws_iam_policy_document.opensearch-cloudwatch_policy.json
  policy_name     = var.md_metadata.name_prefix
}
