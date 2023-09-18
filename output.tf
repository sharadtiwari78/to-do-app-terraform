output "vpc_id" {
  description = "Output the ID for the primary VPC"
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.vpc.private_subnet_ids
}

output "endpoint" {
  value = module.eks_cluster.endpoint
}

output "eks_cluster_name" {
    value = module.eks_cluster.eks_cluster_name
}

output "eks_node_group_name" {
    value = module.eks_node_group.eks_node_group_name
}

