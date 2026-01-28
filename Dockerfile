# PromptX MCP Server Dockerfile
FROM node:20-slim

# 安装PromptX
RUN npm install -g @deepractice/promptx

# 暴露MCP端口
EXPOSE 5203

# 数据目录
VOLUME /data

# 启动PromptX服务器
CMD ["promptx", "server", "--host", "0.0.0.0", "--port", "5203", "--data", "/data"]
