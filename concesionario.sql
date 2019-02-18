-- MySQL dump 10.14  Distrib 5.3.3-MariaDB-rc, for debian-linux-gnu (i686)
--
-- Host: localhost    Database: concesionario
-- ------------------------------------------------------
-- Server version	5.3.3-MariaDB-rc-mariadb108~maverick-log

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
-- Table structure for table `clientes`
--

DROP TABLE IF EXISTS `clientes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `clientes` (
  `dni` varchar(4) COLLATE utf8_spanish_ci NOT NULL DEFAULT '',
  `nombre` varchar(10) COLLATE utf8_spanish_ci NOT NULL DEFAULT '',
  `apellido` varchar(25) COLLATE utf8_spanish_ci NOT NULL DEFAULT '',
  `ciudad` varchar(15) COLLATE utf8_spanish_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`dni`),
  KEY `dni` (`dni`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clientes`
--

LOCK TABLES `clientes` WRITE;
/*!40000 ALTER TABLE `clientes` DISABLE KEYS */;
INSERT INTO `clientes` VALUES ('0001','LUIS','GARCIA','MADRID'),('0002','ANTONIO','LOPEZ','VALENCIA'),('0003','JUAN','MARTIN','MADRID'),('0004','MARIA','GARCIA','MADRID'),('0005','JAVIER','GONZALEZ','BARCELONA'),('0006','ANA','LOPEZ','BARCELONA');
/*!40000 ALTER TABLE `clientes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `coches`
--

DROP TABLE IF EXISTS `coches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `coches` (
  `codcoche` varchar(3) COLLATE utf8_spanish_ci NOT NULL DEFAULT '',
  `cifm` varchar(4) COLLATE utf8_spanish_ci NOT NULL DEFAULT '',
  `nombre` varchar(15) COLLATE utf8_spanish_ci NOT NULL DEFAULT '',
  `modelo` varchar(15) COLLATE utf8_spanish_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`codcoche`),
  UNIQUE KEY `itodos` (`codcoche`,`nombre`,`modelo`),
  KEY `cifm` (`cifm`),
  KEY `codcoche` (`codcoche`),
  KEY `ITODO2` (`codcoche`,`cifm`,`nombre`,`modelo`),
  CONSTRAINT `coches_ibfk_1` FOREIGN KEY (`cifm`) REFERENCES `marcas` (`cifm`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `coches`
--

LOCK TABLES `coches` WRITE;
/*!40000 ALTER TABLE `coches` DISABLE KEYS */;
INSERT INTO `coches` VALUES ('001','0001','IBIZA','GLX'),('002','0001','IBIZA','GTI'),('003','0001','IBIZA','GTD'),('004','0001','TOLEDO','GTD'),('005','0001','CORDOBA','GTI'),('006','0002','MEGANE','1.6'),('007','0002','MEGANE','GTI'),('008','0002','LAGUNA','GTD'),('009','0002','LAGUNA','TD'),('010','0003','ZX','16V'),('011','0003','ZX','TD'),('012','0003','XANTIA','GTD'),('013','0004','A4','1.8'),('014','0004','A4','2.8'),('015','0005','ASTRA','CARAVAN'),('016','0005','ASTRA','GTI'),('017','0005','CORSA','1.4'),('018','0006','300','316i'),('019','0006','500','525i'),('020','0006','700','750i');
/*!40000 ALTER TABLE `coches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `concesionario`
--

DROP TABLE IF EXISTS `concesionario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `concesionario` (
  `cifc` varchar(4) COLLATE utf8_spanish_ci NOT NULL DEFAULT '',
  `nombre` varchar(4) COLLATE utf8_spanish_ci NOT NULL DEFAULT '',
  `ciudad` varchar(15) COLLATE utf8_spanish_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`cifc`),
  KEY `cifc` (`cifc`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `concesionario`
--

LOCK TABLES `concesionario` WRITE;
/*!40000 ALTER TABLE `concesionario` DISABLE KEYS */;
INSERT INTO `concesionario` VALUES ('0001','ACAR','MADRID'),('0002','BCAR','MADRID'),('0003','CCAR','BARCELONA'),('0004','DCAR','VALENCIA'),('0005','ECAR','BILBAO');
/*!40000 ALTER TABLE `concesionario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `distribucion`
--

DROP TABLE IF EXISTS `distribucion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `distribucion` (
  `cifc` varchar(4) COLLATE utf8_spanish_ci NOT NULL DEFAULT '',
  `codcoche` varchar(3) COLLATE utf8_spanish_ci NOT NULL DEFAULT '',
  `cantidad` smallint(6) NOT NULL DEFAULT '0',
  PRIMARY KEY (`cifc`,`codcoche`),
  KEY `codcoche` (`codcoche`),
  KEY `cifc` (`cifc`),
  CONSTRAINT `distribucion_ibfk_1` FOREIGN KEY (`cifc`) REFERENCES `concesionario` (`cifc`) ON UPDATE CASCADE,
  CONSTRAINT `distribucion_ibfk_2` FOREIGN KEY (`codcoche`) REFERENCES `coches` (`codcoche`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `distribucion`
--

LOCK TABLES `distribucion` WRITE;
/*!40000 ALTER TABLE `distribucion` DISABLE KEYS */;
INSERT INTO `distribucion` VALUES ('0001','001',8),('0001','005',20),('0001','006',10),('0002','006',5),('0002','008',10),('0002','009',10),('0003','010',5),('0003','011',3),('0003','012',5),('0004','013',10),('0004','014',5),('0005','015',10),('0005','016',20),('0005','017',8);
/*!40000 ALTER TABLE `distribucion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `marcas`
--

DROP TABLE IF EXISTS `marcas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `marcas` (
  `cifm` varchar(4) COLLATE utf8_spanish_ci NOT NULL DEFAULT '',
  `nombre` varchar(15) COLLATE utf8_spanish_ci NOT NULL DEFAULT '',
  `ciudad` varchar(15) COLLATE utf8_spanish_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`cifm`),
  UNIQUE KEY `ICIFM` (`cifm`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `marcas`
--

LOCK TABLES `marcas` WRITE;
/*!40000 ALTER TABLE `marcas` DISABLE KEYS */;
INSERT INTO `marcas` VALUES ('0001','SEAT','MADRID'),('0002','RENAULT','BARCELONA'),('0003','CITROEN','VALENCIA'),('0004','AUDI','MADRID'),('0005','OPEL','BILBAO'),('0006','BMW','BARCELONA');
/*!40000 ALTER TABLE `marcas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ventas`
--

DROP TABLE IF EXISTS `ventas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ventas` (
  `cifc` varchar(4) COLLATE utf8_spanish_ci NOT NULL DEFAULT '',
  `dni` varchar(4) COLLATE utf8_spanish_ci NOT NULL DEFAULT '',
  `codcoche` varchar(3) COLLATE utf8_spanish_ci NOT NULL DEFAULT '',
  `color` varchar(15) COLLATE utf8_spanish_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`cifc`,`dni`,`codcoche`),
  KEY `dni` (`dni`),
  KEY `codcoche` (`codcoche`),
  CONSTRAINT `ventas_ibfk_1` FOREIGN KEY (`cifc`) REFERENCES `concesionario` (`cifc`) ON UPDATE CASCADE,
  CONSTRAINT `ventas_ibfk_2` FOREIGN KEY (`dni`) REFERENCES `clientes` (`dni`) ON UPDATE CASCADE,
  CONSTRAINT `ventas_ibfk_3` FOREIGN KEY (`codcoche`) REFERENCES `coches` (`codcoche`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ventas`
--

LOCK TABLES `ventas` WRITE;
/*!40000 ALTER TABLE `ventas` DISABLE KEYS */;
INSERT INTO `ventas` VALUES ('0001','0001','001','BLANCO'),('0001','0002','005','ROJO'),('0002','0001','006','ROJO'),('0002','0003','008','BLANCO'),('0003','0004','011','ROJO'),('0004','0005','014','VERDE');
/*!40000 ALTER TABLE `ventas` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2012-02-07 21:48:42
