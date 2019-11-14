-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jul 27, 2019 at 11:37 AM
-- Server version: 5.6.44
-- PHP Version: 7.2.7

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `inui_licensetest`
--

-- --------------------------------------------------------

--
-- Table structure for table `activity_log`
--


CREATE TABLE `activity_log` (
  `al_id` int(11) NOT NULL,
  `al_log` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `al_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `activity_log`
--

INSERT INTO `activity_log` (`al_id`, `al_log`, `al_date`) VALUES
(1, 'Successful login from IP <b>999.101.999.245</b>.', '2019-03-31 14:59:34'),;

-- --------------------------------------------------------

--
-- Table structure for table `api_keys`
--

CREATE TABLE `api_keys` (
  `id` int(11) NOT NULL,
  `key` varchar(40) NOT NULL,
  `controller` varchar(255) NOT NULL,
  `ignore_limits` tinyint(1) NOT NULL DEFAULT '0',
  `ip_addresses` text,
  `date_created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `api_keys`
--

INSERT INTO `api_keys` (`id`, `key`, `controller`, `ignore_limits`, `ip_addresses`, `date_created`) VALUES
(1, 'A0CE78BAC551C4764D03', '/api_external', 0, NULL, '2019-03-31 15:00:34'),
(2, 'C6B16B2A633B180CFF6E', '/api_internal', 0, NULL, '2019-03-31 15:00:40');

-- --------------------------------------------------------

--
-- Table structure for table `api_limits`
--

CREATE TABLE `api_limits` (
  `id` int(11) NOT NULL,
  `uri` varchar(255) NOT NULL,
  `count` int(10) NOT NULL,
  `hour_started` int(11) NOT NULL,
  `api_key` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `app_settings`
--

CREATE TABLE `app_settings` (
  `as_id` int(11) NOT NULL,
  `as_name` varchar(255) NOT NULL,
  `as_value` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `app_settings`
--

INSERT INTO `app_settings` (`as_id`, `as_name`, `as_value`) VALUES
(1, 'license_code_format', '{[Z]}{[Z]}{[Z]}{[Z]}-{[Z]}{[Z]}{[Z]}{[Z]}-{[Z]}{[Z]}{[Z]}{[Z]}-{[Z]}{[Z]}{[Z]}{[Z]}'),
(2, 'envato_username', ''),
(3, 'envato_api_token', ''),
(4, 'server_email', 'no-reply@example.com'),
(5, 'blacklisted_ips', NULL),
(6, 'blacklisted_domains', NULL),
(7, 'api_rate_limit', NULL),
(8, 'license_expiring', '<p>Hello,&nbsp;</p><p>Your <strong>{[product]}</strong> license is expiring today, please renew your license if you wish to continue using {[product]}.</p><p><i>Company</i></p>'),
(9, 'support_expiring', '<p>Hello,&nbsp;</p><p>Your <strong>{[product]}</strong> support period is ending today, please extend your support period to continue receiving a better prioritized support.&nbsp;</p><p><i>Company</i></p>'),
(10, 'updates_expiring', '<p>Hello,&nbsp;</p><p>Your <strong>{[product]}</strong> update period is expiring today, please extend your update period and never miss out on our future releases.&nbsp;</p><p><i>Company</i></p>'),
(11, 'new_update', '<p>Hello,&nbsp;</p><p>We are excited to announce our new <strong>{[version]}</strong> update for <strong>{[product]}</strong>, grab the new version now and try it out yourself!&nbsp;</p><p><i>Company</i></p>'),
(12, 'license_expiring_enable', '0'),
(13, 'support_expiring_enable', '0'),
(14, 'updates_expiring_enable', '0'),
(15, 'new_update_enable', '0'),
(16, 'failed_activation_logs', '1'),
(17, 'failed_update_download_logs', '1');

-- --------------------------------------------------------

--
-- Table structure for table `auth_users`
--

CREATE TABLE `auth_users` (
  `au_id` int(11) NOT NULL,
  `au_uid` varchar(15) NOT NULL,
  `au_username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `au_password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `au_email` varchar(255) NOT NULL,
  `au_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `au_date_created` date NOT NULL,
  `au_reset_key` varchar(255) DEFAULT NULL,
  `au_reset_exp` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `auth_users`
--

INSERT INTO `auth_users` (`au_id`, `au_uid`, `au_username`, `au_password`, `au_email`, `au_name`, `au_date_created`, `au_reset_key`, `au_reset_exp`) VALUES
(1, 'lbgstyu7g12', 'admin', '$2y$10$OfDs9eGltW9E7L0uRLBnfOkrtPnaUe7WyMbbyZtAZ8aYEacjxGTXy', 'admin@admin.com', 'Administrator', '2019-02-13', '$2y$10$YhAg6pMz67Mg0z2xZt60bexJJjFoP20zYgRcGyzJDIut/6pyJbxrm', '2019-06-24 15:20:29');

-- --------------------------------------------------------

--
-- Table structure for table `cron_mails`
--

CREATE TABLE `cron_mails` (
  `id` int(11) NOT NULL,
  `license` varchar(255) NOT NULL,
  `client_email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `mail_type` varchar(255) NOT NULL,
  `date_sent` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `version` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `product_details`
--

CREATE TABLE `product_details` (
  `pd_id` int(11) NOT NULL,
  `pd_pid` varchar(30) NOT NULL,
  `envato_id` varchar(100) DEFAULT NULL,
  `pd_name` tinytext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `pd_details` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci,
  `license_update` tinyint(1) NOT NULL,
  `pd_status` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `product_installations`
--

CREATE TABLE `product_installations` (
  `pi_id` int(11) NOT NULL,
  `pi_product` varchar(30) NOT NULL,
  `pi_iid` varchar(50) NOT NULL,
  `pi_username` tinytext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `pi_purchase_code` varchar(150) NOT NULL,
  `pi_url` tinytext NOT NULL,
  `pi_ip` tinytext NOT NULL,
  `pi_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `pi_agent` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci,
  `pi_isvalid` tinyint(1) NOT NULL,
  `pi_isactive` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `product_licenses`
--

CREATE TABLE `product_licenses` (
  `id` int(11) NOT NULL,
  `pid` varchar(50) NOT NULL,
  `license_code` varchar(225) NOT NULL,
  `license_type` varchar(255) DEFAULT NULL,
  `invoice` varchar(255) DEFAULT NULL,
  `is_envato` tinyint(4) DEFAULT NULL,
  `added_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `client` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `comments` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci,
  `ips` text,
  `domains` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci,
  `supported_till` datetime DEFAULT NULL,
  `updates_till` datetime DEFAULT NULL,
  `expiry` datetime DEFAULT NULL,
  `uses` int(11) DEFAULT NULL,
  `uses_left` int(11) DEFAULT NULL,
  `parallel_uses` int(11) DEFAULT NULL,
  `parallel_uses_left` int(11) DEFAULT NULL,
  `validity` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `product_versions`
--

CREATE TABLE `product_versions` (
  `id` int(11) NOT NULL,
  `vid` varchar(100) NOT NULL,
  `pid` varchar(30) NOT NULL,
  `version` varchar(100) NOT NULL,
  `release_date` date NOT NULL,
  `changelog` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `main_file` varchar(255) NOT NULL,
  `sql_file` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `update_downloads`
--

CREATE TABLE `update_downloads` (
  `id` int(11) NOT NULL,
  `did` varchar(100) NOT NULL,
  `product` varchar(30) NOT NULL,
  `vid` varchar(100) NOT NULL,
  `url` tinytext NOT NULL,
  `ip` tinytext NOT NULL,
  `download_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `isvalid` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `activity_log`
--
ALTER TABLE `activity_log`
  ADD PRIMARY KEY (`al_id`);

--
-- Indexes for table `api_keys`
--
ALTER TABLE `api_keys`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `key` (`key`);

--
-- Indexes for table `api_limits`
--
ALTER TABLE `api_limits`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `app_settings`
--
ALTER TABLE `app_settings`
  ADD PRIMARY KEY (`as_id`);

--
-- Indexes for table `auth_users`
--
ALTER TABLE `auth_users`
  ADD PRIMARY KEY (`au_id`),
  ADD UNIQUE KEY `username` (`au_username`),
  ADD UNIQUE KEY `au_email` (`au_email`),
  ADD UNIQUE KEY `au_uid` (`au_uid`);

--
-- Indexes for table `cron_mails`
--
ALTER TABLE `cron_mails`
  ADD PRIMARY KEY (`id`),
  ADD KEY `license` (`license`);

--
-- Indexes for table `product_details`
--
ALTER TABLE `product_details`
  ADD PRIMARY KEY (`pd_id`),
  ADD UNIQUE KEY `pd_pid` (`pd_pid`);

--
-- Indexes for table `product_installations`
--
ALTER TABLE `product_installations`
  ADD PRIMARY KEY (`pi_id`),
  ADD UNIQUE KEY `pi_iid` (`pi_iid`),
  ADD KEY `pi_id` (`pi_id`),
  ADD KEY `pi_product` (`pi_product`),
  ADD KEY `product_installations_ibfkd_1` (`pi_purchase_code`);

--
-- Indexes for table `product_licenses`
--
ALTER TABLE `product_licenses`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `license_code` (`license_code`),
  ADD KEY `pid` (`pid`);

--
-- Indexes for table `product_versions`
--
ALTER TABLE `product_versions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `vid` (`vid`),
  ADD KEY `pid` (`pid`);

--
-- Indexes for table `update_downloads`
--
ALTER TABLE `update_downloads`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product` (`product`),
  ADD KEY `did` (`did`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `activity_log`
--
ALTER TABLE `activity_log`
  MODIFY `al_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `api_keys`
--
ALTER TABLE `api_keys`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `api_limits`
--
ALTER TABLE `api_limits`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `app_settings`
--
ALTER TABLE `app_settings`
  MODIFY `as_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `auth_users`
--
ALTER TABLE `auth_users`
  MODIFY `au_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `cron_mails`
--
ALTER TABLE `cron_mails`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `product_details`
--
ALTER TABLE `product_details`
  MODIFY `pd_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `product_installations`
--
ALTER TABLE `product_installations`
  MODIFY `pi_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `product_licenses`
--
ALTER TABLE `product_licenses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `product_versions`
--
ALTER TABLE `product_versions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `update_downloads`
--
ALTER TABLE `update_downloads`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
