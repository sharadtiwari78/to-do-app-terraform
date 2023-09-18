resource "aws_eks_node_group" "eks_node_group" {
  cluster_name    = var.eks_cluster_name
  node_group_name = "${var.project_name}-eks-node-group"
  node_role_arn   = aws_iam_role.node_group_role.arn
  subnet_ids      = "${var.subnet_ids}"

# Configuration block
  scaling_config {
    # Required number of worker nodes
    desired_size = 2

    # Maximum number of worker nodes
    max_size     = 2

    # Minimum number of worker nodes
    min_size     = 2
  }

  
  # Type of Amazon Machine Image (AMI) associated with the EKS Node Group
 
  ami_type = "AL2_x86_64"

  # Type of capacity associated with the EKS Node Group

  capacity_type = "ON_DEMAND"

  # Disk size in GB for worker nodes
  disk_size = 20

  # Force version update if existing pods are unable to be drained due to a pod disruption budget issue
  force_update_version = false

  # Instance type associated with the EKS Node Group
  instance_types = ["t3.small"]

  labels = {
    role = "${var.eks_cluster_name}-Node-group-role",
    name = "${var.eks_cluster_name}-node_group"
  }

  # Kubernetes version
  version = "1.27"

}

# Create IAM role for EKS Node Group
resource "aws_iam_role" "node_group_role" {
  name = "${var.project_name}-node_group-role"

  # The policy that grants an entity permission to assume the role.
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      }, 
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}


resource "aws_iam_role_policy_attachment" "AmazonEKSWorkerNodePolicy" {
  
     # https://github.com/SummitRoute/aws_managed_policies/blob/master/policies/AmazonEKSWorkerNodePolicy

  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.node_group_role.name
}

resource "aws_iam_role_policy_attachment" "AmazonEKS_CNI_Policy" {

  # https://github.com/SummitRoute/aws_managed_policies/blob/master/policies/AmazonEKS_CNI_Policy

  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.node_group_role.name
}

resource "aws_iam_role_policy_attachment" "AmazonEC2ContainerRegistryReadOnly" {

  # https://github.com/SummitRoute/aws_managed_policies/blob/master/policies/AmazonEC2ContainerRegistryReadOnly

  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.node_group_role.name
}