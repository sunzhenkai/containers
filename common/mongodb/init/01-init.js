// MongoDB 初始化脚本示例
// 此文件将在 MongoDB 容器首次启动时自动执行

// 切换到 admin 数据库进行认证
db = db.getSiblingDB('admin');

// 创建应用数据库
db = db.getSiblingDB('app');

// 创建用户集合
db.createCollection('users');

// 创建索引
db.users.createIndex({ "username": 1 }, { unique: true });
db.users.createIndex({ "email": 1 }, { unique: true });
db.users.createIndex({ "created_at": 1 });

// 插入示例数据
db.users.insertMany([
    {
        username: 'admin',
        email: 'admin@example.com',
        created_at: new Date(),
        updated_at: new Date()
    },
    {
        username: 'user1',
        email: 'user1@example.com',
        created_at: new Date(),
        updated_at: new Date()
    }
]);

// 创建其他集合（示例）
db.createCollection('logs');
db.logs.createIndex({ "timestamp": 1 });
db.logs.createIndex({ "level": 1 });

print('MongoDB 初始化完成');
