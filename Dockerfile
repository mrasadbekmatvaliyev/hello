# 1. Java 17 image dan boshlaymiz
FROM openjdk:17-jdk-slim

# 2. App papkasini yaratamiz
WORKDIR /app

# 3. Gradle wrapper va build fayllarni copy qilamiz
COPY gradle gradle
COPY build.gradle settings.gradle gradlew ./

# 4. gradlew faylga executable huquq beramiz
RUN chmod +x gradlew

# 5. Dependencies ni yuklab olamiz (cache uchun)
RUN ./gradlew dependencies --no-daemon || return 0

# 6. Source code ni copy qilamiz
COPY src src

# 7. JAR faylni build qilamiz
RUN ./gradlew build --no-daemon -x test

# 8. Portni expose qilamiz
EXPOSE 8080

# 9. Entrypoint script ni copy qilamiz va ishga tushuramiz
COPY entrypoint.sh /app/
RUN chmod +x /app/entrypoint.sh
CMD ["/app/entrypoint.sh"]
