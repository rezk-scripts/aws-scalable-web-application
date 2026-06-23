resource "aws_autoscaling_group" "app" {

  name = "${local.name_prefix}-asg"

  min_size         = var.min_size
  desired_capacity = var.desired_capacity
  max_size         = var.max_size

  vpc_zone_identifier = var.private_app_subnet_ids

  health_check_type = "EC2"

  health_check_grace_period = 300

  launch_template {

    id      = aws_launch_template.app.id
    version = "$Latest"

  }

  tag {

    key = "Name"

    value = "${local.name_prefix}-app"

    propagate_at_launch = true

  }

}

resource "aws_autoscaling_policy" "cpu_target_tracking" {

  name = "${local.name_prefix}-cpu-target"

  autoscaling_group_name = aws_autoscaling_group.app.name

  policy_type = "TargetTrackingScaling"

  target_tracking_configuration {

    predefined_metric_specification {

      predefined_metric_type = "ASGAverageCPUUtilization"

    }

    target_value = 60

  }

}