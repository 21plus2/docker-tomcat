############################################################
# CentOS 7 with a ORACLE-Server-JRE and Tomcat installation
#
# is based on the idea of Peter Rossbach
# http://www.infrabricks.de/blog/2014/12/19/docker-microservice-basis-mit-apache-tomcat-implementieren/
############################################################

FROM 21plus2/server-jre
MAINTAINER 21plus2

############################################################
# Configure Java Version
############################################################

ENV TOMCAT_MINOR_VERSION=8.0.41 \
    CATALINA_HOME=/opt/tomcat

############################################################
# Download, verify and extract Tomcat
############################################################

RUN curl -O http://archive.apache.org/dist/tomcat/tomcat-8/v${TOMCAT_MINOR_VERSION}/bin/apache-tomcat-${TOMCAT_MINOR_VERSION}.tar.gz \
   && curl http://archive.apache.org/dist/tomcat/tomcat-8/v${TOMCAT_MINOR_VERSION}/bin/apache-tomcat-${TOMCAT_MINOR_VERSION}.tar.gz.md5 \
   && gunzip apache-tomcat-*.tar.gz \
   && tar xf apache-tomcat-*.tar \
   && rm apache-tomcat-*.tar \
   && mv apache-tomcat* ${CATALINA_HOME} \
   && rm -rf ${CATALINA_HOME}/webapps/examples \
      ${CATALINA_HOME}/webapps/docs ${CATALINA_HOME}/webapps/ROOT \
      ${CATALINA_HOME}/webapps/host-manager \
      ${CATALINA_HOME}/RELEASE-NOTES ${CATALINA_HOME}/RUNNING.txt \
      ${CATALINA_HOME}/bin/*.bat ${CATALINA_HOME}/bin/*.tar.gz

WORKDIR /opt/tomcat

EXPOSE 8080 8009
VOLUME [ "/opt/tomcat" ]

ENTRYPOINT [ "/opt/tomcat/bin/catalina.sh" ]
CMD [ "run"]
