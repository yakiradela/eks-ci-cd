 output "cluster_endpoint" {
  description = "EKS cluster endpoint"
  value       = module.eks.cluster_endpoint
}

output "cluster_certificate_authority_data" {
  description = "EKS CA certificate"
  value       = module.eks.cluster_certificate_authority_data
}

output "cluster_name" {
  description = "EKS cluster name"
  value       = module.eks.cluster_name
}

output "launch_template_id" {
  value = aws_launch_template.eks_node_template.id
}

output "nat_gateway_id" {
  value       = length(module.vpc.natgw_ids) > 0 ? module.vpc.natgw_ids[0] : null
  description = "The first NAT Gateway ID"
}
