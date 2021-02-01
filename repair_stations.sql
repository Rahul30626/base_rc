-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3307
-- Generation Time: Jan 27, 2021 at 11:52 AM
-- Server version: 10.4.17-MariaDB
-- PHP Version: 7.3.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `repair_stations`
--

-- --------------------------------------------------------

--
-- Table structure for table `accessories`
--

CREATE TABLE `accessories` (
  `parts_id` int(200) NOT NULL,
  `parts_name` varchar(100) NOT NULL,
  `price` int(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `booking_parts`
--

CREATE TABLE `booking_parts` (
  `user_id` int(11) NOT NULL,
  `part_id` int(200) NOT NULL,
  `num_of_parts` int(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `repair_station_details`
--

CREATE TABLE `repair_station_details` (
  `station_id` int(100) NOT NULL,
  `station_name` varchar(55) NOT NULL,
  `latitude` varchar(200) NOT NULL,
  `longitude` varchar(200) NOT NULL,
  `area_name` varchar(200) NOT NULL,
  `pincode` bigint(20) NOT NULL,
  `city_name` varchar(55) NOT NULL,
  `parts_id` int(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `time_scheduling`
--

CREATE TABLE `time_scheduling` (
  `station_id` int(100) NOT NULL,
  `user_id` int(11) NOT NULL,
  `vehicle_user_name` varchar(100) NOT NULL,
  `date` date NOT NULL,
  `time` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `vehicle_details`
--

CREATE TABLE `vehicle_details` (
  `user_id` int(11) NOT NULL,
  `vehicle_id` int(255) NOT NULL,
  `vehicle_name` varchar(20) NOT NULL,
  `vehicle_user_name` varchar(100) NOT NULL,
  `vehicle_reg_num` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `accessories`
--
ALTER TABLE `accessories`
  ADD PRIMARY KEY (`parts_id`);

--
-- Indexes for table `booking_parts`
--
ALTER TABLE `booking_parts`
  ADD PRIMARY KEY (`user_id`,`part_id`),
  ADD KEY `part_id` (`part_id`);

--
-- Indexes for table `repair_station_details`
--
ALTER TABLE `repair_station_details`
  ADD PRIMARY KEY (`station_id`,`parts_id`),
  ADD KEY `parts_id` (`parts_id`);

--
-- Indexes for table `time_scheduling`
--
ALTER TABLE `time_scheduling`
  ADD PRIMARY KEY (`station_id`,`user_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `vehicle_details`
--
ALTER TABLE `vehicle_details`
  ADD PRIMARY KEY (`user_id`,`vehicle_id`),
  ADD UNIQUE KEY `vehicle_reg_num` (`vehicle_reg_num`),
  ADD UNIQUE KEY `user_id` (`user_id`);
ALTER TABLE `vehicle_details` ADD FULLTEXT KEY `vehicle_user_name` (`vehicle_user_name`);
ALTER TABLE `vehicle_details` ADD FULLTEXT KEY `vehicle_name` (`vehicle_name`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `booking_parts`
--
ALTER TABLE `booking_parts`
  ADD CONSTRAINT `booking_parts_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `vehicle_details` (`user_id`),
  ADD CONSTRAINT `booking_parts_ibfk_2` FOREIGN KEY (`part_id`) REFERENCES `accessories` (`parts_id`);

--
-- Constraints for table `repair_station_details`
--
ALTER TABLE `repair_station_details`
  ADD CONSTRAINT `repair_station_details_ibfk_1` FOREIGN KEY (`parts_id`) REFERENCES `accessories` (`parts_id`);

--
-- Constraints for table `time_scheduling`
--
ALTER TABLE `time_scheduling`
  ADD CONSTRAINT `time_scheduling_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `vehicle_details` (`user_id`),
  ADD CONSTRAINT `time_scheduling_ibfk_2` FOREIGN KEY (`station_id`) REFERENCES `repair_station_details` (`station_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
