# ADR-006: Private Management Access Using AWS Systems Manager

## Context

Application instances are deployed in private subnets without public IP addresses. Administrative access is required for troubleshooting and operational tasks while maintaining a minimal attack surface.

## Decision

AWS Systems Manager Session Manager will be used for administrative access instead of SSH or a bastion host.

To allow Systems Manager traffic to remain within the AWS network, Interface VPC Endpoints will be deployed for:

- ssm
- ssmmessages
- ec2messages

These endpoints are deployed in the private application subnets with Private DNS enabled.

## Rationale

This design removes the need to expose TCP port 22, eliminates SSH key management, and keeps Systems Manager traffic on the AWS backbone. It also reduces dependence on the NAT Gateway for management traffic.

## Consequences

### Positive

- No inbound SSH access required.
- Administrative traffic remains private.
- Improved security posture.
- Aligns with AWS Well-Architected guidance.

### Negative

- Additional Interface VPC Endpoints increase infrastructure cost.
- More AWS resources to manage and monitor.

## Alternatives Considered

### Bastion Host

Rejected due to increased operational overhead, exposure of SSH, and additional infrastructure.

### NAT Gateway Only

Rejected because management traffic would unnecessarily traverse the NAT Gateway and public internet path.

## References

- AWS Systems Manager User Guide
- AWS PrivateLink Documentation
- AWS Well-Architected Framework – Security Pillar