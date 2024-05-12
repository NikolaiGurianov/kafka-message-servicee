# Use a base image with JDK 17 and Maven
FROM maven:3.8.4-openjdk-17-slim AS builder

# Set working directory
WORKDIR /app

# Copy Maven dependencies file
COPY pom.xml .

# Download dependencies
RUN mvn -B -e -C -T 1C org.apache.maven.plugins:maven-dependency-plugin:3.1.2:go-offline

# Copy the project source
COPY src ./src

# Build the project
RUN mvn -f /app/pom.xml clean package -Dmaven.test.skip=true

# Use a smaller base image for the runtime
FROM amazoncorretto:17

# Set the working directory
WORKDIR /app

# Copy the built JAR file from the builder stage
COPY --from=builder /app/target/kafka-message-service-0.0.1-SNAPSHOT.jar .

# Command to run the application
CMD ["java", "-jar", "kafka-message-service-0.0.1-SNAPSHOT.jar", "--server.port=8000"]
