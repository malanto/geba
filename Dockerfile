FROM python:3.10-slim

WORKDIR /app

COPY . .

# 更新 apt 并安装 git
RUN apt-get update && apt-get install -y --no-install-recommends git \
    && chmod +x ./start.sh \
    && rm -rf /var/lib/apt/lists/*

RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 8080

ENTRYPOINT ["/app/start.sh"]

USER 10014
