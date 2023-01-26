# https://github.com/terraform-providers/terraform-provider-aws/issues/5218
# https://github.com/cloudposse/terraform-aws-elasticsearch/issues/5

# The linked service role can only be created once per account. This is conditionally created if it doesnt not exist.

# Could this be solved with a custom_suffix?
#   No. Elasticsearch service and OpenSearch service both do _not_ support custom suffix.

# This step is skipped during decommission to preserve the service role.
#   The module that creates the role needs to know if it created it before the count is set ...
#   if this root module creates it, then checks data, it says its created, so the count is now 0 and it deletes it, thus we cache
#   But if we cache and this module is deleted, no other module will make it because _they also cache_.

locals {
  opensearch_service_linked_role = {
    service_name = "opensearchservice.amazonaws.com"
    role_name    = "AWSServiceRoleForAmazonOpenSearchService"
    path_prefix  = "/aws-service-role/opensearchservice.amazonaws.com/"
  }
}

data "aws_iam_roles" "path_prefix" {
  path_prefix = local.opensearch_service_linked_role.path_prefix
}

resource "cache_store" "service_linked_role_exists" {
  value = contains(data.aws_iam_roles.path_prefix.names, local.opensearch_service_linked_role.role_name)
}

resource "aws_iam_service_linked_role" "main" {
  count            = cache_store.service_linked_role_exists.value ? 0 : 1
  aws_service_name = local.opensearch_service_linked_role.service_name
  description      = "${local.opensearch_service_linked_role.role_name} Service-Linked Role"
}
