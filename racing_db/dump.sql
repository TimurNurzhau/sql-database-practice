-- MariaDB dump 10.19  Distrib 10.4.32-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: racing_db
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
-- Table structure for table `cars`
--

DROP TABLE IF EXISTS `cars`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cars` (
  `name` varchar(100) NOT NULL,
  `class` varchar(100) NOT NULL,
  `year` int(11) NOT NULL,
  PRIMARY KEY (`name`),
  KEY `class` (`class`),
  CONSTRAINT `cars_ibfk_1` FOREIGN KEY (`class`) REFERENCES `classes` (`class`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cars`
--

LOCK TABLES `cars` WRITE;
/*!40000 ALTER TABLE `cars` DISABLE KEYS */;
INSERT INTO `cars` VALUES ('Audi A4','Sedan',2018),('BMW 3 Series','Sedan',2019),('Chevrolet Camaro','Coupe',2021),('Ferrari 488','Convertible',2019),('Ford F-150','Pickup',2021),('Ford Mustang','SportsCar',2020),('Mercedes-Benz S-Class','Luxury Sedan',2022),('Nissan Rogue','SUV',2020),('Renault Clio','Hatchback',2020),('Toyota RAV4','SUV',2021);
/*!40000 ALTER TABLE `cars` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `classes`
--

DROP TABLE IF EXISTS `classes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `classes` (
  `class` varchar(100) NOT NULL,
  `type` enum('Racing','Street') NOT NULL,
  `country` varchar(100) NOT NULL,
  `numDoors` int(11) NOT NULL,
  `engineSize` decimal(3,1) NOT NULL,
  `weight` int(11) NOT NULL,
  PRIMARY KEY (`class`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `classes`
--

LOCK TABLES `classes` WRITE;
/*!40000 ALTER TABLE `classes` DISABLE KEYS */;
INSERT INTO `classes` VALUES ('Convertible','Racing','Italy',2,3.0,1300),('Coupe','Street','USA',2,2.5,1400),('Hatchback','Street','France',5,1.6,1100),('Luxury Sedan','Street','Germany',4,3.0,1600),('Pickup','Street','USA',2,2.8,2000),('Sedan','Street','Germany',4,2.0,1200),('SportsCar','Racing','USA',2,3.5,1500),('SUV','Street','Japan',4,2.5,1800);
/*!40000 ALTER TABLE `classes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `races`
--

DROP TABLE IF EXISTS `races`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `races` (
  `name` varchar(100) NOT NULL,
  `date` date NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `races`
--

LOCK TABLES `races` WRITE;
/*!40000 ALTER TABLE `races` DISABLE KEYS */;
INSERT INTO `races` VALUES ('Bathurst 1000','2023-10-08'),('Daytona 500','2023-02-19'),('Indy 500','2023-05-28'),('Le Mans','2023-06-10'),('Monaco Grand Prix','2023-05-28'),('Nürburgring 24 Hours','2023-06-17'),('Pikes Peak International Hill Climb','2023-06-25'),('Spa 24 Hours','2023-07-29');
/*!40000 ALTER TABLE `races` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `results`
--

DROP TABLE IF EXISTS `results`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `results` (
  `car` varchar(100) NOT NULL,
  `race` varchar(100) NOT NULL,
  `position` int(11) NOT NULL,
  PRIMARY KEY (`car`,`race`),
  KEY `race` (`race`),
  CONSTRAINT `results_ibfk_1` FOREIGN KEY (`car`) REFERENCES `cars` (`name`),
  CONSTRAINT `results_ibfk_2` FOREIGN KEY (`race`) REFERENCES `races` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `results`
--

LOCK TABLES `results` WRITE;
/*!40000 ALTER TABLE `results` DISABLE KEYS */;
INSERT INTO `results` VALUES ('Audi A4','Nürburgring 24 Hours',8),('BMW 3 Series','Le Mans',3),('Chevrolet Camaro','Monaco Grand Prix',4),('Ferrari 488','Le Mans',1),('Ford F-150','Bathurst 1000',6),('Ford Mustang','Indy 500',1),('Mercedes-Benz S-Class','Spa 24 Hours',2),('Nissan Rogue','Pikes Peak International Hill Climb',3),('Renault Clio','Daytona 500',5),('Toyota RAV4','Monaco Grand Prix',2);
/*!40000 ALTER TABLE `results` ENABLE KEYS */;
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
