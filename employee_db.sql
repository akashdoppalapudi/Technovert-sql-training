-- MySQL dump 10.13  Distrib 8.0.28, for Win64 (x86_64)
--
-- Host: localhost    Database: employee_db
-- ------------------------------------------------------
-- Server version	8.0.28

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
-- Current Database: `employee_db`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `employee_db` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `employee_db`;

--
-- Table structure for table `employee`
--

DROP TABLE IF EXISTS `employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employee` (
  `first_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `title` varchar(50) DEFAULT NULL,
  `age` int DEFAULT NULL,
  `salary` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee`
--

LOCK TABLES `employee` WRITE;
/*!40000 ALTER TABLE `employee` DISABLE KEYS */;
INSERT INTO `employee` VALUES ('John','Smith','Programmer',54,27000),('Leroy','Brooks','General Manager',55,40099),('John','Fanning','Programmer',28,35000),('Lisa','Moore','Programmer',27,35000),('Ginger','Finger','Fresher',22,31500),('Kelly','Brooks','Programmer',27,22000),('Shawn','Tait','Fresher',20,25000),('Michael','Tolstoy','Fresher',21,25000),('Anthony','Hopkins','Programmer',26,19500),('Leroy','Miles','General Manager',54,30000),('Mary Ann','Moore','Software Engineer',32,32513),('Donald','Duck','Programmer',35,19300),('Linda','Hamilton','Fresher',35,25000),('Sarah','Karan','Fresher',15,25000),('Kevin','Peitersen','Programmer',40,32300),('Conrad','Whales','Software Engineer',20,32300),('Isabela','Karan','Programmer',38,30260),('Lisa','Logan','Programmer',23,20000),('Ginger','Gran','Fresher',10,22000),('Kelly','Shield','Programmer',25,19000),('Shawn','Bichel','Fresher',26,22000),('Michael','Stone','Fresher',24,21000),('Anthony','Groove','Software Engineer',47,23000),('Mary Ann','Vista','Programmer',27,37570),('Donald','Bang','Fresher',34,31000),('Linda','Hamser','Fresher',42,34000),('Sarah','Bones','Fresher',51,32000),('Kevin','Luther','Programmer',45,33000),('Conrad','Marss','Fresher',24,31500),('Isabela','Tauton','Programmer',25,32500),('John','Vaughan','Programmer',25,27000),('Leroy','Garten','Programmer',55,40099),('John','Whitaker','Programmer',25,32000),('Lisa','Merci','Programmer',27,35000),('Ginger','Brown','Software Engineer',20,25000),('Kelly','Alba','Programmer',27,22000),('Shawn','Sons','Fresher',20,25000),('Michael','Mitchell','Fresher',21,25000),('Anthony','Bravo','Programmer',26,19500),('Leroy','Kings','General Manager',54,30000),('Mary Ann','Dolce','Programmer',32,32513),('Donald','Bus','Programmer',35,19300),('Linda','Scott','Fresher',35,25000),('Sarah','Jones','Fresher',15,25000),('Kevin','Reese','Software Engineer',40,32300),('Conrad','Turtle','Software Engineer',40,25000),('Isabela','Apple','Programmer',38,30260),('Lisa','Hammer','Programmer',23,20000),('Ginger','Gold','Fresher',10,22000),('Kelly','Rise','Programmer',25,19000),('Shawn','Bell','Fresher',26,22000),('Michael','Moore','Fresher',24,21000),('Anthony','Tamahori','Programmer',84,23000),('Mary Ann','Horn','Programmer',27,37570),('Donald','Crank','Programmer',34,31000),('Linda','Josh','Fresher',42,34000),('Sarah','Michael','Fresher',51,32000),('Kevin','Long','Programmer',45,33000),('Conrad','Tamahori','Software Engineer',24,31500),('Isabela','Moore','Programmer',25,32500);
/*!40000 ALTER TABLE `employee` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-02-27 23:52:19
