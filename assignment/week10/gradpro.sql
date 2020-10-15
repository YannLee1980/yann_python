-- MySQL dump 10.13  Distrib 8.0.20, for macos10.15 (x86_64)
--
-- Host: localhost    Database: gradpro
-- ------------------------------------------------------
-- Server version	8.0.20

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=73 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add user',4,'add_user'),(14,'Can change user',4,'change_user'),(15,'Can delete user',4,'delete_user'),(16,'Can view user',4,'view_user'),(17,'Can add content type',5,'add_contenttype'),(18,'Can change content type',5,'change_contenttype'),(19,'Can delete content type',5,'delete_contenttype'),(20,'Can view content type',5,'view_contenttype'),(21,'Can add session',6,'add_session'),(22,'Can change session',6,'change_session'),(23,'Can delete session',6,'delete_session'),(24,'Can view session',6,'view_session'),(25,'Can add auth group',7,'add_authgroup'),(26,'Can change auth group',7,'change_authgroup'),(27,'Can delete auth group',7,'delete_authgroup'),(28,'Can view auth group',7,'view_authgroup'),(29,'Can add auth group permissions',8,'add_authgrouppermissions'),(30,'Can change auth group permissions',8,'change_authgrouppermissions'),(31,'Can delete auth group permissions',8,'delete_authgrouppermissions'),(32,'Can view auth group permissions',8,'view_authgrouppermissions'),(33,'Can add auth permission',9,'add_authpermission'),(34,'Can change auth permission',9,'change_authpermission'),(35,'Can delete auth permission',9,'delete_authpermission'),(36,'Can view auth permission',9,'view_authpermission'),(37,'Can add auth user',10,'add_authuser'),(38,'Can change auth user',10,'change_authuser'),(39,'Can delete auth user',10,'delete_authuser'),(40,'Can view auth user',10,'view_authuser'),(41,'Can add auth user groups',11,'add_authusergroups'),(42,'Can change auth user groups',11,'change_authusergroups'),(43,'Can delete auth user groups',11,'delete_authusergroups'),(44,'Can view auth user groups',11,'view_authusergroups'),(45,'Can add auth user user permissions',12,'add_authuseruserpermissions'),(46,'Can change auth user user permissions',12,'change_authuseruserpermissions'),(47,'Can delete auth user user permissions',12,'delete_authuseruserpermissions'),(48,'Can view auth user user permissions',12,'view_authuseruserpermissions'),(49,'Can add django admin log',13,'add_djangoadminlog'),(50,'Can change django admin log',13,'change_djangoadminlog'),(51,'Can delete django admin log',13,'delete_djangoadminlog'),(52,'Can view django admin log',13,'view_djangoadminlog'),(53,'Can add django content type',14,'add_djangocontenttype'),(54,'Can change django content type',14,'change_djangocontenttype'),(55,'Can delete django content type',14,'delete_djangocontenttype'),(56,'Can view django content type',14,'view_djangocontenttype'),(57,'Can add django migrations',15,'add_djangomigrations'),(58,'Can change django migrations',15,'change_djangomigrations'),(59,'Can delete django migrations',15,'delete_djangomigrations'),(60,'Can view django migrations',15,'view_djangomigrations'),(61,'Can add django session',16,'add_djangosession'),(62,'Can change django session',16,'change_djangosession'),(63,'Can delete django session',16,'delete_djangosession'),(64,'Can view django session',16,'view_djangosession'),(65,'Can add shampoo',17,'add_shampoo'),(66,'Can change shampoo',17,'change_shampoo'),(67,'Can delete shampoo',17,'delete_shampoo'),(68,'Can view shampoo',17,'view_shampoo'),(69,'Can add shampoo raw',18,'add_shampooraw'),(70,'Can change shampoo raw',18,'change_shampooraw'),(71,'Can delete shampoo raw',18,'delete_shampooraw'),(72,'Can view shampoo raw',18,'view_shampooraw');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'auth','user'),(5,'contenttypes','contenttype'),(6,'sessions','session'),(7,'shampoo','authgroup'),(8,'shampoo','authgrouppermissions'),(9,'shampoo','authpermission'),(10,'shampoo','authuser'),(11,'shampoo','authusergroups'),(12,'shampoo','authuseruserpermissions'),(13,'shampoo','djangoadminlog'),(14,'shampoo','djangocontenttype'),(15,'shampoo','djangomigrations'),(16,'shampoo','djangosession'),(17,'shampoo','shampoo'),(18,'shampoo','shampooraw');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2020-09-02 07:19:41.825576'),(2,'auth','0001_initial','2020-09-02 07:19:41.911169'),(3,'admin','0001_initial','2020-09-02 07:19:42.101719'),(4,'admin','0002_logentry_remove_auto_add','2020-09-02 07:19:42.145712'),(5,'admin','0003_logentry_add_action_flag_choices','2020-09-02 07:19:42.154338'),(6,'contenttypes','0002_remove_content_type_name','2020-09-02 07:19:42.201304'),(7,'auth','0002_alter_permission_name_max_length','2020-09-02 07:19:42.224189'),(8,'auth','0003_alter_user_email_max_length','2020-09-02 07:19:42.247286'),(9,'auth','0004_alter_user_username_opts','2020-09-02 07:19:42.255515'),(10,'auth','0005_alter_user_last_login_null','2020-09-02 07:19:42.284897'),(11,'auth','0006_require_contenttypes_0002','2020-09-02 07:19:42.287452'),(12,'auth','0007_alter_validators_add_error_messages','2020-09-02 07:19:42.295452'),(13,'auth','0008_alter_user_username_max_length','2020-09-02 07:19:42.327420'),(14,'auth','0009_alter_user_last_name_max_length','2020-09-02 07:19:42.356474'),(15,'auth','0010_alter_group_name_max_length','2020-09-02 07:19:42.371303'),(16,'auth','0011_update_proxy_permissions','2020-09-02 07:19:42.380683'),(17,'sessions','0001_initial','2020-09-02 07:19:42.393491'),(18,'shampoo','0001_initial','2020-09-04 03:54:28.030613');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shampoo`
--

DROP TABLE IF EXISTS `shampoo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `shampoo` (
  `name` text,
  `short` text,
  `time` date DEFAULT NULL,
  `sentiment` double DEFAULT NULL,
  `id` bigint DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shampoo`
--

LOCK TABLES `shampoo` WRITE;
/*!40000 ALTER TABLE `shampoo` DISABLE KEYS */;
INSERT INTO `shampoo` VALUES ('飘柔兰花去屑洗发水露1L','飘柔主要两个系列，这是家庭护理系列，十年前就200毫升9块9，另一款精华护理系列才是印象中的飘柔，不过也不贵，相比保洁其他洗发水也是便宜许多 ','2020-09-04',0.97,1),('飘柔兰花去屑洗发水露1L','谢谢已入。。。 ','2020-09-04',0.44,2),('飘柔兰花去屑洗发水露1L','散了吧、19.9  都散了 ','2020-09-04',0.38,3),('飘柔兰花去屑洗发水露1L','功能超级基础，干 ','2020-09-04',0.63,4),('飘柔兰花去屑洗发水露1L','补贴后，19.9了可以散啦 ','2020-09-04',0.04,5),('飘柔兰花去屑洗发水露1L','保价去 ','2020-09-04',0.79,6),('飘柔兰花去屑洗发水露1L','9.8刚买 ','2020-09-04',0.45,7),('飘柔兰花去屑洗发水露1L','没有优惠卷的话打开淘宝首页百亿补贴，里面搜飘柔然后下单立减 ','2020-09-04',0.11,8),('飘柔兰花去屑洗发水露1L','一个账号只能买一瓶，下单了 ','2020-09-04',0.14,9),('飘柔兰花去屑洗发水露1L','我想那种第一次可以三天不洗的 ','2020-09-04',0.1,10),('飘柔兰花去屑洗发水露1L','没货啊 我这里显示没货 ','2020-09-04',0.03,11),('飘柔兰花去屑洗发水露1L','已买，男的一天一洗，很适合了 ','2020-09-04',0.29,12),('飘柔兰花去屑洗发水露1L','19块刚买过，真的，天猫发货 ','2020-09-04',0.27,13),('飘柔兰花去屑洗发水露1L','这东西我用多了就得上药用的，很难受，雪花飘飘 ','2020-09-04',0.08,14),('飘柔兰花去屑洗发水露1L','这货最','2020-09-04',0.28,15),('飘柔兰花去屑洗发水露1L','一直显示：同一时间下单人数过多，建议您稍后再试 ','2020-09-04',0,16),('飘柔兰花去屑洗发水露1L','我最近在用，也感觉到了 ','2020-09-04',0.55,17),('飘柔兰花去屑洗发水露1L','昨天14.9买的，陪了一毛钱，心好痛 ','2020-09-04',0.89,18),('飘柔兰花去屑洗发水露1L','买一瓶先屯着，上次京东买的29.9   。。。。。 ','2020-09-04',0.24,19),('飘柔兰花去屑洗发水露1L','打开淘宝，从百亿补贴进，直接就14.8 ','2020-09-04',0.07,20),('飘柔兰花去屑洗发水露1L','亏了 上次19.9出手了 ','2020-09-04',0.59,21),('飘柔兰花去屑洗发水露1L','并没有过期，我刚刚下单，比前几天的14.9还便宜一毛 ','2020-09-03',0.52,22),('飘柔兰花去屑洗发水露1L','已入，便宜啊 ','2020-09-03',0.55,23),('飘柔兰花去屑洗发水露1L','风清扬差点想用独孤九剑刺人 ','2020-09-03',0.44,24),('飘柔兰花去屑洗发水露1L','搞错了，再来 ','2020-09-03',0.21,25),('飘柔兰花去屑洗发水露1L','不好用。现在还在发愁怎么消耗 ','2020-09-03',0.86,26),('飘柔兰花去屑洗发水露1L','去 他 妹 子 的，专门升级了天猫，扫码进去36.8！曹丹的！ ','2020-09-03',0.15,27),('飘柔兰花去屑洗发水露1L','不用新版。。。。 ','2020-09-03',0.59,28),('飘柔兰花去屑洗发水露1L','下单时候自动减免品类购物券 ','2020-09-03',0.11,29),('飘柔兰花去屑洗发水露1L','理论上来说，这家店应该是天猫自己去拿来和拼夕夕比百亿补贴低价竞争的正品店，货源应该是有保证的，我买过十几次9块钱包邮的农夫山泉和可乐，感觉挺真 ','2020-09-03',0,30),('飘柔兰花去屑洗发水露1L','谢谢，已买。。。。。。。。。。。 ','2020-09-03',0.45,31),('飘柔兰花去屑洗发水露1L','刚19.9，，，靠 ','2020-09-03',0.47,32),('飘柔兰花去屑洗发水露1L','曾经很高端的飘柔，如今也成了地摊货了 ','2020-09-03',0.75,33),('飘柔兰花去屑洗发水露1L','号真黑，这些东西完全买不了 ','2020-09-03',0.22,34),('飘柔兰花去屑洗发水露1L','用这款飘柔是油的快，真的痒 ','2020-09-03',0.94,35),('飘柔兰花去屑洗发水露1L','淘宝首页百亿补贴进去搜飘柔，自动减 ','2020-09-03',0.07,37),('飘柔兰花去屑洗发水露1L','券呢？在哪里？ ','2020-09-03',0.34,38),('飘柔兰花去屑洗发水露1L','打算等12块再考虑入手 ','2020-09-03',0.49,39),('飘柔兰花去屑洗发水露1L','放心吧，天猫正品 ','2020-09-03',0.93,40),('飘柔兰花去屑洗发水露1L','不是啊，之前一直都是11快多啊我买过两次。。。这个14块还是不值 ','2020-09-03',0.05,41),('飘柔兰花去屑洗发水露1L','已经没了，散了散了。 ','2020-09-03',0.25,42),('飘柔兰花去屑洗发水露1L','无功无过，挺好的 ','2020-09-03',0.73,43),('飘柔兰花去屑洗发水露1L','没看到券，直接下单是36.8 ','2020-09-03',0.09,44),('飘柔兰花去屑洗发水露1L','券在哪儿？ ','2020-09-03',0.34,45),('古龙洗发水男士专用去屑止痒控油香味持久留香洗头膏露沐浴露套装','注意我的订单截图，左下角 品类购物券 上方返回有个紫红小圆圈里面的字，下载那个App ','2020-09-04',0,60),('古龙洗发水男士专用去屑止痒控油香味持久留香洗头膏露沐浴露套装','就下载紫红圓圈里的字的App ','2020-09-04',0.06,61),('古龙洗发水男士专用去屑止痒控油香味持久留香洗头膏露沐浴露套装','只有你有 我们都没有 ','2020-09-04',0.55,62),('古龙洗发水男士专用去屑止痒控油香味持久留香洗头膏露沐浴露套装','就是看我的订单截图呀，品类购物券上方返回有个紫红圆圈里的字 ','2020-09-04',0,63),('古龙洗发水男士专用去屑止痒控油香味持久留香洗头膏露沐浴露套装','你自己有品类券不代表所有人都有，估计也只有你一个人有 ','2020-09-04',0.2,64),('古龙洗发水男士专用去屑止痒控油香味持久留香洗头膏露沐浴露套装','我的订单截图，左下角 品类购物券 上方返回有个紫红小圆圈里面的字 ','2020-09-04',0,65),('古龙洗发水男士专用去屑止痒控油香味持久留香洗头膏露沐浴露套装','没找到^_^ ','2020-09-04',0.76,66),('古龙洗发水男士专用去屑止痒控油香味持久留香洗头膏露沐浴露套装','仔细注意订单页面，左下角品类券上方，返回那里紫红小圆圈的字 ','2020-09-04',0,67),('古龙洗发水男士专用去屑止痒控油香味持久留香洗头膏露沐浴露套装','淘礼金怎么领都不告诉大家你叫人家去哪领淘礼金？ ','2020-09-04',0.21,68),('古龙洗发水男士专用去屑止痒控油香味持久留香洗头膏露沐浴露套装','淘礼金怎么弄？ ','2020-09-04',0.26,69),('古龙洗发水男士专用去屑止痒控油香味持久留香洗头膏露沐浴露套装','各位值友们，记得领取礼金红包 ','2020-09-04',0.49,70),('BAWANG霸王何首乌控油防脱发洗发液1L+赠生姜强根护发素80ml*2件','该脱的什么洗发水都没用，不会脱的调整作息和饮食就能好 ','2020-09-03',0.18,82),('BAWANG霸王何首乌控油防脱发洗发液1L+赠生姜强根护发素80ml*2件','duang~~~! ','2020-09-03',0.5,83),('BAWANG霸王何首乌控油防脱发洗发液1L+赠生姜强根护发素80ml*2件','20多岁就关注防脱洗发水了 ','2020-09-03',0.29,84),('Rejoice飘柔顺滑洗护套装750ml*2瓶','除了品牌自营店，别的都一样的，对于我来说，实惠就行。用飘柔六七年了，都一样 ','2020-09-04',0.99,88),('Rejoice飘柔顺滑洗护套装750ml*2瓶','又来拼购店， ','2020-09-04',0.36,89),('Rejoice飘柔顺滑洗护套装750ml*2瓶','开了有一段时间了，产品质量没问题就行 ','2020-09-04',0.39,90),('Rejoice飘柔顺滑洗护套装750ml*2瓶','新开的第三方拼购店 ','2020-09-04',0.11,91),('卡诗（KERASTASE）头皮系列根源特护洗发水1000ml修护纤细脆弱发根无硅油','太贵了，之前亚马逊299 ','2020-09-04',0.57,96),('卡诗（KERASTASE）头皮系列根源特护洗发水1000ml修护纤细脆弱发根无硅油','这个牌子修护还是可以的 ','2020-09-04',0.45,97),('卡诗（KERASTASE）头皮系列根源特护洗发水1000ml修护纤细脆弱发根无硅油','169的优惠券在哪里 ','2020-09-04',0.6,98),('卡诗（KERASTASE）头皮系列根源特护洗发水1000ml修护纤细脆弱发根无硅油','plus可以199-40 ','2020-09-03',0.5,99),('卡诗（KERASTASE）头皮系列根源特护洗发水1000ml修护纤细脆弱发根无硅油','券在哪里领？ ','2020-09-03',0.31,100),('卡诗（KERASTASE）头皮系列根源特护洗发水1000ml修护纤细脆弱发根无硅油','好用 确实不错 ','2020-09-03',0.95,101),('卡诗（KERASTASE）头皮系列根源特护洗发水1000ml修护纤细脆弱发根无硅油','好用！！！！！！ ','2020-09-03',0.06,102),('卡诗（KERASTASE）头皮系列根源特护洗发水1000ml修护纤细脆弱发根无硅油','对于头发出油多、发质良好的人来说，本来就不需要硅油进行滋润保护，无硅油洗发水显然会更加得心应手 ','2020-09-03',0.34,103),('Head&Shoulders海飞丝丝源复活头皮保湿洗发露530ml*2件','要运费？？？  我叼。。。 ','2020-09-04',0.01,112),('Head&Shoulders海飞丝丝源复活头皮保湿洗发露530ml*2件','还别说，这系列确实不错！已使用一年！ ','2020-09-04',0.95,113),('Head&Shoulders海飞丝丝源复活头皮保湿洗发露530ml*2件','求券链接。。 ','2020-09-04',0.22,114),('Head&Shoulders海飞丝丝源复活头皮保湿洗发露530ml*2件','看了看历史订单，2019年9月份不到10块钱买的 ','2020-09-04',0.1,115),('Head&Shoulders海飞丝丝源复活头皮保湿洗发露530ml*2件','找不到券啊 ','2020-09-04',0.11,116),('Head&Shoulders海飞丝丝源复活头皮保湿洗发露530ml*2件','这个系列应该比标准白瓶好，标准白又比绿瓶好。绿瓶好像是电商特供，感觉很一般。 ','2020-09-04',0.5,117),('Head&Shoulders海飞丝丝源复活头皮保湿洗发露530ml*2件','绿的去屑，蓝的保湿 ','2020-09-04',0.86,118),('Head&Shoulders海飞丝丝源复活头皮保湿洗发露530ml*2件','我喜欢用这个 ','2020-09-04',0.7,119),('Head&Shoulders海飞丝丝源复活头皮保湿洗发露530ml*2件','说一下优惠券哪里领啊 ','2020-09-04',0.21,120),('Head&Shoulders海飞丝丝源复活头皮保湿洗发露530ml*2件','那是护发素吧 ','2020-09-04',0.36,121),('Head&Shoulders海飞丝丝源复活头皮保湿洗发露530ml*2件','绿的跟着有啥区别？ ','2020-09-04',0.8,122),('Head&Shoulders海飞丝丝源复活头皮保湿洗发露530ml*2件','不能叠加优惠？ ','2020-09-04',0.36,123),('Head&Shoulders海飞丝丝源复活头皮保湿洗发露530ml*2件','APP首页-优惠券-京东页面里就找得到京东超市周年庆优惠券了 ','2020-09-04',0.7,124),('Head&Shoulders海飞丝丝源复活头皮保湿洗发露530ml*2件','199-40券在哪里？ ','2020-09-04',0.32,125),('KASTIZA凯仕帝海飞丝3D去屑止痒洗发露750ml','上个月买了的，是正品，价格不错，看评价可解毒 ','2020-09-03',0.97,140),('KASTIZA凯仕帝海飞丝3D去屑止痒洗发露750ml','8月1号开张的第三方店 ','2020-09-03',0.01,141),('移动专享：CLEAR清扬清爽控油型去屑洗沐套装（洗发水500g+幽莲魅肤沐浴乳350g+清扬100g*2）','原价谁会买，这价都贵了 ','2020-09-03',0.26,144),('移动专享：CLEAR清扬清爽控油型去屑洗沐套装（洗发水500g+幽莲魅肤沐浴乳350g+清扬100g*2）','第三方拼购店 ','2020-09-03',0.12,145),('聚划算百亿补贴：Rejoice飘柔清爽去屑/洁顺水润洗发水1000ml','收到了，天猫超市发的货，应该靠谱吧 ','2020-09-04',0.12,148),('聚划算百亿补贴：Rejoice飘柔清爽去屑/洁顺水润洗发水1000ml','天猫超市发的 ','2020-09-04',0.47,149),('聚划算百亿补贴：Rejoice飘柔清爽去屑/洁顺水润洗发水1000ml','我不是杠，你认为花钱买了无敌券，会员是送的，券等于钱。他认为花钱买了会员，券是送的。观点不同而已。 ','2020-09-04',0,150),('聚划算百亿补贴：Rejoice飘柔清爽去屑/洁顺水润洗发水1000ml','就是美杏仁那款 ','2020-09-04',0.91,151),('聚划算百亿补贴：Rejoice飘柔清爽去屑/洁顺水润洗发水1000ml','便宜是真啊 ','2020-09-04',0.67,152),('聚划算百亿补贴：Rejoice飘柔清爽去屑/洁顺水润洗发水1000ml','帝都不销售，差评 ','2020-09-04',0.05,153),('聚划算百亿补贴：Rejoice飘柔清爽去屑/洁顺水润洗发水1000ml','如何撸的？我只撸了一瓶…… ','2020-09-04',0.32,154),('聚划算百亿补贴：Rejoice飘柔清爽去屑/洁顺水润洗发水1000ml','劣制跟价格没直接关系……这个网上有科普，一句话来说就是各种成分比例不同 ','2020-09-04',0.98,155),('聚划算百亿补贴：Rejoice飘柔清爽去屑/洁顺水润洗发水1000ml','以前觉得飘柔洗发水很高档，怎么现在便宜成这样了 ','2020-09-04',0.69,156),('聚划算百亿补贴：Rejoice飘柔清爽去屑/洁顺水润洗发水1000ml','秀发去无踪 头屑更出众  ','2020-09-04',0.9,157),('聚划算百亿补贴：Rejoice飘柔清爽去屑/洁顺水润洗发水1000ml','莫慌，十个光头九富 ','2020-09-04',0.91,158),('聚划算百亿补贴：Rejoice飘柔清爽去屑/洁顺水润洗发水1000ml','不要慌！其实 是开始变强了！ ','2020-09-04',0.66,159),('聚划算百亿补贴：Rejoice飘柔清爽去屑/洁顺水润洗发水1000ml','已经撸了3瓶了，不要了 ','2020-09-04',0.18,160),('聚划算百亿补贴：Rejoice飘柔清爽去屑/洁顺水润洗发水1000ml','感觉一般般吧 ','2020-09-04',0.53,161),('聚划算百亿补贴：Rejoice飘柔清爽去屑/洁顺水润洗发水1000ml','没什么变化，该秃还是秃。','2020-09-04',0.82,162),('聚划算百亿补贴：Rejoice飘柔清爽去屑/洁顺水润洗发水1000ml','听他','2020-09-04',0.59,163),('聚划算百亿补贴：Rejoice飘柔清爽去屑/洁顺水润洗发水1000ml','这种的怕不是正品吧？ ','2020-09-04',0.65,164),('聚划算百亿补贴：Rejoice飘柔清爽去屑/洁顺水润洗发水1000ml','感觉前几天的六神是假的，冰片完全无感 ','2020-09-04',0.45,165),('聚划算百亿补贴：Rejoice飘柔清爽去屑/洁顺水润洗发水1000ml','读书的时候用这款飘柔头皮屑就贼多 ','2020-09-04',0.65,166),('聚划算百亿补贴：Rejoice飘柔清爽去屑/洁顺水润洗发水1000ml','第三方的，请谨慎 ','2020-09-04',0.06,167),('聚划算百亿补贴：Rejoice飘柔清爽去屑/洁顺水润洗发水1000ml','十几还谈质量','2020-09-04',0.51,168),('聚划算百亿补贴：Rejoice飘柔清爽去屑/洁顺水润洗发水1000ml','大神，可以给个链接吗？ ','2020-09-03',0.37,169),('聚划算百亿补贴：Rejoice飘柔清爽去屑/洁顺水润洗发水1000ml','9.9买的 ','2020-09-03',0.74,170),('聚划算百亿补贴：Rejoice飘柔清爽去屑/洁顺水润洗发水1000ml','链接有吗。 ','2020-09-03',0.39,171),('聚划算百亿补贴：Rejoice飘柔清爽去屑/洁顺水润洗发水1000ml','头发秃确实是身体原因，但再用劣质产品的话就加快秃发问题了 ','2020-09-03',0.47,172),('聚划算百亿补贴：Rejoice飘柔清爽去屑/洁顺水润洗发水1000ml','其实跟你用什么洗发水没关系 ','2020-09-03',0.24,173),('聚划算百亿补贴：Rejoice飘柔清爽去屑/洁顺水润洗发水1000ml','这和心态有毛关系  无敌券券就是钱   ','2020-09-03',0.9,174),('聚划算百亿补贴：Rejoice飘柔清爽去屑/洁顺水润洗发水1000ml','上车一瓶试试 ','2020-09-03',0.62,175),('聚划算百亿补贴：Rejoice飘柔清爽去屑/洁顺水润洗发水1000ml','买了，一桶可以用几个月 ','2020-09-03',0.23,176),('聚划算百亿补贴：Rejoice飘柔清爽去屑/洁顺水润洗发水1000ml','感谢，己撸，其实这个洗发水真的不错。 ','2020-09-03',0.45,177),('聚划算百亿补贴：Rejoice飘柔清爽去屑/洁顺水润洗发水1000ml','这么想你就错了  25的无敌券你要当钱看牙，所以实际上你是25+7=32不到买了2瓶 ','2020-09-03',0.09,179),('聚划算百亿补贴：Rejoice飘柔清爽去屑/洁顺水润洗发水1000ml','快到中年了，已经开始微微秃发了，便宜的真不敢用了 ','2020-09-03',0.81,181),('聚划算百亿补贴：Rejoice飘柔清爽去屑/洁顺水润洗发水1000ml','都说了好几次了，要送淘宝首页的百亿补贴入口进去… ','2020-09-03',0.01,185),('聚划算百亿补贴：Rejoice飘柔清爽去屑/洁顺水润洗发水1000ml','不是直营店不敢买 ','2020-09-03',0.05,186),('聚划算百亿补贴：Rejoice飘柔清爽去屑/洁顺水润洗发水1000ml','心态最重要 ','2020-09-03',0.93,188),('聚划算百亿补贴：Rejoice飘柔清爽去屑/洁顺水润洗发水1000ml','苏宁开的联合会员送的无敌券，7元不到撸了2瓶 ','2020-09-03',0.72,189),('SEEYOUNG滋源小滋礼盒60ml*6支+凑单品','你果然不识字 谁告诉你退洗手液了 人家只是说两件商品其中爆料那件合多少钱 你居然理解要退另外一件 服气 ','2020-09-04',0.01,208),('SEEYOUNG滋源小滋礼盒60ml*6支+凑单品','运费怎么破？ ','2020-09-04',0.07,209),('SEEYOUNG滋源小滋礼盒60ml*6支+凑单品','健身房配有浴室，健身完一身汗，冲完澡再回家有啥不妥？ ','2020-09-04',0.34,210),('SEEYOUNG滋源小滋礼盒60ml*6支+凑单品','哪里领的白条？已经两个月没领过白条了 ','2020-09-04',0.12,211),('SEEYOUNG滋源小滋礼盒60ml*6支+凑单品','你不认字的吗 ','2020-09-04',0.3,212),('SEEYOUNG滋源小滋礼盒60ml*6支+凑单品','木有运费券 ','2020-09-04',0.21,213),('SEEYOUNG滋源小滋礼盒60ml*6支+凑单品','游泳健身必备 ','2020-09-04',0.68,214),('SEEYOUNG滋源小滋礼盒60ml*6支+凑单品','洗手液不要钱？ ','2020-09-04',0.05,215),('SEEYOUNG滋源小滋礼盒60ml*6支+凑单品','凑单了佳洁士牙膏 ','2020-09-04',0.1,216),('SEEYOUNG滋源小滋礼盒60ml*6支+凑单品','。。。洗手液不要钱的么 ','2020-09-04',0.03,217),('SEEYOUNG滋源小滋礼盒60ml*6支+凑单品','白条减了2块 ','2020-09-04',0.24,218),('SEEYOUNG滋源小滋礼盒60ml*6支+凑单品','这个单凑的，无可挑剔 ','2020-09-04',0.21,219),('SEEYOUNG滋源小滋礼盒60ml*6支+凑单品','去健身房洗头吗 ','2020-09-04',0.81,220),('SEEYOUNG滋源小滋礼盒60ml*6支+凑单品','明白了，你是说收到后退掉洗手液吧，还是算了吧，容易被黑号 ','2020-09-04',0.01,221),('SEEYOUNG滋源小滋礼盒60ml*6支+凑单品','要运费 不划算 ','2020-09-04',0.34,222),('SEEYOUNG滋源小滋礼盒60ml*6支+凑单品','怎么知道12.9的，咋看都是19.9 ','2020-09-04',0.56,223),('SEEYOUNG滋源小滋礼盒60ml*6支+凑单品','总价19.8？？ ','2020-09-04',0.18,224),('SEEYOUNG滋源小滋礼盒60ml*6支+凑单品','好用~健身房必备好物~ ','2020-09-04',0.84,225);
/*!40000 ALTER TABLE `shampoo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shampoo_raw`
--

DROP TABLE IF EXISTS `shampoo_raw`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `shampoo_raw` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(300) DEFAULT NULL,
  `short` varchar(500) DEFAULT NULL,
  `time` date DEFAULT NULL,
  `sentiment` float DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=244 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shampoo_raw`
--

LOCK TABLES `shampoo_raw` WRITE;
/*!40000 ALTER TABLE `shampoo_raw` DISABLE KEYS */;
INSERT INTO `shampoo_raw` VALUES (1,'飘柔兰花去屑洗发水露1L','飘柔主要两个系列，这是家庭护理系列，十年前就200毫升9块9，另一款精华护理系列才是印象中的飘柔，不过也不贵，相比保洁其他洗发水也是便宜许多 ','2020-09-04',0.972214),(2,'飘柔兰花去屑洗发水露1L','谢谢已入。。。 ','2020-09-04',0.435913),(3,'飘柔兰花去屑洗发水露1L','散了吧、19.9  都散了 ','2020-09-04',0.382171),(4,'飘柔兰花去屑洗发水露1L','功能超级基础，干 ','2020-09-04',0.628291),(5,'飘柔兰花去屑洗发水露1L','补贴后，19.9了可以散啦 ','2020-09-04',0.0425291),(6,'飘柔兰花去屑洗发水露1L','保价去 ','2020-09-04',0.790032),(7,'飘柔兰花去屑洗发水露1L','9.8刚买 ','2020-09-04',0.454828),(8,'飘柔兰花去屑洗发水露1L','没有优惠卷的话打开淘宝首页百亿补贴，里面搜飘柔然后下单立减 ','2020-09-04',0.114896),(9,'飘柔兰花去屑洗发水露1L','一个账号只能买一瓶，下单了 ','2020-09-04',0.138983),(10,'飘柔兰花去屑洗发水露1L','我想那种第一次可以三天不洗的 ','2020-09-04',0.0969121),(11,'飘柔兰花去屑洗发水露1L','没货啊 我这里显示没货 ','2020-09-04',0.0285737),(12,'飘柔兰花去屑洗发水露1L','已买，男的一天一洗，很适合了 ','2020-09-04',0.292673),(13,'飘柔兰花去屑洗发水露1L','19块刚买过，真的，天猫发货 ','2020-09-04',0.269625),(14,'飘柔兰花去屑洗发水露1L','这东西我用多了就得上药用的，很难受，雪花飘飘 ','2020-09-04',0.0833609),(15,'飘柔兰花去屑洗发水露1L','这货最','2020-09-04',0.283314),(16,'飘柔兰花去屑洗发水露1L','一直显示：同一时间下单人数过多，建议您稍后再试 ','2020-09-04',0.00295486),(17,'飘柔兰花去屑洗发水露1L','我最近在用，也感觉到了 ','2020-09-04',0.548309),(18,'飘柔兰花去屑洗发水露1L','昨天14.9买的，陪了一毛钱，心好痛 ','2020-09-04',0.887576),(19,'飘柔兰花去屑洗发水露1L','买一瓶先屯着，上次京东买的29.9   。。。。。 ','2020-09-04',0.237088),(20,'飘柔兰花去屑洗发水露1L','打开淘宝，从百亿补贴进，直接就14.8 ','2020-09-04',0.0678518),(21,'飘柔兰花去屑洗发水露1L','亏了 上次19.9出手了 ','2020-09-04',0.586428),(22,'飘柔兰花去屑洗发水露1L','并没有过期，我刚刚下单，比前几天的14.9还便宜一毛 ','2020-09-03',0.523353),(23,'飘柔兰花去屑洗发水露1L','已入，便宜啊 ','2020-09-03',0.549098),(24,'飘柔兰花去屑洗发水露1L','风清扬差点想用独孤九剑刺人 ','2020-09-03',0.444182),(25,'飘柔兰花去屑洗发水露1L','搞错了，再来 ','2020-09-03',0.208612),(26,'飘柔兰花去屑洗发水露1L','不好用。现在还在发愁怎么消耗 ','2020-09-03',0.856024),(27,'飘柔兰花去屑洗发水露1L','去 他 妹 子 的，专门升级了天猫，扫码进去36.8！曹丹的！ ','2020-09-03',0.151439),(28,'飘柔兰花去屑洗发水露1L','不用新版。。。。 ','2020-09-03',0.594993),(29,'飘柔兰花去屑洗发水露1L','下单时候自动减免品类购物券 ','2020-09-03',0.113901),(30,'飘柔兰花去屑洗发水露1L','理论上来说，这家店应该是天猫自己去拿来和拼夕夕比百亿补贴低价竞争的正品店，货源应该是有保证的，我买过十几次9块钱包邮的农夫山泉和可乐，感觉挺真 ','2020-09-03',0.000217725),(31,'飘柔兰花去屑洗发水露1L','谢谢，已买。。。。。。。。。。。 ','2020-09-03',0.44777),(32,'飘柔兰花去屑洗发水露1L','刚19.9，，，靠 ','2020-09-03',0.472292),(33,'飘柔兰花去屑洗发水露1L','曾经很高端的飘柔，如今也成了地摊货了 ','2020-09-03',0.753606),(34,'飘柔兰花去屑洗发水露1L','号真黑，这些东西完全买不了 ','2020-09-03',0.221251),(35,'飘柔兰花去屑洗发水露1L','用这款飘柔是油的快，真的痒 ','2020-09-03',0.943808),(36,'飘柔兰花去屑洗发水露1L','风清扬差点想用独孤九剑刺人 ','2020-09-03',0.444182),(37,'飘柔兰花去屑洗发水露1L','淘宝首页百亿补贴进去搜飘柔，自动减 ','2020-09-03',0.0700288),(38,'飘柔兰花去屑洗发水露1L','券呢？在哪里？ ','2020-09-03',0.344828),(39,'飘柔兰花去屑洗发水露1L','打算等12块再考虑入手 ','2020-09-03',0.494699),(40,'飘柔兰花去屑洗发水露1L','放心吧，天猫正品 ','2020-09-03',0.933552),(41,'飘柔兰花去屑洗发水露1L','不是啊，之前一直都是11快多啊我买过两次。。。这个14块还是不值 ','2020-09-03',0.0466863),(42,'飘柔兰花去屑洗发水露1L','已经没了，散了散了。 ','2020-09-03',0.253056),(43,'飘柔兰花去屑洗发水露1L','无功无过，挺好的 ','2020-09-03',0.730461),(44,'飘柔兰花去屑洗发水露1L','没看到券，直接下单是36.8 ','2020-09-03',0.09165),(45,'飘柔兰花去屑洗发水露1L','券在哪儿？ ','2020-09-03',0.344828),(46,'飘柔兰花去屑洗发水露1L','飘柔主要两个系列，这是家庭护理系列，十年前就200毫升9块9，另一款精华护理系列才是印象中的飘柔，不过也不贵，相比保洁其他洗发水也是便宜许多 ','2020-09-04',0.972214),(47,'飘柔兰花去屑洗发水露1L','谢谢已入。。。 ','2020-09-04',0.435913),(48,'飘柔兰花去屑洗发水露1L','散了吧、19.9  都散了 ','2020-09-04',0.382171),(49,'飘柔兰花去屑洗发水露1L','功能超级基础，干 ','2020-09-04',0.628291),(50,'飘柔兰花去屑洗发水露1L','补贴后，19.9了可以散啦 ','2020-09-04',0.0425291),(51,'飘柔兰花去屑洗发水露1L','保价去 ','2020-09-04',0.790032),(52,'飘柔兰花去屑洗发水露1L','9.8刚买 ','2020-09-04',0.454828),(53,'飘柔兰花去屑洗发水露1L','没有优惠卷的话打开淘宝首页百亿补贴，里面搜飘柔然后下单立减 ','2020-09-04',0.114896),(54,'飘柔兰花去屑洗发水露1L','一个账号只能买一瓶，下单了 ','2020-09-04',0.138983),(55,'飘柔兰花去屑洗发水露1L','我想那种第一次可以三天不洗的 ','2020-09-04',0.0969121),(56,'飘柔兰花去屑洗发水露1L','没货啊 我这里显示没货 ','2020-09-04',0.0285737),(57,'飘柔兰花去屑洗发水露1L','已买，男的一天一洗，很适合了 ','2020-09-04',0.292673),(58,'飘柔兰花去屑洗发水露1L','19块刚买过，真的，天猫发货 ','2020-09-04',0.269625),(59,'飘柔兰花去屑洗发水露1L','这东西我用多了就得上药用的，很难受，雪花飘飘 ','2020-09-04',0.0833609),(60,'古龙洗发水男士专用去屑止痒控油香味持久留香洗头膏露沐浴露套装','注意我的订单截图，左下角 品类购物券 上方返回有个紫红小圆圈里面的字，下载那个App ','2020-09-04',0.000676961),(61,'古龙洗发水男士专用去屑止痒控油香味持久留香洗头膏露沐浴露套装','就下载紫红圓圈里的字的App ','2020-09-04',0.0559173),(62,'古龙洗发水男士专用去屑止痒控油香味持久留香洗头膏露沐浴露套装','只有你有 我们都没有 ','2020-09-04',0.551211),(63,'古龙洗发水男士专用去屑止痒控油香味持久留香洗头膏露沐浴露套装','就是看我的订单截图呀，品类购物券上方返回有个紫红圆圈里的字 ','2020-09-04',0.00301919),(64,'古龙洗发水男士专用去屑止痒控油香味持久留香洗头膏露沐浴露套装','你自己有品类券不代表所有人都有，估计也只有你一个人有 ','2020-09-04',0.198682),(65,'古龙洗发水男士专用去屑止痒控油香味持久留香洗头膏露沐浴露套装','我的订单截图，左下角 品类购物券 上方返回有个紫红小圆圈里面的字 ','2020-09-04',0.00135324),(66,'古龙洗发水男士专用去屑止痒控油香味持久留香洗头膏露沐浴露套装','没找到^_^ ','2020-09-04',0.76422),(67,'古龙洗发水男士专用去屑止痒控油香味持久留香洗头膏露沐浴露套装','仔细注意订单页面，左下角品类券上方，返回那里紫红小圆圈的字 ','2020-09-04',0.000351735),(68,'古龙洗发水男士专用去屑止痒控油香味持久留香洗头膏露沐浴露套装','淘礼金怎么领都不告诉大家你叫人家去哪领淘礼金？ ','2020-09-04',0.207664),(69,'古龙洗发水男士专用去屑止痒控油香味持久留香洗头膏露沐浴露套装','淘礼金怎么弄？ ','2020-09-04',0.263287),(70,'古龙洗发水男士专用去屑止痒控油香味持久留香洗头膏露沐浴露套装','各位值友们，记得领取礼金红包 ','2020-09-04',0.486498),(71,'古龙洗发水男士专用去屑止痒控油香味持久留香洗头膏露沐浴露套装','你自己有品类券不代表所有人都有，估计也只有你一个人有 ','2020-09-04',0.198682),(72,'古龙洗发水男士专用去屑止痒控油香味持久留香洗头膏露沐浴露套装','淘礼金怎么领都不告诉大家你叫人家去哪领淘礼金？ ','2020-09-04',0.207664),(73,'古龙洗发水男士专用去屑止痒控油香味持久留香洗头膏露沐浴露套装','注意我的订单截图，左下角 品类购物券 上方返回有个紫红小圆圈里面的字，下载那个App ','2020-09-04',0.000676961),(74,'古龙洗发水男士专用去屑止痒控油香味持久留香洗头膏露沐浴露套装','就下载紫红圓圈里的字的App ','2020-09-04',0.0559173),(75,'古龙洗发水男士专用去屑止痒控油香味持久留香洗头膏露沐浴露套装','只有你有 我们都没有 ','2020-09-04',0.551211),(76,'古龙洗发水男士专用去屑止痒控油香味持久留香洗头膏露沐浴露套装','就是看我的订单截图呀，品类购物券上方返回有个紫红圆圈里的字 ','2020-09-04',0.00301919),(77,'古龙洗发水男士专用去屑止痒控油香味持久留香洗头膏露沐浴露套装','我的订单截图，左下角 品类购物券 上方返回有个紫红小圆圈里面的字 ','2020-09-04',0.00135324),(78,'古龙洗发水男士专用去屑止痒控油香味持久留香洗头膏露沐浴露套装','没找到^_^ ','2020-09-04',0.76422),(79,'古龙洗发水男士专用去屑止痒控油香味持久留香洗头膏露沐浴露套装','仔细注意订单页面，左下角品类券上方，返回那里紫红小圆圈的字 ','2020-09-04',0.000351735),(80,'古龙洗发水男士专用去屑止痒控油香味持久留香洗头膏露沐浴露套装','淘礼金怎么弄？ ','2020-09-04',0.263287),(81,'古龙洗发水男士专用去屑止痒控油香味持久留香洗头膏露沐浴露套装','各位值友们，记得领取礼金红包 ','2020-09-04',0.486498),(82,'BAWANG霸王何首乌控油防脱发洗发液1L+赠生姜强根护发素80ml*2件','该脱的什么洗发水都没用，不会脱的调整作息和饮食就能好 ','2020-09-03',0.178268),(83,'BAWANG霸王何首乌控油防脱发洗发液1L+赠生姜强根护发素80ml*2件','duang~~~! ','2020-09-03',0.5),(84,'BAWANG霸王何首乌控油防脱发洗发液1L+赠生姜强根护发素80ml*2件','20多岁就关注防脱洗发水了 ','2020-09-03',0.287754),(85,'BAWANG霸王何首乌控油防脱发洗发液1L+赠生姜强根护发素80ml*2件','20多岁就关注防脱洗发水了 ','2020-09-03',0.287754),(86,'BAWANG霸王何首乌控油防脱发洗发液1L+赠生姜强根护发素80ml*2件','该脱的什么洗发水都没用，不会脱的调整作息和饮食就能好 ','2020-09-03',0.178268),(87,'BAWANG霸王何首乌控油防脱发洗发液1L+赠生姜强根护发素80ml*2件','duang~~~! ','2020-09-03',0.5),(88,'Rejoice飘柔顺滑洗护套装750ml*2瓶','除了品牌自营店，别的都一样的，对于我来说，实惠就行。用飘柔六七年了，都一样 ','2020-09-04',0.99051),(89,'Rejoice飘柔顺滑洗护套装750ml*2瓶','又来拼购店， ','2020-09-04',0.355339),(90,'Rejoice飘柔顺滑洗护套装750ml*2瓶','开了有一段时间了，产品质量没问题就行 ','2020-09-04',0.388199),(91,'Rejoice飘柔顺滑洗护套装750ml*2瓶','新开的第三方拼购店 ','2020-09-04',0.106648),(92,'Rejoice飘柔顺滑洗护套装750ml*2瓶','除了品牌自营店，别的都一样的，对于我来说，实惠就行。用飘柔六七年了，都一样 ','2020-09-04',0.99051),(93,'Rejoice飘柔顺滑洗护套装750ml*2瓶','又来拼购店， ','2020-09-04',0.355339),(94,'Rejoice飘柔顺滑洗护套装750ml*2瓶','开了有一段时间了，产品质量没问题就行 ','2020-09-04',0.388199),(95,'Rejoice飘柔顺滑洗护套装750ml*2瓶','新开的第三方拼购店 ','2020-09-04',0.106648),(96,'卡诗（KERASTASE）头皮系列根源特护洗发水1000ml修护纤细脆弱发根无硅油','太贵了，之前亚马逊299 ','2020-09-04',0.574631),(97,'卡诗（KERASTASE）头皮系列根源特护洗发水1000ml修护纤细脆弱发根无硅油','这个牌子修护还是可以的 ','2020-09-04',0.453864),(98,'卡诗（KERASTASE）头皮系列根源特护洗发水1000ml修护纤细脆弱发根无硅油','169的优惠券在哪里 ','2020-09-04',0.602295),(99,'卡诗（KERASTASE）头皮系列根源特护洗发水1000ml修护纤细脆弱发根无硅油','plus可以199-40 ','2020-09-03',0.5),(100,'卡诗（KERASTASE）头皮系列根源特护洗发水1000ml修护纤细脆弱发根无硅油','券在哪里领？ ','2020-09-03',0.307588),(101,'卡诗（KERASTASE）头皮系列根源特护洗发水1000ml修护纤细脆弱发根无硅油','好用 确实不错 ','2020-09-03',0.947661),(102,'卡诗（KERASTASE）头皮系列根源特护洗发水1000ml修护纤细脆弱发根无硅油','好用！！！！！！ ','2020-09-03',0.0597513),(103,'卡诗（KERASTASE）头皮系列根源特护洗发水1000ml修护纤细脆弱发根无硅油','对于头发出油多、发质良好的人来说，本来就不需要硅油进行滋润保护，无硅油洗发水显然会更加得心应手 ','2020-09-03',0.340408),(104,'卡诗（KERASTASE）头皮系列根源特护洗发水1000ml修护纤细脆弱发根无硅油','太贵了，之前亚马逊299 ','2020-09-04',0.574631),(105,'卡诗（KERASTASE）头皮系列根源特护洗发水1000ml修护纤细脆弱发根无硅油','这个牌子修护还是可以的 ','2020-09-04',0.453864),(106,'卡诗（KERASTASE）头皮系列根源特护洗发水1000ml修护纤细脆弱发根无硅油','169的优惠券在哪里 ','2020-09-04',0.602295),(107,'卡诗（KERASTASE）头皮系列根源特护洗发水1000ml修护纤细脆弱发根无硅油','plus可以199-40 ','2020-09-03',0.5),(108,'卡诗（KERASTASE）头皮系列根源特护洗发水1000ml修护纤细脆弱发根无硅油','券在哪里领？ ','2020-09-03',0.307588),(109,'卡诗（KERASTASE）头皮系列根源特护洗发水1000ml修护纤细脆弱发根无硅油','好用 确实不错 ','2020-09-03',0.947661),(110,'卡诗（KERASTASE）头皮系列根源特护洗发水1000ml修护纤细脆弱发根无硅油','好用！！！！！！ ','2020-09-03',0.0597513),(111,'卡诗（KERASTASE）头皮系列根源特护洗发水1000ml修护纤细脆弱发根无硅油','对于头发出油多、发质良好的人来说，本来就不需要硅油进行滋润保护，无硅油洗发水显然会更加得心应手 ','2020-09-03',0.340408),(112,'Head&Shoulders海飞丝丝源复活头皮保湿洗发露530ml*2件','要运费？？？  我叼。。。 ','2020-09-04',0.00905043),(113,'Head&Shoulders海飞丝丝源复活头皮保湿洗发露530ml*2件','还别说，这系列确实不错！已使用一年！ ','2020-09-04',0.951914),(114,'Head&Shoulders海飞丝丝源复活头皮保湿洗发露530ml*2件','求券链接。。 ','2020-09-04',0.221409),(115,'Head&Shoulders海飞丝丝源复活头皮保湿洗发露530ml*2件','看了看历史订单，2019年9月份不到10块钱买的 ','2020-09-04',0.100304),(116,'Head&Shoulders海飞丝丝源复活头皮保湿洗发露530ml*2件','找不到券啊 ','2020-09-04',0.107458),(117,'Head&Shoulders海飞丝丝源复活头皮保湿洗发露530ml*2件','这个系列应该比标准白瓶好，标准白又比绿瓶好。绿瓶好像是电商特供，感觉很一般。 ','2020-09-04',0.503497),(118,'Head&Shoulders海飞丝丝源复活头皮保湿洗发露530ml*2件','绿的去屑，蓝的保湿 ','2020-09-04',0.856068),(119,'Head&Shoulders海飞丝丝源复活头皮保湿洗发露530ml*2件','我喜欢用这个 ','2020-09-04',0.699459),(120,'Head&Shoulders海飞丝丝源复活头皮保湿洗发露530ml*2件','说一下优惠券哪里领啊 ','2020-09-04',0.214382),(121,'Head&Shoulders海飞丝丝源复活头皮保湿洗发露530ml*2件','那是护发素吧 ','2020-09-04',0.358731),(122,'Head&Shoulders海飞丝丝源复活头皮保湿洗发露530ml*2件','绿的跟着有啥区别？ ','2020-09-04',0.800123),(123,'Head&Shoulders海飞丝丝源复活头皮保湿洗发露530ml*2件','不能叠加优惠？ ','2020-09-04',0.359727),(124,'Head&Shoulders海飞丝丝源复活头皮保湿洗发露530ml*2件','APP首页-优惠券-京东页面里就找得到京东超市周年庆优惠券了 ','2020-09-04',0.699142),(125,'Head&Shoulders海飞丝丝源复活头皮保湿洗发露530ml*2件','199-40券在哪里？ ','2020-09-04',0.321501),(126,'Head&Shoulders海飞丝丝源复活头皮保湿洗发露530ml*2件','找不到券啊 ','2020-09-04',0.107458),(127,'Head&Shoulders海飞丝丝源复活头皮保湿洗发露530ml*2件','199-40券在哪里？ ','2020-09-04',0.321501),(128,'Head&Shoulders海飞丝丝源复活头皮保湿洗发露530ml*2件','看了看历史订单，2019年9月份不到10块钱买的 ','2020-09-04',0.100304),(129,'Head&Shoulders海飞丝丝源复活头皮保湿洗发露530ml*2件','APP首页-优惠券-京东页面里就找得到京东超市周年庆优惠券了 ','2020-09-04',0.699142),(130,'Head&Shoulders海飞丝丝源复活头皮保湿洗发露530ml*2件','要运费？？？  我叼。。。 ','2020-09-04',0.00905043),(131,'Head&Shoulders海飞丝丝源复活头皮保湿洗发露530ml*2件','还别说，这系列确实不错！已使用一年！ ','2020-09-04',0.951914),(132,'Head&Shoulders海飞丝丝源复活头皮保湿洗发露530ml*2件','求券链接。。 ','2020-09-04',0.221409),(133,'Head&Shoulders海飞丝丝源复活头皮保湿洗发露530ml*2件','这个系列应该比标准白瓶好，标准白又比绿瓶好。绿瓶好像是电商特供，感觉很一般。 ','2020-09-04',0.503497),(134,'Head&Shoulders海飞丝丝源复活头皮保湿洗发露530ml*2件','绿的去屑，蓝的保湿 ','2020-09-04',0.856068),(135,'Head&Shoulders海飞丝丝源复活头皮保湿洗发露530ml*2件','我喜欢用这个 ','2020-09-04',0.699459),(136,'Head&Shoulders海飞丝丝源复活头皮保湿洗发露530ml*2件','说一下优惠券哪里领啊 ','2020-09-04',0.214382),(137,'Head&Shoulders海飞丝丝源复活头皮保湿洗发露530ml*2件','那是护发素吧 ','2020-09-04',0.358731),(138,'Head&Shoulders海飞丝丝源复活头皮保湿洗发露530ml*2件','绿的跟着有啥区别？ ','2020-09-04',0.800123),(139,'Head&Shoulders海飞丝丝源复活头皮保湿洗发露530ml*2件','不能叠加优惠？ ','2020-09-04',0.359727),(140,'KASTIZA凯仕帝海飞丝3D去屑止痒洗发露750ml','上个月买了的，是正品，价格不错，看评价可解毒 ','2020-09-03',0.972992),(141,'KASTIZA凯仕帝海飞丝3D去屑止痒洗发露750ml','8月1号开张的第三方店 ','2020-09-03',0.00653449),(142,'KASTIZA凯仕帝海飞丝3D去屑止痒洗发露750ml','上个月买了的，是正品，价格不错，看评价可解毒 ','2020-09-03',0.972992),(143,'KASTIZA凯仕帝海飞丝3D去屑止痒洗发露750ml','8月1号开张的第三方店 ','2020-09-03',0.00653449),(144,'移动专享：CLEAR清扬清爽控油型去屑洗沐套装（洗发水500g+幽莲魅肤沐浴乳350g+清扬100g*2）','原价谁会买，这价都贵了 ','2020-09-03',0.261117),(145,'移动专享：CLEAR清扬清爽控油型去屑洗沐套装（洗发水500g+幽莲魅肤沐浴乳350g+清扬100g*2）','第三方拼购店 ','2020-09-03',0.117076),(146,'移动专享：CLEAR清扬清爽控油型去屑洗沐套装（洗发水500g+幽莲魅肤沐浴乳350g+清扬100g*2）','第三方拼购店 ','2020-09-03',0.117076),(147,'移动专享：CLEAR清扬清爽控油型去屑洗沐套装（洗发水500g+幽莲魅肤沐浴乳350g+清扬100g*2）','原价谁会买，这价都贵了 ','2020-09-03',0.261117),(148,'聚划算百亿补贴：Rejoice飘柔清爽去屑/洁顺水润洗发水1000ml','收到了，天猫超市发的货，应该靠谱吧 ','2020-09-04',0.122365),(149,'聚划算百亿补贴：Rejoice飘柔清爽去屑/洁顺水润洗发水1000ml','天猫超市发的 ','2020-09-04',0.473767),(150,'聚划算百亿补贴：Rejoice飘柔清爽去屑/洁顺水润洗发水1000ml','我不是杠，你认为花钱买了无敌券，会员是送的，券等于钱。他认为花钱买了会员，券是送的。观点不同而已。 ','2020-09-04',0.00172919),(151,'聚划算百亿补贴：Rejoice飘柔清爽去屑/洁顺水润洗发水1000ml','就是美杏仁那款 ','2020-09-04',0.91175),(152,'聚划算百亿补贴：Rejoice飘柔清爽去屑/洁顺水润洗发水1000ml','便宜是真啊 ','2020-09-04',0.667188),(153,'聚划算百亿补贴：Rejoice飘柔清爽去屑/洁顺水润洗发水1000ml','帝都不销售，差评 ','2020-09-04',0.0504012),(154,'聚划算百亿补贴：Rejoice飘柔清爽去屑/洁顺水润洗发水1000ml','如何撸的？我只撸了一瓶…… ','2020-09-04',0.318264),(155,'聚划算百亿补贴：Rejoice飘柔清爽去屑/洁顺水润洗发水1000ml','劣制跟价格没直接关系……这个网上有科普，一句话来说就是各种成分比例不同 ','2020-09-04',0.982849),(156,'聚划算百亿补贴：Rejoice飘柔清爽去屑/洁顺水润洗发水1000ml','以前觉得飘柔洗发水很高档，怎么现在便宜成这样了 ','2020-09-04',0.68527),(157,'聚划算百亿补贴：Rejoice飘柔清爽去屑/洁顺水润洗发水1000ml','秀发去无踪 头屑更出众  ','2020-09-04',0.899026),(158,'聚划算百亿补贴：Rejoice飘柔清爽去屑/洁顺水润洗发水1000ml','莫慌，十个光头九富 ','2020-09-04',0.909876),(159,'聚划算百亿补贴：Rejoice飘柔清爽去屑/洁顺水润洗发水1000ml','不要慌！其实 是开始变强了！ ','2020-09-04',0.657159),(160,'聚划算百亿补贴：Rejoice飘柔清爽去屑/洁顺水润洗发水1000ml','已经撸了3瓶了，不要了 ','2020-09-04',0.181915),(161,'聚划算百亿补贴：Rejoice飘柔清爽去屑/洁顺水润洗发水1000ml','感觉一般般吧 ','2020-09-04',0.525537),(162,'聚划算百亿补贴：Rejoice飘柔清爽去屑/洁顺水润洗发水1000ml','没什么变化，该秃还是秃。','2020-09-04',0.823079),(163,'聚划算百亿补贴：Rejoice飘柔清爽去屑/洁顺水润洗发水1000ml','听他','2020-09-04',0.590071),(164,'聚划算百亿补贴：Rejoice飘柔清爽去屑/洁顺水润洗发水1000ml','这种的怕不是正品吧？ ','2020-09-04',0.652294),(165,'聚划算百亿补贴：Rejoice飘柔清爽去屑/洁顺水润洗发水1000ml','感觉前几天的六神是假的，冰片完全无感 ','2020-09-04',0.453316),(166,'聚划算百亿补贴：Rejoice飘柔清爽去屑/洁顺水润洗发水1000ml','读书的时候用这款飘柔头皮屑就贼多 ','2020-09-04',0.650592),(167,'聚划算百亿补贴：Rejoice飘柔清爽去屑/洁顺水润洗发水1000ml','第三方的，请谨慎 ','2020-09-04',0.0638186),(168,'聚划算百亿补贴：Rejoice飘柔清爽去屑/洁顺水润洗发水1000ml','十几还谈质量','2020-09-04',0.505431),(169,'聚划算百亿补贴：Rejoice飘柔清爽去屑/洁顺水润洗发水1000ml','大神，可以给个链接吗？ ','2020-09-03',0.369334),(170,'聚划算百亿补贴：Rejoice飘柔清爽去屑/洁顺水润洗发水1000ml','9.9买的 ','2020-09-03',0.736601),(171,'聚划算百亿补贴：Rejoice飘柔清爽去屑/洁顺水润洗发水1000ml','链接有吗。 ','2020-09-03',0.394115),(172,'聚划算百亿补贴：Rejoice飘柔清爽去屑/洁顺水润洗发水1000ml','头发秃确实是身体原因，但再用劣质产品的话就加快秃发问题了 ','2020-09-03',0.468792),(173,'聚划算百亿补贴：Rejoice飘柔清爽去屑/洁顺水润洗发水1000ml','其实跟你用什么洗发水没关系 ','2020-09-03',0.237384),(174,'聚划算百亿补贴：Rejoice飘柔清爽去屑/洁顺水润洗发水1000ml','这和心态有毛关系  无敌券券就是钱   ','2020-09-03',0.900866),(175,'聚划算百亿补贴：Rejoice飘柔清爽去屑/洁顺水润洗发水1000ml','上车一瓶试试 ','2020-09-03',0.623365),(176,'聚划算百亿补贴：Rejoice飘柔清爽去屑/洁顺水润洗发水1000ml','买了，一桶可以用几个月 ','2020-09-03',0.231109),(177,'聚划算百亿补贴：Rejoice飘柔清爽去屑/洁顺水润洗发水1000ml','感谢，己撸，其实这个洗发水真的不错。 ','2020-09-03',0.452007),(178,'聚划算百亿补贴：Rejoice飘柔清爽去屑/洁顺水润洗发水1000ml','其实跟你用什么洗发水没关系 ','2020-09-03',0.237384),(179,'聚划算百亿补贴：Rejoice飘柔清爽去屑/洁顺水润洗发水1000ml','这么想你就错了  25的无敌券你要当钱看牙，所以实际上你是25+7=32不到买了2瓶 ','2020-09-03',0.0933262),(180,'聚划算百亿补贴：Rejoice飘柔清爽去屑/洁顺水润洗发水1000ml','没什么变化，该秃还是秃。','2020-09-04',0.823079),(181,'聚划算百亿补贴：Rejoice飘柔清爽去屑/洁顺水润洗发水1000ml','快到中年了，已经开始微微秃发了，便宜的真不敢用了 ','2020-09-03',0.808717),(182,'聚划算百亿补贴：Rejoice飘柔清爽去屑/洁顺水润洗发水1000ml','不要慌！其实 是开始变强了！ ','2020-09-04',0.657159),(183,'聚划算百亿补贴：Rejoice飘柔清爽去屑/洁顺水润洗发水1000ml','劣制跟价格没直接关系……这个网上有科普，一句话来说就是各种成分比例不同 ','2020-09-04',0.982849),(184,'聚划算百亿补贴：Rejoice飘柔清爽去屑/洁顺水润洗发水1000ml','莫慌，十个光头九富 ','2020-09-04',0.909876),(185,'聚划算百亿补贴：Rejoice飘柔清爽去屑/洁顺水润洗发水1000ml','都说了好几次了，要送淘宝首页的百亿补贴入口进去… ','2020-09-03',0.0122935),(186,'聚划算百亿补贴：Rejoice飘柔清爽去屑/洁顺水润洗发水1000ml','不是直营店不敢买 ','2020-09-03',0.0531217),(187,'聚划算百亿补贴：Rejoice飘柔清爽去屑/洁顺水润洗发水1000ml','第三方的，请谨慎 ','2020-09-04',0.0638186),(188,'聚划算百亿补贴：Rejoice飘柔清爽去屑/洁顺水润洗发水1000ml','心态最重要 ','2020-09-03',0.928802),(189,'聚划算百亿补贴：Rejoice飘柔清爽去屑/洁顺水润洗发水1000ml','苏宁开的联合会员送的无敌券，7元不到撸了2瓶 ','2020-09-03',0.717986),(190,'聚划算百亿补贴：Rejoice飘柔清爽去屑/洁顺水润洗发水1000ml','收到了，天猫超市发的货，应该靠谱吧 ','2020-09-04',0.122365),(191,'聚划算百亿补贴：Rejoice飘柔清爽去屑/洁顺水润洗发水1000ml','天猫超市发的 ','2020-09-04',0.473767),(192,'聚划算百亿补贴：Rejoice飘柔清爽去屑/洁顺水润洗发水1000ml','我不是杠，你认为花钱买了无敌券，会员是送的，券等于钱。他认为花钱买了会员，券是送的。观点不同而已。 ','2020-09-04',0.00172919),(193,'聚划算百亿补贴：Rejoice飘柔清爽去屑/洁顺水润洗发水1000ml','就是美杏仁那款 ','2020-09-04',0.91175),(194,'聚划算百亿补贴：Rejoice飘柔清爽去屑/洁顺水润洗发水1000ml','便宜是真啊 ','2020-09-04',0.667188),(195,'聚划算百亿补贴：Rejoice飘柔清爽去屑/洁顺水润洗发水1000ml','帝都不销售，差评 ','2020-09-04',0.0504012),(196,'聚划算百亿补贴：Rejoice飘柔清爽去屑/洁顺水润洗发水1000ml','如何撸的？我只撸了一瓶…… ','2020-09-04',0.318264),(197,'聚划算百亿补贴：Rejoice飘柔清爽去屑/洁顺水润洗发水1000ml','以前觉得飘柔洗发水很高档，怎么现在便宜成这样了 ','2020-09-04',0.68527),(198,'聚划算百亿补贴：Rejoice飘柔清爽去屑/洁顺水润洗发水1000ml','秀发去无踪 头屑更出众  ','2020-09-04',0.899026),(199,'聚划算百亿补贴：Rejoice飘柔清爽去屑/洁顺水润洗发水1000ml','已经撸了3瓶了，不要了 ','2020-09-04',0.181915),(200,'聚划算百亿补贴：Rejoice飘柔清爽去屑/洁顺水润洗发水1000ml','感觉一般般吧 ','2020-09-04',0.525537),(201,'聚划算百亿补贴：Rejoice飘柔清爽去屑/洁顺水润洗发水1000ml','听他','2020-09-04',0.590071),(202,'聚划算百亿补贴：Rejoice飘柔清爽去屑/洁顺水润洗发水1000ml','这种的怕不是正品吧？ ','2020-09-04',0.652294),(203,'聚划算百亿补贴：Rejoice飘柔清爽去屑/洁顺水润洗发水1000ml','感觉前几天的六神是假的，冰片完全无感 ','2020-09-04',0.453316),(204,'聚划算百亿补贴：Rejoice飘柔清爽去屑/洁顺水润洗发水1000ml','读书的时候用这款飘柔头皮屑就贼多 ','2020-09-04',0.650592),(205,'聚划算百亿补贴：Rejoice飘柔清爽去屑/洁顺水润洗发水1000ml','十几还谈质量','2020-09-04',0.505431),(206,'聚划算百亿补贴：Rejoice飘柔清爽去屑/洁顺水润洗发水1000ml','大神，可以给个链接吗？ ','2020-09-03',0.369334),(207,'聚划算百亿补贴：Rejoice飘柔清爽去屑/洁顺水润洗发水1000ml','9.9买的 ','2020-09-03',0.736601),(208,'SEEYOUNG滋源小滋礼盒60ml*6支+凑单品','你果然不识字 谁告诉你退洗手液了 人家只是说两件商品其中爆料那件合多少钱 你居然理解要退另外一件 服气 ','2020-09-04',0.0109208),(209,'SEEYOUNG滋源小滋礼盒60ml*6支+凑单品','运费怎么破？ ','2020-09-04',0.0677888),(210,'SEEYOUNG滋源小滋礼盒60ml*6支+凑单品','健身房配有浴室，健身完一身汗，冲完澡再回家有啥不妥？ ','2020-09-04',0.342815),(211,'SEEYOUNG滋源小滋礼盒60ml*6支+凑单品','哪里领的白条？已经两个月没领过白条了 ','2020-09-04',0.1196),(212,'SEEYOUNG滋源小滋礼盒60ml*6支+凑单品','你不认字的吗 ','2020-09-04',0.304614),(213,'SEEYOUNG滋源小滋礼盒60ml*6支+凑单品','木有运费券 ','2020-09-04',0.207574),(214,'SEEYOUNG滋源小滋礼盒60ml*6支+凑单品','游泳健身必备 ','2020-09-04',0.684909),(215,'SEEYOUNG滋源小滋礼盒60ml*6支+凑单品','洗手液不要钱？ ','2020-09-04',0.049608),(216,'SEEYOUNG滋源小滋礼盒60ml*6支+凑单品','凑单了佳洁士牙膏 ','2020-09-04',0.100518),(217,'SEEYOUNG滋源小滋礼盒60ml*6支+凑单品','。。。洗手液不要钱的么 ','2020-09-04',0.0258097),(218,'SEEYOUNG滋源小滋礼盒60ml*6支+凑单品','白条减了2块 ','2020-09-04',0.243008),(219,'SEEYOUNG滋源小滋礼盒60ml*6支+凑单品','这个单凑的，无可挑剔 ','2020-09-04',0.206356),(220,'SEEYOUNG滋源小滋礼盒60ml*6支+凑单品','去健身房洗头吗 ','2020-09-04',0.805816),(221,'SEEYOUNG滋源小滋礼盒60ml*6支+凑单品','明白了，你是说收到后退掉洗手液吧，还是算了吧，容易被黑号 ','2020-09-04',0.00837349),(222,'SEEYOUNG滋源小滋礼盒60ml*6支+凑单品','要运费 不划算 ','2020-09-04',0.336688),(223,'SEEYOUNG滋源小滋礼盒60ml*6支+凑单品','怎么知道12.9的，咋看都是19.9 ','2020-09-04',0.560751),(224,'SEEYOUNG滋源小滋礼盒60ml*6支+凑单品','总价19.8？？ ','2020-09-04',0.183723),(225,'SEEYOUNG滋源小滋礼盒60ml*6支+凑单品','好用~健身房必备好物~ ','2020-09-04',0.835153),(226,'SEEYOUNG滋源小滋礼盒60ml*6支+凑单品','好用~健身房必备好物~ ','2020-09-04',0.835153),(227,'SEEYOUNG滋源小滋礼盒60ml*6支+凑单品','这个单凑的，无可挑剔 ','2020-09-04',0.206356),(228,'SEEYOUNG滋源小滋礼盒60ml*6支+凑单品','健身房配有浴室，健身完一身汗，冲完澡再回家有啥不妥？ ','2020-09-04',0.342815),(229,'SEEYOUNG滋源小滋礼盒60ml*6支+凑单品','怎么知道12.9的，咋看都是19.9 ','2020-09-04',0.560751),(230,'SEEYOUNG滋源小滋礼盒60ml*6支+凑单品','。。。洗手液不要钱的么 ','2020-09-04',0.0258097),(231,'SEEYOUNG滋源小滋礼盒60ml*6支+凑单品','去健身房洗头吗 ','2020-09-04',0.805816),(232,'SEEYOUNG滋源小滋礼盒60ml*6支+凑单品','你果然不识字 谁告诉你退洗手液了 人家只是说两件商品其中爆料那件合多少钱 你居然理解要退另外一件 服气 ','2020-09-04',0.0109208),(233,'SEEYOUNG滋源小滋礼盒60ml*6支+凑单品','运费怎么破？ ','2020-09-04',0.0677888),(234,'SEEYOUNG滋源小滋礼盒60ml*6支+凑单品','哪里领的白条？已经两个月没领过白条了 ','2020-09-04',0.1196),(235,'SEEYOUNG滋源小滋礼盒60ml*6支+凑单品','你不认字的吗 ','2020-09-04',0.304614),(236,'SEEYOUNG滋源小滋礼盒60ml*6支+凑单品','木有运费券 ','2020-09-04',0.207574),(237,'SEEYOUNG滋源小滋礼盒60ml*6支+凑单品','游泳健身必备 ','2020-09-04',0.684909),(238,'SEEYOUNG滋源小滋礼盒60ml*6支+凑单品','洗手液不要钱？ ','2020-09-04',0.049608),(239,'SEEYOUNG滋源小滋礼盒60ml*6支+凑单品','凑单了佳洁士牙膏 ','2020-09-04',0.100518),(240,'SEEYOUNG滋源小滋礼盒60ml*6支+凑单品','白条减了2块 ','2020-09-04',0.243008),(241,'SEEYOUNG滋源小滋礼盒60ml*6支+凑单品','明白了，你是说收到后退掉洗手液吧，还是算了吧，容易被黑号 ','2020-09-04',0.00837349),(242,'SEEYOUNG滋源小滋礼盒60ml*6支+凑单品','要运费 不划算 ','2020-09-04',0.336688),(243,'SEEYOUNG滋源小滋礼盒60ml*6支+凑单品','总价19.8？？ ','2020-09-04',0.183723);
/*!40000 ALTER TABLE `shampoo_raw` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-09-05 22:45:08
