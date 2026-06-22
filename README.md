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