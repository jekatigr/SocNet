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
-- Table structure for table `chats`
--

DROP TABLE IF EXISTS `chats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `chats` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `chat_owner` int(11) DEFAULT NULL,
  `is_group` int(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chats`
--

LOCK TABLES `chats` WRITE;
/*!40000 ALTER TABLE `chats` DISABLE KEYS */;
INSERT INTO `chats` VALUES (1,35,0),(2,1,1),(3,1,1),(4,4,0),(5,4,1);
/*!40000 ALTER TABLE `chats` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `messages`
--

DROP TABLE IF EXISTS `messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` datetime DEFAULT NULL,
  `utc_id` int(11) DEFAULT NULL,
  `text` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `messages`
--

LOCK TABLES `messages` WRITE;
/*!40000 ALTER TABLE `messages` DISABLE KEYS */;
INSERT INTO `messages` VALUES (1,'2015-06-11 19:22:26',1,'Hi'),(2,'2015-06-11 19:28:19',1,'Hello! How are you?'),(3,'2015-06-11 19:29:21',2,'I am fine!'),(4,'2015-06-11 19:29:38',1,'good'),(5,'2015-06-11 19:33:01',3,'Мне кажется, или тут одни животные?'),(6,'2015-06-11 19:33:21',11,'Да не, не может быть'),(7,'2015-06-11 19:33:57',9,'Сейчас добавлю сюда коалу'),(8,'2015-06-11 19:47:58',13,'привет'),(9,'2015-06-11 19:48:12',14,'прив'),(10,'2015-06-11 19:52:05',10,'ok'),(11,'2015-06-11 19:52:16',12,'я тут'),(12,'2015-06-11 19:52:36',12,'как дела?'),(13,'2015-06-11 19:55:00',12,'у меня норм'),(14,'2015-06-11 19:55:39',15,'ща коалу добавлю'),(15,'2015-06-11 19:56:47',19,'я и тут есть'),(16,'2015-06-11 19:56:57',15,'ага');
/*!40000 ALTER TABLE `messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `posts`
--

DROP TABLE IF EXISTS `posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `posts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `author_id` int(11) DEFAULT NULL,
  `receiver_id` int(11) DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `text` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `posts`
--

LOCK TABLES `posts` WRITE;
/*!40000 ALTER TABLE `posts` DISABLE KEYS */;
INSERT INTO `posts` VALUES (1,35,1,'2015-06-11 19:15:40','You are an animal! ');
/*!40000 ALTER TABLE `posts` ENABLE KEYS */;
UNLOCK TABLES;

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
  `birthday` date DEFAULT NULL,
  `country` varchar(45) DEFAULT NULL,
  `city` varchar(45) DEFAULT NULL,
  `about` text,
  `position` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profiles`
--

LOCK TABLES `profiles` WRITE;
/*!40000 ALTER TABLE `profiles` DISABLE KEYS */;
INSERT INTO `profiles` VALUES (1,'Dolphin','Livingston','1.jpg','2031-12-15','Liechtenstein','Louveign','est tempor bibendum. Donec felis orci, adipiscing non, luctus sit amet, faucibus ut, nulla. Cras eu tellus eu augue porttitor interdum.','Tech Support'),(2,'Rhino','Bradley','2.jpg','2027-09-14','Chad','Torre Cajetani','tempus non, lacinia at, iaculis quis, pede. Praesent eu dui. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Aenean eget magna. Suspendisse tristique neque venenatis lacus. Etiam bibendum fermentum metus. Aenean sed pede nec ante blandit viverra. Donec tempus, lorem fringilla ornare placerat, orci','Web Developer'),(3,'Leopard','Wong','3.jpg','2022-07-14','Antigua and Barbuda','San Rafael','ante blandit viverra. Donec tempus, lorem fringilla ornare placerat, orci lacus vestibulum lorem, sit amet ultricies sem magna nec quam. Curabitur vel lectus. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur','Advertising Manager'),(4,'Cat','Guerra','4.jpg','2027-01-15','Czech Republic','Esneux','felis ullamcorper viverra. Maecenas iaculis aliquet diam. Sed diam lorem, auctor quis, tristique ac, eleifend vitae, erat. Vivamus nisi. Mauris nulla. Integer urna. Vivamus molestie dapibus ligula. Aliquam erat volutpat. Nulla dignissim. Maecenas ornare egestas ligula. Nullam feugiat placerat velit. Quisque varius. Nam porttitor scelerisque neque. Nullam nisl. Maecenas malesuada','Marketing Manager'),(5,'Dog','Mcintyre','5.jpg','2023-02-16','Saint Barthelemy','Monteu Roero','In at pede. Cras vulputate velit eu sem. Pellentesque ut ipsum ac mi eleifend egestas. Sed pharetra, felis eget varius ultrices, mauris ipsum porta elit, a feugiat tellus lorem','Payroll Manager'),(6,'Elephant','Beard','6.jpg','2026-06-15','Mozambique','Saint-Sebastien-sur-Loire','erat nonummy ultricies ornare, elit elit fermentum risus, at fringilla purus mauris a nunc. In at pede. Cras vulputate velit eu sem. Pellentesque ut ipsum ac mi eleifend egestas. Sed pharetra, felis eget varius ultrices, mauris ipsum porta elit, a feugiat tellus lorem eu metus. In lorem. Donec elementum,','Quality Assurance Manager'),(7,'Horse','Herring','7.jpg','2018-12-14','Kyrgyzstan','Tarbes','Nulla tempor augue ac ipsum. Phasellus vitae mauris sit amet lorem semper auctor. Mauris vel turpis. Aliquam adipiscing lobortis risus. In mi pede, nonummy ut, molestie','Customer Manager'),(8,'Monkey','Melton','8.jpg','2022-04-16','El Salvador','Waasmunster','at lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada id, erat. Etiam vestibulum massa rutrum magna. Cras convallis convallis dolor. Quisque tincidunt pede ac urna. Ut tincidunt vehicula risus. Nulla eget metus eu erat semper rutrum.','Java Developer'),(9,'Bird','Alvarez','9.jpg','2030-09-14','Saint Lucia','Termoli','lacus pede sagittis augue, eu tempor erat neque non quam. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Aliquam fringilla cursus purus. Nullam scelerisque neque sed sem egestas blandit. Nam','Marketing Manager'),(10,'Bear','Vazquez','10.jpg','2014-04-15','Cook Islands','Musselburgh','Duis gravida. Praesent eu nulla at sem molestie sodales. Mauris blandit enim consequat purus. Maecenas libero est, congue a, aliquet vel, vulputate','Advertising Manager'),(11,'Ape','Patel','11.jpg','2013-09-14','Niger','Notre-Dame-de-la-Salette','leo. Morbi neque tellus, imperdiet non, vestibulum nec, euismod in, dolor. Fusce feugiat. Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aliquam auctor, velit eget laoreet posuere, enim nisl elementum purus, accumsan interdum','Payroll Manager'),(12,'Worm','Wooten','12.jpg','2025-12-15','Algeria','Alvito','natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec dignissim magna a tortor. Nunc commodo auctor velit. Aliquam nisl. Nulla eu neque pellentesque massa lobortis ultrices. Vivamus rhoncus. Donec est. Nunc ullamcorper, velit in aliquet lobortis, nisi','Sales Manager'),(13,'Dinosaur','Riddle','13.jpg','2016-10-14','Falkland Islands','Pitt Meadows','vel, faucibus id, libero. Donec consectetuer mauris id sapien. Cras dolor dolor, tempus non, lacinia at, iaculis quis, pede. Praesent eu dui. Cum sociis natoque penatibus et magnis','Advertising Manager'),(14,'Pterosaur','Paul','14.jpg','2022-07-15','Sierra Leone','Dunoon','urna suscipit nonummy. Fusce fermentum fermentum arcu. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Phasellus ornare. Fusce mollis. Duis sit amet diam eu dolor egestas rhoncus. Proin nisl sem,','Customer Manager'),(15,'Snake','Holman','15.jpg','2015-05-16','Bahamas','Snellegem','ac nulla. In tincidunt congue turpis. In condimentum. Donec at arcu. Vestibulum ante ipsum primis in faucibus orci luctus et','Advertising Manager'),(16,'Reptile','Ball','16.jpg','2030-05-16','Switzerland','South Perth','erat. Sed nunc est, mollis non, cursus non, egestas a, dui. Cras pellentesque. Sed dictum. Proin eget odio. Aliquam vulputate ullamcorper magna. Sed eu eros. Nam consequat dolor vitae dolor. Donec fringilla. Donec feugiat metus sit amet ante. Vivamus non lorem vitae','Finance Manager'),(17,'Bison','Hopper','17.jpg','2014-10-15','Brunei','Crieff','vitae risus. Duis a mi fringilla mi lacinia mattis. Integer eu lacus. Quisque imperdiet, erat nonummy ultricies ornare, elit elit fermentum risus, at fringilla purus mauris a nunc.','Java Developer'),(18,'Ant','French','18.jpg','2004-12-15','Austria','Milton Keynes','et ultrices posuere cubilia Curae; Phasellus ornare. Fusce mollis. Duis sit amet diam eu dolor egestas rhoncus. Proin nisl sem, consequat nec, mollis vitae, posuere at, velit. Cras lorem lorem, luctus ut, pellentesque eget, dictum placerat, augue. Sed molestie. Sed id risus quis diam luctus lobortis.','Quality Assurance Manager'),(19,'Duck','Beasley','19.jpg','2015-04-15','Niger','Louisville','taciti sociosqu ad litora torquent per conubia nostra, per inceptos hymenaeos. Mauris ut quam vel sapien imperdiet ornare. In faucibus. Morbi vehicula. Pellentesque tincidunt tempus risus. Donec egestas.','Java Developer'),(20,'Beetle','Bryan','20.jpg','2017-07-15','Argentina','Cromer','Integer in magna. Phasellus dolor elit, pellentesque a, facilisis non, bibendum sed, est. Nunc laoreet lectus quis massa. Mauris vestibulum, neque sed dictum eleifend, nunc','Java Developer'),(21,'Cow','Merrill','21.jpg','2020-04-15','Chile','Subiaco','consectetuer euismod est arcu ac orci. Ut semper pretium neque. Morbi quis urna. Nunc quis arcu vel quam dignissim pharetra. Nam ac nulla. In tincidunt congue turpis. In condimentum. Donec','Customer Manager'),(22,'Coyote','Warner','22.jpg','2029-01-15','Qatar','Yellowknife','sodales at, velit. Pellentesque ultricies dignissim lacus. Aliquam rutrum lorem ac risus. Morbi metus. Vivamus euismod urna. Nullam lobortis quam a felis ullamcorper viverra. Maecenas iaculis aliquet diam. Sed diam lorem, auctor quis, tristique ac, eleifend vitae, erat. Vivamus nisi. Mauris nulla.','Marketing Manager'),(23,'Wolf','Dorsey','23.jpg','2016-07-15','Cayman Islands','Shrewsbury','urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada id, erat. Etiam vestibulum massa rutrum magna. Cras convallis convallis dolor. Quisque tincidunt pede ac urna. Ut tincidunt vehicula risus. Nulla eget metus eu erat semper rutrum. Fusce dolor','Customer Manager'),(24,'Fox','Cooley','24.jpg','2012-07-14','Bolivia','Asnieres-sur-Seine','mauris, rhoncus id, mollis nec, cursus a, enim. Suspendisse aliquet, sem ut cursus luctus, ipsum leo elementum sem, vitae aliquam eros turpis','Customer Manager'),(25,'Goat','Norton','25.jpg','2008-02-16','Vanuatu','Polcenigo','Curabitur dictum. Phasellus in felis. Nulla tempor augue ac ipsum. Phasellus vitae mauris sit amet lorem semper auctor. Mauris vel turpis. Aliquam adipiscing lobortis risus. In','Sales Manager'),(26,'Lion','Hutchinson','26.jpg','2001-03-15','Antigua and Barbuda','Friedrichsdorf','lacus. Nulla tincidunt, neque vitae semper egestas, urna justo faucibus lectus, a sollicitudin orci sem eget massa. Suspendisse eleifend. Cras sed leo. Cras vehicula aliquet libero. Integer in magna. Phasellus dolor elit, pellentesque a, facilisis non, bibendum sed,','Account Manager'),(27,'Tiger','Woods','27.jpg','2017-01-15','Zambia','Gateshead','Donec nibh. Quisque nonummy ipsum non arcu. Vivamus sit amet risus. Donec egestas. Aliquam nec enim. Nunc ut erat. Sed nunc est, mollis non, cursus non, egestas a, dui. Cras pellentesque. Sed dictum. Proin','Payroll Manager'),(28,'Rat','Roman','28.jpg','2031-08-15','Sint Maarten','Saint-Oyen','Integer sem elit, pharetra ut, pharetra sed, hendrerit a, arcu. Sed et libero. Proin mi. Aliquam gravida mauris ut mi. Duis risus odio, auctor vitae, aliquet nec, imperdiet nec, leo. Morbi neque tellus, imperdiet','Quality Assurance Manager'),(29,'Mice','Horn','29.jpg','2026-04-16','Mozambique','Castiglione di Sicilia','metus. In lorem. Donec elementum, lorem ut aliquam iaculis, lacus pede sagittis augue, eu tempor erat neque non quam. Pellentesque','Customer Manager'),(30,'Pig','Glass','30.jpg','2001-07-14','Panama','Ingelheim','sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Aenean eget magna. Suspendisse tristique neque venenatis lacus. Etiam bibendum fermentum metus. Aenean sed pede nec ante blandit viverra. Donec tempus, lorem fringilla ornare','Quality Assurance Manager'),(31,'Rabbit','Woodward','31.jpg','2021-10-14','Chile','Naihati','Donec non justo. Proin non massa non ante bibendum ullamcorper. Duis cursus, diam at pretium aliquet, metus urna convallis erat, eget tincidunt dui augue eu tellus. Phasellus elit pede, malesuada vel,','Marketing Manager'),(32,'Tortoise','Gross','32.jpg','2019-02-15','Bhutan','Kirkland','mauris elit, dictum eu, eleifend nec, malesuada ut, sem. Nulla interdum. Curabitur dictum. Phasellus in felis. Nulla tempor augue ac ipsum. Phasellus vitae mauris sit amet lorem semper auctor. Mauris vel turpis. Aliquam adipiscing lobortis risus. In mi pede, nonummy ut, molestie','Payroll Manager'),(33,'Batat','Hall','33.jpg','2022-12-14','Saint Barthelemy','La Matapdia','iaculis quis, pede. Praesent eu dui. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Aenean eget magna. Suspendisse tristique neque venenatis lacus. Etiam bibendum fermentum metus. Aenean sed pede nec ante blandit viverra. Donec tempus, lorem fringilla ornare placerat, orci lacus vestibulum lorem,','Web Developer'),(34,'Zebra','Potter','34.jpg','2014-03-16','Italy','Melbourne','nunc interdum feugiat. Sed nec metus facilisis lorem tristique aliquet. Phasellus fermentum convallis ligula. Donec luctus aliquet odio. Etiam ligula tortor, dictum eu, placerat eget, venenatis a,','Web Developer'),(35,'Koala','Lich','35.jpg','2003-05-12','Russia','Moscow','Nothing.','CEO');
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
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'dolphin','cb7337c9a86957c69fe597e1da88adb1'),(2,'rhino','527a08a7cc3b5226be313d5a22b54772'),(3,'leopard','e65ac5b47a94428210c05a391f4daec6'),(4,'cat','df51130e60098001f3ecf1f1507163b3'),(5,'dog','9e43179c32a1e03c78f2731939ae0f1e'),(6,'elephant','86f02c0c796764f61dc7ae6b325c19e6'),(7,'horse','f8df76651bb9d73f48d18b9f79ec2ebc'),(8,'monkey','437512e73774814f9ee70e05fb5a9a99'),(9,'bird','0fd38725202cf26564377850b3d84bfd'),(10,'bear','9b5604305b9405fb0241afb603c2af11'),(11,'ape','a2349f4ddcf0568dc196b6eb90ab6783'),(12,'worm','9e08b7ebe230871748bb5bf1e2b27ea9'),(13,'dinosaur','fd140bfa3fb3828af79c3a9950ac26d2'),(14,'pterosaur','04dde060f313987394609960bfb597fe'),(15,'snake','fe0a5ca3bb6927793dd6a8107de74031'),(16,'reptile','0760a7b67f38f12d00efd47182ee4ada'),(17,'bison','4e7ca16edfa12a892c9f70ca0368fd4d'),(18,'ant','c053eb1380343d749bbde029e292471c'),(19,'duck','75bec7ee56da04e71b9ef4e16dd9dea3'),(20,'beetle','08147843f312a851a6a3fc7155dbc8b7'),(21,'cow','7fc104479ca61ed0a37c37086c29d83b'),(22,'coyote','52b7c9e9115e09ea7aa0e61796f98091'),(23,'wolf','9d2432211c1171430be25d0c1538a34c'),(24,'fox','d468fddef38a9deb1649e6d6cf813a4e'),(25,'goat','5937c7b9f75ffc1d271721c993409f5c'),(26,'lion','17479d7a72a9ade93298713240545e80'),(27,'tiger','804bc33f8477a8ae9a88e313c6efdd3e'),(28,'rat','96a276aa9a7bb52dd347a6dc0e71be3a'),(29,'mice','10a5a5a9296d08b8797686d6dea2332f'),(30,'pig','ee52e237fe12a657ecb8eb480dc7d6bf'),(31,'rabbit','23f5d557e67b963235aadd735bb4127d'),(32,'tortoise','26d3e8131871592c8c9b1fe480934918'),(33,'batat','830a5df3873184b8d7686623bd6bae20'),(34,'zebra','7346b5bfd1667fe1d15f80c87456b7c3'),(35,'coala','d762d43dedd7d0a9b67f8ddae854dd9b');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_to_chats`
--

