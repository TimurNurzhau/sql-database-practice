-- MariaDB dump 10.19  Distrib 10.4.32-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: hotels_db
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
-- Table structure for table `booking`
--

DROP TABLE IF EXISTS `booking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `booking` (
  `ID_booking` int(11) NOT NULL,
  `ID_room` int(11) DEFAULT NULL,
  `ID_customer` int(11) DEFAULT NULL,
  `check_in_date` date NOT NULL,
  `check_out_date` date NOT NULL,
  PRIMARY KEY (`ID_booking`),
  KEY `ID_room` (`ID_room`),
  KEY `ID_customer` (`ID_customer`),
  CONSTRAINT `booking_ibfk_1` FOREIGN KEY (`ID_room`) REFERENCES `room` (`ID_room`),
  CONSTRAINT `booking_ibfk_2` FOREIGN KEY (`ID_customer`) REFERENCES `customer` (`ID_customer`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `booking`
--

LOCK TABLES `booking` WRITE;
/*!40000 ALTER TABLE `booking` DISABLE KEYS */;
INSERT INTO `booking` VALUES (1,1,1,'2025-05-01','2025-05-05'),(2,2,2,'2025-05-02','2025-05-06'),(3,3,3,'2025-05-03','2025-05-07'),(4,4,4,'2025-05-04','2025-05-08'),(5,5,5,'2025-05-05','2025-05-09'),(6,6,6,'2025-05-06','2025-05-10'),(7,7,7,'2025-05-07','2025-05-11'),(8,8,8,'2025-05-08','2025-05-12'),(9,9,9,'2025-05-09','2025-05-13'),(10,10,10,'2025-05-10','2025-05-14'),(11,1,2,'2025-05-11','2025-05-15'),(12,2,3,'2025-05-12','2025-05-14'),(13,3,4,'2025-05-13','2025-05-15'),(14,4,5,'2025-05-14','2025-05-16'),(15,5,6,'2025-05-15','2025-05-16'),(16,6,7,'2025-05-16','2025-05-18'),(17,7,8,'2025-05-17','2025-05-21'),(18,8,9,'2025-05-18','2025-05-19'),(19,9,10,'2025-05-19','2025-05-22'),(20,10,1,'2025-05-20','2025-05-22'),(21,1,2,'2025-05-21','2025-05-23'),(22,2,3,'2025-05-22','2025-05-25'),(23,3,4,'2025-05-23','2025-05-26'),(24,4,5,'2025-05-24','2025-05-25'),(25,5,6,'2025-05-25','2025-05-27'),(26,6,7,'2025-05-26','2025-05-29');
/*!40000 ALTER TABLE `booking` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customer` (
  `ID_customer` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone` varchar(20) NOT NULL,
  PRIMARY KEY (`ID_customer`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES (1,'John Doe','john.doe@example.com','+1234567890'),(2,'Jane Smith','jane.smith@example.com','+0987654321'),(3,'Alice Johnson','alice.johnson@example.com','+1122334455'),(4,'Bob Brown','bob.brown@example.com','+2233445566'),(5,'Charlie White','charlie.white@example.com','+3344556677'),(6,'Diana Prince','diana.prince@example.com','+4455667788'),(7,'Ethan Hunt','ethan.hunt@example.com','+5566778899'),(8,'Fiona Apple','fiona.apple@example.com','+6677889900'),(9,'George Washington','george.washington@example.com','+7788990011'),(10,'Hannah Montana','hannah.montana@example.com','+8899001122');
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hotel`
--

DROP TABLE IF EXISTS `hotel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hotel` (
  `ID_hotel` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `location` varchar(255) NOT NULL,
  PRIMARY KEY (`ID_hotel`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hotel`
--

LOCK TABLES `hotel` WRITE;
/*!40000 ALTER TABLE `hotel` DISABLE KEYS */;
INSERT INTO `hotel` VALUES (1,'Grand Hotel','Paris, France'),(2,'Ocean View Resort','Miami, USA'),(3,'Mountain Retreat','Aspen, USA'),(4,'City Center Inn','New York, USA'),(5,'Desert Oasis','Las Vegas, USA'),(6,'Lakeside Lodge','Lake Tahoe, USA'),(7,'Historic Castle','Edinburgh, Scotland'),(8,'Tropical Paradise','Bali, Indonesia'),(9,'Business Suites','Tokyo, Japan'),(10,'Eco-Friendly Hotel','Copenhagen, Denmark');
/*!40000 ALTER TABLE `hotel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `room`
--

DROP TABLE IF EXISTS `room`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `room` (
  `ID_room` int(11) NOT NULL,
  `ID_hotel` int(11) DEFAULT NULL,
  `room_type` enum('Single','Double','Suite') NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `capacity` int(11) NOT NULL,
  PRIMARY KEY (`ID_room`),
  KEY `ID_hotel` (`ID_hotel`),
  CONSTRAINT `room_ibfk_1` FOREIGN KEY (`ID_hotel`) REFERENCES `hotel` (`ID_hotel`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `room`
--

LOCK TABLES `room` WRITE;
/*!40000 ALTER TABLE `room` DISABLE KEYS */;
INSERT INTO `room` VALUES (1,1,'Single',150.00,1),(2,1,'Double',200.00,2),(3,1,'Suite',350.00,4),(4,2,'Single',120.00,1),(5,2,'Double',180.00,2),(6,2,'Suite',300.00,4),(7,3,'Double',250.00,2),(8,3,'Suite',400.00,4),(9,4,'Single',100.00,1),(10,4,'Double',150.00,2),(11,5,'Single',90.00,1),(12,5,'Double',140.00,2),(13,6,'Suite',280.00,4),(14,7,'Double',220.00,2),(15,8,'Single',130.00,1),(16,8,'Double',190.00,2),(17,9,'Suite',360.00,4),(18,10,'Single',110.00,1),(19,10,'Double',160.00,2);
/*!40000 ALTER TABLE `room` ENABLE KEYS */;
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
