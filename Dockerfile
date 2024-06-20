# Stage 1: Build the application
FROM maven:3.8.5-openjdk-11 AS build
WORKDIR /app
COPY . /app
RUN mvn package

# Stage 2: Run the application
FROM tomcat:9.0.45-jdk11-openjdk-slim
COPY --from=build /app/target/*.war /usr/local/tomcat/webapps/


EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
