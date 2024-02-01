/*
 Navicat Premium Data Transfer

 Source Server         : 2710_hw2
 Source Server Type    : MySQL
 Source Server Version : 80035
 Source Host           : localhost:3306
 Source Schema         : dbdigital

 Target Server Type    : MySQL
 Target Server Version : 80035
 File Encoding         : 65001

 Date: 01/12/2023 21:05:10
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for Customers
-- ----------------------------
DROP TABLE IF EXISTS `Customers`;
CREATE TABLE `Customers`  (
  `CustomerID` int NOT NULL,
  `Name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Street` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `City` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `State` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `ZipCode` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `Category` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `BusinessCategory` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `AnnualRevenue` decimal(18, 2) NULL DEFAULT NULL,
  `MaritalStatus` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `Gender` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `Age` int NULL DEFAULT NULL,
  `PersonalIncome` decimal(18, 2) NULL DEFAULT NULL,
  PRIMARY KEY (`CustomerID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of Customers
-- ----------------------------
BEGIN;
INSERT INTO `Customers` (`CustomerID`, `Name`, `Street`, `City`, `State`, `ZipCode`, `Category`, `BusinessCategory`, `AnnualRevenue`, `MaritalStatus`, `Gender`, `Age`, `PersonalIncome`) VALUES (1, 'Weiwei', '123 Main St', 'New York', 'NY', '12345', 'Family', NULL, NULL, 'Married', 'Male', 30, 50000.00), (2, 'TheShy', '456 Oak St', 'New York', 'NY', '67890', 'Business', 'Retail', 1000000.00, NULL, NULL, NULL, NULL), (3, 'Oner', '789 Pine St', 'New York', 'NY', '23456', 'Family', NULL, NULL, 'Single', 'Female', 25, 40000.00), (4, 'Light', '101 Elm St', 'San Jose', 'CA', '78901', 'Business', 'Manufacturing', 5000000.00, NULL, NULL, NULL, NULL), (5, 'Zeus', '202 Maple St', 'San Jose', 'CA', '34567', 'Family', NULL, NULL, 'Married', 'Male', 35, 60000.00), (6, 'Faker', '303 Cedar St', 'San Jose', 'CA', '89012', 'Business', 'Technology', 2000000.00, NULL, NULL, NULL, NULL), (7, 'Xiaohu', '404 Birch St', 'Austin', 'TX', '45678', 'Family', NULL, NULL, 'Married', 'Female', 32, 55000.00), (8, 'Crisp', '505 Walnut St', 'Austin', 'TX', '56789', 'Business', 'Services', 800000.00, NULL, NULL, NULL, NULL), (9, 'keria', '606 Pine St', 'Los Angles', 'CA', '67890', 'Family', NULL, NULL, 'Single', 'Male', 28, 45000.00), (10, 'Gumayusi', '707 Oak St', 'Los Angles', 'CA', '78901', 'Business', 'Finance', 1500000.00, NULL, NULL, NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for Regions
-- ----------------------------
DROP TABLE IF EXISTS `Regions`;
CREATE TABLE `Regions`  (
  `RegionID` int NOT NULL,
  `RegionName` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `RegionManager` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`RegionID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of Regions
-- ----------------------------
BEGIN;
INSERT INTO `Regions` (`RegionID`, `RegionName`, `RegionManager`) VALUES (301, 'Austin', 'JingPro'), (302, 'New York', 'Xinyang'), (303, 'San Jose', 'Andres'), (304, 'Los Angles', 'Sean');
COMMIT;

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `manager` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `manager`(`manager` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci;

-- ----------------------------
-- Records of admin
-- ----------------------------
BEGIN;
INSERT INTO `admin` (`id`, `password`, `manager`) VALUES (1, 'pbkdf2:sha256:50000$nEXDkmWN$c40c5c714cddeb4ef1f11a06776c7ff5e002efdcab8c9b30a05f90237206ddf5', 'admin');
COMMIT;

-- ----------------------------
-- Table structure for alembic_version
-- ----------------------------
DROP TABLE IF EXISTS `alembic_version`;
CREATE TABLE `alembic_version`  (
  `version_num` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`version_num`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci;

-- ----------------------------
-- Records of alembic_version
-- ----------------------------
BEGIN;
INSERT INTO `alembic_version` (`version_num`) VALUES ('acfd5712f3c2');
COMMIT;

-- ----------------------------
-- Table structure for cart
-- ----------------------------
DROP TABLE IF EXISTS `cart`;
CREATE TABLE `cart`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `goods_id` int NULL DEFAULT NULL,
  `user_id` int NULL DEFAULT NULL,
  `number` int NULL DEFAULT NULL,
  `addtime` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `goods_id`(`goods_id` ASC) USING BTREE,
  INDEX `user_id`(`user_id` ASC) USING BTREE,
  INDEX `ix_cart_addtime`(`addtime` ASC) USING BTREE,
  CONSTRAINT `cart_ibfk_1` FOREIGN KEY (`goods_id`) REFERENCES `goods` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 29 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci;

-- ----------------------------
-- Records of cart
-- ----------------------------
BEGIN;
INSERT INTO `cart` (`id`, `goods_id`, `user_id`, `number`, `addtime`) VALUES (6, 62, 0, 1, '2023-11-27 22:35:32'), (7, 10, 0, 1, '2023-11-27 22:36:54'), (9, 48, 7, 1, '2023-11-27 23:31:09'), (11, 59, 0, 1, '2023-11-29 10:01:31'), (12, 18, 0, 1, '2023-11-29 10:02:00'), (13, 19, 0, 1, '2023-11-29 10:02:03'), (14, 52, 0, 1, '2023-11-29 10:02:06'), (15, 2, 0, 1, '2023-11-29 10:02:08'), (16, 8, 0, 1, '2023-11-29 10:02:10'), (17, 33, 0, 1, '2023-11-29 10:02:12'), (18, 58, 0, 1, '2023-11-29 12:22:56'), (19, 18, 0, 1, '2023-11-29 12:24:02'), (20, 61, 0, 1, '2023-11-29 12:24:05'), (21, 61, 0, 1, '2023-11-29 12:24:07'), (22, 56, 0, 1, '2023-11-29 12:24:10'), (23, 5, 0, 1, '2023-11-29 12:24:18'), (24, 21, 0, 1, '2023-11-29 12:24:20'), (25, 23, 0, 1, '2023-11-29 12:24:25'), (26, 57, 9, 1, '2023-11-29 14:15:35'), (27, 62, 0, 1, '2023-11-30 16:31:00');
COMMIT;

-- ----------------------------
-- Table structure for collect
-- ----------------------------
DROP TABLE IF EXISTS `collect`;
CREATE TABLE `collect`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `goods_id` int NULL DEFAULT NULL,
  `user_id` int NULL DEFAULT NULL,
  `addtime` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `goods_id`(`goods_id` ASC) USING BTREE,
  INDEX `user_id`(`user_id` ASC) USING BTREE,
  INDEX `ix_collect_addtime`(`addtime` ASC) USING BTREE,
  CONSTRAINT `collect_ibfk_1` FOREIGN KEY (`goods_id`) REFERENCES `goods` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci;

-- ----------------------------
-- Records of collect
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for goods
-- ----------------------------
DROP TABLE IF EXISTS `goods`;
CREATE TABLE `goods`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `original_price` decimal(10, 2) NULL DEFAULT NULL,
  `current_price` decimal(10, 2) NULL DEFAULT NULL,
  `picture` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `introduction` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL,
  `is_sale` tinyint(1) NULL DEFAULT NULL,
  `is_new` tinyint(1) NULL DEFAULT NULL,
  `addtime` datetime NULL DEFAULT NULL,
  `views_count` int NULL DEFAULT NULL,
  `subcat_id` int NULL DEFAULT NULL,
  `supercat_id` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `ix_goods_addtime`(`addtime` ASC) USING BTREE,
  INDEX `supercat_id`(`supercat_id` ASC) USING BTREE,
  INDEX `subcat_id`(`subcat_id` ASC) USING BTREE,
  CONSTRAINT `goods_ibfk_1` FOREIGN KEY (`supercat_id`) REFERENCES `supercat` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `goods_ibfk_2` FOREIGN KEY (`subcat_id`) REFERENCES `subcat` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 63 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci;

-- ----------------------------
-- Records of goods
-- ----------------------------
BEGIN;
INSERT INTO `goods` (`id`, `name`, `original_price`, `current_price`, `picture`, `introduction`, `is_sale`, `is_new`, `addtime`, `views_count`, `subcat_id`, `supercat_id`) VALUES (2, 'iPhone 15', 799.00, 799.00, '1.jpg', 'Dynamic Island bubbles up alerts and Live Activities — so you don’t miss them while you’re doing something else. You can track your next ride, see who’s calling, check your flight status, and so much more.', 1, 0, '2023-08-20 09:58:53', 25, 27, 14), (3, 'iPhone 15 Plus', 899.00, 899.00, '2.jpg', 'Dynamic Island bubbles up alerts and Live Activities — so you don’t miss them while you’re doing something else. You can track your next ride, see who’s calling, check your flight status, and so much more.', 1, 0, '2023-08-31 10:10:38', 4, 27, 14), (4, 'iPhone 15 Pro', 999.00, 999.00, '3.jpg', 'iPhone 15 Pro is the first iPhone to feature an aerospace‑grade titanium design, using the same alloy that spacecraft use for missions to Mars.', 1, 0, '2023-08-31 10:12:00', 0, 27, 14), (5, 'iPhone 15 Pro Max', 1199.00, 1199.00, '4.jpg', 'iPhone 15 Pro Max is the first iPhone to feature an aerospace‑grade titanium design, using the same alloy that spacecraft use for missions to Mars.', 1, 0, '2023-08-31 10:13:06', 0, 27, 14), (6, 'iPhone 14', 699.00, 699.00, '5.jpg', 'As part of our efforts to reach carbon neutrality by 2030, iPhone 14 and iPhone 14 Plus do not include a power adapter or EarPods. Included in the box is a USB‑C to Lightning Cable that supports fast charging and is compatible with USB‑C power adapters and computer ports.', 1, 0, '2023-08-31 10:14:24', 6, 27, 14), (7, 'Samsung Galaxy S23 Ultra', 1199.99, 1199.99, '6.jpg', 'Ultra evolved', 1, 0, '2023-08-31 10:18:19', 0, 28, 14), (8, 'Samsung Galaxy Z Flip5', 999.99, 999.99, '7.jpg', 'Mini phone, mighty innovation', 1, 1, '2023-08-31 10:20:10', 1, 28, 14), (9, 'Samsung Galaxy S23', 799.99, 799.99, '8.jpg', 'Ultra evolved', 1, 0, '2023-08-31 10:24:51', 0, 28, 14), (10, 'Samsung Galaxy S23 FE', 599.99, 599.99, '9.jpg', 'Colors that capture attention', 1, 0, '2023-08-31 10:26:06', 1, 28, 14), (11, 'Samsung Galaxy S23+', 999.99, 999.99, '10.jpg', 'Ultra evolved', 1, 0, '2023-08-30 10:27:22', 0, 28, 14), (12, 'Huawei Mate60 Pro', 1099.99, 1099.99, '11.jpg', 'Far Far ahead.', 1, 0, '2023-08-29 10:29:44', 2, 29, 14), (13, 'Huawei P60 Pro', 1595.00, 1595.00, '12.jpg', 'Vision Enlightened', 1, 0, '2023-08-31 10:31:56', 0, 29, 14), (14, 'Huawei Mate X5', 2129.99, 2129.99, '13.jpg', 'Unfold Your Expectations', 1, 0, '2023-08-25 10:34:32', 0, 29, 14), (15, 'Huawei nova 11', 474.85, 474.85, '14.jpg', 'Be inspired, Be nova', 1, 0, '2023-08-30 10:39:48', 0, 29, 14), (16, 'Huawei Mate50 Pro', 700.00, 700.00, '15.jpg', 'Your Glamorous Mate\nSymmetry Aesthetics, Refined Clous de Paris Pattern,\nDurable Kunlun Glass,⁠1 6-Metre Water Resistance⁠2\nHUAWEI Mate 50 Pro Your Glamorous Mate\nA New Era of Mobile Photography\nUltra Aperture XMAGE Camera, F1.4 Ultra-large Aperture, Adjustable Physical Aperture of 10 sizes, Super Night Mode, Professional Portrait, Super Macro\nHUAWEI Mate 50 Pro A New Era of Mobile Photography\nPerforms Like a Champ\n4700 mAh Battery,⁠3 SuperHold, SuperRender,⁠4 SuperStorage\nHUAWEI Mate 50 Pro Performs Like a Champ\nPersonal, Productive, and Private', 1, 0, '2023-08-31 10:40:43', 0, 29, 14), (17, 'Macbook Pro 16-inch', 2499.00, 2499.00, '16.jpg', 'Mind-blowing.\nHead-turning.', 1, 0, '2023-08-31 10:43:27', 0, 30, 15), (18, 'Macbook Pro 14-inch', 1599.00, 1599.00, '17.jpg', 'Mind-blowing.\nHead-turning.', 1, 0, '2023-08-31 10:45:55', 7, 30, 15), (19, 'Macbook Air 13-inch', 1099.00, 1099.00, '18.jpg', 'Strikingly thin and fast so you can work, play, or create anywhere.', 1, 0, '2023-08-31 10:46:55', 0, 30, 15), (20, 'Macbook Air 15-inch', 1299.00, 1299.00, '19.jpg', 'Strikingly thin and fast so you can work, play, or create anywhere.', 1, 0, '2023-08-31 10:47:48', 0, 30, 15), (21, 'Mac mini', 599.00, 499.00, '20.jpg', 'More muscle.\nMore hustle.', 1, 0, '2023-08-31 10:49:30', 0, 30, 15), (22, 'Zenbook Pro 14 OLED', 1799.99, 1599.99, '21.jpg', 'Incredible Comes From Unlimited Power.', 1, 0, '2023-08-31 10:50:35', 0, 31, 15), (23, 'Chromebook Plus CX34', 599.99, 599.99, '22.jpg', 'Every experience, stepped up.', 1, 0, '2023-08-31 10:51:57', 0, 31, 15), (24, 'Vivobook 13 Slate OLED', 749.99, 699.99, '23.jpg', 'Your speedy PC, your brilliant entertainment center.', 1, 0, '2023-08-31 10:52:58', 0, 31, 15), (25, 'ROG Strix SCAR 17 X3D', 3699.99, 3199.99, '24.jpg', 'BEAT THE BEST. CARVE YOUR LEGACY.', 1, 0, '2023-08-31 10:54:58', 0, 31, 15), (26, 'ProArt Studiobook Pro 16', 1999.99, 1599.99, '25.jpg', 'Born for Creative Pros', 1, 0, '2023-08-31 10:56:21', 0, 31, 15), (27, 'ThinkPad X1 Carbon Gen 10', 1079.99, 1049.99, '26.jpg', 'Redesigned with collaboration in mind.', 1, 0, '2023-08-31 10:57:39', 0, 32, 15), (28, 'ThinkPad L14 Gen 3', 692.45, 649.45, '27.jpg', 'A business laptop you can count on.', 1, 0, '2023-08-31 10:58:36', 0, 32, 15), (29, 'ThinkPad T16 ', 809.00, 799.00, '28.jpg', 'Puts the personal in PC.', 1, 0, '2023-08-31 11:00:27', 0, 32, 15), (30, 'ThinkPad P14s Gen 4', 969.00, 909.00, '29.jpg', 'Redesigned with collaboration in mind.', 1, 0, '2023-08-31 11:01:39', 0, 32, 15), (31, 'ThinkPad Z16 ', 1616.00, 1499.00, '30.jpg', 'Elevated experience. Exceptional power.', 1, 0, '2023-08-31 11:02:43', 0, 32, 15), (32, 'EOS 5D Mark IV', 2699.00, 2699.00, '31.jpg', 'New 30.4 Megapixel full-frame CMOS sensor for versatile shooting in nearly any light, with ISO range 100–32000; expandable up to 50–102400 (equivalent ISO).\n4K Motion JPEG video (DCI cinema-type 4096 x 2160) at 30p or 24p; in-camera still frame grab* of 4K 8.8-Megapixel images; multiple video options include Full HD up to 60p, and HD up to 120p.', 1, 0, '2023-08-31 11:04:26', 1, 33, 16), (33, 'EOS-1D X Mark III Body', 6499.00, 6499.00, '32.jpg', 'High Image Quality with New 20.1 Megapixel Full-frame CMOS Sensor Combined with Newly Designed low Pass Filter.\nNew DIGIC X Image Processor with an ISO range of 100-102400; Expandable to 50-819200*.\nNew 191-point AF System Capable of Tracking the Subjects Head and Face using Deep Learning Technology.', 1, 1, '2023-08-31 11:06:02', 0, 33, 16), (34, 'EOS 6D Mark II Body', 1399.00, 1399.00, '33.jpg', '26.2 Megapixel Full-frame CMOS Sensor.\nOptical Viewfinder with a 45-point All Cross-type AF System*.\nDual Pixel CMOS AF with Phase-Detection & Full HD 60p. ', 1, 1, '2023-08-31 11:07:22', 0, 33, 16), (35, 'EOS 90D Body', 1199.00, 1199.00, '34.jpg', 'High Image Quality with 32.5 Megapixel CMOS (APS-C) Sensor.\nHigh-Speed Continuous Shooting of up to 10 fps with no Time Lag during OVF Shooting.', 1, 0, '2023-08-31 11:08:38', 1, 33, 16), (36, 'EOS R3 Body', 4999.00, 4999.00, '35.jpg', 'High Image Quality with a Back-illuminated Stacked 24.1 Megapixel Full-frame CMOS Sensor.\nDIGIC X Image Processor with an ISO range of 100-102400; Expandable to 204800.1\nHigh-speed continuous shooting of up to approx. 30 fps with electronic (silent) shutter and up to 12fps with Mechanical Shutter.', 1, 0, '2023-08-31 11:09:51', 0, 33, 16), (37, 'Nikon D7500', 899.95, 899.95, '36.jpg', 'Follow your passion wherever it leads.', 1, 0, '2023-08-31 11:12:04', 0, 34, 16), (38, 'Nikon D780', 1899.95, 1899.95, '37.jpg', 'Versatility meets agility.', 1, 0, '2023-08-31 11:13:03', 0, 34, 16), (39, 'Nikon D850', 2499.95, 2499.95, '38.jpg', 'Extreme resolution meets extreme speed.', 1, 0, '2023-08-31 11:14:48', 1, 34, 16), (40, 'Nikon D5600', 699.95, 699.95, '39.jpg', 'Stand out from the crowd.', 1, 0, '2023-08-31 11:15:57', 0, 34, 16), (41, 'Nikon D3500', 649.95, 649.95, '40.jpg', 'Beautiful pictures for all.', 1, 0, '2023-08-31 11:17:06', 2, 34, 16), (42, 'SONY Alpha 7 IV', 2499.00, 2299.00, '41.jpg', 'Beyond basic.\nFor a new generation of imagemakers.', 1, 1, '2023-08-31 11:18:48', 0, 35, 16), (43, 'SONY Alpha 7 III ', 1999.00, 1499.00, '42.jpg', 'Perfection for all. Everything you need.', 1, 1, '2023-08-31 11:20:07', 0, 35, 16), (44, 'SONY Alpha ZV-E10', 699.00, 599.00, '43.jpg', 'Capture more of your\nworld.', 0, 1, '2023-08-31 11:21:19', 0, 35, 16), (45, 'SONY Alpha 7R V', 3899.00, 3499.00, '44.jpg', 'Evolved imaging intelligence.', 1, 0, '2023-08-31 11:25:22', 0, 35, 16), (46, 'SONY Alpha 7C ', 1599.00, 1599.00, '45.jpg', 'Compact Size,\nFull-frame Power.', 1, 0, '2023-08-31 11:27:00', 0, 35, 16), (47, 'SONY WH-1000XM5', 399.99, 329.99, '46.jpg', 'YOUR WORLD. NOTHING ELSE.', 1, 1, '2023-08-31 11:28:23', 9, 36, 17), (48, 'SONY WH-1000XM4', 349.99, 249.99, '47.jpg', 'ONLY MUSIC. NOTHING ELSE.\nONLY MUSIC. NOTHING ELSE.', 1, 0, '2023-08-31 11:29:16', 1, 36, 17), (49, 'SONY WH-1000XM3', 300.95, 245.00, '48.jpg', 'More power = even less noise.', 1, 0, '2023-08-31 11:30:20', 3, 36, 17), (50, 'SONY WH-CH720N', 149.99, 99.99, '49.jpg', 'Enjoy all-day comfort without the noise.', 0, 1, '2023-08-31 11:31:28', 0, 36, 17), (51, 'SONY WH-XB910N', 249.99, 119.99, '50.jpg', 'Turn up the bass. Turn down the noise.', 0, 1, '2023-08-31 11:32:20', 9, 36, 17), (52, 'SONY WH-CH520', 59.99, 39.99, '51.jpg', 'Stunning sound and longer battery life.', 0, 1, '2023-08-31 11:34:09', 2, 36, 17), (53, 'MOMENTUM 4 Wireless', 379.95, 259.95, '52.jpg', 'Discover best-in-class sound with our audiophile-inspired accoustic system.', 0, 1, '2023-08-31 11:36:28', 0, 37, 17), (54, 'Sennheiser HD 660S2', 599.95, 399.95, '53.jpg', 'Enjoy your music on a completely new level. An intimate, relaxed sound signature combines with outstanding precision and exceptional comfort — and now, extended sub bass — for a deeply moving experience.', 0, 1, '2023-08-31 11:37:29', 1, 37, 17), (55, 'MOMENTUM 4 Copper', 399.95, 249.95, '54.jpg', 'Discover best-in-class sound with our audiophile-inspired accoustic system.', 0, 1, '2023-08-31 11:38:45', 0, 37, 17), (56, 'Sennheiser HD820', 1999.95, 1599.95, '55.jpg', 'The critics said closed headphones could never sound as immersive as their open-air counterparts. They said physics would never allow it. To that we simply said, “listen”. The HD 820 combines an innovative glass reflector and ring radiator transducer technology for a benchmark listening experience.', 0, 1, '2023-08-31 11:39:52', 3, 37, 17), (57, 'Bose QuietComfort 45', 329.00, 199.00, '56.jpg', 'There’s comfort in quiet. You can feel it the minute you put them on. The soft, plush cushions seal you in. You press the button and whoosh — the world fades, the music starts, and it’s love at first listen. That’s the power of our QuietComfort 45 Headphones with signature active noise cancelling technology and premium comfort.', 0, 1, '2023-08-31 11:41:14', 3, 38, 17), (58, 'Bose QuietComfort', 349.00, 249.00, '57.jpg', 'Take charge of your music and stride along to the beat. High-fidelity audio and legendary noise cancellation work their magic by sealing you in, eliminating distractions, and letting you dive deep into your own rhythm.', 0, 1, '2023-08-31 11:42:31', 8, 38, 17), (59, 'Bose QuietComfort Ultra', 429.00, 379.00, '58.jpg', 'World-class noise cancellation, quieter than ever before. Breakthrough spatialized audio for immersive listening, no matter the content or source. Elevated design and luxe materials for unrivaled comfort. It’s everything music makes you feel taken to new highs. ', 0, 1, '2023-08-31 11:43:18', 91, 38, 17), (61, 'Beats Studio Pro', 349.00, 249.00, '59.jpg', 'Beats Studio Pro – Premium Wireless Noise Cancelling Headphones', 0, 0, '2023-08-31 11:45:23', 16, 40, 17), (62, 'Beats Solo3 Wireless', 199.95, 199.95, '60.jpg', 'Beats Solo3 Wireless on-ear headphones immerse you in rich, award-winning sound, everywhere you want to go.', 0, 1, '2023-08-31 22:30:24', 7, 40, 17);
COMMIT;

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NULL DEFAULT NULL,
  `recevie_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `recevie_address` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `recevie_tel` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `remark` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `addtime` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_id`(`user_id` ASC) USING BTREE,
  INDEX `ix_orders_addtime`(`addtime` ASC) USING BTREE,
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 33 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci;

-- ----------------------------
-- Records of orders
-- ----------------------------
BEGIN;
INSERT INTO `orders` (`id`, `user_id`, `recevie_name`, `recevie_address`, `recevie_tel`, `remark`, `addtime`) VALUES (28, 7, 'Oner', 'New York', '6666666', '1', '2023-11-27 11:13:08'), (29, 7, 'Zeus', 'San Jose', '6666666', '2', '2023-11-27 22:38:15'), (30, 9, 'Faker', 'San Jose', '14127898476', '111', '2023-11-29 10:02:47'), (31, 9, 'keria', 'Los Angles', '127898476', '222', '2023-11-29 12:25:22'), (32, 10, 'jinhan jiang', 'Austin', '14127898476', '1221', '2023-11-30 16:31:33');
COMMIT;

-- ----------------------------
-- Table structure for orders_detail
-- ----------------------------
DROP TABLE IF EXISTS `orders_detail`;
CREATE TABLE `orders_detail`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `goods_id` int NULL DEFAULT NULL,
  `order_id` int NULL DEFAULT NULL,
  `number` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `goods_id`(`goods_id` ASC) USING BTREE,
  INDEX `order_id`(`order_id` ASC) USING BTREE,
  CONSTRAINT `orders_detail_ibfk_1` FOREIGN KEY (`goods_id`) REFERENCES `goods` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `orders_detail_ibfk_2` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 42 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci;

-- ----------------------------
-- Records of orders_detail
-- ----------------------------
BEGIN;
INSERT INTO `orders_detail` (`id`, `goods_id`, `order_id`, `number`) VALUES (23, 18, 28, 1), (24, 62, 29, 1), (25, 10, 29, 1), (26, 59, 30, 1), (27, 18, 30, 1), (28, 19, 30, 1), (29, 52, 30, 1), (30, 2, 30, 1), (31, 8, 30, 1), (32, 33, 30, 1), (33, 58, 31, 1), (34, 18, 31, 1), (35, 61, 31, 1), (36, 61, 31, 1), (37, 56, 31, 1), (38, 5, 31, 1), (39, 21, 31, 1), (40, 23, 31, 1), (41, 62, 32, 1);
COMMIT;

-- ----------------------------
-- Table structure for salesbrand
-- ----------------------------
DROP TABLE IF EXISTS `salesbrand`;
CREATE TABLE `salesbrand`  (
  `name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `address` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `email` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `position` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `store` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `income` decimal(18, 2) NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of salesbrand
-- ----------------------------
BEGIN;
INSERT INTO `salesbrand` (`name`, `address`, `email`, `position`, `store`, `income`) VALUES ('iPhone', 'San Jose', 'iPhone@apple.com', 'Sales Brands', 'Smartphones', 98210518.00), ('Samsung', 'Austin', 'Samsung@samsung.com', 'Sales Brands', 'Smartphones', 36339788.00), ('Huawei', 'New York', 'Huawei@hw.com', 'Sales Brands', 'Smartphones', 68050215.00), ('Macbook', 'San Jose', 'Macbook@apple.com', 'Sales Brands', 'Laptops', 90666830.00), ('ASUS', 'New York', 'ASUS@asus.com', 'Sales Brands', 'Laptops', 47501258.00), ('Thinkpad', 'New York', 'Thinkpad@lenovo.com', 'Sales Brands', 'Laptops', 48919028.00), ('Canon', 'New York', 'Canon@canon.com', 'Sales Brands', 'Cameras', 31625663.00), ('Nikon', 'Austin', 'Nikon@nikon.com', 'Sales Brands', 'Cameras', 85162083.00), ('Sony', 'Los Angles', 'SonyCamera@sony.com', 'Sales Brands', 'Cameras', 48916733.00), ('Sony', 'Los Angles', 'SonyHeadphones@sony.com', 'Sales Brands', 'Headphones', 80311619.00), ('Sennheiser', 'Austin', 'Sennheiser@sennheiser.com', 'Sales Brands', 'Headphones', 84630899.00), ('Bose', 'San Jose', 'Bose@bose.com', 'Sales Brands', 'Headphones', 23158238.00), ('Beats', 'San Jose', 'Beats@beats.com', 'Sales Brands', 'Headphones', 88173590.00);
COMMIT;

-- ----------------------------
-- Table structure for subcat
-- ----------------------------
DROP TABLE IF EXISTS `subcat`;
CREATE TABLE `subcat`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `cat_name` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `addtime` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `super_cat_id` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `super_cat_id`(`super_cat_id` ASC) USING BTREE,
  INDEX `ix_subcat_addtime`(`addtime` ASC) USING BTREE,
  CONSTRAINT `subcat_ibfk_1` FOREIGN KEY (`super_cat_id`) REFERENCES `supercat` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 41 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci;

-- ----------------------------
-- Records of subcat
-- ----------------------------
BEGIN;
INSERT INTO `subcat` (`id`, `cat_name`, `addtime`, `super_cat_id`) VALUES (27, 'iPhone', '2023-08-24 10:26:52', 14), (28, 'Samsung', '2023-08-24 10:26:52', 14), (29, 'Huawei', '2023-08-24 10:26:52', 14), (30, 'Macbook', '2023-08-24 10:26:52', 15), (31, 'ASUS', '2023-08-24 10:26:52', 15), (32, 'Thinkpad', '2023-08-24 10:26:52', 15), (33, 'Canon', '2023-08-24 10:26:52', 16), (34, 'Nikon', '2023-08-24 10:26:52', 16), (35, 'Sony', '2023-08-24 10:26:52', 16), (36, 'Sony', '2023-08-24 10:26:52', 17), (37, 'Sennheiser', '2023-08-24 10:26:52', 17), (38, 'Bose', '2023-08-24 10:26:52', 17), (40, 'Beats', '2023-08-31 22:28:52', 17);
COMMIT;

-- ----------------------------
-- Table structure for supercat
-- ----------------------------
DROP TABLE IF EXISTS `supercat`;
CREATE TABLE `supercat`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `cat_name` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `addtime` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `ix_supercat_addtime`(`addtime` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 18 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci;

-- ----------------------------
-- Records of supercat
-- ----------------------------
BEGIN;
INSERT INTO `supercat` (`id`, `cat_name`, `addtime`) VALUES (14, 'Smartphones', '2023-08-23 10:24:59'), (15, 'Laptops', '2023-08-23 10:24:59'), (16, 'Cameras', '2023-08-23 10:24:59'), (17, 'Headphones', '2023-08-23 15:35:51');
COMMIT;

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `email` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `phone` varchar(11) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `addtime` datetime NULL DEFAULT NULL,
  `password` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `consumption` decimal(10, 2) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `email`(`email` ASC) USING BTREE,
  UNIQUE INDEX `phone`(`phone` ASC) USING BTREE,
  INDEX `ix_user_addtime`(`addtime` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci;

-- ----------------------------
-- Records of user
-- ----------------------------
BEGIN;
INSERT INTO `user` (`id`, `username`, `email`, `phone`, `addtime`, `password`, `consumption`) VALUES (7, 'bhml', '666666@qq.com', '18723456789', '2023-08-23 16:45:01', 'pbkdf2:sha256:50000$nEXDkmWN$c40c5c714cddeb4ef1f11a06776c7ff5e002efdcab8c9b30a05f90237206ddf5', 0.00), (9, 'jjh', 'jiangjinhan0708@gmail.com', '18809867279', '2023-11-26 12:11:43', 'pbkdf2:sha256:50000$qqEnp5Js$056c2e774116456bdafebe1209ff07d8cd6f1605bc1d9d4bda30c5aafa918ec9', 0.00), (10, 'zijing', 'jiangjinhan079@gmail.com', '15524507319', '2023-11-30 16:30:03', 'pbkdf2:sha256:50000$L5s3nDVA$8349281a19a330c19699f17947d4ca6326f1138005a79c321656df6a6c17f72c', 0.00), (11, 'andres', 'jiangjinhan0708@outlook.com', '15524507318', '2023-11-30 20:03:01', 'pbkdf2:sha256:50000$QVCTVCa0$54cf1d8159eb1167885683d8ce0ca172763bc7a0fff2f3f8a91559bb9730b03d', 0.00), (12, 'faker', '102@pitt.edu', '15524507777', '2023-11-30 20:10:17', 'pbkdf2:sha256:50000$8dqs5zQR$9ba4d7a59125cc462b1ff2c093d5f5e2099ad04b30b0dbe7d10807b95a25182b', 0.00), (13, 'JIJ10000', 'JIJ103@pitt.edu', '4127898476', '2023-11-30 20:10:47', 'pbkdf2:sha256:50000$AxQDEyyi$e1748dd7ab7f0a53759179e426a48e663980aab1154fc8fac6dc7cedf0367828', 0.00);
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
