terraform {
  backend "s3" {
    bucket = "10weeksofcloudops-sharad"
    key    = "state/todo/terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "terraform-dynamoDB"
  }
}