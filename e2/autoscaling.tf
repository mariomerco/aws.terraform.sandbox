resource "aws_launch_template" "app" {
  name_prefix   = var.project_name
  image_id      = data.aws_ssm_parameter.amazon-linux-ami.value
  instance_type = var.instance_type

  user_data = filebase64("scripts/init.sh")

  vpc_security_group_ids = [aws_security_group.instance_allow_http.id]

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "${var.project_name}-server"
    }
  }
}

resource "aws_autoscaling_group" "app" {
  name             = "${var.project_name}-asg"
  desired_capacity = 1
  max_size         = 1
  min_size         = 1

  vpc_zone_identifier = [
    aws_subnet.private_subnets[0].id,
    aws_subnet.private_subnets[1].id,
    aws_subnet.private_subnets[2].id
  ]

  target_group_arns = [aws_lb_target_group.app.arn]

  launch_template {
    id      = aws_launch_template.app.id
    version = "$Latest"
  }
}


resource "aws_security_group" "instance_allow_http" {
  name        = "instance_allow_http"
  description = "Allow http inbound traffic from the load balancer"
  vpc_id      = aws_vpc.main.id

  ingress {
    description     = "http from the Load Balancer"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.lb_allow_http.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
