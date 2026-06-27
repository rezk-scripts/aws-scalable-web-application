# Security Layer

## Purpose

The Security layer defines the controls that protect the infrastructure and regulate communication between components. It applies the principle of least privilege by restricting network access, enabling secure administrative connectivity, and ensuring that each resource communicates only with the services it requires.

Rather than relying on publicly accessible management interfaces, the solution uses AWS Systems Manager Session Manager to provide secure, audited access to EC2 instances without exposing SSH to the internet.

![Security Diagram](../../documentation/screenshots/security-architecture.png)

## Architecture

Security controls are implemented using a layered approach. Network access is controlled through dedicated Security Groups, while administrative access is provided through AWS Systems Manager Session Manager. Database resources are isolated behind application-level security controls, ensuring they cannot be accessed directly from the internet.

## Resources

| Resource            | Purpose                                                                   |
| ------------------- | ------------------------------------------------------------------------- |
| Security Groups     | Restrict inbound and outbound traffic between infrastructure layers.      |
| IAM Roles           | Grant AWS service permissions following the principle of least privilege. |
| Instance Profile    | Allows EC2 instances to interact with AWS services securely.              |
| AWS Systems Manager | Provides secure management access to EC2 instances.                       |

## Key Inputs

| Variable        | Description                               |
| --------------- | ----------------------------------------- |
| `vpc_id`        | VPC where security resources are created. |
| `app_port`      | Port exposed by the application.          |
| `database_port` | Database listener port.                   |

## Key Outputs

| Output                       | Description                                               |
| ---------------------------- | --------------------------------------------------------- |
| `alb_security_group_id`      | Security Group assigned to the Application Load Balancer. |
| `ec2_security_group_id`      | Security Group assigned to EC2 instances.                 |
| `database_security_group_id` | Security Group assigned to the RDS instance.              |
| `instance_profile_name`      | IAM Instance Profile attached to EC2 instances.           |

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

## Related Documentation

| Document | Description |
|----------|-------------|
| [`../../../docs/architecture/README.md`](../../../docs/architecture/README.md) | Overall solution architecture and request lifecycle. |
| [`../networking/README.md`](../networking/README.md) | Networking infrastructure secured by this layer. |
| [`../compute/README.md`](../compute/README.md) | Compute resources protected by these security controls. |
| [`../database/README.md`](../database/README.md) | Database resources secured by dedicated security groups. |