# Edge Layer

> Provides the public entry point to the application by delivering DNS resolution, content delivery, request routing, and application-layer protection.

## Architecture

           Users
              │
              ▼
        Route 53
              │
              ▼
         CloudFront
          /       \
     Static      Dynamic
       │            │
       ▼            ▼
      S3           WAF
                    │
                    ▼
                   ALB


![Edge Layer](../../../diagrams/edge-architecture.png)

> **Figure 1.** Edge layer illustrating DNS resolution, content delivery, request filtering, and request forwarding to the application.

### Overview

The Edge layer serves as the public entry point to the application.

Client requests are resolved through Amazon Route 53 and directed to an Amazon CloudFront distribution. CloudFront serves cached static content from edge locations when available and forwards dynamic requests to the Application Load Balancer. 

Implementing AWS WAF at the edge via Amazon CloudFront, rather than ALB, optimizes costs by blocking malicious traffic before it reaches your backend, preventing expensive computing and data transfer charges. However, 

## Components

| Component | Purpose |
|------------|----------|
| Amazon Route 53 | Resolves the application domain and directs clients to CloudFront. |
| Amazon CloudFront | Delivers cached content from edge locations and forwards dynamic requests to the origin. |
| AWS WAF | Inspects HTTP requests and blocks malicious traffic based on managed rule sets. |
| Application Load Balancer | Serves as the origin for dynamic application requests. |


## Content Delivery Strategy

Amazon CloudFront improves application performance by serving cacheable content from AWS edge locations.

Static assets such as images, CSS, JavaScript, and other static resources are delivered directly from the cache whenever possible, reducing latency and minimizing requests to the origin infrastructure.

Requests that cannot be served from cache are forwarded to the Application Load Balancer.


## Design Decisions

### DNS Strategy

Amazon Route 53 provides authoritative DNS services for the application domain.

Alias records are used to direct traffic to the CloudFront distribution without requiring static IP addresses.

This approach supports high availability while simplifying endpoint management.

### Edge Caching

Static assets are cached at CloudFront edge locations to reduce origin requests and improve application responsiveness.

### Static and Dynamic Separation

Static content is served directly from Amazon S3 while dynamic requests continue to the application layer, reducing backend workload and improving cache utilization.

---

## Module Interface

### Key Inputs

N/A

### Key Outputs

N/A

---

## Related Documentation

| Document | Description |
|----------|-------------|
| [`../../../documentation/architecture/README.md`](../../../documentation/architecture/README.md) | Overall solution architecture and request lifecycle. |
| [`../compute/README.md`](../compute/README.md) | Application infrastructure serving as the CloudFront origin. |
| [`../security/README.md`](../security/README.md) | Security controls protecting the application. |
| [`../networking/README.md`](../network/README.md) | Network infrastructure supporting the edge services. |
