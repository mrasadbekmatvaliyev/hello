# 1. Java 17 image dan boshlaymiz
FROM openjdk:17-jdk-slim

# 2. App papkasini yaratamiz
WORKDIR /app

# 3. Gradle cache uchun build.gradle va settings.gradle ni copy qilamiz
COPY build.gradle settings.gradle gradlew gradle /app/

# 4. dependencies ni oldindan yuklab olamiz (build tezlashadi)
RUN ./gradlew dependencies || return 0

# 5. Hamma fayllarni copy qilamiz
COPY . /app

# 6. JAR faylni yaratamiz
RUN ./gradlew build

# 7. JAR fayl nomini aniqlaymiz
ARG JAR_FILE=build/libs/*.jar

# 8. Portni expose qilamiz (Render `PORT` env var beradi)
EXPOSE 8080

# 9. Java ilovani ishga tushiramiz
CMD ["sh", "-c", "java -jar ${JAR_FILE}"]
