locals {
  vpc_id = element(split("/", var.network.data.infrastructure.arn), 1)
  subnet_ids = {
    "internal" = [for subnet in var.network.data.infrastructure.internal_subnets : element(split("/", subnet["arn"]), 1)]
    "private"  = [for subnet in var.network.data.infrastructure.private_subnets : element(split("/", subnet["arn"]), 1)]
  }

  domain_name                = "${random_string.domain_name_first.result}${random_string.domain_name.result}"
  auto_enable_zone_awareness = var.cluster.data_nodes.instance_count > 1
  even_number_of_nodes       = var.cluster.data_nodes.instance_count % 2 == 0
  availability_zone_count    = local.auto_enable_zone_awareness ? (local.even_number_of_nodes ? 2 : 3) : 1

  # data_nodes_instance_class = element(split(".", var.cluster.data_nodes.instance_type), 0)
  # are_instances_gravitron   = length(regexall("g$", local.data_nodes_instance_class)) > 0
  # are_instances_gravitron   = endswith(local.data_nodes_instance_class, "g")

  # master_nodes_recommendations = [
  #   {
  #     instance_count_range : [1, 10],
  #     instance_types : ["m5.large.search", "m6g.large.search"]
  #   },
  #   {
  #     instance_count_range : [11, 30],
  #     instance_types : ["c5.2xlarge.search", "c6g.2xlarge.search"]
  #   },
  #   {
  #     instance_count_range : [31, 75],
  #     instance_types : ["c5.4xlarge.search", "c6g.4xlarge.search"]
  #   },
  #   {
  #     instance_count_range : [76, 125],
  #     instance_types : ["r5.2xlarge.search", "r6g.2xlarge.search"]
  #   },
  #   {
  #     instance_count_range : [126, 200],
  #     instance_types : ["r5.4xlarge.search", "r6g.4xlarge.search"]
  #   }
  # ]

  # master_nodes_in_class_range = {
  #   for c in local.master_nodes_recommendations : "${contains(range(c.instance_count_range[0], c.instance_count_range[1]), var.cluster.data_nodes.instance_count)}" => c.instance_types...
  # }

  # master_nodes_instance_types = flatten(local.master_nodes_in_class_range["true"])
  # master_nodes_instance_type  = local.are_instances_gravitron ? local.master_nodes_instance_types[1] : local.master_nodes_instance_types[0]
}
