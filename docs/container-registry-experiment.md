# Эксперимент Container Registry: сканирование контейнерных образов

## Цель

Проверить риск использования уязвимых контейнерных образов и показать эффективность меры защиты в виде сканирования образов на наличие известных уязвимостей.

## Ресурсы

- Container Registry: `crpgvkre5ragc5bos7qt`
- Репозиторий образов: `crpgvkre5ragc5bos7qt/demo-app`
- Уязвимый образ: `cr.yandex/crpgvkre5ragc5bos7qt/demo-app:vulnerable`
- Защищённый образ: `cr.yandex/crpgvkre5ragc5bos7qt/demo-app:secure`

## Состояние «до»

В качестве демонстрационного состояния «до» используется образ `demo-app:vulnerable`, собранный на устаревшей базовой системе `python:3.8-slim-buster`. Такой образ имитирует типовую ситуацию использования устаревших базовых контейнерных образов и зависимостей.

Evidence:

- `evidence/before/image-list-before.txt`
- `evidence/before/image-scan-before.json`
- `evidence/before/image-vulnerabilities-before.json`
- `evidence/before/image-vulnerabilities-summary-before.txt`

## Состояние «после»

В качестве состояния «после» используется образ `demo-app:secure`, собранный на более актуальной и минимизированной базе `python:3.12-alpine`, с запуском приложения от непривилегированного пользователя.

Evidence:

- `evidence/after/image-list-after.txt`
- `evidence/after/image-scan-after.json`
- `evidence/after/image-vulnerabilities-after.json`
- `evidence/after/image-vulnerabilities-summary-after.txt`

## Вывод

Эксперимент демонстрирует, что использование встроенного сканирования Container Registry позволяет выявлять известные уязвимости в контейнерных образах и использовать результаты сканирования как критерий допуска образа к дальнейшему развертыванию.
