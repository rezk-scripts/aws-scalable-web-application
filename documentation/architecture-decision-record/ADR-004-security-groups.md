# ADR-004: Security Group Strategy

## Context

The Scalable Web Application is designed using a three-tier architecture consisting of an internet-facing Application Load Balancer (ALB), application servers running on Amazon EC2 instances in private subnets, and an Amazon RDS database deployed in private database subnets.

A security model was required to ensure that each tier is accessible only by the components that legitimately require communication with it while minimizing the attack surface.

---

## Decision

Three dedicated Security Groups created, each representing a single application tier.

### ALB Security Group

- Attached to Application Load Balancer

Inbound Rules:

- TCP 80 (HTTP) from `0.0.0.0/0`
- TCP 443 (HTTPS) from `0.0.0.0/0`

Outbound Rules:

- All outbound traffic

Purpose:

- Receive client traffic from the Internet.
- Forward requests to application instances.

---

### Application Security Group

- Attached to EC2 Auto Scaling Group instances

Inbound Rules:

- TCP 80 from the ALB Security Group only

Outbound Rules:

- All outbound traffic

Purpose:

- Prevent direct access from the Internet.
- Accept traffic exclusively from the Application Load Balancer.

---

### Database Security Group

- Attached to Amazon RDS

Inbound Rules:

- PostgreSQL (TCP 5432) from the Application Security Group only

Outbound Rules:

- Default AWS behavior (stateful)

Purpose:

- Restrict database connectivity to application servers only.

---

## Rationale

Security Groups reference other Security Groups instead of CIDR blocks whenever possible.

This approach provides several advantages:

- Access is based on workload identity rather than IP addresses.
- Resources remain protected even if subnet CIDR ranges change.
- Security rules are easier to maintain as the infrastructure scales.
- The design follows the Principle of Least Privilege.

Application servers are deployed in private subnets and therefore cannot be accessed directly from the Internet.

Administrative access will be provided through AWS Systems Manager Session Manager rather than SSH.

---

## Consequences

### Positive

- Clear separation between infrastructure tiers.
- Reduced attack surface.
- No public access to application or database instances.
- Simplified management through Security Group references.
- Compatible with Auto Scaling since new instances automatically inherit the appropriate Security Group.

### Negative

- Additional Security Groups increase the number of managed AWS resources.
- Troubleshooting connectivity may require reviewing multiple Security Groups.
- Future services must be explicitly granted access where required.

---

## Alternatives Considered

### Single Security Group

Rejected because it violates separation of concerns and significantly increases the attack surface.

---

### CIDR-Based Rules

Rejected because access should be granted to workloads rather than network ranges whenever possible.

---

### Bastion Host with SSH

Rejected.

AWS Systems Manager Session Manager provides secure administrative access without exposing TCP port 22 or managing SSH keys.

---

## References

- AWS Well-Architected Framework – Security Pillar
- AWS Security Group Documentation
- AWS Systems Manager Session Manager Best Practices