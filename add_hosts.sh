#!/bin/bash

HOSTS_FILE="/etc/hosts"

# 要添加的多条记录
entries=(
  "10.220.150.44 www.c534.com"
  "10.220.150.44 c534.com"
  "10.220.150.44 gitlab.c534.com"
)

for entry in "${entries[@]}"; do
  ip=$(echo "$entry" | awk '{print $1}')
  domain=$(echo "$entry" | awk '{print $2}')

  # 检查该域名是否已存在于 hosts 文件中
  if grep -qE "[[:space:]]$domain(\$|[[:space:]])" "$HOSTS_FILE"; then
    echo "✅ 已存在：$domain"
  else
    echo "🔧 添加：$entry"
    echo "$entry" | sudo tee -a "$HOSTS_FILE" > /dev/null
  fi
done

echo "✅ 操作完成！"

