# Итоговые результаты экспериментальной проверки

## Сводная таблица «угроза → до → после → результат»

| № | Угроза | Состояние «до» | Реализованные меры «после» | Evidence | Результат |
|---|---|---|---|---|---|
| 1 | Компрометация учётных записей и избыточные права доступа | Использование широких прав и отсутствие отдельного разграничения для компонентов стенда | Созданы отдельные service account, применены ограниченные роли, для Kubernetes workload отключен automount service account token | `audit-trails-iam-bindings-after.txt`, `k8s-secure-serviceaccount-after.txt`, `final-k8s-secure-deployment-summary-after.json` | Снижена вероятность использования избыточных прав и токенов внутри workload |
| 2 | Ошибки конфигурации облачных ресурсов | Публичный доступ к bucket, небезопасные настройки workload, отсутствие сетевого ограничения | Bucket переведен в приватный режим, применены securityContext, RBAC, NetworkPolicy, Pod Security labels | `bucket-access-before.txt`, `bucket-access-after.txt`, `k8s-secure-pod-security-after.txt`, `k8s-secure-networkpolicy-after.yaml` | Снижена вероятность несанкционированного доступа из-за ошибок конфигурации |
| 3 | Несанкционированное раскрытие, утечка или потеря данных | Объект в bucket доступен анонимно, отсутствует проверка восстановления версии | Закрыт публичный доступ, включено versioning, выполнена проверка восстановления предыдущей версии объекта | `bucket-public-access-before.txt`, `bucket-private-access-after.txt`, `restored-object-content-after.txt` | Анонимный доступ заблокирован, восстановление данных подтверждено |
| 4 | Утечка секретов, ключей доступа и служебных токенов | Секреты присутствуют в plaintext-манифестах и переменных окружения | Plaintext-секреты исключены из secure-манифестов, используется ссылка на внешний источник секрета, отключен automount service account token | `secret-plaintext-before.txt`, `secret-secure-after.txt`, `final-k8s-secure-deployment-summary-after.json` | Снижена вероятность утечки секретов из репозитория и pod |
| 5 | Использование уязвимых компонентов и контейнерных образов | Используется vulnerable image на устаревшей базе, сканирование показывает большое количество CVE | Собран secure image на актуальной базе, выполнено повторное сканирование Container Registry | `image-vulnerabilities-summary-before.txt`, `image-vulnerabilities-summary-after.txt` | Количество уязвимостей снижено со 125 до 1, устранены Critical и High |
| 6 | Угрозы Kubernetes и контейнерной runtime-среды | Контейнер запускается от root, privileged, без ограничений capabilities и root filesystem | Настроены non-root UID/GID, `allowPrivilegeEscalation: false`, `drop: ALL`, `readOnlyRootFilesystem: true`, `seccompProfile: RuntimeDefault` | `k8s-vulnerable-deployment-before.yaml`, `k8s-secure-probes-limits-after.json`, `final-k8s-secure-deployment-summary-after.json` | Снижены последствия компрометации контейнера |
| 7 | Недостаточное журналирование, мониторинг и аудит событий безопасности | Отдельный централизованный аудит и алертинг не использовались | Настроены Audit Trails, Cloud Logging, Monitoring dashboard и alert notification | `audit-trails-events-found-after.txt`, `monitoring-k8s-memory-alert-warning.png`, `monitoring-alert-notification.png` | Подтверждена фиксация административных действий и оповещение по метрикам |
| 8 | Угрозы доступности и восстановления | Отсутствуют probes, limits и проверка восстановления данных | Настроены resource limits, readiness/liveness probes, versioning/restore, Monitoring alert | `k8s-secure-probes-limits-after.json`, `k8s-secure-readiness-negative-endpointslice-summary-after.txt`, `restored-object-content-after.txt` | Подтвержден контроль готовности workload и возможность восстановления данных |

## Ключевые количественные результаты

| Показатель | До | После |
|---|---:|---:|
| Анонимный доступ к объекту Object Storage | HTTP 200 | HTTP 403 |
| Количество найденных уязвимостей в контейнерном образе | 125 | 1 |
| Critical CVE в контейнерном образе | 2 | 0 |
| High CVE в контейнерном образе | 40 | 0 |
| Readiness state для pod с некорректной проверкой | не проверялось | `ready: false` |
| Restart count secure-контейнера | не проверялось | 0 |
| Audit event для IAM-действия | не фиксировался в отдельной лог-группе стенда | найден в Cloud Logging |
| Monitoring alert | отсутствовал | создан, получено уведомление |

## Вывод

Экспериментальная проверка показала, что реализованный комплекс мер снижает риски раскрытия данных, утечки секретов, использования уязвимых контейнерных образов, небезопасной конфигурации Kubernetes, недостаточного мониторинга и отсутствия аудита административных действий. Для каждой меры был получен проверяемый артефакт в виде вывода CLI, Kubernetes-манифеста, результата сканирования, логов Audit Trails или скриншота Monitoring.
