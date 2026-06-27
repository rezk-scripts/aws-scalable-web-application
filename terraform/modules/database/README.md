# Database Layer

## Purpose

The Database layer provides persistent storage for the application while ensuring high availability and data durability. It is responsible for provisioning and configuring Amazon RDS in a Multi-Availability Zone deployment, allowing the application to remain resilient against infrastructure failures without requiring application-level failover logic.

By isolating the database within dedicated private subnets, the solution minimizes exposure to external networks and enforces secure communication exclusively through the application layer.

![Database Diagram](../../documentation/screenshots/database-architecture.png)

## Architecture

The database is deployed as an Amazon RDS Multi-AZ instance spanning two Availability Zones. Applications connect through a single managed database endpoint while Amazon RDS automatically replicates data to a standby instance.

In the event of an Availability Zone failure, Amazon RDS performs automatic failover, allowing the application to reconnect through the same endpoint with minimal disruption.

## Resources

| Resource                       | Purpose                                                              |
| ------------------------------ | -------------------------------------------------------------------- |
| Amazon RDS                     | Managed relational database service hosting application data.        |
| DB Subnet Group                | Restricts database deployment to dedicated private database subnets. |
| Parameter Group                | Defines database engine configuration.                               |
| Option Group *(if applicable)* | Enables optional database features.                                  |

## Key Inputs

| Variable                     | Description                                          |
| ---------------------------- | ---------------------------------------------------- |
| `db_engine`                  | Database engine (MySQL or PostgreSQL).               |
| `db_instance_class`          | Compute capacity allocated to the database instance. |
| `allocated_storage`          | Initial storage allocation.                          |
| `db_subnet_ids`              | Private database subnets used by Amazon RDS.         |
| `database_security_group_id` | Security Group allowing application connectivity.    |

## Key Outputs

| Output                 | Description                      |
| ---------------------- | -------------------------------- |
| `db_endpoint`          | Application connection endpoint. |
| `db_identifier`        | Database instance identifier.    |
| `db_subnet_group_name` | Database subnet group.           |


## Design Decisions

### Managed Database Service

Amazon RDS is used instead of self-managed databases on EC2 to reduce operational overhead while providing automated backups, patching, and failover capabilities.

### Multi-Availability Zone Deployment

Database replication across multiple Availability Zones improves resilience by providing automatic failover in the event of infrastructure failure.

### Private Database Network

The database resides exclusively within dedicated private database subnets and accepts traffic only from the application Security Group.

### Application Transparency

Applications connect using the managed database endpoint, allowing Amazon RDS to perform failover without requiring configuration changes within the application.