-- MySQL dump 10.13  Distrib 9.4.0, for macos15 (arm64)
--
-- Host: localhost    Database: PureWaveDB
-- ------------------------------------------------------
-- Server version	9.4.0

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
-- Table structure for table `addresses`
--

DROP TABLE IF EXISTS `addresses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `addresses` (
  `address_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `street` varchar(255) DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `state` varchar(100) DEFAULT NULL,
  `country` varchar(100) DEFAULT NULL,
  `postal_code` varchar(20) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`address_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `addresses_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `addresses`
--

LOCK TABLES `addresses` WRITE;
/*!40000 ALTER TABLE `addresses` DISABLE KEYS */;
/*!40000 ALTER TABLE `addresses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `admin`
--

DROP TABLE IF EXISTS `admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admin` (
  `admin_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `role` enum('SuperAdmin','Marketing','Inventory','Sales') DEFAULT 'Marketing',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `last_login` datetime DEFAULT NULL,
  `login_count` int DEFAULT '0',
  `force_reset` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`admin_id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin`
--

LOCK TABLES `admin` WRITE;
/*!40000 ALTER TABLE `admin` DISABLE KEYS */;
INSERT INTO `admin` VALUES (1,'Arnob Hasan Sabit','arnob007@gmail.com','$2b$10$pzERqqbzbQ2bTchEsudIteIiuEq9HKJ5R36Z0HZojC/mMPXgCf9tm','SuperAdmin','2025-09-01 03:01:47',NULL,0,1);
/*!40000 ALTER TABLE `admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `announcements`
--

DROP TABLE IF EXISTS `announcements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `announcements` (
  `id` int NOT NULL AUTO_INCREMENT,
  `message` text NOT NULL,
  `assigned_to` varchar(100) DEFAULT NULL,
  `status` enum('pending','done') DEFAULT 'pending',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `announcements`
--

LOCK TABLES `announcements` WRITE;
/*!40000 ALTER TABLE `announcements` DISABLE KEYS */;
/*!40000 ALTER TABLE `announcements` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `banners`
--

DROP TABLE IF EXISTS `banners`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `banners` (
  `banner_id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `image_url` varchar(500) NOT NULL,
  `category_id` int DEFAULT NULL,
  `product_id` int DEFAULT NULL,
  `start_date` datetime NOT NULL,
  `end_date` datetime NOT NULL,
  `status` enum('active','inactive') DEFAULT 'active',
  PRIMARY KEY (`banner_id`),
  KEY `category_id` (`category_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `banners_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`) ON DELETE SET NULL,
  CONSTRAINT `banners_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `banners`
--

LOCK TABLES `banners` WRITE;
/*!40000 ALTER TABLE `banners` DISABLE KEYS */;
/*!40000 ALTER TABLE `banners` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cart`
--

DROP TABLE IF EXISTS `cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart` (
  `cart_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `product_id` int DEFAULT NULL,
  `quantity` int NOT NULL,
  `size` varchar(10) DEFAULT NULL,
  `added_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`cart_id`),
  KEY `user_id` (`user_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `cart_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  CONSTRAINT `cart_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart`
--

LOCK TABLES `cart` WRITE;
/*!40000 ALTER TABLE `cart` DISABLE KEYS */;
INSERT INTO `cart` VALUES (1,NULL,NULL,2,'L','2025-10-06 09:58:11');
/*!40000 ALTER TABLE `cart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `category_id` int NOT NULL AUTO_INCREMENT,
  `category_name` varchar(100) NOT NULL,
  `parent_id` int DEFAULT NULL,
  `level` enum('grand','parent','sub') NOT NULL,
  `thumbnail_url` varchar(255) DEFAULT NULL,
  `thumbnail_order` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`category_id`),
  KEY `fk_parent` (`parent_id`),
  CONSTRAINT `categories_ibfk_1` FOREIGN KEY (`parent_id`) REFERENCES `categories` (`category_id`),
  CONSTRAINT `fk_parent` FOREIGN KEY (`parent_id`) REFERENCES `categories` (`category_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=91 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,'Mens',NULL,'grand',NULL,0,'2025-08-31 13:39:08','2025-08-31 13:39:08'),(2,'Womens',NULL,'grand',NULL,0,'2025-08-31 13:39:08','2025-08-31 13:39:08'),(3,'Kids',NULL,'grand',NULL,0,'2025-08-31 13:39:08','2025-08-31 13:39:08'),(4,'Face Mask',NULL,'grand','Thumbnails/14.jpg',14,'2025-08-31 13:39:08','2025-09-02 17:23:43'),(5,'Sports',NULL,'grand',NULL,0,'2025-08-31 13:39:08','2025-08-31 13:39:08'),(6,'New Arrival',NULL,'grand',NULL,0,'2025-08-31 13:39:08','2025-08-31 13:39:08'),(7,'Top Selling',NULL,'grand',NULL,0,'2025-08-31 13:39:08','2025-08-31 13:39:08'),(8,'Merchandise',NULL,'grand',NULL,0,'2025-08-31 13:39:08','2025-08-31 13:39:08'),(9,'Free Delivery',NULL,'grand',NULL,0,'2025-08-31 13:39:08','2025-08-31 13:39:08'),(10,'Winter Exclusive',NULL,'grand',NULL,0,'2025-08-31 13:39:08','2025-08-31 13:39:08'),(11,'Mega Deal',NULL,'grand',NULL,0,'2025-08-31 13:39:08','2025-08-31 13:39:08'),(12,'Teens',NULL,'grand',NULL,0,'2025-08-31 13:39:08','2025-08-31 13:39:08'),(13,'Half Sleeve T-shirt',1,'parent',NULL,0,'2025-08-31 13:39:08','2025-08-31 13:39:08'),(14,'Full Sleeve T-shirt',1,'parent',NULL,0,'2025-08-31 13:39:08','2025-08-31 13:39:08'),(15,'Maggie',1,'parent',NULL,0,'2025-08-31 13:39:08','2025-08-31 13:39:08'),(16,'Shirt',1,'parent',NULL,0,'2025-08-31 13:39:08','2025-08-31 13:39:08'),(17,'Polo T-shirt',1,'parent',NULL,0,'2025-08-31 13:39:08','2025-08-31 13:39:08'),(18,'Hoodie',1,'parent','Thumbnails/5.jpg',5,'2025-08-31 13:39:08','2025-09-02 16:52:49'),(19,'Jacket',1,'parent','Thumbnails/4.jpg',4,'2025-08-31 13:39:08','2025-09-02 16:52:49'),(20,'Joggers',1,'parent','Thumbnails/12.jpg',12,'2025-08-31 13:39:08','2025-09-02 16:52:49'),(21,'Sweatshirt',1,'parent',NULL,0,'2025-08-31 13:39:08','2025-08-31 13:39:08'),(22,'Comfy Trouser',1,'parent','Thumbnails/10.jpg',10,'2025-08-31 13:39:08','2025-09-02 16:52:49'),(23,'Sports Trouser',1,'parent','Thumbnails/11.jpg',11,'2025-08-31 13:39:08','2025-09-02 16:52:49'),(24,'Shorts',1,'parent',NULL,0,'2025-08-31 13:39:08','2025-08-31 13:39:08'),(25,'Underwear',1,'parent',NULL,0,'2025-08-31 13:39:08','2025-08-31 13:39:08'),(26,'Socks',1,'parent','Thumbnails/13.jpg',13,'2025-08-31 13:39:08','2025-09-02 16:52:49'),(27,'Panjabi',1,'parent',NULL,0,'2025-08-31 13:39:08','2025-08-31 13:39:08'),(28,'Tupi',1,'parent',NULL,0,'2025-08-31 13:39:08','2025-08-31 13:39:08'),(29,'Jeans',1,'parent','Thumbnails/8.jpg',8,'2025-08-31 13:39:08','2025-09-02 16:52:49'),(30,'Pajama',1,'parent',NULL,0,'2025-08-31 13:39:08','2025-08-31 13:39:08'),(31,'Accessories',1,'parent',NULL,0,'2025-08-31 13:39:08','2025-08-31 13:39:08'),(32,'Chino Pants',1,'parent','Thumbnails/7.jpg',7,'2025-08-31 13:39:08','2025-09-02 16:52:49'),(33,'Cargo Pants',1,'parent','Thumbnails/9.jpg',9,'2025-08-31 13:39:08','2025-09-02 16:52:49'),(34,'T-Shirt',2,'parent',NULL,0,'2025-08-31 13:39:08','2025-08-31 13:39:08'),(35,'Comfy Trouser',2,'parent','',0,'2025-08-31 13:39:08','2025-09-02 15:12:30'),(36,'Kurti Tunic And Tops',2,'parent',NULL,0,'2025-08-31 13:39:08','2025-08-31 13:39:08'),(37,'Pajamas',2,'parent',NULL,0,'2025-08-31 13:39:08','2025-08-31 13:39:08'),(38,'Pants',2,'parent',NULL,0,'2025-08-31 13:39:08','2025-08-31 13:39:08'),(39,'Palazzo',2,'parent',NULL,0,'2025-08-31 13:39:08','2025-08-31 13:39:08'),(40,'Leggings',2,'parent',NULL,0,'2025-08-31 13:39:08','2025-08-31 13:39:08'),(41,'Boys',3,'parent',NULL,0,'2025-08-31 13:39:08','2025-08-31 13:39:08'),(42,'Girls',3,'parent',NULL,0,'2025-08-31 13:39:08','2025-08-31 13:39:08'),(43,'Professional 7 Layer Mask',4,'parent',NULL,0,'2025-08-31 13:39:08','2025-08-31 13:39:08'),(44,'Sports Edition',4,'parent',NULL,0,'2025-08-31 13:39:08','2025-08-31 13:39:08'),(45,'Womens Designer Edition',4,'parent',NULL,0,'2025-08-31 13:39:08','2025-08-31 13:39:08'),(46,'Womens Embroidery Edition',4,'parent',NULL,0,'2025-08-31 13:39:08','2025-08-31 13:39:08'),(47,'Kids Mask',4,'parent',NULL,0,'2025-08-31 13:39:08','2025-08-31 13:39:08'),(48,'Sports T-shirt',5,'parent',NULL,0,'2025-08-31 13:39:08','2025-08-31 13:39:08'),(49,'Football Jersey',5,'parent',NULL,0,'2025-08-31 13:39:08','2025-08-31 13:39:08'),(50,'Blank',13,'sub',NULL,0,'2025-08-31 13:39:08','2025-08-31 13:39:08'),(51,'Cut & Stitch',13,'sub','Thumbnails/3.jpg',3,'2025-08-31 13:39:08','2025-09-02 16:52:49'),(52,'Cut & Stitch (Designer Edition)',13,'sub',NULL,0,'2025-08-31 13:39:08','2025-08-31 13:39:08'),(53,'Drop Shoulder T-shirt',13,'sub',NULL,0,'2025-08-31 13:39:08','2025-08-31 13:39:08'),(54,'Printed',13,'sub','Thumbnails/1.jpg',1,'2025-08-31 13:39:08','2025-09-02 19:30:46'),(55,'Raglan',13,'sub',NULL,0,'2025-08-31 13:39:08','2025-08-31 13:39:08'),(56,'Sports',13,'sub',NULL,0,'2025-08-31 13:39:08','2025-08-31 13:39:08'),(57,'Blank',14,'sub',NULL,0,'2025-08-31 13:39:08','2025-08-31 13:39:08'),(58,'Cut & Stitch',14,'sub',NULL,0,'2025-08-31 13:39:08','2025-08-31 13:39:08'),(59,'Printed',14,'sub','Thumbnails/6.jpg',6,'2025-08-31 13:39:08','2025-09-02 16:52:49'),(60,'Raglan',14,'sub',NULL,0,'2025-08-31 13:39:08','2025-08-31 13:39:08'),(61,'Sports',14,'sub',NULL,0,'2025-08-31 13:39:08','2025-08-31 13:39:08'),(62,'Casual Shirt',16,'sub',NULL,0,'2025-08-31 13:39:08','2025-08-31 13:39:08'),(63,'Formal Shirt',16,'sub',NULL,0,'2025-08-31 13:39:08','2025-08-31 13:39:08'),(64,'Classic',17,'sub','Thumbnails/2.jpg',2,'2025-08-31 13:39:08','2025-09-02 16:52:49'),(65,'Cut & Stitch',17,'sub',NULL,0,'2025-08-31 13:39:08','2025-08-31 13:39:08'),(66,'Printed',17,'sub',NULL,0,'2025-08-31 13:39:08','2025-08-31 13:39:08'),(67,'Chino Shorts',24,'sub',NULL,0,'2025-08-31 13:39:08','2025-08-31 13:39:08'),(68,'Sports Shorts',24,'sub',NULL,0,'2025-08-31 13:39:08','2025-08-31 13:39:08'),(69,'Boxer Brief',25,'sub',NULL,0,'2025-08-31 13:39:08','2025-08-31 13:39:08'),(70,'Boxer Shorts',25,'sub',NULL,0,'2025-08-31 13:39:08','2025-08-31 13:39:08'),(71,'Trunk',25,'sub',NULL,0,'2025-08-31 13:39:08','2025-08-31 13:39:08'),(72,'Woven Shorts',25,'sub',NULL,0,'2025-08-31 13:39:08','2025-08-31 13:39:08'),(73,'Classic',26,'sub',NULL,0,'2025-08-31 13:39:08','2025-08-31 13:39:08'),(74,'Sports',26,'sub',NULL,0,'2025-08-31 13:39:08','2025-08-31 13:39:08'),(75,'Urban',26,'sub',NULL,0,'2025-08-31 13:39:08','2025-08-31 13:39:08'),(76,'Belt',31,'sub','Thumbnails/15.jpg',15,'2025-08-31 13:39:08','2025-09-02 16:52:49'),(77,'Cap',31,'sub',NULL,0,'2025-08-31 13:39:08','2025-08-31 13:39:08'),(78,'Wallet',31,'sub',NULL,0,'2025-08-31 13:39:08','2025-08-31 13:39:08'),(79,'Blank T-shirt',41,'sub',NULL,0,'2025-08-31 13:39:08','2025-08-31 13:39:08'),(80,'Boys Combo Set',41,'sub',NULL,0,'2025-08-31 13:39:08','2025-08-31 13:39:08'),(81,'Design Shorts',41,'sub',NULL,0,'2025-08-31 13:39:08','2025-08-31 13:39:08'),(82,'Blank T-shirt',42,'sub',NULL,0,'2025-08-31 13:39:08','2025-08-31 13:39:08'),(83,'Design Shorts',42,'sub',NULL,0,'2025-08-31 13:39:08','2025-08-31 13:39:08'),(84,'Frock',42,'sub',NULL,0,'2025-08-31 13:39:08','2025-08-31 13:39:08'),(85,'Two Piece Set',42,'sub',NULL,0,'2025-08-31 13:39:08','2025-08-31 13:39:08'),(86,'Professional 7 Layer Mask',4,'sub',NULL,0,'2025-08-31 13:39:08','2025-08-31 13:39:08'),(87,'Sports Edition',4,'sub',NULL,0,'2025-08-31 13:39:08','2025-08-31 13:39:08'),(88,'Womens Designer Edition',4,'sub',NULL,0,'2025-08-31 13:39:08','2025-08-31 13:39:08'),(89,'Womens Embroidery Edition',4,'sub',NULL,0,'2025-08-31 13:39:08','2025-08-31 13:39:08'),(90,'Kids Mask',4,'sub',NULL,0,'2025-08-31 13:39:08','2025-08-31 13:39:08');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `coupons`
--

DROP TABLE IF EXISTS `coupons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `coupons` (
  `coupon_id` int NOT NULL AUTO_INCREMENT,
  `code` varchar(50) NOT NULL,
  `discount_type` enum('percentage','fixed') NOT NULL,
  `discount_value` decimal(10,2) NOT NULL,
  `start_date` datetime NOT NULL,
  `end_date` datetime NOT NULL,
  `usage_limit` int DEFAULT '0',
  `min_order_value` decimal(10,2) DEFAULT '0.00',
  `status` enum('active','expired','disabled') DEFAULT 'active',
  PRIMARY KEY (`coupon_id`),
  UNIQUE KEY `code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `coupons`
--

LOCK TABLES `coupons` WRITE;
/*!40000 ALTER TABLE `coupons` DISABLE KEYS */;
/*!40000 ALTER TABLE `coupons` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `images`
--

DROP TABLE IF EXISTS `images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `images` (
  `image_id` int NOT NULL AUTO_INCREMENT,
  `product_id` int DEFAULT NULL,
  `image_url` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`image_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `images_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=455 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `images`
--

LOCK TABLES `images` WRITE;
/*!40000 ALTER TABLE `images` DISABLE KEYS */;
INSERT INTO `images` VALUES (1,1,'Products/1.jpg','2025-08-29 09:14:19'),(2,2,'Products/2.jpg','2025-08-29 09:14:19'),(3,3,'Products/3.jpg','2025-08-29 09:14:19'),(4,4,'Products/4.jpg','2025-08-29 09:14:19'),(5,5,'Products/5.jpg','2025-08-29 09:14:19'),(6,6,'Products/6.jpg','2025-08-29 09:14:19'),(7,7,'Products/7.jpg','2025-08-29 09:14:19'),(8,8,'Products/8.jpg','2025-08-29 09:14:19'),(9,9,'Products/9.jpg','2025-08-29 09:14:19'),(10,10,'Products/10.jpg','2025-08-29 09:14:19'),(11,11,'Products/11.jpg','2025-08-29 09:14:19'),(12,12,'Products/12.jpg','2025-08-29 09:14:19'),(13,13,'Products/13.jpg','2025-08-29 09:14:19'),(14,14,'Products/14.jpg','2025-08-29 09:14:19'),(15,15,'Products/15.jpg','2025-08-29 09:14:19'),(16,16,'Products/16.jpg','2025-08-29 09:14:19'),(17,17,'Products/17.jpg','2025-08-29 09:14:19'),(18,18,'Products/18.jpg','2025-08-29 09:14:19'),(19,19,'Products/19.jpg','2025-08-29 09:14:19'),(20,20,'Products/20.jpg','2025-08-29 09:14:19'),(21,21,'Products/21.jpg','2025-08-29 09:14:19'),(22,22,'Products/22.jpg','2025-08-29 09:14:19'),(23,23,'Products/23.jpg','2025-08-29 09:14:19'),(24,24,'Products/24.jpg','2025-08-29 09:14:19'),(25,25,'Products/25.jpg','2025-08-29 09:14:19'),(26,26,'Products/26.jpg','2025-08-29 09:14:19'),(27,27,'Products/27.jpg','2025-08-29 09:14:19'),(28,28,'Products/28.jpg','2025-08-29 09:14:19'),(29,29,'Products/29.jpg','2025-08-29 09:14:19'),(30,30,'Products/30.jpg','2025-08-29 09:14:19'),(31,31,'Products/31.jpg','2025-08-29 09:14:19'),(32,32,'Products/32.jpg','2025-08-29 09:14:19'),(33,33,'Products/33.jpg','2025-08-29 09:14:19'),(34,34,'Products/34.jpg','2025-08-29 09:14:19'),(35,35,'Products/35.jpg','2025-08-29 09:14:19'),(36,36,'Products/36.jpg','2025-08-29 09:14:19'),(37,37,'Products/37.jpg','2025-08-29 09:14:19'),(38,38,'Products/38.jpg','2025-08-29 09:14:19'),(39,39,'Products/39.jpg','2025-08-29 09:14:19'),(40,40,'Products/40.jpg','2025-08-29 09:14:19'),(41,41,'Products/41.jpg','2025-08-29 09:14:19'),(42,42,'Products/42.jpg','2025-08-29 09:14:19'),(43,43,'Products/43.jpg','2025-08-29 09:14:19'),(44,44,'Products/44.jpg','2025-08-29 09:14:19'),(45,45,'Products/45.jpg','2025-08-29 09:14:19'),(46,46,'Products/46.jpg','2025-08-29 09:14:19'),(47,47,'Products/47.jpg','2025-08-29 09:14:19'),(48,48,'Products/48.jpg','2025-08-29 09:14:19'),(49,49,'Products/49.jpg','2025-08-29 09:14:19'),(50,50,'Products/50.jpg','2025-08-29 09:14:19'),(51,51,'Products/51.jpg','2025-08-29 09:14:19'),(52,52,'Products/52.jpg','2025-08-29 09:14:19'),(53,53,'Products/53.jpg','2025-08-29 09:14:19'),(54,54,'Products/54.jpg','2025-08-29 09:14:19'),(55,55,'Products/55.jpg','2025-08-29 09:14:19'),(56,56,'Products/56.jpg','2025-08-29 09:14:19'),(57,57,'Products/57.jpg','2025-08-29 09:14:19'),(58,58,'Products/58.jpg','2025-08-29 09:14:19'),(59,59,'Products/59.jpg','2025-08-29 09:14:19'),(60,60,'Products/60.jpg','2025-08-29 09:14:19'),(61,61,'Products/61.jpg','2025-08-29 09:14:19'),(62,62,'Products/62.jpg','2025-08-29 09:14:19'),(63,63,'Products/63.jpg','2025-08-29 09:14:19'),(64,64,'Products/64.jpg','2025-08-29 09:14:19'),(65,65,'Products/65.jpg','2025-08-29 09:14:19'),(66,66,'Products/66.jpg','2025-08-29 09:14:19'),(67,67,'Products/67.jpg','2025-08-29 09:14:19'),(68,68,'Products/68.jpg','2025-08-29 09:14:19'),(69,69,'Products/69.jpg','2025-08-29 09:14:19'),(70,70,'Products/70.jpg','2025-08-29 09:14:19'),(71,71,'Products/71.jpg','2025-08-29 09:14:19'),(72,72,'Products/72.jpg','2025-08-29 09:14:19'),(73,73,'Products/73.jpg','2025-08-29 09:14:19'),(74,74,'Products/74.jpg','2025-08-29 09:14:19'),(75,75,'Products/75.jpg','2025-08-29 09:14:19'),(76,76,'Products/76.jpg','2025-08-29 09:14:19'),(77,77,'Products/77.jpg','2025-08-29 09:14:19'),(78,78,'Products/78.jpg','2025-08-29 09:14:19'),(79,79,'Products/79.jpg','2025-08-29 09:14:19'),(80,80,'Products/80.jpg','2025-08-29 09:14:19'),(81,81,'Products/81.jpg','2025-08-29 09:14:19'),(82,82,'Products/82.jpg','2025-08-29 09:14:19'),(83,83,'Products/83.jpg','2025-08-29 09:14:19'),(84,84,'Products/84.jpg','2025-08-29 09:14:19'),(85,85,'Products/85.jpg','2025-08-29 09:14:19'),(86,86,'Products/86.jpg','2025-08-29 09:14:19'),(87,87,'Products/87.jpg','2025-08-29 09:14:19'),(88,88,'Products/88.jpg','2025-08-29 09:14:19'),(89,89,'Products/89.jpg','2025-08-29 09:14:19'),(90,90,'Products/90.jpg','2025-08-29 09:14:19'),(91,91,'Products/91.jpg','2025-08-29 09:14:19'),(92,92,'Products/92.jpg','2025-08-29 09:14:19'),(93,93,'Products/93.jpg','2025-08-29 09:14:19'),(94,94,'Products/94.jpg','2025-08-29 09:14:19'),(95,95,'Products/95.jpg','2025-08-29 09:14:19'),(96,96,'Products/96.jpg','2025-08-29 09:14:19'),(97,97,'Products/97.jpg','2025-08-29 09:14:19'),(98,98,'Products/98.jpg','2025-08-29 09:14:19'),(99,99,'Products/99.jpg','2025-08-29 09:14:19'),(100,100,'Products/100.jpg','2025-08-29 09:14:19'),(101,101,'Products/101.jpg','2025-08-29 09:14:19'),(102,102,'Products/102.jpg','2025-08-29 09:14:19'),(103,103,'Products/103.jpg','2025-08-29 09:14:19'),(104,104,'Products/104.jpg','2025-08-29 09:14:19'),(105,105,'Products/105.jpg','2025-08-29 09:14:19'),(106,106,'Products/106.jpg','2025-08-29 09:14:19'),(107,107,'Products/107.jpg','2025-08-29 09:14:19'),(108,108,'Products/108.jpg','2025-08-29 09:14:19'),(109,109,'Products/109.jpg','2025-08-29 09:14:19'),(110,110,'Products/110.jpg','2025-08-29 09:14:19'),(111,111,'Products/111.jpg','2025-08-29 09:14:19'),(112,112,'Products/112.jpg','2025-08-29 09:14:19'),(113,113,'Products/113.jpg','2025-08-29 09:14:19'),(114,114,'Products/114.jpg','2025-08-29 09:14:19'),(115,115,'Products/115.jpg','2025-08-29 09:14:19'),(116,116,'Products/116.jpg','2025-08-29 09:14:19'),(117,117,'Products/117.jpg','2025-08-29 09:14:19'),(118,118,'Products/118.jpg','2025-08-29 09:14:19'),(119,119,'Products/119.jpg','2025-08-29 09:14:19'),(120,120,'Products/120.jpg','2025-08-29 09:14:19'),(121,121,'Products/121.jpg','2025-08-29 09:14:19'),(122,122,'Products/122.jpg','2025-08-29 09:14:19'),(123,123,'Products/123.jpg','2025-08-29 09:14:19'),(124,124,'Products/124.jpg','2025-08-29 09:14:19'),(125,125,'Products/125.jpg','2025-08-29 09:14:19'),(126,126,'Products/126.jpg','2025-08-29 09:14:19'),(127,127,'Products/127.jpg','2025-08-29 09:14:19'),(128,128,'Products/128.jpg','2025-08-29 09:14:19'),(129,129,'Products/129.jpg','2025-08-29 09:14:19'),(130,130,'Products/130.jpg','2025-08-29 09:14:19'),(131,131,'Products/131.jpg','2025-08-29 09:14:19'),(132,132,'Products/132.jpg','2025-08-29 09:14:19'),(133,133,'Products/133.jpg','2025-08-29 09:14:19'),(134,134,'Products/134.jpg','2025-08-29 09:14:19'),(135,135,'Products/135.jpg','2025-08-29 09:14:19'),(136,136,'Products/136.jpg','2025-08-29 09:14:19'),(137,137,'Products/137.jpg','2025-08-29 09:14:19'),(138,138,'Products/138.jpg','2025-08-29 09:14:19'),(139,139,'Products/139.jpg','2025-08-29 09:14:19'),(140,140,'Products/140.jpg','2025-08-29 09:14:19'),(141,141,'Products/141.jpg','2025-08-29 09:14:19'),(142,142,'Products/142.jpg','2025-08-29 09:14:19'),(143,143,'Products/143.jpg','2025-08-29 09:14:19'),(144,144,'Products/144.jpg','2025-08-29 09:14:19'),(145,145,'Products/145.jpg','2025-08-29 09:14:19'),(146,146,'Products/146.jpg','2025-08-29 09:14:19'),(147,147,'Products/147.jpg','2025-08-29 09:14:19'),(148,148,'Products/148.jpg','2025-08-29 09:14:19'),(149,149,'Products/149.jpg','2025-08-29 09:14:19'),(150,150,'Products/150.jpg','2025-08-29 09:14:19'),(151,151,'Products/151.jpg','2025-08-29 09:14:19'),(152,152,'Products/152.jpg','2025-08-29 09:14:19'),(153,153,'Products/153.jpg','2025-08-29 09:14:19'),(154,154,'Products/154.jpg','2025-08-29 09:14:19'),(155,155,'Products/155.jpg','2025-08-29 09:14:19'),(156,156,'Products/156.jpg','2025-08-29 09:14:19'),(157,157,'Products/157.jpg','2025-08-29 09:14:19'),(158,158,'Products/158.jpg','2025-08-29 09:14:19'),(159,159,'Products/159.jpg','2025-08-29 09:14:19'),(160,160,'Products/160.jpg','2025-08-29 09:14:19'),(161,161,'Products/161.jpg','2025-08-29 09:14:19'),(162,162,'Products/162.jpg','2025-08-29 09:14:19'),(163,163,'Products/163.jpg','2025-08-29 09:14:19'),(164,164,'Products/164.jpg','2025-08-29 09:14:19'),(165,165,'Products/165.jpg','2025-08-29 09:14:19'),(166,166,'Products/166.jpg','2025-08-29 09:14:19'),(167,167,'Products/167.jpg','2025-08-29 09:14:19'),(168,168,'Products/168.jpg','2025-08-29 09:14:19'),(169,169,'Products/169.jpg','2025-08-29 09:14:19'),(170,170,'Products/170.jpg','2025-08-29 09:14:19'),(171,171,'Products/171.jpg','2025-08-29 09:14:19'),(172,172,'Products/172.jpg','2025-08-29 09:14:19'),(173,173,'Products/173.jpg','2025-08-29 09:14:19'),(174,174,'Products/174.jpg','2025-08-29 09:14:19'),(175,175,'Products/175.jpg','2025-08-29 09:14:19'),(176,176,'Products/176.jpg','2025-08-29 09:14:19'),(177,177,'Products/177.jpg','2025-08-29 09:14:19'),(178,178,'Products/178.jpg','2025-08-29 09:14:19'),(179,179,'Products/179.jpg','2025-08-29 09:14:19'),(180,180,'Products/180.jpg','2025-08-29 09:14:19'),(181,181,'Products/181.jpg','2025-08-29 09:14:19'),(182,182,'Products/182.jpg','2025-08-29 09:14:19'),(183,183,'Products/183.jpg','2025-08-29 09:14:19'),(184,184,'Products/184.jpg','2025-08-29 09:14:19'),(185,185,'Products/185.jpg','2025-08-29 09:14:19'),(186,186,'Products/186.jpg','2025-08-29 09:14:19'),(187,187,'Products/187.jpg','2025-08-29 09:14:19'),(188,188,'Products/188.jpg','2025-08-29 09:14:19'),(189,189,'Products/189.jpg','2025-08-29 09:14:19'),(190,190,'Products/190.jpg','2025-08-29 09:14:19'),(191,191,'Products/191.jpg','2025-08-29 09:14:19'),(192,192,'Products/192.jpg','2025-08-29 09:14:19'),(193,193,'Products/193.jpg','2025-08-29 09:14:19'),(194,194,'Products/194.jpg','2025-08-29 09:14:19'),(195,195,'Products/195.jpg','2025-08-29 09:14:19'),(196,196,'Products/196.jpg','2025-08-29 09:14:19'),(197,197,'Products/197.jpg','2025-08-29 09:14:19'),(198,198,'Products/198.jpg','2025-08-29 09:14:19'),(199,199,'Products/199.jpg','2025-08-29 09:14:19'),(200,200,'Products/200.jpg','2025-08-29 09:14:19'),(201,201,'Products/201.jpg','2025-08-29 09:14:19'),(202,202,'Products/202.jpg','2025-08-29 09:14:19'),(203,203,'Products/203.jpg','2025-08-29 09:14:19'),(204,204,'Products/204.jpg','2025-08-29 09:14:19'),(205,205,'Products/205.jpg','2025-08-29 09:14:19'),(206,206,'Products/206.jpg','2025-08-29 09:14:19'),(207,207,'Products/207.jpg','2025-08-29 09:14:19'),(208,208,'Products/208.jpg','2025-08-29 09:14:19'),(209,209,'Products/209.jpg','2025-08-29 09:14:19'),(210,210,'Products/210.jpg','2025-08-29 09:14:19'),(211,211,'Products/211.jpg','2025-08-29 09:14:19'),(212,212,'Products/212.jpg','2025-08-29 09:14:19'),(213,213,'Products/213.jpg','2025-08-29 09:14:19'),(214,214,'Products/214.jpg','2025-08-29 09:14:19'),(215,215,'Products/215.jpg','2025-08-29 09:14:19'),(216,216,'Products/216.jpg','2025-08-29 09:14:19'),(217,217,'Products/217.jpg','2025-08-29 09:14:19'),(218,218,'Products/218.jpg','2025-08-29 09:14:19'),(219,219,'Products/219.jpg','2025-08-29 09:14:19'),(220,220,'Products/220.jpg','2025-08-29 09:14:19'),(221,221,'Products/221.jpg','2025-08-29 09:14:19'),(222,222,'Products/222.jpg','2025-08-29 09:14:19'),(223,223,'Products/223.jpg','2025-08-29 09:14:19'),(224,224,'Products/224.jpg','2025-08-29 09:14:19'),(225,225,'Products/225.jpg','2025-08-29 09:14:19'),(226,1,'Products/226.jpg','2025-09-03 10:37:15'),(454,NULL,'','2025-09-10 13:51:58');
/*!40000 ALTER TABLE `images` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inventory`
--

DROP TABLE IF EXISTS `inventory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inventory` (
  `inventory_id` int NOT NULL AUTO_INCREMENT,
  `product_id` int DEFAULT NULL,
  `stock_in` int DEFAULT '0',
  `stock_out` int DEFAULT '0',
  `current_stock` int DEFAULT '0',
  `last_updated` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`inventory_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `inventory_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventory`
--

LOCK TABLES `inventory` WRITE;
/*!40000 ALTER TABLE `inventory` DISABLE KEYS */;
/*!40000 ALTER TABLE `inventory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `loyalty_points`
--

DROP TABLE IF EXISTS `loyalty_points`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `loyalty_points` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `points` int NOT NULL DEFAULT '0',
  `earned_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `redeemed_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `loyalty_points_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `loyalty_points`
--

LOCK TABLES `loyalty_points` WRITE;
/*!40000 ALTER TABLE `loyalty_points` DISABLE KEYS */;
/*!40000 ALTER TABLE `loyalty_points` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_items`
--

DROP TABLE IF EXISTS `order_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_items` (
  `order_item_id` int NOT NULL AUTO_INCREMENT,
  `order_id` int DEFAULT NULL,
  `product_id` int DEFAULT NULL,
  `quantity` int NOT NULL,
  `price` decimal(10,2) NOT NULL,
  PRIMARY KEY (`order_item_id`),
  KEY `order_id` (`order_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`),
  CONSTRAINT `order_items_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_items`
--

LOCK TABLES `order_items` WRITE;
/*!40000 ALTER TABLE `order_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `order_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `order_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `status` enum('pending','shipped','delivered','canceled') DEFAULT 'pending',
  `total_amount` decimal(10,2) DEFAULT NULL,
  `payment_id` int DEFAULT NULL,
  `shipping_address_id` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`order_id`),
  KEY `user_id` (`user_id`),
  KEY `shipping_address_id` (`shipping_address_id`),
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`shipping_address_id`) REFERENCES `addresses` (`address_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payments`
--

DROP TABLE IF EXISTS `payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payments` (
  `payment_id` int NOT NULL AUTO_INCREMENT,
  `order_id` int DEFAULT NULL,
  `payment_method` enum('card','COD','PayPal','Other') DEFAULT NULL,
  `payment_status` enum('pending','completed','failed','refunded') DEFAULT 'pending',
  `transaction_id` varchar(100) DEFAULT NULL,
  `amount` decimal(10,2) DEFAULT NULL,
  `currency` varchar(10) DEFAULT 'USD',
  `payment_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`payment_id`),
  KEY `order_id` (`order_id`),
  CONSTRAINT `payments_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payments`
--

LOCK TABLES `payments` WRITE;
/*!40000 ALTER TABLE `payments` DISABLE KEYS */;
/*!40000 ALTER TABLE `payments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_variants`
--

DROP TABLE IF EXISTS `product_variants`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_variants` (
  `variant_id` int NOT NULL AUTO_INCREMENT,
  `product_id` int NOT NULL,
  `size` varchar(20) DEFAULT NULL,
  `color` varchar(50) DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `stock_quantity` int DEFAULT '0',
  `sku` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`variant_id`),
  UNIQUE KEY `sku` (`sku`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `product_variants_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_variants`
--

LOCK TABLES `product_variants` WRITE;
/*!40000 ALTER TABLE `product_variants` DISABLE KEYS */;
/*!40000 ALTER TABLE `product_variants` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `product_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  `description` text,
  `category_id` int DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `size` varchar(50) DEFAULT NULL,
  `color` varchar(50) DEFAULT NULL,
  `stock_quantity` int DEFAULT '0',
  `brand` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `premium` tinyint(1) DEFAULT '0',
  `limited_edition` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`product_id`),
  KEY `category_id` (`category_id`),
  CONSTRAINT `products_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=226 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,'Printed','PureWave Mens Premium Quality t-shirt that offers a much smoother, silky feel and more structured, mid-weight fit than the regular t-shirts . The t-shirts are made with finest quality Combed Compact Cotton , features astonishing ~175 GSM on just 26\'s cotton which gives a smooth and compact construction.  The compact finish guarantees that the t-shirt length and width will not change over wash or months of usage.  Detailed Specification:  Organic Ringspun Combed Compact Cotton 100% Cotton Regular fit, Crew Neck Mid-weight, 5.16 oz/yd2(~175GSM) Reactive Dye, enzyme and silicon washed Preshurnk to minimize shrinkage',54,699.00,'Small, Medium, Large, Extra Large','',99,'PureWave','2025-08-29 08:51:16','2025-09-03 10:23:19',0,0),(2,'Printed','',54,699.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 08:51:16','2025-09-02 19:29:06',0,0),(3,'Printed','',54,699.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 08:51:16','2025-09-02 19:29:06',0,0),(4,'Printed','',54,699.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 08:51:16','2025-09-02 19:29:06',0,0),(5,'Printed','',54,699.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 08:51:16','2025-09-02 19:29:06',0,0),(6,'Printed','',54,699.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 08:51:16','2025-09-02 19:29:06',0,0),(7,'Printed','',54,699.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 08:51:16','2025-09-02 19:29:06',0,0),(8,'Printed','',54,699.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 08:51:16','2025-09-02 19:29:06',0,0),(9,'Printed','',54,699.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 08:51:16','2025-09-02 19:29:06',0,0),(10,'Printed','',54,699.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 08:51:16','2025-09-02 19:29:06',0,0),(11,'Printed','',54,699.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 08:51:16','2025-09-02 19:29:06',0,0),(12,'Printed','',54,699.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 08:51:16','2025-09-02 19:29:06',0,0),(13,'Printed','',54,699.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 08:51:16','2025-09-02 19:29:06',0,0),(14,'Printed','',54,699.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 08:51:16','2025-09-02 19:29:06',0,0),(15,'Printed','',54,699.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 08:51:16','2025-09-02 19:29:06',0,0),(16,'Premium Polo','',64,899.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 08:51:16','2025-09-02 19:29:55',0,0),(17,'Premium Polo','',64,899.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 08:51:16','2025-09-02 19:29:55',0,0),(18,'Premium Polo','',64,899.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 08:51:16','2025-09-02 19:29:55',0,0),(19,'Premium Polo','',64,899.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 08:51:16','2025-09-02 19:29:55',0,0),(20,'Premium Polo','',64,899.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 08:51:16','2025-09-02 19:29:55',0,0),(21,'Premium Polo','',64,899.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 08:51:16','2025-09-02 19:29:55',0,0),(22,'Premium Polo','',64,899.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 08:51:16','2025-09-02 19:29:55',0,0),(23,'Premium Polo','',64,899.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 08:51:16','2025-09-02 19:29:55',0,0),(24,'Premium Polo','',64,899.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 08:51:16','2025-09-02 19:29:55',0,0),(25,'Premium Polo','',64,899.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 08:51:16','2025-09-02 19:29:55',0,0),(26,'Premium Polo','',64,899.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 08:51:16','2025-09-02 19:29:55',0,0),(27,'Premium Polo','',64,899.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 08:51:16','2025-09-02 19:29:55',0,0),(28,'Premium Polo','',64,899.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 08:51:16','2025-09-02 19:29:55',0,0),(29,'Premium Polo','',64,899.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 08:51:16','2025-09-02 19:29:55',0,0),(30,'Premium Polo','',64,899.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 08:51:16','2025-09-02 19:29:55',0,0),(31,'Cut And Stitch','',51,799.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 08:51:16','2025-09-02 19:31:53',0,0),(32,'Cut And Stitch','',51,799.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 08:51:16','2025-09-02 19:31:53',0,0),(33,'Cut And Stitch','',51,799.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 08:51:16','2025-09-02 19:31:53',0,0),(34,'Cut And Stitch','',51,799.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 08:51:16','2025-09-02 19:31:53',0,0),(35,'Cut And Stitch','',51,799.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 08:51:16','2025-09-02 19:31:53',0,0),(36,'Cut And Stitch','',51,799.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 08:51:16','2025-09-02 19:31:53',0,0),(37,'Cut And Stitch','',51,799.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 08:51:16','2025-09-02 19:31:53',0,0),(38,'Cut And Stitch','',51,799.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 08:51:16','2025-09-02 19:31:53',0,0),(39,'Cut And Stitch','',51,799.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 08:51:16','2025-09-02 19:31:53',0,0),(40,'Cut And Stitch','',51,799.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 08:51:16','2025-09-02 19:31:53',0,0),(41,'Cut And Stitch','',51,799.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 08:51:16','2025-09-02 19:31:53',0,0),(42,'Cut And Stitch','',51,799.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 08:51:16','2025-09-02 19:31:53',0,0),(43,'Cut And Stitch','',51,799.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 08:51:16','2025-09-02 19:31:53',0,0),(44,'Cut And Stitch','',51,799.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 08:51:16','2025-09-02 19:31:53',0,0),(45,'Cut And Stitch','',51,799.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 08:51:16','2025-09-02 19:31:53',0,0),(46,'Jacket','',19,1999.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 08:53:00','2025-09-02 19:32:50',0,0),(47,'Jacket','',19,1999.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 08:53:00','2025-09-02 19:32:50',0,0),(48,'Jacket','',19,1999.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 08:53:00','2025-09-02 19:32:50',0,0),(49,'Jacket','',19,1999.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 08:53:00','2025-09-02 19:32:50',0,0),(50,'Jacket','',19,1999.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 08:53:00','2025-09-02 19:32:50',0,0),(51,'Jacket','',19,1999.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 08:53:00','2025-09-02 19:32:50',0,0),(52,'Jacket','',19,1999.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 08:53:00','2025-09-02 19:32:50',0,0),(53,'Jacket','',19,1999.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 08:53:00','2025-09-02 19:32:50',0,0),(54,'Jacket','',19,1999.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 08:53:00','2025-09-02 19:32:50',0,0),(55,'Jacket','',19,1999.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 08:53:00','2025-09-02 19:32:50',0,0),(56,'Jacket','',19,1999.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 08:53:00','2025-09-02 19:32:50',0,0),(57,'Jacket','',19,1999.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 08:53:00','2025-09-02 19:32:50',0,0),(58,'Jacket','',19,1999.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 08:53:00','2025-09-02 19:32:50',0,0),(59,'Jacket','',19,1999.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 08:53:00','2025-09-02 19:32:50',0,0),(60,'Jacket','',19,1999.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 08:53:00','2025-09-02 19:32:50',0,0),(61,'Hoodie','',18,999.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 08:53:00','2025-09-02 19:33:10',0,0),(62,'Hoodie','',18,999.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 08:53:00','2025-09-02 19:33:10',0,0),(63,'Hoodie','',18,999.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 08:53:00','2025-09-02 19:33:10',0,0),(64,'Hoodie','',18,999.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 08:53:00','2025-09-02 19:33:10',0,0),(65,'Hoodie','',18,999.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 08:53:00','2025-09-02 19:33:10',0,0),(66,'Hoodie','',18,999.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 08:53:00','2025-09-02 19:33:10',0,0),(67,'Hoodie','',18,999.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 08:53:00','2025-09-02 19:33:10',0,0),(68,'Hoodie','',18,999.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 08:53:00','2025-09-02 19:33:10',0,0),(69,'Hoodie','',18,999.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 08:53:00','2025-09-02 19:33:10',0,0),(70,'Hoodie','',18,999.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 08:53:00','2025-09-02 19:33:10',0,0),(71,'Hoodie','',18,999.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 08:53:00','2025-09-02 19:33:10',0,0),(72,'Hoodie','',18,999.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 08:53:00','2025-09-02 19:33:10',0,0),(73,'Hoodie','',18,999.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 08:53:00','2025-09-02 19:33:10',0,0),(74,'Hoodie','',18,999.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 08:53:00','2025-09-02 19:33:10',0,0),(75,'Hoodie','',18,999.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 08:53:00','2025-09-02 19:33:10',0,0),(76,'Full Sleeve T-Shirt','',59,899.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 08:53:00','2025-09-02 19:33:44',0,0),(77,'Full Sleeve T-Shirt','',59,899.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 08:53:00','2025-09-02 19:33:44',0,0),(78,'Full Sleeve T-Shirt','',59,899.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 08:53:00','2025-09-02 19:33:44',0,0),(79,'Full Sleeve T-Shirt','',59,899.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 08:53:00','2025-09-02 19:33:44',0,0),(80,'Full Sleeve T-Shirt','',59,899.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 08:53:00','2025-09-02 19:33:44',0,0),(81,'Full Sleeve T-Shirt','',59,899.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 08:53:00','2025-09-02 19:33:44',0,0),(82,'Full Sleeve T-Shirt','',59,899.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 08:53:00','2025-09-02 19:33:44',0,0),(83,'Full Sleeve T-Shirt','',59,899.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 08:53:00','2025-09-02 19:33:44',0,0),(84,'Full Sleeve T-Shirt','',59,899.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 08:53:00','2025-09-02 19:33:44',0,0),(85,'Full Sleeve T-Shirt','',59,899.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 08:53:00','2025-09-02 19:33:44',0,0),(86,'Full Sleeve T-Shirt','',59,899.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 08:53:00','2025-09-02 19:33:44',0,0),(87,'Full Sleeve T-Shirt','',59,899.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 08:53:00','2025-09-02 19:33:44',0,0),(88,'Full Sleeve T-Shirt','',59,899.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 08:53:00','2025-09-02 19:33:44',0,0),(89,'Full Sleeve T-Shirt','',59,899.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 08:53:00','2025-09-02 19:33:44',0,0),(90,'Full Sleeve T-Shirt','',59,899.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 08:53:00','2025-09-02 19:33:44',0,0),(91,'Chino Pants','',32,999.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 09:03:29','2025-09-02 19:34:24',0,0),(92,'Chino Pants','',32,999.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 09:03:29','2025-09-02 19:34:24',0,0),(93,'Chino Pants','',32,999.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 09:03:29','2025-09-02 19:34:24',0,0),(94,'Chino Pants','',32,999.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 09:03:29','2025-09-02 19:34:24',0,0),(95,'Chino Pants','',32,999.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 09:03:29','2025-09-02 19:34:24',0,0),(96,'Chino Pants','',32,999.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 09:03:29','2025-09-02 19:34:24',0,0),(97,'Chino Pants','',32,999.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 09:03:29','2025-09-02 19:34:24',0,0),(98,'Chino Pants','',32,999.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 09:03:29','2025-09-02 19:34:24',0,0),(99,'Chino Pants','',32,999.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 09:03:29','2025-09-02 19:34:24',0,0),(100,'Chino Pants','',32,999.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 09:03:29','2025-09-02 19:34:24',0,0),(101,'Chino Pants','',32,999.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 09:03:29','2025-09-02 19:34:24',0,0),(102,'Chino Pants','',32,999.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 09:03:29','2025-09-02 19:34:24',0,0),(103,'Chino Pants','',32,999.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 09:03:29','2025-09-02 19:34:24',0,0),(104,'Chino Pants','',32,999.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 09:03:29','2025-09-02 19:34:24',0,0),(105,'Chino Pants','',32,999.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 09:03:29','2025-09-02 19:34:24',0,0),(106,'Jeans','',26,899.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 09:03:29','2025-09-02 19:34:47',0,0),(107,'Jeans','',26,899.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 09:03:29','2025-09-02 19:34:47',0,0),(108,'Jeans','',26,899.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 09:03:29','2025-09-02 19:34:47',0,0),(109,'Jeans','',26,899.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 09:03:29','2025-09-02 19:34:47',0,0),(110,'Jeans','',26,899.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 09:03:29','2025-09-02 19:34:47',0,0),(111,'Jeans','',26,899.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 09:03:29','2025-09-02 19:34:47',0,0),(112,'Jeans','',26,899.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 09:03:29','2025-09-02 19:34:47',0,0),(113,'Jeans','',26,899.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 09:03:29','2025-09-02 19:34:47',0,0),(114,'Jeans','',26,899.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 09:03:29','2025-09-02 19:34:47',0,0),(115,'Jeans','',26,899.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 09:03:29','2025-09-02 19:34:47',0,0),(116,'Jeans','',26,899.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 09:03:29','2025-09-02 19:34:47',0,0),(117,'Jeans','',26,899.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 09:03:29','2025-09-02 19:34:47',0,0),(118,'Jeans','',26,899.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 09:03:29','2025-09-02 19:34:47',0,0),(119,'Jeans','',26,899.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 09:03:29','2025-09-02 19:34:47',0,0),(120,'Jeans','',26,899.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 09:03:29','2025-09-02 19:34:47',0,0),(121,'Cargo Pants','',33,1499.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 09:03:29','2025-09-02 19:35:08',0,0),(122,'Cargo Pants','',33,1499.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 09:03:29','2025-09-02 19:35:08',0,0),(123,'Cargo Pants','',33,1499.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 09:03:29','2025-09-02 19:35:08',0,0),(124,'Cargo Pants','',33,1499.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 09:03:29','2025-09-02 19:35:08',0,0),(125,'Cargo Pants','',33,1499.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 09:03:29','2025-09-02 19:35:08',0,0),(126,'Cargo Pants','',33,1499.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 09:03:29','2025-09-02 19:35:08',0,0),(127,'Cargo Pants','',33,1499.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 09:03:29','2025-09-02 19:35:08',0,0),(128,'Cargo Pants','',33,1499.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 09:03:29','2025-09-02 19:35:08',0,0),(129,'Cargo Pants','',33,1499.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 09:03:29','2025-09-02 19:35:08',0,0),(130,'Cargo Pants','',33,1499.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 09:03:29','2025-09-02 19:35:08',0,0),(131,'Cargo Pants','',33,1499.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 09:03:29','2025-09-02 19:35:08',0,0),(132,'Cargo Pants','',33,1499.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 09:03:29','2025-09-02 19:35:08',0,0),(133,'Cargo Pants','',33,1499.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 09:03:29','2025-09-02 19:35:08',0,0),(134,'Cargo Pants','',33,1499.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 09:03:29','2025-09-02 19:35:08',0,0),(135,'Cargo Pants','',33,1499.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 09:03:29','2025-09-02 19:35:08',0,0),(136,'Comfy Trouser','',22,1899.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 09:03:29','2025-09-02 19:35:41',0,0),(137,'Comfy Trouser','',22,1899.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 09:03:29','2025-09-02 19:35:41',0,0),(138,'Comfy Trouser','',22,1899.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 09:03:29','2025-09-02 19:35:41',0,0),(139,'Comfy Trouser','',22,1899.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 09:03:29','2025-09-02 19:35:41',0,0),(140,'Comfy Trouser','',22,1899.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 09:03:29','2025-09-02 19:35:41',0,0),(141,'Comfy Trouser','',22,1899.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 09:03:29','2025-09-02 19:35:41',0,0),(142,'Comfy Trouser','',22,1899.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 09:03:29','2025-09-02 19:35:41',0,0),(143,'Comfy Trouser','',22,1899.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 09:03:29','2025-09-02 19:35:41',0,0),(144,'Comfy Trouser','',22,1899.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 09:03:29','2025-09-02 19:35:41',0,0),(145,'Comfy Trouser','',22,1899.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 09:03:29','2025-09-02 19:35:41',0,0),(146,'Comfy Trouser','',22,1899.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 09:03:29','2025-09-02 19:35:41',0,0),(147,'Comfy Trouser','',22,1899.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 09:03:29','2025-09-02 19:35:41',0,0),(148,'Comfy Trouser','',22,1899.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 09:03:29','2025-09-02 19:35:41',0,0),(149,'Comfy Trouser','',22,1899.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 09:03:29','2025-09-02 19:35:41',0,0),(150,'Comfy Trouser','',22,1899.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 09:03:29','2025-09-02 19:35:41',0,0),(151,'Sports Trouser','',23,1999.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 09:03:29','2025-09-02 19:36:04',0,0),(152,'Sports Trouser','',23,1999.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 09:03:29','2025-09-02 19:36:04',0,0),(153,'Sports Trouser','',23,1999.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 09:03:29','2025-09-02 19:36:04',0,0),(154,'Sports Trouser','',23,1999.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 09:03:29','2025-09-02 19:36:04',0,0),(155,'Sports Trouser','',23,1999.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 09:03:29','2025-09-02 19:36:04',0,0),(156,'Sports Trouser','',23,1999.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 09:03:29','2025-09-02 19:36:04',0,0),(157,'Sports Trouser','',23,1999.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 09:03:29','2025-09-02 19:36:04',0,0),(158,'Sports Trouser','',23,1999.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 09:03:29','2025-09-02 19:36:04',0,0),(159,'Sports Trouser','',23,1999.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 09:03:29','2025-09-02 19:36:04',0,0),(160,'Sports Trouser','',23,1999.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 09:03:29','2025-09-02 19:36:04',0,0),(161,'Sports Trouser','',23,1999.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 09:03:29','2025-09-02 19:36:04',0,0),(162,'Sports Trouser','',23,1999.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 09:03:29','2025-09-02 19:36:04',0,0),(163,'Sports Trouser','',23,1999.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 09:03:29','2025-09-02 19:36:04',0,0),(164,'Sports Trouser','',23,1999.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 09:03:29','2025-09-02 19:36:04',0,0),(165,'Sports Trouser','',23,1999.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 09:03:29','2025-09-02 19:36:04',0,0),(166,'Joggers','',20,799.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 09:03:29','2025-09-02 19:36:29',0,0),(167,'Joggers','',20,799.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 09:03:29','2025-09-02 19:36:29',0,0),(168,'Joggers','',20,799.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 09:03:29','2025-09-02 19:36:29',0,0),(169,'Joggers','',20,799.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 09:03:29','2025-09-02 19:36:29',0,0),(170,'Joggers','',20,799.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 09:03:29','2025-09-02 19:36:29',0,0),(171,'Joggers','',20,799.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 09:03:29','2025-09-02 19:36:29',0,0),(172,'Joggers','',20,799.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 09:03:29','2025-09-02 19:36:29',0,0),(173,'Joggers','',20,799.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 09:03:29','2025-09-02 19:36:29',0,0),(174,'Joggers','',20,799.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 09:03:29','2025-09-02 19:36:29',0,0),(175,'Joggers','',20,799.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 09:03:29','2025-09-02 19:36:29',0,0),(176,'Joggers','',20,799.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 09:03:29','2025-09-02 19:36:29',0,0),(177,'Joggers','',20,799.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 09:03:29','2025-09-02 19:36:29',0,0),(178,'Joggers','',20,799.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 09:03:29','2025-09-02 19:36:29',0,0),(179,'Joggers','',20,799.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 09:03:29','2025-09-02 19:36:29',0,0),(180,'Joggers','',20,799.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 09:03:29','2025-09-02 19:36:29',0,0),(181,'Socks','',26,899.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 09:03:29','2025-09-02 19:37:17',0,0),(182,'Socks','',26,899.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 09:03:29','2025-09-02 19:37:17',0,0),(183,'Socks','',26,899.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 09:03:29','2025-09-02 19:37:17',0,0),(184,'Socks','',26,899.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 09:03:29','2025-09-02 19:37:17',0,0),(185,'Socks','',26,899.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 09:03:29','2025-09-02 19:37:17',0,0),(186,'Socks','',26,899.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 09:03:29','2025-09-02 19:37:17',0,0),(187,'Socks','',26,899.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 09:03:29','2025-09-02 19:37:17',0,0),(188,'Socks','',26,899.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 09:03:29','2025-09-02 19:37:17',0,0),(189,'Socks','',26,899.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 09:03:29','2025-09-02 19:37:17',0,0),(190,'Socks','',26,899.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 09:03:29','2025-09-02 19:37:17',0,0),(191,'Socks','',26,899.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 09:03:29','2025-09-02 19:37:17',0,0),(192,'Socks','',26,899.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 09:03:29','2025-09-02 19:37:17',0,0),(193,'Socks','',26,899.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 09:03:29','2025-09-02 19:37:17',0,0),(194,'Socks','',26,899.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 09:03:29','2025-09-02 19:37:17',0,0),(195,'Socks','',26,899.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 09:03:29','2025-09-02 19:37:17',0,0),(196,'Mask','',4,299.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 09:03:29','2025-09-02 19:38:14',0,0),(197,'Mask','',4,299.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 09:03:29','2025-09-02 19:38:14',0,0),(198,'Mask','',4,299.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 09:03:29','2025-09-02 19:38:14',0,0),(199,'Mask','',4,299.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 09:03:29','2025-09-02 19:38:14',0,0),(200,'Mask','',4,299.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 09:03:29','2025-09-02 19:38:14',0,0),(201,'Mask','',4,299.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 09:03:29','2025-09-02 19:38:14',0,0),(202,'Mask','',4,299.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 09:03:29','2025-09-02 19:38:14',0,0),(203,'Mask','',4,299.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 09:03:29','2025-09-02 19:38:14',0,0),(204,'Mask','',4,299.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 09:03:29','2025-09-02 19:38:14',0,0),(205,'Mask','',4,299.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 09:03:29','2025-09-02 19:38:14',0,0),(206,'Mask','',4,299.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 09:03:29','2025-09-02 19:38:14',0,0),(207,'Mask','',4,299.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 09:03:29','2025-09-02 19:38:14',0,0),(208,'Mask','',4,299.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 09:03:29','2025-09-02 19:38:14',0,0),(209,'Mask','',4,299.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 09:03:29','2025-09-02 19:38:14',0,0),(210,'Mask','',4,299.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 09:03:29','2025-09-02 19:38:14',0,0),(211,'Belts','',76,399.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 09:03:29','2025-09-02 19:38:41',0,0),(212,'Belts','',76,399.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 09:03:29','2025-09-02 19:38:41',0,0),(213,'Belts','',76,399.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 09:03:29','2025-09-02 19:38:41',0,0),(214,'Belts','',76,399.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 09:03:29','2025-09-02 19:38:41',0,0),(215,'Belts','',76,399.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 09:03:29','2025-09-02 19:38:41',0,0),(216,'Belts','',76,399.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 09:03:29','2025-09-02 19:38:41',0,0),(217,'Belts','',76,399.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 09:03:29','2025-09-02 19:38:41',0,0),(218,'Belts','',76,399.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 09:03:29','2025-09-02 19:38:41',0,0),(219,'Belts','',76,399.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 09:03:29','2025-09-02 19:38:41',0,0),(220,'Belts','',76,399.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 09:03:29','2025-09-02 19:38:41',0,0),(221,'Belts','',76,399.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 09:03:29','2025-09-02 19:38:41',0,0),(222,'Belts','',76,399.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 09:03:29','2025-09-02 19:38:41',0,0),(223,'Belts','',76,399.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 09:03:29','2025-09-02 19:38:41',0,0),(224,'Belts','',76,399.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 09:03:29','2025-09-02 19:38:41',0,0),(225,'Belts','',76,399.00,'Small, Medium, Large, Extra Large',NULL,99,'PureWave','2025-08-29 09:03:29','2025-09-02 19:38:41',0,0);
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `refresh_tokens`
--

DROP TABLE IF EXISTS `refresh_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `refresh_tokens` (
  `token_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `token` varchar(500) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`token_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `refresh_tokens_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=66 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `refresh_tokens`
--

LOCK TABLES `refresh_tokens` WRITE;
/*!40000 ALTER TABLE `refresh_tokens` DISABLE KEYS */;
INSERT INTO `refresh_tokens` VALUES (1,1,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoxLCJlbWFpbCI6ImFybm9iMDA3QGdtYWlsLmNvbSIsImlhdCI6MTc1Njc0Mzg1MCwiZXhwIjoxNzU3MzQ4NjUwfQ.ekV30GJKG1aQEv_Tak28nRvOjRKBv4_Xa3HF50Wi750','2025-09-01 16:24:10'),(2,1,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoxLCJlbWFpbCI6ImFybm9iMDA3QGdtYWlsLmNvbSIsImlhdCI6MTc1Njc0NDEwMiwiZXhwIjoxNzU3MzQ4OTAyfQ.dh2or0wUQg6ico3vqDcWMeXJVJ70hjSqN0SnYWD0Paw','2025-09-01 16:28:22'),(3,1,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoxLCJlbWFpbCI6ImFybm9iMDA3QGdtYWlsLmNvbSIsImlhdCI6MTc1Njc0NDE0NCwiZXhwIjoxNzU3MzQ4OTQ0fQ.MQfiFvJf5s9EAIKNG3fLsnTFe2JgkREJhbviExZNjFA','2025-09-01 16:29:04'),(4,1,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoxLCJlbWFpbCI6ImFybm9iMDA3QGdtYWlsLmNvbSIsImlhdCI6MTc1Njc0NDI3MCwiZXhwIjoxNzU3MzQ5MDcwfQ.dGsAEqw0CZJpeJLsYwWC8o2ckXTLgMAcczjb25ANcmk','2025-09-01 16:31:10'),(5,1,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoxLCJlbWFpbCI6ImFybm9iMDA3QGdtYWlsLmNvbSIsImlhdCI6MTc1Njc0NDI3OSwiZXhwIjoxNzU3MzQ5MDc5fQ.r3a6D3nTU11SstLAe8TJg1E0uwhW2Jl77Qwzwac7ILc','2025-09-01 16:31:19'),(6,1,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoxLCJlbWFpbCI6ImFybm9iMDA3QGdtYWlsLmNvbSIsImlhdCI6MTc1Njc0NDMxMCwiZXhwIjoxNzU3MzQ5MTEwfQ.6_brbL6cftyMMQmWSnEUQxn7zE456DKnUBgLV5oMeis','2025-09-01 16:31:50'),(7,1,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoxLCJlbWFpbCI6ImFybm9iMDA3QGdtYWlsLmNvbSIsImlhdCI6MTc1Njc0NDMzMywiZXhwIjoxNzU3MzQ5MTMzfQ.Z5YasFycHfq7_vAHhCNouyTjapoq38niMu26PZHzr2Y','2025-09-01 16:32:13'),(8,1,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoxLCJlbWFpbCI6ImFybm9iMDA3QGdtYWlsLmNvbSIsImlhdCI6MTc1Njc0NDM0NCwiZXhwIjoxNzU3MzQ5MTQ0fQ.WAed1dbHjBd5aswTHxLJ7NhrqIbYyBOsJC-mFlc_ftU','2025-09-01 16:32:24'),(9,1,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoxLCJlbWFpbCI6ImFybm9iMDA3QGdtYWlsLmNvbSIsImlhdCI6MTc1Njc0NDUyMCwiZXhwIjoxNzU3MzQ5MzIwfQ.r-orAAS2dZABTkuVuP0-mKc_uUFSnQAj3FST_YyYNJ4','2025-09-01 16:35:20'),(10,1,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoxLCJlbWFpbCI6ImFybm9iMDA3QGdtYWlsLmNvbSIsImlhdCI6MTc1Njc0NDk2NCwiZXhwIjoxNzU3MzQ5NzY0fQ.W-I7_XnEynykw3SLXD9qBH7MnqhD3oIWRlh_G-IHRe8','2025-09-01 16:42:44'),(14,1,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoxLCJlbWFpbCI6ImFybm9iMDA3QGdtYWlsLmNvbSIsImlhdCI6MTc1Njc0NjAzNiwiZXhwIjoxNzU3MzUwODM2fQ.zNb-oP8vlKPAJTVz4e0mvMIa5UIN3LfefI_nS6_Faf8','2025-09-01 17:00:36'),(17,1,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoxLCJlbWFpbCI6ImFybm9iMDA3QGdtYWlsLmNvbSIsImlhdCI6MTc1Njc0NjI3MSwiZXhwIjoxNzU3MzUxMDcxfQ.mv75yRougBvN_kcLbk98YEa4aUmsmBc8y-Dx9H2bH9w','2025-09-01 17:04:31'),(19,1,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoxLCJlbWFpbCI6ImFybm9iMDA3QGdtYWlsLmNvbSIsImlhdCI6MTc1Njc0NjQ0OSwiZXhwIjoxNzU3MzUxMjQ5fQ.L6aIJK046aJgMzKD_EM1gho4Nm_8QyXbZZYlIIa0YyY','2025-09-01 17:07:29'),(21,1,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoxLCJlbWFpbCI6ImFybm9iMDA3QGdtYWlsLmNvbSIsImlhdCI6MTc1Njc0NjY2MCwiZXhwIjoxNzU3MzUxNDYwfQ.T398QgdzADtajLcMZ2kQxuOR4Ie78pMNKPjkAQORSQ4','2025-09-01 17:11:00'),(22,1,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoxLCJlbWFpbCI6ImFybm9iMDA3QGdtYWlsLmNvbSIsImlhdCI6MTc1Njc0Njg0NywiZXhwIjoxNzU3MzUxNjQ3fQ.MMOasVCOs-PJiB5KxJq7sgPQNjpdvPBpBuWmlA-xtBM','2025-09-01 17:14:07'),(23,1,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoxLCJlbWFpbCI6ImFybm9iMDA3QGdtYWlsLmNvbSIsImlhdCI6MTc1Njc0NzA2NywiZXhwIjoxNzU3MzUxODY3fQ.Qn6kFMlNmQtA9uxMMs_nWoKGJd9ZpQn3yJh9F6-Ifvw','2025-09-01 17:17:47'),(24,1,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoxLCJlbWFpbCI6ImFybm9iMDA3QGdtYWlsLmNvbSIsImlhdCI6MTc1Njc0NzEyMiwiZXhwIjoxNzU3MzUxOTIyfQ.uqYVwcP4C6yy7R-yAEOnkpUuveGVDHaQN6wiPOBtrMU','2025-09-01 17:18:42'),(25,1,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoxLCJlbWFpbCI6ImFybm9iMDA3QGdtYWlsLmNvbSIsImlhdCI6MTc1Njc0NzE2NywiZXhwIjoxNzU3MzUxOTY3fQ.5EvgisVXblISbO3dYpCRwzaP7QjG_Y5XQmkAlu3lyyI','2025-09-01 17:19:27'),(26,1,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoxLCJlbWFpbCI6ImFybm9iMDA3QGdtYWlsLmNvbSIsImlhdCI6MTc1Njc0NzI5NSwiZXhwIjoxNzU3MzUyMDk1fQ.Em9OB79CfFWHVl-d_3YVRmN8cWqsKWqQnbbpRuWiEQo','2025-09-01 17:21:35'),(27,1,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoxLCJlbWFpbCI6ImFybm9iMDA3QGdtYWlsLmNvbSIsImlhdCI6MTc1Njc0ODU4MywiZXhwIjoxNzU3MzUzMzgzfQ.ZsXAabCooN1zHcknHpKlQHbBNMqatCK7UD4KjYbps-0','2025-09-01 17:43:03'),(28,1,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoxLCJlbWFpbCI6ImFybm9iMDA3QGdtYWlsLmNvbSIsImlhdCI6MTc1Njc1NzMyNywiZXhwIjoxNzU3MzYyMTI3fQ.Xw9_Fk3w2s_BUGR3NiHm7lnrzax8bfyS3i4xfbVjVfU','2025-09-01 20:08:47'),(29,1,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoxLCJlbWFpbCI6ImFybm9iMDA3QGdtYWlsLmNvbSIsImlhdCI6MTc1Njc1Nzc4OSwiZXhwIjoxNzU3MzYyNTg5fQ.QnKlwWuDhXyEQ0WngiZrmakSLQfrxQOW0Uqov_3C4lo','2025-09-01 20:16:29'),(32,1,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoxLCJlbWFpbCI6ImFybm9iMDA3QGdtYWlsLmNvbSIsImlhdCI6MTc1Njc4MTAxMiwiZXhwIjoxNzU3Mzg1ODEyfQ.DYEtoTYkayZYGhJQGNpBgJ1H1PRIw4i1iEeC6QZS8l4','2025-09-02 02:43:32'),(33,1,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoxLCJlbWFpbCI6ImFybm9iMDA3QGdtYWlsLmNvbSIsImlhdCI6MTc1Njc4MTUyNiwiZXhwIjoxNzU3Mzg2MzI2fQ.wVrnDr9zm3JleWElrnS4Awy1qpkbTy7NHarBb-MSgKw','2025-09-02 02:52:06'),(34,1,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoxLCJlbWFpbCI6ImFybm9iMDA3QGdtYWlsLmNvbSIsImlhdCI6MTc1Njc4MTU0OSwiZXhwIjoxNzU3Mzg2MzQ5fQ.aEQB1ElOe39ZmLTWwcNUQWKZyL_Hw2JZNJuncpwFlts','2025-09-02 02:52:29'),(35,1,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoxLCJlbWFpbCI6ImFybm9iMDA3QGdtYWlsLmNvbSIsImlhdCI6MTc1Njc4MTk2OCwiZXhwIjoxNzU3Mzg2NzY4fQ.d0LGzjZRQvH_Sp0b46YkjQVnL8RD6jjgONiCPgqt3vM','2025-09-02 02:59:28'),(36,1,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoxLCJlbWFpbCI6ImFybm9iMDA3QGdtYWlsLmNvbSIsImlhdCI6MTc1Njc4MjI3MCwiZXhwIjoxNzU3Mzg3MDcwfQ.TDjv3otp5GAgt1qc6BiBeErNEDjCxwylZ0o--A84poA','2025-09-02 03:04:30'),(37,1,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoxLCJlbWFpbCI6ImFybm9iMDA3QGdtYWlsLmNvbSIsImlhdCI6MTc1Njc5OTYxNiwiZXhwIjoxNzU3NDA0NDE2fQ.XjzTy8uCuVtJWiZxf_QB0fBjPO9NuJTmpDUA6BiCQv0','2025-09-02 07:53:36'),(38,1,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoxLCJlbWFpbCI6ImFybm9iMDA3QGdtYWlsLmNvbSIsImlhdCI6MTc1Njc5OTcwNywiZXhwIjoxNzU3NDA0NTA3fQ.2_kRQcAGNL4wAMh-U-ey2jD2Osgckw6wj_UPT3w2dlw','2025-09-02 07:55:07'),(39,1,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoxLCJlbWFpbCI6ImFybm9iMDA3QGdtYWlsLmNvbSIsImlhdCI6MTc1Njc5OTg4MiwiZXhwIjoxNzU3NDA0NjgyfQ.RYzpq1wcPjGxwC8cv2FoF0QEiwRiJXpEbZGgJAQY7K8','2025-09-02 07:58:02'),(40,1,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoxLCJlbWFpbCI6ImFybm9iMDA3QGdtYWlsLmNvbSIsImlhdCI6MTc1NjkwMTcxMiwiZXhwIjoxNzU3NTA2NTEyfQ.C6EnvIU3jLqTVzesB3H3kbebw8z5ML7d0zT_CEgaHyo','2025-09-03 12:15:12'),(41,1,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoxLCJlbWFpbCI6ImFybm9iMDA3QGdtYWlsLmNvbSIsImlhdCI6MTc1NjkwMTg1MiwiZXhwIjoxNzU3NTA2NjUyfQ.uyx6q8KfYOVSU4K7h-DeKnTbJg7jvqDymXbkpeJoX5s','2025-09-03 12:17:32'),(42,1,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoxLCJlbWFpbCI6ImFybm9iMDA3QGdtYWlsLmNvbSIsImlhdCI6MTc1NjkwMjg0NSwiZXhwIjoxNzU3NTA3NjQ1fQ.zhJvw2bcudzanomStSs3oGv2QzheTiZuIwGnaCli-Hk','2025-09-03 12:34:05'),(45,1,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoxLCJlbWFpbCI6ImFybm9iMDA3QGdtYWlsLmNvbSIsImlhdCI6MTc1Njk3Njc3NiwiZXhwIjoxNzU3NTgxNTc2fQ.oaQvOZMTb9yHip6eh-gqaqalegwQcx_8WkuahyoC7N4','2025-09-04 09:06:16'),(46,1,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoxLCJlbWFpbCI6ImFybm9iMDA3QGdtYWlsLmNvbSIsImlhdCI6MTc1NzAxMDE4NywiZXhwIjoxNzU3NjE0OTg3fQ.uRZjmlqrL6NqDo7aNPfHXXIUUVGCUWLvaaIG3nQZViw','2025-09-04 18:23:07'),(47,1,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoxLCJlbWFpbCI6ImFybm9iMDA3QGdtYWlsLmNvbSIsImlhdCI6MTc1NzAxMDU3NiwiZXhwIjoxNzU3NjE1Mzc2fQ.1cT5jOhYHTHv5mXAsOta0xRDXRO4ZzKZoIVBfxAqV40','2025-09-04 18:29:36'),(48,1,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoxLCJlbWFpbCI6ImFybm9iMDA3QGdtYWlsLmNvbSIsImlhdCI6MTc1NzM4NjUzNywiZXhwIjoxNzU3OTkxMzM3fQ.I5VBcR3H7hgzoMT0yWOqbxiBnGtAHAFLOcaMQudSPp4','2025-09-09 02:55:37'),(49,1,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoxLCJlbWFpbCI6ImFybm9iMDA3QGdtYWlsLmNvbSIsImlhdCI6MTc1NzM4NzYwNCwiZXhwIjoxNzU3OTkyNDA0fQ.EwxbJsUVT0uK8aWCBoXENSgPHsAPHwiU4dO9ha7C1HU','2025-09-09 03:13:24'),(50,1,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoxLCJlbWFpbCI6ImFybm9iMDA3QGdtYWlsLmNvbSIsImlhdCI6MTc1NzM4OTI3OCwiZXhwIjoxNzU3OTk0MDc4fQ.GJ9ZMxGxYa57iZLrNwKIU1733njo3P2vuTOOSm5ldLM','2025-09-09 03:41:18'),(51,1,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoxLCJlbWFpbCI6ImFybm9iMDA3QGdtYWlsLmNvbSIsImlhdCI6MTc1NzM5MjQyNywiZXhwIjoxNzU3OTk3MjI3fQ.XrH_C5P96-SMT49nYl7x3RQRl7OIMunKA2dfmvDYpJk','2025-09-09 04:33:47'),(53,1,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoxLCJlbWFpbCI6ImFybm9iMDA3QGdtYWlsLmNvbSIsImlhdCI6MTc1NzQwOTA2MCwiZXhwIjoxNzU4MDEzODYwfQ.PUpkhjn5nc-s1LGjMyJ1Xwl1VWNU5j7iwQlYWQ0zFSY','2025-09-09 09:11:00'),(54,1,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoxLCJlbWFpbCI6ImFybm9iMDA3QGdtYWlsLmNvbSIsImlhdCI6MTc1NzQyNzMxMCwiZXhwIjoxNzU4MDMyMTEwfQ.IHacwnqzdOoGz9rQ1kWHcK0md0bi-kMsfzqgRItv4ic','2025-09-09 14:15:10'),(55,1,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoxLCJlbWFpbCI6ImFybm9iMDA3QGdtYWlsLmNvbSIsImlhdCI6MTc1NzUxMjQxNCwiZXhwIjoxNzU4MTE3MjE0fQ.ZT9BCSUFyold2xRftsjymplo551b2Ly89BOCyAsI_kE','2025-09-10 13:53:34'),(56,1,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoxLCJlbWFpbCI6ImFybm9iMDA3QGdtYWlsLmNvbSIsImlhdCI6MTc1NzUxMjQ2NSwiZXhwIjoxNzU4MTE3MjY1fQ.uiiZ-r-7feZ70BjWngFS1uiME8D_WY_Dp8r_UnAeHgg','2025-09-10 13:54:25'),(57,1,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoxLCJlbWFpbCI6ImFybm9iMDA3QGdtYWlsLmNvbSIsImlhdCI6MTc1OTI1MDc4MSwiZXhwIjoxNzU5ODU1NTgxfQ.LamP9P-h93bM27xFYQCc6eR37yZly1mB2n8nO62Xybo','2025-09-30 16:46:21'),(58,1,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoxLCJlbWFpbCI6ImFybm9iMDA3QGdtYWlsLmNvbSIsImlhdCI6MTc1OTQwODcyNSwiZXhwIjoxNzYwMDEzNTI1fQ.D6tbkaMVgAqe58MB6_A3SyCFcSYWz-va62WMkSy2CxI','2025-10-02 12:38:45'),(59,24,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoyNCwiZW1haWwiOiJuYXNpbUBnbWFpbC5jb20iLCJpYXQiOjE3NTk0MDg3NzUsImV4cCI6MTc2MDAxMzU3NX0.ATYGyJEbGuSzbuwoNnuRWIv3WbGHCrE8qZ0FrflYXC4','2025-10-02 12:39:35'),(60,24,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoyNCwiZW1haWwiOiJuYXNpbUBnbWFpbC5jb20iLCJpYXQiOjE3NTk0MDg3OTEsImV4cCI6MTc2MDAxMzU5MX0.y45vs3sfE4QHlNcOgTIddskyOhVme55dS8qFKm3y1oI','2025-10-02 12:39:51'),(61,1,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoxLCJlbWFpbCI6ImFybm9iMDA3QGdtYWlsLmNvbSIsImlhdCI6MTc1OTQwOTY5NywiZXhwIjoxNzYwMDE0NDk3fQ._DfPOz_k54VwwGnYYVOhdSeNspEkje4xcgwReK7E1As','2025-10-02 12:54:57'),(62,1,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoxLCJlbWFpbCI6ImFybm9iMDA3QGdtYWlsLmNvbSIsImlhdCI6MTc1OTc0NTU0OCwiZXhwIjoxNzYwMzUwMzQ4fQ.spNytEKUUybFByRRQyhuVbIedZQp1uzuPVVwxK6lTOk','2025-10-06 10:12:28'),(63,1,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoxLCJlbWFpbCI6ImFybm9iMDA3QGdtYWlsLmNvbSIsImlhdCI6MTc1OTgxNTc4MSwiZXhwIjoxNzYwNDIwNTgxfQ.2gi5XJkfqsUregBVcqPZKCCBQReUVostJsJETpMscbo','2025-10-07 05:43:01'),(64,1,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoxLCJlbWFpbCI6ImFybm9iMDA3QGdtYWlsLmNvbSIsImlhdCI6MTc1OTgzMjI3OSwiZXhwIjoxNzYwNDM3MDc5fQ.J-H7VnWZsqRrdf2BocMYabZyVdiV0jMx9KQTh8NWyfU','2025-10-07 10:17:59'),(65,24,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoyNCwiZW1haWwiOiJuYXNpbUBnbWFpbC5jb20iLCJpYXQiOjE3NTk4NTkyNDksImV4cCI6MTc2MDQ2NDA0OX0.Z4DaA4X552m7h-bsToZg1mZBxxwUptZWlYicLCAVq4o','2025-10-07 17:47:29');
/*!40000 ALTER TABLE `refresh_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `returns`
--

DROP TABLE IF EXISTS `returns`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `returns` (
  `return_id` int NOT NULL AUTO_INCREMENT,
  `order_item_id` int NOT NULL,
  `user_id` int NOT NULL,
  `reason` text NOT NULL,
  `status` enum('requested','approved','rejected','refunded') DEFAULT 'requested',
  `requested_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `processed_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`return_id`),
  KEY `order_item_id` (`order_item_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `returns_ibfk_1` FOREIGN KEY (`order_item_id`) REFERENCES `order_items` (`order_item_id`) ON DELETE CASCADE,
  CONSTRAINT `returns_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `returns`
--

LOCK TABLES `returns` WRITE;
/*!40000 ALTER TABLE `returns` DISABLE KEYS */;
/*!40000 ALTER TABLE `returns` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reviews`
--

DROP TABLE IF EXISTS `reviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reviews` (
  `review_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `product_id` int DEFAULT NULL,
  `rating` int DEFAULT NULL,
  `comment` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`review_id`),
  KEY `user_id` (`user_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `reviews_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  CONSTRAINT `reviews_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`),
  CONSTRAINT `reviews_chk_1` CHECK (((`rating` >= 1) and (`rating` <= 5)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reviews`
--

LOCK TABLES `reviews` WRITE;
/*!40000 ALTER TABLE `reviews` DISABLE KEYS */;
/*!40000 ALTER TABLE `reviews` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `settings`
--

DROP TABLE IF EXISTS `settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `settings` (
  `id` int NOT NULL DEFAULT '1',
  `currency` varchar(10) DEFAULT 'USD',
  `shipping` varchar(255) DEFAULT NULL,
  `tax_rate` decimal(5,2) DEFAULT '0.00',
  `product_availability` enum('enabled','disabled') DEFAULT 'enabled',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `settings`
--

LOCK TABLES `settings` WRITE;
/*!40000 ALTER TABLE `settings` DISABLE KEYS */;
/*!40000 ALTER TABLE `settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shipping`
--

DROP TABLE IF EXISTS `shipping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `shipping` (
  `shipping_id` int NOT NULL AUTO_INCREMENT,
  `order_id` int DEFAULT NULL,
  `courier_name` varchar(100) DEFAULT NULL,
  `tracking_number` varchar(100) DEFAULT NULL,
  `status` enum('processing','in transit','delivered','returned') DEFAULT 'processing',
  `estimated_delivery_date` date DEFAULT NULL,
  `delivered_date` date DEFAULT NULL,
  PRIMARY KEY (`shipping_id`),
  KEY `order_id` (`order_id`),
  CONSTRAINT `shipping_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shipping`
--

LOCK TABLES `shipping` WRITE;
/*!40000 ALTER TABLE `shipping` DISABLE KEYS */;
/*!40000 ALTER TABLE `shipping` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `super_admins`
--

DROP TABLE IF EXISTS `super_admins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `super_admins` (
  `superadmin_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`superadmin_id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `super_admins`
--

LOCK TABLES `super_admins` WRITE;
/*!40000 ALTER TABLE `super_admins` DISABLE KEYS */;
INSERT INTO `super_admins` VALUES (1,'Arnob Hasan Sabit','arnob007@gmil.com','$2b$10$akvFEH4Via9tlpkgSRV5Ve9f3zU4uaMlAWJqV8Hw2fYwqbgVsPlF6','2025-08-30 05:56:03','2025-08-31 20:28:51');
/*!40000 ALTER TABLE `super_admins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_activities`
--

DROP TABLE IF EXISTS `user_activities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_activities` (
  `activity_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `user_name` varchar(100) DEFAULT NULL,
  `event` varchar(255) DEFAULT NULL,
  `activity_time` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`activity_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `user_activities_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_activities`
--

LOCK TABLES `user_activities` WRITE;
/*!40000 ALTER TABLE `user_activities` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_activities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_logins`
--

DROP TABLE IF EXISTS `user_logins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_logins` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `user_name` varchar(255) DEFAULT NULL,
  `login_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `user_logins_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=84 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_logins`
--

LOCK TABLES `user_logins` WRITE;
/*!40000 ALTER TABLE `user_logins` DISABLE KEYS */;
INSERT INTO `user_logins` VALUES (36,1,'Arnob Hasan Sabit','2025-09-01 16:32:13','::1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36'),(37,1,'Arnob Hasan Sabit','2025-09-01 16:32:24','::1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36'),(38,1,'Arnob Hasan Sabit','2025-09-01 16:35:20','::1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36'),(39,1,'Arnob Hasan Sabit','2025-09-01 16:42:44','::1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36'),(40,1,'Arnob Hasan Sabit','2025-09-01 17:00:36','::1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36'),(41,1,'Arnob Hasan Sabit','2025-09-01 17:04:31','::1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36'),(42,1,'Arnob Hasan Sabit','2025-09-01 17:07:29','::1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36'),(43,1,'Arnob Hasan Sabit','2025-09-01 17:11:00','::1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36'),(44,1,'Arnob Hasan Sabit','2025-09-01 17:14:07','::1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36'),(45,1,'Arnob Hasan Sabit','2025-09-01 17:17:47','::1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36'),(46,1,'Arnob Hasan Sabit','2025-09-01 17:18:42','::1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36'),(47,1,'Arnob Hasan Sabit','2025-09-01 17:19:27','::1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36'),(48,1,'Arnob Hasan Sabit','2025-09-01 17:21:35','::1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36'),(49,1,'Arnob Hasan Sabit','2025-09-01 17:43:03','::1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36'),(50,1,'Arnob Hasan Sabit','2025-09-01 20:08:47','::1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36'),(51,1,'Arnob Hasan Sabit','2025-09-01 20:16:29','::1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36'),(53,1,'Arnob Hasan Sabit','2025-09-02 02:43:32','::1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36'),(54,1,'Arnob Hasan Sabit','2025-09-02 02:52:06','::1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36'),(55,1,'Arnob Hasan Sabit','2025-09-02 02:52:29','::1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36'),(56,1,'Arnob Hasan Sabit','2025-09-02 02:59:27','::1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36'),(57,1,'Arnob Hasan Sabit','2025-09-02 03:04:30','::1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36'),(58,1,'Arnob Hasan Sabit','2025-09-02 07:53:36','::1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36'),(59,1,'Arnob Hasan Sabit','2025-09-02 07:55:07','::1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36'),(60,1,'Arnob Hasan Sabit','2025-09-02 07:58:02','::1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36'),(61,1,'Arnob Hasan Sabit','2025-09-03 12:15:12','::1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36'),(62,1,'Arnob Hasan Sabit','2025-09-03 12:17:32','::1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36'),(63,1,'Arnob Hasan Sabit','2025-09-03 12:34:05','::1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36'),(65,1,'Arnob Hasan Sabit','2025-09-04 09:06:16','::1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36'),(66,1,'Arnob Hasan Sabit','2025-09-04 18:23:07','::1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36'),(67,1,'Arnob Hasan Sabit','2025-09-04 18:29:36','::1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36'),(68,1,'Arnob Hasan Sabit','2025-09-09 02:55:37','::1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36'),(69,1,'Arnob Hasan Sabit','2025-09-09 03:13:24','::1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36'),(70,1,'Arnob Hasan Sabit','2025-09-09 03:41:18','::1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36'),(71,1,'Arnob Hasan Sabit','2025-09-09 04:33:47','::1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36'),(72,1,'Arnob Hasan Sabit','2025-09-09 09:11:00','::1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36'),(73,1,'Arnob Hasan Sabit','2025-09-09 14:15:10','::1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36'),(74,1,'Arnob Hasan Sabit','2025-09-10 13:53:34','::1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36'),(75,1,'Arnob Hasan Sabit','2025-09-10 13:54:25','::1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36'),(76,1,'Arnob Hasan Sabit','2025-09-30 16:46:21','::1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36'),(77,1,'Arnob Hasan Sabit','2025-10-02 12:38:45','::1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36'),(78,24,'Nasim Khan Milon','2025-10-02 12:39:51','::1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36'),(79,1,'Arnob Hasan Sabit','2025-10-02 12:54:57','::1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36'),(80,1,'Arnob Hasan Sabit','2025-10-06 10:12:28','::1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36'),(81,1,'Arnob Hasan Sabit','2025-10-07 05:43:01','::1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36'),(82,1,'Arnob Hasan Sabit','2025-10-07 10:17:59','::1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36'),(83,24,'Nasim Khan Milon','2025-10-07 17:47:29','::1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36');
/*!40000 ALTER TABLE `user_logins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT 'Unknown',
  `email` varchar(150) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `last_login` timestamp NULL DEFAULT NULL,
  `login_count` int DEFAULT '0',
  `role` enum('Customer','Admin','SuperAdmin') DEFAULT 'Customer',
  `vip` tinyint(1) DEFAULT '0',
  `force_reset` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Arnob Hasan Sabit','arnob007@gmail.com','$2b$10$LJIAw77egOgFX1iHUd5/uevuNQsUMMyFt5J11DPhbP/bW9/9SuQJW','01639825039','2025-09-01 08:13:08','2025-10-07 10:17:59',0,'SuperAdmin',0,1),(24,'Nasim Khan Milon','nasim@gmail.com','$2b$10$LXguT91C.SuGipFGfGueSefWagT8qAKFUH5Sh.jUOqeBiaTLzoloW','+88001639825039','2025-10-02 12:39:35','2025-10-07 17:47:29',0,'Customer',0,0);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wishlist`
--

DROP TABLE IF EXISTS `wishlist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wishlist` (
  `wishlist_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `product_id` int DEFAULT NULL,
  `added_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`wishlist_id`),
  KEY `user_id` (`user_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `wishlist_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  CONSTRAINT `wishlist_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wishlist`
--

LOCK TABLES `wishlist` WRITE;
/*!40000 ALTER TABLE `wishlist` DISABLE KEYS */;
/*!40000 ALTER TABLE `wishlist` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-10-08 13:56:22
