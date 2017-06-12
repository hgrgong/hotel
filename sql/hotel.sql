/*
Navicat MySQL Data Transfer

Source Server         : mysql_3306
Source Server Version : 50716
Source Host           : localhost:3306
Source Database       : hotel

Target Server Type    : MYSQL
Target Server Version : 50716
File Encoding         : 65001

Date: 2017-06-12 19:39:19
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `aid` int(5) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `password` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`aid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES ('1', 'Wong', 'localhost');

-- ----------------------------
-- Table structure for order
-- ----------------------------
DROP TABLE IF EXISTS `order`;
CREATE TABLE `order` (
  `oid` int(5) NOT NULL AUTO_INCREMENT,
  `uid` int(5) NOT NULL,
  `rid` int(5) NOT NULL,
  `days` int(5) DEFAULT NULL,
  PRIMARY KEY (`oid`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of order
-- ----------------------------
INSERT INTO `order` VALUES ('1', '1', '8', '4');
INSERT INTO `order` VALUES ('2', '2', '3', '4');
INSERT INTO `order` VALUES ('8', '4', '9', '4');
INSERT INTO `order` VALUES ('9', '3', '2', '3');
INSERT INTO `order` VALUES ('10', '2', '12', '4');

-- ----------------------------
-- Table structure for room
-- ----------------------------
DROP TABLE IF EXISTS `room`;
CREATE TABLE `room` (
  `rid` int(5) NOT NULL AUTO_INCREMENT,
  `price` decimal(10,2) DEFAULT NULL,
  `status` int(2) DEFAULT NULL,
  `category` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`rid`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of room
-- ----------------------------
INSERT INTO `room` VALUES ('1', '170.00', '1', 'single');
INSERT INTO `room` VALUES ('2', '450.00', '1', 'double');
INSERT INTO `room` VALUES ('3', '710.00', '1', 'family');
INSERT INTO `room` VALUES ('4', '170.00', '1', 'single');
INSERT INTO `room` VALUES ('5', '450.00', '1', 'double');
INSERT INTO `room` VALUES ('6', '170.00', '1', 'single');
INSERT INTO `room` VALUES ('7', '170.00', '2', 'single');
INSERT INTO `room` VALUES ('8', '170.00', '1', 'single');
INSERT INTO `room` VALUES ('9', '450.00', '1', 'double');
INSERT INTO `room` VALUES ('10', '450.00', '2', 'double');
INSERT INTO `room` VALUES ('11', '170.00', '0', 'single');
INSERT INTO `room` VALUES ('12', '710.00', '1', 'family');
INSERT INTO `room` VALUES ('13', '710.00', '0', 'family');
INSERT INTO `room` VALUES ('14', '170.00', '0', 'single');
INSERT INTO `room` VALUES ('15', '170.00', '0', 'single');
INSERT INTO `room` VALUES ('16', '450.00', '0', 'double');
INSERT INTO `room` VALUES ('17', '450.00', '0', 'double');
INSERT INTO `room` VALUES ('18', '170.00', '0', 'single');
INSERT INTO `room` VALUES ('19', '710.00', '0', 'family');
INSERT INTO `room` VALUES ('20', '710.00', '0', 'family');
INSERT INTO `room` VALUES ('21', '170.00', '0', 'single');
INSERT INTO `room` VALUES ('22', '170.00', '2', 'single');
INSERT INTO `room` VALUES ('23', '450.00', '0', 'double');
INSERT INTO `room` VALUES ('24', '450.00', '0', 'double');
INSERT INTO `room` VALUES ('25', '170.00', '0', 'single');
INSERT INTO `room` VALUES ('26', '710.00', '0', 'family');
INSERT INTO `room` VALUES ('27', '710.00', '0', 'family');
INSERT INTO `room` VALUES ('28', '170.00', '0', 'single');
INSERT INTO `room` VALUES ('29', '710.00', '0', 'family');
INSERT INTO `room` VALUES ('30', '450.00', '0', 'double');
INSERT INTO `room` VALUES ('31', '450.00', '0', 'double');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `uid` int(5) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `password` varchar(50) DEFAULT NULL,
  `gender` varchar(10) DEFAULT NULL,
  `mobile` varchar(50) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('1', 'Lee', 'myfun', 'man', '13342534532', 'lee@qq.com');
INSERT INTO `user` VALUES ('2', 'Dipper', 'mabel', 'man', '13460992344', 'dipper@outlook.com');
INSERT INTO `user` VALUES ('3', 'Mabel', 'dipper', 'woman', '16731435134', 'mabel@gmail.com');
INSERT INTO `user` VALUES ('4', 'UncleStan', 'twins', 'man', '18237927384', 'stan@163.com');
