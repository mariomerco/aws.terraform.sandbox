output "ubuntu_ami" {
  value = nonsensitive(data.aws_ssm_parameter.amazon-linux-ami.value)
}
