data "aws_caller_identity" "current" {}
data "aws_kms_alias" "opensearch" {
  name = "alias/${var.md_metadata.name_prefix}-opensearch-encryption"
}

data "aws_iam_policy_document" "access_policy" {
  statement {
    actions   = ["es:*"]
    resources = ["arn:aws:es:${var.network.specs.aws.region}:${data.aws_caller_identity.current.account_id}:domain/${local.domain_name}/*"]

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
  }
}

resource "random_pet" "master_user_username" {
  separator = ""
}

resource "random_password" "master_user_password" {
  length      = 16
  lower       = true
  number      = true
  special     = true
  upper       = true
  min_lower   = 1
  min_upper   = 1
  min_special = 1
  min_numeric = 1
}

resource "aws_opensearch_domain" "main" {
  depends_on      = [aws_cloudwatch_log_resource_policy.opensearch_log_publishing_policy]
  domain_name     = local.domain_name
  engine_version  = var.opensearch.version
  access_policies = data.aws_iam_policy_document.access_policy.json


  cluster_config {
    instance_type            = var.cluster.data_nodes.instance_type
    instance_count           = var.cluster.data_nodes.instance_count
    dedicated_master_count   = var.cluster.master_nodes.enabled ? 3 : null
    dedicated_master_enabled = var.cluster.master_nodes.enabled
    dedicated_master_type    = local.master_nodes_instance_type
    zone_awareness_enabled   = local.auto_enable_zone_awareness
    zone_awareness_config {
      # Can't set this value if its not enabled, so null in that case.
      availability_zone_count = local.auto_enable_zone_awareness ? local.availability_zone_count : null
    }
  }

  encrypt_at_rest {
    enabled    = true
    kms_key_id = data.aws_kms_alias.opensearch.target_key_id
  }

  auto_tune_options {
    desired_state       = "ENABLED"
    rollback_on_disable = "NO_ROLLBACK"
  }

  node_to_node_encryption {
    enabled = true
  }

  domain_endpoint_options {
    enforce_https       = true
    tls_security_policy = "Policy-Min-TLS-1-2-2019-07"
  }

  vpc_options {
    security_group_ids = [aws_security_group.main.id]
    subnet_ids         = local.subnet_ids
  }

  dynamic "log_publishing_options" {
    for_each = var.logging
    content {
      enabled                  = true
      log_type                 = upper(log_publishing_options.key)
      cloudwatch_log_group_arn = aws_cloudwatch_log_group.main[log_publishing_options.key].arn
    }
  }

  advanced_security_options {
    # One form of auth must be configured below for audit logs
    enabled = true

    internal_user_database_enabled = true
    master_user_options {
      master_user_name     = random_pet.master_user_username.id
      master_user_password = random_password.master_user_password.result
    }
  }

  # TODO:
  # ebs_options {
  #   ebs_enabled = true
  #   # iops - (Optional) Baseline input/output (I/O) performance of EBS volumes attached to data nodes. Applicable only for the GP3 and Provisioned IOPS EBS volume types.
  #   # throughput - (Required if volume_type is set to gp3) Specifies the throughput (in MiB/s) of the EBS volumes attached to data nodes. Applicable only for the gp3 volume type. Valid values are between 125 and 1000.
  #   # volume_size - (Required if ebs_enabled is set to true.) Size of EBS volumes attached to data nodes (in GiB).
  #   # volume_type - (Optional) Type of EBS volumes attached to data nodes.
  # }
}
