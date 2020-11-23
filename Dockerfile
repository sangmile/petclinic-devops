FROM openjdk:8
RUN useradd -u 1000 spring
USER spring
WORKDIR /app
COPY dependency/*.jar /app/app.jar
ENTRYPOINT ["java","-jar","app.jar"]