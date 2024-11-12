provider "aws" {
  region = "us-west-2" # Cambia a tu región preferida
}

provider "kubernetes" {
  host                   = module.eks_cluster.endpoint
  token                  = data.aws_eks_cluster_auth.cluster.token
  cluster_ca_certificate = base64decode(module.eks_cluster.certificate_authority[0].data)
}

# Módulo EKS
module "eks_cluster" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = "practice-eks-cluster"
  cluster_version = "1.26"
  subnets         = module.vpc.public_subnets
  vpc_id          = module.vpc.vpc_id

  # Configuración de costos
  manage_aws_auth = true
  node_groups = {
    spot_nodes = {
      desired_capacity = 1
      max_capacity     = 3
      min_capacity     = 1
      instance_type    = "t3.medium"  # Usa instancias t3.small si deseas reducir aún más
      spot_price       = "0.02"       # Precio máximo para Spot
    }
  }
}

# CloudWatch Logs para el clúster EKS
resource "aws_cloudwatch_log_group" "eks_log_group" {
  name              = "/aws/eks/practice-eks-cluster/logs"
  retention_in_days = 3 # Mantén los logs solo 3 días para reducir costos
}

output "eks_cluster_endpoint" {
  value = module.eks_cluster.endpoint
}

output "eks_cluster_security_group_id" {
  value = module.eks_cluster.cluster_security_group_id
}
