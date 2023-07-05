-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 05, 2023 at 06:42 PM
-- Server version: 10.4.25-MariaDB
-- PHP Version: 8.0.23

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `golfshopmanagementsystem`
--

-- --------------------------------------------------------

--
-- Table structure for table `cart`
--

CREATE TABLE `cart` (
  `cartID` int(11) NOT NULL,
  `userID` int(11) NOT NULL,
  `totalPrice` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `cart`
--

INSERT INTO `cart` (`cartID`, `userID`, `totalPrice`) VALUES
(8, 1, 134),
(9, 1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `cartitem`
--

CREATE TABLE `cartitem` (
  `CartItemID` int(11) NOT NULL,
  `cartID` int(11) NOT NULL,
  `itemID` int(11) NOT NULL,
  `quantity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `custid` int(11) NOT NULL,
  `firstname` varchar(100) NOT NULL,
  `lastname` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phoneno` varchar(100) NOT NULL,
  `address` varchar(100) NOT NULL,
  `pass1` varchar(50) NOT NULL,
  `pass2` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`custid`, `firstname`, `lastname`, `email`, `phoneno`, `address`, `pass1`, `pass2`) VALUES
(1, 'syafiah', 'aina', 'syafiah@gmail.com', '0198765499', '16789 kubang badak kuala terengganu', '345', '345'),
(2, 'elly', 'rosli', 'elly@gmail.com', '0123456788', 'jalan delima kg serasa', '234', '234'),
(3, 'nur', 'elisya', 'elisya@gmail.com', '0125768433', 'taman kosas 68000 ampang', '000', '000'),
(4, 'nur', 'atirah', 'atirah@gmail.com', '0134567899', 'Taman Likas Jalan ria 68900 Ganu', '777', '777'),
(5, 'fatimah', 'hasimah', 'fatimah@gmail.com', '0176543900', 'Taman Likas Jalan ria 68900 Ganu', '987', '987'),
(6, 'aira', 'masitah', 'masitah@gmail.com', '0111112344', 'kuala lumpur', '555', '555');

-- --------------------------------------------------------

--
-- Table structure for table `item`
--

CREATE TABLE `item` (
  `itemID` int(11) NOT NULL,
  `itemName` varchar(50) NOT NULL,
  `itemDesc` varchar(255) NOT NULL,
  `itemQuantity` int(10) NOT NULL,
  `itemPrice` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `item`
--

INSERT INTO `item` (`itemID`, `itemName`, `itemDesc`, `itemQuantity`, `itemPrice`) VALUES
(1, 'Shirt', 'Adidas Tr Polo Shirt', 10, '134.00'),
(2, 'Caddie Bag ', 'Ping Pioneer Cart Bag', 12, '1300.00'),
(3, 'stand bag', 'to put all the golf stick', 10, '1000.00'),
(4, 'Golf Stick', 'Golf Stick brand new', 20, '1500.00'),
(6, 'Golf Stick', 'Golf Stick brand new', 20, '1500.00');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `orderID` int(11) NOT NULL,
  `itemID` int(11) NOT NULL,
  `custID` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `totalPrice` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`orderID`, `itemID`, `custID`, `quantity`, `totalPrice`) VALUES
(68, 1, 1, 2, '134.00'),
(69, 2, 1, 3, '1300.00');

-- --------------------------------------------------------

--
-- Table structure for table `owner`
--

CREATE TABLE `owner` (
  `ownerid` varchar(100) NOT NULL,
  `ownername` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phoneno` varchar(100) NOT NULL,
  `pass1` varchar(100) NOT NULL,
  `pass2` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `owner`
--

INSERT INTO `owner` (`ownerid`, `ownername`, `email`, `phoneno`, `pass1`, `pass2`) VALUES
('PSGMS01', 'Najmi', 'najmipsgms@gmail.com', '0187654388', '123', '123'),
('PSGMS02', 'Irfan', 'irfanpsgms@gmail.com', '0198765488', '345', '345'),
('PSGMS03', 'sarah', 'sarahpsgms@gmail.com', '0103458799', '000', '000'),
('PSGMS05', 'wani', 'wanipsgms@gmail.com', '0187659866', '888', '888'),
('PSGMS06', 'aira', 'airapsgms@gmail.com', '0117865466', '444', '444');

-- --------------------------------------------------------

--
-- Table structure for table `promotion`
--

CREATE TABLE `promotion` (
  `promoID` varchar(10) NOT NULL,
  `promovalue` varchar(10) NOT NULL,
  `startDate` date NOT NULL,
  `endDate` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `promotion`
--

INSERT INTO `promotion` (`promoID`, `promovalue`, `startDate`, `endDate`) VALUES
('promo2', '90%', '2022-02-02', '2020-02-02'),
('Promo3', '80%', '2023-05-05', '2023-10-05');

-- --------------------------------------------------------

--
-- Table structure for table `service`
--

CREATE TABLE `service` (
  `serviceid` varchar(100) NOT NULL,
  `servicename` varchar(255) NOT NULL,
  `serviceprice` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `service`
--

INSERT INTO `service` (`serviceid`, `servicename`, `serviceprice`) VALUES
('Serv1', 'Balancing', '50.00'),
('Serv2', 'Add Weight', '200.00'),
('Serv3', 'Allignment', '1000.00'),
('Serv4', 'Change Shaft', '100.00'),
('Serv6', 'Add Weight', '50.00'),
('Serv9', 'Tukar tongkat', '80.00');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cart`
--
ALTER TABLE `cart`
  ADD PRIMARY KEY (`cartID`),
  ADD KEY `userID` (`userID`);

--
-- Indexes for table `cartitem`
--
ALTER TABLE `cartitem`
  ADD PRIMARY KEY (`CartItemID`),
  ADD KEY `cartID` (`cartID`),
  ADD KEY `itemID` (`itemID`);

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`custid`);

--
-- Indexes for table `item`
--
ALTER TABLE `item`
  ADD PRIMARY KEY (`itemID`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`orderID`),
  ADD KEY `itemID` (`itemID`),
  ADD KEY `custID` (`custID`);

--
-- Indexes for table `owner`
--
ALTER TABLE `owner`
  ADD PRIMARY KEY (`ownerid`);

--
-- Indexes for table `service`
--
ALTER TABLE `service`
  ADD PRIMARY KEY (`serviceid`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `cart`
--
ALTER TABLE `cart`
  MODIFY `cartID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `cartitem`
--
ALTER TABLE `cartitem`
  MODIFY `CartItemID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `customer`
--
ALTER TABLE `customer`
  MODIFY `custid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `item`
--
ALTER TABLE `item`
  MODIFY `itemID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `orderID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=73;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `cart`
--
ALTER TABLE `cart`
  ADD CONSTRAINT `cart_ibfk_1` FOREIGN KEY (`userID`) REFERENCES `customer` (`custid`);

--
-- Constraints for table `cartitem`
--
ALTER TABLE `cartitem`
  ADD CONSTRAINT `cartitem_ibfk_1` FOREIGN KEY (`cartID`) REFERENCES `cart` (`cartID`),
  ADD CONSTRAINT `cartitem_ibfk_2` FOREIGN KEY (`itemID`) REFERENCES `item` (`itemID`);

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`itemID`) REFERENCES `item` (`itemID`),
  ADD CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`custID`) REFERENCES `customer` (`custid`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
