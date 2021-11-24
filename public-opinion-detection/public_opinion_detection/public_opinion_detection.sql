/*
Navicat MySQL Data Transfer

Source Server         : mysql80
Source Server Version : 80019
Source Host           : 127.0.0.1:3306
Source Database       : public_opinion_detection

Target Server Type    : MYSQL
Target Server Version : 80019
File Encoding         : 65001

Date: 2021-11-23 16:29:35
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `answer`
-- ----------------------------
DROP TABLE IF EXISTS `answer`;
CREATE TABLE `answer` (
  `answerid` int NOT NULL AUTO_INCREMENT,
  `questionid` int NOT NULL,
  `userid` int NOT NULL,
  `content` longtext NOT NULL,
  `time` datetime(6) NOT NULL,
  `favor` int NOT NULL,
  `replyid` int NOT NULL,
  PRIMARY KEY (`answerid`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of answer
-- ----------------------------
INSERT INTO `answer` VALUES ('1', '1', '2', '测试回答1', '2021-04-09 11:09:00.000000', '1', '0');
INSERT INTO `answer` VALUES ('2', '1', '2', '测试回答2', '2021-04-09 11:09:00.000000', '1', '0');
INSERT INTO `answer` VALUES ('3', '1', '1', '二层回复', '2021-04-09 11:09:00.000000', '0', '1');
INSERT INTO `answer` VALUES ('4', '1', '2', '回复测试', '2021-04-09 11:15:00.000000', '0', '1');
INSERT INTO `answer` VALUES ('5', '2', '2', 'zxc', '2021-04-11 09:02:16.064095', '1', '0');
INSERT INTO `answer` VALUES ('9', '1', '2', '3', '2021-04-11 12:34:52.683516', '0', '0');
INSERT INTO `answer` VALUES ('10', '1', '2', '3', '2021-04-11 12:37:23.622349', '0', '0');
INSERT INTO `answer` VALUES ('11', '1', '2', '环境下氨基酸', '2021-04-11 12:37:23.622349', '0', '0');
INSERT INTO `answer` VALUES ('12', '1', '2', '1', '2021-04-11 12:37:23.622349', '0', '0');
INSERT INTO `answer` VALUES ('13', '1', '2', '44', '2021-04-11 12:37:23.622349', '0', '0');
INSERT INTO `answer` VALUES ('14', '1', '2', '1111', '2021-04-11 12:37:23.622349', '0', '1');
INSERT INTO `answer` VALUES ('15', '1', '2', '2222', '2021-04-11 12:37:23.622349', '0', '1');
INSERT INTO `answer` VALUES ('16', '1', '2', '1111', '2021-04-11 12:37:23.622349', '0', '13');
INSERT INTO `answer` VALUES ('17', '1', '2', '222', '2021-04-11 12:37:23.622349', '0', '13');
INSERT INTO `answer` VALUES ('18', '2', '2', '111', '2021-04-11 12:37:23.622349', '0', '5');
INSERT INTO `answer` VALUES ('19', '2', '2', '222', '2021-04-11 12:37:23.622349', '0', '5');
INSERT INTO `answer` VALUES ('20', '2', '2', '333', '2021-04-11 12:37:23.622349', '0', '5');
INSERT INTO `answer` VALUES ('21', '2', '2', '444', '2021-04-11 12:37:23.622349', '0', '5');
INSERT INTO `answer` VALUES ('22', '1', '2', '0', '2021-04-11 12:37:23.622349', '0', '2');
INSERT INTO `answer` VALUES ('23', '1', '2', '1', '2021-04-11 12:37:23.622349', '0', '2');
INSERT INTO `answer` VALUES ('24', '1', '2', '0', '2021-04-11 12:37:23.622349', '0', '9');
INSERT INTO `answer` VALUES ('25', '1', '2', '0', '2021-04-11 12:37:23.622349', '0', '10');
INSERT INTO `answer` VALUES ('26', '3', '2', '【【', '2021-04-11 14:40:00.731976', '0', '0');
INSERT INTO `answer` VALUES ('27', '3', '2', '环境', '2021-04-11 14:40:00.731976', '0', '0');
INSERT INTO `answer` VALUES ('28', '3', '2', '回复', '2021-04-11 14:40:00.731976', '1', '27');
INSERT INTO `answer` VALUES ('29', '3', '2', '黄及', '2021-04-11 14:40:00.731976', '0', '0');
INSERT INTO `answer` VALUES ('30', '3', '2', '接口', '2021-04-11 14:40:00.731976', '0', '29');
INSERT INTO `answer` VALUES ('31', '5', '2', '123', '2021-04-16 04:51:28.678171', '0', '0');
INSERT INTO `answer` VALUES ('32', '5', '2', '456', '2021-04-16 04:51:28.678171', '0', '31');

-- ----------------------------
-- Table structure for `answerlike`
-- ----------------------------
DROP TABLE IF EXISTS `answerlike`;
CREATE TABLE `answerlike` (
  `id` int NOT NULL AUTO_INCREMENT,
  `answerid` int NOT NULL,
  `userid` int NOT NULL,
  `time` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of answerlike
-- ----------------------------
INSERT INTO `answerlike` VALUES ('10', '5', '2', '2021-04-11 12:19:17.961880');
INSERT INTO `answerlike` VALUES ('14', '2', '2', '2021-04-11 12:19:17.961880');
INSERT INTO `answerlike` VALUES ('17', '1', '2', '2021-04-11 12:33:41.499417');
INSERT INTO `answerlike` VALUES ('34', '28', '2', '2021-04-11 14:40:00.731976');

-- ----------------------------
-- Table structure for `auth_group`
-- ----------------------------
DROP TABLE IF EXISTS `auth_group`;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of auth_group
-- ----------------------------

-- ----------------------------
-- Table structure for `auth_group_permissions`
-- ----------------------------
DROP TABLE IF EXISTS `auth_group_permissions`;
CREATE TABLE `auth_group_permissions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of auth_group_permissions
-- ----------------------------

-- ----------------------------
-- Table structure for `auth_permission`
-- ----------------------------
DROP TABLE IF EXISTS `auth_permission`;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of auth_permission
-- ----------------------------
INSERT INTO `auth_permission` VALUES ('1', 'Can add log entry', '1', 'add_logentry');
INSERT INTO `auth_permission` VALUES ('2', 'Can change log entry', '1', 'change_logentry');
INSERT INTO `auth_permission` VALUES ('3', 'Can delete log entry', '1', 'delete_logentry');
INSERT INTO `auth_permission` VALUES ('4', 'Can view log entry', '1', 'view_logentry');
INSERT INTO `auth_permission` VALUES ('5', 'Can add permission', '2', 'add_permission');
INSERT INTO `auth_permission` VALUES ('6', 'Can change permission', '2', 'change_permission');
INSERT INTO `auth_permission` VALUES ('7', 'Can delete permission', '2', 'delete_permission');
INSERT INTO `auth_permission` VALUES ('8', 'Can view permission', '2', 'view_permission');
INSERT INTO `auth_permission` VALUES ('9', 'Can add group', '3', 'add_group');
INSERT INTO `auth_permission` VALUES ('10', 'Can change group', '3', 'change_group');
INSERT INTO `auth_permission` VALUES ('11', 'Can delete group', '3', 'delete_group');
INSERT INTO `auth_permission` VALUES ('12', 'Can view group', '3', 'view_group');
INSERT INTO `auth_permission` VALUES ('13', 'Can add user', '4', 'add_user');
INSERT INTO `auth_permission` VALUES ('14', 'Can change user', '4', 'change_user');
INSERT INTO `auth_permission` VALUES ('15', 'Can delete user', '4', 'delete_user');
INSERT INTO `auth_permission` VALUES ('16', 'Can view user', '4', 'view_user');
INSERT INTO `auth_permission` VALUES ('17', 'Can add content type', '5', 'add_contenttype');
INSERT INTO `auth_permission` VALUES ('18', 'Can change content type', '5', 'change_contenttype');
INSERT INTO `auth_permission` VALUES ('19', 'Can delete content type', '5', 'delete_contenttype');
INSERT INTO `auth_permission` VALUES ('20', 'Can view content type', '5', 'view_contenttype');
INSERT INTO `auth_permission` VALUES ('21', 'Can add session', '6', 'add_session');
INSERT INTO `auth_permission` VALUES ('22', 'Can change session', '6', 'change_session');
INSERT INTO `auth_permission` VALUES ('23', 'Can delete session', '6', 'delete_session');
INSERT INTO `auth_permission` VALUES ('24', 'Can view session', '6', 'view_session');
INSERT INTO `auth_permission` VALUES ('25', 'Can add answer', '7', 'add_answer');
INSERT INTO `auth_permission` VALUES ('26', 'Can change answer', '7', 'change_answer');
INSERT INTO `auth_permission` VALUES ('27', 'Can delete answer', '7', 'delete_answer');
INSERT INTO `auth_permission` VALUES ('28', 'Can view answer', '7', 'view_answer');
INSERT INTO `auth_permission` VALUES ('29', 'Can add hot news', '8', 'add_hotnews');
INSERT INTO `auth_permission` VALUES ('30', 'Can change hot news', '8', 'change_hotnews');
INSERT INTO `auth_permission` VALUES ('31', 'Can delete hot news', '8', 'delete_hotnews');
INSERT INTO `auth_permission` VALUES ('32', 'Can view hot news', '8', 'view_hotnews');
INSERT INTO `auth_permission` VALUES ('33', 'Can add my like', '9', 'add_mylike');
INSERT INTO `auth_permission` VALUES ('34', 'Can change my like', '9', 'change_mylike');
INSERT INTO `auth_permission` VALUES ('35', 'Can delete my like', '9', 'delete_mylike');
INSERT INTO `auth_permission` VALUES ('36', 'Can view my like', '9', 'view_mylike');
INSERT INTO `auth_permission` VALUES ('37', 'Can add question', '10', 'add_question');
INSERT INTO `auth_permission` VALUES ('38', 'Can change question', '10', 'change_question');
INSERT INTO `auth_permission` VALUES ('39', 'Can delete question', '10', 'delete_question');
INSERT INTO `auth_permission` VALUES ('40', 'Can view question', '10', 'view_question');
INSERT INTO `auth_permission` VALUES ('41', 'Can add user', '11', 'add_user');
INSERT INTO `auth_permission` VALUES ('42', 'Can change user', '11', 'change_user');
INSERT INTO `auth_permission` VALUES ('43', 'Can delete user', '11', 'delete_user');
INSERT INTO `auth_permission` VALUES ('44', 'Can view user', '11', 'view_user');
INSERT INTO `auth_permission` VALUES ('45', 'Can add cors model', '12', 'add_corsmodel');
INSERT INTO `auth_permission` VALUES ('46', 'Can change cors model', '12', 'change_corsmodel');
INSERT INTO `auth_permission` VALUES ('47', 'Can delete cors model', '12', 'delete_corsmodel');
INSERT INTO `auth_permission` VALUES ('48', 'Can view cors model', '12', 'view_corsmodel');
INSERT INTO `auth_permission` VALUES ('49', 'Can add answer like', '13', 'add_answerlike');
INSERT INTO `auth_permission` VALUES ('50', 'Can change answer like', '13', 'change_answerlike');
INSERT INTO `auth_permission` VALUES ('51', 'Can delete answer like', '13', 'delete_answerlike');
INSERT INTO `auth_permission` VALUES ('52', 'Can view answer like', '13', 'view_answerlike');

-- ----------------------------
-- Table structure for `auth_user`
-- ----------------------------
DROP TABLE IF EXISTS `auth_user`;
CREATE TABLE `auth_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of auth_user
-- ----------------------------
INSERT INTO `auth_user` VALUES ('1', 'pbkdf2_sha256$216000$lbzmrHeXyeSC$R4b5SkfCWcFe1ZxfIIDbkV5Ducnk1a+11iTHSR69qEw=', '2021-04-09 11:10:10.297172', '1', 'admin', '', '', '', '1', '1', '2021-03-29 09:37:03.401700');

-- ----------------------------
-- Table structure for `auth_user_groups`
-- ----------------------------
DROP TABLE IF EXISTS `auth_user_groups`;
CREATE TABLE `auth_user_groups` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of auth_user_groups
-- ----------------------------

-- ----------------------------
-- Table structure for `auth_user_user_permissions`
-- ----------------------------
DROP TABLE IF EXISTS `auth_user_user_permissions`;
CREATE TABLE `auth_user_user_permissions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of auth_user_user_permissions
-- ----------------------------

-- ----------------------------
-- Table structure for `corsheaders_corsmodel`
-- ----------------------------
DROP TABLE IF EXISTS `corsheaders_corsmodel`;
CREATE TABLE `corsheaders_corsmodel` (
  `id` int NOT NULL AUTO_INCREMENT,
  `cors` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of corsheaders_corsmodel
-- ----------------------------

-- ----------------------------
-- Table structure for `django_admin_log`
-- ----------------------------
DROP TABLE IF EXISTS `django_admin_log`;
CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of django_admin_log
-- ----------------------------
INSERT INTO `django_admin_log` VALUES ('1', '2021-03-29 15:57:38.485716', '1', 'User object (1)', '1', '[{\"added\": {}}]', '11', '1');
INSERT INTO `django_admin_log` VALUES ('2', '2021-03-30 12:33:26.679412', '1', 'HotNews object (1)', '1', '[{\"added\": {}}]', '8', '1');
INSERT INTO `django_admin_log` VALUES ('3', '2021-03-30 12:33:58.358010', '2', 'HotNews object (2)', '1', '[{\"added\": {}}]', '8', '1');
INSERT INTO `django_admin_log` VALUES ('4', '2021-03-30 12:35:49.358766', '3', 'HotNews object (3)', '1', '[{\"added\": {}}]', '8', '1');
INSERT INTO `django_admin_log` VALUES ('5', '2021-03-31 02:40:08.209654', '5', 'HotNews object (5)', '1', '[{\"added\": {}}]', '8', '1');
INSERT INTO `django_admin_log` VALUES ('6', '2021-03-31 02:43:14.385201', '6', 'HotNews object (6)', '1', '[{\"added\": {}}]', '8', '1');
INSERT INTO `django_admin_log` VALUES ('7', '2021-03-31 03:18:30.070855', '7', 'HotNews object (7)', '1', '[{\"added\": {}}]', '8', '1');
INSERT INTO `django_admin_log` VALUES ('8', '2021-03-31 03:18:42.027079', '8', 'HotNews object (8)', '1', '[{\"added\": {}}]', '8', '1');
INSERT INTO `django_admin_log` VALUES ('9', '2021-03-31 03:18:49.276331', '9', 'HotNews object (9)', '1', '[{\"added\": {}}]', '8', '1');
INSERT INTO `django_admin_log` VALUES ('10', '2021-03-31 03:19:00.410247', '10', 'HotNews object (10)', '1', '[{\"added\": {}}]', '8', '1');
INSERT INTO `django_admin_log` VALUES ('11', '2021-04-09 11:11:48.121297', '1', 'Question object (1)', '1', '[{\"added\": {}}]', '10', '1');
INSERT INTO `django_admin_log` VALUES ('12', '2021-04-09 11:12:18.429240', '2', 'Question object (2)', '1', '[{\"added\": {}}]', '10', '1');
INSERT INTO `django_admin_log` VALUES ('13', '2021-04-09 11:13:54.397685', '1', 'Answer object (1)', '1', '[{\"added\": {}}]', '7', '1');
INSERT INTO `django_admin_log` VALUES ('14', '2021-04-09 11:14:32.448882', '2', 'Answer object (2)', '1', '[{\"added\": {}}]', '7', '1');
INSERT INTO `django_admin_log` VALUES ('15', '2021-04-09 11:15:27.382578', '3', 'Answer object (3)', '1', '[{\"added\": {}}]', '7', '1');
INSERT INTO `django_admin_log` VALUES ('16', '2021-04-09 12:04:34.573212', '4', 'Answer object (4)', '1', '[{\"added\": {}}]', '7', '1');

-- ----------------------------
-- Table structure for `django_content_type`
-- ----------------------------
DROP TABLE IF EXISTS `django_content_type`;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of django_content_type
-- ----------------------------
INSERT INTO `django_content_type` VALUES ('1', 'admin', 'logentry');
INSERT INTO `django_content_type` VALUES ('3', 'auth', 'group');
INSERT INTO `django_content_type` VALUES ('2', 'auth', 'permission');
INSERT INTO `django_content_type` VALUES ('4', 'auth', 'user');
INSERT INTO `django_content_type` VALUES ('5', 'contenttypes', 'contenttype');
INSERT INTO `django_content_type` VALUES ('12', 'corsheaders', 'corsmodel');
INSERT INTO `django_content_type` VALUES ('7', 'news_app', 'answer');
INSERT INTO `django_content_type` VALUES ('13', 'news_app', 'answerlike');
INSERT INTO `django_content_type` VALUES ('8', 'news_app', 'hotnews');
INSERT INTO `django_content_type` VALUES ('9', 'news_app', 'mylike');
INSERT INTO `django_content_type` VALUES ('10', 'news_app', 'question');
INSERT INTO `django_content_type` VALUES ('11', 'news_app', 'user');
INSERT INTO `django_content_type` VALUES ('6', 'sessions', 'session');

-- ----------------------------
-- Table structure for `django_migrations`
-- ----------------------------
DROP TABLE IF EXISTS `django_migrations`;
CREATE TABLE `django_migrations` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of django_migrations
-- ----------------------------
INSERT INTO `django_migrations` VALUES ('1', 'contenttypes', '0001_initial', '2021-03-29 09:35:03.685724');
INSERT INTO `django_migrations` VALUES ('2', 'auth', '0001_initial', '2021-03-29 09:35:03.993721');
INSERT INTO `django_migrations` VALUES ('3', 'admin', '0001_initial', '2021-03-29 09:35:06.230435');
INSERT INTO `django_migrations` VALUES ('4', 'admin', '0002_logentry_remove_auto_add', '2021-03-29 09:35:06.415127');
INSERT INTO `django_migrations` VALUES ('5', 'admin', '0003_logentry_add_action_flag_choices', '2021-03-29 09:35:06.424103');
INSERT INTO `django_migrations` VALUES ('6', 'contenttypes', '0002_remove_content_type_name', '2021-03-29 09:35:06.612608');
INSERT INTO `django_migrations` VALUES ('7', 'auth', '0002_alter_permission_name_max_length', '2021-03-29 09:35:06.903727');
INSERT INTO `django_migrations` VALUES ('8', 'auth', '0003_alter_user_email_max_length', '2021-03-29 09:35:07.006162');
INSERT INTO `django_migrations` VALUES ('9', 'auth', '0004_alter_user_username_opts', '2021-03-29 09:35:07.067443');
INSERT INTO `django_migrations` VALUES ('10', 'auth', '0005_alter_user_last_login_null', '2021-03-29 09:35:07.272449');
INSERT INTO `django_migrations` VALUES ('11', 'auth', '0006_require_contenttypes_0002', '2021-03-29 09:35:07.297558');
INSERT INTO `django_migrations` VALUES ('12', 'auth', '0007_alter_validators_add_error_messages', '2021-03-29 09:35:07.321184');
INSERT INTO `django_migrations` VALUES ('13', 'auth', '0008_alter_user_username_max_length', '2021-03-29 09:35:07.511611');
INSERT INTO `django_migrations` VALUES ('14', 'auth', '0009_alter_user_last_name_max_length', '2021-03-29 09:35:07.844900');
INSERT INTO `django_migrations` VALUES ('15', 'auth', '0010_alter_group_name_max_length', '2021-03-29 09:35:07.871844');
INSERT INTO `django_migrations` VALUES ('16', 'auth', '0011_update_proxy_permissions', '2021-03-29 09:35:07.879848');
INSERT INTO `django_migrations` VALUES ('17', 'auth', '0012_alter_user_first_name_max_length', '2021-03-29 09:35:08.113908');
INSERT INTO `django_migrations` VALUES ('18', 'sessions', '0001_initial', '2021-03-29 09:35:08.160824');
INSERT INTO `django_migrations` VALUES ('19', 'news_app', '0001_initial', '2021-03-29 14:47:54.648157');
INSERT INTO `django_migrations` VALUES ('20', 'news_app', '0002_auto_20210329_2023', '2021-03-29 14:47:54.654258');
INSERT INTO `django_migrations` VALUES ('21', 'news_app', '0003_auto_20210329_2025', '2021-03-29 14:47:54.659521');
INSERT INTO `django_migrations` VALUES ('22', 'news_app', '0004_auto_20210329_2027', '2021-03-29 14:47:54.667156');
INSERT INTO `django_migrations` VALUES ('23', 'news_app', '0005_auto_20210329_2221', '2021-03-29 14:47:54.679532');
INSERT INTO `django_migrations` VALUES ('24', 'news_app', '0006_auto_20210329_2247', '2021-03-29 14:47:54.683258');
INSERT INTO `django_migrations` VALUES ('25', 'news_app', '0007_auto_20210329_2357', '2021-03-29 15:57:05.629289');
INSERT INTO `django_migrations` VALUES ('26', 'news_app', '0008_auto_20210330_1721', '2021-03-30 09:22:01.143213');
INSERT INTO `django_migrations` VALUES ('27', 'news_app', '0009_auto_20210330_2029', '2021-03-30 12:30:05.708398');
INSERT INTO `django_migrations` VALUES ('28', 'news_app', '0010_auto_20210402_2053', '2021-04-02 12:53:44.149970');
INSERT INTO `django_migrations` VALUES ('29', 'news_app', '0011_auto_20210406_1806', '2021-04-06 10:06:40.301227');
INSERT INTO `django_migrations` VALUES ('30', 'news_app', '0012_auto_20210407_0007', '2021-04-06 16:07:55.699029');
INSERT INTO `django_migrations` VALUES ('31', 'corsheaders', '0001_initial', '2021-04-09 10:08:53.061916');
INSERT INTO `django_migrations` VALUES ('32', 'news_app', '0013_auto_20210409_1759', '2021-04-09 10:08:53.304268');
INSERT INTO `django_migrations` VALUES ('33', 'news_app', '0014_auto_20210409_1909', '2021-04-09 11:09:39.498398');
INSERT INTO `django_migrations` VALUES ('34', 'news_app', '0015_auto_20210410_0025', '2021-04-09 16:26:07.713419');
INSERT INTO `django_migrations` VALUES ('35', 'news_app', '0016_auto_20210410_2142', '2021-04-10 13:42:36.107813');

-- ----------------------------
-- Table structure for `django_session`
-- ----------------------------
DROP TABLE IF EXISTS `django_session`;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of django_session
-- ----------------------------
INSERT INTO `django_session` VALUES ('02z933ksiuyqq5urn2zyoeqkztmjul7v', 'eyJjYXB0Y2hhX3N0ciI6InJKRVoifQ:1lY5CA:AJnT0Vvz37tEt6TxYb86CH6c8QNfoB67IdMz_GMyv7k', '2021-05-02 11:02:30.075277');
INSERT INTO `django_session` VALUES ('09x1urqdd2kc6h27vkfc77n9h084eqx6', 'eyJjYXB0Y2hhX3N0ciI6ImFYZ2kifQ:1lXz92:-n76YaNthjEkFz4mpE1op84kKQp7u9GxK399j9_9RQw', '2021-05-02 04:34:52.435158');
INSERT INTO `django_session` VALUES ('0ejthj2cp8wisxgdc9q9045822ss5n0e', 'eyJjYXB0Y2hhX3N0ciI6ImFtMWgifQ:1lY5BK:sXyDOPN_VWY2hoKX7d3D0m3wxUjfHgINMFvqVrowQKc', '2021-05-02 11:01:38.257440');
INSERT INTO `django_session` VALUES ('3mhm0jo7dzejgwqaykw3rbx35v5hj7xf', 'eyJjYXB0Y2hhX3N0ciI6InlPVzQifQ:1lXMcO:0F019-tOhF55cYC8IfFI2Q3SwfWPq4FSaqhTXn_7dvo', '2021-04-30 11:26:36.495223');
INSERT INTO `django_session` VALUES ('4q2y6l2lnauc37wj8y650ru04fujkf39', 'eyJjYXB0Y2hhX3N0ciI6IlRkM1kifQ:1lWgLN:YOqDI30Y4VfaDEpeD-3Yeb85V0MqxL8r1rRUz6mFQg0', '2021-04-28 14:18:13.221107');
INSERT INTO `django_session` VALUES ('b0o9jpz59sg738laqcmiqvh84go04qhw', 'eyJjYXB0Y2hhX3N0ciI6IkxGUDEifQ:1lY5Q4:ErhXPOWAog8a3hLVDX2gxZoOzYH18CFPv1HqiMZa8K8', '2021-05-02 11:16:52.173955');
INSERT INTO `django_session` VALUES ('bq7h9uuu9y6o09yx6b9ji86zcf05dllm', 'eyJjYXB0Y2hhX3N0ciI6ImNyT28ifQ:1lXMct:IfTJWwfLdQw9VSkf8q3seZDc_7CnmWaWFp1WBxUP_9s', '2021-04-30 11:27:07.282809');
INSERT INTO `django_session` VALUES ('bwwpyoq7zwbk8uw8inmnp0nhe4l5nu1p', 'eyJjYXB0Y2hhX3N0ciI6Imw4UmcifQ:1lYV9e:tJQj6kKF_sFy4v-hHwmXhzD8xmpslSKRjJr8tStaX_U', '2021-05-03 14:45:38.330510');
INSERT INTO `django_session` VALUES ('c7kjis5ts6r792fscy0hqrfjzbe06scc', 'eyJjYXB0Y2hhX3N0ciI6IjRhY0cifQ:1lYVE3:Bfxj2P8V5XGKlHD0z-cPiuQJ8egsu7bcJnP1nmcSvps', '2021-05-03 14:50:11.676720');
INSERT INTO `django_session` VALUES ('fbwjrltps4pnmno2f8wzxmimpw5kv46x', 'eyJjYXB0Y2hhX3N0ciI6IjhicUkifQ:1lXzA0:msPOK84eP2oGN2hwZgrLKgM0156ngaqnQ8iZLKVYIok', '2021-05-02 04:35:52.781553');
INSERT INTO `django_session` VALUES ('fpp0ldgntn81a9nrw5dcz5q6emqqbjq0', 'eyJjYXB0Y2hhX3N0ciI6IkRaUTIifQ:1lXMhD:Eu1bRf-7eujm41_FAYYlMlUsCRatnfEn0wMz3-0-nOo', '2021-04-30 11:31:35.212296');
INSERT INTO `django_session` VALUES ('hxnrkuitekw7erfpav1z52vvu7g15s1y', 'eyJjYXB0Y2hhX3N0ciI6InJOQ3QifQ:1lWgMk:zS4fEZkv-XHjhSeLRR9aR0tdH2dDl0xCqzIN3URyIoI', '2021-04-28 14:19:38.792490');
INSERT INTO `django_session` VALUES ('j6yqhilr0vxmyfeypql5t3sfgthgq2wl', 'eyJjYXB0Y2hhX3N0ciI6IlhZdVIifQ:1lWgbR:6Q6yBtSRN7lOFEUMbTBl2XTvzNx_6oaoriuD3Bmcgyk', '2021-04-28 14:34:49.208829');
INSERT INTO `django_session` VALUES ('jcbcho7l7lieupg2bqek1a1denp6l6vg', 'eyJjYXB0Y2hhX3N0ciI6Ill6RGwifQ:1lXzA0:R3LiE0ZQ90YkqWVir3Boim92YXuTA7BI6wKoCkISfaM', '2021-05-02 04:35:52.745612');
INSERT INTO `django_session` VALUES ('kf8ulwdsyvxq7p3ngegk7rwfw89yl71q', 'eyJjYXB0Y2hhX3N0ciI6IlV4WlgifQ:1lWgLK:uhG4D5OUb-VtWgVEn_ewrBFlUeuBQm-vlqjq36PvtwM', '2021-04-28 14:18:10.695162');
INSERT INTO `django_session` VALUES ('l3r9r4p68eooshas3en2o8975nfbmc88', 'eyJjYXB0Y2hhX3N0ciI6IkVMQVYifQ:1lXG53:1RbQoiV8fYNiFWlCTqs5gSWL-GHTHT-SE7v4iMSOIXQ', '2021-04-30 04:27:45.219595');
INSERT INTO `django_session` VALUES ('mfwe5qhghy2fipu9bhqsb1z1o5lbyl9r', 'eyJjYXB0Y2hhX3N0ciI6ImF0dTQifQ:1lYVA4:cp1fBIwjFPLQL1DJmt_7plUfYW5oKRTI2tOZLQWYDQw', '2021-05-03 14:46:04.214273');
INSERT INTO `django_session` VALUES ('mur376dk3z6bw6nu53yay8z8gt6rc1ld', 'eyJjYXB0Y2hhX3N0ciI6ImdmbXMifQ:1lY5BI:wbmnnXBvLNz4YXtDvdaV-kyoxbTFcNdXkXbb929qkMQ', '2021-05-02 11:01:36.526484');
INSERT INTO `django_session` VALUES ('ncdhph267ls9hbpc0ihp48lu1v5hms1c', 'eyJjYXB0Y2hhX3N0ciI6IkRGcDcifQ:1lY5BI:l_O9OTDmV8l_t9NQxif1JBtv1YhnbvPTkb-dh6t2jwI', '2021-05-02 11:01:36.575353');
INSERT INTO `django_session` VALUES ('r0rs5c1dbtgrkianrgj093wq75b2m7nx', 'eyJjYXB0Y2hhX3N0ciI6InFQRGQifQ:1lWgIu:m5SvN6qSes3YT8eLyROcK-nCRP1e2tzL90W5lo7emB8', '2021-04-28 14:15:40.920133');
INSERT INTO `django_session` VALUES ('sgbi7wuujcxw9iyrqz6c5h1udzlvv0pq', 'eyJjYXB0Y2hhX3N0ciI6ImwwQ2UifQ:1lY5BK:fTX0l-7JqpLBIK3S4DzRaU1rXYUf4sUEejc8XvW1y2k', '2021-05-02 11:01:38.299303');
INSERT INTO `django_session` VALUES ('sudbdell4syyhh2bc0dh32sc5mubkkdl', 'eyJjYXB0Y2hhX3N0ciI6IjZscEgifQ:1lYV9t:VvU3eGAEZKzK4ozVTNKEdS-h055RZAHwvAPVernwuCE', '2021-05-03 14:45:53.969437');
INSERT INTO `django_session` VALUES ('tmp4jgiwevybzc3br860ybi37belbac9', 'eyJjYXB0Y2hhX3N0ciI6Im0zMjgifQ:1lWgLG:KZ22aPrfIDOTPvcdd0qjVWMwd0r4TLC0bqKU4JWJiBE', '2021-04-28 14:18:06.155858');
INSERT INTO `django_session` VALUES ('yrn8bu8xu8lgi55wmw4nn8bookm36fq7', 'eyJjYXB0Y2hhX3N0ciI6IlhhZ1kifQ:1lYV9u:XEShDjDJQ_hnwsARF9troxRUNcx-9F5qapECVsR0rQE', '2021-05-03 14:45:54.002348');
INSERT INTO `django_session` VALUES ('zoenzycpw4dnpv95ax5cztxo06a8ztkf', 'eyJjYXB0Y2hhX3N0ciI6IkdIVk4ifQ:1lWgJL:1m9plSHeE08MpBxdR_vMi2_S158YAxgpsDeHNvGOzYw', '2021-04-28 14:16:07.346902');

-- ----------------------------
-- Table structure for `hotnews`
-- ----------------------------
DROP TABLE IF EXISTS `hotnews`;
CREATE TABLE `hotnews` (
  `newsid` int NOT NULL AUTO_INCREMENT,
  `content` longtext NOT NULL,
  `time` datetime(6) NOT NULL,
  `imageUrl` varchar(250) NOT NULL,
  `tag` smallint NOT NULL,
  `title` varchar(250) NOT NULL,
  PRIMARY KEY (`newsid`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of hotnews
-- ----------------------------
INSERT INTO `hotnews` VALUES ('1', '伪创新屡屡粉墨登场，根子在一些人“挣快钱”的思想作祟。相比真创新的高投入、耗时耗力，复制已有模式、稍加变通，或者炒作伪概念，投入更低、来钱更快。而监管的滞后或缺失，也给了一些人钻空子的机会。\r\n\r\n　　在舆论的诧异和声讨中，彩礼贷、墓地贷不出意外地迅速被叫停，以闹剧收场——据近日《工人日报》等多家媒体报道，3月18日，云南昆明一陵园推出“不需要抵押”的墓地按揭贷被叫停；同日，九江银行发布致歉声明，表示取消之前推出的彩礼贷，并对责任人给予处分。\r\n\r\n　　彩礼贷、墓地贷，类似“奇葩贷”的合法合理性何在？金融产品创新的边界何在？公众对类似游走于法律边缘、有悖社会主流价值观的“奇葩贷”，纷纷表示不满与质疑。\r\n\r\n　　彩礼贷、墓地贷，表面上看是银行拓宽消费贷应用场景、满足特定人群金融需求的创新，实质上则是典型的伪创新。\r\n\r\n　　银保监会曾给出衡量金融创新合理性的基本标准——是否有利于支持实体经济、是否有利于防范金融风险、是否有利于保护消费者合法权益。对照看，彩礼贷、墓地贷无疑谈不上支持实体经济，某种程度上会鼓励“天价彩礼”“天价墓”等不良风气，而过度营销则可能诱导消费者过度负债，不利于防范金融风险。\r\n\r\n　　类似伪创新的身影，近来不时出没于我们周边，包括某些以“高科技”名义，热炒伪概念。比如，在很多人还没搞清楚量子技术的时候，“量子护肤”“量子项链”“量子眼镜”等量子概念日用品充斥电商平台。很快，专家啪啪“打脸”这些商品：目前量子科技研究主要集中在量子通信、量子计算和量子精密测量等领域，应用到百姓生活可能还要数年之后。当下所谓“量子＋生活”产品，几乎都是骗人的。\r\n\r\n　　这些伪创新产品大多披着光鲜的外衣，针对特定消费群体的需求，精准下套。比如，借款、嫩肤、黑发是某些人群的刚需，在巨大的国内市场和庞大的消费者人群中，针对这些刚需上演的骗钱闹剧总会不时上演，而不幸的是，它们也总能找到一些“交学费”的人。\r\n\r\n　　伪创新屡屡粉墨登场，根子在一些人“挣快钱”的思想作祟。相比真创新的高投入、耗时耗力，复制已有模式、稍加变通，或者炒作伪概念，投入更低、来钱更快。而监管的滞后或缺失，也给了一些人钻空子的机会。\r\n\r\n　　类似伪创新的闹剧，尽管只是活跃在个别领域或地方，总体规模和体量不算很大，但我们依然有必要警惕其可能产生的负面影响。以金融产品为例，贷款产品的创新理当守住底线和“良心”，不能折损淳朴的民俗民风和社会主流价值观。\r\n\r\n　　打击伪创新、防止被忽悠，需要社会各界一道努力。监管要与时俱进，快速反应，正如今年政府工作报告中要求，“确保金融创新在审慎监管的前提下进行”。此外，一旦发现有类似闹剧上演，相关各方应配合监管部门，及时揭穿闹剧、骗局的真面目，规范相关市场秩序。\r\n\r\n　　无论是金融领域，还是其他领域，创新都应该得到鼓励，但创新必须坚守一个基本前提和价值取向——守正。无视社会效益的创新注定难以走远、走稳。与此同时，有必要强调，各方应该多给真正的创新提供展示的舞台，让创新背后的汗水被人们看到，让创新的价值得到最大化的实现。（杜鑫 吴迪）', '2021-03-23 12:29:00.000000', '/static/picture/testimg.jpg', '0', '伪创新，闹剧式“表演”该收场了');
INSERT INTO `hotnews` VALUES ('2', '近年来，一些不法分子利用社会公众广泛关注重大纪念性事件和热点题材等心理，制作了品类繁多的臆造币，通过互联网进行夸大宣传、欺诈销售。臆造币的图案或题材找不到对应的官方信息，主题和图案完全是臆造出来的假币。专家提醒消费者，应认清臆造币的五大套路，购买贵金属纪念币一定要牢记四点注意事项。\r\n\r\n　　近期，中国人民银行发布风险提示称，中国人民银行已将“中国共产党成立100周年纪念币”纳入2021年纪念币发行计划，但尚未发行。目前，市场上所谓“中国人民银行发行”的“中国共产党成立100周年”纪念币（钞）均为臆造，相关宣传、销售、预定等均为违法违规行为。提醒消费者在购买人民币钱币产品时要谨慎选择购买渠道，不要误信虚假宣传，保护自身利益。\r\n\r\n　　据悉，当前市场中所谓的假贵金属纪念币主要包括伪造、变造和臆造的贵金属纪念币。伪造的贵金属纪念币，是指违法分子仿造中国人民银行发行的真币的图案、形状、色彩等，采用各种材质及手段制作的假币。变造的贵金属纪念币，是指在真币的基础上，采用各种手段制作的，改变了真币的价值、形态等的假币。臆造币是指纪念币的图案或题材找不到对应的官方信息，主题和图案完全是臆造出来的假币。\r\n\r\n　　近年来，仍有一些不法分子利用社会公众广泛关注重大纪念性事件和热点题材等心理，制作了品类繁多的臆造币，通过互联网进行夸大宣传，并假借中国人民银行或中国金币总公司之名进行欺诈销售。\r\n\r\n　　“制造、销售臆造金银纪念币不是法外之地。”中国金币总公司维权发展办公室副主任王元泉在中国金币北京零售中心开展的“谨防臆造币网络诈骗”维权反假活动上表示，中国人民银行发行的贵金属纪念币是法定货币。我国刑法对制贩假币规定了三个罪名：一是伪造货币罪；二是出售、购买、运输假币罪；三是持有、使用假币罪。刑法对这三个犯罪行为都作出了严厉的处罚规定。\r\n\r\n　　王元泉强调，制售假贵金属纪念币并非以其面额来定罪，而是以其初始发行价格来定罪的。制造销售臆造金银纪念币，决不属于法外之地，不法分子切莫心存侥幸。\r\n\r\n　　消费者如何识别臆造币？北京开元中国金币经销中心西城营业部高级主管郝梦雄介绍，消费者应认清臆造币的五大套路：套路一是热点题材、大全套。臆造币多喜欢“蹭热点”，以消费者关注的题材成套出现。但只要登录央行官网或中国金币网查询相关发行公告，就能立即识破。\r\n\r\n　　套路二是以“章”充“币”。“纪念币”和“纪念章”仅一字之差，外形也相似，实际却完全不同。无论是权威性还是收藏价值，纪念章都远不如纪念币。但一些不法分子会利用真币图案仿制纪念币，但面额部分用克重代替，企图蒙骗消费者。\r\n\r\n　　套路三是等额兑换。贵金属纪念币的面额远低于售价。如果有人声称其销售的金银纪念币可以用面额等值兑换，一定是假币。\r\n\r\n　　套路四是所谓“权威机构”发行。不法分子假借所谓权威机构的名义售卖贵金属纪念币，而实际上所谓的权威机构“英国金币总公司”“美国金币总公司”根本不存在。\r\n\r\n　　套路五是饥饿营销。其广告语一般极力营造火爆的销售场面，声称“不怕涨不了，就怕买不到”“今日起限量抢购”等，看到类似这样的广告一定得留个心眼。\r\n\r\n　　郝梦雄提醒，消费者购买贵金属纪念币一定要牢记四点：一是贵金属纪念币的面额只是象征符号，与实际价值无关，不可能等值兑换；二是中国人民银行是我国纪念币发行的唯一机构，中国金币总公司是我国贵金属纪念币唯一总经销，上海造币有限公司、沈阳造币有限公司和深圳国宝造币有限公司是我国贵金属纪念币的铸造单位；三是中国人民银行在发行纪念币之前，都会在央行官网公布发行公告。购买之前，一定要先查看央行公告，不在公告之列的肯定是假币；四是中国金币总公司在贵金属纪念币发行当日，会通过中国金币网公布销售渠道。消费者一定要通过公布的正规渠道购买贵金属纪念币，避免蒙受损失。（记者 陈果静）', '2021-03-19 12:29:00.000000', '/static/picture/testimg.jpg', '0', '识破五大套路 防范“臆造币”陷阱');
INSERT INTO `hotnews` VALUES ('3', '近期，H&M、耐克等国外品牌声称新疆存在“强迫劳动”问题，拒绝使用新疆棉花产品的声明引起了舆论关注。前段时间，一些新疆棉企负责人也反映，去年以来，已经签好的棉产品出口订单突然间全部被取消。新疆棉花为何突然面临困境？记者前往新疆进行了调查。\r\n\r\n　　机构声称新疆棉企“强迫劳动” 棉企工人用亲身经历辟谣\r\n\r\n　　今年55岁的艾尔肯·艾则孜是新疆尉犁县的一名棉农，依靠家里的150多亩棉田，每年有10万元左右的纯收入。种棉、养牛、放羊，艾尔肯一家的生活越来越富裕。然而，这样的幸福生活，很有可能因为附近工厂不再收购他的棉花而改变。\r\n\r\n\r\n\r\n　　尉犁县众望工贸有限公司负责人张彪，已经连续两年从艾尔肯的棉田收购棉花，加工后销往国内外。2020年，张彪却失去了出口的机会，因为很多品牌终止收购来自新疆的原料，有的甚至放弃了中国的供应商。张彪说，一些主要依靠出口的棉企销售渠道已经被彻底切断，有的企业损失达到几亿元。\r\n\r\n\r\n\r\n　　这中间到底出了什么问题？原来，2020年8月，瑞士良好棉花发展协会（BCI）宣布对所有新疆棉企无限期取消担保认证。这一行动导致新疆棉产品进入了国际贸易的“黑名单”，而该协会给出的理由竟是新疆棉企存在“强迫劳动”的问题。对于这种说法，新疆棉商和棉花企业工人都予以驳斥。\r\n\r\n\r\n\r\n　　新疆国欣种业有限公司总经理 卢春建：纯属胡说八道。我不知道他说这个话的目的是看到了还是听到了，还是胡言乱语，说这个话是不是有什么目的。今年招聘的时候，本来应该是八十多个人，来了将近一百六七十个人。我们要是强迫劳动，会来这么多人吗，会这么积极吗？\r\n\r\n\r\n\r\n　　新疆国欣种业有限公司员工 穆太力普：我们平时上八个小时班，中间有两个小时午休时间，夫妻俩一个月的工资是9000元左右，我们的公司没有所谓的“强迫劳动”，我来公司后也没听过没见过这样的事。\r\n\r\n\r\n\r\n　　“强迫劳动”谎言从何而来？ BCI上海代表处评估报告遭无视\r\n\r\n　　BCI为什么会得出与事实相悖的结论？这还要从近几年一些西方媒体炮制的谎言说起。 2019年以来，澳大利亚战略政策研究所、英国广播公司、《华尔街日报》等一些西方媒体和非政府组织，持续指责新疆存在“强迫劳动”问题，把新疆棉纺织行业定义为“强迫劳动的重灾区”。\r\n\r\n\r\n\r\n　　在西方强大的舆论攻势下，耐克、CK、汤米、Gap等品牌商停用新疆棉织品。作为关键角色的BCI也采取行动，启动新疆“强迫劳动”调查。在BCI上海代表处供职的吴艳，向记者介绍了调查流程。\r\n\r\n\r\n\r\n　　BCI上海代表处首席代表 吴艳：首先是生产者单位进行自我评估，然后由我们上海的团队进行第二方的可信度审核，最后由第三方的审核机构出具单独的验证报告。为回应境外有关“强迫劳动”的舆论，BCI上海代表处对新疆的项目进行了严格复查，最终证实新疆并没有所谓“强迫劳动”问题。他们向总部提交了两份调查报告，还汇总了瑞士通标公司等第三方检测机构历年以来的检测报告。\r\n\r\n\r\n\r\n　　但是，BCI总部却无视其上海代表处和通标公司提交的评估报告，声称新疆棉企存在所谓“强迫劳动”，并且没有任何理由的无限期取消新疆棉企“良好棉花”认证。导致近50万吨的新疆棉花无法进入国际棉纺织生产供应链。\r\n\r\n\r\n\r\n　　BCI错误认定的背后： “人权组织”施压，美国政府机构授意\r\n\r\n　　BCI为何执意地不顾事实？记者了解到，参加良好棉花调查工作组的一些所谓的“人权组织”，在调查工作中向BCI总部频频施压，他们也是所谓新疆“强迫劳动”问题的始作俑者。除此之外，良好棉花理事会和美国国际开发署的不断授意也与此有关。\r\n\r\n\r\n\r\n　　整个2020年，美国政府对新疆棉产业频频出手打压。从美国财政部要求美国公司完成与新疆52家棉企的清算撤资，到国土安全部海关与边境保护局针对新疆棉企发布进口禁令，几项措施几乎封堵了新疆棉产品的出口渠道。国际零售品牌在中国地区采购的“良好棉花”，占全球采购量的33%。BCI总部作出的无理决定，实际是美国政府涉疆制裁的延伸，导致了供应链脱钩的恶果。瑞士良好棉花发展协会和一些非政府组织、零售品牌商的所做所为，让白棉花上了“黑名单”。\r\n\r\n\r\n\r\n　　中国社科院中国边疆研究所研究员 许建英：美国所谓的要保护新疆的人权完全是一派谎言，根本目的实际是破坏新疆各族人民的生存权和发展权，这也是对新疆各族人民的人权的最大的破坏。\r\n\r\n\r\n\r\n　　事实证明，所谓新疆“强迫劳动”的说法是彻头彻尾的世纪谎言，是美西方个别政客、非政府组织、媒体沆瀣一气炮制的丑恶闹剧。他们表面上关心的是人权问题，实际却是打着人权的幌子反人权，企图剥夺新疆棉农和最普通劳动者的利益。他们以“强迫劳动”为由限制新疆产品出口，打压中国企业、破坏新疆稳定、抹黑中国治疆政策，甚至对中国内政粗暴干涉。中方对此坚决反对，也将继续采取一切必要举措，维护中国企业和劳动者的合法权益。', '2021-03-29 12:29:00.000000', '/static/picture/testimg.jpg', '0', '白棉花为何上了“黑名单”？');
INSERT INTO `hotnews` VALUES ('4', '流传说法：\r\n较真鉴定： 假谣言\r\n查证要点：\r\n1世界卫生组织（WHO）从未禁止过对死于Covid-19的患者进行尸检。Covid-19是由一种名为SARS-CoV-2的病毒（新型冠状病毒）引起的，而不是一种细菌。\r\n2在意大利Covid-19潜在治疗方案的临床试验名单中，也没有明确提及阿司匹林。而且三片阿司匹林加蜂蜜煮过的柠檬汁并没有用处。\r\n3肺炎是重症Covid-19患者的常见并发症。而血栓栓塞是Covid-19重症患者可能出现的几种潜在并发症之一。\r\n查证者：返朴专业科普平台\r\n时间 : 2021-03-25 来源 : 腾讯较真 查看原文\r\n去年六月， Facebook上出现了一篇关于新冠病毒的帖子，称意大利在应对新冠大流行的时候发现了“Covid-19不是病毒，而是细菌感染”的“真相”。近来，这些流言在其他社交平台重新发酵（其实是文字缩减了一些，文采更差了），逐渐转入我国，在微信群和朋友圈四处流传。\r\n\r\n让我们先看看原始版本引人注目的“精彩”开头：\r\n\r\nundefined\r\n注：谣言文章截图\r\n\r\n流言声称，意大利背着世卫组织对Covid-19患者进行尸检，结果发现这一疾病其实是由一种导致血液凝结的细菌引起的，而不是什么“新冠病毒”。\r\n\r\n但事实是，该帖子中的每一句“声明”都漏洞百出，实乃无稽之谈。让我们来一句句戳破它。\r\n\r\n一、世卫组织禁止解剖Covid-19患者尸体？\r\nundefined\r\n注：谣言文章截图\r\n\r\n世界卫生组织（WHO）从未禁止过对死于Covid-19的患者进行尸检。早在2020年3月24日，WHO就发布了关于管理尸体和对Covid-19死亡患者进行尸检的安全措施的指导意见[1]，该指南中从未出现“不应该进行尸体解剖”的类似字样。\r\n\r\n虽然意大利卫生部在2020年4月1日建议不要对明显患有该疾病的患者进行尸检，但他们确实对Covid-19死亡患者进行了尸检。事实上，英国和中国等其他国家也都是允许对Covid-19死亡患者进行尸检的。\r\n\r\n二．新冠病毒不是病毒，而是细菌，会使血液凝结？\r\nundefined\r\n注：谣言文章截图\r\n\r\nCovid-19是由一种名为SARS-CoV-2的病毒（新型冠状病毒）引起的，而不是一种细菌。这是毋庸置疑的事实。新冠疫情暴发以来，科学家们就一直在研究这种疾病及其致病原因，并且对致病病毒的遗传物质进行了测序。\r\n\r\n不容否认的是，严重的Covid-19的确可能导致凝血问题，Covid-19患者确实可能会出现由细菌引起的继发性感染，陷入危险。\r\n\r\n三、用阿司匹林和凝血药物可治愈新冠？\r\nundefined\r\n注：谣言文章截图\r\n\r\n事实上，关于治疗Covid-19患者的、临床试验以外的药物，意大利药品管理局并没有提到阿司匹林；在意大利Covid-19潜在治疗方案的临床试验名单中，也没有明确提及阿司匹林。虽然目前的确有一项使用阿司匹林治疗Covid-19的研究，但并不是在意大利进行的。\r\n\r\n在某些医疗过程中，意大利给Covid-19患者使用的是一种名为肝素（通常用于防止血栓的形成）的抗凝剂，而非所谓的“凝血药物”。\r\n\r\n四、意大利要求比尔·盖茨和世界卫生组织对罪行负责？\r\nundefined\r\n注：谣言文章截图\r\n\r\n这里似乎指的是意大利国会议员萨拉·库尼亚尔（Sara Cunial）在一次演讲中要求意大利总理以反人类罪将比尔·盖茨送上国际刑事法庭的事件。不过库尼亚尔现在已经不是任何政党的成员了，她的讲话也没有得到意大利政府的认可。\r\n\r\n五、意大利尸检结果显示，这不是肺炎，而是血栓？\r\nundefined\r\n注：谣言文章截图\r\n\r\n上文已经说过，Covid-19患者被诊断为肺炎，同时又出现弥散性血管内凝血时，并不意味着就是误诊。实际上，肺炎是重症Covid-19患者的常见并发症。\r\n\r\n至于治疗，目前还没有一种针对Covid-19的特效疗法被证明是有效的。抗生素不是直接治疗病毒的，因此也不适用于Covid-19。只有当患者出现细菌感染时，才会上抗生素。\r\n\r\n有一些抗病毒药物的效果仍在测试之中，比如在英国，有些病人已经能使用瑞德西韦；消炎药布洛芬是否有用，也在测试之中；不过抗凝剂肝素已在某些情况下用于辅助治疗Covid-19。\r\n\r\n六、三片阿司匹林加蜂蜜煮过的柠檬汁能治愈新冠？\r\nundefined\r\n注：谣言文章截图\r\n\r\n目前根本找不到任何一份记录说有墨西哥家庭用这种方法治愈了Covid-19。还有一些报道说，这种家庭疗法是意大利人发明的，也有说是古巴人发明的。\r\n\r\n任何家庭疗法，包括柠檬和蜂蜜，都不能治愈，也不能预防Covid-19。加了柠檬和蜂蜜的热水当然可以缓解咳嗽，阿司匹林当然也可以用于缓解疼痛。但它们都不能除掉新冠病毒。\r\n\r\n另外，你不应该一次服用三个500毫克的阿司匹林，这剂量太多了。事实上，阿司匹林片剂通常为325mg/片（Bayer通常剂量），一般每4-6小时服用1-2片。\r\n\r\n七、意大利是全世界做尸检最多的国家，而中国只做了3例？\r\nundefined\r\n注：谣言文章截图\r\n\r\n没有任何一份报告记录了贝加莫的任何一家医院的50例Covid-19患者尸检。事实上，只有一项发表在《柳叶刀》上的研究，报道了贝加莫和米兰的医院所观察到的38例Covid-19死亡患者样本[2]。\r\n\r\n显然，中国的Covid-19死亡患者尸检早就超过了3例。早在去年6月，中国科学家就发文总结了37例系统尸检和54例微创尸检的病理结果[3]。\r\n\r\n八、如不先解决血栓栓塞的问题，在ICU的治疗就是无效的？\r\nundefined\r\n注：谣言文章截图\r\n\r\n血栓栓塞是一种血凝块，是Covid-19重症患者可能出现的几种潜在并发症之一，目前到底有多少Covid-19患者死于血栓栓塞而非呼吸衰竭或器官衰竭，仍不清楚。而且，这些症状甚至可以同时发生在同一个病人身上。\r\n\r\n至于Covid-19住院患者是否进入ICU，这一点不仅取决于他们出现的并发症，也要取决于他们的病情、需要被监测的密切程度，以及所在医院的能力和政策。\r\n\r\n九、到三月中旬，科学文献都说不应该使用消炎药？\r\nundefined\r\n注：谣言文章截图\r\n\r\n目前为止，找不到任何质疑消炎药在Covid-19患者中安全性的同行评议研究，也找不到任何来自中国的专门研究。\r\n\r\n不过，对于Covid-19患者能否使用布洛芬等抗炎药物，确实存在一些争论。\r\n\r\n疫情暴发之初，英国国家医疗服务体系（NSH）表示，除非医生明确禁止，那些有症状的自我隔离者可以服用布洛芬和扑热息痛等止痛药。\r\n\r\n但到了2020年3月中旬，NHS改变了指导方针，不再建议人们使用布洛芬。NHS表示，尽管目前没有强有力的证据表明布洛芬会使Covid-19恶化，但建议在获得更多信息之前使用扑热息痛来减轻症状。\r\n\r\n到了6月，NHS又表示，如果出现症状，布洛芬是可以使用的。不过NHS仍建议人们应该率先尝试扑热息痛，毕竟这对大多数人来说是更安全的选择。\r\n\r\n十、主要的问题不是病毒，而是免疫系统的过度反应？\r\nundefined\r\n注：谣言文章截图\r\n\r\n的确，某些患者的免疫系统会对感染产生过度反应，引发的炎症导致了器官衰竭，这就是所谓的“细胞因子风暴”。但是必须明确的一点是，证据表明，并不是所有的危重病人都存在这种现象，也不是所有的危重病人都死于细胞因子风暴。\r\n\r\n', '2021-03-31 12:30:00.000000', '/static/picture/testimg.jpg', '0', '来自意大利的“真相”：“新冠”不是病毒，而是细菌');
INSERT INTO `hotnews` VALUES ('5', '<p>最近有媒体报道称“法国发现新的变异新冠病毒，可以逃避核酸检测”，引发广泛关注。据法国卫生部公布的信息，布列塔尼一家企业内部发现聚集性感染，其中8例患者被发现携带新的变异新冠病毒。这8名患者虽然有典型的感染症状，但其此前鼻咽样本核酸测试呈阴性。该新变异株的S蛋白以及其他病毒区域中共携带9个突变。</p>\r\n<p>为什么核酸检测未能测出病毒？是变异导致的吗？自新冠爆发以来核酸检测就是各国最常用的检测手段，如果法国变异株真如报道所说能逃过核酸检测，会不会引发新一轮的疫情流行？</p>\r\n<h2>一、变异病毒此前为什么没被检测出？先从两个基础知识点说起：第一，我们用什么方式检测新冠病毒，第二，我们取什么样的标本检测新冠病毒</h2>\r\n<p>先说第一个知识点，核酸检测是病毒检测的一种方式，但两者不能完全等同。</p>\r\n<p>病毒是由里面的核酸和外面的蛋白质外壳两部分组成。病毒的个头很小，比如新冠病毒只有100纳米左右，大概是头发丝直径的六百分之一，所以我们很难直接检测活病毒，这个过程需要用到电子显微镜，还有其他更复杂的处理方式。</p>\r\n<p>因此使用更多的便是核酸检测，现在已经有了很成熟的核酸检测方法，比如RT-PCR技术。样本中的病毒核酸其实是很少的，RT-PCR的目的是将微量的特定核酸片段进行大幅扩增。在这个不断循环扩增核酸片段的过程中，达到阈值所需要的循环（cycle）越少，说明样本中特定核酸的含量越高。</p>\r\n<p>第二个知识点，我们取什么标本进行检测？</p>\r\n<p>我们现在采样的标本，包括鼻咽拭子、口咽拭子、肛拭子、深部痰以及肺泡灌洗液等。一个好的标本，应当容易采样，同时病毒载量（viral load）比较高。</p>\r\n<p>但实际上，很难有样本能完美符合这个要求。从取样难度来说，深部痰和肺泡灌洗液远远难于鼻咽/口咽拭子，但检测准确度较高。而比较鼻咽拭子和口咽拭子，大多数人往往更愿意选择后者，因为鼻咽拭子检测起来比口咽拭子难受多了。</p>\r\n<p>之前有研究人员对213名新冠肺炎住院患者进行口咽拭子和鼻咽拭子测试，鼻咽拭子的阳性检出率明显高于口咽拭子[1]。</p>\r\n<img src=\"//jiaozhen-70111.picnjc.qpic.cn/xoH4hKv5zQNogBdWH6uNEF\" alt=\"undefined\" style=\"float:none;height: ;width: \"/>\r\n<p>图注：轻重症患者口咽拭子/鼻咽拭子检出率对比 数据来源：Xiong, W. A. ,  Li, T. B. ,  Xu, W. A. ,  Wl, A. ,  Yl, A. , &amp;  Lc, A. , et al. (2020). Comparison of nasopharyngeal and oropharyngeal swabs for sars-cov-2 detection in 353 patients received tests with both specimens simultaneously - sciencedirect. International Journal of Infectious Diseases, 94, 107-109. 图片作者自制</p>\r\n<p>即便对已经确诊住院的患者而言，鼻咽拭子和口咽拭子的核酸检测仍然会有假阴性的结果出现。另外，在人体感染新冠病毒后的不同时间，不同样本中能检测到病毒的概率也是一直变化的。比如根据发表在JAMA上一篇关于新冠病毒诊断测试的研究[2]，深部呼吸道样本（肺泡灌洗液和深部痰）持续阳性的时间就比鼻咽拭子更长。</p>\r\n<p>总结一下，核酸检测并不是直接检测活病毒，检测过程受到样本病毒载量的影响，人感染病毒后，不同样本中能检测到病毒的概率也并非恒定，所以核酸检测并不能保证百分百准确，存在假阴性的可能。</p>\r\n<h2>二、法国变异病毒未能“逃避核酸检测”，目前因变异导致核酸检测失灵的概率非常低。&nbsp;</h2>\r\n<p>说完采样的问题，我们再来看看法国的情况。根据法国卫生部公布的信息，病毒变异导致核酸检测失效的可能基本排除了。但仍有很多媒体报道的标题是“法国发现变异病毒能逃避核酸检测”，这并不是事实的真相。</p>\r\n<p>很简单的一点，如果病毒逃避了核酸检测，那我们怎么知道患者是感染了新冠？实际上，法国这8名患者虽然鼻咽拭子核酸检测是阴性的，但是深部呼吸道样本的核酸检测结果是阳性的。</p>\r\n<p>这就说明一点，法国变异株并没有出现所谓“逃避核酸检测”的能力。实际上目前新冠病毒核酸检测试剂盒都是以ORF1a/b为最主要目标基因（一些厂商会再加上N、E或S基因），而ORF1a/b基因为RNA依赖的RNA聚合酶（RdRp）基因所在区域，编码RNA聚合酶，负责病毒核酸复制——这是一个相对保守的区域[3]。如果新冠病毒突变到逃避试剂盒检测，目前来看概率还是非常低的。</p>\r\n<p>而鼻咽拭子测试阴性、深部呼吸道样本测试阳性，这种情况也并不少见。一些变异株会加重这种现象，比如病毒载量低、在上呼吸道停留时间短等，都有可能导致鼻咽拭子测试阴性。</p>\r\n<p>根据法国卫生部的公告[4]，这次的变异株是来源于Clade20C病毒株，现在的初步分析不能表明新变异株具有更高的传染性，或者更强的致病能力。法国已将其列入了监测名单，但没有列入“值得担忧的变异株类型”，后者目前只有英国变异株（B.1.1.7）、南非变异株（B.1.351）和巴西变异株（P.1）等少数几种。</p>\r\n<p>大家没有必要对变异病毒株过于担心。我们在过去的一年中，已经发现了接近三万个突变，绝大多数突变是没有实际意义的，只有几十个突变会改变病毒的传播能力或致病能力。而即便是这样的突变，通过疫苗接种和有效的社会防控来控制其传播，仍是有效的。&nbsp;</p>', '2021-03-31 01:56:00.000000', '/static/picture/testimg.jpg', '2', '法国发现的新冠病毒变异株核酸检测查不出');
INSERT INTO `hotnews` VALUES ('6', '<p>微博账号“@黑老汉的白日梦”于2021年1月25日发布微博称：“疫苗大鳄比尔盖茨，雇用替身演员，表演注射疫苗，忽悠群众打疫苗。疫苗致残的问题，地球人都知道。大新闻，让更多的人，知道事实真相。”</p>\r\n<p>微博中还附加了一张图片，对比了盖茨肖像和其接种疫苗时拍摄的照片中耳部形状的不同，并据此声称接种疫苗的图片中出现的人并不是盖茨本人，而是其雇用的替身演员。</p>\r\n<img src=\"//jiaozhen-70111.picnjc.qpic.cn/7H2jm6sfg42yNGBgVxtyj1\" alt=\"undefined\" style=\"float:none;height: undefined;width: undefined\"/>\r\n<h2><strong>1，接种疫苗照片里的人是盖茨吗？</strong></h2>\r\n<p>在“@黑老汉的白日梦”微博中附有英文字幕的对比图中，右侧的照片来自于盖茨的认证推特账号。</p>\r\n<p>2021年1月23日，盖茨发布推文并配图称：“65岁高龄的好处之一就是我拥有接种新冠疫苗的资格。这周，我接种了我的第一针疫苗，并且我感觉状态很好。感谢所有的科学家、测试参与者、管理者以及前线医护工作者们帮助我们达成了现在的成就。”</p>\r\n<img src=\"//jiaozhen-70111.picnjc.qpic.cn/mGjyyQUXEvnPd2phekUoYF\" alt=\"undefined\" style=\"float:none;height: undefined;width: undefined\"/>\r\n<p>1月27日，盖茨在接受凤凰网财经频道采访时进一步透露：“我已经接种了第一剂的莫德纳（Moderna）疫苗，几周后将去接种第二剂，疫苗的有效性通常在第二剂接种完一周后会变得很高。我觉得很幸运，65岁仍然符合疫苗的接种标准并且有机会接种，我信任这些疫苗。”</p>\r\n<img src=\"//jiaozhen-70111.picnjc.qpic.cn/6USVYzaVvWxB1Us5cZcWeS\" alt=\"undefined\" style=\"float:none;height: undefined;width: undefined\"/>\r\n<p>微博对比图中左侧的照片来自Corbis签约摄影师John van Hasselt，拍摄于2018年4月16日的巴黎——当时盖茨正在爱丽舍宫受到法国总统马克龙的接见。</p>\r\n<img src=\"//jiaozhen-70111.picnjc.qpic.cn/3p1DPhnsxgUJ9FBPXLgBtJ\" alt=\"undefined\" style=\"float:none;height: undefined;width: undefined\"/>\r\n<p>从该微博发布的对比图中可以看出，盖茨在接种疫苗时没有佩戴眼镜，发型似乎也没有精心打理，并且比2018年的照片中显得更加灰白。这与人们熟悉的盖茨形象有一定的差距。</p>\r\n<p>然而，两张图片的拍摄时间、环境和人物的身体状态都是完全不同的。</p>\r\n<p>其中，最大的不同之处就在于口罩的佩戴。2021年接种疫苗时拍摄的照片中，考虑到新冠疫情影响下的公共卫生条件和社会规范，盖茨佩戴着口罩；然而，2018年拍摄的照片中，盖茨没有佩戴口罩或任何面部饰物，当时的公共卫生条件和社会规范也不需要他长期地、频繁地佩戴口罩。</p>\r\n<p>在盖茨基金会官方认证微博账号于2021年1月28日发布的一则微博中，附加的视频封面图片中的盖茨佩带着口罩，发型和发色均与接种疫苗时拍摄照片中的形象极其类似，并且耳部形状也与接种疫苗时照片中的耳朵形状十分接近。</p>\r\n<img src=\"//jiaozhen-70111.picnjc.qpic.cn/u4PJbiek3Kq6hNKjjr6gSH\" alt=\"undefined\" style=\"float:none;height: undefined;width: undefined\"/>\r\n<p>美国全国公共广播电视台（NPR）早在2015年1月10日发布的一则报道中，就使用了一张盖茨未佩戴眼镜的照片。照片中，盖茨的发型、发色和眼部特征均与接种疫苗时照片中的相似。</p>\r\n<img src=\"//jiaozhen-70111.picnjc.qpic.cn/qfhkR9UpgBYMCj2Mauff33\" alt=\"undefined\" style=\"float:none;height: undefined;width: undefined\"/>\r\n<p>类似的例子还有2021年1月27日，比尔和梅琳达·盖茨发布他们的2021年度公开信《这一年，全球健康与你我休戚与共》中的配图：</p>\r\n\r\n<p>在这张2020年12月22日发布在盖茨博客中的文章配图中，其耳部与接种疫苗时拍摄照片中的耳部形状十分接近：</p>\r\n<img src=\"//jiaozhen-70111.picnjc.qpic.cn/6SG6FaeVySiUqED3Mj8jEQ\" alt=\"undefined\" style=\"float:none;height: undefined;width: undefined\"/>\r\n<p>另据一份发布于2020年6月18日的研究，较长时间佩戴由松紧带环绕双耳固定在面部的口罩可能会导致耳部变形。</p>\r\n<p>在美国国家医学图书馆（NLM）国家生物技术信息中心（National Center for Biotechnology Information，NCBI）网站上，Bruno Zanotti等人的这份研究分析了类似口罩产品对于儿童耳部发育的影响。</p>\r\n<img src=\"//jiaozhen-70111.picnjc.qpic.cn/xnx21ZgkDzbnbEqVekn4as\" alt=\"undefined\" style=\"float:none;height: undefined;width: undefined\"/>\r\n<p>他们的研究指出，“这些松紧带结构造成了对皮肤以及耳廓软骨的持续性压迫，如果每天佩戴数小时，可能会导致出现红斑和后耳皮肤的疼痛性损伤。尚未进入青春期的儿童耳廓软骨尚未发育完全，抵抗形变的能力更弱；口罩松紧带绳套对外耳空洞甚至是反螺旋体带来的长时间压迫会影响外耳的正确成长和角度。”</p>\r\n<p>由此可见，大部分口罩产品的松紧带结构会对人体耳部产生压迫，长时间佩戴可能使外耳产生形变，只不过由于成年人耳廓软骨的发育程度和抗形变能力远高于儿童，短时间佩戴口罩也不会出现严重的不可逆损伤。</p>\r\n<p>因此，受口罩松紧带结构的影响，再加上拍摄角度、拍摄时间、光线条件等因素的差异，造成不同照片呈现的耳部形状存在一定的差异，不能成为判断照片中被拍摄者是否为同一人的充分依据', '2021-03-31 01:56:00.000000', '/static/picture/testimg.jpg', '2', '比尔·盖茨雇替身打新冠疫苗？');
INSERT INTO `hotnews` VALUES ('7', 'text', '2021-03-31 01:56:00.000000', '/static/picture/testimg.jpg', '0', 'text真相');
INSERT INTO `hotnews` VALUES ('8', 'text2真相', '2021-03-31 01:56:00.000000', '/static/picture/testimg.jpg', '0', 'text2');
INSERT INTO `hotnews` VALUES ('9', 'text3', '2021-03-31 01:56:00.000000', '/static/picture/testimg.jpg', '0', 'text3');
INSERT INTO `hotnews` VALUES ('10', 'text4', '2021-03-31 01:56:00.000000', '/static/picture/testimg.jpg', '0', 'text4');

-- ----------------------------
-- Table structure for `mylike`
-- ----------------------------
DROP TABLE IF EXISTS `mylike`;
CREATE TABLE `mylike` (
  `likeid` int NOT NULL AUTO_INCREMENT,
  `userid` int NOT NULL,
  `newsid` int NOT NULL,
  PRIMARY KEY (`likeid`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of mylike
-- ----------------------------
INSERT INTO `mylike` VALUES ('9', '2', '3');
INSERT INTO `mylike` VALUES ('10', '2', '1');
INSERT INTO `mylike` VALUES ('13', '2', '2');

-- ----------------------------
-- Table structure for `question`
-- ----------------------------
DROP TABLE IF EXISTS `question`;
CREATE TABLE `question` (
  `questionid` int NOT NULL AUTO_INCREMENT,
  `userid_id` int NOT NULL,
  `content` longtext NOT NULL,
  `time` datetime(6) NOT NULL,
  `title` varchar(250) NOT NULL,
  PRIMARY KEY (`questionid`),
  KEY `Question_userid_id_5eb69b8c` (`userid_id`),
  CONSTRAINT `Question_userid_id_5eb69b8c_fk_User_userid` FOREIGN KEY (`userid_id`) REFERENCES `user` (`userid`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of question
-- ----------------------------
INSERT INTO `question` VALUES ('1', '1', '为什么嘞。。。', '2021-04-09 11:09:00.000000', '白棉花为何上了“黑名单”？');
INSERT INTO `question` VALUES ('2', '1', '为什么嘞。。。', '2021-04-09 11:09:00.000000', '比尔·盖茨雇替身打新冠疫苗？');
INSERT INTO `question` VALUES ('3', '2', '如题。。。。。。。。。。。。', '2021-04-11 14:30:15.934854', '可以不吃早饭吗');
INSERT INTO `question` VALUES ('4', '2', '增肥增肥增肥增肥增肥增肥增肥', '2021-04-11 14:30:15.934854', '怎么安排一天六顿');
INSERT INTO `question` VALUES ('5', '2', '狙击皇家空军航空那你客户', '2021-04-11 14:40:00.730979', '黄及');
INSERT INTO `question` VALUES ('6', '2', '。。。。。。。。。。。', '2021-04-16 04:51:28.678171', '最后一个问题');

-- ----------------------------
-- Table structure for `user`
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `userid` int NOT NULL AUTO_INCREMENT,
  `username` varchar(20) NOT NULL,
  `password` varchar(255) NOT NULL,
  `nickname` varchar(20) DEFAULT NULL,
  `avatarurl` varchar(255) DEFAULT NULL,
  `tel` varchar(11) DEFAULT NULL,
  `token` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`userid`),
  UNIQUE KEY `User_username_3851fdce_uniq` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('1', 'admin', 'pbkdf2_sha256$216000$ReUJs1WoGSme$BYRCxeXLGlvI7edrHXLipGQv7/SqagTtTapkjPYY8e0=', 'admin_test', '/static/picture/testimg.jpg', '11111111111', 'TKxedbuhmcozcckhw1617362009');
INSERT INTO `user` VALUES ('2', '123', 'pbkdf2_sha256$216000$tLRuxcbgTgl5$JyGFG7/l7KeAH+aEht8A4vP+ewR80Db3tDMboPrRYcU=', 'hello', '/static/picture/MTYxODU2ODY2My45MzEzNTU1.png', 'null', 'TKymctcjadmcyvdei1618893117');
INSERT INTO `user` VALUES ('3', '1234', 'pbkdf2_sha256$216000$tLRuxcbgTgl5$JyGFG7/l7KeAH+aEht8A4vP+ewR80Db3tDMboPrRYcU=', '1234', '/static/picture/testimg.jpg', null, 'TKuungjwahtistxat1618569087');
INSERT INTO `user` VALUES ('4', '12344', 'pbkdf2_sha256$216000$nT2ThfOinVpp$zn18CPsea3YbTuTghg9AOgOAdKtkRu8r5mSUq3zh10I=', '12344', '/static/picture/testimg.jpg', null, null);
INSERT INTO `user` VALUES ('5', '123222', 'pbkdf2_sha256$216000$7C8T78sFagnU$N5+8Z+RWlPpWrHozXXI/xcbVdARUtn5xUuy4vEZ9ZLY=', '123222', '/static/picture/testimg.jpg', null, null);
INSERT INTO `user` VALUES ('6', '1111', 'pbkdf2_sha256$216000$pyOnHrpzWloO$hDxO4kfq4RXTj7KqXDxRqxJoQJcUpajk4lsUivjHoik=', '1111', '/static/picture/testimg.jpg', null, null);
INSERT INTO `user` VALUES ('7', '12345', 'pbkdf2_sha256$216000$1ghrTQzSgPxh$0OePFj9v654orkbCImF6Q3XplnjbIKKiXxsMDB/Xdts=', '12345', '/static/picture/testimg.jpg', null, null);
INSERT INTO `user` VALUES ('8', 'zxczxc', 'pbkdf2_sha256$216000$dzXn6CpKZ5nH$r0ZqE6Hp+Nw8Ds2nMRbzGjHPPrntgh9o8rddcOraDno=', 'zxczxc', '/static/picture/testimg.jpg', null, null);
INSERT INTO `user` VALUES ('9', '1311055', 'pbkdf2_sha256$216000$tpZatp3w9Jc5$3RFXRf+bbSqdhKCo4Of2t2cmoc8wdt+gqyW9DnylW4E=', '1311055', '/static/picture/testimg.jpg', null, 'TKvqfgsmacsgdrpfy1619188729');
