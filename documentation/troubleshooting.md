# Troubleshooting Guide

This document records issues encountered during the implementation of the Scalable Web Application project, along with their root causes and resolutions.

---

## Issue 001 - Unsupported Attribute (`each.value.id`)

### Error

```text
Error: Unsupported attribute

each.value is object with 3 attributes

This object does not have an attribute named "id".
```

### Cause

The `for_each` loop iterated over `var.subnets`.

The objects in `var.subnets` contain only configuration values:

- cidr
- availability zone
- subnet type

They do **not** contain AWS-generated resource attributes such as an ID.

### Incorrect Implementation

```hcl
subnet_id = each.value.id
```

### Correct Implementation

```hcl
subnet_id = aws_subnet.subnets[each.key].id
```

### Root Cause

Terraform variables describe the desired configuration.

Terraform resources represent infrastructure created in AWS.

Only resources expose runtime attributes such as:

- id
- arn
- dns_name
- availability_zone_id

### Lesson Learned

When an AWS identifier is required, reference the Terraform resource rather than the input variable.