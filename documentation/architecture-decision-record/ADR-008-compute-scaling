# ADR-009: Compute Scaling Strategy

## Context

The application must remain highly available across multiple Availability Zones while automatically adapting to changes in workload. Manual provisioning of EC2 instances does not provide automatic recovery or elastic scaling.

## Decision

The compute layer will use an Amazon EC2 Auto Scaling Group backed by an EC2 Launch Template.

The Auto Scaling Group will:

- Maintain a minimum of two EC2 instances.
- Distribute instances across private application subnets in multiple Availability Zones.
- Automatically replace unhealthy instances.
- Scale based on a Target Tracking policy using average CPU utilization with a target of 60%.

## Rationale

Using an Auto Scaling Group provides self-healing, supports high availability, and enables elastic scaling without manual intervention. Target Tracking Scaling is chosen because it automatically adjusts capacity to maintain a desired utilization level and requires less operational tuning than Simple or Step Scaling policies.

## Consequences

### Positive

- High availability across Availability Zones.
- Automatic replacement of failed instances.
- Automatic scaling based on demand.
- Reduced operational overhead.

### Negative

- Additional AWS resources increase infrastructure complexity.
- Scaling events may take several minutes as new instances launch and initialize.

## Alternatives Considered

### Manually Managed EC2 Instances

Rejected because they do not provide automatic recovery or elastic scaling.

### Step Scaling Policies

Rejected for this project because Target Tracking offers simpler management while meeting the application's scaling requirements.

## References

- AWS Auto Scaling User Guide
- AWS Well-Architected Framework – Reliability Pillar
- Terraform AWS Provider Documentation (`aws_autoscaling_group`)