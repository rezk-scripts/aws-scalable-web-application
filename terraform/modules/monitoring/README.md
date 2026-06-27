# Monitoring Layer

> Provides operational visibility into the platform by collecting metrics, monitoring resource health, generating alerts, and notifying administrators of operational events.

## Architecture

![Monitoring Layer](../../../docs/architecture/diagrams/monitoring-layer.png)

> **Figure 1.** Monitoring layer illustrating metric collection, alarm evaluation, and notification delivery.

### Overview

The Monitoring layer provides centralized observability across the infrastructure by collecting operational metrics from AWS services, evaluating resource health, and notifying administrators when predefined thresholds are exceeded.

Amazon CloudWatch serves as the primary monitoring platform, while Amazon SNS delivers alert notifications to subscribed recipients.

## Components

| Component | Purpose |
|------------|----------|
| Amazon CloudWatch | Collects metrics, evaluates alarms, and provides dashboards. |
| CloudWatch Alarms | Detect abnormal infrastructure conditions. |
| Amazon SNS | Delivers notifications when alarms are triggered. |
| CloudWatch Dashboard | Provides a centralized operational view of infrastructure health. |

## Design Decisions

### Monitoring Strategy

Operational visibility is achieved by monitoring the health and performance of critical infrastructure components.

The current implementation monitors:

- EC2 instance performance
- Application Load Balancer health
- Auto Scaling Group capacity
- Amazon RDS performance
- Infrastructure availability

Collected metrics are evaluated continuously to detect abnormal operating conditions.

### Metrics

| Service | Key Metrics |
|----------|-------------|
| EC2 | CPU Utilization, Status Check Failed |
| Application Load Balancer | Healthy Host Count, Request Count, Target Response Time |
| Auto Scaling Group | Desired Capacity, InService Instances |
| Amazon RDS | CPU Utilization, Free Storage Space, Database Connections |

### Alerting Strategy

CloudWatch Alarms evaluate infrastructure metrics against predefined thresholds.

When an alarm transitions to the **ALARM** state:

1. CloudWatch detects the threshold breach.
2. The associated alarm changes state.
3. Amazon SNS publishes a notification.
4. Subscribers receive the alert.

This workflow enables timely awareness of infrastructure issues without requiring continuous manual monitoring.

### Operational Dashboards

Amazon CloudWatch Dashboards provide a consolidated view of infrastructure health by presenting operational metrics in a single location.

Dashboards enable administrators to:

- Monitor resource utilization
- Identify performance trends
- Verify application availability
- Observe scaling activity

### Notification Strategy

Amazon SNS distributes operational alerts to subscribed endpoints when CloudWatch Alarms enter the **ALARM** state.

This decouples monitoring from notification delivery, allowing additional subscribers or integrations to be introduced without modifying the monitoring configuration.

## Module Interface

### Key Inputs

- Not built yet -

### Key Outputs

- Not built yet -

## Related Documentation

| Document | Description |
|----------|-------------|
| [`../../../docs/architecture/README.md`](../../../documentation/architecture/README.md) | Overall solution architecture and operational considerations. |
| [`../compute/README.md`](../compute/README.md) | Compute resources monitored by CloudWatch. |
| [`../database/README.md`](../database/README.md) | Database metrics and availability. |
| [`../edge/README.md`](../edge/README.md) | Edge services that contribute to application availability. |

