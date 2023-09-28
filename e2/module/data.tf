data "aws_ssm_parameter" "amazon-linux-ami" {
  name = local.amazon_linux_ami_ssm_parameter_key
}
