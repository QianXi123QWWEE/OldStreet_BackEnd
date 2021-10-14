/*
 Navicat MySQL Data Transfer

 Source Server         : 127.0.0.1
 Source Server Type    : MariaDB
 Source Server Version : 100119
 Source Host           : localhost:3306
 Source Schema         : street

 Target Server Type    : MariaDB
 Target Server Version : 100119
 File Encoding         : 65001

 Date: 12/10/2021 14:38:56
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for details
-- ----------------------------
DROP TABLE IF EXISTS `details`;
CREATE TABLE `details`  (
  `did` int(11) NOT NULL AUTO_INCREMENT,
  `family_id` int(11) NOT NULL COMMENT '类别id，关联类别表',
  `title` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '商品名称',
  `dimg` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品图片',
  `price` decimal(10, 2) NOT NULL COMMENT '商品价格',
  `details` varchar(10240) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '商品详情/介绍',
  `standards` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品规格',
  `stock` int(11) NOT NULL COMMENT '库存',
  `isSale` int(2) NOT NULL COMMENT '是否在售 1在售  0不在售',
  PRIMARY KEY (`did`) USING BTREE,
  INDEX `family_id`(`family_id`) USING BTREE,
  CONSTRAINT `details_ibfk_1` FOREIGN KEY (`family_id`) REFERENCES `details_family` (`family_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of details
-- ----------------------------
INSERT INTO `details` VALUES (1, 10, '五香瓜子', ' /image/details/10/guazi.png', 12.20, '老接口五香瓜子，谁都说香', '每包/100g', 2000, 0);
INSERT INTO `details` VALUES (2, 10, '奶油瓜子', ' /image/details/10/naiyou.png', 14.20, '老接口五香瓜子，谁都说香', '每包/100g', 2000, 0);

-- ----------------------------
-- Table structure for details_family
-- ----------------------------
DROP TABLE IF EXISTS `details_family`;
CREATE TABLE `details_family`  (
  `fid` int(11) NOT NULL AUTO_INCREMENT,
  `family_id` int(11) NULL DEFAULT NULL COMMENT '类别id',
  `family_name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '类别名称',
  PRIMARY KEY (`fid`) USING BTREE,
  INDEX `family`(`family_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of details_family
-- ----------------------------
INSERT INTO `details_family` VALUES (1, 10, '花生');
INSERT INTO `details_family` VALUES (2, 20, '瓜子');
INSERT INTO `details_family` VALUES (3, 30, ' 坚果');
INSERT INTO `details_family` VALUES (4, 40, '核桃');
INSERT INTO `details_family` VALUES (5, 50, '南瓜酥');

-- ----------------------------
-- Table structure for lj_order
-- ----------------------------
DROP TABLE IF EXISTS `lj_order`;
CREATE TABLE `lj_order`  (
  `oid` int(11) NOT NULL,
  `uid` int(11) NOT NULL COMMENT '关联的用户表id',
  `status` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '您的订单已经开始处理了' COMMENT '订单状态',
  `order_time` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '订单过期时间',
  `details_arry` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品数组，保存商品表的id',
  PRIMARY KEY (`oid`) USING BTREE,
  INDEX `uid`(`uid`) USING BTREE,
  CONSTRAINT `lj_order_ibfk_1` FOREIGN KEY (`oid`) REFERENCES `lj_user` (`uid`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of lj_order
-- ----------------------------

-- ----------------------------
-- Table structure for lj_user
-- ----------------------------
DROP TABLE IF EXISTS `lj_user`;
CREATE TABLE `lj_user`  (
  `uid` int(11) NOT NULL AUTO_INCREMENT,
  `uname` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `upwd` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `email` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `phone` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `avatar` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '/image/avatar/details.png',
  `gender` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '未知',
  PRIMARY KEY (`uid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of lj_user
-- ----------------------------
INSERT INTO `lj_user` VALUES (1, 'wncf1314', 'ac1dbe2e73044407345c03d1b2c3aa5d', '', NULL, '/image/avatar/details.png', '未知');

SET FOREIGN_KEY_CHECKS = 1;
