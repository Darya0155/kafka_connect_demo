
FROM openjdk:21-jdk-slim

WORKDIR /app

COPY target/aws-mks-connect-demo-1.0-SNAPSHOT.jar /app/app.jar

EXPOSE 8089

CMD ["java", "-jar", "app.jar"]
