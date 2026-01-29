#!/bin/sh
# Railway会在运行时设置PORT环境变量，我们读取它
# 如果没有设置（比如本地运行），默认使用8080

if [ -z "$PORT" ]; then
  PORT=8080
fi

echo "Starting PromptX MCP Server on port $PORT"
exec node dist/mcp-server.js --transport http --port "$PORT" --host 0.0.0.0 --cors --debug
