output "ubuntu_ami" {
  value = nonsensitive(data.aws_ssm_parameter.amazon-linux-ami.value)
}

output "dns" {
  value = aws_lb.app.dns_name
}
