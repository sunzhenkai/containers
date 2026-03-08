# Common Services - 常用服务部署

这个目录包含常用的数据库和缓存服务的 Docker Compose 配置，支持跨机器访问。

## 🚀 快速开始

### 1. 初始化配置

首次使用必须执行：

```bash
make init
```

这会创建：
- 配置目录和文件
- `.env` 环境变量文件（可根据需要修改）

### 2. 启动服务

```bash
# 启动所有服务
make up

# 启动指定服务
make up SERVICE=mysql
make up SERVICE=redis
```

### 3. 查看状态

```bash
# 查看服务状态
make ps

# 查看详细状态（包括健康检查）
make status

# 查看日志
make logs
make logs SERVICE=mysql
```

## 📦 包含的服务

| 服务 | 版本 | 端口 | 说明 |
|------|------|------|------|
| MySQL | 8.0 | 3306 | 关系型数据库 |
| PostgreSQL | 16 | 5432 | 关系型数据库 |
| MongoDB | 7 | 27017 | 文档数据库 |
| Redis | 7 | 6379 | 缓存/内存数据库 |

## 🔧 配置说明

### 环境变量配置

编辑 `.env` 文件修改默认配置：

```bash
# MySQL 配置
MYSQL_ROOT_PASSWORD=root123
MYSQL_DATABASE=app
MYSQL_USER=app
MYSQL_PASSWORD=app123
MYSQL_PORT=3306

# PostgreSQL 配置
POSTGRES_USER=postgres
POSTGRES_PASSWORD=postgres123
POSTGRES_DB=app
POSTGRES_PORT=5432

# MongoDB 配置
MONGO_ROOT_USER=admin
MONGO_ROOT_PASSWORD=admin123
MONGO_DATABASE=app
MONGO_PORT=27017

# Redis 配置
REDIS_PORT=6379
```

### 自定义配置文件

- MySQL: `mysql/conf.d/my.cnf`
- Redis: `redis/redis.conf`
- 初始化脚本: `*/init/` 目录

## 🌐 跨机器访问

服务启动后，其他机器可通过以下方式访问：

### MySQL

```bash
mysql -h <服务器IP> -P 3306 -u root -p
# 或使用应用程序连接
# jdbc:mysql://<服务器IP>:3306/app
```

### PostgreSQL

```bash
psql -h <服务器IP> -p 5432 -U postgres
# 或使用连接字符串
# postgresql://postgres:postgres123@<服务器IP>:5432/app
```

### MongoDB

```bash
mongosh "mongodb://admin:admin123@<服务器IP>:27017"
# 或使用连接字符串
# mongodb://admin:admin123@<服务器IP>:27017/app?authSource=admin
```

### Redis

```bash
redis-cli -h <服务器IP> -p 6379
# 或在应用程序中配置
# redis://<服务器IP>:6379
```

## 📚 常用命令

### 服务管理

```bash
make up                # 启动所有服务
make down              # 停止所有服务
make restart           # 重启所有服务
make ps                # 查看服务状态
make logs              # 查看日志
```

### 服务操作

```bash
# 进入容器
make exec SERVICE=mysql

# 备份数据库
make backup

# 拉取最新镜像
make pull

# 查看网络信息
make network
```

### 清理

```bash
# 警告：删除所有服务和数据！
make clean
```

## 🔒 安全建议

1. **修改默认密码**：在生产环境中务必修改 `.env` 中的默认密码
2. **防火墙配置**：仅开放必要的端口给可信的 IP 地址
3. **数据备份**：定期执行 `make backup` 备份数据
4. **SSL/TLS**：生产环境建议配置 SSL 加密连接

## 📁 目录结构

```
common/
├── docker-compose.yml    # Docker Compose 配置
├── Makefile              # 管理脚本
├── README.md             # 说明文档
├── .env                  # 环境变量（需要初始化）
├── mysql/
│   ├── conf.d/           # MySQL 配置文件
│   └── init/             # MySQL 初始化脚本
├── postgres/
│   └── init/             # PostgreSQL 初始化脚本
├── mongodb/
│   └── init/             # MongoDB 初始化脚本
├── redis/
│   └── redis.conf        # Redis 配置文件
└── backups/              # 数据库备份目录
```

## 🐛 故障排除

### 服务无法启动

1. 检查端口是否被占用：`lsof -i :3306`
2. 查看日志：`make logs SERVICE=<服务名>`
3. 检查配置：`docker compose config`

### 无法从其他机器访问

1. 检查防火墙设置
2. 确认服务已启动：`make ps`
3. 确认端口映射正确：`docker ps`

### 数据丢失

数据存储在 Docker volumes 中，使用 `docker volume ls` 查看。
如需持久化到主机目录，可修改 `docker-compose.yml` 中的 volumes 配置。

## 📝 常见问题

**Q: 如何修改服务端口？**
A: 修改 `.env` 文件中对应的端口配置，然后重启服务。

**Q: 如何添加初始化脚本？**
A: 将 `.sql` 或 `.sh` 脚本放到对应服务的 `init/` 目录。

**Q: 如何查看服务日志？**
A: 使用 `make logs SERVICE=<服务名>` 或 `docker logs common-<服务名>`。

**Q: 数据存储在哪里？**
A: 数据存储在 Docker volumes 中，可通过 `docker volume inspect common-<服务>-data` 查看。

## 📄 License

MIT
