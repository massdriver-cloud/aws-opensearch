resource "random_pet" "domain_name" {
  length    = 2
  separator = "-"
}

resource "random_string" "domain_name_suffix" {
  # 28 char max for OS domain name, save 1 for the hyphen
  length  = 28 - length(random_pet.domain_name.id) - 1
  lower   = true
  number  = true
  special = false
  upper   = false
}


locals {
  domain_name = "${random_pet.domain_name.id}-${random_string.domain_name_suffix.result}"

  # calculate VPC & subnet types
  vpc_id = element(split("/", var.network.data.infrastructure.arn), 1)
  subnet_ids_by_type = {
    "internal" = [for subnet in var.network.data.infrastructure.internal_subnets : element(split("/", subnet["arn"]), 1)]
    "private"  = [for subnet in var.network.data.infrastructure.private_subnets : element(split("/", subnet["arn"]), 1)]
  }
  num_subnets_in_vpc       = length(local.selected_subnet_type_ids)
  selected_subnet_type_ids = local.subnet_ids_by_type[var.networking.subnet_type]

  # Calculate zone awareness and max subnets
  # TODO: 2 nodes, but 3 subnets
  # Max zones supported by OSS = 3, otherwise however many subnets there are
  max_zone_awareness         = local.num_subnets_in_vpc >= 3 ? 3 : local.num_subnets_in_vpc
  auto_enable_zone_awareness = var.cluster.data_nodes.instance_count > 1
  availability_zone_count    = local.auto_enable_zone_awareness ? local.max_zone_awareness : 1
  subnet_ids                 = slice(local.selected_subnet_type_ids, 0, local.availability_zone_count)

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
