CREATE DATABASE  IF NOT EXISTS `socnet` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `socnet`;
-- MySQL dump 10.13  Distrib 5.6.17, for Win64 (x86_64)
--
-- Host: localhost    Database: socnet
-- ------------------------------------------------------
-- Server version	5.6.21-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `profiles`
--

DROP TABLE IF EXISTS `profiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `profiles` (
  `id` int(11) NOT NULL,
  `first_name` varchar(45) DEFAULT NULL,
  `last_name` varchar(45) DEFAULT NULL,
  `photo` varchar(255) DEFAULT NULL,
  `sex` int(1) DEFAULT '1',
  `birthday` date DEFAULT NULL,
  `country` varchar(45) DEFAULT NULL,
  `city` varchar(45) DEFAULT NULL,
  `about` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profiles`
--

LOCK TABLES `profiles` WRITE;
/*!40000 ALTER TABLE `profiles` DISABLE KEYS */;
INSERT INTO `profiles` VALUES (1,'Me','User','1.png',0,'1993-09-22','Russia','Moscow','ano ano ano ano ano ano ano ano ano ano ano ano ano ano ano ano ano ano ano ano ano ano ano ano ano ano ano ano ano ano ano ano ano ano ano ano ano ano ano ano ano ano ano ano ano ano ano ano ano ano ano ano ano ano ano ano ano ano ano ano ano ano ano ano '),(2,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL),(3,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL),(4,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL),(5,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL),(6,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL),(7,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL),(8,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL),(9,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL),(10,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `profiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `login` varchar(60) NOT NULL,
  `password` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  UNIQUE KEY `login_UNIQUE` (`login`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'jekatigr','0abf0076ec5f741db3189885a9acca6b'),(2,'non','ce483b04437e69dc607ff0c73de71644'),(3,'tempor','255287d42d3a1261f6e8981ae236136d'),(4,'luctus','d50afe1523a411a88655de23e2e309e9'),(5,'luctus1','08fe85e539f2b3c02ca68096c70d0b1f'),(6,'consequat','daaf59c65a9660dd02a8b1a345e96096'),(7,'ultricies','baa100d5d66f9aadb19c3a53939fc98a'),(8,'vitae','127e8604d05126d20143c6f78c33ca40'),(9,'quam','eebc69c9cd5ff2d3e8cad2d82e9a05e0'),(10,'ante','45a80dd1c1293d06857cc69a1543d7a3');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-03-28  2:25:33
