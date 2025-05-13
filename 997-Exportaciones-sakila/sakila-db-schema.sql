-- phpMyAdmin SQL Dump
-- version 5.2.1deb1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Tiempo de generación: 13-05-2025 a las 10:50:38
-- Versión del servidor: 10.11.11-MariaDB-0+deb12u1
-- Versión de PHP: 8.2.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `sakila`
--
CREATE DATABASE IF NOT EXISTS `sakila` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `sakila`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `actor`
--

DROP TABLE IF EXISTS `actor`;
CREATE TABLE `actor` (
  `actor_id` smallint(5) UNSIGNED NOT NULL,
  `first_name` varchar(45) NOT NULL,
  `last_name` varchar(45) NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `actor_info`
-- (Véase abajo para la vista actual)
--
DROP VIEW IF EXISTS `actor_info`;
CREATE TABLE `actor_info` (
`actor_id` smallint(5) unsigned
,`first_name` varchar(45)
,`last_name` varchar(45)
,`film_info` mediumtext
);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `address`
--

DROP TABLE IF EXISTS `address`;
CREATE TABLE `address` (
  `address_id` smallint(5) UNSIGNED NOT NULL,
  `address` varchar(50) NOT NULL,
  `address2` varchar(50) DEFAULT NULL,
  `district` varchar(20) NOT NULL,
  `city_id` smallint(5) UNSIGNED NOT NULL,
  `postal_code` varchar(10) DEFAULT NULL,
  `phone` varchar(20) NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `category`
--

DROP TABLE IF EXISTS `category`;
CREATE TABLE `category` (
  `category_id` tinyint(3) UNSIGNED NOT NULL,
  `name` varchar(25) NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `city`
--

DROP TABLE IF EXISTS `city`;
CREATE TABLE `city` (
  `city_id` smallint(5) UNSIGNED NOT NULL,
  `city` varchar(50) NOT NULL,
  `country_id` smallint(5) UNSIGNED NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `country`
--

DROP TABLE IF EXISTS `country`;
CREATE TABLE `country` (
  `country_id` smallint(5) UNSIGNED NOT NULL,
  `country` varchar(50) NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `customer`
--

DROP TABLE IF EXISTS `customer`;
CREATE TABLE `customer` (
  `customer_id` smallint(5) UNSIGNED NOT NULL,
  `store_id` tinyint(3) UNSIGNED NOT NULL,
  `first_name` varchar(45) NOT NULL,
  `last_name` varchar(45) NOT NULL,
  `email` varchar(50) DEFAULT NULL,
  `address_id` smallint(5) UNSIGNED NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `create_date` datetime NOT NULL,
  `last_update` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Disparadores `customer`
--
DROP TRIGGER IF EXISTS `customer_create_date`;
DELIMITER $$
CREATE TRIGGER `customer_create_date` BEFORE INSERT ON `customer` FOR EACH ROW SET NEW.create_date = NOW()
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `customer_list`
-- (Véase abajo para la vista actual)
--
DROP VIEW IF EXISTS `customer_list`;
CREATE TABLE `customer_list` (
`ID` smallint(5) unsigned
,`name` varchar(91)
,`address` varchar(50)
,`zip code` varchar(10)
,`phone` varchar(20)
,`city` varchar(50)
,`country` varchar(50)
,`notes` varchar(6)
,`SID` tinyint(3) unsigned
);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `film`
--

DROP TABLE IF EXISTS `film`;
CREATE TABLE `film` (
  `film_id` smallint(5) UNSIGNED NOT NULL,
  `title` varchar(128) NOT NULL,
  `description` text DEFAULT NULL,
  `release_year` year(4) DEFAULT NULL,
  `language_id` tinyint(3) UNSIGNED NOT NULL,
  `original_language_id` tinyint(3) UNSIGNED DEFAULT NULL,
  `rental_duration` tinyint(3) UNSIGNED NOT NULL DEFAULT 3,
  `rental_rate` decimal(4,2) NOT NULL DEFAULT 4.99,
  `length` smallint(5) UNSIGNED DEFAULT NULL,
  `replacement_cost` decimal(5,2) NOT NULL DEFAULT 19.99,
  `rating` enum('G','PG','PG-13','R','NC-17') DEFAULT 'G',
  `special_features` set('Trailers','Commentaries','Deleted Scenes','Behind the Scenes') DEFAULT NULL,
  `last_update` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Disparadores `film`
--
DROP TRIGGER IF EXISTS `del_film`;
DELIMITER $$
CREATE TRIGGER `del_film` AFTER DELETE ON `film` FOR EACH ROW BEGIN
    DELETE FROM film_text WHERE film_id = old.film_id;
  END
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `ins_film`;
DELIMITER $$
CREATE TRIGGER `ins_film` AFTER INSERT ON `film` FOR EACH ROW BEGIN
    INSERT INTO film_text (film_id, title, description)
        VALUES (new.film_id, new.title, new.description);
  END
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `upd_film`;
DELIMITER $$
CREATE TRIGGER `upd_film` AFTER UPDATE ON `film` FOR EACH ROW BEGIN
    IF (old.title != new.title) OR (old.description != new.description) OR (old.film_id != new.film_id)
    THEN
        UPDATE film_text
            SET title=new.title,
                description=new.description,
                film_id=new.film_id
        WHERE film_id=old.film_id;
    END IF;
  END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `film_actor`
--

DROP TABLE IF EXISTS `film_actor`;
CREATE TABLE `film_actor` (
  `actor_id` smallint(5) UNSIGNED NOT NULL,
  `film_id` smallint(5) UNSIGNED NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `film_category`
--

DROP TABLE IF EXISTS `film_category`;
CREATE TABLE `film_category` (
  `film_id` smallint(5) UNSIGNED NOT NULL,
  `category_id` tinyint(3) UNSIGNED NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `film_list`
-- (Véase abajo para la vista actual)
--
DROP VIEW IF EXISTS `film_list`;
CREATE TABLE `film_list` (
`FID` smallint(5) unsigned
,`title` varchar(128)
,`description` text
,`category` varchar(25)
,`price` decimal(4,2)
,`length` smallint(5) unsigned
,`rating` enum('G','PG','PG-13','R','NC-17')
,`actors` mediumtext
);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `film_text`
--

DROP TABLE IF EXISTS `film_text`;
CREATE TABLE `film_text` (
  `film_id` smallint(5) UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inventory`
--

DROP TABLE IF EXISTS `inventory`;
CREATE TABLE `inventory` (
  `inventory_id` mediumint(8) UNSIGNED NOT NULL,
  `film_id` smallint(5) UNSIGNED NOT NULL,
  `store_id` tinyint(3) UNSIGNED NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `language`
--

DROP TABLE IF EXISTS `language`;
CREATE TABLE `language` (
  `language_id` tinyint(3) UNSIGNED NOT NULL,
  `name` char(20) NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `nicer_but_slower_film_list`
-- (Véase abajo para la vista actual)
--
DROP VIEW IF EXISTS `nicer_but_slower_film_list`;
CREATE TABLE `nicer_but_slower_film_list` (
`FID` smallint(5) unsigned
,`title` varchar(128)
,`description` text
,`category` varchar(25)
,`price` decimal(4,2)
,`length` smallint(5) unsigned
,`rating` enum('G','PG','PG-13','R','NC-17')
,`actors` mediumtext
);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `payment`
--

DROP TABLE IF EXISTS `payment`;
CREATE TABLE `payment` (
  `payment_id` smallint(5) UNSIGNED NOT NULL,
  `customer_id` smallint(5) UNSIGNED NOT NULL,
  `staff_id` tinyint(3) UNSIGNED NOT NULL,
  `rental_id` int(11) DEFAULT NULL,
  `amount` decimal(5,2) NOT NULL,
  `payment_date` datetime NOT NULL,
  `last_update` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Disparadores `payment`
--
DROP TRIGGER IF EXISTS `payment_date`;
DELIMITER $$
CREATE TRIGGER `payment_date` BEFORE INSERT ON `payment` FOR EACH ROW SET NEW.payment_date = NOW()
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rental`
--

DROP TABLE IF EXISTS `rental`;
CREATE TABLE `rental` (
  `rental_id` int(11) NOT NULL,
  `rental_date` datetime NOT NULL,
  `inventory_id` mediumint(8) UNSIGNED NOT NULL,
  `customer_id` smallint(5) UNSIGNED NOT NULL,
  `return_date` datetime DEFAULT NULL,
  `staff_id` tinyint(3) UNSIGNED NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Disparadores `rental`
--
DROP TRIGGER IF EXISTS `rental_date`;
DELIMITER $$
CREATE TRIGGER `rental_date` BEFORE INSERT ON `rental` FOR EACH ROW SET NEW.rental_date = NOW()
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `sales_by_film_category`
-- (Véase abajo para la vista actual)
--
DROP VIEW IF EXISTS `sales_by_film_category`;
CREATE TABLE `sales_by_film_category` (
`category` varchar(25)
,`total_sales` decimal(27,2)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `sales_by_store`
-- (Véase abajo para la vista actual)
--
DROP VIEW IF EXISTS `sales_by_store`;
CREATE TABLE `sales_by_store` (
`store` varchar(101)
,`manager` varchar(91)
,`total_sales` decimal(27,2)
);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `staff`
--

DROP TABLE IF EXISTS `staff`;
CREATE TABLE `staff` (
  `staff_id` tinyint(3) UNSIGNED NOT NULL,
  `first_name` varchar(45) NOT NULL,
  `last_name` varchar(45) NOT NULL,
  `address_id` smallint(5) UNSIGNED NOT NULL,
  `picture` blob DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `store_id` tinyint(3) UNSIGNED NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `username` varchar(16) NOT NULL,
  `password` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `last_update` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `staff_list`
-- (Véase abajo para la vista actual)
--
DROP VIEW IF EXISTS `staff_list`;
CREATE TABLE `staff_list` (
`ID` tinyint(3) unsigned
,`name` varchar(91)
,`address` varchar(50)
,`zip code` varchar(10)
,`phone` varchar(20)
,`city` varchar(50)
,`country` varchar(50)
,`SID` tinyint(3) unsigned
);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `store`
--

DROP TABLE IF EXISTS `store`;
CREATE TABLE `store` (
  `store_id` tinyint(3) UNSIGNED NOT NULL,
  `manager_staff_id` tinyint(3) UNSIGNED NOT NULL,
  `address_id` smallint(5) UNSIGNED NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura para la vista `actor_info`
--
DROP TABLE IF EXISTS `actor_info`;

DROP VIEW IF EXISTS `actor_info`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY INVOKER VIEW `actor_info`  AS SELECT `a`.`actor_id` AS `actor_id`, `a`.`first_name` AS `first_name`, `a`.`last_name` AS `last_name`, group_concat(distinct concat(`c`.`name`,': ',(select group_concat(`f`.`title` order by `f`.`title` ASC separator ', ') from ((`film` `f` join `film_category` `fc` on(`f`.`film_id` = `fc`.`film_id`)) join `film_actor` `fa` on(`f`.`film_id` = `fa`.`film_id`)) where `fc`.`category_id` = `c`.`category_id` and `fa`.`actor_id` = `a`.`actor_id`)) order by `c`.`name` ASC separator '; ') AS `film_info` FROM (((`actor` `a` left join `film_actor` `fa` on(`a`.`actor_id` = `fa`.`actor_id`)) left join `film_category` `fc` on(`fa`.`film_id` = `fc`.`film_id`)) left join `category` `c` on(`fc`.`category_id` = `c`.`category_id`)) GROUP BY `a`.`actor_id`, `a`.`first_name`, `a`.`last_name` ;

-- --------------------------------------------------------

--
-- Estructura para la vista `customer_list`
--
DROP TABLE IF EXISTS `customer_list`;

DROP VIEW IF EXISTS `customer_list`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `customer_list`  AS SELECT `cu`.`customer_id` AS `ID`, concat(`cu`.`first_name`,_utf8mb4' ',`cu`.`last_name`) AS `name`, `a`.`address` AS `address`, `a`.`postal_code` AS `zip code`, `a`.`phone` AS `phone`, `city`.`city` AS `city`, `country`.`country` AS `country`, if(`cu`.`active`,_utf8mb4'active',_utf8mb4'') AS `notes`, `cu`.`store_id` AS `SID` FROM (((`customer` `cu` join `address` `a` on(`cu`.`address_id` = `a`.`address_id`)) join `city` on(`a`.`city_id` = `city`.`city_id`)) join `country` on(`city`.`country_id` = `country`.`country_id`)) ;

-- --------------------------------------------------------

--
-- Estructura para la vista `film_list`
--
DROP TABLE IF EXISTS `film_list`;

DROP VIEW IF EXISTS `film_list`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `film_list`  AS SELECT `film`.`film_id` AS `FID`, `film`.`title` AS `title`, `film`.`description` AS `description`, `category`.`name` AS `category`, `film`.`rental_rate` AS `price`, `film`.`length` AS `length`, `film`.`rating` AS `rating`, group_concat(concat(`actor`.`first_name`,_utf8mb4' ',`actor`.`last_name`) separator ', ') AS `actors` FROM ((((`film` left join `film_category` on(`film_category`.`film_id` = `film`.`film_id`)) left join `category` on(`category`.`category_id` = `film_category`.`category_id`)) left join `film_actor` on(`film`.`film_id` = `film_actor`.`film_id`)) left join `actor` on(`film_actor`.`actor_id` = `actor`.`actor_id`)) GROUP BY `film`.`film_id`, `category`.`name` ;

-- --------------------------------------------------------

--
-- Estructura para la vista `nicer_but_slower_film_list`
--
DROP TABLE IF EXISTS `nicer_but_slower_film_list`;

DROP VIEW IF EXISTS `nicer_but_slower_film_list`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `nicer_but_slower_film_list`  AS SELECT `film`.`film_id` AS `FID`, `film`.`title` AS `title`, `film`.`description` AS `description`, `category`.`name` AS `category`, `film`.`rental_rate` AS `price`, `film`.`length` AS `length`, `film`.`rating` AS `rating`, group_concat(concat(concat(ucase(substr(`actor`.`first_name`,1,1)),lcase(substr(`actor`.`first_name`,2,octet_length(`actor`.`first_name`))),_utf8mb4' ',concat(ucase(substr(`actor`.`last_name`,1,1)),lcase(substr(`actor`.`last_name`,2,octet_length(`actor`.`last_name`)))))) separator ', ') AS `actors` FROM ((((`film` left join `film_category` on(`film_category`.`film_id` = `film`.`film_id`)) left join `category` on(`category`.`category_id` = `film_category`.`category_id`)) left join `film_actor` on(`film`.`film_id` = `film_actor`.`film_id`)) left join `actor` on(`film_actor`.`actor_id` = `actor`.`actor_id`)) GROUP BY `film`.`film_id`, `category`.`name` ;

-- --------------------------------------------------------

--
-- Estructura para la vista `sales_by_film_category`
--
DROP TABLE IF EXISTS `sales_by_film_category`;

DROP VIEW IF EXISTS `sales_by_film_category`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `sales_by_film_category`  AS SELECT `c`.`name` AS `category`, sum(`p`.`amount`) AS `total_sales` FROM (((((`payment` `p` join `rental` `r` on(`p`.`rental_id` = `r`.`rental_id`)) join `inventory` `i` on(`r`.`inventory_id` = `i`.`inventory_id`)) join `film` `f` on(`i`.`film_id` = `f`.`film_id`)) join `film_category` `fc` on(`f`.`film_id` = `fc`.`film_id`)) join `category` `c` on(`fc`.`category_id` = `c`.`category_id`)) GROUP BY `c`.`name` ORDER BY sum(`p`.`amount`) DESC ;

-- --------------------------------------------------------

--
-- Estructura para la vista `sales_by_store`
--
DROP TABLE IF EXISTS `sales_by_store`;

DROP VIEW IF EXISTS `sales_by_store`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `sales_by_store`  AS SELECT concat(`c`.`city`,_utf8mb4',',`cy`.`country`) AS `store`, concat(`m`.`first_name`,_utf8mb4' ',`m`.`last_name`) AS `manager`, sum(`p`.`amount`) AS `total_sales` FROM (((((((`payment` `p` join `rental` `r` on(`p`.`rental_id` = `r`.`rental_id`)) join `inventory` `i` on(`r`.`inventory_id` = `i`.`inventory_id`)) join `store` `s` on(`i`.`store_id` = `s`.`store_id`)) join `address` `a` on(`s`.`address_id` = `a`.`address_id`)) join `city` `c` on(`a`.`city_id` = `c`.`city_id`)) join `country` `cy` on(`c`.`country_id` = `cy`.`country_id`)) join `staff` `m` on(`s`.`manager_staff_id` = `m`.`staff_id`)) GROUP BY `s`.`store_id` ORDER BY `cy`.`country` ASC, `c`.`city` ASC ;

-- --------------------------------------------------------

--
-- Estructura para la vista `staff_list`
--
DROP TABLE IF EXISTS `staff_list`;

DROP VIEW IF EXISTS `staff_list`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `staff_list`  AS SELECT `s`.`staff_id` AS `ID`, concat(`s`.`first_name`,_utf8mb4' ',`s`.`last_name`) AS `name`, `a`.`address` AS `address`, `a`.`postal_code` AS `zip code`, `a`.`phone` AS `phone`, `city`.`city` AS `city`, `country`.`country` AS `country`, `s`.`store_id` AS `SID` FROM (((`staff` `s` join `address` `a` on(`s`.`address_id` = `a`.`address_id`)) join `city` on(`a`.`city_id` = `city`.`city_id`)) join `country` on(`city`.`country_id` = `country`.`country_id`)) ;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `actor`
--
ALTER TABLE `actor`
  ADD PRIMARY KEY (`actor_id`),
  ADD KEY `idx_actor_last_name` (`last_name`);

--
-- Indices de la tabla `address`
--
ALTER TABLE `address`
  ADD PRIMARY KEY (`address_id`),
  ADD KEY `idx_fk_city_id` (`city_id`);

--
-- Indices de la tabla `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`category_id`);

--
-- Indices de la tabla `city`
--
ALTER TABLE `city`
  ADD PRIMARY KEY (`city_id`),
  ADD KEY `idx_fk_country_id` (`country_id`);

--
-- Indices de la tabla `country`
--
ALTER TABLE `country`
  ADD PRIMARY KEY (`country_id`);

--
-- Indices de la tabla `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`customer_id`),
  ADD KEY `idx_fk_store_id` (`store_id`),
  ADD KEY `idx_fk_address_id` (`address_id`),
  ADD KEY `idx_last_name` (`last_name`);

--
-- Indices de la tabla `film`
--
ALTER TABLE `film`
  ADD PRIMARY KEY (`film_id`),
  ADD KEY `idx_title` (`title`),
  ADD KEY `idx_fk_language_id` (`language_id`),
  ADD KEY `idx_fk_original_language_id` (`original_language_id`);

--
-- Indices de la tabla `film_actor`
--
ALTER TABLE `film_actor`
  ADD PRIMARY KEY (`actor_id`,`film_id`),
  ADD KEY `idx_fk_film_id` (`film_id`);

--
-- Indices de la tabla `film_category`
--
ALTER TABLE `film_category`
  ADD PRIMARY KEY (`film_id`,`category_id`),
  ADD KEY `fk_film_category_category` (`category_id`);

--
-- Indices de la tabla `film_text`
--
ALTER TABLE `film_text`
  ADD PRIMARY KEY (`film_id`);
ALTER TABLE `film_text` ADD FULLTEXT KEY `idx_title_description` (`title`,`description`);

--
-- Indices de la tabla `inventory`
--
ALTER TABLE `inventory`
  ADD PRIMARY KEY (`inventory_id`),
  ADD KEY `idx_fk_film_id` (`film_id`),
  ADD KEY `idx_store_id_film_id` (`store_id`,`film_id`);

--
-- Indices de la tabla `language`
--
ALTER TABLE `language`
  ADD PRIMARY KEY (`language_id`);

--
-- Indices de la tabla `payment`
--
ALTER TABLE `payment`
  ADD PRIMARY KEY (`payment_id`),
  ADD KEY `idx_fk_staff_id` (`staff_id`),
  ADD KEY `idx_fk_customer_id` (`customer_id`),
  ADD KEY `fk_payment_rental` (`rental_id`);

--
-- Indices de la tabla `rental`
--
ALTER TABLE `rental`
  ADD PRIMARY KEY (`rental_id`),
  ADD UNIQUE KEY `rental_date` (`rental_date`,`inventory_id`,`customer_id`),
  ADD KEY `idx_fk_inventory_id` (`inventory_id`),
  ADD KEY `idx_fk_customer_id` (`customer_id`),
  ADD KEY `idx_fk_staff_id` (`staff_id`);

--
-- Indices de la tabla `staff`
--
ALTER TABLE `staff`
  ADD PRIMARY KEY (`staff_id`),
  ADD KEY `idx_fk_store_id` (`store_id`),
  ADD KEY `idx_fk_address_id` (`address_id`);

--
-- Indices de la tabla `store`
--
ALTER TABLE `store`
  ADD PRIMARY KEY (`store_id`),
  ADD UNIQUE KEY `idx_unique_manager` (`manager_staff_id`),
  ADD KEY `idx_fk_address_id` (`address_id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `actor`
--
ALTER TABLE `actor`
  MODIFY `actor_id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `address`
--
ALTER TABLE `address`
  MODIFY `address_id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `category`
--
ALTER TABLE `category`
  MODIFY `category_id` tinyint(3) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `city`
--
ALTER TABLE `city`
  MODIFY `city_id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `country`
--
ALTER TABLE `country`
  MODIFY `country_id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `customer`
--
ALTER TABLE `customer`
  MODIFY `customer_id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `film`
--
ALTER TABLE `film`
  MODIFY `film_id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `inventory`
--
ALTER TABLE `inventory`
  MODIFY `inventory_id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `language`
--
ALTER TABLE `language`
  MODIFY `language_id` tinyint(3) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `payment`
--
ALTER TABLE `payment`
  MODIFY `payment_id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `rental`
--
ALTER TABLE `rental`
  MODIFY `rental_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `staff`
--
ALTER TABLE `staff`
  MODIFY `staff_id` tinyint(3) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `store`
--
ALTER TABLE `store`
  MODIFY `store_id` tinyint(3) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `address`
--
ALTER TABLE `address`
  ADD CONSTRAINT `fk_address_city` FOREIGN KEY (`city_id`) REFERENCES `city` (`city_id`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `city`
--
ALTER TABLE `city`
  ADD CONSTRAINT `fk_city_country` FOREIGN KEY (`country_id`) REFERENCES `country` (`country_id`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `customer`
--
ALTER TABLE `customer`
  ADD CONSTRAINT `fk_customer_address` FOREIGN KEY (`address_id`) REFERENCES `address` (`address_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_customer_store` FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `film`
--
ALTER TABLE `film`
  ADD CONSTRAINT `fk_film_language` FOREIGN KEY (`language_id`) REFERENCES `language` (`language_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_film_language_original` FOREIGN KEY (`original_language_id`) REFERENCES `language` (`language_id`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `film_actor`
--
ALTER TABLE `film_actor`
  ADD CONSTRAINT `fk_film_actor_actor` FOREIGN KEY (`actor_id`) REFERENCES `actor` (`actor_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_film_actor_film` FOREIGN KEY (`film_id`) REFERENCES `film` (`film_id`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `film_category`
--
ALTER TABLE `film_category`
  ADD CONSTRAINT `fk_film_category_category` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_film_category_film` FOREIGN KEY (`film_id`) REFERENCES `film` (`film_id`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `inventory`
--
ALTER TABLE `inventory`
  ADD CONSTRAINT `fk_inventory_film` FOREIGN KEY (`film_id`) REFERENCES `film` (`film_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_inventory_store` FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `payment`
--
ALTER TABLE `payment`
  ADD CONSTRAINT `fk_payment_customer` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_payment_rental` FOREIGN KEY (`rental_id`) REFERENCES `rental` (`rental_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_payment_staff` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`staff_id`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `rental`
--
ALTER TABLE `rental`
  ADD CONSTRAINT `fk_rental_customer` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_rental_inventory` FOREIGN KEY (`inventory_id`) REFERENCES `inventory` (`inventory_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_rental_staff` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`staff_id`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `staff`
--
ALTER TABLE `staff`
  ADD CONSTRAINT `fk_staff_address` FOREIGN KEY (`address_id`) REFERENCES `address` (`address_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_staff_store` FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `store`
--
ALTER TABLE `store`
  ADD CONSTRAINT `fk_store_address` FOREIGN KEY (`address_id`) REFERENCES `address` (`address_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_store_staff` FOREIGN KEY (`manager_staff_id`) REFERENCES `staff` (`staff_id`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
