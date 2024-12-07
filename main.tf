locals {
 name_prefix = "choonyee"
}







#example
resource "aws_iam_role" "1" {
 name = "${local.name_prefix}-dynamodb-read-role"

 assume_role_policy = jsonencode({
   Version = "2012-10-17"
   Statement = [
     {
       Action = "sts:AssumeRole"
       Effect = "Allow"
       Sid    = ""
       Principal = {
         Service = "ec2.amazonaws.com"
       }
     },
   ]
 })
}

data "aws_iam_policy_document" "1" {
 statement {
   effect    = "Allow"
   actions   = ["ec2:Describe*"]
   resources = ["*"]
 }
 statement {
   effect    = "Allow"
   actions   = ["s3:ListBucket"]
   resources = ["*"]
 }
}

resource "aws_iam_policy" "1" {
 name = "${local.name_prefix}-policy"

 ## Option 1: Attach data block policy document
 policy = data.aws_iam_policy_document.policy_example.json

}

resource "aws_iam_role_policy_attachment" "attach_example" {
 role       = aws_iam_role.role_example.name
 policy_arn = aws_iam_policy.policy_example.arn
}

resource "aws_iam_instance_profile" "profile_example" {
 name = "${local.name_prefix}-profile-example"
 role = aws_iam_role.role_example.name
}
