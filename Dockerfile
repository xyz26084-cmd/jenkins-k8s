FROM eclipse-temurin:17-jdk
WORKDIR /app
COPY hello.java /app
RUN javac hello.java
CMD ["java","hello"]
