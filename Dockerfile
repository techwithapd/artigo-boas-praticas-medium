# Use Maven for building the application
FROM maven:3.8.4-openjdk-11-slim AS build

# Set the working directory in the Docker image
WORKDIR /app

# Copy the pom.xml and source code
COPY pom.xml ./
COPY src ./src

# Package the application
RUN mvn clean package -DskipTests

# Use OpenJDK for running the application
FROM openjdk:11-jre-slim

# Set the working directory in the Docker image
WORKDIR /app

# Copy the packaged JAR file from the build stage
COPY --from=build /app/target/*.jar app.jar

# Expose the port the application runs on
EXPOSE 9595

# Command to run the application
CMD ["java", "-jar", "app.jar"]
