
## Цель

Проверить возможность мониторинга состояния Managed Kubernetes в Yandex Cloud и показать, что после внедрения средств наблюдаемости доступны метрики узлов, pod и контейнеров.

## Проверенные метрики

| Метрика | Назначение |
|---|---|
| `master.cpu.utilization_percent` | утилизация CPU control plane |
| `node.memory.used_bytes` | использование памяти узла Kubernetes |
| `pod.memory.used_bytes` | использование памяти pod |
| `container.restart_count` | количество перезапусков контейнера |

## Результат

В Yandex Monitoring были построены графики по метрикам Managed Kubernetes. Также был создан демонстрационный алерт для контроля использования памяти узла. Это подтверждает, что состояние Kubernetes-инфраструктуры может контролироваться средствами Yandex Cloud без развертывания отдельной системы мониторинга.

## Evidence

- `docs/screenshots/monitoring-container-restart-count.png`
- `docs/screenshots/monitoring-k8s-alert-email.png`
- `docs/screenshots/monitoring-k8s-alert.png`
- `docs/screenshots/monitoring-master-cpu.png`
- `docs/screenshots/monitoring-node-memory.png`
- `docs/screenshots/monitoring-pod-memory.png`