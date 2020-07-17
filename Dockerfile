FROM  registry.cn-beijing.aliyuncs.com/dengyou/tomcat:v8.5.43

ADD ./target/mvnwebapp.war /apps/tomcat/webapps/

WORKDIR /data/tomcat/webapps

CMD ["/apps/tomcat/bin/catalina.sh", "run"]
