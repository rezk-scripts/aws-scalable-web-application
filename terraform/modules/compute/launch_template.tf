resource "aws_launch_template" "app" {

  name_prefix = "${local.name_prefix}-lt-"

  image_id = data.aws_ami.amazon_linux.id

  instance_type = var.instance_type

  vpc_security_group_ids = [
    var.app_security_group_id
  ]

  user_data = base64encode(
    file("${path.module}/user_data.sh")
  )

  iam_instance_profile {
    name = var.instance_profile_name
  }

    block_device_mappings {

    device_name = "/dev/xvda"

    ebs {

      volume_size = var.root_volume_size

      volume_type = "gp3"

      encrypted = true

      delete_on_termination = true

    }

  }

    metadata_options {

    http_endpoint = "enabled"

    http_tokens = "required"

  }

    tag_specifications {

    resource_type = "instance"

    tags = merge(
      local.common_tags,
      {
        Name = "${local.name_prefix}-app"
      }
    )

  }

}