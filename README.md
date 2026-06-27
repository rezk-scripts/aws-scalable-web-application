# Production-Oriented Scalable Web Application on AWS

> A production-oriented AWS infrastructure deployed using Terraform, demonstrating secure, scalable, and highly available cloud architecture through a modular Infrastructure as Code approach.

![Architecture Overview](documentation/screenshots/architecture-overview.png)
---

## Solution Overview

This repository contains the infrastructure code and supporting documentation for a production-oriented web application environment deployed on AWS using Terraform.

The infrastructure is organized into logical layers that separate networking, security, compute, database, edge, and monitoring responsibilities into reusable Terraform modules. This layered approach improves maintainability, encourages reuse, and clearly defines the responsibility of each component.

In addition to the Terraform implementation, the repository includes detailed architectural documentation explaining the design decisions, infrastructure layers, and request lifecycle.

---

## Value Proposition

Modern web applications require infrastructure that is resilient, scalable, secure, and easy to operate. This project demonstrates how these requirements can be addressed using managed AWS services and Infrastructure as Code.

The architecture distributes workloads across multiple Availability Zones, isolates application resources within private networks, automatically scales compute capacity in response to demand, and provides centralized monitoring and operational visibility. The result is a production-oriented foundation that is both maintainable and extensible.

---

## Objectives

- Design a highly available AWS architecture.
- Implement reusable Infrastructure as Code using Terraform.
- Apply secure networking and least-privilege access principles.
- Build scalable compute infrastructure.
- Deploy a resilient relational database.
- Improve application delivery through edge services.
- Implement centralized monitoring and alerting.
- Document the architecture and implementation.

---

## Documentation

| Document | Description |
|----------|-------------|
| [Solution Architecture](docs/architecture/README.md) | Overall architecture, request flow, design decisions, and module relationships |
| [Networking Layer](terraform/modules/networking/README.md) | VPC, subnets, routing, NAT Gateway, and connectivity |
| [Security Layer](terraform/modules/security/README.md) | Security Groups, IAM, Session Manager, and security controls |
| [Compute Layer](terraform/modules/compute/README.md) | Application Load Balancer, Launch Template, Auto Scaling, and EC2 |
| [Database Layer](terraform/modules/database/README.md) | Amazon RDS deployment and database architecture |
| [Edge Layer](terraform/modules/edge/README.md) | Route 53, CloudFront, and AWS WAF |
| [Monitoring Layer](terraform/modules/monitoring/README.md) | CloudWatch dashboards, alarms, and SNS notifications |

---

## Repository Structure

```text
terraform/
├── environments/
└── modules/
    ├── networking/
    ├── security/
    ├── compute/
    ├── database/
    ├── edge/
    └── monitoring/

docs/
└── architecture/
```

---


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