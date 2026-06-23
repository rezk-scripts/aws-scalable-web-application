# ADR-003: Network ACL Strategy

## Context

The project requires the implementation of custom Network ACLs (NACLs) as part of the networking layer.

AWS provides a default Network ACL that allows all inbound and outbound traffic. While custom NACLs can be used to implement subnet-level filtering, the primary security mechanism for this architecture is AWS Security Groups, which provide stateful traffic filtering at the resource level.

## Decision

Implement two custom Network ACLs:

- One associated with the public subnets.
- One associated with the private application and database subnets.

Both Network ACLs allow all inbound and outbound traffic.

Traffic restrictions will instead be enforced using Security Groups attached to individual AWS resources.

---

## Alternatives Considered

### Option 1 – Restrictive Network ACLs

Configure explicit allow and deny rules for HTTP, HTTPS, database traffic, and ephemeral ports.

**Pros**

- Additional subnet-level protection.
- Defense in depth.

**Cons**

- Complex to maintain.
- Stateless behavior requires return traffic rules.
- Easy to misconfigure.
- Duplicates controls already implemented by Security Groups.

---

### Option 2 – Default Network ACL

Use the AWS-managed default Network ACL.

**Pros**

- No maintenance required.
- Fully functional.

**Cons**

- Does not demonstrate understanding of Network ACL configuration.
- Does not satisfy the project requirement for custom NACLs.

---

### ✔ Selected Option – Custom Permissive Network ACLs

Create custom NACLs that allow all traffic while relying on Security Groups for access control.

This approach satisfies the project requirements while following AWS guidance that Security Groups should be the primary mechanism for instance-level traffic filtering.

---

## Consequences

### Positive

- Demonstrates knowledge of custom Network ACLs.
- Keeps the networking layer simple.
- Avoids accidental connectivity issues caused by incorrect stateless rules.
- Allows Security Groups to provide fine-grained access control.

### Negative

- Network ACLs do not provide meaningful traffic filtering.
- Additional security relies entirely on Security Groups.
- Less defense in depth than a restrictive NACL implementation.

---

## References

1. AWS VPC User Guide – Network ACLs

2. AWS Well-Architected Framework – Security Pillar