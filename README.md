# AWS Scalable Web Application

## Overview

This project demonstrates how to deploy a highly available and scalable web application on AWS using production best practices.

## Architecture

Coming Soon

## Services Used

- VPC
- EC2
- Auto Scaling Group
- Application Load Balancer
- CloudFront
- Route 53
- RDS
- WAF
- Systems Manager
- CloudWatch
- SNS

## Documentation

| Document | Description |
|----------|-------------|
| Project Overview | Project goals |
| Requirements | Functional requirements |
| Architecture | High-level architecture |
| Network Design | VPC and subnet design |
| Security Design | IAM and networking security |
| Compute Design | EC2 and Auto Scaling |
| Database Design | RDS |
| Monitoring | CloudWatch |
| Deployment Guide | Deployment steps |
| Testing | Validation |
| Cost Estimation | Monthly estimate |
| Lessons Learned | Challenges and improvements |


## Network Design

The application is deployed inside a dedicated Amazon VPC (`10.0.0.0/16`) spanning two Availability Zones (`eu-north-1a` and `eu-north-1b`). The network is segmented into public, private application, and private database subnets to follow AWS security and high availability best practices.