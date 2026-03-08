.PHONY: up down logs ps restart status clean help init debug

# 自动检测 docker compose 命令版本
# Docker Compose V2 使用 "docker compose"
# Docker Compose V1 使用 "docker-compose"
DOCKER_COMPOSE := $(shell if docker compose version >/dev/null 2>&1; then echo "docker compose"; elif command -v docker-compose >/dev/null 2>&1; then echo "docker-compose"; else echo ""; fi)

# Docker Compose 文件路径
COMPOSE_FILE := docker-compose.yml

# 可选：指定特定服务（例如：make up SERVICE=redis）
SERVICE ?=

# 默认目标
.DEFAULT_GOAL := help

# 检查 Docker Compose 是否安装
define check-docker-compose
	@if [ -z "$(DOCKER_COMPOSE)" ]; then \
		echo "错误: 未检测到 Docker Compose，请先安装 Docker Compose"; \
		echo "安装方法:"; \
		echo "  - Docker Desktop 已包含 Docker Compose V2 (docker compose)"; \
		echo "  - 或访问 https://docs.docker.com/compose/install/"; \
		exit 1; \
	fi
endef

# 初始化配置文件和目录
init:
	@echo "=== 初始化配置文件和目录 ==="
	@mkdir -p mysql/conf.d mysql/init
	@mkdir -p postgres/init
	@mkdir -p mongodb/init
	@mkdir -p redis
	@if [ ! -f mysql/conf.d/my.cnf ]; then \
		echo "[mysqld]" > mysql/conf.d/my.cnf; \
		echo "character-set-server=utf8mb4" >> mysql/conf.d/my.cnf; \
		echo "collation-server=utf8mb4_unicode_ci" >> mysql/conf.d/my.cnf; \
		echo "default-authentication-plugin=mysql_native_password" >> mysql/conf.d/my.cnf; \
		echo "创建 MySQL 配置文件: mysql/conf.d/my.cnf"; \
	fi
	@if [ ! -f redis/redis.conf ]; then \
		echo "# Redis 配置文件" > redis/redis.conf; \
		echo "bind 0.0.0.0" >> redis/redis.conf; \
		echo "protected-mode no" >> redis/redis.conf; \
		echo "创建 Redis 配置文件: redis/redis.conf"; \
	fi
	@if [ ! -f .env ]; then \
		echo "=== 创建 .env 文件 ==="; \
		echo "# MySQL 配置" > .env; \
		echo "MYSQL_ROOT_PASSWORD=root123" >> .env; \
		echo "MYSQL_DATABASE=app" >> .env; \
		echo "MYSQL_USER=app" >> .env; \
		echo "MYSQL_PASSWORD=app123" >> .env; \
		echo "MYSQL_PORT=3306" >> .env; \
		echo "" >> .env; \
		echo "# PostgreSQL 配置" >> .env; \
		echo "POSTGRES_USER=postgres" >> .env; \
		echo "POSTGRES_PASSWORD=postgres123" >> .env; \
		echo "POSTGRES_DB=app" >> .env; \
		echo "POSTGRES_PORT=5432" >> .env; \
		echo "" >> .env; \
		echo "# MongoDB 配置" >> .env; \
		echo "MONGO_ROOT_USER=admin" >> .env; \
		echo "MONGO_ROOT_PASSWORD=admin123" >> .env; \
		echo "MONGO_DATABASE=app" >> .env; \
		echo "MONGO_PORT=27017" >> .env; \
		echo "" >> .env; \
		echo "# Redis 配置" >> .env; \
		echo "REDIS_PORT=6379" >> .env; \
		echo "创建 .env 文件，请根据需要修改配置"; \
	fi
	@echo "=== 初始化完成 ==="

# 启动服务
up:
	$(check-docker-compose)
	@echo "使用命令: $(DOCKER_COMPOSE)"
ifdef SERVICE
	@echo "启动服务: $(SERVICE)"
	$(DOCKER_COMPOSE) -f $(COMPOSE_FILE) up -d $(SERVICE)
