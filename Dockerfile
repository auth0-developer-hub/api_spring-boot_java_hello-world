FROM openjdk:17.0.1

WORKDIR /home/app

COPY ./config ./config
COPY ./gradle ./gradle
COPY ./src ./src
COPY ./build.gradle ./
COPY ./buildscript-gradle.lockfile ./
COPY ./gradle.lockfile ./
COPY ./gradlew ./
COPY ./gradlew.bat ./
COPY ./settings.gradle ./
COPY .env ./

ARG CACHEBUST=$RANDOM
RUN ./gradlew clean build

RUN useradd -M auth0
USER auth0

EXPOSE 6060

ENTRYPOINT ["java", "-jar", "build/libs/helloworld-0.0.1-SNAPSHOT.jar"]