DROP TABLE IF EXISTS `users_to_chats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_to_chats` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `chat_id` int(11) DEFAULT NULL,
  `add_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_to_chats`
--

LOCK TABLES `users_to_chats` WRITE;
/*!40000 ALTER TABLE `users_to_chats` DISABLE KEYS */;
INSERT INTO `users_to_chats` VALUES (1,35,1,'2015-06-11 19:22:14'),(2,1,1,'2015-06-11 19:22:14'),(3,1,2,'2015-06-11 19:30:16'),(5,18,2,'2015-06-11 19:30:27'),(6,6,2,'2015-06-11 19:30:27'),(7,28,2,'2015-06-11 19:30:28'),(8,30,2,'2015-06-11 19:30:29'),(9,1,3,'2015-06-11 19:30:36'),(10,4,3,'2015-06-11 19:30:36'),(11,35,2,'2015-06-11 19:32:29'),(12,35,3,'2015-06-11 19:34:04'),(13,4,4,'2015-06-11 19:47:48'),(14,35,4,'2015-06-11 19:47:48'),(15,4,5,'2015-06-11 19:55:29'),(16,3,5,'2015-06-11 19:55:29'),(19,35,5,'2015-06-11 19:56:34');
/*!40000 ALTER TABLE `users_to_chats` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-06-11 19:00:37
