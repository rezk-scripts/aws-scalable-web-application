# ADR-001: VPC and Subnet Design

## Status

Accepted

## Context

The project requires a highly available architecture across two Availability Zones with isolated application and database tiers.

## Decision

Use a single VPC (`10.0.0.0/16`) with six subnets:

- 2 Public Subnets
- 2 Private Application Subnets
- 2 Private Database Subnets

## Consequences

### Positive

- Supports high availability
- Separates public, application, and database traffic
- Aligns with AWS networking best practices

### Negative

- More resources to manage than a flat network