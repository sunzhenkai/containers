.PHONY: up down logs ps restart help

# 自动检测 docker compose 命令版本
# Docker Compose V2 使用 "docker compose"
# Docker Compose V1 使用 "docker-compose"
DOCKER_COMPOSE := $(shell docker compose version 2>/dev/null && echo "docker compose" || echo "docker-compose")

# Docker Compose 文件路径
COMPOSE_FILE := docker-compose.yml

# 可选：指定特定服务（例如：make up SERVICE=redis）
SERVICE ?=

# 默认目标
.DEFAULT_GOAL := help

# 启动服务
up:
	@echo "使用命令: $(DOCKER_COMPOSE)"
ifdef SERVICE
	@echo "启动服务: $(SERVICE)"
	$(DOCKER_COMPOSE) -f $(COMPOSE_FILE) up -d $(SERVICE)
else
	$(DOCKER_COMPOSE) -f $(COMPOSE_FILE) up -d
endif

# 停止并删除服务
down:
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
ifdef SERVICE
	$(DOCKER_COMPOSE) -f $(COMPOSE_FILE) logs -f $(SERVICE)
else
	$(DOCKER_COMPOSE) -f $(COMPOSE_FILE) logs -f
endif

# 查看服务状态
ps:
	$(DOCKER_COMPOSE) -f $(COMPOSE_FILE) ps

# 重启服务
restart:
ifdef SERVICE
	@echo "重启服务: $(SERVICE)"
	$(DOCKER_COMPOSE) -f $(COMPOSE_FILE) restart $(SERVICE)
else
	$(DOCKER_COMPOSE) -f $(COMPOSE_FILE) restart
endif

# 帮助信息
help:
	@echo "可用的命令:"
	@echo "  make up              - 启动所有服务"
	@echo "  make up SERVICE=xxx  - 启动指定服务"
	@echo "  make down            - 停止并删除所有服务"
	@echo "  make down SERVICE=xxx- 停止并删除指定服务"
	@echo "  make restart         - 重启所有服务"
	@echo "  make restart SERVICE=xxx - 重启指定服务"
	@echo "  make logs            - 查看所有服务日志"
	@echo "  make logs SERVICE=xxx- 查看指定服务日志"
	@echo "  make ps              - 查看服务状态"
	@echo ""
	@echo "示例:"
	@echo "  make up SERVICE=redis"
	@echo "  make down SERVICE=redis"
	@echo "  make restart SERVICE=redis"
	@echo ""
	@echo "检测到的 Docker Compose 命令: $(DOCKER_COMPOSE)"
