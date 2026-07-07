FROM eclipse-temurin:17-jre
WORKDIR /app
RUN ln -snf /usr/share/zoneinfo/Asia/Ho_Chi_Minh /etc/localtime && echo Asia/Ho_Chi_Minh > /etc/timezone
COPY target/Avatar2D-1.0-SNAPSHOT.jar app.jar
EXPOSE 19128 19129
CMD ["java", "-cp", "app.jar", "avatar.server.Avatar"]
