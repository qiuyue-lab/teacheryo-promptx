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

# 暴露MCP端口
EXPOSE 5203

# 环境变量（Railway会覆盖PORT）
ENV PORT=5203
ENV HOST=0.0.0.0
ENV NODE_ENV=production

# 工作目录切换到mcp-server
WORKDIR /app/packages/mcp-server

# 启动命令：使用正确的入口文件
CMD ["node", "dist/mcp-server.js", "--port", "$PORT", "--host", "0.0.0.0"]
