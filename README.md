Схема стенда

```jsx
Yandex Cloud
│
├── VPC
│   ├── Public subnet
│   │   └── attacker-bastion-vm
│   │
│   └── Private subnet
│       ├── Kubernetes worker node
│       └── application workloads
│
├── Managed Kubernetes
│   └── 1 worker node
│
├── Container Registry
│   └── Docker images
│
├── Object Storage
│   ├── reports bucket
│   └── test-data bucket
│
├── Lockbox
│   └── secrets
│
├── Audit Trails
│   └── cloud audit events
│
└── Cloud Logging / Monitoring
    └── logs and basic alerts
```