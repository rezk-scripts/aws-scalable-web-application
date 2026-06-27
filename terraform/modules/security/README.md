# Security Layer

## Purpose

> Implements the security controls that govern network communication, identity, and administrative access across the infrastructure, following the principle of least privilege and defense in depth.

## Architecture

![Security Diagram](../../../documentation/diagrams/security-architecture.png)

> **Figure 1.** Security layer illustrating trust boundaries, network access controls, IAM roles, and secure administrative access.

### Overview

The security layer protects the infrastructure by enforcing network isolation, identity-based permissions, and secure administration.

Rather than exposing management interfaces such as SSH, the solution uses AWS Systems Manager Session Manager to provide authenticated, auditable access to EC2 instances. Network communication between infrastructure components is restricted through dedicated Security Groups that implement least-privilege access policies.

## Components

| Component | Purpose |
|------------|----------|
| Security Groups | Restrict traffic between infrastructure layers using stateful firewall rules. |
| IAM Roles | Grant AWS service permissions without embedding credentials. |
| IAM Instance Profile | Associates IAM permissions with EC2 instances. |
| AWS Systems Manager | Enables secure instance administration without SSH or bastion hosts. |
| Session Manager | Provides encrypted shell access through Systems Manager. |

## Security Model

The solution follows a layered security model that applies the principle of least privilege at both the network and identity levels.

Each infrastructure tier communicates only with the resources required to perform its function. Administrative access is separated from application traffic and is provided through AWS Systems Manager rather than traditional SSH access.

## Network Access Matrix

| Source | Destination | Protocol / Port | Purpose |
|----------|-------------|-----------------|----------|
| Internet | Application Load Balancer | HTTP (80) / HTTPS (443) | Client requests |
| Application Load Balancer | EC2 Instances | HTTP (80) | Forward application traffic |
| EC2 Instances | Amazon RDS | MySQL (3306) / PostgreSQL (5432) | Database connectivity |
| EC2 Instances | AWS Systems Manager | HTTPS (443) | Instance management |

## Identity & Access Management

IAM roles are assigned to AWS resources instead of embedding long-term credentials.

The EC2 instance profile grants the minimum permissions required for:

- AWS Systems Manager Session Manager
- Amazon CloudWatch (if applicable)
- Additional AWS service integrations as required

This approach simplifies credential management while reducing the risk associated with static access keys.



## Design Decisions

### Layered Network Security

Dedicated Security Groups are assigned to each infrastructure tier. This approach limits communication paths and enforces least-privilege access between components.

### Bastion-Free Administration

EC2 instances are managed using AWS Systems Manager Session Manager rather than SSH. This eliminates the need for bastion hosts and avoids exposing management ports to the public internet.

### Least-Privilege IAM

IAM roles grant only the permissions required for each service to perform its intended function, reducing unnecessary privilege escalation risks.

### Database Isolation

The database accepts traffic exclusively from the application Security Group, preventing direct client or internet access.

---

## Module Interface

### Key Inputs

| Variable        | Description                               |
| --------------- | ----------------------------------------- |
| `vpc_id`        | VPC where security resources are created. |
| `app_port`      | Port exposed by the application.          |
| `database_port` | Database listener port.                   |

### Key Outputs

| Output                       | Description                                               |
| ---------------------------- | --------------------------------------------------------- |
| `alb_security_group_id`      | Security Group assigned to the Application Load Balancer. |
| `ec2_security_group_id`      | Security Group assigned to EC2 instances.                 |
| `database_security_group_id` | Security Group assigned to the RDS instance.              |
| `instance_profile_name`      | IAM Instance Profile attached to EC2 instances.           |

---

## Related Documentation

| Document | Description |
|----------|-------------|
| [`../../../docs/architecture/README.md`](../../../documentation/architecture/README.md) | Overall solution architecture and request lifecycle. |
| [`../networking/README.md`](../networking/README.md) | Networking infrastructure secured by this layer. |
| [`../compute/README.md`](../compute/README.md) | Compute resources protected by these security controls. |
| [`../database/README.md`](../database/README.md) | Database resources secured by dedicated security groups. |
