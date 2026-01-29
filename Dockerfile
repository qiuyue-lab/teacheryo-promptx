# PromptX MCP Server Dockerfile
FROM node:20-slim

# 设置工作目录
WORKDIR /app

# 安装基础依赖和pnpm
RUN apt-get update && apt-get install -y \
    git \
    && rm -rf /var/lib/apt/lists/* \
    && npm install -g pnpm

# 克隆PromptX仓库
RUN git clone https://github.com/Deepractice/PromptX.git . && \
    pnpm install && \
    pnpm build

# 创建数据目录
RUN mkdir -p /data

# 环境变量
ENV NODE_ENV=production
ENV PROMPTX_DATA_DIR=/data

# 工作目录切换到mcp-server
WORKDIR /app/packages/mcp-server

# 创建启动脚本来正确处理PORT环境变量
RUN echo '#!/bin/sh\n\
PORT=${PORT:-8080}\n\
echo "Starting MCP Server on port $PORT"\n\
exec node dist/mcp-server.js --transport http --port "$PORT" --host 0.0.0.0 --cors --debug\n\
' > /app/start.sh && chmod +x /app/start.sh

CMD ["/app/start.sh"]
