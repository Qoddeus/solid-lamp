-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 20, 2022 at 08:55 PM
-- Server version: 10.4.24-MariaDB
-- PHP Version: 8.1.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `cs301_project_invsys`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `adm_id` int(11) NOT NULL,
  `adm_username` varchar(20) NOT NULL,
  `adm_password` varchar(128) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`adm_id`, `adm_username`, `adm_password`) VALUES
(1, 'im_thady', '$2b$12$5D0rewNI8TS8VmaQA3QiCuRTIpVgFfak1YdP2JzdpZEIqYB/y.5ea'),
(2, 'super_admin', '$2b$12$hOvNj7KwMRAH7RhJYdH0uejs715EMlfqc6zXhMsErTWhV4lpZv2Ga'),
(3, 'admin', '$2b$12$xpEGeN/uJt31n4zIMrQOuequm5U7ml3OqJRw5G7wovbB1V7FAn0Qq'),
(4, 'super_thady', '$2b$12$Z4ET/2TOSRsrEgNBsHfSNeWHea/NN1P2/94F2ajRHIjEft.x.IMR2'),
(5, 'test', '$2b$12$rjno32c4xwhlXu45v6Aiou.WoN0IN8wgciWrKYYvXaUoEiFqNftqy');

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `cus_id` int(11) NOT NULL,
  `cus_name` varchar(50) NOT NULL,
  `cus_phone` varchar(11) NOT NULL,
  `cus_email` varchar(320) NOT NULL,
  `cus_website` varchar(320) NOT NULL,
  `cus_billadd` varchar(256) NOT NULL,
  `cus_shipadd` varchar(256) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`cus_id`, `cus_name`, `cus_phone`, `cus_email`, `cus_website`, `cus_billadd`, `cus_shipadd`) VALUES