else
	$(DOCKER_COMPOSE) -f $(COMPOSE_FILE) up -d
endif
	@echo "服务启动完成，使用 'make logs' 查看日志"

# 停止并删除服务
down:
	$(check-docker-compose)
	@echo "使用命令: $(DOCKER_COMPOSE)"
ifdef SERVICE
	@echo "停止服务: $(SERVICE)"
	$(DOCKER_COMPOSE) -f $(COMPOSE_FILE) stop $(SERVICE)
	$(DOCKER_COMPOSE) -f $(COMPOSE_FILE) rm -f $(SERVICE)
else
	$(DOCKER_COMPOSE) -f $(COMPOSE_FILE) down
endif

# 查看日志
logs:
	$(check-docker-compose)
ifdef SERVICE
	$(DOCKER_COMPOSE) -f $(COMPOSE_FILE) logs -f --tail=100 $(SERVICE)
else
	$(DOCKER_COMPOSE) -f $(COMPOSE_FILE) logs -f --tail=100
endif

# 查看服务状态
ps:
	$(check-docker-compose)
	@$(DOCKER_COMPOSE) -f $(COMPOSE_FILE) ps

# 查看详细状态（包括健康检查）
status:
	$(check-docker-compose)
	@echo "=== 服务状态 ==="
	@$(DOCKER_COMPOSE) -f $(COMPOSE_FILE) ps
	@echo ""
	@echo "=== 健康检查状态 ==="
	@docker ps --filter "name=common-" --format "table {{.Names}}\t{{.Status}}"

# 重启服务
restart:
	$(check-docker-compose)
	@echo "使用命令: $(DOCKER_COMPOSE)"
ifdef SERVICE
	@echo "重启服务: $(SERVICE)"
	$(DOCKER_COMPOSE) -f $(COMPOSE_FILE) restart $(SERVICE)
else
	$(DOCKER_COMPOSE) -f $(COMPOSE_FILE) restart
endif

# 停止并删除所有服务、网络和数据卷（危险操作！）
clean:
	$(check-docker-compose)
	@echo "警告：此操作将删除所有服务和数据卷！"
	@read -p "确定要继续吗？(yes/no): " confirm; \
	if [ "$$confirm" = "yes" ]; then \
		$(DOCKER_COMPOSE) -f $(COMPOSE_FILE) down -v; \
		echo "清理完成"; \
	else \
		echo "操作已取消"; \
	fi

# 进入服务容器
exec:
ifndef SERVICE
	@echo "错误：请指定服务名称"
	@echo "示例: make exec SERVICE=mysql"
else
	@echo "进入容器: $(SERVICE)"
	@docker exec -it common-$(SERVICE) sh
endif

# 备份数据库
backup:
	@echo "=== 备份数据库 ==="
	@mkdir -p backups
	@echo "备份 MySQL..."
	@docker exec common-mysql mysqldump -u root -p${MYSQL_ROOT_PASSWORD:-root123} --all-databases > backups/mysql_backup_$$(date +%Y%m%d_%H%M%S).sql 2>/dev/null || echo "MySQL 备份失败或未启动"
	@echo "备份 PostgreSQL..."
	@docker exec common-postgres pg_dumpall -U ${POSTGRES_USER:-postgres} > backups/postgres_backup_$$(date +%Y%m%d_%H%M%S).sql 2>/dev/null || echo "PostgreSQL 备份失败或未启动"
	@echo "备份 MongoDB..."
	@docker exec common-mongodb mongodump --username ${MONGO_ROOT_USER:-admin} --password ${MONGO_ROOT_PASSWORD:-admin123} --authenticationDatabase admin --out /tmp/backup 2>/dev/null && \
	docker cp common-mongodb:/tmp/backup backups/mongodb_backup_$$(date +%Y%m%d_%H%M%S) || echo "MongoDB 备份失败或未启动"
	@echo "备份完成，文件保存在 backups 目录"

