-- MariaDB dump 10.19  Distrib 10.4.32-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: vehicles_db
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
-- Table structure for table `bicycle`
--

DROP TABLE IF EXISTS `bicycle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bicycle` (
  `serial_number` varchar(20) NOT NULL,
  `model` varchar(100) NOT NULL,
  `gear_count` int(11) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `type` enum('Mountain','Road','Hybrid') NOT NULL,
  PRIMARY KEY (`serial_number`),
  KEY `model` (`model`),
  CONSTRAINT `bicycle_ibfk_1` FOREIGN KEY (`model`) REFERENCES `vehicle` (`model`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bicycle`
--

LOCK TABLES `bicycle` WRITE;
/*!40000 ALTER TABLE `bicycle` DISABLE KEYS */;
INSERT INTO `bicycle` VALUES ('SN123456789','Domane',22,3500.00,'Road'),('SN456789123','Stumpjumper',30,4000.00,'Mountain'),('SN987654321','Defy',20,3000.00,'Road');
/*!40000 ALTER TABLE `bicycle` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `car`
--

DROP TABLE IF EXISTS `car`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `car` (
  `vin` varchar(17) NOT NULL,
  `model` varchar(100) NOT NULL,
  `engine_capacity` decimal(4,2) NOT NULL,
  `horsepower` int(11) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `transmission` enum('Automatic','Manual') NOT NULL,
  PRIMARY KEY (`vin`),
  KEY `model` (`model`),
  CONSTRAINT `car_ibfk_1` FOREIGN KEY (`model`) REFERENCES `vehicle` (`model`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `car`
--

LOCK TABLES `car` WRITE;
/*!40000 ALTER TABLE `car` DISABLE KEYS */;
INSERT INTO `car` VALUES ('1FA6P8CF0J1234567','Mustang',5.00,450,55000.00,'Automatic'),('1HGCM82633A123456','Camry',2.50,203,24000.00,'Automatic'),('2HGFG3B53GH123456','Civic',2.00,158,22000.00,'Manual');
/*!40000 ALTER TABLE `car` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `motorcycle`
--

DROP TABLE IF EXISTS `motorcycle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `motorcycle` (
  `vin` varchar(17) NOT NULL,
  `model` varchar(100) NOT NULL,
  `engine_capacity` decimal(4,2) NOT NULL,
  `horsepower` int(11) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `type` enum('Sport','Cruiser','Touring') NOT NULL,
  PRIMARY KEY (`vin`),
  KEY `model` (`model`),
  CONSTRAINT `motorcycle_ibfk_1` FOREIGN KEY (`model`) REFERENCES `vehicle` (`model`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `motorcycle`
--

LOCK TABLES `motorcycle` WRITE;
/*!40000 ALTER TABLE `motorcycle` DISABLE KEYS */;
INSERT INTO `motorcycle` VALUES ('1HD1ZK3158K123456','Sportster',1.20,70,12000.00,'Cruiser'),('JKBVNAF156A123456','Ninja',0.90,150,14000.00,'Sport'),('JYARN28E9FA123456','YZF-R1',1.00,200,17000.00,'Sport');
/*!40000 ALTER TABLE `motorcycle` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vehicle`
--

DROP TABLE IF EXISTS `vehicle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vehicle` (
  `maker` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  `type` enum('Car','Motorcycle','Bicycle') NOT NULL,
  PRIMARY KEY (`model`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vehicle`
--

LOCK TABLES `vehicle` WRITE;
/*!40000 ALTER TABLE `vehicle` DISABLE KEYS */;
INSERT INTO `vehicle` VALUES ('Toyota','Camry','Car'),('Honda','Civic','Car'),('Giant','Defy','Bicycle'),('Trek','Domane','Bicycle'),('Ford','Mustang','Car'),('Kawasaki','Ninja','Motorcycle'),('Harley-Davidson','Sportster','Motorcycle'),('Specialized','Stumpjumper','Bicycle'),('Yamaha','YZF-R1','Motorcycle');
/*!40000 ALTER TABLE `vehicle` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-03-23 20:00:56