(1, 'Turcotte-Littel LLC', '881-559-659', 'krenner@gmail.com', 'wolfschmitt.com', 'Kellie Renner', '32/58 Carter View Apt. 357, Lal-lo 4325 Samar'),
(2, 'Runolfsson Inc PLC', '220-226-077', 'price@botsford.com', 'runolfsson.com', 'Teresa Price', '24A/88 Spinka Path, Macrohon 0750 Bulacan'),
(3, 'Boyle Group Group', '710-256-346', 'theowis@gmail.com', 'boylegg.biz', 'Theodore Wisozk', '32A/51 Heaney Plain, Poblacion, Angeles 2168 Negros Occidental'),
(4, 'Rath and Sons Inc', '023-826-881', 'cam.mar@medhurst.com', 'Ras-inc.biz', 'Camryn Marquardt', '17/68 Boyle Square Suite 798, Malapatan 6456 Bataan');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `pro_id` int(11) NOT NULL,
  `pro_image` varchar(256) NOT NULL,
  `pro_name` varchar(64) NOT NULL,
  `sku` varchar(15) NOT NULL,
  `pro_barcode` varchar(15) NOT NULL,
  `pro_category` varchar(64) NOT NULL,
  `pro_description` varchar(256) NOT NULL,
  `pro_price` double NOT NULL,
  `pro_quantity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`pro_id`, `pro_image`, `pro_name`, `sku`, `pro_barcode`, `pro_category`, `pro_description`, `pro_price`, `pro_quantity`) VALUES
(1, 'https://i.ibb.co/0qX5T9g/AMOR0001.webp', 'NMD_R1 PRIMEBLUE SHOES', 'AMOR0001', 'BC-0004', 'Men, Originals', 'Core Black / Core Black / Gum', 8000, 225),
(2, 'https://i.ibb.co/tP5jB3b/AMRU0022.webp', 'ULTRABOOST 22 SHOES', 'AMRU0022', 'BC-0002', 'Men, Running', 'Core Black / Core Black / Core Black', 10000, 340),
(3, 'https://i.ibb.co/PcMC9Q9/AOCO0080.webp', 'CONTINENTAL 80 SHOES', 'AOCO0080', 'BC-0001', 'Originals', 'Cloud White / Scarlet / Collegiate Navy', 5300, 600),
(4, 'https://i.ibb.co/r40nTHg/ARUD0004.webp', 'ULTRA 4DFWD SHOES', 'ARUD0004', 'BC-0003', 'Running', 'Core Black / Core Black / Carbon', 14000, 460);

-- --------------------------------------------------------

--
-- Table structure for table `purchase_orders`
--

CREATE TABLE `purchase_orders` (
  `po_ordnum` varchar(15) NOT NULL,
  `po_vendor` varchar(50) NOT NULL,
  `po_phone` varchar(11) NOT NULL,
  `po_email` varchar(320) NOT NULL,
  `po_venadd` varchar(256) NOT NULL,
  `po_location` varchar(128) NOT NULL,
  `po_orddate` date NOT NULL,
  `po_product` varchar(50) NOT NULL,
  `po_qty` int(11) NOT NULL,
  `po_unprice` float NOT NULL,
  `po_total` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `purchase_orders`
--

INSERT INTO `purchase_orders` (`po_ordnum`, `po_vendor`, `po_phone`, `po_email`, `po_venadd`, `po_location`, `po_orddate`, `po_product`, `po_qty`, `po_unprice`, `po_total`) VALUES
('PO-0001', 'West, Rempel and Bode Ltd', '856-887-758', 'cordie29@mueller.info', '30 Sporer Mission Suite 567, Poblacion, Iriga 4875 Basilan', 'Warehouse One', '2022-09-20', 'CONTINENTAL 80 SHOES', 50, 5300, 265000),
('PO-0002', 'Franecki Inc LLC', '522-302-719', 'jackie14@schneider.org', '53A/78 Blick Springs, Poblacion, Bago 2652 Iloilo', 'Warehouse One', '2022-09-20', 'NMD_R1 PRIMEBLUE SHOES', 25, 8000, 200000),
('PO-0003', 'Bailey, Welch and Goodwin Inc', '052-752-472', 'isaccarroll@waters.biz', '24/13 Torp Creek, Poblacion, Santa Rosa 7758 Siquijor', 'Warehouse Two', '2022-09-20', 'ULTRABOOST 22 SHOES', 40, 10000, 400000);

-- --------------------------------------------------------

--
-- Table structure for table `sales_orders`
--

CREATE TABLE `sales_orders` (
  `so_ordnum` varchar(15) NOT NULL,
  `so_customer` varchar(50) NOT NULL,
  `so_phone` varchar(11) NOT NULL,
  `so_email` varchar(320) NOT NULL,
  `so_shipadd` varchar(256) NOT NULL,
  `so_location` varchar(128) NOT NULL,
  `so_orddate` date NOT NULL,
  `so_product` varchar(50) NOT NULL,
  `so_qty` int(11) NOT NULL,
  `so_unprice` float NOT NULL,
  `so_total` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `sales_orders`
--

INSERT INTO `sales_orders` (`so_ordnum`, `so_customer`, `so_phone`, `so_email`, `so_shipadd`, `so_location`, `so_orddate`, `so_product`, `so_qty`, `so_unprice`, `so_total`) VALUES
('SO-0001', 'Rath and Sons Inc', '023-826-881', 'cam.mar@medhurst.com', '17/68 Boyle Square Suite 798, Malapatan 6456 Bataan', 'Warehouse One', '2022-09-20', 'ULTRABOOST 22 SHOES', 10, 10000, 100000),
('SO-0002', 'Boyle Group Group', '710-256-346', 'theowis@gmail.com', '32A/51 Heaney Plain, Poblacion, Angeles 2168 Negros Occidental', 'Warehouse Two', '2022-09-20', 'CONTINENTAL 80 SHOES', 25, 5300, 132500),
('SO-0003', 'Turcotte-Littel LLC', '881-559-659', 'krenner@gmail.com', '32/58 Carter View Apt. 357, Lal-lo 4325 Samar', 'Warehouse One', '2022-09-20', 'ULTRA 4DFWD SHOES', 15, 14000, 210000);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `usr_id` int(11) NOT NULL,
  `usr_name` varchar(50) NOT NULL,
  `usr_phone` int(11) NOT NULL,
  `usr_email` varchar(320) NOT NULL,
  `usr_password` varchar(128) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `vendors`
--

CREATE TABLE `vendors` (
  `ven_id` int(11) NOT NULL,
  `ven_name` varchar(50) NOT NULL,
  `ven_phone` varchar(11) NOT NULL,
  `ven_email` varchar(320) NOT NULL,
  `ven_website` varchar(320) NOT NULL,
  `ven_address` varchar(256) NOT NULL,
  `ven_billcon` varchar(256) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `vendors`
--

INSERT INTO `vendors` (`ven_id`, `ven_name`, `ven_phone`, `ven_email`, `ven_website`, `ven_address`, `ven_billcon`) VALUES
(1, 'West, Rempel and Bode Ltd', '856-887-758', 'cordie29@mueller.info', 'prosacco.net', '30 Sporer Mission Suite 567, Poblacion, Iriga 4875 Basilan', 'Cordie Rempel'),
(2, 'Bailey, Welch and Goodwin Inc', '052-752-472', 'isaccarroll@waters.biz', 'predovic.net', '24/13 Torp Creek, Poblacion, Santa Rosa 7758 Siquijor', 'Isac Carroll'),
(3, 'Bergnaum-Schultz PLC', '129-325-902', 'cstreich@daniel.info', 'kerluke.info', '95/90 McCullough River, Poblacion, Calapan 6900 Ilocos Norte', 'Clint Streich'),
(4, 'Franecki Inc LLC', '522-302-719', 'jackie14@schneider.org', 'osinski.com', '53A/78 Blick Springs, Poblacion, Bago 2652 Iloilo', 'Jackie Ebert');

-- --------------------------------------------------------

--
-- Table structure for table `ven_products`
--

CREATE TABLE `ven_products` (
  `ven_product` varchar(50) NOT NULL,
  `sku` varchar(15) NOT NULL,
  `ven_code` varchar(15) NOT NULL,
  `ven_price` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`adm_id`),
  ADD UNIQUE KEY `adm_username` (`adm_username`);

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`cus_id`),
  ADD UNIQUE KEY `cus_email` (`cus_email`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`pro_id`),
  ADD UNIQUE KEY `sku` (`sku`);

--
-- Indexes for table `purchase_orders`
--
ALTER TABLE `purchase_orders`
  ADD PRIMARY KEY (`po_ordnum`);

--
-- Indexes for table `sales_orders`
--
ALTER TABLE `sales_orders`
  ADD PRIMARY KEY (`so_ordnum`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`usr_id`),
  ADD UNIQUE KEY `usr_email` (`usr_email`);

--
-- Indexes for table `vendors`
--
ALTER TABLE `vendors`
  ADD PRIMARY KEY (`ven_id`),
  ADD UNIQUE KEY `ven_email` (`ven_email`);

--
-- Indexes for table `ven_products`
--
ALTER TABLE `ven_products`
  ADD PRIMARY KEY (`sku`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `adm_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `cus_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `pro_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `usr_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `vendors`
--
ALTER TABLE `vendors`
  MODIFY `ven_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
