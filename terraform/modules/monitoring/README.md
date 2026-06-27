# Monitoring Layer

## Purpose

The Monitoring layer provides operational visibility into the health and performance of the infrastructure. It enables proactive monitoring through centralized metrics, automated alarms, and notification mechanisms, allowing operational issues to be detected and addressed quickly.

## Architecture

EC2
  │
ALB
  │
RDS
  │
ASG
  ▼
CloudWatch
     │
 Alarms
     ▼
SNS

## Resources

| Resource                          | Purpose                                            |
| --------------------------------- | -------------------------------------------------- |
| CloudWatch Metrics                | Collect infrastructure performance metrics.        |
| CloudWatch Alarms                 | Monitor thresholds and detect abnormal conditions. |
| Amazon SNS                        | Deliver notifications when alarms are triggered.   |
| CloudWatch Dashboard *(optional)* | Centralized operational visibility.                |


## Design Decisions

### Centralized Monitoring

Operational metrics from multiple AWS services are aggregated within Amazon CloudWatch to provide a unified operational view.

### Proactive Alerting

CloudWatch Alarms continuously evaluate infrastructure metrics and publish notifications through Amazon SNS when configured thresholds are exceeded.

### Operational Visibility

Dashboards provide a consolidated view of application health, enabling faster diagnosis and incident response.
