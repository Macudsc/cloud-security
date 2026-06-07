# План экспериментальной проверки

## Цель

Проверить применимость комплекса мер защиты cloud-native инфраструктуры в Yandex Cloud путем сравнения состояния стенда «до» и «после» внедрения защитных мер.

## Сценарии проверки

| № | Угроза | Состояние «до» | Состояние «после» | Проверка | Evidence |
|---|---|---|---|---|---|
| 1 | Компрометация учетных записей и избыточные права | один сервисный аккаунт с широкими ролями | отдельные сервисные аккаунты с минимальными ролями | список IAM bindings | evidence/before, evidence/after |
| 2 | Ошибки конфигурации | широкие сетевые правила, лишний публичный доступ | ограниченные Security Groups, приватная зона | проверка правил SG и доступности портов | evidence/before, evidence/after |
| 3 | Раскрытие/утечка данных | публичный бакет с тестовым файлом | приватный бакет, ограниченный доступ, versioning | curl/aws s3 без авторизации и с авторизацией | evidence/before, evidence/after |
| 4 | Утечка секретов | fake-secret в YAML/env | секрет в Lockbox, доступ по IAM | grep по манифестам, проверка доступа к секрету | evidence/before, evidence/after |
| 5 | Уязвимые образы | образ со старыми зависимостями | сканирование и обновленный образ | отчет Container Registry scan | evidence/before, evidence/after |
| 6 | Kubernetes threats | pod без limits/securityContext/NetworkPolicy | RBAC, namespace, NetworkPolicy, securityContext, limits | kubectl get yaml, сетевой тест | evidence/before, evidence/after |
| 7 | Logging gaps | отсутствие централизованного аудита/логов | Audit Trails, Cloud Logging, Monitoring | событие фиксируется в логах | evidence/before, evidence/after |
| 8 | Backup/DR failures | нет versioning/restore test | versioning и восстановление объекта | удаление/изменение тестового объекта и restore | evidence/before, evidence/after |

## Ограничения

Используются только тестовые данные, демонстрационные секреты и безопасные сценарии. DDoS, эксплуатация реальных уязвимостей и работа с реальными конфиденциальными данными не выполняются.
