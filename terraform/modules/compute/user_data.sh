#!/bin/bash

dnf update -y

dnf install -y httpd

systemctl enable httpd

systemctl start httpd

TOKEN=$(curl -X PUT \
"http://169.254.169.254/latest/api/token" \
-H "X-aws-ec2-metadata-token-ttl-seconds: 21600")

INSTANCE_ID=$(curl \
-H "X-aws-ec2-metadata-token: $TOKEN" \
http://169.254.169.254/latest/meta-data/instance-id)

AZ=$(curl \
-H "X-aws-ec2-metadata-token: $TOKEN" \
http://169.254.169.254/latest/meta-data/placement/availability-zone)

cat <<EOF >/var/www/html/index.html
<!DOCTYPE html>
<html>
<head>
<title>Scalable Web Application</title>
</head>

<body>

<h1>Scalable Web Application</h1>

<p>Instance ID: ${INSTANCE_ID}</p>

<p>Availability Zone: ${AZ}</p>

</body>

</html>

EOF