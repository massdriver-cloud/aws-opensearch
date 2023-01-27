data "aws_caller_identity" "current" {}

resource "aws_kms_key" "opensearch" {
  description             = "OpenSearch Encryption Key for ${var.md_metadata.name_prefix}"
  deletion_window_in_days = 30
  enable_key_rotation     = true
  policy                  = data.aws_iam_policy_document.kms.json
}

resource "aws_kms_alias" "opensearch" {
  name          = "alias/${var.md_metadata.name_prefix}-opensearch-encryption"
  target_key_id = aws_kms_key.opensearch.key_id
}

data "aws_iam_policy_document" "kms" {
  statement {
    sid       = "Allow access to Cloudwatch for all log groups provisioned by ${var.md_metadata.name_prefix}"
    effect    = "Allow"
    resources = ["*"]

    principals {
      type = "Service"
      identifiers = [
        "logs.${var.network.specs.aws.region}.amazonaws.com"
      ]
    }

    actions = [
      "kms:Encrypt*",
      "kms:Decrypt*",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:Describe*"
    ]

    condition {
      test     = "ArnLike"
      variable = "kms:EncryptionContext:aws:logs:arn"

      values = [
        "arn:aws:logs:${var.network.specs.aws.region}:${data.aws_caller_identity.current.account_id}:log-group:/aws/opensearch/${var.md_metadata.name_prefix}/*"
      ]
    }
  }

  statement {
    sid = "Enable IAM User Permissions"
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
    }
    effect    = "Allow"
    actions   = ["kms:*"]
    resources = ["*"]
  }
}
