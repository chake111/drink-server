-- 饮品店订购系统 数据库表结构
-- 数据库: drink_order

CREATE DATABASE IF NOT EXISTS drink_order DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE drink_order;

-- 用户表（微信端）
CREATE TABLE IF NOT EXISTS `user` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `openid` VARCHAR(64) NOT NULL COMMENT '微信openid',
    `nickname` VARCHAR(64) DEFAULT NULL COMMENT '昵称',
    `avatar` VARCHAR(256) DEFAULT NULL COMMENT '头像URL',
    `phone` VARCHAR(20) DEFAULT NULL COMMENT '手机号',
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_openid` (`openid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户表';

-- 管理员表
CREATE TABLE IF NOT EXISTS `admin` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `username` VARCHAR(64) NOT NULL COMMENT '用户名',
    `password` VARCHAR(128) NOT NULL COMMENT '密码（MD5加密）',
    `name` VARCHAR(64) DEFAULT NULL COMMENT '姓名',
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='管理员表';

-- 饮品表
CREATE TABLE IF NOT EXISTS `drink` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(64) NOT NULL COMMENT '饮品名称',
    `price` DECIMAL(10,2) NOT NULL COMMENT '价格',
    `image` VARCHAR(256) DEFAULT NULL COMMENT '图片URL',
    `description` VARCHAR(256) DEFAULT NULL COMMENT '描述',
    `category` VARCHAR(32) DEFAULT NULL COMMENT '分类',
    `status` TINYINT DEFAULT 1 COMMENT '状态：1起售 0停售',
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` DATETIME DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='饮品表';

-- 饮品口味表
CREATE TABLE IF NOT EXISTS `drink_flavor` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `drink_id` BIGINT NOT NULL COMMENT '饮品ID',
    `name` VARCHAR(32) NOT NULL COMMENT '口味名称',
    `value` VARCHAR(64) NOT NULL COMMENT '口味值',
    PRIMARY KEY (`id`),
    KEY `idx_drink_id` (`drink_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='饮品口味表';

-- 订单表
CREATE TABLE IF NOT EXISTS `order` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT NOT NULL COMMENT '用户ID',
    `order_no` VARCHAR(32) NOT NULL COMMENT '订单号',
    `amount` DECIMAL(10,2) NOT NULL COMMENT '订单金额',
    `status` TINYINT DEFAULT 1 COMMENT '状态：1待接单 2制作中 3待取餐 4已完成 5已取消',
    `pickup_type` VARCHAR(16) DEFAULT NULL COMMENT '取餐方式',
    `pickup_no` VARCHAR(16) DEFAULT NULL COMMENT '取餐号',
    `reject_reason` VARCHAR(128) DEFAULT NULL COMMENT '拒绝原因',
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    PRIMARY KEY (`id`),
    KEY `idx_user_id` (`user_id`),
    KEY `idx_order_no` (`order_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='订单表';

-- 订单明细表
CREATE TABLE IF NOT EXISTS `order_detail` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `order_id` BIGINT NOT NULL COMMENT '订单ID',
    `drink_id` BIGINT NOT NULL COMMENT '饮品ID',
    `drink_name` VARCHAR(64) NOT NULL COMMENT '饮品名称',
    `image` VARCHAR(256) DEFAULT NULL COMMENT '饮品图片URL',
    `spec` VARCHAR(32) DEFAULT NULL COMMENT '规格',
    `quantity` INT NOT NULL DEFAULT 1 COMMENT '数量',
    `price` DECIMAL(10,2) NOT NULL COMMENT '单价',
    PRIMARY KEY (`id`),
    KEY `idx_order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='订单明细表';
