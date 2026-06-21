# AWS Scalable Web Application

## Table of Content

| Document | Description |
|----------|-------------|
| Project Overview | Project goals |
| Architecture | High-level architecture |
| Network Design | VPC and subnet design |
| Security Design | IAM and networking security |
| Compute Design | EC2 and Auto Scaling |
| Database Design | RDS |
| Monitoring | CloudWatch |
| Deployment Guide | Deployment steps |
| Lessons Learned | Challenges and improvements |

## Project Overview

This project demonstrates how to deploy a highly available and scalable web application on AWS using production best practices.

## Architecture

Diagram and explanation

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

## Network Design

The application is deployed inside a dedicated Amazon VPC (`10.0.0.0/16`) spanning two Availability Zones (`eu-north-1a` and `eu-north-1b`). The network is segmented into public, private application, and private database subnets to follow AWS security and high availability best practices.

