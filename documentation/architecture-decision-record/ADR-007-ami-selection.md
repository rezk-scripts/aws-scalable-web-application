# ADR-007: EC2 AMI Selection Strategy

## Implementation Notes

- Implemented in: `terraform/modules/compute/data.tf`
- Consumed by: `launch_template.tf`

## Context

The Compute module requires an Amazon Machine Image (AMI) for launching EC2 instances. Hardcoding AMI IDs introduces maintenance overhead because AMIs differ between AWS Regions and are updated regularly.

## Decision

The Compute module will use a Terraform data source to dynamically retrieve the latest official Amazon Linux 2023 x86_64 AMI published by AWS.

The AMI is selected using filters for:

- Owner: Amazon
- Architecture: x86_64
- Virtualization Type: HVM
- Root Device: EBS
- Most recent image

## Rationale

Selecting the AMI dynamically ensures that newly deployed infrastructure benefits from the latest AWS-supported operating system releases without requiring manual updates to Terraform code.

Using the official AWS-published image also reduces the risk of deploying untrusted or unsupported images.

## Consequences

### Positive

- No region-specific AMI IDs in source code.
- Reduced maintenance effort.
- Consistent deployments across regions.
- Uses AWS-supported operating system images.

### Negative

- New deployments may use newer AMI versions than previous deployments.
- Infrastructure changes should be tested when significant AMI updates are released.

## Alternatives Considered

### Hardcoded AMI ID

Rejected because it is region-specific and requires manual maintenance.

### Community AMIs

Rejected because image provenance and long-term maintenance cannot be guaranteed.

## References

- AWS EC2 User Guide
- Terraform AWS Provider Documentation (`aws_ami`)
- AWS Well-Architected Framework – Operational Excellence Pillar