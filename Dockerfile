# 1. Java 17 image dan boshlaymiz
FROM openjdk:17-jdk-slim

# 2. App papkasini yaratamiz
WORKDIR /app

# 3. Gradle cache uchun fayllarni copy qilamiz
COPY build.gradle settings.gradle gradlew gradle /app/

# 4. gradlew faylga executable huquq beramiz
RUN chmod +x gradlew

# 5. dependencies ni yuklab olamiz
RUN ./gradlew dependencies || return 0

# 6. Loyihani to‘liq copy qilamiz
COPY . /app

# 7. JAR faylni build qilamiz
RUN ./gradlew build

# 8. Portni expose qilamiz (Render yoki Railway `PORT` beradi)
EXPOSE 8080

# 9. Appni ishga tushuramiz (entrypoint orqali glob ishlatamiz)
COPY entrypoint.sh /app/
RUN chmod +x /app/entrypoint.sh
CMD ["/app/entrypoint.sh"]
