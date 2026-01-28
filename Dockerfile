# PromptX MCP Server Dockerfile
FROM node:20-slim

# 设置工作目录
WORKDIR /app

# 安装基础依赖
RUN apt-get update && apt-get install -y \
    git \
    && rm -rf /var/lib/apt/lists/*

# 克隆PromptX仓库（注意大小写）
RUN git clone https://github.com/Deepractice/PromptX.git . && \
    npm install && \
    npm run build

# 创建数据目录
RUN mkdir -p /data

# 暴露MCP端口
EXPOSE 5203

# 启动PromptX服务器
ENV PORT=5203
CMD ["node", "dist/server.js", "--host", "0.0.0.0", "--port", "5203", "--data", "/data"]
