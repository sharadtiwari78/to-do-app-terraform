resource "aws_eks_cluster" "eks_cluster" {
  name     = "${var.project_name}"

# The Amazon Resource Name (ARN) of the IAM role that provides permissions for the Kubernetes control plane to make calls to AWS API operations

  role_arn = aws_iam_role.iam_role.arn

 # Desired Kubernetes master version
  version = "1.27"
  vpc_config {
    subnet_ids = flatten([var.public_subnet_ids, var.private_subnet_ids])
  }
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["eks.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "iam_role" {
  name               = "${var.project_name}-iam-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}


# Resource: aws_iam_role_policy_attachment for EKS cluster and ELB
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment

resource "aws_iam_role_policy_attachment" "role_policy-AmazonEKSClusterPolicy" {

# The ARN of the policy you want to apply
# https://github.com/SummitRoute/aws_managed_policies/blob/master/policies/AmazonEKSClusterPolicy

  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.iam_role.name
}


resource "aws_iam_role_policy_attachment" "role_policy-ElasticLoadBalancingFullAccess" {

# The ARN of the policy you want to apply
#https://github.com/SummitRoute/aws_managed_policies/blob/master/policies/ElasticLoadBalancingFullAccess

  policy_arn = "arn:aws:iam::aws:policy/ElasticLoadBalancingFullAccess"
  role       = aws_iam_role.iam_role.name
}