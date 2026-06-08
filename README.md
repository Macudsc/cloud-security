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
## Итоговые материалы эксперимента

Основные результаты экспериментальной проверки представлены в следующих файлах:

- `docs/final-results.md` — сводная таблица угроз, мер защиты и evidence;
- `docs/risk-assessment.md` — экспертная оценка риска до и после внедрения мер;
- `docs/before-after-results.md` — подробные результаты экспериментов;
- `docs/monitoring-experiment.md` — проверка Monitoring и alerting;
- `docs/observability-experiment.md` — проверка Audit Trails и Cloud Logging;
- `docs/deployment-evidence.md` — подтверждение развертывания стенда;
- `evidence/before/` — артефакты состояния «до»;
- `evidence/after/` — артефакты состояния «после».

Ключевые проверенные меры:

- закрытие публичного доступа к Object Storage;
- включение versioning и проверка восстановления объекта;
- исключение plaintext-секретов из secure-манифестов;
- сканирование контейнерных образов в Container Registry;
- hardening Kubernetes workload;
- настройка RBAC, NetworkPolicy и ServiceAccount;
- настройка readiness/liveness probes и resource limits;
- настройка Audit Trails, Cloud Logging, Monitoring и alerting.
