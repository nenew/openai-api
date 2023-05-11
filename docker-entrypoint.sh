#!/bin/bash

set -e

# 读取容器启动参数中的BIND_IP值
bind_ip=${BIND_IP}
secret=${SECRET}
echo "bind_ip=${bind_ip}" >> /log
echo "BIND_IP=${BIND_IP}" >> /log
echo "secret=${secret}" >> /log
echo "SECRET=${SECRET}" >> /log
# 生成最终的nginx.conf配置文件
#envsubst '${bind_ip} ${secret}' < "$NGINX_CONF_TEMPLATE" > /etc/openresty/nginx.conf
sed -e "s/\${bind_ip}/$bind_ip/g; s/\${secret}/$secret/g" < "$NGINX_CONF_TEMPLATE" > /etc/openresty/nginx.conf

# 执行默认的启动命令
exec "$@"
