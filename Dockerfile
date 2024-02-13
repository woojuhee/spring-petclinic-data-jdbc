FROM	openjdk:17-jdk AS builder
WORKDIR	/home/spring
COPY	. .
RUN	["./mvnw","clean","package","-Dmaven.test.skip=true"]

FROM	openjdk:17.0-buster
EXPOSE	8080
WORKDIR	/home/spring
COPY	--from=builder	/home/spring/target/spring-petclinic-data-jdbc-3.0.0.BUILD-SNAPSHOT.jar /home/spring/spring-petclinic-data-jdbc-3.0.0.BUILD-SNAPSHOT.jar
COPY	--from=builder 	/home/spring/src/main/resources/application.properties /home/spring/application.properties
CMD	["java","-jar","./spring-petclinic-data-jdbc-3.0.0.BUILD-SNAPSHOT.jar"]
