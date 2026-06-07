Схема стенда

```jsx
Локальная VM / DevOps workstation
        |
        | yc / terraform / kubectl / docker
        v
Yandex Cloud
 ├── IAM / Service Accounts
 ├── VPC
 │   ├── public subnet
 │   └── private subnet
 ├── Managed Kubernetes
 │   ├── app namespace
 │   ├── test app
 │   ├── NetworkPolicy
 │   └── RBAC
 ├── Container Registry
 ├── Object Storage
 │   ├── public-demo-bucket
 │   └── protected-bucket
 ├── Lockbox
 ├── Audit Trails
 ├── Cloud Logging
 └── Monitoring
```