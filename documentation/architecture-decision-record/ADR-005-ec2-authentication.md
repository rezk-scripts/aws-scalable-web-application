# ADR-005: EC2 Authentication

## Context

Amazon EC2 instances require authenticated access to AWS services such as AWS Systems Manager and CloudWatch. A secure authentication mechanism is required that avoids the use of long-lived AWS access keys on compute instances.

---

## Decision

EC2 instances will authenticate to AWS using an IAM Role attached through an IAM Instance Profile.

The IAM Role will initially use the AWS-managed policy `AmazonSSMManagedInstanceCore` to enable Systems Manager functionality. Additional permissions will be granted through customer-managed IAM policies as the application evolves.

---

## Rationale

Using IAM Roles provides temporary credentials that are automatically rotated by AWS. This eliminates the need to store or manage long-term access keys on EC2 instances and follows AWS security best practices.

Separating the trust policy from permission policies also improves maintainability and allows permissions to evolve independently of the authentication mechanism.

---

## Consequences

### Positive

- No long-lived credentials on EC2 instances.
- Automatic credential rotation.
- Native integration with AWS Systems Manager.
- Aligns with the AWS Well-Architected Framework.

### Negative

- Requires an IAM Instance Profile in addition to the IAM Role.
- Permissions must be explicitly managed as application capabilities expand.

---

## Alternatives Considered

### IAM User Access Keys

Rejected because storing long-lived credentials on EC2 instances introduces unnecessary security risk and operational overhead.

### Static Credentials in Application Configuration

Rejected because credentials become difficult to rotate, audit, and protect.

---

## References

- AWS IAM Best Practices
- AWS Well-Architected Framework – Security Pillar
- AWS Systems Manager Documentation