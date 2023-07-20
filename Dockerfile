# 使用官方的tomcat镜像作为基础镜像
FROM tomcat:9.0

# 移除原有的ROOT文件夹
RUN rm -rf /usr/local/tomcat/webapps/ROOT

# 从构建环境中复制war文件到tomcat的webapps目录
COPY target/helloworld.war /usr/local/tomcat/webapps/ROOT.war

# 暴露端口
EXPOSE 8080

# 启动tomcat
CMD ["catalina.sh", "run"]