# 查看网络信息
network:
	@echo "=== 网络信息 ==="
	@docker network inspect common-network --format '{{.Name}}: {{.IPAM.Config}}'

# 拉取镜像
pull:
	$(check-docker-compose)
	@echo "拉取所有服务镜像..."
	$(DOCKER_COMPOSE) -f $(COMPOSE_FILE) pull

# 调试信息
debug:
	@echo "=== Docker Compose 检测信息 ==="
	@echo "检测到的命令: '$(DOCKER_COMPOSE)'"
	@echo ""
	@echo "=== 检查 docker compose (V2) ==="
	@docker compose version 2>&1 || echo "未安装或不可用"
	@echo ""
	@echo "=== 检查 docker-compose (V1) ==="
	@docker-compose --version 2>&1 || echo "未安装或不可用"
	@echo ""
	@echo "=== 环境信息 ==="
	@echo "PATH: $(PATH)"
	@echo ""
	@which docker 2>&1 || echo "docker 命令未找到"
	@which docker-compose 2>&1 || echo "docker-compose 命令未找到"

# 帮助信息
help:
	@echo "╔════════════════════════════════════════════════════════════╗"
	@echo "║           Common Services - Docker Compose 管理工具         ║"
	@echo "╚════════════════════════════════════════════════════════════╝"
	@echo ""
	@echo "基本命令:"
	@echo "  make init              - 初始化配置文件和目录（首次使用必执行）"
	@echo "  make up                - 启动所有服务"
	@echo "  make up SERVICE=xxx    - 启动指定服务（mysql/postgres/mongodb/redis）"
	@echo "  make down              - 停止并删除所有服务"
	@echo "  make down SERVICE=xxx  - 停止并删除指定服务"
	@echo "  make restart           - 重启所有服务"
	@echo "  make restart SERVICE=xxx - 重启指定服务"
	@echo "  make ps                - 查看服务状态"
	@echo "  make status            - 查看详细状态（包括健康检查）"
	@echo "  make logs              - 查看所有服务日志"
	@echo "  make logs SERVICE=xxx  - 查看指定服务日志"
	@echo ""
	@echo "高级命令:"
	@echo "  make exec SERVICE=xxx  - 进入指定服务容器"
	@echo "  make backup            - 备份所有数据库"
	@echo "  make network           - 查看网络信息"
	@echo "  make pull              - 拉取所有服务镜像"
	@echo "  make clean             - 停止并删除所有服务和数据卷（危险！）"
	@echo "  make debug             - 显示 Docker Compose 检测信息（调试用）"
	@echo ""
	@echo "可用服务:"
	@echo "  - mysql     (MySQL 8.0, 端口: 3306)"
	@echo "  - postgres  (PostgreSQL 16, 端口: 5432)"
	@echo "  - mongodb   (MongoDB 7, 端口: 27017)"
	@echo "  - redis     (Redis 7, 端口: 6379)"
	@echo ""
	@echo "使用示例:"
	@echo "  make init                    # 首次使用，初始化配置"
	@echo "  make up SERVICE=mysql        # 只启动 MySQL"
	@echo "  make up SERVICE=redis        # 只启动 Redis"
	@echo "  make logs SERVICE=postgres   # 查看 PostgreSQL 日志"
	@echo "  make exec SERVICE=mongodb    # 进入 MongoDB 容器"
	@echo ""
	@echo "跨机器访问:"
	@echo "  服务启动后，其他机器可通过以下方式访问："
	@echo "  - MySQL:      mysql -h <服务器IP> -P 3306 -u root -p"
	@echo "  - PostgreSQL: psql -h <服务器IP> -p 5432 -U postgres"
	@echo "  - MongoDB:    mongosh \"mongodb://admin:admin123@<服务器IP>:27017\""
	@echo "  - Redis:      redis-cli -h <服务器IP> -p 6379"
	@echo ""
	@echo "检测到的 Docker Compose 命令: $(DOCKER_COMPOSE)"
	@echo ""
	@echo "配置文件: .env（首次运行 make init 后生成）"
