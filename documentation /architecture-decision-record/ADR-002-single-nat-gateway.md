# ADR-002: Single NAT Gateway Deployment

## Context

The project requires outbound internet access for resources in private subnets. A production deployment would typically place one NAT Gateway in each Availability Zone.

## Decision

Deploy a single NAT Gateway in one public subnet.

## Rationale

- Reduces cost
- Satisfies the project requirements
- Simplify architecture for deployment while demonstrating the networking pattern

## Consequences

### Positive

- Simpler deployment with lower infrastructure cost due in insufficient credit

### Negative

- Single point of failure for outbound internet access
- Cross-Availability Zone traffic for private resources in the second Availability Zone