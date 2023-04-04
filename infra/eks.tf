module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 19.0"

  cluster_name    = var.cluster_name  
  cluster_version = "1.24"
  cluster_endpoint_private_access  = true

  vpc_id                   = module.vpc.vpc_id
  subnet_ids               = module.vpc.private_subnets

  eks_managed_node_groups = {
    alura = {
      min_size     = 1
      max_size     = 10
      desired_size = 3
      vpc_security_group_ids = [aws_security_group.ssh_cluster.id]
      instance_types = ["t2.micro"]
    }
  }


/*   # aws-auth configmap
  manage_aws_auth_configmap = true

  aws_auth_roles = [
    {
      rolearn  = "arn:aws:iam::66666666666:role/role1"
      username = "role1"
      groups   = ["system:masters"]
    },
  ]

  aws_auth_users = [
    {
      userarn  = "arn:aws:iam::66666666666:user/user1"
      username = "user1"
      groups   = ["system:masters"]
    },
    {
      userarn  = "arn:aws:iam::66666666666:user/user2"
      username = "user2"
      groups   = ["system:masters"]
    },
  ]

  aws_auth_accounts = [
    "777777777777",
    "888888888888",
  ]

  tags = {
    Environment = "dev"
    Terraform   = "true"
  } */
}