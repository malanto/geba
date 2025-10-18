#!/bin/bash
set -e  # 遇到错误立即退出

REPO_URL="https://github.com/snailyp/gemini-balance.git"
APP_DIR="/app/app"
PORT="${PORT:-8080}"

echo "🚀 开始部署..."

# 确保目录存在
mkdir -p "$APP_DIR"

# 删除目录下所有文件（包括隐藏文件），但保留目录本身
echo "🧹 清空目录内容: $APP_DIR"
rm -rf "$APP_DIR"/* "$APP_DIR"/.[!.]* "$APP_DIR"/..?* 2>/dev/null || true

# 克隆最新代码
echo "📦 克隆仓库..."
git clone --depth=1 "$REPO_URL" "$APP_DIR"

# 进入应用目录
cd "$APP_DIR"

# 启动服务
echo "🚀 启动 uvicorn 服务 (端口: ${PORT}) ..."
exec uvicorn app.main:app --host 0.0.0.0 --port "${PORT}" --no-access-log
