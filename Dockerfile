FROM openresty/openresty:latest

# 拷贝自定义配置文件到镜像中
COPY nginx.conf /nginx.conf.template

# 设置环境变量
ENV NGINX_CONF_TEMPLATE=/nginx.conf.template

# 添加启动脚本
COPY docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/usr/local/openresty/bin/openresty", "-g", "daemon off;"]
