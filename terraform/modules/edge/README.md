# Edge Layer

## Purpose

The Edge layer provides the public entry point into the application. It is responsible for DNS resolution, global content delivery, request filtering, and efficient delivery of both static and dynamic content before requests enter the application environment.

This layer improves application performance, strengthens security, and reduces unnecessary load on backend resources.

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


User requests first reach Amazon Route 53, which resolves the application domain and directs traffic to Amazon CloudFront. Static assets are served directly from Amazon S3 whenever possible, while dynamic requests are forwarded to the Application Load Balancer after inspection by AWS WAF.

This architecture reduces latency, improves cache efficiency, and protects the application against common web-based attacks before requests reach the application infrastructure.

## Resources

| Resource   | Purpose                                                  |
| ---------- | -------------------------------------------------------- |
| Route 53   | DNS resolution and routing.                              |
| CloudFront | Global content delivery and caching.                     |
| AWS WAF    | Application-layer protection against malicious requests. |
| Amazon S3  | Storage for static application assets.                   |


## Key Inputs



## Key Outputs



## Design Decisions

### Edge Caching

Static assets are cached at CloudFront edge locations to reduce origin requests and improve application responsiveness.

### Layer 7 Protection

AWS WAF filters incoming requests before they reach the application infrastructure, helping mitigate common web exploits.

### Static and Dynamic Separation

Static content is served directly from Amazon S3 while dynamic requests continue to the application layer, reducing backend workload and improving cache utilization.

## Related Documentation

