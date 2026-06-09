/*
 Navicat Premium Data Transfer

 Source Server         : chake1
 Source Server Type    : MySQL
 Source Server Version : 80038
 Source Host           : localhost:3306
 Source Schema         : drink_order

 Target Server Type    : MySQL
 Target Server Version : 80038
 File Encoding         : 65001

 Date: 09/06/2026 09:30:59
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '分类名称',
  `icon` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '图标标识',
  `sort` int NULL DEFAULT 0 COMMENT '排序号（越小越靠前）',
  `status` tinyint NULL DEFAULT 1 COMMENT '状态：1 启用，0 停用',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '饮品分类表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of category
-- ----------------------------
INSERT INTO `category` VALUES (1, '经典咖啡', 'soda', 2, 1, '2026-06-05 22:32:50', '2026-06-07 23:31:19');
INSERT INTO `category` VALUES (2, '生椰系列', 'cup', 0, 1, '2026-06-05 22:32:50', '2026-06-07 23:31:19');
INSERT INTO `category` VALUES (3, '茶饮', 'fruit', 1, 1, '2026-06-05 22:32:50', '2026-06-09 09:14:46');
INSERT INTO `category` VALUES (4, '果汁冰沙', 'fruit', 3, 1, '2026-06-05 22:32:50', '2026-06-07 23:31:19');
INSERT INTO `category` VALUES (5, '轻食甜点', 'cake', 4, 1, '2026-06-05 22:32:50', '2026-06-07 23:31:19');
INSERT INTO `category` VALUES (6, '季节限定', 'seasonal', 5, 1, '2026-06-05 22:32:50', '2026-06-07 23:31:19');

-- ----------------------------
-- Table structure for drink
-- ----------------------------
DROP TABLE IF EXISTS `drink`;
CREATE TABLE `drink`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '饮品名称',
  `category_id` bigint NOT NULL COMMENT '分类ID',
  `price` decimal(10, 2) NOT NULL COMMENT '价格',
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '图片URL（OSS）',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '描述',
  `status` tinyint NULL DEFAULT 1 COMMENT '状态：1 起售，0 停售',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_category_id`(`category_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 35 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '饮品表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of drink
-- ----------------------------
INSERT INTO `drink` VALUES (1, '美式', 1, 12.00, '/images/ame.png', '经典美式，醇香浓郁', 1, '2026-06-05 22:32:50', '2026-06-09 09:14:48');
INSERT INTO `drink` VALUES (2, '拿铁', 1, 16.00, '/images/latte.png', '丝滑拿铁，奶香四溢', 1, '2026-06-05 22:32:50', '2026-06-06 12:28:00');
INSERT INTO `drink` VALUES (3, '卡布奇诺', 1, 16.00, '/images/cappuccino.png', '经典卡布，绵密奶泡', 1, '2026-06-05 22:32:50', '2026-06-06 12:28:00');
INSERT INTO `drink` VALUES (4, '摩卡', 1, 18.00, '/images/mocha.png', '巧克力风味，香甜浓郁', 1, '2026-06-05 22:32:50', '2026-06-06 12:28:00');
INSERT INTO `drink` VALUES (5, '焦糖玛奇朵', 1, 18.00, '/images/macchiato.png', '焦糖风味，层次分明', 1, '2026-06-05 22:32:50', '2026-06-06 12:28:00');
INSERT INTO `drink` VALUES (6, '澳白', 1, 17.00, '/images/flatwhite.png', '精萃浓缩，口感平衡', 1, '2026-06-05 22:32:50', '2026-06-06 12:28:00');
INSERT INTO `drink` VALUES (7, '生椰拿铁', 2, 19.90, '/images/coconut-latte.png', '爆款生椰，椰香浓郁', 1, '2026-06-05 22:32:50', '2026-06-06 13:19:20');
INSERT INTO `drink` VALUES (8, '生椰Dirty', 2, 21.00, '/images/coconut-dirty.png', '分层美学，一口惊艳', 1, '2026-06-05 22:32:50', '2026-06-06 12:28:00');
INSERT INTO `drink` VALUES (9, '椰云拿铁', 2, 22.00, '/images/coconut-cloud.png', '椰云绵密，口感升级', 1, '2026-06-05 22:32:50', '2026-06-06 12:28:00');
INSERT INTO `drink` VALUES (10, '生椰丝绒拿铁', 2, 23.00, '/images/coconut-velvet.png', '丝绒质地，椰香绵长', 1, '2026-06-05 22:32:50', '2026-06-06 12:28:00');
INSERT INTO `drink` VALUES (11, '椰青美式', 2, 15.00, '/images/coconut-ame.png', '椰青清爽，美式经典', 1, '2026-06-05 22:32:50', '2026-06-06 12:28:00');
INSERT INTO `drink` VALUES (12, '茉莉花香拿铁', 3, 16.00, '/images/jasmine-latte.png', '茉莉花香，清新怡人', 1, '2026-06-05 22:32:50', '2026-06-06 12:28:00');
INSERT INTO `drink` VALUES (13, '红茶拿铁', 3, 16.00, '/images/blacktea-latte.png', '锡兰红茶，醇厚回甘', 1, '2026-06-05 22:32:50', '2026-06-06 12:28:00');
INSERT INTO `drink` VALUES (14, '抹茶拿铁', 3, 18.00, '/images/matcha-latte.png', '日式抹茶，细腻微苦', 1, '2026-06-05 22:32:50', '2026-06-06 12:28:00');
INSERT INTO `drink` VALUES (15, '小鹿茶', 3, 12.00, '/images/deertea.png', '招牌奶茶，百搭经典', 1, '2026-06-05 22:32:50', '2026-06-06 12:28:00');
INSERT INTO `drink` VALUES (16, '桃桃乌龙', 3, 15.00, '/images/peach-oolong.png', '蜜桃果粒，乌龙回甘', 1, '2026-06-05 22:32:50', '2026-06-06 12:28:00');
INSERT INTO `drink` VALUES (17, '鲜榨橙汁', 4, 14.00, '/images/orange-juice.png', '100%鲜榨，维C满满', 1, '2026-06-05 22:32:50', '2026-06-06 12:28:00');
INSERT INTO `drink` VALUES (18, '葡萄冰萃', 4, 16.00, '/images/grape-ice.png', '冰爽葡萄，夏日必备', 1, '2026-06-05 22:32:50', '2026-06-06 12:28:00');
INSERT INTO `drink` VALUES (19, '芒果冰沙', 4, 18.00, '/images/mango-smoothie.png', '香甜芒果，绵密冰沙', 1, '2026-06-05 22:32:50', '2026-06-06 12:28:00');
INSERT INTO `drink` VALUES (20, '西瓜椰椰', 4, 15.00, '/images/watermelon.png', '西瓜清甜，椰香点缀', 1, '2026-06-05 22:32:50', '2026-06-06 12:28:00');
INSERT INTO `drink` VALUES (21, '莓果酸奶', 4, 19.00, '/images/berry-yogurt.png', '混合莓果，酸奶顺滑', 1, '2026-06-05 22:32:50', '2026-06-06 12:28:00');
INSERT INTO `drink` VALUES (22, '火腿芝士贝果', 5, 16.00, '/images/bagel-ham.png', '咸香火腿，芝士浓郁', 1, '2026-06-05 22:32:50', '2026-06-06 12:28:00');
INSERT INTO `drink` VALUES (23, '鸡肉三明治', 5, 18.00, '/images/sandwich-chicken.png', '嫩滑鸡肉，新鲜蔬菜', 1, '2026-06-05 22:32:50', '2026-06-06 12:28:00');
INSERT INTO `drink` VALUES (24, '提拉米苏', 5, 15.00, '/images/tiramisu.png', '经典意式，咖啡风味', 1, '2026-06-05 22:32:50', '2026-06-06 12:28:00');
INSERT INTO `drink` VALUES (25, '蓝莓麦芬', 5, 12.00, '/images/muffin-blueberry.png', '爆浆蓝莓，松软可口', 1, '2026-06-05 22:32:50', '2026-06-06 12:28:00');
INSERT INTO `drink` VALUES (26, '夏日西瓜拿铁', 6, 21.00, '/images/summer-watermelon.png', '夏季限定，清爽解暑', 1, '2026-06-05 22:32:50', '2026-06-06 12:28:00');
INSERT INTO `drink` VALUES (27, '桂花龙井拿铁', 6, 20.00, '/images/osmanthus-tea.png', '金秋限定，桂花飘香', 1, '2026-06-05 22:32:50', '2026-06-06 12:28:00');
INSERT INTO `drink` VALUES (28, '太妃榛果拿铁', 6, 22.00, '/images/toffee-hazelnut.png', '冬日限定，暖心回归', 1, '2026-06-05 22:32:50', '2026-06-06 12:28:00');
INSERT INTO `drink` VALUES (29, '春日樱花拿铁', 6, 20.00, '/images/sakura-latte.png', '春季限定，樱花浪漫', 1, '2026-06-05 22:32:50', '2026-06-06 12:28:00');
INSERT INTO `drink` VALUES (30, '陨石拿铁', 6, 19.90, '/images/meteor-latte.png', '黑糖风味，颜值担当', 1, '2026-06-05 22:32:50', '2026-06-06 12:28:00');

-- ----------------------------
-- Table structure for drink_flavor
-- ----------------------------
DROP TABLE IF EXISTS `drink_flavor`;
CREATE TABLE `drink_flavor`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `drink_id` bigint NOT NULL COMMENT '饮品ID',
  `name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '口味名称（如：甜度、温度）',
  `value` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '口味选项（逗号分隔，如：无糖,半糖,全糖）',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_drink_id`(`drink_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 71 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '饮品口味表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of drink_flavor
-- ----------------------------
INSERT INTO `drink_flavor` VALUES (3, 2, '甜度', '无糖,少糖,半糖,标准糖');
INSERT INTO `drink_flavor` VALUES (4, 2, '温度', '冰,去冰,热');
INSERT INTO `drink_flavor` VALUES (5, 3, '甜度', '无糖,少糖,半糖,标准糖');
INSERT INTO `drink_flavor` VALUES (6, 3, '温度', '冰,热');
INSERT INTO `drink_flavor` VALUES (7, 4, '甜度', '少糖,半糖,标准糖');
INSERT INTO `drink_flavor` VALUES (8, 4, '温度', '冰,热');
INSERT INTO `drink_flavor` VALUES (9, 5, '甜度', '少糖,半糖,标准糖');
INSERT INTO `drink_flavor` VALUES (10, 5, '温度', '冰,热');
INSERT INTO `drink_flavor` VALUES (11, 6, '甜度', '无糖,少糖,半糖');
INSERT INTO `drink_flavor` VALUES (12, 6, '温度', '冰,热');
INSERT INTO `drink_flavor` VALUES (13, 7, '甜度', '无糖,少糖,半糖');
INSERT INTO `drink_flavor` VALUES (14, 7, '温度', '冰,去冰');
INSERT INTO `drink_flavor` VALUES (15, 8, '甜度', '无糖,少糖');
INSERT INTO `drink_flavor` VALUES (16, 8, '温度', '冰');
INSERT INTO `drink_flavor` VALUES (17, 9, '甜度', '少糖,半糖');
INSERT INTO `drink_flavor` VALUES (18, 9, '温度', '冰,去冰');
INSERT INTO `drink_flavor` VALUES (19, 10, '甜度', '少糖,半糖');
INSERT INTO `drink_flavor` VALUES (20, 10, '温度', '冰,去冰');
INSERT INTO `drink_flavor` VALUES (21, 11, '甜度', '无糖,少糖');
INSERT INTO `drink_flavor` VALUES (22, 11, '温度', '冰,去冰');
INSERT INTO `drink_flavor` VALUES (23, 12, '甜度', '无糖,少糖,半糖,标准糖');
INSERT INTO `drink_flavor` VALUES (24, 12, '温度', '冰,去冰,热');
INSERT INTO `drink_flavor` VALUES (25, 13, '甜度', '无糖,少糖,半糖,标准糖');
INSERT INTO `drink_flavor` VALUES (26, 13, '温度', '冰,去冰,热');
INSERT INTO `drink_flavor` VALUES (27, 14, '甜度', '无糖,少糖,半糖');
INSERT INTO `drink_flavor` VALUES (28, 14, '温度', '冰,热');
INSERT INTO `drink_flavor` VALUES (29, 15, '甜度', '半糖,标准糖,多糖');
INSERT INTO `drink_flavor` VALUES (30, 15, '温度', '冰,去冰,热');
INSERT INTO `drink_flavor` VALUES (31, 16, '甜度', '少糖,半糖,标准糖');
INSERT INTO `drink_flavor` VALUES (32, 16, '温度', '冰,去冰');
INSERT INTO `drink_flavor` VALUES (33, 17, '甜度', '无糖,少糖');
INSERT INTO `drink_flavor` VALUES (34, 17, '温度', '冰,去冰');
INSERT INTO `drink_flavor` VALUES (35, 18, '甜度', '少糖,半糖');
INSERT INTO `drink_flavor` VALUES (36, 18, '温度', '冰');
INSERT INTO `drink_flavor` VALUES (37, 19, '甜度', '少糖,半糖,标准糖');
INSERT INTO `drink_flavor` VALUES (38, 19, '温度', '冰');
INSERT INTO `drink_flavor` VALUES (39, 20, '甜度', '少糖,半糖');
INSERT INTO `drink_flavor` VALUES (40, 20, '温度', '冰,去冰');
INSERT INTO `drink_flavor` VALUES (41, 21, '甜度', '少糖,半糖');
INSERT INTO `drink_flavor` VALUES (42, 21, '温度', '冰');
INSERT INTO `drink_flavor` VALUES (43, 26, '甜度', '少糖,半糖');
INSERT INTO `drink_flavor` VALUES (44, 26, '温度', '冰,去冰');
INSERT INTO `drink_flavor` VALUES (45, 27, '甜度', '无糖,少糖,半糖');
INSERT INTO `drink_flavor` VALUES (46, 27, '温度', '冰,热');
INSERT INTO `drink_flavor` VALUES (47, 28, '甜度', '少糖,半糖,标准糖');
INSERT INTO `drink_flavor` VALUES (48, 28, '温度', '热');
INSERT INTO `drink_flavor` VALUES (49, 29, '甜度', '少糖,半糖');
INSERT INTO `drink_flavor` VALUES (50, 29, '温度', '冰,热');
INSERT INTO `drink_flavor` VALUES (51, 30, '甜度', '少糖,半糖');
INSERT INTO `drink_flavor` VALUES (52, 30, '温度', '冰,去冰');
INSERT INTO `drink_flavor` VALUES (67, 1, '甜度', '无糖,少糖,半糖');
INSERT INTO `drink_flavor` VALUES (68, 1, '温度', '冰,热');

-- ----------------------------
-- Table structure for employee
-- ----------------------------
DROP TABLE IF EXISTS `employee`;
CREATE TABLE `employee`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '姓名',
  `account` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '登录账号',
  `password` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '密码（MD5加密）',
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '手机号',
  `role` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '岗位：店长/咖啡师/茶艺师/收银员',
  `status` tinyint NULL DEFAULT 1 COMMENT '状态：1 启用，0 禁用',
  `note` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_account`(`account` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '员工表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of employee
-- ----------------------------
INSERT INTO `employee` VALUES (1, '管理员', 'admin', 'e10adc3949ba59abbe56e057f20f883e', '13900139001', '店长', 1, '系统管理员', '2026-06-05 22:32:50');
INSERT INTO `employee` VALUES (2, '张伟', 'zhangwei', 'e10adc3949ba59abbe56e057f20f883e', '13900139002', '店长', 1, '门店负责人', '2026-06-05 22:32:50');
INSERT INTO `employee` VALUES (3, '李娜', 'lina', 'e10adc3949ba59abbe56e057f20f883e', '13900139003', '咖啡师', 1, '高级咖啡师', '2026-06-05 22:32:50');
INSERT INTO `employee` VALUES (4, '王芳', 'wangfang', 'e10adc3949ba59abbe56e057f20f883e', '13900139004', '咖啡师', 1, NULL, '2026-06-05 22:32:50');
INSERT INTO `employee` VALUES (5, '刘洋', 'liuyang', 'e10adc3949ba59abbe56e057f20f883e', '13900139005', '茶艺师', 1, '负责茶饮系列', '2026-06-05 22:32:50');
INSERT INTO `employee` VALUES (6, '陈静', 'chenjing', 'e10adc3949ba59abbe56e057f20f883e', '13900139006', '收银员', 1, NULL, '2026-06-05 22:32:50');

-- ----------------------------
-- Table structure for order
-- ----------------------------
DROP TABLE IF EXISTS `order`;
CREATE TABLE `order`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` bigint NOT NULL COMMENT '下单用户ID',
  `order_no` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '订单号',
  `amount` decimal(10, 2) NOT NULL COMMENT '订单金额',
  `status` tinyint NULL DEFAULT 1 COMMENT '状态：1待接单 2制作中 3待取餐\r\n  4已完成 5已取消',
  `pickup_type` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '取餐方式：自取/外送',
  `pickup_no` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '取餐号',
  `reject_reason` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '拒绝原因',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '下单时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_order_no`(`order_no` ASC) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 120 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '订单表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of order
-- ----------------------------
INSERT INTO `order` VALUES (1, 12, 'LK20260501001', 35.90, 4, '自取', 'A01', NULL, '2026-05-01 08:15:00');
INSERT INTO `order` VALUES (2, 3, 'LK20260501002', 19.90, 4, '自取', 'A02', NULL, '2026-05-01 08:32:00');
INSERT INTO `order` VALUES (3, 45, 'LK20260501003', 16.00, 4, '外送', NULL, NULL, '2026-05-01 09:05:00');
INSERT INTO `order` VALUES (4, 7, 'LK20260501004', 35.00, 4, '自取', 'A03', NULL, '2026-05-01 09:22:00');
INSERT INTO `order` VALUES (5, 28, 'LK20260501005', 13.00, 4, '自取', 'A04', NULL, '2026-05-01 10:01:00');
INSERT INTO `order` VALUES (6, 15, 'LK20260502001', 22.00, 4, '自取', 'A05', NULL, '2026-05-02 07:45:00');
INSERT INTO `order` VALUES (7, 31, 'LK20260502002', 18.00, 4, '外送', NULL, NULL, '2026-05-02 08:10:00');
INSERT INTO `order` VALUES (8, 2, 'LK20260502003', 15.00, 4, '自取', 'A06', NULL, '2026-05-02 08:55:00');
INSERT INTO `order` VALUES (9, 48, 'LK20260502004', 21.00, 4, '自取', 'A07', NULL, '2026-05-02 12:30:00');
INSERT INTO `order` VALUES (10, 19, 'LK20260502005', 16.00, 5, '自取', NULL, NULL, '2026-05-02 14:20:00');
INSERT INTO `order` VALUES (11, 5, 'LK20260503001', 19.90, 4, '自取', 'A08', NULL, '2026-05-03 08:05:00');
INSERT INTO `order` VALUES (12, 22, 'LK20260503002', 17.00, 4, '自取', 'A09', NULL, '2026-05-03 08:45:00');
INSERT INTO `order` VALUES (13, 38, 'LK20260503003', 23.00, 4, '外送', NULL, NULL, '2026-05-03 09:30:00');
INSERT INTO `order` VALUES (14, 11, 'LK20260503004', 16.00, 4, '自取', 'A10', NULL, '2026-05-03 10:15:00');
INSERT INTO `order` VALUES (15, 42, 'LK20260503005', 18.00, 5, '自取', NULL, NULL, '2026-05-03 11:00:00');
INSERT INTO `order` VALUES (16, 8, 'LK20260504001', 14.00, 4, '自取', 'A11', NULL, '2026-05-04 07:30:00');
INSERT INTO `order` VALUES (17, 25, 'LK20260504002', 22.00, 4, '自取', 'A12', NULL, '2026-05-04 08:20:00');
INSERT INTO `order` VALUES (18, 50, 'LK20260504003', 16.00, 4, '外送', NULL, NULL, '2026-05-04 09:00:00');
INSERT INTO `order` VALUES (19, 14, 'LK20260504004', 19.90, 4, '自取', 'A13', NULL, '2026-05-04 12:45:00');
INSERT INTO `order` VALUES (20, 33, 'LK20260504005', 13.00, 4, '自取', 'A14', NULL, '2026-05-04 15:30:00');
INSERT INTO `order` VALUES (21, 6, 'LK20260505001', 21.00, 4, '自取', 'A15', NULL, '2026-05-05 08:10:00');
INSERT INTO `order` VALUES (22, 29, 'LK20260505002', 16.00, 4, '自取', 'A16', NULL, '2026-05-05 09:25:00');
INSERT INTO `order` VALUES (23, 17, 'LK20260505003', 18.00, 4, '外送', NULL, NULL, '2026-05-05 10:40:00');
INSERT INTO `order` VALUES (24, 46, 'LK20260505004', 15.00, 5, '自取', NULL, NULL, '2026-05-05 13:15:00');
INSERT INTO `order` VALUES (25, 1, 'LK20260505005', 22.00, 4, '自取', 'A17', NULL, '2026-05-05 14:50:00');
INSERT INTO `order` VALUES (26, 36, 'LK20260506001', 19.90, 4, '自取', 'A18', NULL, '2026-05-06 07:55:00');
INSERT INTO `order` VALUES (27, 20, 'LK20260506002', 16.00, 4, '自取', 'A19', NULL, '2026-05-06 08:40:00');
INSERT INTO `order` VALUES (28, 43, 'LK20260506003', 13.00, 4, '外送', NULL, NULL, '2026-05-06 09:15:00');
INSERT INTO `order` VALUES (29, 9, 'LK20260506004', 18.00, 4, '自取', 'A20', NULL, '2026-05-06 12:00:00');
INSERT INTO `order` VALUES (30, 27, 'LK20260506005', 22.00, 4, '自取', 'A21', NULL, '2026-05-06 16:20:00');
INSERT INTO `order` VALUES (31, 13, 'LK20260507001', 16.00, 4, '自取', 'A22', NULL, '2026-05-07 08:00:00');
INSERT INTO `order` VALUES (32, 39, 'LK20260507002', 21.00, 4, '自取', 'A23', NULL, '2026-05-07 09:30:00');
INSERT INTO `order` VALUES (33, 4, 'LK20260507003', 19.90, 4, '外送', NULL, NULL, '2026-05-07 10:45:00');
INSERT INTO `order` VALUES (34, 24, 'LK20260507004', 14.00, 5, '自取', NULL, NULL, '2026-05-07 11:30:00');
INSERT INTO `order` VALUES (35, 47, 'LK20260507005', 18.00, 4, '自取', 'A24', NULL, '2026-05-07 14:00:00');
INSERT INTO `order` VALUES (36, 10, 'LK20260508001', 22.00, 4, '自取', 'A25', NULL, '2026-05-08 07:40:00');
INSERT INTO `order` VALUES (37, 30, 'LK20260508002', 16.00, 4, '自取', 'A26', NULL, '2026-05-08 08:55:00');
INSERT INTO `order` VALUES (38, 16, 'LK20260508003', 13.00, 4, '外送', NULL, NULL, '2026-05-08 09:20:00');
INSERT INTO `order` VALUES (39, 41, 'LK20260508004', 21.00, 4, '自取', 'A27', NULL, '2026-05-08 12:10:00');
INSERT INTO `order` VALUES (40, 35, 'LK20260508005', 15.00, 4, '自取', 'A28', NULL, '2026-05-08 15:45:00');
INSERT INTO `order` VALUES (41, 21, 'LK20260509001', 19.90, 4, '自取', 'A29', NULL, '2026-05-09 08:15:00');
INSERT INTO `order` VALUES (42, 44, 'LK20260509002', 16.00, 4, '自取', 'A30', NULL, '2026-05-09 09:50:00');
INSERT INTO `order` VALUES (43, 7, 'LK20260509003', 18.00, 4, '外送', NULL, NULL, '2026-05-09 10:25:00');
INSERT INTO `order` VALUES (44, 26, 'LK20260509004', 22.00, 5, '自取', NULL, NULL, '2026-05-09 13:40:00');
INSERT INTO `order` VALUES (45, 18, 'LK20260509005', 14.00, 4, '自取', 'A31', NULL, '2026-05-09 16:10:00');
INSERT INTO `order` VALUES (46, 34, 'LK20260510001', 16.00, 4, '自取', 'A32', NULL, '2026-05-10 07:50:00');
INSERT INTO `order` VALUES (47, 2, 'LK20260510002', 21.00, 4, '自取', 'A33', NULL, '2026-05-10 08:35:00');
INSERT INTO `order` VALUES (48, 49, 'LK20260510003', 19.90, 4, '外送', NULL, NULL, '2026-05-10 09:45:00');
INSERT INTO `order` VALUES (49, 12, 'LK20260510004', 13.00, 4, '自取', 'A34', NULL, '2026-05-10 12:30:00');
INSERT INTO `order` VALUES (50, 37, 'LK20260510005', 18.00, 4, '自取', 'A35', NULL, '2026-05-10 14:15:00');
INSERT INTO `order` VALUES (51, 23, 'LK20260511001', 22.00, 4, '自取', 'A36', NULL, '2026-05-11 08:05:00');
INSERT INTO `order` VALUES (52, 40, 'LK20260511002', 16.00, 4, '自取', 'A37', NULL, '2026-05-11 09:20:00');
INSERT INTO `order` VALUES (53, 8, 'LK20260511003', 15.00, 4, '外送', NULL, NULL, '2026-05-11 10:55:00');
INSERT INTO `order` VALUES (54, 32, 'LK20260511004', 21.00, 4, '自取', 'A38', NULL, '2026-05-11 13:10:00');
INSERT INTO `order` VALUES (55, 15, 'LK20260511005', 19.90, 5, '自取', NULL, NULL, '2026-05-11 15:40:00');
INSERT INTO `order` VALUES (56, 48, 'LK20260512001', 16.00, 4, '自取', 'A39', NULL, '2026-05-12 07:35:00');
INSERT INTO `order` VALUES (57, 11, 'LK20260512002', 18.00, 4, '自取', 'A40', NULL, '2026-05-12 08:50:00');
INSERT INTO `order` VALUES (58, 28, 'LK20260512003', 14.00, 4, '外送', NULL, NULL, '2026-05-12 09:35:00');
INSERT INTO `order` VALUES (59, 5, 'LK20260512004', 22.00, 4, '自取', 'A41', NULL, '2026-05-12 12:20:00');
INSERT INTO `order` VALUES (60, 22, 'LK20260512005', 13.00, 4, '自取', 'A42', NULL, '2026-05-12 16:00:00');
INSERT INTO `order` VALUES (61, 38, 'LK20260513001', 19.90, 4, '自取', 'A43', NULL, '2026-05-13 08:10:00');
INSERT INTO `order` VALUES (62, 14, 'LK20260513002', 21.00, 4, '自取', 'A44', NULL, '2026-05-13 09:40:00');
INSERT INTO `order` VALUES (63, 45, 'LK20260513003', 16.00, 4, '外送', NULL, NULL, '2026-05-13 10:15:00');
INSERT INTO `order` VALUES (64, 6, 'LK20260513004', 18.00, 5, '自取', NULL, NULL, '2026-05-13 13:25:00');
INSERT INTO `order` VALUES (65, 31, 'LK20260513005', 15.00, 4, '自取', 'A45', NULL, '2026-05-13 15:55:00');
INSERT INTO `order` VALUES (66, 19, 'LK20260514001', 22.00, 4, '自取', 'A46', NULL, '2026-05-14 07:45:00');
INSERT INTO `order` VALUES (67, 42, 'LK20260514002', 16.00, 4, '自取', 'A47', NULL, '2026-05-14 08:30:00');
INSERT INTO `order` VALUES (68, 9, 'LK20260514003', 13.00, 4, '外送', NULL, NULL, '2026-05-14 09:55:00');
INSERT INTO `order` VALUES (69, 25, 'LK20260514004', 21.00, 4, '自取', 'A48', NULL, '2026-05-14 12:40:00');
INSERT INTO `order` VALUES (70, 50, 'LK20260514005', 19.90, 4, '自取', 'A49', NULL, '2026-05-14 16:30:00');
INSERT INTO `order` VALUES (71, 3, 'LK20260515001', 16.00, 4, '自取', 'A50', NULL, '2026-05-15 08:20:00');
INSERT INTO `order` VALUES (72, 36, 'LK20260515002', 18.00, 4, '自取', 'A51', NULL, '2026-05-15 09:10:00');
INSERT INTO `order` VALUES (73, 17, 'LK20260515003', 22.00, 4, '外送', NULL, NULL, '2026-05-15 10:30:00');
INSERT INTO `order` VALUES (74, 44, 'LK20260515004', 14.00, 4, '自取', 'A52', NULL, '2026-05-15 13:50:00');
INSERT INTO `order` VALUES (75, 29, 'LK20260515005', 15.00, 5, '自取', NULL, NULL, '2026-05-15 15:20:00');
INSERT INTO `order` VALUES (76, 13, 'LK20260516001', 21.00, 4, '自取', 'A53', NULL, '2026-05-16 07:55:00');
INSERT INTO `order` VALUES (77, 20, 'LK20260516002', 19.90, 4, '自取', 'A54', NULL, '2026-05-16 08:45:00');
INSERT INTO `order` VALUES (78, 47, 'LK20260516003', 16.00, 4, '外送', NULL, NULL, '2026-05-16 09:25:00');
INSERT INTO `order` VALUES (79, 34, 'LK20260516004', 13.00, 4, '自取', 'A55', NULL, '2026-05-16 12:15:00');
INSERT INTO `order` VALUES (80, 1, 'LK20260516005', 18.00, 4, '自取', 'A56', NULL, '2026-05-16 14:45:00');
INSERT INTO `order` VALUES (81, 26, 'LK20260517001', 22.00, 4, '自取', 'A57', NULL, '2026-05-17 08:00:00');
INSERT INTO `order` VALUES (82, 41, 'LK20260517002', 16.00, 4, '自取', 'A58', NULL, '2026-05-17 09:35:00');
INSERT INTO `order` VALUES (83, 10, 'LK20260517003', 19.90, 4, '外送', NULL, NULL, '2026-05-17 10:50:00');
INSERT INTO `order` VALUES (84, 33, 'LK20260517004', 21.00, 4, '自取', 'A59', NULL, '2026-05-17 13:05:00');
INSERT INTO `order` VALUES (85, 48, 'LK20260517005', 15.00, 5, '自取', NULL, NULL, '2026-05-17 15:35:00');
INSERT INTO `order` VALUES (86, 7, 'LK20260518001', 16.00, 4, '自取', 'A60', NULL, '2026-05-18 08:25:00');
INSERT INTO `order` VALUES (87, 39, 'LK20260518002', 18.00, 4, '自取', 'A61', NULL, '2026-05-18 09:15:00');
INSERT INTO `order` VALUES (88, 22, 'LK20260518003', 22.00, 4, '外送', NULL, NULL, '2026-05-18 10:40:00');
INSERT INTO `order` VALUES (89, 15, 'LK20260518004', 14.00, 4, '自取', 'A62', NULL, '2026-05-18 12:55:00');
INSERT INTO `order` VALUES (90, 4, 'LK20260518005', 21.00, 4, '自取', 'A63', NULL, '2026-05-18 16:15:00');
INSERT INTO `order` VALUES (91, 30, 'LK20260519001', 19.90, 4, '自取', 'A64', NULL, '2026-05-19 07:40:00');
INSERT INTO `order` VALUES (92, 46, 'LK20260519002', 16.00, 4, '自取', 'A65', NULL, '2026-05-19 08:55:00');
INSERT INTO `order` VALUES (93, 18, 'LK20260519003', 13.00, 4, '外送', NULL, NULL, '2026-05-19 09:30:00');
INSERT INTO `order` VALUES (94, 35, 'LK20260519004', 18.00, 4, '自取', 'A66', NULL, '2026-05-19 12:25:00');
INSERT INTO `order` VALUES (95, 12, 'LK20260519005', 15.00, 4, '自取', 'A67', NULL, '2026-05-19 14:50:00');
INSERT INTO `order` VALUES (96, 27, 'LK20260520001', 22.00, 3, '自取', 'A68', NULL, '2026-05-20 08:10:00');
INSERT INTO `order` VALUES (97, 43, 'LK20260520002', 16.00, 3, '自取', 'A69', NULL, '2026-05-20 09:20:00');
INSERT INTO `order` VALUES (98, 8, 'LK20260520003', 21.00, 2, '外送', NULL, NULL, '2026-05-20 10:05:00');
INSERT INTO `order` VALUES (99, 24, 'LK20260520004', 19.90, 5, '自取', NULL, '111111', '2026-05-20 12:35:00');
INSERT INTO `order` VALUES (100, 16, 'LK20260520005', 14.00, 5, '自取', NULL, NULL, '2026-05-20 15:10:00');
INSERT INTO `order` VALUES (101, 2, '20260605001', 52.00, 4, '自取', 'B01', NULL, '2026-06-05 22:34:15');
INSERT INTO `order` VALUES (102, 1, '20260605002', 18.00, 4, '自取', 'C02', NULL, '2026-06-05 22:57:46');
INSERT INTO `order` VALUES (103, 1, '20260606001', 19.90, 4, '自取', 'B01', NULL, '2026-06-06 13:06:50');
INSERT INTO `order` VALUES (104, 1, '202606071128165313', 61.90, 4, '自取', 'A68', NULL, '2026-06-07 11:28:16');
INSERT INTO `order` VALUES (105, 1, '202606071130309357', 21.00, 5, '自取', 'E06', '11111', '2026-06-07 11:30:30');
INSERT INTO `order` VALUES (106, 1, '202606071130521781', 69.00, 4, '自取', 'S75', NULL, '2026-06-07 11:30:52');
INSERT INTO `order` VALUES (107, 19, '202606071150569828', 20.00, 4, '自取', 'H01', NULL, '2026-06-07 11:50:56');
INSERT INTO `order` VALUES (108, 19, '202606071319574069', 19.90, 4, '自取', 'J53', NULL, '2026-06-07 13:19:57');
INSERT INTO `order` VALUES (109, 19, '202606071320158116', 21.00, 4, '自取', 'L63', NULL, '2026-06-07 13:20:15');
INSERT INTO `order` VALUES (110, 19, '202606071321539426', 22.00, 4, '自取', 'W23', NULL, '2026-06-07 13:21:53');
INSERT INTO `order` VALUES (111, 19, '202606071342264675', 23.00, 4, '自取', 'K61', NULL, '2026-06-07 13:42:26');
INSERT INTO `order` VALUES (112, 51, '202606071912031285', 39.80, 4, '自取', 'U05', NULL, '2026-06-07 19:12:03');
INSERT INTO `order` VALUES (113, 51, '202606071920281147', 19.90, 1, '自取', 'X12', NULL, '2026-06-07 19:20:28');
INSERT INTO `order` VALUES (114, 51, '202606071927108009', 22.00, 2, '自取', 'X45', NULL, '2026-06-07 19:27:10');
INSERT INTO `order` VALUES (115, 51, '202606071927109352', 22.00, 1, '自取', 'Q09', NULL, '2026-06-07 19:27:10');
INSERT INTO `order` VALUES (116, 51, '202606072009453006', 16.00, 1, '自取', 'Q01', NULL, '2026-06-07 20:09:45');
INSERT INTO `order` VALUES (117, 51, '202606072010082590', 14.00, 1, '自取', 'I35', NULL, '2026-06-07 20:10:08');
INSERT INTO `order` VALUES (118, 51, '202606072015098919', 16.00, 2, '自取', 'O64', NULL, '2026-06-07 20:15:09');
INSERT INTO `order` VALUES (119, 51, '202606072044209317', 30.00, 3, '自取', 'R34', NULL, '2026-06-07 20:44:20');

-- ----------------------------
-- Table structure for order_detail
-- ----------------------------
DROP TABLE IF EXISTS `order_detail`;
CREATE TABLE `order_detail`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `order_id` bigint NOT NULL COMMENT '订单ID',
  `drink_id` bigint NOT NULL COMMENT '饮品ID',
  `drink_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '饮品名称（冗余快照）',
  `image` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '饮品图片URL',
  `spec` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '规格（如：全糖/冰）',
  `quantity` int NOT NULL COMMENT '数量',
  `price` decimal(10, 2) NOT NULL COMMENT '单价',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_order_id`(`order_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 126 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '订单明细表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of order_detail
-- ----------------------------
INSERT INTO `order_detail` VALUES (1, 1, 7, '生椰拿铁', '/images/coconut-latte.png', '少糖/冰', 1, 19.90);
INSERT INTO `order_detail` VALUES (2, 1, 13, '红茶拿铁', '/images/blacktea-latte.png', '半糖/热', 1, 16.00);
INSERT INTO `order_detail` VALUES (3, 2, 7, '生椰拿铁', '/images/coconut-latte.png', '无糖/冰', 1, 19.90);
INSERT INTO `order_detail` VALUES (4, 3, 2, '拿铁', '/images/latte.png', '少糖/热', 1, 16.00);
INSERT INTO `order_detail` VALUES (5, 4, 1, '美式', '/images/ame.png', '无糖/冰', 1, 13.00);
INSERT INTO `order_detail` VALUES (6, 4, 9, '椰云拿铁', '/images/coconut-cloud.png', '少糖/冰', 1, 22.00);
INSERT INTO `order_detail` VALUES (7, 5, 1, '美式', '/images/ame.png', '无糖/热', 1, 13.00);
INSERT INTO `order_detail` VALUES (8, 6, 9, '椰云拿铁', '/images/coconut-cloud.png', '半糖/冰', 1, 22.00);
INSERT INTO `order_detail` VALUES (9, 7, 4, '摩卡', '/images/mocha.png', '少糖/热', 1, 18.00);
INSERT INTO `order_detail` VALUES (10, 8, 16, '桃桃乌龙', '/images/peach-oolong.png', '半糖/冰', 1, 15.00);
INSERT INTO `order_detail` VALUES (11, 9, 8, '生椰Dirty', '/images/coconut-dirty.png', '无糖/冰', 1, 21.00);
INSERT INTO `order_detail` VALUES (12, 10, 2, '拿铁', '/images/latte.png', '半糖/热', 1, 16.00);
INSERT INTO `order_detail` VALUES (13, 11, 7, '生椰拿铁', '/images/coconut-latte.png', '少糖/冰', 1, 19.90);
INSERT INTO `order_detail` VALUES (14, 12, 6, '澳白', '/images/flatwhite.png', '无糖/热', 1, 17.00);
INSERT INTO `order_detail` VALUES (15, 13, 10, '生椰丝绒拿铁', '/images/coconut-velvet.png', '少糖/冰', 1, 23.00);
INSERT INTO `order_detail` VALUES (16, 14, 14, '抹茶拿铁', '/images/matcha-latte.png', '少糖/热', 1, 18.00);
INSERT INTO `order_detail` VALUES (17, 15, 3, '卡布奇诺', '/images/cappuccino.png', '半糖/热', 1, 18.00);
INSERT INTO `order_detail` VALUES (18, 16, 17, '鲜榨橙汁', '/images/orange-juice.png', '少糖/冰', 1, 14.00);
INSERT INTO `order_detail` VALUES (19, 17, 9, '椰云拿铁', '/images/coconut-cloud.png', '少糖/冰', 1, 22.00);
INSERT INTO `order_detail` VALUES (20, 18, 2, '拿铁', '/images/latte.png', '无糖/热', 1, 16.00);
INSERT INTO `order_detail` VALUES (21, 19, 7, '生椰拿铁', '/images/coconut-latte.png', '无糖/冰', 1, 19.90);
INSERT INTO `order_detail` VALUES (22, 20, 1, '美式', '/images/ame.png', '无糖/冰', 1, 13.00);
INSERT INTO `order_detail` VALUES (23, 21, 8, '生椰Dirty', '/images/coconut-dirty.png', '少糖/冰', 1, 21.00);
INSERT INTO `order_detail` VALUES (24, 22, 13, '红茶拿铁', '/images/blacktea-latte.png', '半糖/热', 1, 16.00);
INSERT INTO `order_detail` VALUES (25, 23, 5, '焦糖玛奇朵', '/images/macchiato.png', '少糖/热', 1, 18.00);
INSERT INTO `order_detail` VALUES (26, 24, 16, '桃桃乌龙', '/images/peach-oolong.png', '标准糖/冰', 1, 15.00);
INSERT INTO `order_detail` VALUES (27, 25, 9, '椰云拿铁', '/images/coconut-cloud.png', '半糖/冰', 1, 22.00);
INSERT INTO `order_detail` VALUES (28, 26, 7, '生椰拿铁', '/images/coconut-latte.png', '少糖/冰', 1, 19.90);
INSERT INTO `order_detail` VALUES (29, 27, 12, '茉莉花香拿铁', '/images/jasmine-latte.png', '少糖/热', 1, 16.00);
INSERT INTO `order_detail` VALUES (30, 28, 1, '美式', '/images/ame.png', '无糖/热', 1, 13.00);
INSERT INTO `order_detail` VALUES (31, 29, 3, '卡布奇诺', '/images/cappuccino.png', '无糖/热', 1, 18.00);
INSERT INTO `order_detail` VALUES (32, 30, 9, '椰云拿铁', '/images/coconut-cloud.png', '少糖/冰', 1, 22.00);
INSERT INTO `order_detail` VALUES (33, 31, 2, '拿铁', '/images/latte.png', '少糖/热', 1, 16.00);
INSERT INTO `order_detail` VALUES (34, 32, 8, '生椰Dirty', '/images/coconut-dirty.png', '无糖/冰', 1, 21.00);
INSERT INTO `order_detail` VALUES (35, 33, 7, '生椰拿铁', '/images/coconut-latte.png', '无糖/冰', 1, 19.90);
INSERT INTO `order_detail` VALUES (36, 34, 17, '鲜榨橙汁', '/images/orange-juice.png', '少糖/冰', 1, 14.00);
INSERT INTO `order_detail` VALUES (37, 35, 4, '摩卡', '/images/mocha.png', '半糖/热', 1, 18.00);
INSERT INTO `order_detail` VALUES (38, 36, 9, '椰云拿铁', '/images/coconut-cloud.png', '半糖/冰', 1, 22.00);
INSERT INTO `order_detail` VALUES (39, 37, 14, '抹茶拿铁', '/images/matcha-latte.png', '少糖/热', 1, 16.00);
INSERT INTO `order_detail` VALUES (40, 38, 1, '美式', '/images/ame.png', '无糖/冰', 1, 13.00);
INSERT INTO `order_detail` VALUES (41, 39, 8, '生椰Dirty', '/images/coconut-dirty.png', '少糖/冰', 1, 21.00);
INSERT INTO `order_detail` VALUES (42, 40, 16, '桃桃乌龙', '/images/peach-oolong.png', '半糖/冰', 1, 15.00);
INSERT INTO `order_detail` VALUES (43, 41, 7, '生椰拿铁', '/images/coconut-latte.png', '少糖/冰', 1, 19.90);
INSERT INTO `order_detail` VALUES (44, 42, 2, '拿铁', '/images/latte.png', '无糖/热', 1, 16.00);
INSERT INTO `order_detail` VALUES (45, 43, 5, '焦糖玛奇朵', '/images/macchiato.png', '少糖/热', 1, 18.00);
INSERT INTO `order_detail` VALUES (46, 44, 9, '椰云拿铁', '/images/coconut-cloud.png', '少糖/冰', 1, 22.00);
INSERT INTO `order_detail` VALUES (47, 45, 17, '鲜榨橙汁', '/images/orange-juice.png', '无糖/冰', 1, 14.00);
INSERT INTO `order_detail` VALUES (48, 46, 13, '红茶拿铁', '/images/blacktea-latte.png', '半糖/热', 1, 16.00);
INSERT INTO `order_detail` VALUES (49, 47, 8, '生椰Dirty', '/images/coconut-dirty.png', '无糖/冰', 1, 21.00);
INSERT INTO `order_detail` VALUES (50, 48, 7, '生椰拿铁', '/images/coconut-latte.png', '无糖/冰', 1, 19.90);
INSERT INTO `order_detail` VALUES (51, 49, 1, '美式', '/images/ame.png', '无糖/热', 1, 13.00);
INSERT INTO `order_detail` VALUES (52, 50, 3, '卡布奇诺', '/images/cappuccino.png', '少糖/热', 1, 18.00);
INSERT INTO `order_detail` VALUES (53, 51, 9, '椰云拿铁', '/images/coconut-cloud.png', '半糖/冰', 1, 22.00);
INSERT INTO `order_detail` VALUES (54, 52, 6, '澳白', '/images/flatwhite.png', '无糖/热', 1, 16.00);
INSERT INTO `order_detail` VALUES (55, 53, 18, '葡萄冰萃', '/images/grape-ice.png', '少糖/冰', 1, 15.00);
INSERT INTO `order_detail` VALUES (56, 54, 8, '生椰Dirty', '/images/coconut-dirty.png', '少糖/冰', 1, 21.00);
INSERT INTO `order_detail` VALUES (57, 55, 7, '生椰拿铁', '/images/coconut-latte.png', '无糖/冰', 1, 19.90);
INSERT INTO `order_detail` VALUES (58, 56, 2, '拿铁', '/images/latte.png', '少糖/热', 1, 16.00);
INSERT INTO `order_detail` VALUES (59, 57, 4, '摩卡', '/images/mocha.png', '半糖/热', 1, 18.00);
INSERT INTO `order_detail` VALUES (60, 58, 17, '鲜榨橙汁', '/images/orange-juice.png', '无糖/冰', 1, 14.00);
INSERT INTO `order_detail` VALUES (61, 59, 9, '椰云拿铁', '/images/coconut-cloud.png', '少糖/冰', 1, 22.00);
INSERT INTO `order_detail` VALUES (62, 60, 1, '美式', '/images/ame.png', '无糖/冰', 1, 13.00);
INSERT INTO `order_detail` VALUES (63, 61, 7, '生椰拿铁', '/images/coconut-latte.png', '少糖/冰', 1, 19.90);
INSERT INTO `order_detail` VALUES (64, 62, 8, '生椰Dirty', '/images/coconut-dirty.png', '无糖/冰', 1, 21.00);
INSERT INTO `order_detail` VALUES (65, 63, 12, '茉莉花香拿铁', '/images/jasmine-latte.png', '少糖/热', 1, 16.00);
INSERT INTO `order_detail` VALUES (66, 64, 5, '焦糖玛奇朵', '/images/macchiato.png', '半糖/热', 1, 18.00);
INSERT INTO `order_detail` VALUES (67, 65, 16, '桃桃乌龙', '/images/peach-oolong.png', '半糖/冰', 1, 15.00);
INSERT INTO `order_detail` VALUES (68, 66, 9, '椰云拿铁', '/images/coconut-cloud.png', '半糖/冰', 1, 22.00);
INSERT INTO `order_detail` VALUES (69, 67, 14, '抹茶拿铁', '/images/matcha-latte.png', '少糖/热', 1, 16.00);
INSERT INTO `order_detail` VALUES (70, 68, 1, '美式', '/images/ame.png', '无糖/冰', 1, 13.00);
INSERT INTO `order_detail` VALUES (71, 69, 8, '生椰Dirty', '/images/coconut-dirty.png', '少糖/冰', 1, 21.00);
INSERT INTO `order_detail` VALUES (72, 70, 7, '生椰拿铁', '/images/coconut-latte.png', '无糖/冰', 1, 19.90);
INSERT INTO `order_detail` VALUES (73, 71, 2, '拿铁', '/images/latte.png', '少糖/热', 1, 16.00);
INSERT INTO `order_detail` VALUES (74, 72, 3, '卡布奇诺', '/images/cappuccino.png', '无糖/热', 1, 18.00);
INSERT INTO `order_detail` VALUES (75, 73, 9, '椰云拿铁', '/images/coconut-cloud.png', '少糖/冰', 1, 22.00);
INSERT INTO `order_detail` VALUES (76, 74, 17, '鲜榨橙汁', '/images/orange-juice.png', '少糖/冰', 1, 14.00);
INSERT INTO `order_detail` VALUES (77, 75, 16, '桃桃乌龙', '/images/peach-oolong.png', '标准糖/冰', 1, 15.00);
INSERT INTO `order_detail` VALUES (78, 76, 8, '生椰Dirty', '/images/coconut-dirty.png', '无糖/冰', 1, 21.00);
INSERT INTO `order_detail` VALUES (79, 77, 7, '生椰拿铁', '/images/coconut-latte.png', '少糖/冰', 1, 19.90);
INSERT INTO `order_detail` VALUES (80, 78, 13, '红茶拿铁', '/images/blacktea-latte.png', '半糖/热', 1, 16.00);
INSERT INTO `order_detail` VALUES (81, 79, 1, '美式', '/images/ame.png', '无糖/热', 1, 13.00);
INSERT INTO `order_detail` VALUES (82, 80, 4, '摩卡', '/images/mocha.png', '少糖/热', 1, 18.00);
INSERT INTO `order_detail` VALUES (83, 81, 9, '椰云拿铁', '/images/coconut-cloud.png', '半糖/冰', 1, 22.00);
INSERT INTO `order_detail` VALUES (84, 82, 6, '澳白', '/images/flatwhite.png', '无糖/热', 1, 16.00);
INSERT INTO `order_detail` VALUES (85, 83, 7, '生椰拿铁', '/images/coconut-latte.png', '无糖/冰', 1, 19.90);
INSERT INTO `order_detail` VALUES (86, 84, 8, '生椰Dirty', '/images/coconut-dirty.png', '少糖/冰', 1, 21.00);
INSERT INTO `order_detail` VALUES (87, 85, 18, '葡萄冰萃', '/images/grape-ice.png', '少糖/冰', 1, 15.00);
INSERT INTO `order_detail` VALUES (88, 86, 2, '拿铁', '/images/latte.png', '少糖/热', 1, 16.00);
INSERT INTO `order_detail` VALUES (89, 87, 5, '焦糖玛奇朵', '/images/macchiato.png', '半糖/热', 1, 18.00);
INSERT INTO `order_detail` VALUES (90, 88, 9, '椰云拿铁', '/images/coconut-cloud.png', '少糖/冰', 1, 22.00);
INSERT INTO `order_detail` VALUES (91, 89, 17, '鲜榨橙汁', '/images/orange-juice.png', '无糖/冰', 1, 14.00);
INSERT INTO `order_detail` VALUES (92, 90, 8, '生椰Dirty', '/images/coconut-dirty.png', '无糖/冰', 1, 21.00);
INSERT INTO `order_detail` VALUES (93, 91, 7, '生椰拿铁', '/images/coconut-latte.png', '少糖/冰', 1, 19.90);
INSERT INTO `order_detail` VALUES (94, 92, 14, '抹茶拿铁', '/images/matcha-latte.png', '少糖/热', 1, 16.00);
INSERT INTO `order_detail` VALUES (95, 93, 1, '美式', '/images/ame.png', '无糖/冰', 1, 13.00);
INSERT INTO `order_detail` VALUES (96, 94, 3, '卡布奇诺', '/images/cappuccino.png', '少糖/热', 1, 18.00);
INSERT INTO `order_detail` VALUES (97, 95, 16, '桃桃乌龙', '/images/peach-oolong.png', '半糖/冰', 1, 15.00);
INSERT INTO `order_detail` VALUES (98, 96, 9, '椰云拿铁', '/images/coconut-cloud.png', '少糖/冰', 1, 22.00);
INSERT INTO `order_detail` VALUES (99, 97, 6, '澳白', '/images/flatwhite.png', '无糖/热', 1, 16.00);
INSERT INTO `order_detail` VALUES (100, 98, 8, '生椰Dirty', '/images/coconut-dirty.png', '无糖/冰', 1, 21.00);
INSERT INTO `order_detail` VALUES (101, 99, 7, '生椰拿铁', '/images/coconut-latte.png', '少糖/冰', 1, 19.90);
INSERT INTO `order_detail` VALUES (102, 100, 17, '鲜榨橙汁', '/images/orange-juice.png', '少糖/冰', 1, 14.00);
INSERT INTO `order_detail` VALUES (103, 101, 4, '摩卡', '/images/mocha.png', '', 2, 18.00);
INSERT INTO `order_detail` VALUES (104, 101, 3, '卡布奇诺', '/images/cappuccino.png', '', 1, 16.00);
INSERT INTO `order_detail` VALUES (105, 102, 4, '摩卡', '/images/mocha.png', '', 1, 18.00);
INSERT INTO `order_detail` VALUES (106, 103, 7, '生椰拿铁', '/images/coconut-latte.png', '', 1, 19.90);
INSERT INTO `order_detail` VALUES (107, 104, 7, '生椰拿铁', '/images/coconut-latte.png', '', 1, 19.90);
INSERT INTO `order_detail` VALUES (108, 104, 8, '生椰Dirty', '/images/coconut-dirty.png', '', 1, 21.00);
INSERT INTO `order_detail` VALUES (109, 104, 8, '生椰Dirty', '/images/coconut-dirty.png', '无糖/冰', 1, 21.00);
INSERT INTO `order_detail` VALUES (110, 105, 8, '生椰Dirty', '/images/coconut-dirty.png', '', 1, 21.00);
INSERT INTO `order_detail` VALUES (111, 106, 10, '生椰丝绒拿铁', '/images/coconut-velvet.png', '', 3, 23.00);
INSERT INTO `order_detail` VALUES (112, 107, 27, '桂花龙井拿铁', '/images/osmanthus-tea.png', '', 1, 20.00);
INSERT INTO `order_detail` VALUES (113, 108, 7, '生椰拿铁', '/images/coconut-latte.png', '', 1, 19.90);
INSERT INTO `order_detail` VALUES (114, 109, 8, '生椰Dirty', '/images/coconut-dirty.png', '', 1, 21.00);
INSERT INTO `order_detail` VALUES (115, 110, 9, '椰云拿铁', '/images/coconut-cloud.png', '少糖/冰', 1, 22.00);
INSERT INTO `order_detail` VALUES (116, 111, 10, '生椰丝绒拿铁', '/images/coconut-velvet.png', '', 1, 23.00);
INSERT INTO `order_detail` VALUES (117, 112, 7, '生椰拿铁', '/images/coconut-latte.png', '', 2, 19.90);
INSERT INTO `order_detail` VALUES (118, 113, 7, '生椰拿铁', '/images/coconut-latte.png', '', 1, 19.90);
INSERT INTO `order_detail` VALUES (119, 114, 9, '椰云拿铁', '/images/coconut-cloud.png', '', 1, 22.00);
INSERT INTO `order_detail` VALUES (120, 115, 9, '椰云拿铁', '/images/coconut-cloud.png', '', 1, 22.00);
INSERT INTO `order_detail` VALUES (121, 116, 12, '茉莉花香拿铁', '/images/jasmine-latte.png', '', 1, 16.00);
INSERT INTO `order_detail` VALUES (122, 117, 17, '鲜榨橙汁', '/images/orange-juice.png', '少糖/去冰', 1, 14.00);
INSERT INTO `order_detail` VALUES (123, 118, 18, '葡萄冰萃', '/images/grape-ice.png', '少糖/冰', 1, 16.00);
INSERT INTO `order_detail` VALUES (124, 119, 17, '鲜榨橙汁', '/images/orange-juice.png', '少糖/冰', 1, 14.00);
INSERT INTO `order_detail` VALUES (125, 119, 18, '葡萄冰萃', '/images/grape-ice.png', '少糖/冰', 1, 16.00);

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `openid` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '微信openid',
  `nickname` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '昵称',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '头像URL',
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '手机号',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '注册时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_openid`(`openid` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 53 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 'wx_user_001', '小明', NULL, '13800138001', '2026-06-05 22:32:50');
INSERT INTO `user` VALUES (2, 'wx_user_002', '小红', NULL, '13800138002', '2026-06-05 22:32:50');
INSERT INTO `user` VALUES (3, 'wx_user_003', '小刚', NULL, '13800138003', '2026-06-05 22:32:50');
INSERT INTO `user` VALUES (4, 'wx_user_004', '小丽', NULL, '13800138004', '2026-06-05 22:32:50');
INSERT INTO `user` VALUES (5, 'wx_user_005', '阿杰', NULL, '13800138005', '2026-06-05 22:32:50');
INSERT INTO `user` VALUES (6, 'wx_user_006', '阿花', NULL, '13800138006', '2026-06-05 22:32:50');
INSERT INTO `user` VALUES (7, 'wx_user_007', '大伟', NULL, '13800138007', '2026-06-05 22:32:50');
INSERT INTO `user` VALUES (8, 'wx_user_008', '小美', NULL, '13800138008', '2026-06-05 22:32:50');
INSERT INTO `user` VALUES (9, 'wx_user_009', '阿强', NULL, '13800138009', '2026-06-05 22:32:50');
INSERT INTO `user` VALUES (10, 'wx_user_010', '小芳', NULL, '13800138010', '2026-06-05 22:32:50');
INSERT INTO `user` VALUES (11, 'wx_user_011', '志明', NULL, '13800138011', '2026-06-05 22:32:50');
INSERT INTO `user` VALUES (12, 'wx_user_012', '春娇', NULL, '13800138012', '2026-06-05 22:32:50');
INSERT INTO `user` VALUES (13, 'wx_user_013', '阿豪', NULL, '13800138013', '2026-06-05 22:32:50');
INSERT INTO `user` VALUES (14, 'wx_user_014', '小雪', NULL, '13800138014', '2026-06-05 22:32:50');
INSERT INTO `user` VALUES (15, 'wx_user_015', '大山', NULL, '13800138015', '2026-06-05 22:32:50');
INSERT INTO `user` VALUES (16, 'wx_user_016', '小溪', NULL, '13800138016', '2026-06-05 22:32:50');
INSERT INTO `user` VALUES (17, 'wx_user_017', '阿龙', NULL, '13800138017', '2026-06-05 22:32:50');
INSERT INTO `user` VALUES (18, 'wx_user_018', '小凤', NULL, '13800138018', '2026-06-05 22:32:50');
INSERT INTO `user` VALUES (19, 'wx_user_019', '阿飞', NULL, '13800138019', '2026-06-05 22:32:50');
INSERT INTO `user` VALUES (20, 'wx_user_020', '小云', NULL, '13800138020', '2026-06-05 22:32:50');
INSERT INTO `user` VALUES (21, 'wx_user_021', '大鹏', NULL, '13800138021', '2026-06-05 22:32:50');
INSERT INTO `user` VALUES (22, 'wx_user_022', '小燕', NULL, '13800138022', '2026-06-05 22:32:50');
INSERT INTO `user` VALUES (23, 'wx_user_023', '阿威', NULL, '13800138023', '2026-06-05 22:32:50');
INSERT INTO `user` VALUES (25, 'wx_user_025', '阿达', NULL, '13800138025', '2026-06-05 22:32:50');
INSERT INTO `user` VALUES (26, 'wx_user_026', '小敏', NULL, '13800138026', '2026-06-05 22:32:50');
INSERT INTO `user` VALUES (27, 'wx_user_027', '阿亮', NULL, '13800138027', '2026-06-05 22:32:50');
INSERT INTO `user` VALUES (28, 'wx_user_028', '小婷', NULL, '13800138028', '2026-06-05 22:32:50');
INSERT INTO `user` VALUES (29, 'wx_user_029', '阿超', NULL, '13800138029', '2026-06-05 22:32:50');
INSERT INTO `user` VALUES (30, 'wx_user_030', '小怡', NULL, '13800138030', '2026-06-05 22:32:50');
INSERT INTO `user` VALUES (31, 'wx_user_031', '阿涛', NULL, '13800138031', '2026-06-05 22:32:50');
INSERT INTO `user` VALUES (32, 'wx_user_032', '小欣', NULL, '13800138032', '2026-06-05 22:32:50');
INSERT INTO `user` VALUES (33, 'wx_user_033', '阿斌', NULL, '13800138033', '2026-06-05 22:32:50');
INSERT INTO `user` VALUES (34, 'wx_user_034', '小玲', NULL, '13800138034', '2026-06-05 22:32:50');
INSERT INTO `user` VALUES (35, 'wx_user_035', '阿健', NULL, '13800138035', '2026-06-05 22:32:50');
INSERT INTO `user` VALUES (36, 'wx_user_036', '小洁', NULL, '13800138036', '2026-06-05 22:32:50');
INSERT INTO `user` VALUES (37, 'wx_user_037', '阿军', NULL, '13800138037', '2026-06-05 22:32:50');
INSERT INTO `user` VALUES (38, 'wx_user_038', '小蓉', NULL, '13800138038', '2026-06-05 22:32:50');
INSERT INTO `user` VALUES (39, 'wx_user_039', '阿峰', NULL, '13800138039', '2026-06-05 22:32:50');
INSERT INTO `user` VALUES (40, 'wx_user_040', '小蕾', NULL, '13800138040', '2026-06-05 22:32:50');
INSERT INTO `user` VALUES (41, 'wx_user_041', '阿磊', NULL, '13800138041', '2026-06-05 22:32:50');
INSERT INTO `user` VALUES (42, 'wx_user_042', '小静', NULL, '13800138042', '2026-06-05 22:32:50');
INSERT INTO `user` VALUES (43, 'wx_user_043', '阿鑫', NULL, '13800138043', '2026-06-05 22:32:50');
INSERT INTO `user` VALUES (44, 'wx_user_044', '小瑶', NULL, '13800138044', '2026-06-05 22:32:50');
INSERT INTO `user` VALUES (45, 'wx_user_045', '阿坤', NULL, '13800138045', '2026-06-05 22:32:50');
INSERT INTO `user` VALUES (46, 'wx_user_046', '小莹', NULL, '13800138046', '2026-06-05 22:32:50');
INSERT INTO `user` VALUES (47, 'wx_user_047', '阿浩', NULL, '13800138047', '2026-06-05 22:32:50');
INSERT INTO `user` VALUES (48, 'wx_user_048', '小颖', NULL, '13800138048', '2026-06-05 22:32:50');
INSERT INTO `user` VALUES (49, 'wx_user_049', '阿宇', NULL, '13800138049', '2026-06-05 22:32:50');
INSERT INTO `user` VALUES (50, 'wx_user_050', '小萱', NULL, '13800138050', '2026-06-05 22:32:50');
INSERT INTO `user` VALUES (51, 'chake111', '用户chak', NULL, NULL, '2026-06-05 22:55:40');
INSERT INTO `user` VALUES (52, 'chake1111', '用户chake1111', NULL, NULL, '2026-06-07 17:28:38');

SET FOREIGN_KEY_CHECKS = 1;
