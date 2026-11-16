#!/bin/bash

# Скрипт аудита безопасности сервера
echo "=== [1] Проверка UFW ==="
sudo ufw status | grep -q "Status: active" && echo "OK" || echo "FAIL"

echo "=== [2] Проверка прав .env ==="
stat -c "%a" ~/kr2/.env 2>/dev/null | grep -q "600" && echo "OK" || echo "FAIL"

echo "=== [6] Контрольная работа №2 ==="
# Проверка контейнера redis
docker compose --project-directory ~/kr2 ps -q redis | xargs docker inspect -f '{{.State.Health.Status}}' 2>/dev/null | grep -q "healthy" && echo "Redis OK" || echo "Redis FAIL"

# Проверка публикации порта
docker compose --project-directory ~/kr2 port app 8003 | grep -q "127.0.0.1:8003" && echo "Port OK" || echo "Port FAIL"

# Проверка сертификата
openssl x509 -checkend 2592000 -noout -in /etc/ssl/certs/kr2.crt &>/dev/null && echo "Cert OK" || echo "Cert FAIL"

# Проверка активации Nginx
test -L /etc/nginx/sites-enabled/kr2 && echo "Nginx OK" || echo "Nginx FAIL"