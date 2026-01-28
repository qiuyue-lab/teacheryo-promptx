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

# 启动PromptX MCP服务器
ENV PORT=5203
CMD ["pnpm", "start:server", "--host", "0.0.0.0", "--port", "5203"]
