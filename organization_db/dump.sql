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
INSERT INTO `departments` VALUES (1,'Отдел продаж'),(2,'Отдел маркетинга'),(3,'IT-отдел'),(4,'Отдел разработки'),(5,'Отдел поддержки');
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
INSERT INTO `employees` VALUES (1,'Иван Иванов','Генеральный директор',NULL,1,3),(2,'Петр Петров','Директор по продажам',1,1,2),(3,'Светлана Светлова','Директор по маркетингу',1,2,2),(4,'Алексей Алексеев','Менеджер по продажам',2,1,1),(5,'Мария Мариева','Менеджер по маркетингу',3,2,1),(6,'Андрей Андреев','Разработчик',1,4,4),(7,'Елена Еленова','Специалист по поддержке',1,5,5),(8,'Олег Олегов','Менеджер по продукту',2,1,1),(9,'Татьяна Татеева','Маркетолог',3,2,6),(10,'Николай Николаев','Разработчик',6,4,4),(11,'Ирина Иринина','Разработчик',6,4,4),(12,'Сергей Сергеев','Специалист по поддержке',7,5,5),(13,'Кристина Кристинина','Менеджер по продажам',4,1,1),(14,'Дмитрий Дмитриев','Маркетолог',3,2,6),(15,'Виктор Викторов','Менеджер по продажам',4,1,1),(16,'Анастасия Анастасиева','Специалист по поддержке',7,5,5),(17,'Максим Максимов','Разработчик',6,4,4),(18,'Людмила Людмилова','Специалист по маркетингу',3,2,6),(19,'Наталья Натальева','Менеджер по продажам',4,1,1),(20,'Александр Александров','Менеджер по маркетингу',3,2,1),(21,'Галина Галина','Специалист по поддержке',7,5,5),(22,'Павел Павлов','Разработчик',6,4,4),(23,'Марина Маринина','Специалист по маркетингу',3,2,6),(24,'Станислав Станиславов','Менеджер по продажам',4,1,1),(25,'Екатерина Екатеринина','Специалист по поддержке',7,5,5),(26,'Денис Денисов','Разработчик',6,4,4),(27,'Ольга Ольгина','Маркетолог',3,2,6),(28,'Игорь Игорев','Менеджер по продукту',2,1,1),(29,'Анастасия Анастасиевна','Специалист по поддержке',7,5,5),(30,'Валентин Валентинов','Разработчик',6,4,4);
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
INSERT INTO `projects` VALUES (1,'Проект A','2025-01-01','2025-12-31',1),(2,'Проект B','2025-02-01','2025-11-30',2),(3,'Проект C','2025-03-01','2025-10-31',4),(4,'Проект D','2025-04-01','2025-09-30',5),(5,'Проект E','2025-05-01','2025-08-31',3);
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
INSERT INTO `roles` VALUES (1,'Менеджер'),(2,'Директор'),(3,'Генеральный директор'),(4,'Разработчик'),(5,'Специалист по поддержке'),(6,'Маркетолог');
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
INSERT INTO `tasks` VALUES (1,'Задача 1: Подготовка отчета по продажам',4,1),(2,'Задача 2: Анализ рынка',9,2),(3,'Задача 3: Разработка нового функционала',10,3),(4,'Задача 4: Поддержка клиентов',12,4),(5,'Задача 5: Создание рекламной кампании',5,2),(6,'Задача 6: Обновление документации',6,3),(7,'Задача 7: Проведение тренинга для сотрудников',8,1),(8,'Задача 8: Тестирование нового продукта',11,3),(9,'Задача 9: Ответы на запросы клиентов',12,4),(10,'Задача 10: Подготовка маркетинговых материалов',9,2),(11,'Задача 11: Интеграция с новым API',10,3),(12,'Задача 12: Настройка системы поддержки',7,5),(13,'Задача 13: Проведение анализа конкурентов',9,2),(14,'Задача 14: Создание презентации для клиентов',4,1),(15,'Задача 15: Обновление сайта',6,3);
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
