-- =====================================================================
-- biblioteca_v2 · Exemplo de Banco de Dados (Aula 09)
-- Prof. Flávio Copola Azenha
--
-- Evolução do banco biblioteca das aulas anteriores:
--   livro:             qtd_exemplares, qtd_disponivel e
--                      CONSTRAINT ck_livro_disponivel
--                      CHECK (qtd_disponivel BETWEEN 0 AND qtd_exemplares)
--   livro_has_usuario: data_devolucao (NULL = empréstimo ativo) e
--                      data_retirada na chave primária
--   usuario:           multa e CONSTRAINT ck_usuario_multa CHECK (multa >= 0)
-- Regra de consistência: qtd_exemplares = qtd_disponivel + empréstimos ativos.
--
-- Importação:
--   MySQL Workbench > Server > Data Import > Import from Self-Contained File
--   > selecionar este arquivo > Start Import
--   ou, no terminal: mysql -u root -p < biblioteca_v2.sql
-- Requer MySQL 8.0.16 ou superior (aplicação das restrições CHECK).
-- =====================================================================

-- MySQL dump 10.13  Distrib 8.0.46, for Linux (x86_64)
--
-- Host: localhost    Database: biblioteca_v2
-- ------------------------------------------------------
-- Server version	8.0.46

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
-- Current Database: `biblioteca_v2`
--

/*!40000 DROP DATABASE IF EXISTS `biblioteca_v2`*/;

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `biblioteca_v2` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `biblioteca_v2`;

--
-- Table structure for table `curso`
--

