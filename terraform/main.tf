module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = var.cluster_name
  cluster_version = "1.30"
  subnet_ids      = aws_subnet.public[*].id
  vpc_id          = aws_vpc.main.id

  eks_managed_node_groups = {
    nodejs = {
      # By default, the module creates a launch template to ensure tags are propagated to instances, etc.,
      # so we need to disable it to use the default template provided by the AWS EKS managed node group service
      create_launch_template = false
      launch_template_name   = ""

      use_name_prefix = true

      subnet_ids            = aws_subnet.private[*].id
      create_security_group = true

      min_size     = 1
      max_size     = 3
      desired_size = 2

      instance_types = ["t3.medium"]
      capacity_type  = "SPOT"
      enable_monitoring       = true
    }
  }
}

data "aws_availability_zones" "available" {}