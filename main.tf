#Create Module for VPC
module "vpc" {
  source          = "./modules/vpc"
  project_name    = var.project_name
  vpc_name        = "${var.project_name}-vpc"
  vpc_cidr        = var.vpc_cidr
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets
}


#Create EKS Cluster
module "eks_cluster"{
  source = "./modules/aws_eks_cluster"
  project_name = var.project_name
  public_subnet_ids = module.vpc.public_subnet_ids
  private_subnet_ids  = module.vpc.private_subnet_ids
}

module "eks_node_group"{
  source = "./modules/aws_eks_node_group"
  project_name = var.project_name
  eks_cluster_name = module.eks_cluster.eks_cluster_name
  subnet_ids = module.vpc.private_subnet_ids
}




