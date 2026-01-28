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

# 设置工作目录到MCP服务器包
WORKDIR /app/packages/mcp-server

# 启动PromptX MCP服务器
ENV PORT=5203
ENV HOST=0.0.0.0
CMD ["node", "dist/index.js"]
