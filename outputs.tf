output "eks_cluster_id" {
  description = "EKS Cluster ID"
  value       = module.eks_cluster.cluster_id
}

output "eks_cluster_endpoint" {
  description = "EKS Cluster endpoint"
  value       = module.eks_cluster.endpoint
}
