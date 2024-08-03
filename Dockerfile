# Sử dụng image gốc
FROM calciumion/new-api:latest

# Cài đặt các công cụ cần thiết
RUN apk add --no-cache wget

# Thiết lập thư mục làm việc
WORKDIR /app

# Sao chép các file cần thiết (nếu có)
# COPY . .

# Thiết lập biến môi trường
ENV SQL_DSN=postgresql://postgres:NGxWVvFElTKukcyIlQIDBqgechibziro@monorail.proxy.rlwy.net:30046/railway
ENV REDIS_CONN_STRING=redis://default:rLRZHkllTrfXLcfHMXeZdMuPGXDLxCBS@redis-mhr2.railway.internal:6379
ENV SESSION_SECRET=random_string
ENV TZ=Asia/Shanghai

# Tạo thư mục logs
RUN mkdir -p /app/logs

# Mở cổng 3000
EXPOSE 3000

# Thiết lập healthcheck
HEALTHCHECK --interval=30s --timeout=10s --retries=3 \
  CMD wget -q -O - http://localhost:3000/api/status | grep -o '"success":\s*true' | awk -F: '{print $2}'

# Lệnh chạy khi container khởi động
CMD ["--log-dir", "/app/logs"]

# Ghi đè ENTRYPOINT nếu cần
# ENTRYPOINT ["/one-api"]
