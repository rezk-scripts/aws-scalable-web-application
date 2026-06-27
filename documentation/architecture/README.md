# Solution Architecture

## Purpose

This document describes the overall architecture of the solution, the interaction between infrastructure layers, and the key architectural decisions made during the design and implementation of the platform.

The architecture follows AWS Well-Architected Framework principles by emphasizing high availability, security, scalability, operational excellence, and modular Infrastructure as Code (IaC). While the current implementation is intentionally cost-conscious for learning and portfolio purposes, the overall design reflects patterns commonly used in production AWS environments.

## Architectural Principles

The solution is designed around the following architectural principles:

| Principle | Implementation |
|-----------|----------------|
| High Availability | Resources are distributed across two Availability Zones where appropriate. |
| Scalability | The application tier scales automatically using an Auto Scaling Group and Launch Template. |
| Security | Workloads are isolated within private subnets and protected using Security Groups, AWS WAF, and AWS Systems Manager Session Manager. |
| Performance | Amazon CloudFront caches static content at edge locations to reduce latency and origin load. |
| Operational Excellence | Amazon CloudWatch and Amazon SNS provide centralized monitoring and alerting. |
| Modularity | Infrastructure components are organized into reusable Terraform modules following a layered architecture. |

## Architecture Overview

The platform is deployed within a dedicated Amazon Virtual Private Cloud (VPC) spanning two Availability Zones. Public subnets host internet-facing resources, while application servers and database resources remain isolated within private subnets.

Client requests are resolved through Amazon Route 53 and delivered through Amazon CloudFront. Dynamic requests are forwarded to the Application Load Balancer, which distributes traffic across EC2 instances managed by an Auto Scaling Group. Persistent application data is stored in an Amazon RDS Multi-AZ deployment.

Supporting services such as AWS Systems Manager, Amazon CloudWatch, and Amazon SNS provide secure administration, monitoring, and operational visibility.


## High-Level Architecture

The following diagram illustrates the complete solution architecture, highlighting the interaction between infrastructure layers, network boundaries, and the flow of application traffic through the AWS environment.

![Architecture Overview](../../diagrams/high-level-architecture.png)

> **Implementation Note**
>
> This project follows a production-oriented architecture. To reduce costs within the learning environment, the current implementation uses a single NAT Gateway instead of one NAT Gateway per Availability Zone. In a production deployment, a NAT Gateway would typically be provisioned in each Availability Zone to eliminate cross-AZ dependencies and improve fault tolerance.

## Request Lifecycle

The diagram below illustrates the end-to-end request flow from the user to the application backend.

### 1. DNS Resolution

A user accesses the application using its public domain name. Amazon Route 53 resolves the domain and directs requests to the CloudFront distribution.

### 2. Edge Processing

CloudFront serves cached static assets when available. Requests that cannot be served from the cache are forwarded to the origin.

### 3. Application Load Balancing

AWS WAF inspects incoming traffic before it reaches the application, helping mitigate common web exploits and malicious requests. Dynamic requests are forwarded to the Application Load Balancer (ALB), which distributes traffic across healthy EC2 instances deployed in private application subnets spanning multiple Availability Zones.

### 4. Application Processing

The application running on the EC2 instances processes incoming requests. When persistent data is required, the application communicates with the Amazon RDS database through private network connectivity.

### 5. Database Layer

Amazon RDS operates in a Multi-AZ configuration, providing automatic synchronous replication to a standby instance. In the event of an Availability Zone failure, Amazon RDS performs an automatic failover with minimal service interruption.

### 6. Monitoring and Operations

Infrastructure metrics are collected by Amazon CloudWatch. Configured alarms publish notifications to Amazon SNS, while AWS Systems Manager Session Manager provides secure administrative access to the EC2 instances without requiring bastion hosts or SSH access.

## Architectural Layers

To promote separation of concerns and modular infrastructure design, the solution is organized into six logical layers. Each layer is implemented as an independent Terraform module with clearly defined responsibilities and interfaces.

| Layer | Responsibility |
|---------|---------------|
| Networking | Provides the foundational network infrastructure, including the VPC, subnets, routing, and internet connectivity. |
| Security | Defines security controls such as Security Groups, IAM roles, and Systems Manager access. |
| Compute | Hosts the application workload using an Application Load Balancer, Launch Template, Auto Scaling Group, and EC2 instances. |
| Database | Provides persistent storage through Amazon RDS deployed across multiple Availability Zones. |
| Edge | Delivers content through Route 53, CloudFront, AWS WAF, and Amazon S3 for static assets. |
| Monitoring | Collects infrastructure metrics, generates alarms, and delivers operational notifications through CloudWatch and Amazon SNS. |


## Key Design Decisions

### Layered Infrastructure

The infrastructure is organized into logical layers rather than individual AWS services. This approach improves modularity, simplifies maintenance, and enables infrastructure components to evolve independently.

### Private Application Tier

Application instances are deployed exclusively within private subnets. All inbound traffic is routed through the Application Load Balancer, reducing the attack surface and preventing direct public access to compute resources.

### Bastion-Free Administration

Administrative access is provided through AWS Systems Manager Session Manager rather than traditional SSH bastion hosts. This reduces operational complexity while improving security through IAM-based access controls.

### Multi-AZ Deployment

Application and database resources are distributed across multiple Availability Zones to improve resilience and reduce the impact of infrastructure failures.


## Related Documentation

| Document | Description |
|----------|-------------|
| [`../../README.md`](../../README.md) | Project overview and documentation index. |
| [`../../terraform/modules/networking/README.md`](../../terraform/modules/network/README.md) | Networking layer implementation. |
| [`../../terraform/modules/security/README.md`](../../terraform/modules/security/README.md) | Security controls and access management. |
| [`../../terraform/modules/compute/README.md`](../../terraform/modules/compute/README.md) | Compute layer and application hosting. |
| [`../../terraform/modules/database/README.md`](../../terraform/modules/database/README.md) | Database layer implementation. |
| [`../../terraform/modules/edge/README.md`](../../terraform/modules/edge/README.md) | Edge services including Route 53, CloudFront, and AWS WAF. |
| [`../../terraform/modules/monitoring/README.md`](../../terraform/modules/monitoring/README.md) | Monitoring, alerting, and operational visibility. |
