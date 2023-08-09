FROM tomcat:8.0.20-jre8

RUN rm -rf /usr/local/tomcat/webapps/ROOT

COPY target/helloworld.war /usr/local/tomcat/webapps/ROOT.war

ADD consul_template_bootstrap.sh /root/
ADD tsf-consul-template-docker.tar.gz /root/

CMD ["sh", "-ec", "consul_template_bootstrap.sh && exec catalina.sh run"]
