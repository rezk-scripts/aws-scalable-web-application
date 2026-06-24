# AWS Scalable Web Application

## Table of Content

| Document | Description |
|----------|-------------|
| Project Overview | Project goals |
| Architecture | High-level architecture |
| Network Design | VPC and subnet design |
| Security Design | IAM and networking security |
| Compute Design | EC2 and Auto Scaling |
| Database Design | RDS |
| Monitoring | CloudWatch |
| Deployment Guide | Deployment steps |
| Lessons Learned | Challenges and improvements |

## Project Overview

This project demonstrates how to deploy a highly available and scalable web application on AWS using production best practices.

## Architecture

Diagram and explanation

## Services Used

- VPC
- EC2
- Auto Scaling Group
- Application Load Balancer
- CloudFront
- Route 53
- RDS
- WAF
- Systems Manager
- CloudWatch
- SNS

## Network Design

The application is deployed inside a dedicated Amazon VPC (`10.0.0.0/16`) spanning two Availability Zones (`eu-north-1a` and `eu-north-1b`). The network is segmented into public, private application, and private database subnets to follow AWS security and high availability best practices.

DNS resolution and DNS hostnames are enabled to support internal AWS service communication, Application Load Balancer integration, and Systems Manager connectivity.

### Subnet Strategy

The VPC is divided into six subnets across two Availability Zones:

- **2 Public Subnets** host internet-facing resources such as the Application Load Balancer and NAT Gateway.
- **2 Private Application Subnets** host EC2 instances managed by the Auto Scaling Group.
- **2 Private Database Subnets** isolate the Amazon RDS Multi-AZ deployment from direct internet access.

This layered design follows the principle of network segmentation and supports high availability.

### Internet Gateway

An Internet Gateway is attached to the VPC to provide internet connectivity. Public subnets will use route tables that direct outbound internet traffic (`0.0.0.0/0`) to this gateway. Private subnets will not have direct routes to the Internet Gateway.

### NAT Gateway

The private application and database subnets require outbound internet access for software updates, package installation, and communication with AWS services. A managed NAT Gateway is deployed in a public subnet to provide outbound connectivity while preventing unsolicited inbound traffic to private resources.

For cost optimization, this project uses a single NAT Gateway. In a production environment, a NAT Gateway would typically be deployed in each Availability Zone to eliminate a single point of failure and avoid cross-AZ traffic.


### Route Tables

Two custom route tables are used:

- **Public Route Table:** Routes outbound internet traffic (`0.0.0.0/0`) through the Internet Gateway, enabling internet connectivity for public resources.
- **Private Route Table:** Routes outbound internet traffic through the NAT Gateway, allowing private resources to initiate outbound connections without being directly reachable from the internet.

### Network ACLs

Two custom Network ACLs are configured:

- A public NACL associated with the public subnets.
- A private NACL associated with the application and database subnets.

For this project, the NACLs allow all traffic. Security enforcement is primarily implemented using Security Groups, while the custom NACLs demonstrate subnet-level traffic control and satisfy the project requirements.

## Security Architecture

Security follows a layered defense model based on the principle of least privilege.

### Security Groups

Three dedicated Security Groups isolate each application tier:

- **Application Load Balancer Security Group**
  - Allows HTTP (80) and HTTPS (443) traffic from the Internet.
  - Forwards requests to the application tier.

- **Application Security Group**
  - Allows HTTP traffic only from the ALB Security Group.
  - Prevents direct Internet access to EC2 instances.

- **Database Security Group**
  - Allows PostgreSQL traffic (TCP 5432) only from the Application Security Group.
  - Prevents direct database access from other resources.

Security Groups reference other Security Groups instead of CIDR blocks wherever possible to simplify management and implement identity-based access controls.

## Identity and Administrative Access

Application instances authenticate to AWS using an IAM Role attached through an IAM Instance Profile.

This eliminates the need to store long-lived AWS credentials on EC2 instances.

Administrative access is provided using AWS Systems Manager Session Manager instead of SSH.

Benefits include:

- No Bastion Host required
- No inbound SSH (TCP 22)
- No SSH key management
- Temporary AWS credentials provided automatically through IAM Roles

## Private Access to AWS Services

The project deploys Interface VPC Endpoints for AWS Systems Manager.

Endpoints include:

- ssm
- ssmmessages
- ec2messages

These endpoints allow private EC2 instances to communicate with AWS Systems Manager without traversing the public Internet.

Private DNS is enabled to ensure AWS service endpoints resolve automatically within the VPC.

## Compute Layer

Application servers are deployed using an EC2 Launch Template and an Auto Scaling Group.

### Launch Template

The Launch Template defines:

- Latest Amazon Linux 2023 AMI (retrieved dynamically)
- EC2 instance type
- IAM Instance Profile
- Application Security Group
- Encrypted gp3 root EBS volume
- IMDSv2 enforcement
- User data bootstrap script
- Detailed CloudWatch monitoring

### Auto Scaling Group

The Auto Scaling Group provides:

- High availability across two Availability Zones
- Automatic replacement of unhealthy instances
- Target Tracking Scaling based on average CPU utilization
- Integration with the Application Load Balancer

## Application Load Balancer

An internet-facing Application Load Balancer distributes incoming HTTP traffic across EC2 instances.

Features include:

- Deployment across two public subnets
- Dedicated Target Group
- HTTP health checks
- Automatic distribution of traffic across healthy instances

The Target Group continuously monitors application health and works with the Auto Scaling Group to maintain service availability.