DROP TABLE IF EXISTS `curso`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `curso` (
  `pk_curso_id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `turno` varchar(50) NOT NULL,
  PRIMARY KEY (`pk_curso_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `curso`
--

LOCK TABLES `curso` WRITE;
/*!40000 ALTER TABLE `curso` DISABLE KEYS */;
INSERT INTO `curso` (`pk_curso_id`, `nome`, `turno`) VALUES (1,'Engenharia de ProduÃ§Ã£o','Matutino');
INSERT INTO `curso` (`pk_curso_id`, `nome`, `turno`) VALUES (2,'CiÃªncia da ComputaÃ§Ã£o','Noturno');
INSERT INTO `curso` (`pk_curso_id`, `nome`, `turno`) VALUES (3,'AdministraÃ§Ã£o','Vespertino');
INSERT INTO `curso` (`pk_curso_id`, `nome`, `turno`) VALUES (4,'Direito','Integral');
INSERT INTO `curso` (`pk_curso_id`, `nome`, `turno`) VALUES (5,'Engenharia Civil','Matutino');
INSERT INTO `curso` (`pk_curso_id`, `nome`, `turno`) VALUES (6,'Psicologia','Noturno');
INSERT INTO `curso` (`pk_curso_id`, `nome`, `turno`) VALUES (7,'Arquitetura e Urbanismo','Vespertino');
INSERT INTO `curso` (`pk_curso_id`, `nome`, `turno`) VALUES (8,'Engenharia ElÃ©trica','Integral');
/*!40000 ALTER TABLE `curso` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `editora`
--

DROP TABLE IF EXISTS `editora`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `editora` (
  `pk_editora_id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `cidade` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`pk_editora_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `editora`
--

LOCK TABLES `editora` WRITE;
/*!40000 ALTER TABLE `editora` DISABLE KEYS */;
INSERT INTO `editora` (`pk_editora_id`, `nome`, `cidade`) VALUES (1,'Companhia das Letras','SÃ£o Paulo');
INSERT INTO `editora` (`pk_editora_id`, `nome`, `cidade`) VALUES (2,'Record','Rio de Janeiro');
INSERT INTO `editora` (`pk_editora_id`, `nome`, `cidade`) VALUES (3,'Rocco','Rio de Janeiro');
INSERT INTO `editora` (`pk_editora_id`, `nome`, `cidade`) VALUES (4,'IntrÃ­nseca','Rio de Janeiro');
INSERT INTO `editora` (`pk_editora_id`, `nome`, `cidade`) VALUES (5,'Globo Livros','SÃ£o Paulo');
INSERT INTO `editora` (`pk_editora_id`, `nome`, `cidade`) VALUES (6,'Sextante','Rio de Janeiro');
INSERT INTO `editora` (`pk_editora_id`, `nome`, `cidade`) VALUES (7,'Editora Aleph','SÃ£o Paulo');
INSERT INTO `editora` (`pk_editora_id`, `nome`, `cidade`) VALUES (8,'Zahar','Rio de Janeiro');
INSERT INTO `editora` (`pk_editora_id`, `nome`, `cidade`) VALUES (9,'Planeta','SÃ£o Paulo');
INSERT INTO `editora` (`pk_editora_id`, `nome`, `cidade`) VALUES (10,'Leya Brasil','SÃ£o Paulo');
INSERT INTO `editora` (`pk_editora_id`, `nome`, `cidade`) VALUES (11,'Nova Fronteira','Rio de Janeiro');
INSERT INTO `editora` (`pk_editora_id`, `nome`, `cidade`) VALUES (12,'AutÃªntica Editora','Belo Horizonte');
/*!40000 ALTER TABLE `editora` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `livro`
--

DROP TABLE IF EXISTS `livro`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `livro` (
  `pk_livro_id` int NOT NULL AUTO_INCREMENT,
  `titulo` varchar(200) NOT NULL,
  `autor` varchar(200) NOT NULL,
  `ano` int NOT NULL,
  `isbn` varchar(50) NOT NULL,
  `fk_editora_id` int NOT NULL,
  `qtd_exemplares` int NOT NULL DEFAULT '1',
  `qtd_disponivel` int NOT NULL DEFAULT '1',
  PRIMARY KEY (`pk_livro_id`),
  KEY `fk_livro_editora` (`fk_editora_id`),
  CONSTRAINT `fk_livro_editora` FOREIGN KEY (`fk_editora_id`) REFERENCES `editora` (`pk_editora_id`),
  CONSTRAINT `ck_livro_disponivel` CHECK ((`qtd_disponivel` between 0 and `qtd_exemplares`))
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `livro`
--

LOCK TABLES `livro` WRITE;
/*!40000 ALTER TABLE `livro` DISABLE KEYS */;
INSERT INTO `livro` (`pk_livro_id`, `titulo`, `autor`, `ano`, `isbn`, `fk_editora_id`, `qtd_exemplares`, `qtd_disponivel`) VALUES (1,'Torto Arado','Itamar Vieira Junior',2019,'978-8-6999-3867-7',2,3,2);
INSERT INTO `livro` (`pk_livro_id`, `titulo`, `autor`, `ano`, `isbn`, `fk_editora_id`, `qtd_exemplares`, `qtd_disponivel`) VALUES (2,'O Sol Ã© para Todos','Harper Lee',1960,'978-9-6499-0913-3',5,2,2);
INSERT INTO `livro` (`pk_livro_id`, `titulo`, `autor`, `ano`, `isbn`, `fk_editora_id`, `qtd_exemplares`, `qtd_disponivel`) VALUES (3,'A Menina que Roubava Livros','Markus Zusak',2005,'978-1-2328-1206-7',5,1,1);
INSERT INTO `livro` (`pk_livro_id`, `titulo`, `autor`, `ano`, `isbn`, `fk_editora_id`, `qtd_exemplares`, `qtd_disponivel`) VALUES (4,'Ensaio sobre a Cegueira','JosÃ© Saramago',1995,'978-9-7403-4471-3',12,2,2);
INSERT INTO `livro` (`pk_livro_id`, `titulo`, `autor`, `ano`, `isbn`, `fk_editora_id`, `qtd_exemplares`, `qtd_disponivel`) VALUES (5,'A Hora da Estrela','Clarice Lispector',1977,'978-9-3618-3242-1',5,2,2);
INSERT INTO `livro` (`pk_livro_id`, `titulo`, `autor`, `ano`, `isbn`, `fk_editora_id`, `qtd_exemplares`, `qtd_disponivel`) VALUES (6,'Grande SertÃ£o: Veredas','GuimarÃ£es Rosa',1956,'978-2-4994-7174-6',1,3,2);
INSERT INTO `livro` (`pk_livro_id`, `titulo`, `autor`, `ano`, `isbn`, `fk_editora_id`, `qtd_exemplares`, `qtd_disponivel`) VALUES (7,'Sapiens: Uma Breve HistÃ³ria da Humanidade','Yuval Noah Harari',2011,'978-8-8771-9065-9',5,2,1);
INSERT INTO `livro` (`pk_livro_id`, `titulo`, `autor`, `ano`, `isbn`, `fk_editora_id`, `qtd_exemplares`, `qtd_disponivel`) VALUES (8,'O Poder do HÃ¡bito','Charles Duhigg',2012,'978-0-1399-0490-2',5,3,1);
INSERT INTO `livro` (`pk_livro_id`, `titulo`, `autor`, `ano`, `isbn`, `fk_editora_id`, `qtd_exemplares`, `qtd_disponivel`) VALUES (9,'A RevoluÃ§Ã£o dos Bichos','George Orwell',1945,'978-8-7429-6717-5',8,3,3);
INSERT INTO `livro` (`pk_livro_id`, `titulo`, `autor`, `ano`, `isbn`, `fk_editora_id`, `qtd_exemplares`, `qtd_disponivel`) VALUES (10,'1984','George Orwell',1949,'978-5-5125-6746-8',7,2,2);
INSERT INTO `livro` (`pk_livro_id`, `titulo`, `autor`, `ano`, `isbn`, `fk_editora_id`, `qtd_exemplares`, `qtd_disponivel`) VALUES (11,'Cem Anos de SolidÃ£o','Gabriel GarcÃ­a MÃ¡rquez',1967,'978-7-1545-1680-8',1,3,2);
INSERT INTO `livro` (`pk_livro_id`, `titulo`, `autor`, `ano`, `isbn`, `fk_editora_id`, `qtd_exemplares`, `qtd_disponivel`) VALUES (12,'O Alquimista','Paulo Coelho',1988,'978-6-0385-9770-3',8,1,1);
INSERT INTO `livro` (`pk_livro_id`, `titulo`, `autor`, `ano`, `isbn`, `fk_editora_id`, `qtd_exemplares`, `qtd_disponivel`) VALUES (13,'Vidas Secas','Graciliano Ramos',1938,'978-8-2477-1093-2',5,1,1);
INSERT INTO `livro` (`pk_livro_id`, `titulo`, `autor`, `ano`, `isbn`, `fk_editora_id`, `qtd_exemplares`, `qtd_disponivel`) VALUES (14,'Dom Casmurro','Machado de Assis',1899,'978-8-0861-3171-2',5,2,0);
INSERT INTO `livro` (`pk_livro_id`, `titulo`, `autor`, `ano`, `isbn`, `fk_editora_id`, `qtd_exemplares`, `qtd_disponivel`) VALUES (15,'A Culpa Ã© das Estrelas','John Green',2012,'978-4-8467-7378-2',8,1,1);
INSERT INTO `livro` (`pk_livro_id`, `titulo`, `autor`, `ano`, `isbn`, `fk_editora_id`, `qtd_exemplares`, `qtd_disponivel`) VALUES (16,'AdmirÃ¡vel Mundo Novo','Aldous Huxley',1932,'978-3-9821-4658-4',7,1,1);
INSERT INTO `livro` (`pk_livro_id`, `titulo`, `autor`, `ano`, `isbn`, `fk_editora_id`, `qtd_exemplares`, `qtd_disponivel`) VALUES (17,'O Nome do Vento','Patrick Rothfuss',2007,'978-4-4997-2787-5',1,5,2);
INSERT INTO `livro` (`pk_livro_id`, `titulo`, `autor`, `ano`, `isbn`, `fk_editora_id`, `qtd_exemplares`, `qtd_disponivel`) VALUES (18,'MemÃ³rias PÃ³stumas de BrÃ¡s Cubas','Machado de Assis',1881,'978-8-8675-3396-3',6,3,1);
INSERT INTO `livro` (`pk_livro_id`, `titulo`, `autor`, `ano`, `isbn`, `fk_editora_id`, `qtd_exemplares`, `qtd_disponivel`) VALUES (19,'Iracema','JosÃ© de Alencar',1865,'978-0-5766-2702-8',7,2,1);
INSERT INTO `livro` (`pk_livro_id`, `titulo`, `autor`, `ano`, `isbn`, `fk_editora_id`, `qtd_exemplares`, `qtd_disponivel`) VALUES (20,'O CortiÃ§o','AluÃ­sio Azevedo',1890,'978-5-1718-7026-2',10,3,3);
INSERT INTO `livro` (`pk_livro_id`, `titulo`, `autor`, `ano`, `isbn`, `fk_editora_id`, `qtd_exemplares`, `qtd_disponivel`) VALUES (21,'CapitÃ£es da Areia','Jorge Amado',1937,'978-7-4596-1586-5',2,3,1);
INSERT INTO `livro` (`pk_livro_id`, `titulo`, `autor`, `ano`, `isbn`, `fk_editora_id`, `qtd_exemplares`, `qtd_disponivel`) VALUES (22,'Gabriela, Cravo e Canela','Jorge Amado',1958,'978-7-8091-3431-6',11,2,1);
INSERT INTO `livro` (`pk_livro_id`, `titulo`, `autor`, `ano`, `isbn`, `fk_editora_id`, `qtd_exemplares`, `qtd_disponivel`) VALUES (23,'A Hora do Lobo','Rubem Fonseca',1998,'978-1-7240-0504-5',2,1,1);
INSERT INTO `livro` (`pk_livro_id`, `titulo`, `autor`, `ano`, `isbn`, `fk_editora_id`, `qtd_exemplares`, `qtd_disponivel`) VALUES (24,'O Guarani','JosÃ© de Alencar',1857,'978-6-2386-9222-1',6,3,2);
INSERT INTO `livro` (`pk_livro_id`, `titulo`, `autor`, `ano`, `isbn`, `fk_editora_id`, `qtd_exemplares`, `qtd_disponivel`) VALUES (25,'Quincas Borba','Machado de Assis',1891,'978-6-9379-2374-7',10,2,2);
INSERT INTO `livro` (`pk_livro_id`, `titulo`, `autor`, `ano`, `isbn`, `fk_editora_id`, `qtd_exemplares`, `qtd_disponivel`) VALUES (26,'Torto Arado (2Âª ediÃ§Ã£o)','Itamar Vieira Junior',2023,'978-0-7482-1759-4',11,3,2);
INSERT INTO `livro` (`pk_livro_id`, `titulo`, `autor`, `ano`, `isbn`, `fk_editora_id`, `qtd_exemplares`, `qtd_disponivel`) VALUES (27,'O Sol Ã© para Todos (2Âª ediÃ§Ã£o)','Harper Lee',1965,'978-4-7436-7136-9',12,1,1);
INSERT INTO `livro` (`pk_livro_id`, `titulo`, `autor`, `ano`, `isbn`, `fk_editora_id`, `qtd_exemplares`, `qtd_disponivel`) VALUES (28,'A Menina que Roubava Livros (2Âª ediÃ§Ã£o)','Markus Zusak',2009,'978-4-4064-0909-7',10,1,1);
INSERT INTO `livro` (`pk_livro_id`, `titulo`, `autor`, `ano`, `isbn`, `fk_editora_id`, `qtd_exemplares`, `qtd_disponivel`) VALUES (29,'Ensaio sobre a Cegueira (2Âª ediÃ§Ã£o)','JosÃ© Saramago',1999,'978-9-5339-4210-4',4,4,3);
INSERT INTO `livro` (`pk_livro_id`, `titulo`, `autor`, `ano`, `isbn`, `fk_editora_id`, `qtd_exemplares`, `qtd_disponivel`) VALUES (30,'A Hora da Estrela (2Âª ediÃ§Ã£o)','Clarice Lispector',1982,'978-9-5214-5623-2',1,3,3);
INSERT INTO `livro` (`pk_livro_id`, `titulo`, `autor`, `ano`, `isbn`, `fk_editora_id`, `qtd_exemplares`, `qtd_disponivel`) VALUES (31,'Grande SertÃ£o: Veredas (2Âª ediÃ§Ã£o)','GuimarÃ£es Rosa',1960,'978-8-4247-4517-1',9,3,2);
INSERT INTO `livro` (`pk_livro_id`, `titulo`, `autor`, `ano`, `isbn`, `fk_editora_id`, `qtd_exemplares`, `qtd_disponivel`) VALUES (32,'Sapiens: Uma Breve HistÃ³ria da Humanidade (2Âª ediÃ§Ã£o)','Yuval Noah Harari',2014,'978-6-8516-0481-7',4,2,2);
INSERT INTO `livro` (`pk_livro_id`, `titulo`, `autor`, `ano`, `isbn`, `fk_editora_id`, `qtd_exemplares`, `qtd_disponivel`) VALUES (33,'O Poder do HÃ¡bito (2Âª ediÃ§Ã£o)','Charles Duhigg',2016,'978-4-9651-3709-8',11,1,1);
INSERT INTO `livro` (`pk_livro_id`, `titulo`, `autor`, `ano`, `isbn`, `fk_editora_id`, `qtd_exemplares`, `qtd_disponivel`) VALUES (34,'A RevoluÃ§Ã£o dos Bichos (2Âª ediÃ§Ã£o)','George Orwell',1949,'978-3-1746-1200-4',10,1,1);
INSERT INTO `livro` (`pk_livro_id`, `titulo`, `autor`, `ano`, `isbn`, `fk_editora_id`, `qtd_exemplares`, `qtd_disponivel`) VALUES (35,'1984 (2Âª ediÃ§Ã£o)','George Orwell',1954,'978-1-3826-7586-9',2,1,1);
INSERT INTO `livro` (`pk_livro_id`, `titulo`, `autor`, `ano`, `isbn`, `fk_editora_id`, `qtd_exemplares`, `qtd_disponivel`) VALUES (36,'Cem Anos de SolidÃ£o (2Âª ediÃ§Ã£o)','Gabriel GarcÃ­a MÃ¡rquez',1970,'978-1-7964-0537-7',7,2,2);
INSERT INTO `livro` (`pk_livro_id`, `titulo`, `autor`, `ano`, `isbn`, `fk_editora_id`, `qtd_exemplares`, `qtd_disponivel`) VALUES (37,'O Alquimista (2Âª ediÃ§Ã£o)','Paulo Coelho',1991,'978-1-5850-6431-7',6,2,1);
INSERT INTO `livro` (`pk_livro_id`, `titulo`, `autor`, `ano`, `isbn`, `fk_editora_id`, `qtd_exemplares`, `qtd_disponivel`) VALUES (38,'Vidas Secas (2Âª ediÃ§Ã£o)','Graciliano Ramos',1940,'978-3-9005-3293-1',11,3,3);
INSERT INTO `livro` (`pk_livro_id`, `titulo`, `autor`, `ano`, `isbn`, `fk_editora_id`, `qtd_exemplares`, `qtd_disponivel`) VALUES (39,'Dom Casmurro (2Âª ediÃ§Ã£o)','Machado de Assis',1902,'978-3-3529-0422-8',10,1,1);
INSERT INTO `livro` (`pk_livro_id`, `titulo`, `autor`, `ano`, `isbn`, `fk_editora_id`, `qtd_exemplares`, `qtd_disponivel`) VALUES (40,'A Culpa Ã© das Estrelas (2Âª ediÃ§Ã£o)','John Green',2016,'978-1-0205-3950-2',3,2,1);
INSERT INTO `livro` (`pk_livro_id`, `titulo`, `autor`, `ano`, `isbn`, `fk_editora_id`, `qtd_exemplares`, `qtd_disponivel`) VALUES (41,'AdmirÃ¡vel Mundo Novo (2Âª ediÃ§Ã£o)','Aldous Huxley',1936,'978-2-6811-7758-9',1,3,2);
INSERT INTO `livro` (`pk_livro_id`, `titulo`, `autor`, `ano`, `isbn`, `fk_editora_id`, `qtd_exemplares`, `qtd_disponivel`) VALUES (42,'O Nome do Vento (2Âª ediÃ§Ã£o)','Patrick Rothfuss',2009,'978-8-3908-4700-7',8,3,2);
INSERT INTO `livro` (`pk_livro_id`, `titulo`, `autor`, `ano`, `isbn`, `fk_editora_id`, `qtd_exemplares`, `qtd_disponivel`) VALUES (43,'MemÃ³rias PÃ³stumas de BrÃ¡s Cubas (2Âª ediÃ§Ã£o)','Machado de Assis',1886,'978-1-7711-5921-2',7,2,2);
INSERT INTO `livro` (`pk_livro_id`, `titulo`, `autor`, `ano`, `isbn`, `fk_editora_id`, `qtd_exemplares`, `qtd_disponivel`) VALUES (44,'Iracema (2Âª ediÃ§Ã£o)','JosÃ© de Alencar',1869,'978-9-8569-8478-9',10,1,1);
INSERT INTO `livro` (`pk_livro_id`, `titulo`, `autor`, `ano`, `isbn`, `fk_editora_id`, `qtd_exemplares`, `qtd_disponivel`) VALUES (45,'O CortiÃ§o (2Âª ediÃ§Ã£o)','AluÃ­sio Azevedo',1895,'978-1-8367-3657-6',2,1,1);
INSERT INTO `livro` (`pk_livro_id`, `titulo`, `autor`, `ano`, `isbn`, `fk_editora_id`, `qtd_exemplares`, `qtd_disponivel`) VALUES (46,'CapitÃ£es da Areia (2Âª ediÃ§Ã£o)','Jorge Amado',1942,'978-1-5654-5271-1',12,2,2);
INSERT INTO `livro` (`pk_livro_id`, `titulo`, `autor`, `ano`, `isbn`, `fk_editora_id`, `qtd_exemplares`, `qtd_disponivel`) VALUES (47,'Gabriela, Cravo e Canela (2Âª ediÃ§Ã£o)','Jorge Amado',1960,'978-6-1528-0988-5',2,3,3);
INSERT INTO `livro` (`pk_livro_id`, `titulo`, `autor`, `ano`, `isbn`, `fk_editora_id`, `qtd_exemplares`, `qtd_disponivel`) VALUES (48,'A Hora do Lobo (2Âª ediÃ§Ã£o)','Rubem Fonseca',2000,'978-5-6049-4519-8',7,2,2);
INSERT INTO `livro` (`pk_livro_id`, `titulo`, `autor`, `ano`, `isbn`, `fk_editora_id`, `qtd_exemplares`, `qtd_disponivel`) VALUES (49,'O Guarani (2Âª ediÃ§Ã£o)','JosÃ© de Alencar',1860,'978-7-3158-5149-3',3,4,3);
INSERT INTO `livro` (`pk_livro_id`, `titulo`, `autor`, `ano`, `isbn`, `fk_editora_id`, `qtd_exemplares`, `qtd_disponivel`) VALUES (50,'Quincas Borba (2Âª ediÃ§Ã£o)','Machado de Assis',1896,'978-9-9809-4024-4',9,3,3);
INSERT INTO `livro` (`pk_livro_id`, `titulo`, `autor`, `ano`, `isbn`, `fk_editora_id`, `qtd_exemplares`, `qtd_disponivel`) VALUES (51,'Torto Arado (3Âª ediÃ§Ã£o)','Itamar Vieira Junior',2026,'978-0-2296-1201-8',6,1,1);
INSERT INTO `livro` (`pk_livro_id`, `titulo`, `autor`, `ano`, `isbn`, `fk_editora_id`, `qtd_exemplares`, `qtd_disponivel`) VALUES (52,'O Sol Ã© para Todos (3Âª ediÃ§Ã£o)','Harper Lee',1966,'978-6-7525-4599-1',7,2,2);
INSERT INTO `livro` (`pk_livro_id`, `titulo`, `autor`, `ano`, `isbn`, `fk_editora_id`, `qtd_exemplares`, `qtd_disponivel`) VALUES (53,'A Menina que Roubava Livros (3Âª ediÃ§Ã£o)','Markus Zusak',2009,'978-2-9014-7679-7',3,4,1);
INSERT INTO `livro` (`pk_livro_id`, `titulo`, `autor`, `ano`, `isbn`, `fk_editora_id`, `qtd_exemplares`, `qtd_disponivel`) VALUES (54,'Ensaio sobre a Cegueira (3Âª ediÃ§Ã£o)','JosÃ© Saramago',2005,'978-3-8156-1497-8',5,1,1);
INSERT INTO `livro` (`pk_livro_id`, `titulo`, `autor`, `ano`, `isbn`, `fk_editora_id`, `qtd_exemplares`, `qtd_disponivel`) VALUES (55,'A Hora da Estrela (3Âª ediÃ§Ã£o)','Clarice Lispector',1985,'978-3-6900-3432-4',1,1,1);
INSERT INTO `livro` (`pk_livro_id`, `titulo`, `autor`, `ano`, `isbn`, `fk_editora_id`, `qtd_exemplares`, `qtd_disponivel`) VALUES (56,'Grande SertÃ£o: Veredas (3Âª ediÃ§Ã£o)','GuimarÃ£es Rosa',1964,'978-1-0762-2683-8',6,1,1);
INSERT INTO `livro` (`pk_livro_id`, `titulo`, `autor`, `ano`, `isbn`, `fk_editora_id`, `qtd_exemplares`, `qtd_disponivel`) VALUES (57,'Sapiens: Uma Breve HistÃ³ria da Humanidade (3Âª ediÃ§Ã£o)','Yuval Noah Harari',2019,'978-6-0607-1596-9',2,1,1);
INSERT INTO `livro` (`pk_livro_id`, `titulo`, `autor`, `ano`, `isbn`, `fk_editora_id`, `qtd_exemplares`, `qtd_disponivel`) VALUES (58,'O Poder do HÃ¡bito (3Âª ediÃ§Ã£o)','Charles Duhigg',2022,'978-6-4160-5297-5',12,2,2);
INSERT INTO `livro` (`pk_livro_id`, `titulo`, `autor`, `ano`, `isbn`, `fk_editora_id`, `qtd_exemplares`, `qtd_disponivel`) VALUES (59,'A RevoluÃ§Ã£o dos Bichos (3Âª ediÃ§Ã£o)','George Orwell',1949,'978-1-3696-8164-5',7,1,1);
INSERT INTO `livro` (`pk_livro_id`, `titulo`, `autor`, `ano`, `isbn`, `fk_editora_id`, `qtd_exemplares`, `qtd_disponivel`) VALUES (60,'1984 (3Âª ediÃ§Ã£o)','George Orwell',1955,'978-2-1818-8355-2',6,2,1);
INSERT INTO `livro` (`pk_livro_id`, `titulo`, `autor`, `ano`, `isbn`, `fk_editora_id`, `qtd_exemplares`, `qtd_disponivel`) VALUES (61,'Cem Anos de SolidÃ£o (3Âª ediÃ§Ã£o)','Gabriel GarcÃ­a MÃ¡rquez',1973,'978-2-4329-2127-7',2,2,2);
INSERT INTO `livro` (`pk_livro_id`, `titulo`, `autor`, `ano`, `isbn`, `fk_editora_id`, `qtd_exemplares`, `qtd_disponivel`) VALUES (62,'O Alquimista (3Âª ediÃ§Ã£o)','Paulo Coelho',1998,'978-9-9552-7177-4',11,4,3);
INSERT INTO `livro` (`pk_livro_id`, `titulo`, `autor`, `ano`, `isbn`, `fk_editora_id`, `qtd_exemplares`, `qtd_disponivel`) VALUES (63,'Vidas Secas (3Âª ediÃ§Ã£o)','Graciliano Ramos',1946,'978-0-5814-7700-5',10,1,1);
INSERT INTO `livro` (`pk_livro_id`, `titulo`, `autor`, `ano`, `isbn`, `fk_editora_id`, `qtd_exemplares`, `qtd_disponivel`) VALUES (64,'Dom Casmurro (3Âª ediÃ§Ã£o)','Machado de Assis',1907,'978-1-9986-7980-7',2,2,1);
INSERT INTO `livro` (`pk_livro_id`, `titulo`, `autor`, `ano`, `isbn`, `fk_editora_id`, `qtd_exemplares`, `qtd_disponivel`) VALUES (65,'A Culpa Ã© das Estrelas (3Âª ediÃ§Ã£o)','John Green',2018,'978-9-7820-7151-8',6,1,1);
INSERT INTO `livro` (`pk_livro_id`, `titulo`, `autor`, `ano`, `isbn`, `fk_editora_id`, `qtd_exemplares`, `qtd_disponivel`) VALUES (66,'AdmirÃ¡vel Mundo Novo (3Âª ediÃ§Ã£o)','Aldous Huxley',1938,'978-3-7788-9255-4',1,2,1);
INSERT INTO `livro` (`pk_livro_id`, `titulo`, `autor`, `ano`, `isbn`, `fk_editora_id`, `qtd_exemplares`, `qtd_disponivel`) VALUES (67,'O Nome do Vento (3Âª ediÃ§Ã£o)','Patrick Rothfuss',2017,'978-5-9051-5186-4',7,2,2);
INSERT INTO `livro` (`pk_livro_id`, `titulo`, `autor`, `ano`, `isbn`, `fk_editora_id`, `qtd_exemplares`, `qtd_disponivel`) VALUES (68,'MemÃ³rias PÃ³stumas de BrÃ¡s Cubas (3Âª ediÃ§Ã£o)','Machado de Assis',1889,'978-9-2519-2546-2',12,1,1);
INSERT INTO `livro` (`pk_livro_id`, `titulo`, `autor`, `ano`, `isbn`, `fk_editora_id`, `qtd_exemplares`, `qtd_disponivel`) VALUES (69,'Iracema (3Âª ediÃ§Ã£o)','JosÃ© de Alencar',1869,'978-8-6528-1685-0',5,1,1);
INSERT INTO `livro` (`pk_livro_id`, `titulo`, `autor`, `ano`, `isbn`, `fk_editora_id`, `qtd_exemplares`, `qtd_disponivel`) VALUES (70,'O CortiÃ§o (3Âª ediÃ§Ã£o)','AluÃ­sio Azevedo',1898,'978-2-3573-3221-4',5,3,1);
INSERT INTO `livro` (`pk_livro_id`, `titulo`, `autor`, `ano`, `isbn`, `fk_editora_id`, `qtd_exemplares`, `qtd_disponivel`) VALUES (71,'CapitÃ£es da Areia (3Âª ediÃ§Ã£o)','Jorge Amado',1941,'978-8-8059-2962-2',9,3,2);
INSERT INTO `livro` (`pk_livro_id`, `titulo`, `autor`, `ano`, `isbn`, `fk_editora_id`, `qtd_exemplares`, `qtd_disponivel`) VALUES (72,'Gabriela, Cravo e Canela (3Âª ediÃ§Ã£o)','Jorge Amado',1964,'978-9-2706-5379-4',12,4,2);
INSERT INTO `livro` (`pk_livro_id`, `titulo`, `autor`, `ano`, `isbn`, `fk_editora_id`, `qtd_exemplares`, `qtd_disponivel`) VALUES (73,'A Hora do Lobo (3Âª ediÃ§Ã£o)','Rubem Fonseca',2008,'978-8-3473-5977-4',4,3,3);
INSERT INTO `livro` (`pk_livro_id`, `titulo`, `autor`, `ano`, `isbn`, `fk_editora_id`, `qtd_exemplares`, `qtd_disponivel`) VALUES (74,'O Guarani (3Âª ediÃ§Ã£o)','JosÃ© de Alencar',1867,'978-8-6239-2407-5',9,3,2);
INSERT INTO `livro` (`pk_livro_id`, `titulo`, `autor`, `ano`, `isbn`, `fk_editora_id`, `qtd_exemplares`, `qtd_disponivel`) VALUES (75,'Quincas Borba (3Âª ediÃ§Ã£o)','Machado de Assis',1895,'978-8-1412-4782-6',12,3,2);
INSERT INTO `livro` (`pk_livro_id`, `titulo`, `autor`, `ano`, `isbn`, `fk_editora_id`, `qtd_exemplares`, `qtd_disponivel`) VALUES (76,'Torto Arado (4Âª ediÃ§Ã£o)','Itamar Vieira Junior',2025,'978-7-5060-6853-6',4,1,1);
INSERT INTO `livro` (`pk_livro_id`, `titulo`, `autor`, `ano`, `isbn`, `fk_editora_id`, `qtd_exemplares`, `qtd_disponivel`) VALUES (77,'O Sol Ã© para Todos (4Âª ediÃ§Ã£o)','Harper Lee',1966,'978-3-0515-2204-7',6,2,2);
INSERT INTO `livro` (`pk_livro_id`, `titulo`, `autor`, `ano`, `isbn`, `fk_editora_id`, `qtd_exemplares`, `qtd_disponivel`) VALUES (78,'A Menina que Roubava Livros (4Âª ediÃ§Ã£o)','Markus Zusak',2014,'978-7-7901-0432-8',12,4,3);
INSERT INTO `livro` (`pk_livro_id`, `titulo`, `autor`, `ano`, `isbn`, `fk_editora_id`, `qtd_exemplares`, `qtd_disponivel`) VALUES (79,'Ensaio sobre a Cegueira (4Âª ediÃ§Ã£o)','JosÃ© Saramago',2010,'978-4-3410-3697-1',2,1,1);
INSERT INTO `livro` (`pk_livro_id`, `titulo`, `autor`, `ano`, `isbn`, `fk_editora_id`, `qtd_exemplares`, `qtd_disponivel`) VALUES (80,'A Hora da Estrela (4Âª ediÃ§Ã£o)','Clarice Lispector',1983,'978-9-8089-3246-0',8,4,3);
INSERT INTO `livro` (`pk_livro_id`, `titulo`, `autor`, `ano`, `isbn`, `fk_editora_id`, `qtd_exemplares`, `qtd_disponivel`) VALUES (81,'Grande SertÃ£o: Veredas (4Âª ediÃ§Ã£o)','GuimarÃ£es Rosa',1968,'978-9-6218-5188-8',4,2,2);
INSERT INTO `livro` (`pk_livro_id`, `titulo`, `autor`, `ano`, `isbn`, `fk_editora_id`, `qtd_exemplares`, `qtd_disponivel`) VALUES (82,'Sapiens: Uma Breve HistÃ³ria da Humanidade (4Âª ediÃ§Ã£o)','Yuval Noah Harari',2017,'978-7-0654-0515-3',7,1,1);
INSERT INTO `livro` (`pk_livro_id`, `titulo`, `autor`, `ano`, `isbn`, `fk_editora_id`, `qtd_exemplares`, `qtd_disponivel`) VALUES (83,'O Poder do HÃ¡bito (4Âª ediÃ§Ã£o)','Charles Duhigg',2018,'978-5-2058-5277-2',10,1,0);
INSERT INTO `livro` (`pk_livro_id`, `titulo`, `autor`, `ano`, `isbn`, `fk_editora_id`, `qtd_exemplares`, `qtd_disponivel`) VALUES (84,'A RevoluÃ§Ã£o dos Bichos (4Âª ediÃ§Ã£o)','George Orwell',1954,'978-7-0430-3054-8',2,4,3);
INSERT INTO `livro` (`pk_livro_id`, `titulo`, `autor`, `ano`, `isbn`, `fk_editora_id`, `qtd_exemplares`, `qtd_disponivel`) VALUES (85,'1984 (4Âª ediÃ§Ã£o)','George Orwell',1964,'978-7-4034-5054-1',9,2,2);
INSERT INTO `livro` (`pk_livro_id`, `titulo`, `autor`, `ano`, `isbn`, `fk_editora_id`, `qtd_exemplares`, `qtd_disponivel`) VALUES (86,'Cem Anos de SolidÃ£o (4Âª ediÃ§Ã£o)','Gabriel GarcÃ­a MÃ¡rquez',1979,'978-6-7652-7758-4',7,5,3);
INSERT INTO `livro` (`pk_livro_id`, `titulo`, `autor`, `ano`, `isbn`, `fk_editora_id`, `qtd_exemplares`, `qtd_disponivel`) VALUES (87,'O Alquimista (4Âª ediÃ§Ã£o)','Paulo Coelho',1994,'978-6-1692-8451-1',12,3,3);
INSERT INTO `livro` (`pk_livro_id`, `titulo`, `autor`, `ano`, `isbn`, `fk_editora_id`, `qtd_exemplares`, `qtd_disponivel`) VALUES (88,'Vidas Secas (4Âª ediÃ§Ã£o)','Graciliano Ramos',1950,'978-4-4796-2757-0',11,3,3);
INSERT INTO `livro` (`pk_livro_id`, `titulo`, `autor`, `ano`, `isbn`, `fk_editora_id`, `qtd_exemplares`, `qtd_disponivel`) VALUES (89,'Dom Casmurro (4Âª ediÃ§Ã£o)','Machado de Assis',1911,'978-6-4016-5820-2',10,2,2);
INSERT INTO `livro` (`pk_livro_id`, `titulo`, `autor`, `ano`, `isbn`, `fk_editora_id`, `qtd_exemplares`, `qtd_disponivel`) VALUES (90,'A Culpa Ã© das Estrelas (4Âª ediÃ§Ã£o)','John Green',2026,'978-2-1355-6909-2',1,2,2);
INSERT INTO `livro` (`pk_livro_id`, `titulo`, `autor`, `ano`, `isbn`, `fk_editora_id`, `qtd_exemplares`, `qtd_disponivel`) VALUES (91,'AdmirÃ¡vel Mundo Novo (4Âª ediÃ§Ã£o)','Aldous Huxley',1947,'978-5-7192-8565-4',6,1,1);
INSERT INTO `livro` (`pk_livro_id`, `titulo`, `autor`, `ano`, `isbn`, `fk_editora_id`, `qtd_exemplares`, `qtd_disponivel`) VALUES (92,'O Nome do Vento (4Âª ediÃ§Ã£o)','Patrick Rothfuss',2016,'978-0-2786-8144-7',2,2,2);
INSERT INTO `livro` (`pk_livro_id`, `titulo`, `autor`, `ano`, `isbn`, `fk_editora_id`, `qtd_exemplares`, `qtd_disponivel`) VALUES (93,'MemÃ³rias PÃ³stumas de BrÃ¡s Cubas (4Âª ediÃ§Ã£o)','Machado de Assis',1890,'978-4-7312-1727-1',10,1,1);
INSERT INTO `livro` (`pk_livro_id`, `titulo`, `autor`, `ano`, `isbn`, `fk_editora_id`, `qtd_exemplares`, `qtd_disponivel`) VALUES (94,'Iracema (4Âª ediÃ§Ã£o)','JosÃ© de Alencar',1877,'978-5-1884-4225-8',11,4,3);
INSERT INTO `livro` (`pk_livro_id`, `titulo`, `autor`, `ano`, `isbn`, `fk_editora_id`, `qtd_exemplares`, `qtd_disponivel`) VALUES (95,'O CortiÃ§o (4Âª ediÃ§Ã£o)','AluÃ­sio Azevedo',1899,'978-3-2370-5895-7',2,2,1);
INSERT INTO `livro` (`pk_livro_id`, `titulo`, `autor`, `ano`, `isbn`, `fk_editora_id`, `qtd_exemplares`, `qtd_disponivel`) VALUES (96,'CapitÃ£es da Areia (4Âª ediÃ§Ã£o)','Jorge Amado',1946,'978-1-1467-8669-1',10,2,0);
INSERT INTO `livro` (`pk_livro_id`, `titulo`, `autor`, `ano`, `isbn`, `fk_editora_id`, `qtd_exemplares`, `qtd_disponivel`) VALUES (97,'Gabriela, Cravo e Canela (4Âª ediÃ§Ã£o)','Jorge Amado',1967,'978-1-7785-2892-2',6,4,2);
INSERT INTO `livro` (`pk_livro_id`, `titulo`, `autor`, `ano`, `isbn`, `fk_editora_id`, `qtd_exemplares`, `qtd_disponivel`) VALUES (98,'A Hora do Lobo (4Âª ediÃ§Ã£o)','Rubem Fonseca',2013,'978-0-1824-2253-5',9,3,3);
INSERT INTO `livro` (`pk_livro_id`, `titulo`, `autor`, `ano`, `isbn`, `fk_editora_id`, `qtd_exemplares`, `qtd_disponivel`) VALUES (99,'O Guarani (4Âª ediÃ§Ã£o)','JosÃ© de Alencar',1869,'978-4-3842-4981-8',2,1,1);
INSERT INTO `livro` (`pk_livro_id`, `titulo`, `autor`, `ano`, `isbn`, `fk_editora_id`, `qtd_exemplares`, `qtd_disponivel`) VALUES (100,'Quincas Borba (4Âª ediÃ§Ã£o)','Machado de Assis',1900,'978-9-2299-5900-1',10,1,1);
/*!40000 ALTER TABLE `livro` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `livro_has_usuario`
--

DROP TABLE IF EXISTS `livro_has_usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `livro_has_usuario` (
  `fk_livro_id` int NOT NULL,
  `fk_usuario_id` int NOT NULL,
  `data_retirada` date NOT NULL,
  `data_prevista_devolucao` date NOT NULL,
  `data_devolucao` date DEFAULT NULL,
  PRIMARY KEY (`fk_livro_id`,`fk_usuario_id`,`data_retirada`),
  KEY `fk_emprestimo_usuario` (`fk_usuario_id`),
  CONSTRAINT `fk_emprestimo_livro` FOREIGN KEY (`fk_livro_id`) REFERENCES `livro` (`pk_livro_id`),
  CONSTRAINT `fk_emprestimo_usuario` FOREIGN KEY (`fk_usuario_id`) REFERENCES `usuario` (`pk_usuario_id`),
  CONSTRAINT `ck_emprestimo_datas` CHECK (((`data_prevista_devolucao` > `data_retirada`) and ((`data_devolucao` is null) or (`data_devolucao` >= `data_retirada`))))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `livro_has_usuario`
--

LOCK TABLES `livro_has_usuario` WRITE;
/*!40000 ALTER TABLE `livro_has_usuario` DISABLE KEYS */;
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (1,41,'2026-10-02','2026-10-16',NULL);
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (3,95,'2026-07-13','2026-07-27','2026-07-17');
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (5,108,'2026-08-18','2026-09-01','2026-08-28');
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (6,7,'2026-10-03','2026-10-17',NULL);
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (6,74,'2026-08-31','2026-09-14','2026-09-04');
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (6,103,'2026-06-07','2026-06-22','2026-07-01');
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (6,148,'2026-07-04','2026-07-19','2026-07-17');
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (7,13,'2026-07-07','2026-08-06','2026-08-14');
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (7,47,'2026-10-09','2026-10-23',NULL);
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (8,31,'2026-07-30','2026-08-20','2026-08-14');
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (8,51,'2026-10-08','2026-10-22',NULL);
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (8,103,'2026-10-04','2026-10-18',NULL);
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (9,121,'2026-06-05','2026-06-26','2026-07-02');
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (10,145,'2026-06-15','2026-06-29','2026-06-23');
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (11,97,'2026-10-06','2026-10-20',NULL);
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (12,101,'2026-08-04','2026-09-03','2026-09-02');
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (12,103,'2026-08-25','2026-09-08','2026-09-12');
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (12,131,'2026-07-28','2026-08-11','2026-08-02');
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (13,13,'2026-07-08','2026-08-07','2026-07-29');
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (13,36,'2026-06-01','2026-06-16','2026-06-15');
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (14,12,'2026-10-01','2026-10-15',NULL);
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (14,88,'2026-10-06','2026-10-20',NULL);
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (14,111,'2026-06-18','2026-07-09','2026-07-08');
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (15,53,'2026-08-31','2026-09-30','2026-09-21');
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (17,21,'2026-10-04','2026-10-18',NULL);
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (17,24,'2026-10-08','2026-10-22',NULL);
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (17,86,'2026-10-03','2026-10-17',NULL);
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (18,28,'2026-08-18','2026-09-02',NULL);
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (18,86,'2026-07-31','2026-08-30','2026-08-23');
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (18,129,'2026-07-08','2026-07-23','2026-07-21');
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (18,130,'2026-07-30','2026-08-20','2026-08-16');
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (18,134,'2026-09-30','2026-10-14',NULL);
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (19,63,'2026-06-05','2026-06-19','2026-06-16');
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (19,92,'2026-10-03','2026-10-17',NULL);
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (20,132,'2026-06-18','2026-07-09','2026-06-29');
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (21,7,'2026-10-07','2026-10-21',NULL);
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (21,104,'2026-08-27','2026-09-17','2026-09-10');
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (21,113,'2026-07-24','2026-08-23',NULL);
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (22,44,'2026-10-10','2026-10-24',NULL);
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (22,84,'2026-08-06','2026-09-05','2026-09-10');
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (22,135,'2026-08-20','2026-09-19','2026-09-27');
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (23,10,'2026-07-21','2026-08-20','2026-08-24');
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (23,104,'2026-07-25','2026-08-15','2026-08-13');
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (24,36,'2026-08-01','2026-08-22','2026-08-30');
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (24,75,'2026-06-05','2026-06-19','2026-06-09');
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (24,108,'2026-10-08','2026-10-22',NULL);
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (25,5,'2026-07-27','2026-08-17','2026-08-13');
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (25,29,'2026-07-13','2026-07-28','2026-08-04');
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (25,41,'2026-08-03','2026-09-02','2026-08-23');
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (26,83,'2026-10-02','2026-10-16',NULL);
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (29,98,'2026-10-05','2026-10-19',NULL);
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (30,139,'2026-06-28','2026-07-12','2026-07-04');
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (31,53,'2026-06-09','2026-06-23','2026-06-27');
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (31,56,'2026-08-14','2026-09-04','2026-09-11');
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (31,58,'2026-07-09','2026-07-24','2026-07-31');
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (31,78,'2026-06-19','2026-07-04','2026-06-25');
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (31,115,'2026-07-05','2026-07-26','2026-07-29');
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (31,139,'2026-10-08','2026-10-22',NULL);
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (32,2,'2026-07-04','2026-08-03','2026-07-31');
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (32,12,'2026-07-22','2026-08-21','2026-08-30');
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (32,13,'2026-08-25','2026-09-09','2026-09-06');
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (34,93,'2026-08-28','2026-09-12','2026-09-10');
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (35,116,'2026-07-02','2026-07-17','2026-07-24');
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (36,143,'2026-07-09','2026-07-24','2026-08-02');
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (37,32,'2026-08-13','2026-09-12','2026-09-17');
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (37,80,'2026-09-30','2026-10-14',NULL);
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (38,146,'2026-08-26','2026-09-10','2026-09-08');
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (39,74,'2026-08-30','2026-09-14','2026-09-13');
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (39,97,'2026-06-24','2026-07-24','2026-08-02');
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (39,117,'2026-06-10','2026-06-24','2026-06-17');
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (39,119,'2026-08-26','2026-09-25','2026-09-15');
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (39,146,'2026-08-17','2026-08-31','2026-08-29');
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (39,150,'2026-09-01','2026-09-15','2026-09-07');
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (40,94,'2026-10-08','2026-10-22',NULL);
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (41,45,'2026-07-29','2026-08-19','2026-08-11');
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (41,62,'2026-07-30','2026-08-13','2026-08-08');
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (41,78,'2026-10-02','2026-10-16',NULL);
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (41,82,'2026-09-02','2026-09-23','2026-09-13');
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (42,98,'2026-10-02','2026-10-16',NULL);
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (42,148,'2026-09-01','2026-09-22','2026-09-22');
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (43,73,'2026-07-29','2026-08-28','2026-08-28');
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (45,17,'2026-08-09','2026-08-23','2026-08-28');
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (45,114,'2026-08-23','2026-09-13','2026-09-04');
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (45,144,'2026-09-01','2026-09-22','2026-09-14');
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (47,142,'2026-07-07','2026-07-21','2026-07-20');
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (48,57,'2026-06-29','2026-07-14','2026-07-08');
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (48,98,'2026-07-28','2026-08-27','2026-09-01');
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (49,21,'2026-08-27','2026-09-11','2026-09-02');
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (49,140,'2026-10-08','2026-10-22',NULL);
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (50,130,'2026-07-28','2026-08-18','2026-08-11');
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (51,66,'2026-06-01','2026-06-16','2026-06-13');
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (51,89,'2026-06-19','2026-07-10','2026-07-02');
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (51,96,'2026-07-14','2026-08-04','2026-08-02');
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (52,34,'2026-07-18','2026-08-01','2026-08-01');
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (53,47,'2026-06-18','2026-07-18',NULL);
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (53,51,'2026-09-29','2026-10-13',NULL);
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (53,77,'2026-07-06','2026-07-20','2026-07-20');
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (53,85,'2026-08-31','2026-09-30','2026-09-29');
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (53,122,'2026-08-01','2026-08-16','2026-08-16');
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (53,129,'2026-08-18','2026-09-17',NULL);
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (54,39,'2026-07-23','2026-08-07','2026-08-09');
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (54,141,'2026-07-31','2026-08-15','2026-08-18');
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (54,150,'2026-07-10','2026-07-24','2026-07-15');
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (59,34,'2026-08-05','2026-09-04','2026-08-30');
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (59,89,'2026-06-20','2026-07-11','2026-07-07');
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (59,145,'2026-06-08','2026-07-08','2026-07-08');
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (60,15,'2026-08-11','2026-09-10','2026-09-03');
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (60,53,'2026-07-14','2026-07-29',NULL);
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (62,40,'2026-07-29','2026-08-19','2026-08-10');
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (62,63,'2026-08-27','2026-09-26','2026-09-23');
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (62,120,'2026-10-02','2026-10-16',NULL);
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (64,79,'2026-08-03','2026-08-17','2026-08-14');
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (64,82,'2026-10-07','2026-10-21',NULL);
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (64,140,'2026-07-08','2026-07-29','2026-07-25');
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (65,11,'2026-06-06','2026-06-20','2026-06-17');
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (65,131,'2026-08-08','2026-09-07','2026-09-04');
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (66,3,'2026-10-05','2026-10-19',NULL);
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (67,54,'2026-08-11','2026-09-01','2026-08-23');
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (68,115,'2026-08-07','2026-08-28','2026-09-02');
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (69,10,'2026-06-23','2026-07-23','2026-07-24');
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (69,70,'2026-08-11','2026-09-01','2026-08-22');
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (69,98,'2026-06-30','2026-07-15','2026-07-15');
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (69,101,'2026-08-07','2026-08-22','2026-08-17');
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (70,91,'2026-08-26','2026-09-16',NULL);
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (70,107,'2026-09-28','2026-10-12',NULL);
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (71,130,'2026-06-26','2026-07-11',NULL);
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (72,45,'2026-08-20','2026-09-19','2026-09-24');
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (72,58,'2026-09-29','2026-10-13',NULL);
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (72,127,'2026-06-07','2026-06-28','2026-06-23');
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (72,135,'2026-09-28','2026-10-12',NULL);
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (74,69,'2026-10-06','2026-10-20',NULL);
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (75,19,'2026-06-06','2026-07-06','2026-06-27');
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (75,73,'2026-10-05','2026-10-19',NULL);
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (77,9,'2026-07-28','2026-08-11','2026-08-01');
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (77,121,'2026-07-07','2026-07-21','2026-07-17');
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (77,122,'2026-07-04','2026-07-19','2026-07-17');
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (78,81,'2026-10-01','2026-10-15',NULL);
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (79,77,'2026-08-15','2026-09-05','2026-09-11');
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (79,82,'2026-06-21','2026-07-21','2026-07-29');
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (79,108,'2026-07-02','2026-07-17','2026-07-15');
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (79,124,'2026-06-25','2026-07-10','2026-07-07');
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (80,31,'2026-06-17','2026-07-01','2026-06-28');
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (80,66,'2026-10-08','2026-10-22',NULL);
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (82,60,'2026-06-07','2026-06-21','2026-06-18');
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (83,16,'2026-06-12','2026-06-27','2026-06-28');
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (83,98,'2026-08-07','2026-08-28',NULL);
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (84,4,'2026-10-01','2026-10-15',NULL);
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (84,90,'2026-06-16','2026-07-01','2026-06-30');
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (85,123,'2026-08-07','2026-09-06','2026-09-11');
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (86,43,'2026-10-02','2026-10-16',NULL);
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (86,125,'2026-10-04','2026-10-18',NULL);
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (87,79,'2026-09-01','2026-09-15','2026-09-11');
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (89,31,'2026-08-21','2026-09-11','2026-09-11');
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (89,126,'2026-07-11','2026-08-10','2026-08-01');
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (90,107,'2026-07-23','2026-08-07','2026-07-31');
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (91,145,'2026-07-09','2026-08-08','2026-08-16');
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (92,48,'2026-06-02','2026-06-23','2026-06-30');
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (93,14,'2026-08-14','2026-09-13','2026-09-16');
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (94,1,'2026-10-05','2026-10-19',NULL);
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (94,58,'2026-06-01','2026-06-15','2026-06-06');
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (94,94,'2026-07-22','2026-08-12','2026-08-16');
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (94,118,'2026-08-22','2026-09-12','2026-09-06');
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (94,148,'2026-07-11','2026-08-01','2026-07-27');
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (95,16,'2026-08-30','2026-09-14','2026-09-16');
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (95,28,'2026-10-10','2026-10-24',NULL);
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (96,123,'2026-06-28','2026-07-13',NULL);
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (96,135,'2026-10-10','2026-10-24',NULL);
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (97,37,'2026-06-26','2026-07-26','2026-07-20');
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (97,70,'2026-10-08','2026-10-22',NULL);
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (97,74,'2026-07-12','2026-08-02','2026-07-23');
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (97,102,'2026-10-05','2026-10-19',NULL);
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (98,64,'2026-08-27','2026-09-10','2026-09-05');
INSERT INTO `livro_has_usuario` (`fk_livro_id`, `fk_usuario_id`, `data_retirada`, `data_prevista_devolucao`, `data_devolucao`) VALUES (99,147,'2026-07-24','2026-08-07','2026-08-11');
/*!40000 ALTER TABLE `livro_has_usuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuario` (
  `pk_usuario_id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(200) NOT NULL,
  `ra` int NOT NULL,
  `email` varchar(150) NOT NULL,
  `fk_curso_id` int NOT NULL,
  `multa` decimal(8,2) NOT NULL DEFAULT '0.00',
  PRIMARY KEY (`pk_usuario_id`),
  UNIQUE KEY `email` (`email`),
  KEY `fk_usuario_curso` (`fk_curso_id`),
  CONSTRAINT `fk_usuario_curso` FOREIGN KEY (`fk_curso_id`) REFERENCES `curso` (`pk_curso_id`),
  CONSTRAINT `ck_usuario_multa` CHECK ((`multa` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=151 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (1,'Alexandre Dias Lima',20224657,'alexandre.dias1@email.com',5,0.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (2,'Isabela Tavares Teixeira',20257912,'isabela.tavares2@email.com',2,0.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (3,'Carla Lima Nunes',20229279,'carla.lima3@email.com',4,0.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (4,'Caio Lima Campos',20269928,'caio.lima4@email.com',4,0.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (5,'Fernanda Farias Oliveira',20213615,'fernanda.farias5@email.com',5,0.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (6,'FÃ¡bio Martins Mendes',20224527,'fÃ¡bio.martins6@email.com',5,0.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (7,'Ricardo Mendes Teixeira',20242584,'ricardo.mendes7@email.com',2,0.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (8,'Beatriz Ferreira Cavalcanti',20218527,'beatriz.ferreira8@email.com',5,0.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (9,'Aline Dias Barbosa',20255803,'aline.dias9@email.com',2,0.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (10,'Alexandre Barros Santos',20262139,'alexandre.barros10@email.com',4,0.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (11,'Carla Machado Farias',20214814,'carla.machado11@email.com',5,0.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (12,'Gabriela Barbosa Cunha',20266977,'gabriela.barbosa12@email.com',8,0.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (13,'Karina Santos Ferreira',20265374,'karina.santos13@email.com',4,0.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (14,'FÃ¡bio Cordeiro Sales',20253803,'fÃ¡bio.cordeiro14@email.com',2,6.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (15,'Aline Xavier Vieira',20247216,'aline.xavier15@email.com',3,0.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (16,'Sabrina Pimentel Peixoto',20266313,'sabrina.pimentel16@email.com',4,4.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (17,'Amanda Fonseca Alves',20216168,'amanda.fonseca17@email.com',4,0.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (18,'Gustavo Cunha Pinto',20256155,'gustavo.cunha18@email.com',4,0.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (19,'Nicolas Sales Gomes',20268517,'nicolas.sales19@email.com',7,0.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (20,'JoÃ£o Batista Freitas',20269830,'joÃ£o.batista20@email.com',4,0.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (21,'Rafael Tavares Melo',20257543,'rafael.tavares21@email.com',7,0.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (22,'Rodrigo Farias Freitas',20211771,'rodrigo.farias22@email.com',8,0.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (23,'Henrique Cardoso Pimentel',20267916,'henrique.cardoso23@email.com',3,0.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (24,'Caio Pinto Barbosa',20258668,'caio.pinto24@email.com',7,0.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (25,'Leonardo Batista Campos',20262876,'leonardo.batista25@email.com',1,0.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (26,'NatÃ¡lia Nascimento GuimarÃ£es',20266573,'natÃ¡lia.nascimento26@email.com',5,0.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (27,'Henrique Rocha Martins',20241053,'henrique.rocha27@email.com',3,0.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (28,'Igor Xavier Batista',20252743,'igor.xavier28@email.com',3,0.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (29,'Alexandre AraÃºjo Pimentel',20227126,'alexandre.araÃºjo29@email.com',4,0.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (30,'Ricardo Duarte Nascimento',20256310,'ricardo.duarte30@email.com',1,0.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (31,'VinÃ­cius Lima Dias',20234923,'vinÃ­cius.lima31@email.com',6,0.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (32,'Diego Vieira Azevedo',20218962,'diego.vieira32@email.com',2,10.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (33,'Eduarda GuimarÃ£es Nascimento',20228787,'eduarda.guimarÃ£es33@email.com',3,0.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (34,'Rafaela Duarte Batista',20229835,'rafaela.duarte34@email.com',7,0.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (35,'Ricardo Xavier Peixoto',20266107,'ricardo.xavier35@email.com',4,0.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (36,'Gustavo Machado Sales',20249479,'gustavo.machado36@email.com',6,0.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (37,'Juliana Dias Vieira',20216539,'juliana.dias37@email.com',4,0.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (38,'Bruno Melo Campos',20254608,'bruno.melo38@email.com',4,0.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (39,'Ana Pinto BrandÃ£o',20222104,'ana.pinto39@email.com',1,0.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (40,'Carla Mendes Pinto',20238953,'carla.mendes40@email.com',4,0.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (41,'Nicolas Nascimento Freitas',20228749,'nicolas.nascimento41@email.com',8,0.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (42,'Fernanda Reis Teixeira',20268062,'fernanda.reis42@email.com',2,0.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (43,'Beatriz Martins Costa',20261887,'beatriz.martins43@email.com',8,0.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (44,'NatÃ¡lia Sales Sales',20217596,'natÃ¡lia.sales44@email.com',2,0.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (45,'Igor Mendes Teixeira',20224116,'igor.mendes45@email.com',4,10.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (46,'Aline Oliveira Freitas',20225563,'aline.oliveira46@email.com',7,0.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (47,'AndrÃ© Vieira Pinto',20252604,'andrÃ©.vieira47@email.com',8,0.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (48,'Diego Sales Nascimento',20214872,'diego.sales48@email.com',1,0.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (49,'Karina Costa Gomes',20227570,'karina.costa49@email.com',8,0.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (50,'Diego Duarte Barbosa',20245345,'diego.duarte50@email.com',1,0.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (51,'AndrÃ© Rocha Martins',20224111,'andrÃ©.rocha51@email.com',8,0.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (52,'Thiago Pereira Alves',20266138,'thiago.pereira52@email.com',1,0.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (53,'Diego Alves Melo',20259701,'diego.alves53@email.com',8,0.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (54,'Karina Alves Monteiro',20222122,'karina.alves54@email.com',2,0.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (55,'Caio Pinto Cordeiro',20242964,'caio.pinto55@email.com',4,0.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (56,'Matheus Vieira Melo',20252343,'matheus.vieira56@email.com',1,14.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (57,'Fernanda Machado Melo',20234346,'fernanda.machado57@email.com',6,0.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (58,'Guilherme BrandÃ£o Carvalho',20237484,'guilherme.brandÃ£o58@email.com',4,0.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (59,'Isabela Machado Sales',20246180,'isabela.machado59@email.com',5,0.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (60,'Ricardo Pinto Souza',20252638,'ricardo.pinto60@email.com',8,0.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (61,'Eduarda Nascimento Pereira',20226718,'eduarda.nascimento61@email.com',5,0.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (62,'Eduarda Vieira Santos',20228179,'eduarda.vieira62@email.com',5,0.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (63,'Aline BrandÃ£o AraÃºjo',20265905,'aline.brandÃ£o63@email.com',1,0.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (64,'Guilherme Teixeira Freitas',20212753,'guilherme.teixeira64@email.com',5,0.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (65,'Paula Campos Cardoso',20234450,'paula.campos65@email.com',5,0.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (66,'Cristina Mendes Pereira',20259004,'cristina.mendes66@email.com',5,0.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (67,'Rafael Alves Nunes',20231722,'rafael.alves67@email.com',7,0.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (68,'Ana Mendes Fonseca',20265291,'ana.mendes68@email.com',3,0.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (69,'Karina Tavares Oliveira',20251158,'karina.tavares69@email.com',7,0.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (70,'Henrique Pinto Peixoto',20251590,'henrique.pinto70@email.com',3,0.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (71,'Rodrigo Melo Campos',20243088,'rodrigo.melo71@email.com',3,0.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (72,'Carla AraÃºjo Santos',20234441,'carla.araÃºjo72@email.com',1,0.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (73,'NatÃ¡lia Vieira Machado',20237658,'natÃ¡lia.vieira73@email.com',2,0.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (74,'DÃ©bora Tavares Cardoso',20223900,'dÃ©bora.tavares74@email.com',4,0.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (75,'Fernanda Lima Moreira',20245065,'fernanda.lima75@email.com',6,0.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (76,'Sabrina Duarte Peixoto',20241634,'sabrina.duarte76@email.com',2,0.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (77,'Priscila Farias Reis',20236000,'priscila.farias77@email.com',8,12.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (78,'OtÃ¡vio Farias Lima',20246378,'otÃ¡vio.farias78@email.com',4,0.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (79,'Sabrina Pinto Fonseca',20239346,'sabrina.pinto79@email.com',5,0.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (80,'Gustavo Cordeiro Nascimento',20212889,'gustavo.cordeiro80@email.com',6,0.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (81,'Rafael Moreira Melo',20212776,'rafael.moreira81@email.com',5,0.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (82,'Caio Martins Ferreira',20249379,'caio.martins82@email.com',6,0.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (83,'Henrique Barbosa Azevedo',20231727,'henrique.barbosa83@email.com',4,0.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (84,'Cristina Martins Souza',20238066,'cristina.martins84@email.com',4,10.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (85,'Eduarda Machado Mendes',20263041,'eduarda.machado85@email.com',6,0.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (86,'Igor AraÃºjo Monteiro',20267691,'igor.araÃºjo86@email.com',5,0.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (87,'Camila Ramos Peixoto',20253085,'camila.ramos87@email.com',5,0.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (88,'Mariana Costa Machado',20263851,'mariana.costa88@email.com',7,0.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (89,'DÃ©bora Azevedo AraÃºjo',20251006,'dÃ©bora.azevedo89@email.com',7,0.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (90,'VitÃ³ria Rocha Pereira',20256279,'vitÃ³ria.rocha90@email.com',7,0.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (91,'AndrÃ© Oliveira Oliveira',20258752,'andrÃ©.oliveira91@email.com',4,0.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (92,'Paula Duarte Machado',20239445,'paula.duarte92@email.com',2,0.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (93,'Guilherme Pimentel Barros',20214848,'guilherme.pimentel93@email.com',6,0.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (94,'NatÃ¡lia AraÃºjo Farias',20221400,'natÃ¡lia.araÃºjo94@email.com',4,0.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (95,'Carla Vieira Correia',20247790,'carla.vieira95@email.com',2,0.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (96,'Alexandre Azevedo Reis',20247547,'alexandre.azevedo96@email.com',7,0.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (97,'PatrÃ­cia Cardoso Sales',20217965,'patrÃ­cia.cardoso97@email.com',1,0.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (98,'OtÃ¡vio Moreira Peixoto',20215082,'otÃ¡vio.moreira98@email.com',8,10.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (99,'Henrique Andrade Freitas',20269702,'henrique.andrade99@email.com',8,0.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (100,'Rafaela Cavalcanti Carvalho',20259270,'rafaela.cavalcanti100@email.com',8,0.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (101,'Marcelo Campos Oliveira',20268777,'marcelo.campos101@email.com',3,0.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (102,'Juliana Batista GuimarÃ£es',20265543,'juliana.batista102@email.com',4,0.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (103,'Amanda Fonseca Lopes',20264919,'amanda.fonseca103@email.com',8,8.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (104,'Sabrina Oliveira Pinto',20225451,'sabrina.oliveira104@email.com',5,0.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (105,'Daniel Carvalho Nascimento',20223471,'daniel.carvalho105@email.com',2,0.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (106,'OtÃ¡vio Barbosa Peixoto',20264505,'otÃ¡vio.barbosa106@email.com',3,0.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (107,'Eduarda Costa Costa',20258633,'eduarda.costa107@email.com',6,0.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (108,'Fernanda Alves Pereira',20241320,'fernanda.alves108@email.com',7,0.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (109,'Ricardo Azevedo Barbosa',20216763,'ricardo.azevedo109@email.com',8,0.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (110,'VitÃ³ria GuimarÃ£es Barbosa',20259947,'vitÃ³ria.guimarÃ£es110@email.com',7,0.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (111,'Caio Farias Gomes',20238140,'caio.farias111@email.com',4,0.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (112,'VinÃ­cius Lima Barbosa',20267624,'vinÃ­cius.lima112@email.com',6,0.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (113,'Igor Duarte Andrade',20259751,'igor.duarte113@email.com',3,0.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (114,'Bruno Ramos Melo',20218022,'bruno.ramos114@email.com',1,0.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (115,'Isabela Andrade Moreira',20237211,'isabela.andrade115@email.com',1,10.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (116,'Camila Pereira Andrade',20237906,'camila.pereira116@email.com',6,0.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (117,'Rafael Nunes Correia',20269837,'rafael.nunes117@email.com',1,0.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (118,'Diego Ferreira Farias',20261659,'diego.ferreira118@email.com',2,0.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (119,'Ricardo Lima Vieira',20213496,'ricardo.lima119@email.com',4,0.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (120,'PatrÃ­cia Freitas Correia',20254571,'patrÃ­cia.freitas120@email.com',2,0.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (121,'AndrÃ© Peixoto Batista',20222876,'andrÃ©.peixoto121@email.com',6,0.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (122,'Amanda Duarte AraÃºjo',20251420,'amanda.duarte122@email.com',2,0.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (123,'VitÃ³ria Azevedo Cordeiro',20244249,'vitÃ³ria.azevedo123@email.com',7,10.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (124,'Eduarda Melo Peixoto',20215941,'eduarda.melo124@email.com',4,0.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (125,'NatÃ¡lia Cavalcanti Dias',20239728,'natÃ¡lia.cavalcanti125@email.com',1,0.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (126,'Marcelo Machado Santos',20256590,'marcelo.machado126@email.com',2,0.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (127,'Ana Costa Gomes',20246934,'ana.costa127@email.com',2,0.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (128,'Alexandre Andrade BrandÃ£o',20243885,'alexandre.andrade128@email.com',3,0.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (129,'Igor Lopes Sales',20259817,'igor.lopes129@email.com',5,0.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (130,'Amanda Correia Andrade',20265397,'amanda.correia130@email.com',7,0.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (131,'Camila Vieira Nunes',20244995,'camila.vieira131@email.com',5,0.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (132,'Ricardo Andrade Azevedo',20231470,'ricardo.andrade132@email.com',7,0.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (133,'VinÃ­cius Carvalho Moreira',20226813,'vinÃ­cius.carvalho133@email.com',8,0.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (134,'Rafael Mendes Cunha',20251166,'rafael.mendes134@email.com',5,0.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (135,'Leonardo Reis Nunes',20267658,'leonardo.reis135@email.com',4,16.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (136,'VinÃ­cius Campos GuimarÃ£es',20268800,'vinÃ­cius.campos136@email.com',4,0.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (137,'Tatiane BrandÃ£o Gomes',20212524,'tatiane.brandÃ£o137@email.com',8,0.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (138,'Thiago Farias Ramos',20237046,'thiago.farias138@email.com',4,0.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (139,'Priscila Campos Lopes',20246419,'priscila.campos139@email.com',6,0.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (140,'Beatriz Peixoto Andrade',20235118,'beatriz.peixoto140@email.com',5,0.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (141,'OtÃ¡vio Dias Xavier',20232958,'otÃ¡vio.dias141@email.com',4,0.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (142,'Paula Nascimento GuimarÃ£es',20224545,'paula.nascimento142@email.com',3,0.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (143,'Paula Correia Cunha',20214180,'paula.correia143@email.com',5,0.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (144,'Thiago Farias Santos',20231231,'thiago.farias144@email.com',3,0.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (145,'Cristina Nascimento Freitas',20211893,'cristina.nascimento145@email.com',5,0.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (146,'Rafaela Rocha Peixoto',20269042,'rafaela.rocha146@email.com',3,0.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (147,'Gabriela Souza Azevedo',20248843,'gabriela.souza147@email.com',5,0.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (148,'Juliana Mendes Moreira',20238827,'juliana.mendes148@email.com',1,0.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (149,'Henrique Pinto Ramos',20211878,'henrique.pinto149@email.com',8,0.00);
INSERT INTO `usuario` (`pk_usuario_id`, `nome`, `ra`, `email`, `fk_curso_id`, `multa`) VALUES (150,'JoÃ£o Cardoso Azevedo',20215066,'joÃ£o.cardoso150@email.com',5,0.00);
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed
