CREATE DATABASE  IF NOT EXISTS `centro_castracion` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `centro_castracion`;
-- MySQL dump 10.13  Distrib 8.0.44, for Win64 (x86_64)
--
-- Host: localhost    Database: centro_castracion
-- ------------------------------------------------------
-- Server version	8.0.44

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `adopcion`
--

DROP TABLE IF EXISTS `adopcion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `adopcion` (
  `id_adopcion` int NOT NULL AUTO_INCREMENT,
  `id_mascota` int NOT NULL,
  `id_propietario` int NOT NULL,
  `fecha` date NOT NULL,
  `observacion` text,
  PRIMARY KEY (`id_adopcion`),
  KEY `id_mascota` (`id_mascota`),
  KEY `id_propietario` (`id_propietario`),
  CONSTRAINT `adopcion_ibfk_1` FOREIGN KEY (`id_mascota`) REFERENCES `mascota` (`id_mascota`),
  CONSTRAINT `adopcion_ibfk_2` FOREIGN KEY (`id_propietario`) REFERENCES `propietario` (`id_propietario`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `adopcion`
--

LOCK TABLES `adopcion` WRITE;
/*!40000 ALTER TABLE `adopcion` DISABLE KEYS */;
INSERT INTO `adopcion` VALUES (1,2,3,'2026-06-10','Adopcion responsable'),(2,4,5,'2026-06-11','Seguimiento en 30 dias'),(3,6,7,'2026-06-12','Adopcion aprobada'),(4,8,2,'2026-06-13','Animal recuperado'),(5,9,1,'2026-06-14','Sin observaciones'),(6,1,4,'2026-06-15','Adopcion responsable'),(7,3,6,'2026-06-16','Seguimiento'),(8,5,8,'2026-06-17','Adopcion aprobada'),(9,7,9,'2026-06-18','Sin problemas'),(10,10,10,'2026-06-19','Adopcion finalizada');
/*!40000 ALTER TABLE `adopcion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `castracion`
--

DROP TABLE IF EXISTS `castracion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `castracion` (
  `id_castracion` int NOT NULL AUTO_INCREMENT,
  `id_turno` int NOT NULL,
  `id_veterinario` int NOT NULL,
  `id_personal` int NOT NULL,
  `fecha` date NOT NULL,
  `hora` time NOT NULL,
  `observacion` text,
  `monto_pagado` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id_castracion`),
  KEY `id_turno` (`id_turno`),
  KEY `id_veterinario` (`id_veterinario`),
  KEY `id_personal` (`id_personal`),
  CONSTRAINT `castracion_ibfk_1` FOREIGN KEY (`id_turno`) REFERENCES `turno` (`id_turno`),
  CONSTRAINT `castracion_ibfk_2` FOREIGN KEY (`id_veterinario`) REFERENCES `veterinario` (`id_veterinario`),
  CONSTRAINT `castracion_ibfk_3` FOREIGN KEY (`id_personal`) REFERENCES `personal` (`id_personal`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `castracion`
--

LOCK TABLES `castracion` WRITE;
/*!40000 ALTER TABLE `castracion` DISABLE KEYS */;
INSERT INTO `castracion` VALUES (1,1,1,1,'2026-06-01','09:00:00','Sin complicaciones',15000.00),(2,2,2,2,'2026-06-01','10:00:00','Recuperacion normal',15000.00),(3,3,3,3,'2026-06-01','11:00:00','Todo correcto',15000.00),(4,4,1,4,'2026-06-02','09:00:00','Sin complicaciones',15000.00),(5,5,2,5,'2026-06-02','10:00:00','Todo bien',15000.00),(6,6,3,6,'2026-06-02','11:00:00','Animal nervioso',15000.00),(7,7,4,7,'2026-06-03','09:00:00','Sin problemas',15000.00),(8,8,5,8,'2026-06-03','10:00:00','Todo normal',15000.00),(9,9,6,9,'2026-06-03','11:00:00','Recuperacion rapida',15000.00),(10,10,7,10,'2026-06-04','09:00:00','Sin observaciones',15000.00);
/*!40000 ALTER TABLE `castracion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `compra`
--

DROP TABLE IF EXISTS `compra`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `compra` (
  `id_compra` int NOT NULL AUTO_INCREMENT,
  `id_proveedor` int NOT NULL,
  `id_producto` int NOT NULL,
  `monto_compra` decimal(10,2) NOT NULL,
  `fecha` date NOT NULL,
  PRIMARY KEY (`id_compra`),
  KEY `id_proveedor` (`id_proveedor`),
  KEY `id_producto` (`id_producto`),
  CONSTRAINT `compra_ibfk_1` FOREIGN KEY (`id_proveedor`) REFERENCES `proveedor` (`id_proveedor`),
  CONSTRAINT `compra_ibfk_2` FOREIGN KEY (`id_producto`) REFERENCES `producto` (`id_producto`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `compra`
--

LOCK TABLES `compra` WRITE;
/*!40000 ALTER TABLE `compra` DISABLE KEYS */;
INSERT INTO `compra` VALUES (1,1,1,5000.00,'2026-06-01'),(2,2,2,7000.00,'2026-06-01'),(3,3,3,6000.00,'2026-06-02'),(4,1,4,2000.00,'2026-06-02'),(5,2,5,2500.00,'2026-06-03'),(6,3,6,3000.00,'2026-06-03'),(7,1,7,4000.00,'2026-06-04'),(8,2,8,3500.00,'2026-06-04'),(9,3,9,2000.00,'2026-06-05'),(10,1,10,1500.00,'2026-06-05');
/*!40000 ALTER TABLE `compra` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ingreso_animal`
--

DROP TABLE IF EXISTS `ingreso_animal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ingreso_animal` (
  `id_ingreso` int NOT NULL AUTO_INCREMENT,
  `id_mascota` int NOT NULL,
  `motivo_ingreso` varchar(200) DEFAULT NULL,
  `fecha` date NOT NULL,
  `observacion` text,
  PRIMARY KEY (`id_ingreso`),
  KEY `id_mascota` (`id_mascota`),
  CONSTRAINT `ingreso_animal_ibfk_1` FOREIGN KEY (`id_mascota`) REFERENCES `mascota` (`id_mascota`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ingreso_animal`
--

LOCK TABLES `ingreso_animal` WRITE;
/*!40000 ALTER TABLE `ingreso_animal` DISABLE KEYS */;
INSERT INTO `ingreso_animal` VALUES (1,1,'Abandono','2026-05-20','Sin problemas'),(2,2,'Rescate','2026-05-21','Encontrado en la calle'),(3,3,'Rescate','2026-05-22','Sano'),(4,4,'Rescate','2026-05-23','Desnutrido'),(5,5,'Judicial','2026-05-24','Todo bien'),(6,6,'Rescate','2026-05-25','Herida leve'),(7,7,'Judicial','2026-05-26','Sano'),(8,8,'Rescate','2026-05-27','Recuperándose'),(9,9,'Abandono','2026-05-28','Sano'),(10,10,'Abandono','2026-05-29','Encontrado abandonado');
/*!40000 ALTER TABLE `ingreso_animal` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ingresos_pesos`
--

DROP TABLE IF EXISTS `ingresos_pesos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ingresos_pesos` (
  `id_ingreso` int NOT NULL AUTO_INCREMENT,
  `id_castracion` int DEFAULT NULL,
  `tipo_ingreso` varchar(100) DEFAULT NULL,
  `monto_ingreso` decimal(10,2) NOT NULL,
  `fecha` date NOT NULL,
  PRIMARY KEY (`id_ingreso`),
  KEY `id_castracion` (`id_castracion`),
  CONSTRAINT `ingresos_pesos_ibfk_1` FOREIGN KEY (`id_castracion`) REFERENCES `castracion` (`id_castracion`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ingresos_pesos`
--

LOCK TABLES `ingresos_pesos` WRITE;
/*!40000 ALTER TABLE `ingresos_pesos` DISABLE KEYS */;
INSERT INTO `ingresos_pesos` VALUES (1,1,'Castracion',15000.00,'2026-06-01'),(2,2,'Castracion',15000.00,'2026-06-01'),(3,3,'Castracion',15000.00,'2026-06-01'),(4,4,'Castracion',15000.00,'2026-06-02'),(5,5,'Castracion',15000.00,'2026-06-02'),(6,6,'Castracion',15000.00,'2026-06-02'),(7,7,'Castracion',15000.00,'2026-06-03'),(8,8,'Castracion',15000.00,'2026-06-03'),(9,9,'Castracion',15000.00,'2026-06-03'),(10,10,'Castracion',15000.00,'2026-06-04');
/*!40000 ALTER TABLE `ingresos_pesos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mascota`
--

DROP TABLE IF EXISTS `mascota`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mascota` (
  `id_mascota` int NOT NULL AUTO_INCREMENT,
  `id_propietario` int NOT NULL,
  `nombre` varchar(100) DEFAULT NULL,
  `especie` varchar(50) DEFAULT NULL,
  `raza` varchar(50) DEFAULT NULL,
  `edad` int DEFAULT NULL,
  `sexo` varchar(10) DEFAULT NULL,
  `peso` decimal(5,2) DEFAULT NULL,
  `pelaje` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_mascota`),
  KEY `id_propietario` (`id_propietario`),
  CONSTRAINT `mascota_ibfk_1` FOREIGN KEY (`id_propietario`) REFERENCES `propietario` (`id_propietario`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mascota`
--

LOCK TABLES `mascota` WRITE;
/*!40000 ALTER TABLE `mascota` DISABLE KEYS */;
INSERT INTO `mascota` VALUES (1,1,'Firulais','Perro','Mestizo',3,'Macho',12.50,'Blanco'),(2,2,'Michi','Gato','Siames',2,'Hembra',4.20,'Marron'),(3,3,'Rex','Perro','Labrador',5,'Macho',25.00,'Blanco'),(4,4,'Luna','Gato','Persa',4,'Hembra',3.80,'Negro'),(5,5,'Toby','Perro','Caniche',6,'Macho',7.00,'Amarillo'),(6,6,'Nala','Gato','Mestizo',1,'Hembra',3.00,'Blanco'),(7,7,'Rocky','Perro','Boxer',4,'Macho',28.00,'Blanco'),(8,8,'Kira','Perro','Ovejero',2,'Hembra',20.00,'Negro'),(9,9,'Simba','Gato','Mestizo',3,'Macho',4.00,'Marron'),(10,10,'Lola','Perro','Beagle',5,'Hembra',15.00,'Blanco');
/*!40000 ALTER TABLE `mascota` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pago_servicios`
--

DROP TABLE IF EXISTS `pago_servicios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pago_servicios` (
  `id_pago` int NOT NULL AUTO_INCREMENT,
  `id_proveedor` int NOT NULL,
  `monto_servicio` decimal(10,2) NOT NULL,
  `fecha` date NOT NULL,
  PRIMARY KEY (`id_pago`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pago_servicios`
--

LOCK TABLES `pago_servicios` WRITE;
/*!40000 ALTER TABLE `pago_servicios` DISABLE KEYS */;
INSERT INTO `pago_servicios` VALUES (1,4,20000.00,'2026-06-01'),(2,5,18000.00,'2026-06-01'),(3,8,15000.00,'2026-06-02'),(4,4,21000.00,'2026-06-02'),(5,5,17500.00,'2026-06-03'),(6,8,16000.00,'2026-06-03'),(7,4,22000.00,'2026-06-04'),(8,5,18000.00,'2026-06-04'),(9,8,17000.00,'2026-06-05'),(10,4,20000.00,'2026-06-05');
/*!40000 ALTER TABLE `pago_servicios` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `validar_proveedor_pago` BEFORE INSERT ON `pago_servicios` FOR EACH ROW BEGIN

IF NOT EXISTS (
    SELECT 1
    FROM proveedor
    WHERE id_proveedor = NEW.id_proveedor
) THEN

SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'El proveedor no existe. Debe registrarse previamente.';

END IF;

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `personal`
--

DROP TABLE IF EXISTS `personal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `personal` (
  `id_personal` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `rol` varchar(50) NOT NULL,
  `telefono` varchar(30) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id_personal`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `personal`
--

LOCK TABLES `personal` WRITE;
/*!40000 ALTER TABLE `personal` DISABLE KEYS */;
INSERT INTO `personal` VALUES (1,'Carlos Medina','Asistente','351200001','carlos@centro.com'),(2,'Ana Lopez','Asistente','351200002','ana@centro.com'),(3,'Pedro Gomez','Administrativo','351200003','pedro@centro.com'),(4,'Laura Diaz','Recepcion','351200004','laura@centro.com'),(5,'Miguel Ruiz','Asistente','351200005','miguel@centro.com'),(6,'Julia Perez','Recepcion','351200006','julia@centro.com'),(7,'Lucas Torres','Administrativo','351200007','lucas@centro.com'),(8,'Paula Sosa','Asistente','351200008','paula@centro.com'),(9,'Mario Vega','Mantenimiento','351200009','mario@centro.com'),(10,'Carla Rojas','Recepcion','351200010','carla@centro.com');
/*!40000 ALTER TABLE `personal` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `producto`
--

DROP TABLE IF EXISTS `producto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `producto` (
  `id_producto` int NOT NULL AUTO_INCREMENT,
  `descripcion_producto` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id_producto`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `producto`
--

LOCK TABLES `producto` WRITE;
/*!40000 ALTER TABLE `producto` DISABLE KEYS */;
INSERT INTO `producto` VALUES (1,'Vacuna antirrabica'),(2,'Anestesia'),(3,'Antibiotico'),(4,'Gasas'),(5,'Jeringas'),(6,'Guantes'),(7,'Suturas'),(8,'Desinfectante'),(9,'Alcohol'),(10,'Vendajes');
/*!40000 ALTER TABLE `producto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `propietario`
--

DROP TABLE IF EXISTS `propietario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `propietario` (
  `id_propietario` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `dni` varchar(15) NOT NULL,
  `direccion` varchar(150) DEFAULT NULL,
  `localidad` varchar(100) DEFAULT NULL,
  `telefono` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id_propietario`),
  UNIQUE KEY `dni` (`dni`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `propietario`
--

LOCK TABLES `propietario` WRITE;
/*!40000 ALTER TABLE `propietario` DISABLE KEYS */;
INSERT INTO `propietario` VALUES (1,'Juan Perez','30111222','Calle 1','Alta Gracia','351111111'),(2,'Maria Gomez','28999111','Calle 2','Anisacate','351222222'),(3,'Luis Diaz','31222333','Calle 3','Los talas','351333333'),(4,'Ana Torres','29888777','Calle 4','Los chañiaritos','351444444'),(5,'Pedro Ruiz','32222111','Calle 5','Alta Gracia','351555555'),(6,'Laura Medina','33444555','Calle 6','Anisacate','351666666'),(7,'Carlos Sosa','35555666','Calle 7','Alta Gracia','351777777'),(8,'Lucia Rojas','36666777','Calle 8','Anisacate','351888888'),(9,'Martin Lopez','37777888','Calle 9','Alta Gracia','351999999'),(10,'Sofia Vega','38888999','Calle 10','Los talas','351101010');
/*!40000 ALTER TABLE `propietario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `proveedor`
--

DROP TABLE IF EXISTS `proveedor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `proveedor` (
  `id_proveedor` int NOT NULL AUTO_INCREMENT,
  `tipo_servicio` varchar(50) NOT NULL,
  `nombre` varchar(150) NOT NULL,
  `telefono` varchar(30) DEFAULT NULL,
  `direccion` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`id_proveedor`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proveedor`
--

LOCK TABLES `proveedor` WRITE;
/*!40000 ALTER TABLE `proveedor` DISABLE KEYS */;
INSERT INTO `proveedor` VALUES (1,'Insumos','VetSupply','351400001','Cordoba'),(2,'Insumos','AnimalMed','351400002','Cordoba'),(3,'Medicamentos','Farmavet','351400003','Cordoba'),(4,'Servicios','Limpieza SRL','351400004','Alta Gracia'),(5,'Servicios','Electricidad AG','351400005','Alta Gracia'),(6,'Insumos','Distribuidora Vet','351400006','Cordoba'),(7,'Medicamentos','BioVet','351400007','Cordoba'),(8,'Servicios','Agua y Gas','351400008','Alta Gracia'),(9,'Insumos','VetPro','351400009','Cordoba'),(10,'Medicamentos','PetMed','351400010','Cordoba');
/*!40000 ALTER TABLE `proveedor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `turno`
--

DROP TABLE IF EXISTS `turno`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `turno` (
  `id_turno` int NOT NULL AUTO_INCREMENT,
  `id_mascota` int NOT NULL,
  `fecha_turno` date NOT NULL,
  `hora_turno` time NOT NULL,
  `programado` tinyint(1) NOT NULL,
  `asistio` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id_turno`),
  KEY `id_mascota` (`id_mascota`),
  CONSTRAINT `turno_ibfk_1` FOREIGN KEY (`id_mascota`) REFERENCES `mascota` (`id_mascota`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `turno`
--

LOCK TABLES `turno` WRITE;
/*!40000 ALTER TABLE `turno` DISABLE KEYS */;
INSERT INTO `turno` VALUES (1,1,'2026-06-01','09:00:00',1,1),(2,2,'2026-06-01','10:00:00',1,1),(3,3,'2026-06-01','11:00:00',1,1),(4,4,'2026-06-02','09:00:00',1,1),(5,5,'2026-06-02','10:00:00',1,1),(6,6,'2026-06-02','11:00:00',0,1),(7,7,'2026-06-03','09:00:00',1,0),(8,8,'2026-06-03','10:00:00',1,0),(9,9,'2026-06-03','11:00:00',1,1),(10,10,'2026-06-04','09:00:00',1,1);
/*!40000 ALTER TABLE `turno` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `validar_turno_horario` BEFORE INSERT ON `turno` FOR EACH ROW BEGIN

IF EXISTS (
    SELECT 1
    FROM turno
    WHERE fecha_turno = NEW.fecha_turno
    AND hora_turno = NEW.hora_turno
) THEN

SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'Ya existe un turno asignado para esa fecha y hora';

END IF;

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `vacunacion`
--

DROP TABLE IF EXISTS `vacunacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vacunacion` (
  `id_vacunacion` int NOT NULL AUTO_INCREMENT,
  `id_mascota` int NOT NULL,
  `id_compra` int NOT NULL,
  `fecha` date NOT NULL,
  `observacion` text,
  PRIMARY KEY (`id_vacunacion`),
  KEY `id_mascota` (`id_mascota`),
  KEY `id_compra` (`id_compra`),
  CONSTRAINT `vacunacion_ibfk_1` FOREIGN KEY (`id_mascota`) REFERENCES `mascota` (`id_mascota`),
  CONSTRAINT `vacunacion_ibfk_2` FOREIGN KEY (`id_compra`) REFERENCES `compra` (`id_compra`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vacunacion`
--

LOCK TABLES `vacunacion` WRITE;
/*!40000 ALTER TABLE `vacunacion` DISABLE KEYS */;
INSERT INTO `vacunacion` VALUES (1,1,1,'2026-06-02','Vacuna anual'),(2,2,1,'2026-06-02','Vacuna anual'),(3,3,1,'2026-06-02','Vacuna anual'),(4,4,1,'2026-06-03','Vacuna anual'),(5,5,1,'2026-06-03','Vacuna anual'),(6,6,1,'2026-06-04','Vacuna anual'),(7,7,1,'2026-06-04','Vacuna anual'),(8,8,1,'2026-06-04','Vacuna anual'),(9,9,1,'2026-06-05','Vacuna anual'),(10,10,1,'2026-06-05','Vacuna anual');
/*!40000 ALTER TABLE `vacunacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `veterinario`
--

DROP TABLE IF EXISTS `veterinario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `veterinario` (
  `id_veterinario` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `matricula` varchar(50) NOT NULL,
  `telefono` varchar(30) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id_veterinario`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `veterinario`
--

LOCK TABLES `veterinario` WRITE;
/*!40000 ALTER TABLE `veterinario` DISABLE KEYS */;
INSERT INTO `veterinario` VALUES (1,'Dr. Fernandez','MAT001','351300001','vet1@centro.com'),(2,'Dr. Alvarez','MAT002','351300002','vet2@centro.com'),(3,'Dra. Lopez','MAT003','351300003','vet3@centro.com'),(4,'Dr. Sosa','MAT004','351300004','vet4@centro.com'),(5,'Dra. Medina','MAT005','351300005','vet5@centro.com'),(6,'Dr. Ruiz','MAT006','351300006','vet6@centro.com'),(7,'Dra. Torres','MAT007','351300007','vet7@centro.com'),(8,'Dr. Vega','MAT008','351300008','vet8@centro.com'),(9,'Dra. Rojas','MAT009','351300009','vet9@centro.com'),(10,'Dr. Diaz','MAT010','351300010','vet10@centro.com');
/*!40000 ALTER TABLE `veterinario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `vista_balance_mensual`
--

DROP TABLE IF EXISTS `vista_balance_mensual`;
/*!50001 DROP VIEW IF EXISTS `vista_balance_mensual`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vista_balance_mensual` AS SELECT 
 1 AS `anio`,
 1 AS `mes`,
 1 AS `total_ingresos`,
 1 AS `total_egresos`,
 1 AS `balance`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vista_castraciones_realizadas`
--

DROP TABLE IF EXISTS `vista_castraciones_realizadas`;
/*!50001 DROP VIEW IF EXISTS `vista_castraciones_realizadas`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vista_castraciones_realizadas` AS SELECT 
 1 AS `id_castracion`,
 1 AS `fecha`,
 1 AS `hora`,
 1 AS `id_mascota`,
 1 AS `mascota`,
 1 AS `sexo`,
 1 AS `id_veterinario`,
 1 AS `veterinario`,
 1 AS `id_personal`,
 1 AS `asistente`,
 1 AS `rol`,
 1 AS `observacion`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vista_turnos_mascota`
--

DROP TABLE IF EXISTS `vista_turnos_mascota`;
/*!50001 DROP VIEW IF EXISTS `vista_turnos_mascota`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vista_turnos_mascota` AS SELECT 
 1 AS `id_turno`,
 1 AS `fecha_turno`,
 1 AS `hora_turno`,
 1 AS `programado`,
 1 AS `nombre_mascota`,
 1 AS `especie`,
 1 AS `sexo`,
 1 AS `nombre_propietario`,
 1 AS `telefono`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping routines for database 'centro_castracion'
--
/*!50003 DROP FUNCTION IF EXISTS `total_castraciones_mes_sexo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `total_castraciones_mes_sexo`(p_mes INT, p_anio INT, p_sexo VARCHAR(10)) RETURNS int
    DETERMINISTIC
BEGIN

    DECLARE total INT;

    SELECT COUNT(*)
    INTO total
    FROM castracion c
    JOIN turno t ON c.id_turno = t.id_turno
    JOIN mascota m ON t.id_mascota = m.id_mascota
    WHERE MONTH(c.fecha) = p_mes
    AND YEAR(c.fecha) = p_anio
    AND m.sexo = p_sexo;

    RETURN IFNULL(total,0);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `total_ingresos_mes` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `total_ingresos_mes`(p_mes INT, p_anio INT) RETURNS decimal(10,2)
    DETERMINISTIC
BEGIN

    DECLARE total DECIMAL(10,2);

    SELECT SUM(monto_ingreso)
    INTO total
    FROM ingresos_pesos
    WHERE MONTH(fecha) = p_mes
    AND YEAR(fecha) = p_anio;

    RETURN IFNULL(total,0);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `registrar_castracion` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `registrar_castracion`(
    IN p_id_turno INT,
    IN p_id_veterinario INT,
    IN p_id_personal INT,
    IN p_fecha DATE,
    IN p_hora TIME,
    IN p_observacion TEXT,
    IN p_monto DECIMAL(10,2)
)
BEGIN

DECLARE v_id_castracion INT;

-- insertar castracion
INSERT INTO castracion(
    id_turno,
    id_veterinario,
    id_personal,
    fecha,
    hora,
    observacion,
    monto_pagado
)
VALUES(
    p_id_turno,
    p_id_veterinario,
    p_id_personal,
    p_fecha,
    p_hora,
    p_observacion,
    p_monto
);

-- obtener id generado
SET v_id_castracion = LAST_INSERT_ID();

-- registrar ingreso
INSERT INTO ingresos(
    id_castracion,
    tipo_ingreso,
    monto_ingreso,
    fecha
)
VALUES(
    v_id_castracion,
    'Castracion',
    p_monto,
    p_fecha
);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `registrar_turno` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `registrar_turno`(
    IN p_id_mascota INT,
    IN p_fecha DATE,
    IN p_hora TIME,
    IN p_programado BOOLEAN
)
BEGIN

INSERT INTO turno(
    id_mascota,
    fecha_turno,
    hora_turno,
    programado
)
VALUES(
    p_id_mascota,
    p_fecha,
    p_hora,
    p_programado
);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `vista_balance_mensual`
--

/*!50001 DROP VIEW IF EXISTS `vista_balance_mensual`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vista_balance_mensual` AS select year(`movimientos`.`fecha`) AS `anio`,month(`movimientos`.`fecha`) AS `mes`,sum(`movimientos`.`ingresos`) AS `total_ingresos`,sum(`movimientos`.`egresos`) AS `total_egresos`,(sum(`movimientos`.`ingresos`) - sum(`movimientos`.`egresos`)) AS `balance` from (select `ingresos_pesos`.`fecha` AS `fecha`,`ingresos_pesos`.`monto_ingreso` AS `ingresos`,0 AS `egresos` from `ingresos_pesos` union all select `pago_servicios`.`fecha` AS `fecha`,0 AS `ingresos`,`pago_servicios`.`monto_servicio` AS `egresos` from `pago_servicios` union all select `compra`.`fecha` AS `fecha`,0 AS `ingresos`,`compra`.`monto_compra` AS `egresos` from `compra`) `movimientos` group by `anio`,`mes` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vista_castraciones_realizadas`
--

/*!50001 DROP VIEW IF EXISTS `vista_castraciones_realizadas`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vista_castraciones_realizadas` AS select `c`.`id_castracion` AS `id_castracion`,`c`.`fecha` AS `fecha`,`c`.`hora` AS `hora`,`m`.`id_mascota` AS `id_mascota`,`m`.`nombre` AS `mascota`,`m`.`sexo` AS `sexo`,`v`.`id_veterinario` AS `id_veterinario`,`v`.`nombre` AS `veterinario`,`per`.`id_personal` AS `id_personal`,`per`.`nombre` AS `asistente`,`per`.`rol` AS `rol`,`c`.`observacion` AS `observacion` from ((((`castracion` `c` join `turno` `t` on((`c`.`id_turno` = `t`.`id_turno`))) join `mascota` `m` on((`t`.`id_mascota` = `m`.`id_mascota`))) join `veterinario` `v` on((`c`.`id_veterinario` = `v`.`id_veterinario`))) join `personal` `per` on((`c`.`id_personal` = `per`.`id_personal`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vista_turnos_mascota`
--

/*!50001 DROP VIEW IF EXISTS `vista_turnos_mascota`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vista_turnos_mascota` AS select `t`.`id_turno` AS `id_turno`,`t`.`fecha_turno` AS `fecha_turno`,`t`.`hora_turno` AS `hora_turno`,`t`.`programado` AS `programado`,`m`.`nombre` AS `nombre_mascota`,`m`.`especie` AS `especie`,`m`.`sexo` AS `sexo`,`p`.`nombre` AS `nombre_propietario`,`p`.`telefono` AS `telefono` from ((`turno` `t` join `mascota` `m` on((`t`.`id_mascota` = `m`.`id_mascota`))) join `propietario` `p` on((`m`.`id_propietario` = `p`.`id_propietario`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-04-16 18:46:18
