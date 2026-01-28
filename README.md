# PromptX MCP Server - Railway部署

## 🚀 快速部署到Railway（5分钟）

### 步骤1：注册Railway账号
1. 访问：https://railway.app
2. 使用GitHub账号登录（推荐）
3. 验证邮箱

### 步骤2：创建新项目
1. 点击 "New Project"
2. 选择 "Deploy from GitHub repo"
3. 连接您的GitHub账号
4. 选择这个仓库（或先push代码到GitHub）

### 步骤3：配置环境变量（可选）
在Railway项目设置中添加：
```
PORT=5203
NODE_ENV=production
```

### 步骤4：部署
- Railway会自动检测Dockerfile
- 自动构建和部署
- 等待3-5分钟

### 步骤5：获取服务器URL
部署成功后，Railway会提供一个URL，类似：
```
https://promptx-production-xxxx.up.railway.app
```

## 📝 本地测试

```bash
docker build -t promptx-server .
docker run -p 5203:5203 -v $(pwd)/data:/data promptx-server
```

访问：http://localhost:5203/mcp

## 🔧 故障排查

### 服务无法启动
检查Railway日志：Project → Deployments → 点击最新部署 → Logs

### 连接被拒绝
确保防火墙允许HTTP流量

### 数据丢失
Railway重启会清空非持久化存储，需要配置Volume
