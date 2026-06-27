# Networking Layer

## Purpose

The Networking layer provides the foundational infrastructure upon which all other components of the solution are deployed. It establishes network isolation, controls traffic flow between resources, and enables secure communication between application, database, and external services.

This layer is responsible for defining the Virtual Private Cloud (VPC), subnet layout, routing configuration, and internet connectivity required to support a highly available application architecture.


![Network Diagram](../../documentation/screenshots/network-architecture.png)

## Architecture

The networking architecture spans two Availability Zones to improve fault tolerance and support highly available application deployments. Public subnets host internet-facing resources, while application and database workloads remain isolated within private subnets.

Separate subnet tiers and route tables enforce traffic boundaries and ensure that only the resources requiring internet connectivity are publicly accessible.

## Resources

| Resource | Purpose |
|----------|---------|
| VPC | Provides network isolation for all infrastructure resources. |
| Public Subnets | Host internet-facing resources and the NAT Gateway. |
| Private Application Subnets | Host EC2 instances running the application workload. |
| Private Database Subnets | Host the Amazon RDS deployment. |
| Internet Gateway | Enables inbound and outbound internet connectivity for public resources. |
| NAT Gateway | Provides outbound internet access for private application resources. |
| Route Tables | Control network traffic between subnet tiers and external networks. |

## Key Inputs

| Variable | Description |
|----------|-------------|
| `vpc_cidr` | CIDR block assigned to the VPC. |
| `availability_zones` | Availability Zones used by the deployment. |
| `public_subnet_cidrs` | CIDR ranges for public subnets. |
| `private_app_subnet_cidrs` | CIDR ranges for application subnets. |
| `private_db_subnet_cidrs` | CIDR ranges for database subnets. |

## Key Outputs

| Output | Description |
|---------|-------------|
| `vpc_id` | Identifier of the created VPC. |
| `public_subnet_ids` | Public subnet identifiers. |
| `private_app_subnet_ids` | Application subnet identifiers. |
| `private_db_subnet_ids` | Database subnet identifiers. |
| `private_route_table_ids` | Route tables associated with private subnets. |

## Design Decisions

### Multi-Availability Zone Deployment

Resources are distributed across two Availability Zones to improve resilience and reduce the impact of infrastructure failures.

### Public and Private Subnet Separation

Internet-facing resources are deployed within public subnets, while application and database workloads remain isolated in private subnets. This minimizes the attack surface and ensures that only required components are publicly accessible.

### Dedicated Database Subnets

Database resources are deployed within dedicated private database subnets, preventing direct internet access and allowing database-specific routing and security controls.

### Cost Optimization

To reduce infrastructure costs within the learning environment, the implementation uses a single NAT Gateway. In production environments, a NAT Gateway would typically be deployed within each Availability Zone to eliminate cross-AZ dependencies and improve fault tolerance.

---

## Related Documentation

| Document | Description |
|----------|-------------|
| [`../../../docs/architecture/README.md`](../../../docs/architecture/README.md) | Overall solution architecture and request lifecycle. |
| [`../security/README.md`](../security/README.md) | Security controls applied to the networking layer. |
| [`../compute/README.md`](../compute/README.md) | Application resources deployed within the network. |