-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema final
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema final
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `final` DEFAULT CHARACTER SET utf8 ;
USE `final` ;

-- -----------------------------------------------------
-- Table `final`.`countries`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `final`.`countries` ;

CREATE TABLE IF NOT EXISTS `final`.`countries` (
  `country_id` INT NOT NULL,
  `country_name` VARCHAR(50) NOT NULL,
  `twocountrycode` CHAR(2) NOT NULL,
  `threecountrycode` CHAR(3) NOT NULL,
  PRIMARY KEY (`country_id`),
  UNIQUE INDEX `twocountrycode_UNIQUE` (`twocountrycode` ASC) VISIBLE,
  UNIQUE INDEX `threecountrycode_UNIQUE` (`threecountrycode` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `final`.`states`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `final`.`states` ;

CREATE TABLE IF NOT EXISTS `final`.`states` (
  `state_id` INT NOT NULL,
  `state_name` VARCHAR(45) NOT NULL,
  `threestatecode` CHAR(3) NULL,
  `country_id` INT NOT NULL,
  PRIMARY KEY (`state_id`),
  INDEX `fk_states_countries_idx` (`country_id` ASC) VISIBLE,
  UNIQUE INDEX `threestatecode_UNIQUE` (`threestatecode` ASC) VISIBLE,
  CONSTRAINT `fk_states_countries`
    FOREIGN KEY (`country_id`)
    REFERENCES `final`.`countries` (`country_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `final`.`cities`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `final`.`cities` ;

CREATE TABLE IF NOT EXISTS `final`.`cities` (
  `city_id` INT NOT NULL AUTO_INCREMENT,
  `city_name` VARCHAR(30) NOT NULL,
  `state_id` INT NOT NULL,
  PRIMARY KEY (`city_id`),
  INDEX `fk_cities_states1_idx` (`state_id` ASC) VISIBLE,
  CONSTRAINT `fk_cities_states1`
    FOREIGN KEY (`state_id`)
    REFERENCES `final`.`states` (`state_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `final`.`addresses`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `final`.`addresses` ;

CREATE TABLE IF NOT EXISTS `final`.`addresses` (
  `address_id` INT NOT NULL AUTO_INCREMENT,
  `address_one` VARCHAR(50) NOT NULL,
  `address_two` VARCHAR(10) NULL,
  `region` VARCHAR(45) NULL,
  `postal_code` INT NOT NULL,
  `city_id` INT NOT NULL,
  PRIMARY KEY (`address_id`),
  INDEX `fk_addresses_cities1_idx` (`city_id` ASC) VISIBLE,
  CONSTRAINT `fk_addresses_cities1`
    FOREIGN KEY (`city_id`)
    REFERENCES `final`.`cities` (`city_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `final`.`persons`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `final`.`persons` ;

CREATE TABLE IF NOT EXISTS `final`.`persons` (
  `person_id` INT NOT NULL,
  `fname` VARCHAR(15) NOT NULL,
  `lname` VARCHAR(35) NOT NULL,
  `gender` ENUM('F', 'M', 'N') NOT NULL,
  `dob` DATE NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `cellphone` VARCHAR(20) NULL,
  `phone` VARCHAR(20) NULL,
  `username` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `religion` VARCHAR(60) NULL,
  `address_id` INT NOT NULL,
  PRIMARY KEY (`person_id`),
  UNIQUE INDEX `username_UNIQUE` (`username` ASC) VISIBLE,
  INDEX `fk_persons_addresses1_idx` (`address_id` ASC) VISIBLE,
  CONSTRAINT `fk_persons_addresses1`
    FOREIGN KEY (`address_id`)
    REFERENCES `final`.`addresses` (`address_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `final`.`roles`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `final`.`roles` ;

CREATE TABLE IF NOT EXISTS `final`.`roles` (
  `role_id` INT NOT NULL,
  `role_name` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`role_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `final`.`isco`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `final`.`isco` ;

CREATE TABLE IF NOT EXISTS `final`.`isco` (
  `isco_id` INT NOT NULL,
  `isco_name` VARCHAR(55) NOT NULL,
  PRIMARY KEY (`isco_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `final`.`person_has_role_and_isco`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `final`.`person_has_role_and_isco` ;

CREATE TABLE IF NOT EXISTS `final`.`person_has_role_and_isco` (
  `person_id` INT NOT NULL,
  `role_id` INT NOT NULL,
  `isco_id` INT NOT NULL,
  PRIMARY KEY (`person_id`, `isco_id`),
  INDEX `fk_person_has_role_and_isco_roles1_idx` (`role_id` ASC) VISIBLE,
  INDEX `fk_person_has_role_and_isco_isco1_idx` (`isco_id` ASC) VISIBLE,
  CONSTRAINT `fk_person_has_role_and_isco_persons1`
    FOREIGN KEY (`person_id`)
    REFERENCES `final`.`persons` (`person_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_person_has_role_and_isco_roles1`
    FOREIGN KEY (`role_id`)
    REFERENCES `final`.`roles` (`role_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_person_has_role_and_isco_isco1`
    FOREIGN KEY (`isco_id`)
    REFERENCES `final`.`isco` (`isco_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `final`.`major_groups`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `final`.`major_groups` ;

CREATE TABLE IF NOT EXISTS `final`.`major_groups` (
  `major_group_id` INT NOT NULL,
  `major_group_name` VARCHAR(70) NOT NULL,
  `isco_id` INT NOT NULL,
  PRIMARY KEY (`major_group_id`),
  INDEX `fk_major_groups_isco1_idx` (`isco_id` ASC) VISIBLE,
  CONSTRAINT `fk_major_groups_isco1`
    FOREIGN KEY (`isco_id`)
    REFERENCES `final`.`isco` (`isco_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `final`.`submajor_groups`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `final`.`submajor_groups` ;

CREATE TABLE IF NOT EXISTS `final`.`submajor_groups` (
  `submajor_group_id` INT NOT NULL,
  `submajor_group_name` VARCHAR(70) NOT NULL,
  `major_group_id` INT NOT NULL,
  PRIMARY KEY (`submajor_group_id`),
  INDEX `fk_submajor_groups_major_groups1_idx` (`major_group_id` ASC) VISIBLE,
  CONSTRAINT `fk_submajor_groups_major_groups1`
    FOREIGN KEY (`major_group_id`)
    REFERENCES `final`.`major_groups` (`major_group_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


-- INSERT STATEMENTS START --------------------------------------------------------------------------------------------------------------------
use final;

-- COUNTRIES TABLE ----------------------------------------------------------------------------------------------------------------------------
INSERT INTO countries (country_id, country_name, twocountrycode, threecountrycode) VALUES
(1,'Afghanistan','AF','AFG'),
(2,'Aland Islands','AX','ALA'),
(3,'Albania','AL','ALB'),
(4,'Algeria','DZ','DZA'),
(5,'American Samoa','AS','ASM'),
(6,'Andorra','AD','AND'),
(7,'Angola','AO','AGO'),
(8,'Anguilla','AI','AIA'),
(9,'Antarctica','AQ','ATA'),
(10,'Antigua and Barbuda','AG','ATG'),
(11,'Argentina','AR','ARG'),
(12,'Armenia','AM','ARM'),
(13,'Aruba','AW','ABW'),
(14,'Australia','AU','AUS'),
(15,'Austria','AT','AUT'),
(16,'Azerbaijan','AZ','AZE'),
(17,'Bahamas','BS','BHS'),
(18,'Bahrain','BH','BHR'),
(19,'Bangladesh','BD','BGD'),
(20,'Barbados','BB','BRB'),
(21,'Belarus','BY','BLR'),
(22,'Belgium','BE','BEL'),
(23,'Belize','BZ','BLZ'),
(24,'Benin','BJ','BEN'),
(25,'Bermuda','BM','BMU'),
(26,'Bhutan','BT','BTN'),
(27,'Bolivia','BO','BOL'),
(28,'Bonaire, Sint Eustatius and Saba','BQ','BES'),
(29,'Bosnia and Herzegovina','BA','BIH'),
(30,'Botswana','BW','BWA'),
(31,'Bouvet Island','BV','BVT'),
(32,'Brazil','BR','BRA'),
(33,'British Indian Ocean Territory','IO','IOT'),
(34,'Brunei','BN','BRN'),
(35,'Bulgaria','BG','BGR'),
(36,'Burkina Faso','BF','BFA'),
(37,'Burundi','BI','BDI'),
(38,'Cambodia','KH','KHM'),
(39,'Cameroon','CM','CMR'),
(40,'Canada','CA','CAN'),
(41,'Cape Verde','CV','CPV'),
(42,'Cayman Islands','KY','CYM'),
(43,'Central African Republic','CF','CAF'),
(44,'Chad','TD','TCD'),
(45,'Chile','CL','CHL'),
(46,'China','CN','CHN'),
(47,'Christmas Island','CX','CXR'),
(48,'Cocos (Keeling) Islands','CC','CCK'),
(49,'Colombia','CO','COL'),
(50,'Comoros','KM','COM'),
(51,'Congo','CG','COG'),
(52,'Cook Islands','CK','COK'),
(53,'Costa Rica','CR','CRI'),
(54,'Ivory Coast','CI','CIV'),
(55,'Croatia','HR','HRV'),
(56,'Cuba','CU','CUB'),
(57,'Curacao','CW','CUW'),
(58,'Cyprus','CY','CYP'),
(59,'Czech Republic','CZ','CZE'),
(60,'Democratic Republic of the Congo','CD','COD'),
(61,'Denmark','DK','DNK'),
(62,'Djibouti','DJ','DJI'),
(63,'Dominica','DM','DMA'),
(64,'Dominican Republic','DO','DOM'),
(65,'Ecuador','EC','ECU'),
(66,'Egypt','EG','EGY'),
(67,'El Salvador','SV','SLV'),
(68,'Equatorial Guinea','GQ','GNQ'),
(69,'Eritrea','ER','ERI'),
(70,'Estonia','EE','EST'),
(71,'Ethiopia','ET','ETH'),
(72,'Falkland Islands (Malvinas)','FK','FLK'),
(73,'Faroe Islands','FO','FRO'),
(74,'Fiji','FJ','FJI'),
(75,'Finland','FI','FIN'),
(76,'France','FR','FRA'),
(77,'French Guiana','GF','GUF'),
(78,'French Polynesia','PF','PYF'),
(79,'French Southern Territories','TF','ATF'),
(80,'Gabon','GA','GAB'),
(81,'Gambia','GM','GMB'),
(82,'Georgia','GE','GEO'),
(83,'Germany','DE','DEU'),
(84,'Ghana','GH','GHA'),
(85,'Gibraltar','GI','GIB'),
(86,'Greece','GR','GRC'),
(87,'Greenland','GL','GRL'),
(88,'Grenada','GD','GRD'),
(89,'Guadaloupe','GP','GLP'),
(90,'Guam','GU','GUM'),
(91,'Guatemala','GT','GTM'),
(92,'Guernsey','GG','GGY'),
(93,'Guinea','GN','GIN'),
(94,'Guinea-Bissau','GW','GNB'),
(95,'Guyana','GY','GUY'),
(96,'Haiti','HT','HTI'),
(97,'Heard Island and McDonald Islands','HM','HMD'),
(98,'Honduras','HN','HND'),
(99,'Hong Kong','HK','HKG'),
(100,'Hungary','HU','HUN'),
(101,'Iceland','IS','ISL'),
(102,'India','IN','IND'),
(103,'Indonesia','ID','IDN'),
(104,'Iran','IR','IRN'),
(105,'Iraq','IQ','IRQ'),
(106,'Ireland','IE','IRL'),
(107,'Isle of Man','IM','IMN'),
(108,'Israel','IL','ISR'),
(109,'Italy','IT','ITA'),
(110,'Jamaica','JM','JAM'),
(111,'Japan','JP','JPN'),
(112,'Jersey','JE','JEY'),
(113,'Jordan','JO','JOR'),
(114,'Kazakhstan','KZ','KAZ'),
(115,'Kenya','KE','KEN'),
(116,'Kiribati','KI','KIR'),
(117,'Kosovo','XK','---'),
(118,'Kuwait','KW','KWT'),
(119,'Kyrgyzstan','KG','KGZ'),
(120,'Laos','LA','LAO'),
(121,'Latvia','LV','LVA'),
(122,'Lebanon','LB','LBN'),
(123,'Lesotho','LS','LSO'),
(124,'Liberia','LR','LBR'),
(125,'Libya','LY','LBY'),
(126,'Liechtenstein','LI','LIE'),
(127,'Lithuania','LT','LTU'),
(128,'Luxembourg','LU','LUX'),
(129,'Macao','MO','MAC'),
(130,'Macedonia','MK','MKD'),
(131,'Madagascar','MG','MDG'),
(132,'Malawi','MW','MWI'),
(133,'Malaysia','MY','MYS'),
(134,'Maldives','MV','MDV'),
(135,'Mali','ML','MLI'),
(136,'Malta','MT','MLT'),
(137,'Marshall Islands','MH','MHL'),
(138,'Martinique','MQ','MTQ'),
(139,'Mauritania','MR','MRT'),
(140,'Mauritius','MU','MUS'),
(141,'Mayotte','YT','MYT'),
(142,'Mexico','MX','MEX'),
(143,'Micronesia','FM','FSM'),
(144,'Moldava','MD','MDA'),
(145,'Monaco','MC','MCO'),
(146,'Mongolia','MN','MNG'),
(147,'Montenegro','ME','MNE'),
(148,'Montserrat','MS','MSR'),
(149,'Morocco','MA','MAR'),
(150,'Mozambique','MZ','MOZ'),
(151,'Myanmar (Burma)','MM','MMR'),
(152,'Namibia','NA','NAM'),
(153,'Nauru','NR','NRU'),
(154,'Nepal','NP','NPL'),
(155,'Netherlands','NL','NLD'),
(156,'New Caledonia','NC','NCL'),
(157,'New Zealand','NZ','NZL'),
(158,'Nicaragua','NI','NIC'),
(159,'Niger','NE','NER'),
(160,'Nigeria','NG','NGA'),
(161,'Niue','NU','NIU'),
(162,'Norfolk Island','NF','NFK'),
(163,'North Korea','KP','PRK'),
(164,'Northern Mariana Islands','MP','MNP'),
(165,'Norway','NO','NOR'),
(166,'Oman','OM','OMN'),
(167,'Pakistan','PK','PAK'),
(168,'Palau','PW','PLW'),
(169,'Palestine','PS','PSE'),
(170,'Panama','PA','PAN'),
(171,'Papua New Guinea','PG','PNG'),
(172,'Paraguay','PY','PRY'),
(173,'Peru','PE','PER'),
(174,'Phillipines','PH','PHL'),
(175,'Pitcairn','PN','PCN'),
(176,'Poland','PL','POL'),
(177,'Portugal','PT','PRT'),
(178,'Puerto Rico','PR','PRI'),
(179,'Qatar','QA','QAT'),
(180,'Reunion','RE','REU'),
(181,'Romania','RO','ROU'),
(182,'Russia','RU','RUS'),
(183,'Rwanda','RW','RWA'),
(184,'Saint Barthelemy','BL','BLM'),
(185,'Saint Helena','SH','SHN'),
(186,'Saint Kitts and Nevis','KN','KNA'),
(187,'Saint Lucia','LC','LCA'),
(188,'Saint Martin','MF','MAF'),
(189,'Saint Pierre and Miquelon','PM','SPM'),
(190,'Saint Vincent and the Grenadines','VC','VCT'),
(191,'Samoa','WS','WSM'),
(192,'San Marino','SM','SMR'),
(193,'Sao Tome and Principe','ST','STP'),
(194,'Saudi Arabia','SA','SAU'),
(195,'Senegal','SN','SEN'),
(196,'Serbia','RS','SRB'),
(197,'Seychelles','SC','SYC'),
(198,'Sierra Leone','SL','SLE'),
(199,'Singapore','SG','SGP'),
(200,'Sint Maarten','SX','SXM'),
(201,'Slovakia','SK','SVK'),
(202,'Slovenia','SI','SVN'),
(203,'Solomon Islands','SB','SLB'),
(204,'Somalia','SO','SOM'),
(205,'South Africa','ZA','ZAF'),
(206,'South Georgia and the South Sandwich Islands','GS','SGS'),
(207,'South Korea','KR','KOR'),
(208,'South Sudan','SS','SSD'),
(209,'Spain','ES','ESP'),
(210,'Sri Lanka','LK','LKA'),
(211,'Sudan','SD','SDN'),
(212,'Suriname','SR','SUR'),
(213,'Svalbard and Jan Mayen','SJ','SJM'),
(214,'Swaziland','SZ','SWZ'),
(215,'Sweden','SE','SWE'),
(216,'Switzerland','CH','CHE'),
(217,'Syria','SY','SYR'),
(218,'Taiwan','TW','TWN'),
(219,'Tajikistan','TJ','TJK'),
(220,'Tanzania','TZ','TZA'),
(221,'Thailand','TH','THA'),
(222,'Timor-Leste (East Timor)','TL','TLS'),
(223,'Togo','TG','TGO'),
(224,'Tokelau','TK','TKL'),
(225,'Tonga','TO','TON'),
(226,'Trinidad and Tobago','TT','TTO'),
(227,'Tunisia','TN','TUN'),
(228,'Turkey','TR','TUR'),
(229,'Turkmenistan','TM','TKM'),
(230,'Turks and Caicos Islands','TC','TCA'),
(231,'Tuvalu','TV','TUV'),
(232,'Uganda','UG','UGA'),
(233,'Ukraine','UA','UKR'),
(234,'United Arab Emirates','AE','ARE'),
(235,'United Kingdom','GB','GBR'),
(236,'United States','US','USA'),
(237,'United States Minor Outlying Islands','UM','UMI'),
(238,'Uruguay','UY','URY'),
(239,'Uzbekistan','UZ','UZB'),
(240,'Vanuatu','VU','VUT'),
(241,'Vatican City','VA','VAT'),
(242,'Venezuela','VE','VEN'),
(243,'Vietnam','VN','VNM'),
(244,'Virgin Islands, British','VG','VGB'),
(245,'Virgin Islands, US','VI','VIR'),
(246,'Wallis and Futuna','WF','WLF'),
(247,'Western Sahara','EH','ESH'),
(248,'Yemen','YE','YEM'),
(249,'Zambia','ZM','ZMB'),
(250,'Zimbabwe','ZW','ZWE');

SELECT * FROM countries;

-- STATES TABLE -------------------------------------------------------------------------------------------------------------------------------
INSERT INTO states (country_id, state_id, state_name, threestatecode) VALUES
(142, 1, 'Aguascalientes', 'AGU'),
(142, 2, 'Baja California', 'BCN'),
(142, 3, 'Baja California Sur', 'BCS'),
(142, 4, 'Campeche', 'CAM'),
(142, 5, 'Chiapas', 'CHP'),
(142, 6, 'Chihuahua', 'CHH'),
(142, 7, 'Coahuila', 'COA'),
(142, 8, 'Colima', 'COL'),
(142, 9, 'Distrito Federal', 'DIF'),
(142, 10, 'Durango', 'DUR'),
(142, 11, 'Guanajuato', 'GUA'),
(142, 12, 'Guerrero', 'GRO'),
(142, 13, 'Hidalgo', 'HID'),
(142, 14, 'Jalisco', 'JAL'),
(142, 15, 'México', 'MEX'),
(142, 16, 'Michoacán', 'MIC'),
(142, 17, 'Morelos', 'MOR'),
(142, 18, 'Nayarit', 'NAY'),
(142, 19, 'Nuevo León', 'NLE'),
(142, 20, 'Oaxaca', 'OAX'),
(142, 21, 'Puebla', 'PUE'),
(142, 22, 'Querétaro', 'QUE'),
(142, 23, 'Quintana Roo', 'ROO'),
(142, 24, 'San Luis Potosí', 'SLP'),
(142, 25, 'Sinaloa', 'SIN'),
(142, 26, 'Sonora', 'SON'),
(142, 27, 'Tabasco', 'TAB'),
(142, 28, 'Tamaulipas', 'TAM'),
(142, 29, 'Tlaxcala', 'TLA'),
(142, 30, 'Veracruz', 'VER'),
(142, 31, 'Yucatán', 'YUC'),
(142, 32, 'Zacatecas', 'ZAC');

SELECT * FROM states;

-- CITIES TABLE -------------------------------------------------------------------------------------------------------------------------------
INSERT INTO cities (city_id, state_id, city_name) VALUES
(1,1,'Aguascalientes'),
(2,2,'Ensenada'),
(3,2,'Mexicali'),
(4,2,'Tijuana'),
(5,3,'La Paz'),
(6,3,'Los Cabos'),
(7,4,'Campeche'),
(8,4,'Carmen'),
(9,5,'Tuxtla Gutiérrez'),
(10,5,'Tapachula'),
(11,5,'Ocosingo'),
(12,5,'San Cristóbal de las Casas'),
(13,5,'Comitán de Domínguez'),
(14,5,'Las Margaritas'),
(15,6,'Juárez'),
(16,6,'Chihuahua'),
(17,6,'Cuauhtémoc'),
(18,6,'Delicias'),
(19,6,'Hidalgo del Parral'),
(20,7,'Saltillo'),
(21,7,'Torreón'),
(22,7,'Monclova'),
(23,7,'Piedras Negras'),
(24,7,'Acuña'),
(25,7,'Matamoros'),
(26,8,'Colima'),
(27,8,'Manzanillo'),
(28,8,'Tecomán'),
(29,9,'Ciudad de México'),
(30,10,'Durango'),
(31,10,'Gómez Palacio'),
(32,10,'Lerdo'),
(33,11,'León'),
(34,11,'Irapuato'),
(35,11,'Celaya'),
(36,11,'Salamanca'),
(37,11,'Pénjamo'),
(38,11,'Guanajuato'),
(39,11,'Allende'),
(40,11,'Silao'),
(41,11,'Valle de Santiago'),
(42,11,'Dolores Hidalgo'),
(43,11,'Acámbaro'),
(44,11,'San Francisco del Rincón'),
(45,11,'San Luis de la Paz'),
(46,11,'San Felipe'),
(47,11,'Salvatierra'),
(48,12,'Acapulco de Juárez'),
(49,12,'Chilpancingo de los Bravo'),
(50,12,'Iguala de la Independencia'),
(51,12,'Chilapa de Alvarez'),
(52,12,'Taxco de Alarcón'),
(53,12,'José Azueta'),
(54,13,'Pachuca de Soto'),
(55,13,'Poza Rica de Hidalgo'),
(56,13,'Tulancingo de Bravo'),
(57,13,'Huejutla de Reyes'),
(58,14,'Guadalajara'),
(59,14,'Zapopan'),
(60,14,'Tlaquepaque'),
(61,14,'Tonalá'),
(62,14,'Puerto Vallarta'),
(63,14,'Lagos de Moreno'),
(64,14,'Tlajomulco de Zúñiga'),
(65,14,'Tepatitlán de Morelos'),
(66,15,'Ecatepec de Morelos'),
(67,15,'Nezahualcóyotl'),
(68,15,'Naucalpan de Juárez'),
(69,15,'Tlalnepantla de Baz'),
(70,15,'Toluca'),
(71,15,'Chimalhuacán'),
(72,15,'Atizapán de Zaragoza'),
(73,15,'Cuautitlán Izcalli'),
(74,15,'Tultitlán'),
(75,15,'Valle de Chalco Solidaridad'),
(76,15,'Ixtapaluca'),
(77,15,'Nicolás Romero'),
(78,15,'Coacalco de Berriozábal'),
(79,15,'Chalco'),
(80,15,'La Paz'),
(81,15,'Texcoco'),
(82,15,'Metepec'),
(83,15,'Huixquilucan'),
(84,15,'San Felipe del Progreso'),
(85,15,'Tecámac'),
(86,15,'Zinacantepec'),
(87,15,'Ixtlahuaca'),
(88,15,'Almoloya de Juárez'),
(89,15,'Zumpango'),
(90,15,'Lerma'),
(91,15,'Tejupilco'),
(92,15,'Tultepec'),
(93,16,'Morelia'),
(94,16,'Uruapan'),
(95,16,'Lázaro Cárdenas'),
(96,16,'Zamora'),
(97,16,'Zitácuaro'),
(98,16,'Apatzingán'),
(99,16,'Hidalgo'),
(100,17,'Cuernavaca'),
(101,17,'Jiutepec'),
(102,17,'Cuautla'),
(103,17,'Temixco'),
(104,18,'Tepic'),
(105,18,'Santiago Ixcuintla'),
(106,19,'Monterrey'),
(107,19,'Guadalupe'),
(108,19,'San Nicolás de los Garza'),
(109,19,'Apodaca'),
(110,19,'General Escobedo'),
(111,19,'Santa Catarina'),
(112,19,'San Pedro Garza García'),
(113,20,'Oaxaca de Juárez'),
(114,20,'San Juan Bautista Tuxtepec'),
(115,21,'Puebla'),
(116,21,'Tehuacán'),
(117,21,'San Martín Texmelucan'),
(118,21,'Atlixco'),
(119,21,'San Pedro Cholula'),
(120,22,'Querétaro'),
(121,22,'San Juan del Río'),
(122,23,'Benito Juárez'),
(123,23,'Othón P. Blanco - Chetumal'),
(124,24,'San Luis Potosí'),
(125,24,'Soledad de Graciano Sánchez'),
(126,24,'Ciudad Valles'),
(127,25,'Culiacán'),
(128,25,'Mazatlán'),
(129,25,'Ahome'),
(130,25,'Guasave'),
(131,25,'Navolato'),
(132,25,'El Fuerte'),
(133,26,'Hermosillo'),
(134,26,'Cajeme'),
(135,26,'Nogales'),
(136,26,'San Luis Río Colorado'),
(137,26,'Navojoa'),
(138,26,'Guaymas'),
(139,27,'Centro - Villahermosa'),
(140,27,'Cárdenas'),
(141,27,'Comalcalco'),
(142,27,'Huimanguillo'),
(143,27,'Macuspana'),
(144,27,'Cunduacán'),
(145,28,'Reynosa'),
(146,28,'Matamoros'),
(147,28,'Nuevo Laredo'),
(148,28,'Tampico'),
(149,28,'Victoria'),
(150,28,'Ciudad Madero'),
(151,28,'Altamira'),
(152,28,'El Mante'),
(153,28,'Río Bravo'),
(154,30,'Veracruz'),
(155,30,'Xalapa'),
(156,30,'Coatzacoalcos'),
(157,30,'Córdoba'),
(158,30,'Papantla'),
(159,30,'Minatitlán'),
(160,30,'San Andrés Tuxtla'),
(161,30,'Túxpam'),
(162,30,'Martínez de la Torre'),
(163,30,'Orizaba'),
(164,30,'Temapache'),
(165,30,'Cosoleacaque'),
(166,30,'Tantoyuca'),
(167,30,'Pánuco'),
(168,30,'Tierra Blanca'),
(169,30,'Boca del Río'),
(170,31,'Mérida'),
(171,32,'Fresnillo'),
(172,32,'Zacatecas'),
(173,32,'Guadalupe');

SELECT * FROM cities;

-- ADDRESSES TABLE ----------------------------------------------------------------------------------------------------------------------------
INSERT INTO addresses (address_id, city_id, address_one, address_two, region, postal_code) VALUES
(DEFAULT,1,'156 Roberts Shores',NULL,NULL,11111),
(DEFAULT,15,'boulevard Sahin 9',NULL,NULL,22222),
(DEFAULT,11,'23387 Dangelo Passage',NULL,NULL,33333),
(DEFAULT,21,'Ulica Matka Peića 99',NULL,NULL,44444),
(DEFAULT,23,'677 Logan Circle',NULL,NULL,55555),
(DEFAULT,23,'Karlakaari 0 906',NULL,NULL,66666),
(DEFAULT,7,'28, impasse Lucie Tanguy',NULL,NULL,77777),
(DEFAULT,2,'12 Tok Wu Road',NULL,NULL,88888),
(DEFAULT,5,'Providus Bank Plc Of Hungary',NULL,NULL,99999),
(DEFAULT,19,'05 Leann Square',NULL,NULL,00000);

SELECT * FROM addresses;

-- PERSONS TABLE ------------------------------------------------------------------------------------------------------------------------------
INSERT INTO persons (person_id, fname, lname, gender, dob, email, cellphone, phone, address_id, username, password, religion) VALUES  
(1, "Christopher", "Davis", 'M', "2000-01-01-", "one@email.com", "111-111-1111", NULL, 1, "userone", "userone", NULL),
(2, "Laurie", "Duran", 'F', "2000-02-02-", "two@email.com", "222-222-2222", "222-2222", 2, "usertwo", "usertwo", 'The Church of Jesus Christ of Latter-Day Saints'),
(3, "Paul", "May", 'M', "2000-03-03-", "three@email.com", "333-333-3333", "333-3333", 3, "userthree", "userthree", NULL),
(4, "David", "Gray", 'M', "2000-04-04-", "four@email.com", "444-444-4444", "444-4444", 4, "userfour", "userfour", NULL),
(5, "Mary", "Hancock", 'N', "2000-05-05-", "five@email.com", "555-555-5555", NULL, 5, "userfive", "userfive", 'The Church of Jesus Christ of Latter-Day Saints'),
(6, "Sarah", "Brock", 'F', "2000-06-06-", "six@email.com", "666-666-6666", "666-6666", 6, "usersix", "usersix", 'The Church of Jesus Christ of Latter-Day Saints'),
(7, "Nicholas", "Jones", 'M', "2000-07-07-", "seven@email.com", "777-777-7777", "777-7777", 7, "userseven", "userseven", 'The Church of Jesus Christ of Latter-Day Saints'),
(8, "Amanda", "Obrien", 'F', "2000-08-08-", "eight@email.com", "888-888-8888", "888-8888", 8, "usereight", "usereight", 'The Church of Jesus Christ of Latter-Day Saints'),
(9, "Daniel", "Hernandez", 'M', "2000-09-09-", "nine@email.com", "999-999-9999", "999-9999", 9, "usernine", "usernine", 'The Church of Jesus Christ of Latter-Day Saints'),
(10, "Sharon", "Cruz", 'F', "2000-10-10-", "ten@email.com", "000-000-0000", NULL, 10, "userten", "userten", 'The Church of Jesus Christ of Latter-Day Saints');

SELECT * FROM persons;

-- ROLES TABLE --------------------------------------------------------------------------------------------------------------------------------
INSERT INTO roles (role_id, role_name) VALUES
(1, 'worker'),
(2, 'solicitant');

SELECT * FROM roles;

-- ISCO TABLE ---------------------------------------------------------------------------------------------------------------------------------
-- https://en.wikipedia.org/wiki/International_Standard_Classification_of_Occupations 
INSERT INTO isco (isco_id, isco_name) VALUES
(1, 'Managers'),
(2, 'Professional'),
(3, 'Technicians and associate professionals'),
(4, 'Clerical support workers'),
(5, 'Service and sales workes'),
(6, 'Skilled agricultural, forestry and fishery workers'),
(7, 'Craft and related trades workers'),
(8, 'Plant and machine operators, and assemblers'),
(9, 'Elementary occupations'),
(10, 'Armed forces occupations');

SELECT * FROM isco;

-- PERSON HAS ROLE AND ISCO TABLE -------------------------------------------------------------------------------------------------------------
INSERT INTO person_has_role_and_isco (person_id, role_id, isco_id) VALUES
(1, 2, 1),
(1, 1, 2),
(2, 1, 3),
(2, 2, 4),
(3, 1, 5),
(3, 2, 6),
(4, 1, 7),
(4, 2, 8),
(5, 1, 9),
(5, 2, 10);

SELECT * FROM person_has_role_and_isco;

-- MAJOR GROUPS TABLE -------------------------------------------------------------------------------------------------------------------------
INSERT INTO major_groups (isco_id, major_group_id, major_group_name) VALUES
(1, 11, 'Chief executives, senior officials and legislators'),
(1, 12, 'Administrative and commercial managers'),
(1, 13, 'Production and specialized services managers'),
(1, 14, 'Hospitality, retail and other services managers');

SELECT * FROM major_groups;

-- SUBMAJOR GROUPS TABLE ----------------------------------------------------------------------------------------------------------------------
INSERT INTO submajor_groups (major_group_id, submajor_group_id, submajor_group_name) VALUES
(11, 111, 'Legislators and senior officials'),
(11, 112, 'Managing directors and chief executives'),
(12, 121, 'Business services and administration managers'),
(12, 122, 'Sales, marketing and development managers');

SELECT * FROM submajor_groups;


