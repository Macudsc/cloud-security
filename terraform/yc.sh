# Создать registry с безопасным автосканированием
yc container registry create --name thesis-reg --secure

# Создать log group для security logs
yc logging group create --name thesis-sec-logs --retention-period 168h

# Создать кластер
yc managed-kubernetes cluster create \
  --name thesis-k8s \
  --network-name mynet \
  --master-location zone=ru-central1-a,subnet-name=private-a \
  --service-account-name cluster-sa \
  --node-service-account-name node-sa \
  --security-group-ids <sg-id>

# Выключить публичность демонстрационного bucket
yc storage bucket update \
  --name thesis-public-demo \
  --public-read=false \
  --public-list=false \
  --public-config-read=false