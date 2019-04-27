/*
Navicat MySQL Data Transfer

Source Server         : 112.124.34.189
Source Server Version : 50558
Source Host           : 112.124.34.189:3306
Source Database       : weixinAdv

Target Server Type    : MYSQL
Target Server Version : 50558
File Encoding         : 65001

Date: 2019-04-26 18:29:08
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for pw_admin
-- ----------------------------
DROP TABLE IF EXISTS `pw_admin`;
CREATE TABLE `pw_admin` (
  `admin_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户id',
  `user_name` varchar(60) NOT NULL DEFAULT '' COMMENT '用户名',
  `email` varchar(60) NOT NULL DEFAULT '' COMMENT 'email',
  `password` varchar(32) NOT NULL DEFAULT '' COMMENT '密码',
  `ec_salt` varchar(10) DEFAULT NULL COMMENT '秘钥',
  `add_time` int(11) NOT NULL DEFAULT '0' COMMENT '添加时间',
  `last_login` int(11) NOT NULL DEFAULT '0' COMMENT '最后登录时间',
  `last_ip` varchar(15) NOT NULL DEFAULT '' COMMENT '最后登录ip',
  `nav_list` text COMMENT '权限',
  `lang_type` varchar(50) NOT NULL DEFAULT '' COMMENT 'lang_type',
  `agency_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'agency_id',
  `suppliers_id` smallint(5) unsigned DEFAULT '0' COMMENT 'suppliers_id',
  `todolist` longtext COMMENT 'todolist',
  `role_id` smallint(5) DEFAULT '0' COMMENT '角色id',
  `province_id` int(8) unsigned DEFAULT '0' COMMENT '加盟商省级id',
  `city_id` int(8) unsigned DEFAULT '0' COMMENT '加盟商市级id',
  `district_id` int(8) unsigned DEFAULT '0' COMMENT '加盟商区级id',
  `code` varchar(255) DEFAULT NULL COMMENT '二维码链接id',
  `codepath` varchar(255) DEFAULT NULL COMMENT '二维码路径',
  `is_lock` int(4) DEFAULT '0' COMMENT '是否冻结账号',
  PRIMARY KEY (`admin_id`),
  UNIQUE KEY `user_name` (`user_name`) USING BTREE,
  KEY `agency_id` (`agency_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pw_admin
-- ----------------------------
INSERT INTO `pw_admin` VALUES ('1', 'admin', '1042451513@qq.com', '44b1520c64cc2f0440bfafd11a70aab2', null, '1527212212', '1556274234', '127.0.0.1', '', '', '0', '0', null, '1', '0', '0', '0', null, null, '0');
INSERT INTO `pw_admin` VALUES ('2', 'aaa', '1042451513@qq.com', '640d7b39a6d805aa0e2e23287a2043e7', null, '1527581198', '1527581198', '127.0.0.1', null, '', '0', '0', null, '1', '0', '0', '0', null, null, '0');
INSERT INTO `pw_admin` VALUES ('24', 'test', '1042451513@qq.com', '091754135bb53b30b2e1677b053afac7', null, '1527581198', '1555726826', '127.0.0.1', null, '', '0', '0', null, '2', '0', '0', '0', 'e07dee4fffab49536c822308cc8d93ce', '/public/upload/qr_code/e07dee4fffab49536c822308cc8d93ce.png', '0');

-- ----------------------------
-- Table structure for pw_admin_log
-- ----------------------------
DROP TABLE IF EXISTS `pw_admin_log`;
CREATE TABLE `pw_admin_log` (
  `log_id` bigint(16) unsigned NOT NULL AUTO_INCREMENT COMMENT '表id',
  `admin_id` int(10) DEFAULT NULL COMMENT '管理员id',
  `log_info` varchar(255) DEFAULT NULL COMMENT '日志描述',
  `log_ip` varchar(30) DEFAULT NULL COMMENT 'ip地址',
  `log_url` varchar(50) DEFAULT NULL COMMENT 'url',
  `log_time` int(10) DEFAULT NULL COMMENT '日志时间',
  `status` int(2) NOT NULL DEFAULT '1' COMMENT '登录状态 1： 成功    2：失败',
  PRIMARY KEY (`log_id`)
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pw_admin_log
-- ----------------------------
INSERT INTO `pw_admin_log` VALUES ('1', '1', '后台登录', '127.0.0.1', '/admin.php/login/index', '1555668605', '1');
INSERT INTO `pw_admin_log` VALUES ('2', '1', '后台登录', '113.111.83.73', '/admin.php/login/index', '1555669156', '1');
INSERT INTO `pw_admin_log` VALUES ('3', '1', '后台登录', '113.111.83.73', '/admin.php/login/index', '1555670026', '1');
INSERT INTO `pw_admin_log` VALUES ('4', '1', '后台登录', '113.111.83.73', '/admin.php/login/index', '1555670311', '1');
INSERT INTO `pw_admin_log` VALUES ('5', '1', '后台登录', '113.111.83.73', '/admin.php/login/index', '1555670596', '1');
INSERT INTO `pw_admin_log` VALUES ('6', '1', '后台登录', '127.0.0.1', '/admin.php/login/index', '1555674118', '1');
INSERT INTO `pw_admin_log` VALUES ('7', '1', '后台登录', '113.111.83.73', '/admin.php/login/index', '1555677680', '1');
INSERT INTO `pw_admin_log` VALUES ('8', '1', '后台登录', '113.111.83.73', '/admin.php/login/index', '1555677883', '1');
INSERT INTO `pw_admin_log` VALUES ('9', '1', '后台登录', '127.0.0.1', '/admin.php/login/index', '1555678083', '1');
INSERT INTO `pw_admin_log` VALUES ('10', '1', '后台登录', '127.0.0.1', '/admin.php/login/index', '1555679013', '2');
INSERT INTO `pw_admin_log` VALUES ('11', '1', '后台登录', '127.0.0.1', '/admin.php/login/index', '1555679025', '1');
INSERT INTO `pw_admin_log` VALUES ('12', '1', '后台登录', '127.0.0.1', '/admin.php/login/index', '1555680665', '1');
INSERT INTO `pw_admin_log` VALUES ('13', '1', '后台登录', '127.0.0.1', '/admin.php/login/index', '1555722435', '1');
INSERT INTO `pw_admin_log` VALUES ('14', '1', '后台登录', '113.111.83.73', '/admin.php/login/index', '1555722829', '1');
INSERT INTO `pw_admin_log` VALUES ('15', '1', '后台登录', '127.0.0.1', '/admin.php/login/index', '1555723060', '1');
INSERT INTO `pw_admin_log` VALUES ('16', '1', '后台登录', '127.0.0.1', '/admin.php/login/index', '1555723557', '1');
INSERT INTO `pw_admin_log` VALUES ('17', '24', '后台登录', '127.0.0.1', '/admin.php/login/index', '1555726826', '1');
INSERT INTO `pw_admin_log` VALUES ('18', '1', '后台登录', '113.111.83.73', '/admin.php/login/index', '1555730592', '1');
INSERT INTO `pw_admin_log` VALUES ('19', '1', '后台登录', '113.111.83.73', '/admin.php/login/index', '1555737386', '1');
INSERT INTO `pw_admin_log` VALUES ('20', '1', '后台登录', '112.96.167.101', '/admin.php/login/index', '1555738888', '1');
INSERT INTO `pw_admin_log` VALUES ('21', '1', '后台登录', '113.111.83.73', '/admin.php/login/index', '1555739035', '1');
INSERT INTO `pw_admin_log` VALUES ('22', '1', '后台登录', '113.111.83.73', '/admin.php/login/index', '1555739073', '1');
INSERT INTO `pw_admin_log` VALUES ('23', '1', '后台登录', '42.49.173.216', '/admin.php/login/index', '1555753373', '1');
INSERT INTO `pw_admin_log` VALUES ('24', '1', '后台登录', '59.42.123.121', '/admin.php/login/index', '1555897457', '1');
INSERT INTO `pw_admin_log` VALUES ('25', '1', '后台登录', '127.0.0.1', '/admin.php/login/index', '1555900781', '1');
INSERT INTO `pw_admin_log` VALUES ('26', '1', '后台登录', '59.42.123.121', '/admin.php/login/index', '1555912225', '1');
INSERT INTO `pw_admin_log` VALUES ('27', '1', '后台登录', '59.42.123.121', '/admin.php/login/index', '1555915040', '1');
INSERT INTO `pw_admin_log` VALUES ('28', '1', '后台登录', '59.42.123.121', '/admin.php/login/index', '1555922124', '1');
INSERT INTO `pw_admin_log` VALUES ('29', '1', '后台登录', '59.42.121.41', '/admin.php/login/index', '1556072139', '1');
INSERT INTO `pw_admin_log` VALUES ('30', '1', '后台登录', '127.0.0.1', '/admin.php/login/index', '1556076560', '1');
INSERT INTO `pw_admin_log` VALUES ('31', '1', '后台登录', '223.104.130.72', '/admin.php/login/index', '1556084192', '1');
INSERT INTO `pw_admin_log` VALUES ('32', '1', '后台登录', '59.42.121.41', '/admin.php/login/index', '1556092894', '2');
INSERT INTO `pw_admin_log` VALUES ('33', '1', '后台登录', '59.42.121.41', '/admin.php/login/index', '1556092903', '2');
INSERT INTO `pw_admin_log` VALUES ('34', '1', '后台登录', '59.42.121.41', '/admin.php/login/index', '1556092915', '1');
INSERT INTO `pw_admin_log` VALUES ('35', '1', '后台登录', '59.42.121.41', '/admin.php/login/index', '1556099079', '1');
INSERT INTO `pw_admin_log` VALUES ('36', '1', '后台登录', '42.49.173.216', '/admin.php/login/index', '1556099963', '1');
INSERT INTO `pw_admin_log` VALUES ('37', '1', '后台登录', '127.0.0.1', '/admin.php/login/index', '1556101002', '1');
INSERT INTO `pw_admin_log` VALUES ('38', '1', '后台登录', '112.96.132.114', '/admin.php/login/index', '1556115060', '1');
INSERT INTO `pw_admin_log` VALUES ('39', '1', '后台登录', '59.42.121.41', '/admin.php/login/index', '1556155125', '1');
INSERT INTO `pw_admin_log` VALUES ('40', '1', '后台登录', '127.0.0.1', '/admin.php/login/index', '1556155952', '1');
INSERT INTO `pw_admin_log` VALUES ('41', '1', '后台登录', '59.42.121.41', '/admin.php/login/index', '1556158437', '1');
INSERT INTO `pw_admin_log` VALUES ('42', '1', '后台登录', '127.0.0.1', '/admin.php/login/index', '1556158532', '1');
INSERT INTO `pw_admin_log` VALUES ('43', '1', '后台登录', '127.0.0.1', '/admin.php/login/index', '1556158617', '1');
INSERT INTO `pw_admin_log` VALUES ('44', '1', '后台登录', '113.66.34.216', '/admin.php/login/index', '1556171332', '1');
INSERT INTO `pw_admin_log` VALUES ('45', '1', '后台登录', '127.0.0.1', '/admin.php/login/index', '1556181499', '1');
INSERT INTO `pw_admin_log` VALUES ('46', '1', '后台登录', '127.0.0.1', '/admin.php/login/index', '1556184328', '1');
INSERT INTO `pw_admin_log` VALUES ('47', '1', '后台登录', '113.66.34.216', '/admin.php/login/index', '1556247275', '1');
INSERT INTO `pw_admin_log` VALUES ('48', '1', '后台登录', '113.66.34.216', '/admin.php/login/index', '1556247421', '1');
INSERT INTO `pw_admin_log` VALUES ('49', '1', '后台登录', '127.0.0.1', '/admin.php/login/index', '1556248627', '1');
INSERT INTO `pw_admin_log` VALUES ('50', '1', '后台登录', '113.66.34.216', '/admin.php/login/index', '1556259823', '2');
INSERT INTO `pw_admin_log` VALUES ('51', '1', '后台登录', '113.66.34.216', '/admin.php/login/index', '1556259830', '2');
INSERT INTO `pw_admin_log` VALUES ('52', '1', '后台登录', '113.66.34.216', '/admin.php/login/index', '1556259838', '2');
INSERT INTO `pw_admin_log` VALUES ('53', '1', '后台登录', '113.66.34.216', '/admin.php/login/index', '1556259847', '2');
INSERT INTO `pw_admin_log` VALUES ('54', '1', '后台登录', '113.66.34.216', '/admin.php/login/index', '1556259868', '1');
INSERT INTO `pw_admin_log` VALUES ('55', '1', '后台登录', '127.0.0.1', '/admin.php/login/index', '1556274216', '2');
INSERT INTO `pw_admin_log` VALUES ('56', '1', '后台登录', '127.0.0.1', '/admin.php/login/index', '1556274226', '2');
INSERT INTO `pw_admin_log` VALUES ('57', '1', '后台登录', '127.0.0.1', '/admin.php/login/index', '1556274234', '1');

-- ----------------------------
-- Table structure for pw_admin_role
-- ----------------------------
DROP TABLE IF EXISTS `pw_admin_role`;
CREATE TABLE `pw_admin_role` (
  `role_id` smallint(6) unsigned NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `role_name` varchar(30) DEFAULT NULL COMMENT '角色名称',
  `act_list` text COMMENT '权限列表',
  `role_desc` varchar(255) DEFAULT NULL COMMENT '角色描述',
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pw_admin_role
-- ----------------------------
INSERT INTO `pw_admin_role` VALUES ('1', '超级管理员', 'all', '管理全站');
INSERT INTO `pw_admin_role` VALUES ('2', '管理员', 'notuser', '除了添加用户');

-- ----------------------------
-- Table structure for pw_city
-- ----------------------------
DROP TABLE IF EXISTS `pw_city`;
CREATE TABLE `pw_city` (
  `cid` int(11) NOT NULL,
  `city` varchar(50) NOT NULL,
  `pid` int(11) DEFAULT NULL,
  PRIMARY KEY (`city`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pw_city
-- ----------------------------
INSERT INTO `pw_city` VALUES ('10', '七台河市', '10');
INSERT INTO `pw_city` VALUES ('7', '万宁市', '24');
INSERT INTO `pw_city` VALUES ('2', '三亚市', '24');
INSERT INTO `pw_city` VALUES ('4', '三明市', '14');
INSERT INTO `pw_city` VALUES ('12', '三门峡市', '17');
INSERT INTO `pw_city` VALUES ('1', '上海市', '3');
INSERT INTO `pw_city` VALUES ('11', '上饶市', '15');
INSERT INTO `pw_city` VALUES ('8', '东方市', '24');
INSERT INTO `pw_city` VALUES ('17', '东莞市', '20');
INSERT INTO `pw_city` VALUES ('5', '东营市', '16');
INSERT INTO `pw_city` VALUES ('5', '中卫市', '30');
INSERT INTO `pw_city` VALUES ('18', '中山市', '20');
INSERT INTO `pw_city` VALUES ('13', '临夏回族自治州', '21');
INSERT INTO `pw_city` VALUES ('10', '临汾市', '6');
INSERT INTO `pw_city` VALUES ('13', '临沂市', '16');
INSERT INTO `pw_city` VALUES ('8', '临沧市', '25');
INSERT INTO `pw_city` VALUES ('12', '临高县', '24');
INSERT INTO `pw_city` VALUES ('6', '丹东市', '8');
INSERT INTO `pw_city` VALUES ('11', '丽水市', '12');
INSERT INTO `pw_city` VALUES ('6', '丽江市', '25');
INSERT INTO `pw_city` VALUES ('9', '乌兰察布市', '32');
INSERT INTO `pw_city` VALUES ('3', '乌海市', '32');
INSERT INTO `pw_city` VALUES ('21', '乌苏市', '31');
INSERT INTO `pw_city` VALUES ('1', '乌鲁木齐市', '31');
INSERT INTO `pw_city` VALUES ('15', '乐东黎族自治县', '24');
INSERT INTO `pw_city` VALUES ('10', '乐山市', '22');
INSERT INTO `pw_city` VALUES ('4', '九江市', '15');
INSERT INTO `pw_city` VALUES ('16', '云林县', '7');
INSERT INTO `pw_city` VALUES ('21', '云浮市', '20');
INSERT INTO `pw_city` VALUES ('6', '五家渠市', '31');
INSERT INTO `pw_city` VALUES ('3', '五指山市', '24');
INSERT INTO `pw_city` VALUES ('15', '亳州市', '13');
INSERT INTO `pw_city` VALUES ('13', '仙桃市', '18');
INSERT INTO `pw_city` VALUES ('7', '伊 春 市', '10');
INSERT INTO `pw_city` VALUES ('18', '伊宁市', '31');
INSERT INTO `pw_city` VALUES ('6', '佛山市', '20');
INSERT INTO `pw_city` VALUES ('9', '佳木斯市', '10');
INSERT INTO `pw_city` VALUES ('17', '保亭黎族苗族自治县', '24');
INSERT INTO `pw_city` VALUES ('6', '保定市', '5');
INSERT INTO `pw_city` VALUES ('4', '保山市', '25');
INSERT INTO `pw_city` VALUES ('15', '信阳市', '17');
INSERT INTO `pw_city` VALUES ('5', '儋州市', '24');
INSERT INTO `pw_city` VALUES ('2', '克拉玛依市', '31');
INSERT INTO `pw_city` VALUES ('14', '六安市', '13');
INSERT INTO `pw_city` VALUES ('2', '六盘水市', '23');
INSERT INTO `pw_city` VALUES ('1', '兰州市', '21');
INSERT INTO `pw_city` VALUES ('11', '兴安盟', '32');
INSERT INTO `pw_city` VALUES ('9', '内江市', '22');
INSERT INTO `pw_city` VALUES ('21', '凉山彝族自治州', '22');
INSERT INTO `pw_city` VALUES ('2', '包头市', '32');
INSERT INTO `pw_city` VALUES ('1', '北京市', '1');
INSERT INTO `pw_city` VALUES ('5', '北海市', '28');
INSERT INTO `pw_city` VALUES ('3', '十堰市', '18');
INSERT INTO `pw_city` VALUES ('1', '南京市', '11');
INSERT INTO `pw_city` VALUES ('11', '南充市', '22');
INSERT INTO `pw_city` VALUES ('1', '南宁市', '28');
INSERT INTO `pw_city` VALUES ('7', '南平市', '14');
INSERT INTO `pw_city` VALUES ('15', '南投县', '7');
INSERT INTO `pw_city` VALUES ('1', '南昌市', '15');
INSERT INTO `pw_city` VALUES ('6', '南通市', '11');
INSERT INTO `pw_city` VALUES ('13', '南阳市', '17');
INSERT INTO `pw_city` VALUES ('17', '博乐市', '31');
INSERT INTO `pw_city` VALUES ('2', '厦门市', '14');
INSERT INTO `pw_city` VALUES ('4', '双鸭山市', '10');
INSERT INTO `pw_city` VALUES ('22', '台东县', '7');
INSERT INTO `pw_city` VALUES ('13', '台中县', '7');
INSERT INTO `pw_city` VALUES ('4', '台中市', '7');
INSERT INTO `pw_city` VALUES ('8', '台北县', '7');
INSERT INTO `pw_city` VALUES ('1', '台北市', '7');
INSERT INTO `pw_city` VALUES ('18', '台南县', '7');
INSERT INTO `pw_city` VALUES ('5', '台南市', '7');
INSERT INTO `pw_city` VALUES ('10', '台州市', '12');
INSERT INTO `pw_city` VALUES ('1', '合肥市', '13');
INSERT INTO `pw_city` VALUES ('8', '吉安市', '15');
INSERT INTO `pw_city` VALUES ('2', '吉林市', '9');
INSERT INTO `pw_city` VALUES ('7', '吐鲁番市', '31');
INSERT INTO `pw_city` VALUES ('11', '吕梁市', '6');
INSERT INTO `pw_city` VALUES ('3', '吴忠市', '30');
INSERT INTO `pw_city` VALUES ('16', '周口市', '17');
INSERT INTO `pw_city` VALUES ('7', '呼伦贝尔市', '32');
INSERT INTO `pw_city` VALUES ('1', '呼和浩特市', '32');
INSERT INTO `pw_city` VALUES ('11', '和田市', '31');
INSERT INTO `pw_city` VALUES ('11', '咸宁市', '18');
INSERT INTO `pw_city` VALUES ('4', '咸阳市', '27');
INSERT INTO `pw_city` VALUES ('10', '哈密市', '31');
INSERT INTO `pw_city` VALUES ('1', '哈尔滨市', '10');
INSERT INTO `pw_city` VALUES ('2', '唐山市', '5');
INSERT INTO `pw_city` VALUES ('14', '商丘市', '17');
INSERT INTO `pw_city` VALUES ('10', '商洛市', '27');
INSERT INTO `pw_city` VALUES ('9', '喀什市', '31');
INSERT INTO `pw_city` VALUES ('17', '嘉义县', '7');
INSERT INTO `pw_city` VALUES ('7', '嘉义市', '7');
INSERT INTO `pw_city` VALUES ('4', '嘉兴市', '12');
INSERT INTO `pw_city` VALUES ('5', '嘉峪关市', '21');
INSERT INTO `pw_city` VALUES ('3', '四平市', '9');
INSERT INTO `pw_city` VALUES ('4', '固原市', '30');
INSERT INTO `pw_city` VALUES ('5', '图木舒克市', '31');
INSERT INTO `pw_city` VALUES ('3', '基隆市', '7');
INSERT INTO `pw_city` VALUES ('20', '塔城市', '31');
INSERT INTO `pw_city` VALUES ('6', '大 庆 市', '10');
INSERT INTO `pw_city` VALUES ('13', '大兴安岭地区', '10');
INSERT INTO `pw_city` VALUES ('2', '大同市', '6');
INSERT INTO `pw_city` VALUES ('13', '大理白族自治州', '25');
INSERT INTO `pw_city` VALUES ('2', '大连市', '8');
INSERT INTO `pw_city` VALUES ('4', '天水市', '21');
INSERT INTO `pw_city` VALUES ('1', '天津市', '2');
INSERT INTO `pw_city` VALUES ('14', '天门市', '18');
INSERT INTO `pw_city` VALUES ('1', '太原市', '6');
INSERT INTO `pw_city` VALUES ('19', '奎屯市', '31');
INSERT INTO `pw_city` VALUES ('10', '威海市', '16');
INSERT INTO `pw_city` VALUES ('13', '娄底市', '19');
INSERT INTO `pw_city` VALUES ('9', '孝感市', '18');
INSERT INTO `pw_city` VALUES ('9', '宁德市', '14');
INSERT INTO `pw_city` VALUES ('2', '宁波市', '12');
INSERT INTO `pw_city` VALUES ('8', '安庆市', '13');
INSERT INTO `pw_city` VALUES ('9', '安康市', '27');
INSERT INTO `pw_city` VALUES ('5', '安阳市', '17');
INSERT INTO `pw_city` VALUES ('4', '安顺市', '23');
INSERT INTO `pw_city` VALUES ('10', '定安县', '24');
INSERT INTO `pw_city` VALUES ('11', '定西市', '21');
INSERT INTO `pw_city` VALUES ('9', '宜兰县', '7');
INSERT INTO `pw_city` VALUES ('13', '宜宾市', '22');
INSERT INTO `pw_city` VALUES ('5', '宜昌市', '18');
INSERT INTO `pw_city` VALUES ('9', '宜春市', '15');
INSERT INTO `pw_city` VALUES ('3', '宝鸡市', '27');
INSERT INTO `pw_city` VALUES ('17', '宣城市', '13');
INSERT INTO `pw_city` VALUES ('12', '宿州市', '13');
INSERT INTO `pw_city` VALUES ('13', '宿迁市', '11');
INSERT INTO `pw_city` VALUES ('20', '屏东县', '7');
INSERT INTO `pw_city` VALUES ('11', '屯昌县', '24');
INSERT INTO `pw_city` VALUES ('4', '山南地区', '29');
INSERT INTO `pw_city` VALUES ('6', '岳阳市', '19');
INSERT INTO `pw_city` VALUES ('14', '崇左市', '28');
INSERT INTO `pw_city` VALUES ('13', '巢湖市', '13');
INSERT INTO `pw_city` VALUES ('17', '巴中市', '22');
INSERT INTO `pw_city` VALUES ('8', '巴彦淖尔市', '32');
INSERT INTO `pw_city` VALUES ('4', '常州市', '11');
INSERT INTO `pw_city` VALUES ('7', '常德市', '19');
INSERT INTO `pw_city` VALUES ('8', '平凉市', '21');
INSERT INTO `pw_city` VALUES ('4', '平顶山市', '17');
INSERT INTO `pw_city` VALUES ('7', '广元市', '22');
INSERT INTO `pw_city` VALUES ('14', '广安市', '22');
INSERT INTO `pw_city` VALUES ('1', '广州市', '20');
INSERT INTO `pw_city` VALUES ('10', '庆阳市', '21');
INSERT INTO `pw_city` VALUES ('13', '库尔勒市', '31');
INSERT INTO `pw_city` VALUES ('10', '廊坊市', '5');
INSERT INTO `pw_city` VALUES ('6', '延安市', '27');
INSERT INTO `pw_city` VALUES ('9', '延边朝鲜族自治州', '9');
INSERT INTO `pw_city` VALUES ('2', '开封市', '17');
INSERT INTO `pw_city` VALUES ('7', '张家口市', '5');
INSERT INTO `pw_city` VALUES ('8', '张家界市', '19');
INSERT INTO `pw_city` VALUES ('7', '张掖市', '21');
INSERT INTO `pw_city` VALUES ('14', '彰化县', '7');
INSERT INTO `pw_city` VALUES ('3', '徐州市', '11');
INSERT INTO `pw_city` VALUES ('14', '德宏傣族景颇族自治州', '25');
INSERT INTO `pw_city` VALUES ('14', '德州市', '16');
INSERT INTO `pw_city` VALUES ('5', '德阳市', '22');
INSERT INTO `pw_city` VALUES ('9', '忻州市', '6');
INSERT INTO `pw_city` VALUES ('12', '怀化市', '19');
INSERT INTO `pw_city` VALUES ('15', '怒江傈傈族自治州', '25');
INSERT INTO `pw_city` VALUES ('7', '思茅市', '25');
INSERT INTO `pw_city` VALUES ('17', '恩施土家族苗族自治州', '18');
INSERT INTO `pw_city` VALUES ('11', '惠州市', '20');
INSERT INTO `pw_city` VALUES ('1', '成都市', '22');
INSERT INTO `pw_city` VALUES ('10', '扬州市', '11');
INSERT INTO `pw_city` VALUES ('8', '承德市', '5');
INSERT INTO `pw_city` VALUES ('10', '抚州市', '15');
INSERT INTO `pw_city` VALUES ('4', '抚顺市', '8');
INSERT INTO `pw_city` VALUES ('1', '拉萨市', '29');
INSERT INTO `pw_city` VALUES ('20', '揭阳市', '20');
INSERT INTO `pw_city` VALUES ('3', '攀枝花市', '22');
INSERT INTO `pw_city` VALUES ('9', '文山壮族苗族自治州', '25');
INSERT INTO `pw_city` VALUES ('6', '文昌市', '24');
INSERT INTO `pw_city` VALUES ('7', '新乡市', '17');
INSERT INTO `pw_city` VALUES ('5', '新余市', '15');
INSERT INTO `pw_city` VALUES ('11', '新竹县', '7');
INSERT INTO `pw_city` VALUES ('6', '新竹市', '7');
INSERT INTO `pw_city` VALUES ('2', '无锡市', '11');
INSERT INTO `pw_city` VALUES ('5', '日喀则地区', '29');
INSERT INTO `pw_city` VALUES ('11', '日照市', '16');
INSERT INTO `pw_city` VALUES ('1', '昆明市', '25');
INSERT INTO `pw_city` VALUES ('14', '昌吉市　', '31');
INSERT INTO `pw_city` VALUES ('14', '昌江黎族自治县', '24');
INSERT INTO `pw_city` VALUES ('3', '昌都地区', '29');
INSERT INTO `pw_city` VALUES ('5', '昭通市', '25');
INSERT INTO `pw_city` VALUES ('7', '晋中市', '6');
INSERT INTO `pw_city` VALUES ('5', '晋城市', '6');
INSERT INTO `pw_city` VALUES ('2', '景德镇市', '15');
INSERT INTO `pw_city` VALUES ('2', '曲靖市', '25');
INSERT INTO `pw_city` VALUES ('6', '朔州市', '6');
INSERT INTO `pw_city` VALUES ('13', '朝阳市', '8');
INSERT INTO `pw_city` VALUES ('5', '本溪市', '8');
INSERT INTO `pw_city` VALUES ('13', '来宾市', '28');
INSERT INTO `pw_city` VALUES ('1', '杭州市', '12');
INSERT INTO `pw_city` VALUES ('7', '松原市', '9');
INSERT INTO `pw_city` VALUES ('7', '林芝地区', '29');
INSERT INTO `pw_city` VALUES ('6', '果洛藏族自治州', '26');
INSERT INTO `pw_city` VALUES ('4', '枣庄市', '16');
INSERT INTO `pw_city` VALUES ('2', '柳州市', '28');
INSERT INTO `pw_city` VALUES ('2', '株洲市', '19');
INSERT INTO `pw_city` VALUES ('3', '桂林市', '28');
INSERT INTO `pw_city` VALUES ('10', '桃园县', '7');
INSERT INTO `pw_city` VALUES ('12', '梅州市', '20');
INSERT INTO `pw_city` VALUES ('4', '梧州市', '28');
INSERT INTO `pw_city` VALUES ('12', '楚雄彝族自治州', '25');
INSERT INTO `pw_city` VALUES ('8', '榆林市', '27');
INSERT INTO `pw_city` VALUES ('6', '武威市', '21');
INSERT INTO `pw_city` VALUES ('1', '武汉市', '18');
INSERT INTO `pw_city` VALUES ('6', '毕节地区', '23');
INSERT INTO `pw_city` VALUES ('11', '永州市', '19');
INSERT INTO `pw_city` VALUES ('7', '汉中市', '27');
INSERT INTO `pw_city` VALUES ('4', '汕头市', '20');
INSERT INTO `pw_city` VALUES ('13', '汕尾市', '20');
INSERT INTO `pw_city` VALUES ('7', '江门市', '20');
INSERT INTO `pw_city` VALUES ('16', '池州市', '13');
INSERT INTO `pw_city` VALUES ('1', '沈阳市', '8');
INSERT INTO `pw_city` VALUES ('9', '沧州市', '5');
INSERT INTO `pw_city` VALUES ('12', '河池市', '28');
INSERT INTO `pw_city` VALUES ('14', '河源市', '20');
INSERT INTO `pw_city` VALUES ('5', '泉州市', '14');
INSERT INTO `pw_city` VALUES ('9', '泰安市', '16');
INSERT INTO `pw_city` VALUES ('12', '泰州市', '11');
INSERT INTO `pw_city` VALUES ('4', '泸州市', '22');
INSERT INTO `pw_city` VALUES ('3', '洛阳市', '17');
INSERT INTO `pw_city` VALUES ('1', '济南市', '16');
INSERT INTO `pw_city` VALUES ('8', '济宁市', '16');
INSERT INTO `pw_city` VALUES ('18', '济源市', '17');
INSERT INTO `pw_city` VALUES ('2', '海东地区', '26');
INSERT INTO `pw_city` VALUES ('3', '海北藏族自治州', '26');
INSERT INTO `pw_city` VALUES ('5', '海南藏族自治州', '26');
INSERT INTO `pw_city` VALUES ('1', '海口市', '24');
INSERT INTO `pw_city` VALUES ('8', '海西蒙古族藏族自治州', '26');
INSERT INTO `pw_city` VALUES ('3', '淄博市', '16');
INSERT INTO `pw_city` VALUES ('6', '淮北市', '13');
INSERT INTO `pw_city` VALUES ('4', '淮南市', '13');
INSERT INTO `pw_city` VALUES ('8', '淮安市', '11');
INSERT INTO `pw_city` VALUES ('2', '深圳市', '20');
INSERT INTO `pw_city` VALUES ('16', '清远市', '20');
INSERT INTO `pw_city` VALUES ('3', '温州市', '12');
INSERT INTO `pw_city` VALUES ('5', '渭南市', '27');
INSERT INTO `pw_city` VALUES ('5', '湖州市', '12');
INSERT INTO `pw_city` VALUES ('3', '湘潭市', '19');
INSERT INTO `pw_city` VALUES ('14', '湘西土家族苗族自治州', '19');
INSERT INTO `pw_city` VALUES ('8', '湛江市', '20');
INSERT INTO `pw_city` VALUES ('10', '滁州市', '13');
INSERT INTO `pw_city` VALUES ('16', '滨州市', '16');
INSERT INTO `pw_city` VALUES ('11', '漯河市', '17');
INSERT INTO `pw_city` VALUES ('6', '漳州市', '14');
INSERT INTO `pw_city` VALUES ('7', '潍坊市', '16');
INSERT INTO `pw_city` VALUES ('15', '潜江市', '18');
INSERT INTO `pw_city` VALUES ('19', '潮州市', '20');
INSERT INTO `pw_city` VALUES ('9', '澄迈县', '24');
INSERT INTO `pw_city` VALUES ('21', '澎湖县', '7');
INSERT INTO `pw_city` VALUES ('1', '澳门特别行政区', '33');
INSERT INTO `pw_city` VALUES ('9', '濮阳市', '17');
INSERT INTO `pw_city` VALUES ('6', '烟台市', '16');
INSERT INTO `pw_city` VALUES ('8', '焦作市', '17');
INSERT INTO `pw_city` VALUES ('8', '牡丹江市', '10');
INSERT INTO `pw_city` VALUES ('9', '玉林市', '28');
INSERT INTO `pw_city` VALUES ('7', '玉树藏族自治州', '26');
INSERT INTO `pw_city` VALUES ('3', '玉溪市', '25');
INSERT INTO `pw_city` VALUES ('3', '珠海市', '20');
INSERT INTO `pw_city` VALUES ('18', '琼中黎族苗族自治县', '24');
INSERT INTO `pw_city` VALUES ('4', '琼海市', '24');
INSERT INTO `pw_city` VALUES ('14', '甘南藏族自治州', '21');
INSERT INTO `pw_city` VALUES ('20', '甘孜藏族自治州', '22');
INSERT INTO `pw_city` VALUES ('8', '白城市', '9');
INSERT INTO `pw_city` VALUES ('6', '白山市', '9');
INSERT INTO `pw_city` VALUES ('13', '白沙黎族自治县', '24');
INSERT INTO `pw_city` VALUES ('3', '白银市', '21');
INSERT INTO `pw_city` VALUES ('10', '百色市', '28');
INSERT INTO `pw_city` VALUES ('9', '益阳市', '19');
INSERT INTO `pw_city` VALUES ('9', '盐城市', '11');
INSERT INTO `pw_city` VALUES ('11', '盘锦市', '8');
INSERT INTO `pw_city` VALUES ('12', '眉山市', '22');
INSERT INTO `pw_city` VALUES ('2', '石嘴山市', '30');
INSERT INTO `pw_city` VALUES ('1', '石家庄市', '5');
INSERT INTO `pw_city` VALUES ('3', '石河子市　', '31');
INSERT INTO `pw_city` VALUES ('16', '神农架林区', '18');
INSERT INTO `pw_city` VALUES ('1', '福州市', '14');
INSERT INTO `pw_city` VALUES ('3', '秦皇岛市', '5');
INSERT INTO `pw_city` VALUES ('16', '米泉市', '31');
INSERT INTO `pw_city` VALUES ('10', '红河哈尼族彝族自治州', '25');
INSERT INTO `pw_city` VALUES ('6', '绍兴市', '12');
INSERT INTO `pw_city` VALUES ('12', '绥 化 市', '10');
INSERT INTO `pw_city` VALUES ('6', '绵阳市', '22');
INSERT INTO `pw_city` VALUES ('15', '聊城市', '16');
INSERT INTO `pw_city` VALUES ('10', '肇庆市', '20');
INSERT INTO `pw_city` VALUES ('2', '自贡市', '22');
INSERT INTO `pw_city` VALUES ('9', '舟山市', '12');
INSERT INTO `pw_city` VALUES ('2', '芜湖市', '13');
INSERT INTO `pw_city` VALUES ('23', '花莲县', '7');
INSERT INTO `pw_city` VALUES ('5', '苏州市', '11');
INSERT INTO `pw_city` VALUES ('12', '苗栗县', '7');
INSERT INTO `pw_city` VALUES ('9', '茂名市', '20');
INSERT INTO `pw_city` VALUES ('4', '荆州市', '18');
INSERT INTO `pw_city` VALUES ('8', '荆门市', '18');
INSERT INTO `pw_city` VALUES ('3', '莆田市', '14');
INSERT INTO `pw_city` VALUES ('12', '莱芜市', '16');
INSERT INTO `pw_city` VALUES ('17', '菏泽市', '16');
INSERT INTO `pw_city` VALUES ('3', '萍乡市', '15');
INSERT INTO `pw_city` VALUES ('8', '营口市', '8');
INSERT INTO `pw_city` VALUES ('14', '葫芦岛市', '8');
INSERT INTO `pw_city` VALUES ('3', '蚌埠市', '13');
INSERT INTO `pw_city` VALUES ('11', '衡水市', '5');
INSERT INTO `pw_city` VALUES ('4', '衡阳市', '19');
INSERT INTO `pw_city` VALUES ('8', '衢州市', '12');
INSERT INTO `pw_city` VALUES ('6', '襄樊市', '18');
INSERT INTO `pw_city` VALUES ('11', '西双版纳傣族自治州', '25');
INSERT INTO `pw_city` VALUES ('1', '西宁市', '26');
INSERT INTO `pw_city` VALUES ('1', '西安市', '27');
INSERT INTO `pw_city` VALUES ('10', '许昌市', '17');
INSERT INTO `pw_city` VALUES ('8', '贵港市', '28');
INSERT INTO `pw_city` VALUES ('1', '贵阳市', '23');
INSERT INTO `pw_city` VALUES ('11', '贺州市', '28');
INSERT INTO `pw_city` VALUES ('18', '资阳市', '22');
INSERT INTO `pw_city` VALUES ('7', '赣州市', '15');
INSERT INTO `pw_city` VALUES ('4', '赤峰市', '32');
INSERT INTO `pw_city` VALUES ('4', '辽源市', '9');
INSERT INTO `pw_city` VALUES ('10', '辽阳市', '8');
INSERT INTO `pw_city` VALUES ('15', '达州市', '22');
INSERT INTO `pw_city` VALUES ('8', '运城市', '6');
INSERT INTO `pw_city` VALUES ('7', '连云港市', '11');
INSERT INTO `pw_city` VALUES ('16', '迪庆藏族自治州', '25');
INSERT INTO `pw_city` VALUES ('5', '通化市', '9');
INSERT INTO `pw_city` VALUES ('5', '通辽市', '32');
INSERT INTO `pw_city` VALUES ('8', '遂宁市', '22');
INSERT INTO `pw_city` VALUES ('3', '遵义市', '23');
INSERT INTO `pw_city` VALUES ('5', '邢台市', '5');
INSERT INTO `pw_city` VALUES ('2', '那曲地区', '29');
INSERT INTO `pw_city` VALUES ('4', '邯郸市', '5');
INSERT INTO `pw_city` VALUES ('5', '邵阳市', '19');
INSERT INTO `pw_city` VALUES ('1', '郑州市', '17');
INSERT INTO `pw_city` VALUES ('10', '郴州市', '19');
INSERT INTO `pw_city` VALUES ('6', '鄂尔多斯市', '32');
INSERT INTO `pw_city` VALUES ('7', '鄂州市', '18');
INSERT INTO `pw_city` VALUES ('9', '酒泉市', '21');
INSERT INTO `pw_city` VALUES ('1', '重庆市', '4');
INSERT INTO `pw_city` VALUES ('7', '金华市', '12');
INSERT INTO `pw_city` VALUES ('2', '金昌市', '21');
INSERT INTO `pw_city` VALUES ('7', '钦州市', '28');
INSERT INTO `pw_city` VALUES ('12', '铁岭市', '8');
INSERT INTO `pw_city` VALUES ('5', '铜仁地区', '23');
INSERT INTO `pw_city` VALUES ('2', '铜川市', '27');
INSERT INTO `pw_city` VALUES ('7', '铜陵市', '13');
INSERT INTO `pw_city` VALUES ('1', '银川市', '30');
INSERT INTO `pw_city` VALUES ('10', '锡林郭勒盟', '32');
INSERT INTO `pw_city` VALUES ('7', '锦州市', '8');
INSERT INTO `pw_city` VALUES ('11', '镇江市', '11');
INSERT INTO `pw_city` VALUES ('1', '长春市', '9');
INSERT INTO `pw_city` VALUES ('1', '长沙市', '19');
INSERT INTO `pw_city` VALUES ('4', '长治市', '6');
INSERT INTO `pw_city` VALUES ('15', '阜康市', '31');
INSERT INTO `pw_city` VALUES ('9', '阜新市', '8');
INSERT INTO `pw_city` VALUES ('11', '阜阳市', '13');
INSERT INTO `pw_city` VALUES ('6', '防城港市', '28');
INSERT INTO `pw_city` VALUES ('15', '阳江市', '20');
INSERT INTO `pw_city` VALUES ('3', '阳泉市', '6');
INSERT INTO `pw_city` VALUES ('8', '阿克苏市', '31');
INSERT INTO `pw_city` VALUES ('22', '阿勒泰市', '31');
INSERT INTO `pw_city` VALUES ('12', '阿图什市', '31');
INSERT INTO `pw_city` VALUES ('19', '阿坝藏族羌族自治州', '22');
INSERT INTO `pw_city` VALUES ('12', '阿拉善盟', '32');
INSERT INTO `pw_city` VALUES ('4', '阿拉尔市', '31');
INSERT INTO `pw_city` VALUES ('6', '阿里地区', '29');
INSERT INTO `pw_city` VALUES ('12', '陇南市', '21');
INSERT INTO `pw_city` VALUES ('16', '陵水黎族自治县', '24');
INSERT INTO `pw_city` VALUES ('12', '随州市', '18');
INSERT INTO `pw_city` VALUES ('16', '雅安市', '22');
INSERT INTO `pw_city` VALUES ('2', '青岛市', '16');
INSERT INTO `pw_city` VALUES ('3', '鞍山市', '8');
INSERT INTO `pw_city` VALUES ('5', '韶关市', '20');
INSERT INTO `pw_city` VALUES ('1', '香港特别行政区', '34');
INSERT INTO `pw_city` VALUES ('5', '马鞍山市', '13');
INSERT INTO `pw_city` VALUES ('17', '驻马店市', '17');
INSERT INTO `pw_city` VALUES ('19', '高雄县', '7');
INSERT INTO `pw_city` VALUES ('2', '高雄市', '7');
INSERT INTO `pw_city` VALUES ('5', '鸡 西 市', '10');
INSERT INTO `pw_city` VALUES ('3', '鹤 岗 市', '10');
INSERT INTO `pw_city` VALUES ('6', '鹤壁市', '17');
INSERT INTO `pw_city` VALUES ('6', '鹰潭市', '15');
INSERT INTO `pw_city` VALUES ('10', '黄冈市', '18');
INSERT INTO `pw_city` VALUES ('4', '黄南藏族自治州', '26');
INSERT INTO `pw_city` VALUES ('9', '黄山市', '13');
INSERT INTO `pw_city` VALUES ('2', '黄石市', '18');
INSERT INTO `pw_city` VALUES ('11', '黑 河 市', '10');
INSERT INTO `pw_city` VALUES ('8', '黔东南苗族侗族自治州', '23');
INSERT INTO `pw_city` VALUES ('9', '黔南布依族苗族自治州', '23');
INSERT INTO `pw_city` VALUES ('7', '黔西南布依族苗族自治州', '23');
INSERT INTO `pw_city` VALUES ('2', '齐齐哈尔市', '10');
INSERT INTO `pw_city` VALUES ('8', '龙岩市', '14');

-- ----------------------------
-- Table structure for pw_config
-- ----------------------------
DROP TABLE IF EXISTS `pw_config`;
CREATE TABLE `pw_config` (
  `id` smallint(6) unsigned NOT NULL AUTO_INCREMENT COMMENT '表id',
  `name` varchar(50) DEFAULT NULL COMMENT '配置的key键名',
  `value` varchar(512) DEFAULT NULL COMMENT '配置的val值',
  `inc_type` varchar(64) DEFAULT NULL COMMENT '配置分组',
  `desc` varchar(50) DEFAULT NULL COMMENT '描述',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=165 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pw_config
-- ----------------------------
INSERT INTO `pw_config` VALUES ('1', 'site_url', 'http://www.tpshop.cn', 'shop_info', null);
INSERT INTO `pw_config` VALUES ('2', 'record_no', '粤ICP备123456号', 'shop_info', null);
INSERT INTO `pw_config` VALUES ('3', 'store_name', 'TPshop开源商城', 'shop_info', null);
INSERT INTO `pw_config` VALUES ('5', 'store_title', '开源商城 | B2C商城 | B2B2C商城 | 三级分销 | 免费商城 | 多用户商城 | tpshop｜thinkphp shop｜TPshop 免费开源系统 | 微商城', 'shop_info', null);
INSERT INTO `pw_config` VALUES ('6', 'store_desc', 'TPshop 开源商城 tpshop thinkphp shop B2C商城 B2B2C商城 三级分销 免费商城  微商城 多用户商城 免费开源系统', 'shop_info', null);
INSERT INTO `pw_config` VALUES ('7', 'store_keyword', '开源商城 B2C商城  B2B2C商城  三级分销  多用户商城  免费商城  微商城', 'shop_info', null);
INSERT INTO `pw_config` VALUES ('55', 'auto_confirm_date', '1', 'shopping', null);
INSERT INTO `pw_config` VALUES ('8', 'contact', '张小姐', 'shop_info', null);
INSERT INTO `pw_config` VALUES ('9', 'phone', '0744-12345678', 'shop_info', null);
INSERT INTO `pw_config` VALUES ('10', 'address', '南山区西丽镇留仙大道1001号', 'shop_info', null);
INSERT INTO `pw_config` VALUES ('11', 'qq', '123456789', 'shop_info', null);
INSERT INTO `pw_config` VALUES ('12', 'qq2', '123456789', 'shop_info', null);
INSERT INTO `pw_config` VALUES ('13', 'qq3', '123456789', 'shop_info', null);
INSERT INTO `pw_config` VALUES ('14', 'freight_free', '0', 'shopping', null);
INSERT INTO `pw_config` VALUES ('15', 'point_rate', '10', 'shopping', null);
INSERT INTO `pw_config` VALUES ('16', 'is_mark', '1', 'water', null);
INSERT INTO `pw_config` VALUES ('17', 'mark_txt', 'Tpshop商城', 'water', null);
INSERT INTO `pw_config` VALUES ('18', 'mark_img', '/public/upload/water/2018/01-26/9da13305eb67822d8403b13d7fc29827.png', 'water', null);
INSERT INTO `pw_config` VALUES ('19', 'mark_width', '40', 'water', null);
INSERT INTO `pw_config` VALUES ('20', 'mark_height', '40', 'water', null);
INSERT INTO `pw_config` VALUES ('21', 'mark_degree', '40', 'water', null);
INSERT INTO `pw_config` VALUES ('22', 'mark_quality', '100', 'water', null);
INSERT INTO `pw_config` VALUES ('23', 'sel', '9', 'water', null);
INSERT INTO `pw_config` VALUES ('24', 'sms_url', 'https://yunpan.cn/OcRgiKWxZFmjSJ', 'sms', null);
INSERT INTO `pw_config` VALUES ('25', 'sms_user', '', 'sms', null);
INSERT INTO `pw_config` VALUES ('26', 'sms_pwd', '访问密码 080e', 'sms', null);
INSERT INTO `pw_config` VALUES ('27', 'regis_sms_enable', '1', 'sms', null);
INSERT INTO `pw_config` VALUES ('28', 'sms_time_out', '300', 'sms', null);
INSERT INTO `pw_config` VALUES ('29', 'reg_integral', '100', 'basic', null);
INSERT INTO `pw_config` VALUES ('30', 'file_size', '2', 'basic', null);
INSERT INTO `pw_config` VALUES ('31', 'default_storage', '100', 'basic', null);
INSERT INTO `pw_config` VALUES ('32', 'warning_storage', '10', 'basic', null);
INSERT INTO `pw_config` VALUES ('33', 'tax', '6', 'basic', null);
INSERT INTO `pw_config` VALUES ('34', 'is_remind', '0', 'basic', null);
INSERT INTO `pw_config` VALUES ('35', 'order_finish_time', '', 'basic', null);
INSERT INTO `pw_config` VALUES ('36', 'order_cancel_time', '', 'basic', null);
INSERT INTO `pw_config` VALUES ('37', 'hot_keywords', '手机|小米|iphone|三星|华为|冰箱', 'basic', null);
INSERT INTO `pw_config` VALUES ('38', '__hash__', '8d9fea07e44955760d3407524e469255_6ac8706878aa807db7ffb09dd0b02453', 'sms', null);
INSERT INTO `pw_config` VALUES ('116', 'store_logo', '/public/upload/logo/2018/04-09/814d7e9a0eddcf3754f2e8373a50a19c.png', 'shop_info', null);
INSERT INTO `pw_config` VALUES ('40', 'app_test', '0', 'basic', null);
INSERT INTO `pw_config` VALUES ('41', 'switch', '1', 'distribut', null);
INSERT INTO `pw_config` VALUES ('42', 'condition', '0', 'distribut', null);
INSERT INTO `pw_config` VALUES ('43', 'name', '我的分销商', 'distribut', null);
INSERT INTO `pw_config` VALUES ('44', 'pattern', '0', 'distribut', null);
INSERT INTO `pw_config` VALUES ('45', 'order_rate', '20', 'distribut', null);
INSERT INTO `pw_config` VALUES ('46', 'first_name', '一级分销', 'distribut', null);
INSERT INTO `pw_config` VALUES ('47', 'first_rate', '70', 'distribut', null);
INSERT INTO `pw_config` VALUES ('48', 'second_name', '二级分销', 'distribut', null);
INSERT INTO `pw_config` VALUES ('49', 'second_rate', '20', 'distribut', null);
INSERT INTO `pw_config` VALUES ('50', 'third_name', '三级分销', 'distribut', null);
INSERT INTO `pw_config` VALUES ('51', 'third_rate', '10', 'distribut', null);
INSERT INTO `pw_config` VALUES ('52', 'date', '1', 'distribut', null);
INSERT INTO `pw_config` VALUES ('53', 'need', '100', 'basic', null);
INSERT INTO `pw_config` VALUES ('54', 'min', '50', 'basic', null);
INSERT INTO `pw_config` VALUES ('56', 'sms_appkey', '123456', 'sms', null);
INSERT INTO `pw_config` VALUES ('57', 'sms_secretKey', '123456', 'sms', null);
INSERT INTO `pw_config` VALUES ('58', 'sms_product', 'TPshop 开源商城', 'sms', null);
INSERT INTO `pw_config` VALUES ('59', 'sms_templateCode', 'SMS_101234567890', 'sms', null);
INSERT INTO `pw_config` VALUES ('60', 'smpw_server', 'ssl://smtp.qq.com', 'smtp', null);
INSERT INTO `pw_config` VALUES ('61', 'smpw_port', '465', 'smtp', null);
INSERT INTO `pw_config` VALUES ('62', 'smpw_user', '123456@qq.com', 'smtp', null);
INSERT INTO `pw_config` VALUES ('63', 'smpw_pwd', '123456', 'smtp', null);
INSERT INTO `pw_config` VALUES ('64', 'regis_smpw_enable', '1', 'smtp', null);
INSERT INTO `pw_config` VALUES ('65', 'test_eamil', '123456@qq.com', 'smtp', null);
INSERT INTO `pw_config` VALUES ('66', 'mobile', '12345678911', 'shop_info', null);
INSERT INTO `pw_config` VALUES ('67', 'province', '636', 'shop_info', null);
INSERT INTO `pw_config` VALUES ('68', 'city', '1188', 'shop_info', null);
INSERT INTO `pw_config` VALUES ('69', 'district', '1218', 'shop_info', null);
INSERT INTO `pw_config` VALUES ('70', 'forget_pwd_sms_enable', '1', 'sms', null);
INSERT INTO `pw_config` VALUES ('71', 'bind_mobile_sms_enable', '1', 'sms', null);
INSERT INTO `pw_config` VALUES ('72', 'order_add_sms_enable', '0', 'sms', null);
INSERT INTO `pw_config` VALUES ('73', 'order_pay_sms_enable', '0', 'sms', null);
INSERT INTO `pw_config` VALUES ('74', 'order_shipping_sms_enable', '0', 'sms', null);
INSERT INTO `pw_config` VALUES ('75', 'form_submit', 'ok', 'distribut', null);
INSERT INTO `pw_config` VALUES ('76', 'form_submit', 'ok', 'shop_info', null);
INSERT INTO `pw_config` VALUES ('78', 'reduce', '2', 'shopping', null);
INSERT INTO `pw_config` VALUES ('77', 'form_submit', 'ok', 'shopping', null);
INSERT INTO `pw_config` VALUES ('79', 'form_submit', 'ok', '', null);
INSERT INTO `pw_config` VALUES ('80', 'reg_integral', '100', '', null);
INSERT INTO `pw_config` VALUES ('81', 'file_size', '2', 'basic', null);
INSERT INTO `pw_config` VALUES ('82', 'default_storage', '100', 'basic', null);
INSERT INTO `pw_config` VALUES ('84', 'need', '100', 'basic', null);
INSERT INTO `pw_config` VALUES ('85', 'min', '50', 'basic', null);
INSERT INTO `pw_config` VALUES ('86', 'tax', '6', '', null);
INSERT INTO `pw_config` VALUES ('87', 'hot_keywords', '手机|小米|iphone|三星|华为|冰箱', 'basic', null);
INSERT INTO `pw_config` VALUES ('88', 'point_min_limit', '10', 'shopping', null);
INSERT INTO `pw_config` VALUES ('89', 'point_use_percent', '100', 'shopping', null);
INSERT INTO `pw_config` VALUES ('90', 'inc_type', 'smtp', 'smtp', null);
INSERT INTO `pw_config` VALUES ('91', 'mark_type', 'text', 'water', null);
INSERT INTO `pw_config` VALUES ('92', 'need', '100', 'basic', null);
INSERT INTO `pw_config` VALUES ('93', 'min', '50', 'basic', null);
INSERT INTO `pw_config` VALUES ('115', 'integral_use_enable', '1', 'shopping', null);
INSERT INTO `pw_config` VALUES ('94', 'form_submit', 'ok', 'push', null);
INSERT INTO `pw_config` VALUES ('95', 'jpush_app_key', '123456', 'push', null);
INSERT INTO `pw_config` VALUES ('96', 'jpush_master_secret', '123456', 'push', null);
INSERT INTO `pw_config` VALUES ('98', 'sms_platform', '2', 'sms', null);
INSERT INTO `pw_config` VALUES ('99', 'form_submit', 'ok', 'oss', null);
INSERT INTO `pw_config` VALUES ('100', 'oss_key_id', '123456', 'oss', null);
INSERT INTO `pw_config` VALUES ('101', 'oss_key_secret', '1', 'oss', null);
INSERT INTO `pw_config` VALUES ('102', 'oss_endpoint', 'oss-cn-shenzhen.aliyuncs.com', 'oss', null);
INSERT INTO `pw_config` VALUES ('103', 'oss_bucket', 'how1', 'oss', null);
INSERT INTO `pw_config` VALUES ('104', 'android_app_path', 'public/upload/appfile/androidapp_0.12.1_170706_104041.apk', 'mobile_app', null);
INSERT INTO `pw_config` VALUES ('105', 'android_app_version', '0.12.1', 'mobile_app', null);
INSERT INTO `pw_config` VALUES ('106', 'android_app_log', '测试日记', 'mobile_app', null);
INSERT INTO `pw_config` VALUES ('107', 'oss_switch', '0', 'oss', null);
INSERT INTO `pw_config` VALUES ('110', 'qrcode_menu_word', 'distribut_qrcode', 'distribut', null);
INSERT INTO `pw_config` VALUES ('108', 'mark_txt_size', '12', 'water', null);
INSERT INTO `pw_config` VALUES ('109', 'mark_txt_color', '#000000', 'water', null);
INSERT INTO `pw_config` VALUES ('111', 'qrcode_input_word', '我的二维码', 'distribut', null);
INSERT INTO `pw_config` VALUES ('112', 'qr_back', '/public/upload/weixin/2017/10-27/e9823d589b202818c86511be60a6b65a.jpg', 'distribut', null);
INSERT INTO `pw_config` VALUES ('113', 'qr_big_back', '/public/upload/weixin/2017/10-27/ddbf260c88c706b38473dc6972b66c42.jpg', 'distribut', null);
INSERT INTO `pw_config` VALUES ('114', 'auto_service_date', '16', 'shopping', null);
INSERT INTO `pw_config` VALUES ('117', 'invite', '1', 'basic', null);
INSERT INTO `pw_config` VALUES ('118', 'invite_integral', '200', 'basic', null);
INSERT INTO `pw_config` VALUES ('125', 'store_ico', '/public/upload/logo/2018/04-09/516bc70315079d81dc3726991672b4af.png', 'shop_info', null);
INSERT INTO `pw_config` VALUES ('119', 'store_user_logo', '/public/upload/logo/2018/04-17/570c1284f663ce3fad34e819d430b428.png', 'shop_info', null);
INSERT INTO `pw_config` VALUES ('120', 'sign_on_off', '1', 'sign', null);
INSERT INTO `pw_config` VALUES ('121', 'sign_integral', '10', 'sign', null);
INSERT INTO `pw_config` VALUES ('122', 'sign_signcount', '7', 'sign', null);
INSERT INTO `pw_config` VALUES ('123', 'sign_award', '20', 'sign', null);
INSERT INTO `pw_config` VALUES ('124', 'own_rate', '10', 'distribut', null);
INSERT INTO `pw_config` VALUES ('126', 'regrade', '1', 'distribut', null);
INSERT INTO `pw_config` VALUES ('127', 'rechargevip_on_off', '1', 'basic', null);
INSERT INTO `pw_config` VALUES ('128', 'rechargevip_price', '1', 'basic', null);
INSERT INTO `pw_config` VALUES ('129', 'rechargevip_rebate_on_off', '0', 'basic', null);
INSERT INTO `pw_config` VALUES ('130', 'rechargevip_rebate', '1', 'basic', null);
INSERT INTO `pw_config` VALUES ('131', 'is_bind_account', '0', 'basic', null);
INSERT INTO `pw_config` VALUES ('132', 'virtual_goods_sms_enable', '1', 'sms', null);
INSERT INTO `pw_config` VALUES ('133', 'form_submit', 'ok', 'kdniao', null);
INSERT INTO `pw_config` VALUES ('134', 'kdniao_switch', '1', 'kdniao', null);
INSERT INTO `pw_config` VALUES ('135', 'kdniao_id', '123456', 'express', null);
INSERT INTO `pw_config` VALUES ('136', 'kdniao_key', '123456', 'express', null);
INSERT INTO `pw_config` VALUES ('137', 'form_submit', 'ok', 'express', null);
INSERT INTO `pw_config` VALUES ('138', 'express_switch', '0', 'express', null);
INSERT INTO `pw_config` VALUES ('139', 'kd100_key', '123456', 'express', null);
INSERT INTO `pw_config` VALUES ('140', 'kdniao_id', '123456', 'express', null);
INSERT INTO `pw_config` VALUES ('141', 'kdniao_key', '123456', 'express', null);
INSERT INTO `pw_config` VALUES ('142', 'admin_login_logo', '/public/static/images/logo/admin_login_logo_default.png', 'shop_info', null);
INSERT INTO `pw_config` VALUES ('143', 'admin_home_logo', '/public/upload/logo/2018/04-10/da91523a817bc5adcb2c4c123bbf6e3f.png', 'shop_info', null);
INSERT INTO `pw_config` VALUES ('144', 'wap_home_logo', '/public/static/images/logo/wap_home_logo_default.png', 'shop_info', null);
INSERT INTO `pw_config` VALUES ('145', 'wap_login_logo', '/public/upload/logo/2018/03-16/f3e95de4bf31b237ee7ca125053f84b8.png', 'shop_info', null);
INSERT INTO `pw_config` VALUES ('146', 'mark_txt', '123', 'water', null);
INSERT INTO `pw_config` VALUES ('147', 'store_name', '广告上墙管理系统', 'shop_info', null);
INSERT INTO `pw_config` VALUES ('148', 'store_title', '广告上墙管理系统', 'shop_info', null);
INSERT INTO `pw_config` VALUES ('149', 'store_desc', '广告上墙管理系统', 'shop_info', null);
INSERT INTO `pw_config` VALUES ('150', 'store_keyword', '广告上墙管理系统', 'shop_info', null);
INSERT INTO `pw_config` VALUES ('151', 'store_name', '邂倾城 | 广告上墙', 'shop_info', null);
INSERT INTO `pw_config` VALUES ('152', 'store_title', '邂倾城 | 广告上墙', 'shop_info', null);
INSERT INTO `pw_config` VALUES ('153', 'store_desc', '邂倾城 | 广告上墙', 'shop_info', null);
INSERT INTO `pw_config` VALUES ('154', 'store_keyword', '邂倾城 | 广告上墙', 'shop_info', null);
INSERT INTO `pw_config` VALUES ('155', 'is_bind_account', '1', 'basic', null);
INSERT INTO `pw_config` VALUES ('156', 'store_logo', '/UPLOAD_PATHlogo/2018/11-27/35781e2e8d737b27dfb3b3684325169c.jpg', 'shop_info', null);
INSERT INTO `pw_config` VALUES ('157', 'store_logo', '/UPLOAD_PATHlogo/2018/11-27/8fb3a7e99ac463705a639006446159c4.jpg', 'shop_info', null);
INSERT INTO `pw_config` VALUES ('158', 'store_logo', '/public/upload/logo/2018/11-27/56dd8e2b705b120a50c028914f48bdba.jpg', 'shop_info', null);
INSERT INTO `pw_config` VALUES ('159', 'default_time_coe', '{starttime:0,endtime:28800,price:3};{starttime:28800,endtime:64800,price:5};{starttime:64800,endtime:86340,price:8}', 'ad_info', null);
INSERT INTO `pw_config` VALUES ('160', 'default_time_coe', '{starttime:0,endtime:28800,price:3};{starttime:28800,endtime:64800,price:5};{starttime:64800,endtime:72000,price:8};{starttime:72000,endtime:86340,price:10}', 'ad_info', null);
INSERT INTO `pw_config` VALUES ('161', 'store_name', '上墙广告系统', 'shop_info', null);
INSERT INTO `pw_config` VALUES ('162', 'store_title', '上墙广告系统', 'shop_info', null);
INSERT INTO `pw_config` VALUES ('163', 'store_desc', '上墙广告系统', 'shop_info', null);
INSERT INTO `pw_config` VALUES ('164', 'store_keyword', '上墙广告系统', 'shop_info', null);

-- ----------------------------
-- Table structure for pw_email_log
-- ----------------------------
DROP TABLE IF EXISTS `pw_email_log`;
CREATE TABLE `pw_email_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '发送标题',
  `content` text CHARACTER SET utf8 COMMENT '发送内容',
  `email` varchar(80) CHARACTER SET utf8 DEFAULT NULL COMMENT '发送的邮箱',
  `sendtime` int(11) DEFAULT '0' COMMENT '邮件发送时间',
  `adminid` int(8) DEFAULT '1' COMMENT '发送给的管理员id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- ----------------------------
-- Records of pw_email_log
-- ----------------------------
INSERT INTO `pw_email_log` VALUES ('12', '{$title}', '{$content}', '{$postuser}', '0', '0');
INSERT INTO `pw_email_log` VALUES ('13', '{$title}', '{$content}', '{$postuser}', '0', '0');
INSERT INTO `pw_email_log` VALUES ('14', 'fdsafdsa', 'fdsfdsafdsa', 'fdsafdsf', '0', '0');
INSERT INTO `pw_email_log` VALUES ('15', ' 跳转网址被封 ', '123213', '123432', '12321321', '1');
INSERT INTO `pw_email_log` VALUES ('16', ' 跳转网址被封 ', '12343214', '1042451513@qq.com', '1556302095', '1');
INSERT INTO `pw_email_log` VALUES ('17', ' 跳转网址被封 ', '尊敬的管理员:&amp;amp;nbsp;&amp;amp;nbsp;&amp;amp;nbsp;&amp;amp;nbsp;您好，您的跳转域名：http://op1955.com已被微信检测违法，请替换跳转域名，以免影响您的正常使用', '1042451513@qq.com', '1556302276', '1');
INSERT INTO `pw_email_log` VALUES ('18', ' 跳转网址被封 ', '尊敬的管理员:&amp;amp;nbsp;&amp;amp;nbsp;&amp;amp;nbsp;&amp;amp;nbsp;您好，您的跳转域名：www.powu.com已被微信检测违法，请替换跳转域名，以免影响您的正常使用', '1042451513@qq.com', '1556302310', '1');

-- ----------------------------
-- Table structure for pw_jump_type
-- ----------------------------
DROP TABLE IF EXISTS `pw_jump_type`;
CREATE TABLE `pw_jump_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(50) CHARACTER SET utf8 NOT NULL COMMENT '项目标题',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- ----------------------------
-- Records of pw_jump_type
-- ----------------------------
INSERT INTO `pw_jump_type` VALUES ('1', '顺序跳转');
INSERT INTO `pw_jump_type` VALUES ('2', '随机跳转');
INSERT INTO `pw_jump_type` VALUES ('3', '直接跳转');
INSERT INTO `pw_jump_type` VALUES ('4', '随机直接跳转');

-- ----------------------------
-- Table structure for pw_jump_url
-- ----------------------------
DROP TABLE IF EXISTS `pw_jump_url`;
CREATE TABLE `pw_jump_url` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) DEFAULT '0' COMMENT '所属项目id',
  `url` varchar(250) CHARACTER SET utf8 DEFAULT NULL COMMENT '跳出网址',
  `status` tinyint(1) unsigned DEFAULT '1' COMMENT '被封状态(1正常,2被封)',
  `createtime` int(11) DEFAULT NULL COMMENT '创建时间',
  `mark` varchar(100) CHARACTER SET utf8 DEFAULT NULL COMMENT '项目备注',
  `isuse` tinyint(1) DEFAULT '1' COMMENT '是否使用。1使用2禁用',
  `isdefault` tinyint(1) DEFAULT '2' COMMENT '是否默认：1默认2不是默认',
  `adminid` int(8) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- ----------------------------
-- Records of pw_jump_url
-- ----------------------------
INSERT INTO `pw_jump_url` VALUES ('3', '2', 'http://www.liruhu.com', '1', '1555570663', '', '1', '2', '1');
INSERT INTO `pw_jump_url` VALUES ('9', '3', 'http://www.baidu.com', '1', '1555671524', '', '2', '2', '1');
INSERT INTO `pw_jump_url` VALUES ('11', '6', 'http://www.liruhu.com', '1', '1555727146', '', '1', '2', '24');
INSERT INTO `pw_jump_url` VALUES ('12', '6', 'http://www.abc.com', '1', '1555727299', '', '1', '2', '24');
INSERT INTO `pw_jump_url` VALUES ('13', '6', 'http://www.c.com', '1', '1555727418', 'ry65 u7', '1', '2', '24');
INSERT INTO `pw_jump_url` VALUES ('14', '7', 'https://www.lyilife.com/m/index', '1', '1555739210', '', '1', '2', '1');
INSERT INTO `pw_jump_url` VALUES ('15', '2', 'http://www.baidu.com', '1', '1555739314', '', '2', '1', '1');
INSERT INTO `pw_jump_url` VALUES ('18', '7', 'http://op1955.com', '2', '1555754212', '', '1', '2', '1');
INSERT INTO `pw_jump_url` VALUES ('19', '7', 'http://baidu.com', '1', '1555754363', '', '1', '2', '1');
INSERT INTO `pw_jump_url` VALUES ('20', '8', 'http://baidu.com', '1', '1556100200', '', '2', '1', '1');
INSERT INTO `pw_jump_url` VALUES ('21', '8', 'http://360.cn', '1', '1556100232', '', '2', '2', '1');
INSERT INTO `pw_jump_url` VALUES ('22', '8', 'http://jd.com', '1', '1556100253', '', '1', '2', '1');
INSERT INTO `pw_jump_url` VALUES ('30', '3', 'http://www.liruhu.com', '1', '1556179607', '', '2', '1', '1');
INSERT INTO `pw_jump_url` VALUES ('40', '9', 'http://www.baidu.com', '1', '1556184831', '', '1', '2', '1');
INSERT INTO `pw_jump_url` VALUES ('41', '9', 'http://www.qq.com', '1', '1556184839', '', '1', '2', '1');
INSERT INTO `pw_jump_url` VALUES ('42', '9', 'http://www.360.cn', '1', '1556184855', '', '1', '2', '1');
INSERT INTO `pw_jump_url` VALUES ('44', '3', 'http://www.ii.com', '1', '1556186075', '', '1', '2', '1');

-- ----------------------------
-- Table structure for pw_own_url
-- ----------------------------
DROP TABLE IF EXISTS `pw_own_url`;
CREATE TABLE `pw_own_url` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `url` varchar(250) CHARACTER SET utf8 DEFAULT NULL COMMENT '自有域名',
  `status` tinyint(1) DEFAULT '1' COMMENT '被封状态(1正常,2被封)',
  `hit` int(11) DEFAULT '0' COMMENT '访问量',
  `adminid` int(8) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=67 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- ----------------------------
-- Records of pw_own_url
-- ----------------------------
INSERT INTO `pw_own_url` VALUES ('1', 'www.powu.com', '1', '0', '1');
INSERT INTO `pw_own_url` VALUES ('2', 'www.baidu.com', '1', '0', '1');
INSERT INTO `pw_own_url` VALUES ('4', 'wwww.xunsa.com', '1', '0', '1');
INSERT INTO `pw_own_url` VALUES ('9', 'www.rr.com', '1', '0', '1');
INSERT INTO `pw_own_url` VALUES ('10', 'www.yy.com', '1', '0', '1');
INSERT INTO `pw_own_url` VALUES ('11', 'www.m.com', '1', '0', '1');
INSERT INTO `pw_own_url` VALUES ('12', 'www.c.com', '1', '0', '1');
INSERT INTO `pw_own_url` VALUES ('14', 'http://testss.mudaxi.com', '1', '0', '1');
INSERT INTO `pw_own_url` VALUES ('15', 'www.t.com', '1', '0', '24');
INSERT INTO `pw_own_url` VALUES ('16', 'www.m.com', '1', '0', '24');
INSERT INTO `pw_own_url` VALUES ('17', 'www.xunsa.com', '1', '0', '24');
INSERT INTO `pw_own_url` VALUES ('61', 'op1955.com', '2', '0', '1');

-- ----------------------------
-- Table structure for pw_portal_url
-- ----------------------------
DROP TABLE IF EXISTS `pw_portal_url`;
CREATE TABLE `pw_portal_url` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) DEFAULT '0' COMMENT '所属项目id',
  `url` varchar(250) CHARACTER SET utf8 DEFAULT NULL COMMENT '推广网址',
  `localpath` varchar(250) COLLATE utf8mb4_bin NOT NULL COMMENT '项目文件路径',
  `status` tinyint(1) unsigned DEFAULT '1' COMMENT '被封状态(1正常,2被封)',
  `createtime` int(11) DEFAULT NULL COMMENT '创建时间',
  `mark` varchar(100) CHARACTER SET utf8 DEFAULT NULL COMMENT '项目备注',
  `hit` int(11) DEFAULT '0' COMMENT '点击量',
  `isuse` tinyint(1) DEFAULT '1' COMMENT '使用状态，1启用，2禁用',
  `adminid` int(8) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=96 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- ----------------------------
-- Records of pw_portal_url
-- ----------------------------
INSERT INTO `pw_portal_url` VALUES ('55', '6', 'http://www.t.com/jz9kf6i.html', '', '1', '1555727121', '', '61', '1', '24');
INSERT INTO `pw_portal_url` VALUES ('56', '6', 'http://www.m.com/wr8uq.html', '', '2', '1555727126', '', '0', '1', '24');
INSERT INTO `pw_portal_url` VALUES ('57', '6', 'http://www.xunsa.com/d2gwnid5u.html', '', '1', '1555727133', '', '0', '1', '24');
INSERT INTO `pw_portal_url` VALUES ('80', '3', 'http://testss.mudaxi.com/admin/a/j/P2oYzNjg9H', 'P2oYzNjg9H', '1', '1556073627', '', '42', '1', '1');
INSERT INTO `pw_portal_url` VALUES ('81', '3', 'http://testss.mudaxi.com/admin/a/j/tlMnPjAaxr', 'tlMnPjAaxr', '1', '1556073680', '', '32', '1', '1');
INSERT INTO `pw_portal_url` VALUES ('82', '7', 'http://testss.mudaxi.com/admin/a/j/joM4uJU83v', 'joM4uJU83v', '1', '1556099980', '', '0', '1', '1');
INSERT INTO `pw_portal_url` VALUES ('83', '2', 'op1955.com/admin/a/j/RGOghKDyoz', 'RGOghKDyoz', '1', '1556100008', '', '0', '1', '1');
INSERT INTO `pw_portal_url` VALUES ('84', '8', 'http://testss.mudaxi.com/admin/a/j/wkDU6gs1xh', 'wkDU6gs1xh', '1', '1556100168', '', '19', '1', '1');
INSERT INTO `pw_portal_url` VALUES ('85', '2', 'http://testss.mudaxi.com/admin/a/j/bKtMQgNOVy', 'bKtMQgNOVy', '1', '1556101630', '', '16', '1', '1');
INSERT INTO `pw_portal_url` VALUES ('86', '2', 'http://testss.mudaxi.com/admin/a/j/lLEOy8wTS7', 'lLEOy8wTS7', '1', '1556115085', '', '10', '1', '1');
INSERT INTO `pw_portal_url` VALUES ('88', '3', 'http://testss.mudaxi.com/admin/a/j/NsITDLicbh', 'NsITDLicbh', '1', '1556158460', '', '28', '2', '1');
INSERT INTO `pw_portal_url` VALUES ('89', '3', 'http://testss.mudaxi.com/admin/a/j/sUvIGbjmaR', 'sUvIGbjmaR', '1', '1556180270', '', '1', '2', '1');
INSERT INTO `pw_portal_url` VALUES ('90', '9', 'http://testss.mudaxi.com/admin/a/j/rbcPqOQR6G', 'rbcPqOQR6G', '1', '1556184809', '', '76', '1', '1');
INSERT INTO `pw_portal_url` VALUES ('91', '9', 'www.m.com/admin/a/j/NGQMh4LOdA', 'NGQMh4LOdA', '1', '1556185461', '', '0', '1', '1');
INSERT INTO `pw_portal_url` VALUES ('92', '9', 'wwww.xunsa.com/admin/a/j/94Uicj3Vgr', '94Uicj3Vgr', '1', '1556185475', '', '0', '1', '1');

-- ----------------------------
-- Table structure for pw_project
-- ----------------------------
DROP TABLE IF EXISTS `pw_project`;
CREATE TABLE `pw_project` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(50) CHARACTER SET utf8 NOT NULL COMMENT '项目标题',
  `url` varchar(250) CHARACTER SET utf8 DEFAULT NULL COMMENT '默认出口域名',
  `status` tinyint(1) unsigned DEFAULT '1' COMMENT '被封状态(1正常,2被封)',
  `createtime` int(11) DEFAULT NULL COMMENT '创建时间',
  `mark` varchar(100) CHARACTER SET utf8 DEFAULT NULL COMMENT '项目备注',
  `jumptype` tinyint(1) DEFAULT '1' COMMENT '跳转方式：1顺序2随机3直接4随机直接',
  `adminid` int(8) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- ----------------------------
-- Records of pw_project
-- ----------------------------
INSERT INTO `pw_project` VALUES ('2', '迫无', null, '1', '1555495912', null, '1', '1');
INSERT INTO `pw_project` VALUES ('3', '场景2', null, '1', '1555553728', null, '3', '1');
INSERT INTO `pw_project` VALUES ('5', '1232', null, '1', '1555646093', null, '2', '1');
INSERT INTO `pw_project` VALUES ('6', '测试1', null, '1', '1555726956', null, '2', '24');
INSERT INTO `pw_project` VALUES ('7', '跳转，', null, '1', '1555739119', null, '1', '1');
INSERT INTO `pw_project` VALUES ('8', 'shenghuo', null, '1', '1556100158', null, '1', '1');
INSERT INTO `pw_project` VALUES ('9', '25日测试', null, '1', '1556184784', null, '4', '1');

-- ----------------------------
-- Table structure for pw_provincial
-- ----------------------------
DROP TABLE IF EXISTS `pw_provincial`;
CREATE TABLE `pw_provincial` (
  `pid` int(11) NOT NULL DEFAULT '0',
  `Provincial` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`pid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pw_provincial
-- ----------------------------
INSERT INTO `pw_provincial` VALUES ('1', '北京市');
INSERT INTO `pw_provincial` VALUES ('2', '天津市');
INSERT INTO `pw_provincial` VALUES ('3', '上海市');
INSERT INTO `pw_provincial` VALUES ('4', '重庆市');
INSERT INTO `pw_provincial` VALUES ('5', '河北省');
INSERT INTO `pw_provincial` VALUES ('6', '山西省');
INSERT INTO `pw_provincial` VALUES ('7', '台湾省');
INSERT INTO `pw_provincial` VALUES ('8', '辽宁省');
INSERT INTO `pw_provincial` VALUES ('9', '吉林省');
INSERT INTO `pw_provincial` VALUES ('10', '黑龙江省');
INSERT INTO `pw_provincial` VALUES ('11', '江苏省');
INSERT INTO `pw_provincial` VALUES ('12', '浙江省');
INSERT INTO `pw_provincial` VALUES ('13', '安徽省');
INSERT INTO `pw_provincial` VALUES ('14', '福建省');
INSERT INTO `pw_provincial` VALUES ('15', '江西省');
INSERT INTO `pw_provincial` VALUES ('16', '山东省');
INSERT INTO `pw_provincial` VALUES ('17', '河南省');
INSERT INTO `pw_provincial` VALUES ('18', '湖北省');
INSERT INTO `pw_provincial` VALUES ('19', '湖南省');
INSERT INTO `pw_provincial` VALUES ('20', '广东省');
INSERT INTO `pw_provincial` VALUES ('21', '甘肃省');
INSERT INTO `pw_provincial` VALUES ('22', '四川省');
INSERT INTO `pw_provincial` VALUES ('23', '贵州省');
INSERT INTO `pw_provincial` VALUES ('24', '海南省');
INSERT INTO `pw_provincial` VALUES ('25', '云南省');
INSERT INTO `pw_provincial` VALUES ('26', '青海省');
INSERT INTO `pw_provincial` VALUES ('27', '陕西省');
INSERT INTO `pw_provincial` VALUES ('28', '广西壮族自治区');
INSERT INTO `pw_provincial` VALUES ('29', '西藏自治区');
INSERT INTO `pw_provincial` VALUES ('30', '宁夏回族自治区');
INSERT INTO `pw_provincial` VALUES ('31', '新疆维吾尔自治区');
INSERT INTO `pw_provincial` VALUES ('32', '内蒙古自治区');
INSERT INTO `pw_provincial` VALUES ('33', '澳门特别行政区');
INSERT INTO `pw_provincial` VALUES ('34', '香港特别行政区');

-- ----------------------------
-- Table structure for pw_restrict
-- ----------------------------
DROP TABLE IF EXISTS `pw_restrict`;
CREATE TABLE `pw_restrict` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `pid` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `province_name` varchar(20) NOT NULL DEFAULT '0',
  `city_name` varchar(20) NOT NULL DEFAULT '0',
  `adminid` int(8) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `city_name` (`city_name`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pw_restrict
-- ----------------------------
INSERT INTO `pw_restrict` VALUES ('4', '3', '浙江省', '衢州市', '1');
INSERT INTO `pw_restrict` VALUES ('7', '3', '浙江省', '嘉兴市', '1');
INSERT INTO `pw_restrict` VALUES ('9', '2', '河南省', '焦作市', '1');
INSERT INTO `pw_restrict` VALUES ('10', '3', '福建省', '三明市', '1');
INSERT INTO `pw_restrict` VALUES ('14', '3', '福建省', '厦门市', '1');
INSERT INTO `pw_restrict` VALUES ('16', '3', '福建省', '福州市', '1');
INSERT INTO `pw_restrict` VALUES ('18', '3', '福建省', '南平市', '1');
INSERT INTO `pw_restrict` VALUES ('19', '3', '河南省', '南阳市', '1');
INSERT INTO `pw_restrict` VALUES ('21', '3', '河南省', '开封市', '1');
INSERT INTO `pw_restrict` VALUES ('23', '3', '河南省', '鹤壁市', '1');
INSERT INTO `pw_restrict` VALUES ('24', '3', '河南省', '商丘市', '1');
INSERT INTO `pw_restrict` VALUES ('25', '3', '河南省', '驻马店市', '1');
INSERT INTO `pw_restrict` VALUES ('26', '3', '山东省', '东营市', '1');
