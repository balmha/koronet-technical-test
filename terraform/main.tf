module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = var.cluster_name
  cluster_version = "1.30"
  subnet_ids      = module.vpc.public_subnets
  vpc_id          = module.vpc.vpc_id
  cluster_endpoint_public_access = true

  # EKS Addons
  cluster_addons = {
    coredns                = {}
    eks-pod-identity-agent = {}
    kube-proxy             = {}
    vpc-cni                = {}
  }

  eks_managed_node_groups = {
    nodejs = {
      use_name_prefix = true

      subnet_ids            = module.vpc.private_subnets
      create_security_group = true

      min_size     = 1
      max_size     = 2
      desired_size = 1

      instance_types = ["t3.medium"]
      capacity_type  = "SPOT"
    }
  }
}