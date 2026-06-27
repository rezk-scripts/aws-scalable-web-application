# Compute Layer

## Purpose

> Hosts the application workload and provides high availability, elastic scalability, and load balancing through a resilient compute architecture.

## Architecture

![Compute Layer Diagram](../../documentation/diagrams/compute-architecture.png)

### Overview

The compute layer hosts the application and ensures requests are processed efficiently while maintaining high availability. Client requests are distributed by an Application Load Balancer across EC2 instances deployed in private application subnets.

Instance lifecycle management is delegated to an Auto Scaling Group, which provisions instances from a Launch Template and automatically adjusts capacity based on application demand.

## Components

| Resource                  | Purpose                                                                   |
| ------------------------- | ------------------------------------------------------------------------- |
| Application Load Balancer | Distributes client traffic across healthy application instances.          |
| Target Group              | Performs health checks and routes traffic to EC2 instances.               |
| Launch Template           | Defines the configuration used when creating EC2 instances.               |
| Auto Scaling Group        | Maintains desired capacity and scales the application tier automatically. |
| EC2 Instances             | Execute the application workload.                                         |

## Design Decisions

### High Availability Strategy

Application instances are distributed across two Availability Zones to reduce the impact of infrastructure failures.The Application Load Balancer continuously monitors target health and routes requests only to healthy instances. If an instance becomes unhealthy, the Auto Scaling Group automatically replaces it using the Launch Template.This combination enables the application tier to remain available during instance failures and routine scaling events.

### Scaling Strategy

The Auto Scaling Group maintains the desired application capacity while adapting to changing workloads.

The current implementation uses a Target Tracking Scaling Policy based on Amazon CloudWatch metrics.

| Configuration | Value |
|---------------|-------|
| Scaling Policy | Target Tracking |
| Metric | CPU Utilization |
| Desired Capacity | 2 |
| Minimum Capacity | 2 |
| Maximum Capacity | 4 |

### Health Monitoring

Application availability is continuously evaluated through Target Group health checks.

| Configuration | Value |
|---------------|-------|
| Protocol | HTTP |
| Health Check Path | `/health` *(or `/` if applicable)* |
| Target Type | Instance |

Only healthy instances receive production traffic from the Application Load Balancer.

### Stateless Compute

Application instances are treated as disposable resources. All persistent data is stored within Amazon RDS, allowing instances to be replaced without affecting application state.

### Elastic Scaling

An Auto Scaling Group automatically adjusts compute capacity based on application demand, improving availability during peak traffic while reducing unnecessary resource consumption during quieter periods.

### Centralized Load Balancing

The Application Load Balancer distributes requests only to healthy instances, improving resilience and enabling seamless scaling events.

### Reusable Instance Configuration

A Launch Template provides a consistent definition for EC2 instances, ensuring all Auto Scaling events create identical application servers.

---

## Module interface

### Key Inputs

| Variable                 | Description                               |
| ------------------------ | ----------------------------------------- |
| `private_app_subnet_ids` | Subnets where EC2 instances are deployed. |
| `launch_template_name`   | Name assigned to the Launch Template.     |
| `desired_capacity`       | Initial number of application instances.  |
| `min_size`               | Minimum Auto Scaling Group capacity.      |
| `max_size`               | Maximum Auto Scaling Group capacity.      |

### Key Outputs

| Output                    | Description                                |
| ------------------------- | ------------------------------------------ |
| `alb_dns_name`            | DNS name of the Application Load Balancer. |
| `alb_arn`                 | ARN of the Application Load Balancer.      |
| `target_group_arn`        | ARN of the Target Group.                   |
| `launch_template_id`      | Launch Template identifier.                |
| `auto_scaling_group_name` | Auto Scaling Group name.                   |

---

## Related Documentation

| Document | Description |
|----------|-------------|
| [`../../../../docs/architecture/README.md`](../../../../documentation/architecture/README.md) | Overall solution architecture and request lifecycle. |
| [`../networking/README.md`](../network/README.md) | Networking layer supporting the compute resources. |
| [`../security/README.md`](../security/README.md) | Security controls applied to the compute layer. |
| [`../database/README.md`](../database/README.md) | Database services consumed by the application. |
