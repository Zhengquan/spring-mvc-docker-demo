FROM tomcat:8.0.20-jre8

RUN rm -rf /usr/local/tomcat/webapps/ROOT

COPY target/helloworld.war /usr/local/tomcat/webapps/ROOT.war
