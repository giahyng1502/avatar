# ==========================================
# GIAI ĐOẠN 1: BUILD CODE
# ==========================================
FROM maven:3.8-eclipse-temurin-17 AS build
WORKDIR /app

# Copy file cấu hình maven trước để cache dependencies
COPY pom.xml .
# Download offline dependencies (giúp build nhanh hơn trong những lần sau)
RUN mvn dependency:go-offline

# Copy toàn bộ source code
COPY src ./src
# Biên dịch mã nguồn và đóng gói thành file .jar
RUN mvn clean package -DskipTests

# ==========================================
# GIAI ĐOẠN 2: RUN SERVER
# ==========================================
FROM eclipse-temurin:17-jre
WORKDIR /app

# Thiết lập múi giờ (Vietnam)
ENV TZ=Asia/Ho_Chi_Minh
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Lấy file jar đã build từ giai đoạn 1
COPY --from=build /app/target/Avatar2D-1.0-SNAPSHOT.jar app.jar

# Không copy các thư mục data và config ở đây vì sẽ được mount qua docker-compose.yml 
# để đảm bảo tính lưu trữ (persistent data) và dễ chỉnh sửa.

EXPOSE 19128 19129

# Lệnh khởi chạy server (sử dụng -cp app.jar vì đây là uber-jar chứa thư viện)
CMD ["java", "-cp", "app.jar", "avatar.server.Avatar"]
