# PromptX MCP Server Dockerfile
FROM node:20-slim

# 设置工作目录
WORKDIR /app

# 安装基础依赖和pnpm
RUN apt-get update && apt-get install -y \
    git \
    tree \
    && rm -rf /var/lib/apt/lists/* \
    && npm install -g pnpm

# 克隆PromptX仓库
RUN git clone https://github.com/Deepractice/PromptX.git . && \
    pnpm install && \
    pnpm build

# 创建数据目录
RUN mkdir -p /data

# 暴露MCP端口
EXPOSE 5203

# 启动脚本（带调试信息）
ENV PORT=5203
ENV HOST=0.0.0.0

# 创建启动脚本
RUN echo '#!/bin/bash\n\
echo "=== PromptX MCP Server Starting ==="\n\
echo "Current directory: $(pwd)"\n\
echo ""\n\
echo "Directory structure:"\n\
ls -la /app/packages/ || echo "packages directory not found"\n\
echo ""\n\
if [ -d "/app/packages/mcp-server" ]; then\n\
  echo "MCP Server directory exists"\n\
  cd /app/packages/mcp-server\n\
  echo "Contents:"\n\
  ls -la\n\
  echo ""\n\
  if [ -f "dist/index.js" ]; then\n\
    echo "Starting with: node dist/index.js"\n\
    exec node dist/index.js\n\
  else\n\
    echo "ERROR: dist/index.js not found!"\n\
    echo "Looking for entry files:"\n\
    find . -name "*.js" -type f | head -20\n\
  fi\n\
else\n\
  echo "ERROR: MCP server directory not found!"\n\
  echo "Available packages:"\n\
  ls -la /app/packages/\n\
fi\n\
' > /app/start.sh && chmod +x /app/start.sh

CMD ["/app/start.sh"]
