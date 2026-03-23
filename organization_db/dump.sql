-- MariaDB dump 10.19  Distrib 10.4.32-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: organization_db
-- ------------------------------------------------------
-- Server version	10.4.32-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `departments`
--

DROP TABLE IF EXISTS `departments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `departments` (
  `DepartmentID` int(11) NOT NULL,
  `DepartmentName` varchar(100) NOT NULL,
  PRIMARY KEY (`DepartmentID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `departments`
--

LOCK TABLES `departments` WRITE;
/*!40000 ALTER TABLE `departments` DISABLE KEYS */;
INSERT INTO `departments` VALUES (1,'РћС‚РґРµР» РїСЂРѕРґР°Р¶'),(2,'РћС‚РґРµР» РјР°СЂРєРµС‚РёРЅРіР°'),(3,'IT-РѕС‚РґРµР»'),(4,'РћС‚РґРµР» СЂР°Р·СЂР°Р±РѕС‚РєРё'),(5,'РћС‚РґРµР» РїРѕРґРґРµСЂР¶РєРё');
/*!40000 ALTER TABLE `departments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employees`
--

DROP TABLE IF EXISTS `employees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `employees` (
  `EmployeeID` int(11) NOT NULL,
  `Name` varchar(100) NOT NULL,
  `Position` varchar(100) DEFAULT NULL,
  `ManagerID` int(11) DEFAULT NULL,
  `DepartmentID` int(11) DEFAULT NULL,
  `RoleID` int(11) DEFAULT NULL,
  PRIMARY KEY (`EmployeeID`),
  KEY `ManagerID` (`ManagerID`),
  KEY `DepartmentID` (`DepartmentID`),
  KEY `RoleID` (`RoleID`),
  CONSTRAINT `employees_ibfk_1` FOREIGN KEY (`ManagerID`) REFERENCES `employees` (`EmployeeID`),
  CONSTRAINT `employees_ibfk_2` FOREIGN KEY (`DepartmentID`) REFERENCES `departments` (`DepartmentID`),
  CONSTRAINT `employees_ibfk_3` FOREIGN KEY (`RoleID`) REFERENCES `roles` (`RoleID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employees`
--

LOCK TABLES `employees` WRITE;
/*!40000 ALTER TABLE `employees` DISABLE KEYS */;
INSERT INTO `employees` VALUES (1,'РРІР°РЅ РРІР°РЅРѕРІ','Р“РµРЅРµСЂР°Р»СЊРЅС‹Р№ РґРёСЂРµРєС‚РѕСЂ',NULL,1,3),(2,'РџРµС‚СЂ РџРµС‚СЂРѕРІ','Р”РёСЂРµРєС‚РѕСЂ РїРѕ РїСЂРѕРґР°Р¶Р°Рј',1,1,2),(3,'РЎРІРµС‚Р»Р°РЅР° РЎРІРµС‚Р»РѕРІР°','Р”РёСЂРµРєС‚РѕСЂ РїРѕ РјР°СЂРєРµС‚РёРЅРіСѓ',1,2,2),(4,'РђР»РµРєСЃРµР№ РђР»РµРєСЃРµРµРІ','РњРµРЅРµРґР¶РµСЂ РїРѕ РїСЂРѕРґР°Р¶Р°Рј',2,1,1),(5,'РњР°СЂРёСЏ РњР°СЂРёРµРІР°','РњРµРЅРµРґР¶РµСЂ РїРѕ РјР°СЂРєРµС‚РёРЅРіСѓ',3,2,1),(6,'РђРЅРґСЂРµР№ РђРЅРґСЂРµРµРІ','Р Р°Р·СЂР°Р±РѕС‚С‡РёРє',1,4,4),(7,'Р•Р»РµРЅР° Р•Р»РµРЅРѕРІР°','РЎРїРµС†РёР°Р»РёСЃС‚ РїРѕ РїРѕРґРґРµСЂР¶РєРµ',1,5,5),(8,'РћР»РµРі РћР»РµРіРѕРІ','РњРµРЅРµРґР¶РµСЂ РїРѕ РїСЂРѕРґСѓРєС‚Сѓ',2,1,1),(9,'РўР°С‚СЊСЏРЅР° РўР°С‚РµРµРІР°','РњР°СЂРєРµС‚РѕР»РѕРі',3,2,6),(10,'РќРёРєРѕР»Р°Р№ РќРёРєРѕР»Р°РµРІ','Р Р°Р·СЂР°Р±РѕС‚С‡РёРє',6,4,4),(11,'РСЂРёРЅР° РСЂРёРЅРёРЅР°','Р Р°Р·СЂР°Р±РѕС‚С‡РёРє',6,4,4),(12,'РЎРµСЂРіРµР№ РЎРµСЂРіРµРµРІ','РЎРїРµС†РёР°Р»РёСЃС‚ РїРѕ РїРѕРґРґРµСЂР¶РєРµ',7,5,5),(13,'РљСЂРёСЃС‚РёРЅР° РљСЂРёСЃС‚РёРЅРёРЅР°','РњРµРЅРµРґР¶РµСЂ РїРѕ РїСЂРѕРґР°Р¶Р°Рј',4,1,1),(14,'Р”РјРёС‚СЂРёР№ Р”РјРёС‚СЂРёРµРІ','РњР°СЂРєРµС‚РѕР»РѕРі',3,2,6),(15,'Р’РёРєС‚РѕСЂ Р’РёРєС‚РѕСЂРѕРІ','РњРµРЅРµРґР¶РµСЂ РїРѕ РїСЂРѕРґР°Р¶Р°Рј',4,1,1),(16,'РђРЅР°СЃС‚Р°СЃРёСЏ РђРЅР°СЃС‚Р°СЃРёРµРІР°','РЎРїРµС†РёР°Р»РёСЃС‚ РїРѕ РїРѕРґРґРµСЂР¶РєРµ',7,5,5),(17,'РњР°РєСЃРёРј РњР°РєСЃРёРјРѕРІ','Р Р°Р·СЂР°Р±РѕС‚С‡РёРє',6,4,4),(18,'Р›СЋРґРјРёР»Р° Р›СЋРґРјРёР»РѕРІР°','РЎРїРµС†РёР°Р»РёСЃС‚ РїРѕ РјР°СЂРєРµС‚РёРЅРіСѓ',3,2,6),(19,'РќР°С‚Р°Р»СЊСЏ РќР°С‚Р°Р»СЊРµРІР°','РњРµРЅРµРґР¶РµСЂ РїРѕ РїСЂРѕРґР°Р¶Р°Рј',4,1,1),(20,'РђР»РµРєСЃР°РЅРґСЂ РђР»РµРєСЃР°РЅРґСЂРѕРІ','РњРµРЅРµРґР¶РµСЂ РїРѕ РјР°СЂРєРµС‚РёРЅРіСѓ',3,2,1),(21,'Р“Р°Р»РёРЅР° Р“Р°Р»РёРЅР°','РЎРїРµС†РёР°Р»РёСЃС‚ РїРѕ РїРѕРґРґРµСЂР¶РєРµ',7,5,5),(22,'РџР°РІРµР» РџР°РІР»РѕРІ','Р Р°Р·СЂР°Р±РѕС‚С‡РёРє',6,4,4),(23,'РњР°СЂРёРЅР° РњР°СЂРёРЅРёРЅР°','РЎРїРµС†РёР°Р»РёСЃС‚ РїРѕ РјР°СЂРєРµС‚РёРЅРіСѓ',3,2,6),(24,'РЎС‚Р°РЅРёСЃР»Р°РІ РЎС‚Р°РЅРёСЃР»Р°РІРѕРІ','РњРµРЅРµРґР¶РµСЂ РїРѕ РїСЂРѕРґР°Р¶Р°Рј',4,1,1),(25,'Р•РєР°С‚РµСЂРёРЅР° Р•РєР°С‚РµСЂРёРЅРёРЅР°','РЎРїРµС†РёР°Р»РёСЃС‚ РїРѕ РїРѕРґРґРµСЂР¶РєРµ',7,5,5),(26,'Р”РµРЅРёСЃ Р”РµРЅРёСЃРѕРІ','Р Р°Р·СЂР°Р±РѕС‚С‡РёРє',6,4,4),(27,'РћР»СЊРіР° РћР»СЊРіРёРЅР°','РњР°СЂРєРµС‚РѕР»РѕРі',3,2,6),(28,'РРіРѕСЂСЊ РРіРѕСЂРµРІ','РњРµРЅРµРґР¶РµСЂ РїРѕ РїСЂРѕРґСѓРєС‚Сѓ',2,1,1),(29,'РђРЅР°СЃС‚Р°СЃРёСЏ РђРЅР°СЃС‚Р°СЃРёРµРІРЅР°','РЎРїРµС†РёР°Р»РёСЃС‚ РїРѕ РїРѕРґРґРµСЂР¶РєРµ',7,5,5),(30,'Р’Р°Р»РµРЅС‚РёРЅ Р’Р°Р»РµРЅС‚РёРЅРѕРІ','Р Р°Р·СЂР°Р±РѕС‚С‡РёРє',6,4,4);
/*!40000 ALTER TABLE `employees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `projects`
--

DROP TABLE IF EXISTS `projects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `projects` (
  `ProjectID` int(11) NOT NULL,
  `ProjectName` varchar(100) NOT NULL,
  `StartDate` date DEFAULT NULL,
  `EndDate` date DEFAULT NULL,
  `DepartmentID` int(11) DEFAULT NULL,
  PRIMARY KEY (`ProjectID`),
  KEY `DepartmentID` (`DepartmentID`),
  CONSTRAINT `projects_ibfk_1` FOREIGN KEY (`DepartmentID`) REFERENCES `departments` (`DepartmentID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `projects`
--

LOCK TABLES `projects` WRITE;
/*!40000 ALTER TABLE `projects` DISABLE KEYS */;
INSERT INTO `projects` VALUES (1,'РџСЂРѕРµРєС‚ A','2025-01-01','2025-12-31',1),(2,'РџСЂРѕРµРєС‚ B','2025-02-01','2025-11-30',2),(3,'РџСЂРѕРµРєС‚ C','2025-03-01','2025-10-31',4),(4,'РџСЂРѕРµРєС‚ D','2025-04-01','2025-09-30',5),(5,'РџСЂРѕРµРєС‚ E','2025-05-01','2025-08-31',3);
/*!40000 ALTER TABLE `projects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `roles` (
  `RoleID` int(11) NOT NULL,
  `RoleName` varchar(100) NOT NULL,
  PRIMARY KEY (`RoleID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'РњРµРЅРµРґР¶РµСЂ'),(2,'Р”РёСЂРµРєС‚РѕСЂ'),(3,'Р“РµРЅРµСЂР°Р»СЊРЅС‹Р№ РґРёСЂРµРєС‚РѕСЂ'),(4,'Р Р°Р·СЂР°Р±РѕС‚С‡РёРє'),(5,'РЎРїРµС†РёР°Р»РёСЃС‚ РїРѕ РїРѕРґРґРµСЂР¶РєРµ'),(6,'РњР°СЂРєРµС‚РѕР»РѕРі');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tasks`
--

DROP TABLE IF EXISTS `tasks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tasks` (
  `TaskID` int(11) NOT NULL,
  `TaskName` varchar(100) NOT NULL,
  `AssignedTo` int(11) DEFAULT NULL,
  `ProjectID` int(11) DEFAULT NULL,
  PRIMARY KEY (`TaskID`),
  KEY `AssignedTo` (`AssignedTo`),
  KEY `ProjectID` (`ProjectID`),
  CONSTRAINT `tasks_ibfk_1` FOREIGN KEY (`AssignedTo`) REFERENCES `employees` (`EmployeeID`),
  CONSTRAINT `tasks_ibfk_2` FOREIGN KEY (`ProjectID`) REFERENCES `projects` (`ProjectID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tasks`
--

LOCK TABLES `tasks` WRITE;
/*!40000 ALTER TABLE `tasks` DISABLE KEYS */;
INSERT INTO `tasks` VALUES (1,'Р—Р°РґР°С‡Р° 1: РџРѕРґРіРѕС‚РѕРІРєР° РѕС‚С‡РµС‚Р° РїРѕ РїСЂРѕРґР°Р¶Р°Рј',4,1),(2,'Р—Р°РґР°С‡Р° 2: РђРЅР°Р»РёР· СЂС‹РЅРєР°',9,2),(3,'Р—Р°РґР°С‡Р° 3: Р Р°Р·СЂР°Р±РѕС‚РєР° РЅРѕРІРѕРіРѕ С„СѓРЅРєС†РёРѕРЅР°Р»Р°',10,3),(4,'Р—Р°РґР°С‡Р° 4: РџРѕРґРґРµСЂР¶РєР° РєР»РёРµРЅС‚РѕРІ',12,4),(5,'Р—Р°РґР°С‡Р° 5: РЎРѕР·РґР°РЅРёРµ СЂРµРєР»Р°РјРЅРѕР№ РєР°РјРїР°РЅРёРё',5,2),(6,'Р—Р°РґР°С‡Р° 6: РћР±РЅРѕРІР»РµРЅРёРµ РґРѕРєСѓРјРµРЅС‚Р°С†РёРё',6,3),(7,'Р—Р°РґР°С‡Р° 7: РџСЂРѕРІРµРґРµРЅРёРµ С‚СЂРµРЅРёРЅРіР° РґР»СЏ СЃРѕС‚СЂСѓРґРЅРёРєРѕРІ',8,1),(8,'Р—Р°РґР°С‡Р° 8: РўРµСЃС‚РёСЂРѕРІР°РЅРёРµ РЅРѕРІРѕРіРѕ РїСЂРѕРґСѓРєС‚Р°',11,3),(9,'Р—Р°РґР°С‡Р° 9: РћС‚РІРµС‚С‹ РЅР° Р·Р°РїСЂРѕСЃС‹ РєР»РёРµРЅС‚РѕРІ',12,4),(10,'Р—Р°РґР°С‡Р° 10: РџРѕРґРіРѕС‚РѕРІРєР° РјР°СЂРєРµС‚РёРЅРіРѕРІС‹С… РјР°С‚РµСЂРёР°Р»РѕРІ',9,2),(11,'Р—Р°РґР°С‡Р° 11: РРЅС‚РµРіСЂР°С†РёСЏ СЃ РЅРѕРІС‹Рј API',10,3),(12,'Р—Р°РґР°С‡Р° 12: РќР°СЃС‚СЂРѕР№РєР° СЃРёСЃС‚РµРјС‹ РїРѕРґРґРµСЂР¶РєРё',7,5),(13,'Р—Р°РґР°С‡Р° 13: РџСЂРѕРІРµРґРµРЅРёРµ Р°РЅР°Р»РёР·Р° РєРѕРЅРєСѓСЂРµРЅС‚РѕРІ',9,2),(14,'Р—Р°РґР°С‡Р° 14: РЎРѕР·РґР°РЅРёРµ РїСЂРµР·РµРЅС‚Р°С†РёРё РґР»СЏ РєР»РёРµРЅС‚РѕРІ',4,1),(15,'Р—Р°РґР°С‡Р° 15: РћР±РЅРѕРІР»РµРЅРёРµ СЃР°Р№С‚Р°',6,3);
/*!40000 ALTER TABLE `tasks` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-03-23 20:00:57
