-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 21, 2025 at 03:31 PM
-- Server version: 8.0.44
-- PHP Version: 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `shop_management`
--

-- --------------------------------------------------------

--
-- Table structure for table `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `order` int NOT NULL DEFAULT '0',
  `description` text COLLATE utf8mb4_unicode_ci,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_by` bigint UNSIGNED DEFAULT NULL,
  `updated_by` bigint UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`, `slug`, `order`, `description`, `image`, `is_active`, `created_by`, `updated_by`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Grocery', 'grocery', 1, 'Food items and daily essentials', NULL, 1, 1, 1, '2025-12-21 14:30:44', '2025-12-21 14:30:44', NULL),
(2, 'Cosmetics', 'cosmetics', 2, 'Beauty and personal care products', NULL, 1, 1, 1, '2025-12-21 14:30:44', '2025-12-21 14:30:44', NULL),
(3, 'Electronics', 'electronics', 3, 'Electronic devices and gadgets', NULL, 1, 1, 1, '2025-12-21 14:30:44', '2025-12-21 14:30:44', NULL),
(4, 'Clothing', 'clothing', 4, 'Apparel and fashion items', NULL, 1, 1, 1, '2025-12-21 14:30:44', '2025-12-21 14:30:44', NULL),
(5, 'Home & Kitchen', 'home-kitchen', 5, 'Household and kitchen essentials', NULL, 1, 1, 1, '2025-12-21 14:30:44', '2025-12-21 14:30:44', NULL),
(6, 'Sports & Outdoors', 'sports-outdoors', 6, 'Sports equipment and outdoor gear', NULL, 1, 1, 1, '2025-12-21 14:30:44', '2025-12-21 14:30:44', NULL),
(7, 'Books & Stationery', 'books-stationery', 7, 'Books, notebooks, and office supplies', NULL, 1, 1, 1, '2025-12-21 14:30:44', '2025-12-21 14:30:44', NULL),
(8, 'Toys & Games', 'toys-games', 8, 'Children toys and board games', NULL, 1, 1, 1, '2025-12-21 14:30:44', '2025-12-21 14:30:44', NULL),
(9, 'Health & Wellness', 'health-wellness', 9, 'Health supplements and wellness products', NULL, 1, 1, 1, '2025-12-21 14:30:44', '2025-12-21 14:30:44', NULL),
(10, 'Automotive', 'automotive', 10, 'Car accessories and automotive parts', NULL, 1, 1, 1, '2025-12-21 14:30:44', '2025-12-21 14:30:44', NULL),
(11, 'Pet Supplies', 'pet-supplies', 11, 'Pet food and accessories', NULL, 1, 1, 1, '2025-12-21 14:30:44', '2025-12-21 14:30:44', NULL),
(12, 'Baby Products', 'baby-products', 12, 'Baby care and essentials', NULL, 1, 1, 1, '2025-12-21 14:30:44', '2025-12-21 14:30:44', NULL),
(13, 'Furniture', 'furniture', 13, 'Home and office furniture', NULL, 1, 1, 1, '2025-12-21 14:30:44', '2025-12-21 14:30:44', NULL),
(14, 'Jewelry & Accessories', 'jewelry-accessories', 14, 'Jewelry and fashion accessories', NULL, 1, 1, 1, '2025-12-21 14:30:44', '2025-12-21 14:30:44', NULL),
(15, 'Garden & Tools', 'garden-tools', 15, 'Gardening supplies and tools', NULL, 1, 1, 1, '2025-12-21 14:30:44', '2025-12-21 14:30:44', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `company_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mobile` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` text COLLATE utf8mb4_unicode_ci,
  `city` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `state` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `postal_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tax_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `opening_balance` decimal(15,2) NOT NULL DEFAULT '0.00',
  `current_balance` decimal(15,2) NOT NULL DEFAULT '0.00',
  `notes` text COLLATE utf8mb4_unicode_ci,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_by` bigint UNSIGNED DEFAULT NULL,
  `updated_by` bigint UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`id`, `name`, `code`, `company_name`, `email`, `phone`, `mobile`, `address`, `city`, `state`, `country`, `postal_code`, `tax_id`, `opening_balance`, `current_balance`, `notes`, `is_active`, `created_by`, `updated_by`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Walk-in Customer', 'CUS-001', NULL, NULL, '01800000001', '01800000001', 'N/A', NULL, NULL, NULL, NULL, NULL, '0.00', '-244597.17', 'Default walk-in customer', 1, 1, NULL, '2025-12-21 14:30:44', '2025-12-21 14:30:47', NULL),
(2, 'Ahmed Rahman', 'CUS-002', 'Rahman Enterprises', 'ahmed.rahman@email.com', '01800000002', '01800000002', '12 Residential Area, Dhanmondi', 'Dhaka', 'Dhaka', 'Bangladesh', '1205', NULL, '0.00', '-278795.70', 'Regular customer with credit account', 1, 1, NULL, '2025-12-21 14:30:44', '2025-12-21 14:30:47', NULL),
(3, 'Fatima Begum', 'CUS-003', 'Fatima Retail Store', 'fatima@retailstore.com', '01800000003', '01800000003', '45 Shop Road, Uttara', 'Dhaka', 'Dhaka', 'Bangladesh', '1230', 'CUS-TAX-003', '0.00', '-372976.96', 'Retail store owner, regular bulk orders', 1, 1, NULL, '2025-12-21 14:30:44', '2025-12-21 14:30:47', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `queue` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint UNSIGNED NOT NULL,
  `reserved_at` int UNSIGNED DEFAULT NULL,
  `available_at` int UNSIGNED NOT NULL,
  `created_at` int UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_jobs` int NOT NULL,
  `pending_jobs` int NOT NULL,
  `failed_jobs` int NOT NULL,
  `failed_job_ids` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` mediumtext COLLATE utf8mb4_unicode_ci,
  `cancelled_at` int DEFAULT NULL,
  `created_at` int NOT NULL,
  `finished_at` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `login_logs`
--

CREATE TABLE `login_logs` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `status` enum('success','failed') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'failed',
  `failure_reason` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `logged_in_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `login_logs`
--

INSERT INTO `login_logs` (`id`, `user_id`, `email`, `ip_address`, `user_agent`, `status`, `failure_reason`, `logged_in_at`, `created_at`, `updated_at`) VALUES
(1, 1, 'admin@mail.com', '192.168.1.101', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:121.0) Gecko/20100101 Firefox/121.0', 'success', NULL, '2025-11-06 17:42:47', '2025-11-06 17:42:47', '2025-11-06 17:42:47'),
(2, 1, 'admin@mail.com', '10.0.0.50', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36', 'success', NULL, '2025-11-08 06:59:47', '2025-11-08 06:59:47', '2025-11-08 06:59:47'),
(3, 1, 'admin@mail.com', '192.168.1.100', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36', 'success', NULL, '2025-09-30 04:03:47', '2025-09-30 04:03:47', '2025-09-30 04:03:47'),
(4, 1, 'admin@mail.com', '192.168.1.100', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36', 'success', NULL, '2025-09-24 09:13:47', '2025-09-24 09:13:47', '2025-09-24 09:13:47'),
(5, 1, 'admin@mail.com', '192.168.1.101', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36', 'success', NULL, '2025-10-06 02:31:47', '2025-10-06 02:31:47', '2025-10-06 02:31:47'),
(6, 1, 'admin@mail.com', '192.168.1.100', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36', 'success', NULL, '2025-11-17 00:36:47', '2025-11-17 00:36:47', '2025-11-17 00:36:47'),
(7, NULL, 'admin@mail.com', '10.0.0.50', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36', 'failed', 'password_expired', NULL, '2025-11-12 21:06:47', '2025-11-12 21:06:47'),
(8, NULL, 'admin@mail.com', '172.16.0.25', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:121.0) Gecko/20100101 Firefox/121.0', 'failed', 'password_expired', NULL, '2025-10-13 06:22:47', '2025-10-13 06:22:47'),
(9, NULL, 'admin@mail.com', '198.51.100.12', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36', 'failed', 'password_expired', NULL, '2025-09-27 09:31:47', '2025-09-27 09:31:47'),
(10, 2, 'cashier@mail.com', '10.0.0.50', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:121.0) Gecko/20100101 Firefox/121.0', 'success', NULL, '2025-10-24 11:30:47', '2025-10-24 11:30:47', '2025-10-24 11:30:47'),
(11, 2, 'cashier@mail.com', '172.16.0.25', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36', 'success', NULL, '2025-12-15 12:20:47', '2025-12-15 12:20:47', '2025-12-15 12:20:47'),
(12, 2, 'cashier@mail.com', '198.51.100.12', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36', 'success', NULL, '2025-12-05 10:34:47', '2025-12-05 10:34:47', '2025-12-05 10:34:47'),
(13, 2, 'cashier@mail.com', '10.0.0.50', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36', 'success', NULL, '2025-11-21 21:26:47', '2025-11-21 21:26:47', '2025-11-21 21:26:47'),
(14, 2, 'cashier@mail.com', '172.16.0.25', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.1 Safari/605.1.15', 'success', NULL, '2025-11-03 00:24:47', '2025-11-03 00:24:47', '2025-11-03 00:24:47'),
(15, NULL, 'cashier@mail.com', '198.51.100.12', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.1 Safari/605.1.15', 'failed', 'account_locked', NULL, '2025-12-01 13:04:47', '2025-12-01 13:04:47'),
(16, NULL, 'cashier@mail.com', '192.168.1.101', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:121.0) Gecko/20100101 Firefox/121.0', 'failed', 'password_expired', NULL, '2025-11-20 09:04:47', '2025-11-20 09:04:47'),
(17, 3, 'store@mail.com', '203.0.113.45', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:121.0) Gecko/20100101 Firefox/121.0', 'success', NULL, '2025-10-27 22:01:47', '2025-10-27 22:01:47', '2025-10-27 22:01:47'),
(18, 3, 'store@mail.com', '10.0.0.50', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.1 Safari/605.1.15', 'success', NULL, '2025-10-02 09:39:47', '2025-10-02 09:39:47', '2025-10-02 09:39:47'),
(19, 3, 'store@mail.com', '203.0.113.45', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36', 'success', NULL, '2025-10-02 20:06:47', '2025-10-02 20:06:47', '2025-10-02 20:06:47'),
(20, 3, 'store@mail.com', '10.0.0.50', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.1 Safari/605.1.15', 'success', NULL, '2025-12-13 10:55:47', '2025-12-13 10:55:47', '2025-12-13 10:55:47'),
(21, 3, 'store@mail.com', '192.168.1.100', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36', 'success', NULL, '2025-09-26 03:00:47', '2025-09-26 03:00:47', '2025-09-26 03:00:47'),
(22, 3, 'store@mail.com', '198.51.100.12', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36', 'success', NULL, '2025-10-31 02:16:47', '2025-10-31 02:16:47', '2025-10-31 02:16:47'),
(23, 3, 'store@mail.com', '172.16.0.25', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36', 'success', NULL, '2025-11-23 23:41:47', '2025-11-23 23:41:47', '2025-11-23 23:41:47'),
(24, 3, 'store@mail.com', '192.168.1.101', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36', 'success', NULL, '2025-11-18 14:35:47', '2025-11-18 14:35:47', '2025-11-18 14:35:47'),
(25, 3, 'store@mail.com', '198.51.100.12', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36', 'success', NULL, '2025-09-25 13:15:47', '2025-09-25 13:15:47', '2025-09-25 13:15:47'),
(26, 3, 'store@mail.com', '198.51.100.12', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.1 Safari/605.1.15', 'success', NULL, '2025-10-01 12:20:47', '2025-10-01 12:20:47', '2025-10-01 12:20:47'),
(27, NULL, 'store@mail.com', '172.16.0.25', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36', 'failed', 'too_many_attempts', NULL, '2025-09-27 19:32:47', '2025-09-27 19:32:47'),
(28, NULL, 'store@mail.com', '203.0.113.45', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36', 'failed', 'too_many_attempts', NULL, '2025-10-31 14:48:47', '2025-10-31 14:48:47'),
(29, NULL, 'hacker@example.com', '10.0.0.50', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36', 'failed', 'invalid_credentials', NULL, '2025-11-02 01:20:47', '2025-11-02 01:20:47'),
(30, NULL, 'hacker@example.com', '172.16.0.25', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.1 Safari/605.1.15', 'failed', 'invalid_credentials', NULL, '2025-10-20 02:00:47', '2025-10-20 02:00:47'),
(31, NULL, 'hacker@example.com', '172.16.0.25', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36', 'failed', 'invalid_credentials', NULL, '2025-11-29 10:48:47', '2025-11-29 10:48:47'),
(32, NULL, 'hacker@example.com', '172.16.0.25', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36', 'failed', 'invalid_credentials', NULL, '2025-12-14 02:40:47', '2025-12-14 02:40:47'),
(33, NULL, 'hacker@example.com', '198.51.100.12', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.1 Safari/605.1.15', 'failed', 'invalid_credentials', NULL, '2025-12-07 00:00:47', '2025-12-07 00:00:47'),
(34, NULL, 'test@test.com', '203.0.113.45', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:121.0) Gecko/20100101 Firefox/121.0', 'failed', 'invalid_credentials', NULL, '2025-11-03 23:36:47', '2025-11-03 23:36:47'),
(35, NULL, 'test@test.com', '192.168.1.101', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:121.0) Gecko/20100101 Firefox/121.0', 'failed', 'invalid_credentials', NULL, '2025-10-04 12:32:47', '2025-10-04 12:32:47'),
(36, NULL, 'test@test.com', '172.16.0.25', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36', 'failed', 'invalid_credentials', NULL, '2025-12-18 18:24:47', '2025-12-18 18:24:47'),
(37, NULL, 'test@test.com', '192.168.1.100', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36', 'failed', 'invalid_credentials', NULL, '2025-10-01 22:34:47', '2025-10-01 22:34:47'),
(38, NULL, 'admin@admin.com', '192.168.1.101', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:121.0) Gecko/20100101 Firefox/121.0', 'failed', 'invalid_credentials', NULL, '2025-10-14 05:40:47', '2025-10-14 05:40:47'),
(39, NULL, 'admin@admin.com', '198.51.100.12', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:121.0) Gecko/20100101 Firefox/121.0', 'failed', 'invalid_credentials', NULL, '2025-11-29 00:39:47', '2025-11-29 00:39:47'),
(40, NULL, 'admin@admin.com', '198.51.100.12', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36', 'failed', 'invalid_credentials', NULL, '2025-11-20 05:19:47', '2025-11-20 05:19:47'),
(41, NULL, 'admin@admin.com', '192.168.1.100', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36', 'failed', 'invalid_credentials', NULL, '2025-11-15 07:52:47', '2025-11-15 07:52:47'),
(42, NULL, 'user@user.com', '192.168.1.100', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.1 Safari/605.1.15', 'failed', 'invalid_credentials', NULL, '2025-10-08 16:00:47', '2025-10-08 16:00:47'),
(43, NULL, 'user@user.com', '192.168.1.101', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36', 'failed', 'invalid_credentials', NULL, '2025-12-17 17:21:47', '2025-12-17 17:21:47'),
(44, NULL, 'user@user.com', '172.16.0.25', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36', 'failed', 'invalid_credentials', NULL, '2025-11-05 01:18:47', '2025-11-05 01:18:47'),
(45, NULL, 'user@user.com', '10.0.0.50', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:121.0) Gecko/20100101 Firefox/121.0', 'failed', 'invalid_credentials', NULL, '2025-12-11 03:32:47', '2025-12-11 03:32:47'),
(46, NULL, 'user@user.com', '192.168.1.100', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36', 'failed', 'invalid_credentials', NULL, '2025-11-21 11:30:47', '2025-11-21 11:30:47');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1),
(4, '2025_11_22_200555_create_settings_table', 1),
(5, '2025_11_22_201228_create_personal_access_tokens_table', 1),
(6, '2025_11_22_210651_create_permissions_table', 1),
(7, '2025_11_22_210651_create_roles_table', 1),
(8, '2025_11_22_210652_create_role_permission_table', 1),
(9, '2025_11_22_210652_create_user_role_table', 1),
(10, '2025_11_23_180622_create_login_logs_table', 1),
(11, '2025_11_27_222552_create_categories_table', 1),
(12, '2025_11_27_222555_create_units_table', 1),
(13, '2025_11_27_222557_create_warehouses_table', 1),
(14, '2025_11_27_222559_create_suppliers_table', 1),
(15, '2025_11_27_222601_create_customers_table', 1),
(16, '2025_11_27_222603_create_products_table', 1),
(17, '2025_11_27_222607_create_stocks_table', 1),
(18, '2025_11_27_222611_create_stock_ledgers_table', 1),
(19, '2025_11_27_222619_create_purchases_table', 1),
(20, '2025_11_27_222621_create_purchase_items_table', 1),
(21, '2025_11_27_222636_create_sales_table', 1),
(22, '2025_11_27_222638_create_sales_items_table', 1),
(23, '2025_12_04_000012_create_payments_table', 1),
(24, '2025_12_21_163250_create_visitor_logs_table', 1);

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE `payments` (
  `id` bigint UNSIGNED NOT NULL,
  `payment_number` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payment_type` enum('purchase','sale','expense','refund') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'purchase',
  `party_type` enum('supplier','customer') COLLATE utf8mb4_unicode_ci NOT NULL,
  `party_id` bigint UNSIGNED NOT NULL,
  `reference_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reference_id` bigint UNSIGNED DEFAULT NULL,
  `reference_number` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_date` date NOT NULL,
  `amount` decimal(15,2) NOT NULL,
  `payment_method` enum('cash','bank_transfer','cheque','card','mobile_banking','other') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'cash',
  `transaction_reference` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bank_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `account_number` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('pending','completed','failed','cancelled') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'completed',
  `notes` text COLLATE utf8mb4_unicode_ci,
  `created_by` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `payments`
--

INSERT INTO `payments` (`id`, `payment_number`, `payment_type`, `party_type`, `party_id`, `reference_type`, `reference_id`, `reference_number`, `payment_date`, `amount`, `payment_method`, `transaction_reference`, `bank_name`, `account_number`, `status`, `notes`, `created_by`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'PAY-000001', 'purchase', 'supplier', 1, 'Purchase', 2, 'PO-000002', '2025-09-21', '7271.46', 'mobile_banking', NULL, NULL, NULL, 'completed', 'Payment for purchase PO-000002', 1, '2025-12-21 14:30:47', '2025-12-21 14:30:47', NULL),
(2, 'PAY-000002', 'purchase', 'supplier', 2, 'Purchase', 4, 'PO-000004', '2025-08-21', '14169.19', 'mobile_banking', NULL, NULL, NULL, 'completed', 'Payment for purchase PO-000004', 1, '2025-12-21 14:30:47', '2025-12-21 14:30:47', NULL),
(3, 'PAY-000003', 'purchase', 'supplier', 3, 'Purchase', 11, 'PO-000011', '2025-08-19', '11994.15', 'bank_transfer', 'TXN-2557718', 'BRAC', '1534343004', 'completed', 'Payment for purchase PO-000011', 1, '2025-12-21 14:30:47', '2025-12-21 14:30:47', NULL),
(4, 'PAY-000004', 'purchase', 'supplier', 1, 'Purchase', 12, 'PO-000012', '2025-09-18', '1763.04', 'cash', NULL, NULL, NULL, 'completed', 'Payment for purchase PO-000012', 1, '2025-12-21 14:30:47', '2025-12-21 14:30:47', NULL),
(5, 'PAY-000005', 'purchase', 'supplier', 1, 'Purchase', 13, 'PO-000013', '2025-12-02', '8573.05', 'cash', NULL, NULL, NULL, 'completed', 'Payment for purchase PO-000013', 1, '2025-12-21 14:30:47', '2025-12-21 14:30:47', NULL),
(6, 'PAY-000006', 'purchase', 'supplier', 1, 'Purchase', 18, 'PO-000018', '2025-11-05', '11046.90', 'bank_transfer', 'TXN-6293045', 'DBBL', '6022826147', 'completed', 'Payment for purchase PO-000018', 1, '2025-12-21 14:30:47', '2025-12-21 14:30:47', NULL),
(7, 'PAY-000007', 'purchase', 'supplier', 1, 'Purchase', 20, 'PO-000020', '2025-07-19', '11739.34', 'mobile_banking', NULL, NULL, NULL, 'completed', 'Payment for purchase PO-000020', 1, '2025-12-21 14:30:47', '2025-12-21 14:30:47', NULL),
(8, 'PAY-000008', 'purchase', 'supplier', 2, 'Purchase', 22, 'PO-000022', '2025-11-22', '15371.00', 'bank_transfer', 'TXN-6523096', 'City Bank', '3335701241', 'completed', 'Payment for purchase PO-000022', 1, '2025-12-21 14:30:47', '2025-12-21 14:30:47', NULL),
(9, 'PAY-000009', 'purchase', 'supplier', 1, 'Purchase', 23, 'PO-000023', '2025-12-14', '1768.93', 'cheque', 'CHQ-307667', 'City Bank', '3766264584', 'completed', 'Payment for purchase PO-000023', 1, '2025-12-21 14:30:47', '2025-12-21 14:30:47', NULL),
(10, 'PAY-000010', 'purchase', 'supplier', 1, 'Purchase', 24, 'PO-000024', '2025-10-04', '7383.69', 'cash', NULL, NULL, NULL, 'completed', 'Payment for purchase PO-000024', 1, '2025-12-21 14:30:47', '2025-12-21 14:30:47', NULL),
(11, 'PAY-000011', 'purchase', 'supplier', 3, 'Purchase', 25, 'PO-000025', '2025-08-28', '664.61', 'cheque', 'CHQ-525728', 'City Bank', '9275085165', 'completed', 'Payment for purchase PO-000025', 1, '2025-12-21 14:30:47', '2025-12-21 14:30:47', NULL),
(12, 'PAY-000012', 'purchase', 'supplier', 2, 'Purchase', 31, 'PO-000031', '2025-10-22', '14567.80', 'bank_transfer', 'TXN-7544992', 'BRAC', '5051821348', 'completed', 'Payment for purchase PO-000031', 1, '2025-12-21 14:30:47', '2025-12-21 14:30:47', NULL),
(13, 'PAY-000013', 'purchase', 'supplier', 1, 'Purchase', 33, 'PO-000033', '2025-09-10', '643.10', 'card', NULL, NULL, NULL, 'completed', 'Payment for purchase PO-000033', 1, '2025-12-21 14:30:47', '2025-12-21 14:30:47', NULL),
(14, 'PAY-000014', 'purchase', 'supplier', 1, 'Purchase', 34, 'PO-000034', '2025-08-12', '377.48', 'card', NULL, NULL, NULL, 'completed', 'Payment for purchase PO-000034', 1, '2025-12-21 14:30:47', '2025-12-21 14:30:47', NULL),
(15, 'PAY-000015', 'purchase', 'supplier', 3, 'Purchase', 35, 'PO-000035', '2025-10-27', '463.00', 'bank_transfer', 'TXN-9355542', 'BRAC', '5268752614', 'completed', 'Payment for purchase PO-000035', 1, '2025-12-21 14:30:47', '2025-12-21 14:30:47', NULL),
(16, 'PAY-000016', 'purchase', 'supplier', 3, 'Purchase', 37, 'PO-000037', '2025-08-27', '1331.49', 'card', NULL, NULL, NULL, 'completed', 'Payment for purchase PO-000037', 1, '2025-12-21 14:30:47', '2025-12-21 14:30:47', NULL),
(17, 'PAY-000017', 'purchase', 'supplier', 3, 'Purchase', 38, 'PO-000038', '2025-06-10', '3367.36', 'cash', NULL, NULL, NULL, 'completed', 'Payment for purchase PO-000038', 1, '2025-12-21 14:30:47', '2025-12-21 14:30:47', NULL),
(18, 'PAY-000018', 'purchase', 'supplier', 2, 'Purchase', 43, 'PO-000043', '2025-12-12', '2686.32', 'mobile_banking', NULL, NULL, NULL, 'completed', 'Payment for purchase PO-000043', 1, '2025-12-21 14:30:47', '2025-12-21 14:30:47', NULL),
(19, 'PAY-000019', 'purchase', 'supplier', 1, 'Purchase', 45, 'PO-000045', '2025-09-20', '12312.46', 'cheque', 'CHQ-394751', 'Eastern Bank', '8213003387', 'completed', 'Payment for purchase PO-000045', 1, '2025-12-21 14:30:47', '2025-12-21 14:30:47', NULL),
(20, 'PAY-000020', 'purchase', 'supplier', 3, 'Purchase', 48, 'PO-000048', '2025-06-30', '1097.76', 'mobile_banking', NULL, NULL, NULL, 'completed', 'Payment for purchase PO-000048', 1, '2025-12-21 14:30:47', '2025-12-21 14:30:47', NULL),
(21, 'PAY-000021', 'purchase', 'supplier', 3, 'Purchase', 49, 'PO-000049', '2025-08-16', '4143.22', 'cheque', 'CHQ-445575', 'DBBL', '2731168290', 'completed', 'Payment for purchase PO-000049', 1, '2025-12-21 14:30:47', '2025-12-21 14:30:47', NULL),
(22, 'PAY-000022', 'purchase', 'supplier', 2, 'Purchase', 50, 'PO-000050', '2025-12-11', '2931.81', 'mobile_banking', NULL, NULL, NULL, 'completed', 'Payment for purchase PO-000050', 1, '2025-12-21 14:30:47', '2025-12-21 14:30:47', NULL),
(23, 'PAY-000023', 'sale', 'customer', 3, 'Sale', 2, 'INV-000002', '2025-11-16', '38935.88', 'mobile_banking', NULL, NULL, NULL, 'completed', 'Payment for sale INV-000002', 1, '2025-12-21 14:30:47', '2025-12-21 14:30:47', NULL),
(24, 'PAY-000024', 'sale', 'customer', 2, 'Sale', 6, 'INV-000006', '2025-12-21', '12255.13', 'bank_transfer', 'TXN-3636273', 'City Bank', '7069057332', 'completed', 'Payment for sale INV-000006', 1, '2025-12-21 14:30:47', '2025-12-21 14:30:47', NULL),
(25, 'PAY-000025', 'sale', 'customer', 2, 'Sale', 9, 'INV-000009', '2025-11-12', '5957.55', 'cheque', 'CHQ-216418', 'Eastern Bank', '6182070696', 'completed', 'Payment for sale INV-000009', 1, '2025-12-21 14:30:47', '2025-12-21 14:30:47', NULL),
(26, 'PAY-000026', 'sale', 'customer', 2, 'Sale', 12, 'INV-000012', '2025-08-14', '1311.33', 'mobile_banking', NULL, NULL, NULL, 'completed', 'Payment for sale INV-000012', 1, '2025-12-21 14:30:47', '2025-12-21 14:30:47', NULL),
(27, 'PAY-000027', 'sale', 'customer', 3, 'Sale', 13, 'INV-000013', '2025-09-07', '25948.33', 'cash', NULL, NULL, NULL, 'completed', 'Payment for sale INV-000013', 1, '2025-12-21 14:30:47', '2025-12-21 14:30:47', NULL),
(28, 'PAY-000028', 'sale', 'customer', 3, 'Sale', 17, 'INV-000017', '2025-08-26', '28653.00', 'bank_transfer', 'TXN-6051134', 'City Bank', '3446572451', 'completed', 'Payment for sale INV-000017', 1, '2025-12-21 14:30:47', '2025-12-21 14:30:47', NULL),
(29, 'PAY-000029', 'sale', 'customer', 1, 'Sale', 18, 'INV-000018', '2025-09-24', '2174.19', 'mobile_banking', NULL, NULL, NULL, 'completed', 'Payment for sale INV-000018', 1, '2025-12-21 14:30:47', '2025-12-21 14:30:47', NULL),
(30, 'PAY-000030', 'sale', 'customer', 1, 'Sale', 21, 'INV-000021', '2025-07-06', '9278.42', 'mobile_banking', NULL, NULL, NULL, 'completed', 'Payment for sale INV-000021', 1, '2025-12-21 14:30:47', '2025-12-21 14:30:47', NULL),
(31, 'PAY-000031', 'sale', 'customer', 1, 'Sale', 27, 'INV-000027', '2025-06-17', '8227.56', 'cash', NULL, NULL, NULL, 'completed', 'Payment for sale INV-000027', 1, '2025-12-21 14:30:47', '2025-12-21 14:30:47', NULL),
(32, 'PAY-000032', 'sale', 'customer', 3, 'Sale', 30, 'INV-000030', '2025-10-09', '56550.43', 'cheque', 'CHQ-650656', 'BRAC', '1906096095', 'completed', 'Payment for sale INV-000030', 1, '2025-12-21 14:30:47', '2025-12-21 14:30:47', NULL),
(33, 'PAY-000033', 'sale', 'customer', 3, 'Sale', 33, 'INV-000033', '2025-11-19', '9153.19', 'cheque', 'CHQ-317944', 'Eastern Bank', '8915026796', 'completed', 'Payment for sale INV-000033', 1, '2025-12-21 14:30:47', '2025-12-21 14:30:47', NULL),
(34, 'PAY-000034', 'sale', 'customer', 3, 'Sale', 37, 'INV-000037', '2025-10-14', '34381.60', 'bank_transfer', 'TXN-9088208', 'DBBL', '3640423553', 'completed', 'Payment for sale INV-000037', 1, '2025-12-21 14:30:47', '2025-12-21 14:30:47', NULL),
(35, 'PAY-000035', 'sale', 'customer', 1, 'Sale', 39, 'INV-000039', '2025-07-02', '7157.07', 'bank_transfer', 'TXN-2432912', 'City Bank', '7539318819', 'completed', 'Payment for sale INV-000039', 1, '2025-12-21 14:30:47', '2025-12-21 14:30:47', NULL),
(36, 'PAY-000036', 'sale', 'customer', 1, 'Sale', 42, 'INV-000042', '2025-11-05', '35817.49', 'card', NULL, NULL, NULL, 'completed', 'Payment for sale INV-000042', 1, '2025-12-21 14:30:47', '2025-12-21 14:30:47', NULL),
(37, 'PAY-000037', 'sale', 'customer', 1, 'Sale', 44, 'INV-000044', '2025-09-14', '11289.49', 'mobile_banking', NULL, NULL, NULL, 'completed', 'Payment for sale INV-000044', 1, '2025-12-21 14:30:47', '2025-12-21 14:30:47', NULL),
(38, 'PAY-000038', 'sale', 'customer', 1, 'Sale', 45, 'INV-000045', '2025-12-14', '6344.17', 'card', NULL, NULL, NULL, 'completed', 'Payment for sale INV-000045', 1, '2025-12-21 14:30:47', '2025-12-21 14:30:47', NULL),
(39, 'PAY-000039', 'sale', 'customer', 1, 'Sale', 47, 'INV-000047', '2025-07-06', '31824.87', 'card', NULL, NULL, NULL, 'completed', 'Payment for sale INV-000047', 1, '2025-12-21 14:30:47', '2025-12-21 14:30:47', NULL),
(40, 'PAY-000040', 'sale', 'customer', 1, 'Sale', 48, 'INV-000048', '2025-12-24', '33813.16', 'card', NULL, NULL, NULL, 'completed', 'Payment for sale INV-000048', 1, '2025-12-21 14:30:47', '2025-12-21 14:30:47', NULL),
(41, 'PAY-000041', 'sale', 'customer', 3, 'Sale', 50, 'INV-000050', '2025-11-02', '78073.02', 'card', NULL, NULL, NULL, 'completed', 'Payment for sale INV-000050', 1, '2025-12-21 14:30:47', '2025-12-21 14:30:47', NULL),
(42, 'PAY-000042', 'sale', 'customer', 2, 'Sale', 53, 'INV-000053', '2025-08-07', '45169.97', 'cheque', 'CHQ-106978', 'BRAC', '2194471671', 'completed', 'Payment for sale INV-000053', 1, '2025-12-21 14:30:47', '2025-12-21 14:30:47', NULL),
(43, 'PAY-000043', 'sale', 'customer', 2, 'Sale', 56, 'INV-000056', '2025-11-16', '93097.82', 'bank_transfer', 'TXN-8762556', 'City Bank', '3595643789', 'completed', 'Payment for sale INV-000056', 1, '2025-12-21 14:30:47', '2025-12-21 14:30:47', NULL),
(44, 'PAY-000044', 'sale', 'customer', 2, 'Sale', 57, 'INV-000057', '2025-12-03', '10889.12', 'cash', NULL, NULL, NULL, 'completed', 'Payment for sale INV-000057', 1, '2025-12-21 14:30:47', '2025-12-21 14:30:47', NULL),
(45, 'PAY-000045', 'sale', 'customer', 3, 'Sale', 58, 'INV-000058', '2025-11-23', '10242.44', 'card', NULL, NULL, NULL, 'completed', 'Payment for sale INV-000058', 1, '2025-12-21 14:30:47', '2025-12-21 14:30:47', NULL),
(46, 'PAY-000046', 'sale', 'customer', 3, 'Sale', 59, 'INV-000059', '2025-10-31', '6691.68', 'card', NULL, NULL, NULL, 'completed', 'Payment for sale INV-000059', 1, '2025-12-21 14:30:47', '2025-12-21 14:30:47', NULL),
(47, 'PAY-000047', 'sale', 'customer', 2, 'Sale', 63, 'INV-000063', '2025-10-26', '31553.44', 'bank_transfer', 'TXN-4211116', 'Eastern Bank', '5312187030', 'completed', 'Payment for sale INV-000063', 1, '2025-12-21 14:30:47', '2025-12-21 14:30:47', NULL),
(48, 'PAY-000048', 'sale', 'customer', 3, 'Sale', 67, 'INV-000067', '2025-07-13', '32577.65', 'bank_transfer', 'TXN-9213652', 'City Bank', '5930431278', 'completed', 'Payment for sale INV-000067', 1, '2025-12-21 14:30:47', '2025-12-21 14:30:47', NULL),
(49, 'PAY-000049', 'sale', 'customer', 3, 'Sale', 72, 'INV-000072', '2025-05-29', '12712.09', 'card', NULL, NULL, NULL, 'completed', 'Payment for sale INV-000072', 1, '2025-12-21 14:30:47', '2025-12-21 14:30:47', NULL),
(50, 'PAY-000050', 'sale', 'customer', 2, 'Sale', 74, 'INV-000074', '2025-10-19', '10804.25', 'bank_transfer', 'TXN-1740617', 'DBBL', '9891854957', 'completed', 'Payment for sale INV-000074', 1, '2025-12-21 14:30:47', '2025-12-21 14:30:47', NULL),
(51, 'PAY-000051', 'sale', 'customer', 1, 'Sale', 76, 'INV-000076', '2025-07-30', '84417.67', 'card', NULL, NULL, NULL, 'completed', 'Payment for sale INV-000076', 1, '2025-12-21 14:30:47', '2025-12-21 14:30:47', NULL),
(52, 'PAY-000052', 'sale', 'customer', 2, 'Sale', 79, 'INV-000079', '2025-12-01', '30191.94', 'card', NULL, NULL, NULL, 'completed', 'Payment for sale INV-000079', 1, '2025-12-21 14:30:47', '2025-12-21 14:30:47', NULL),
(53, 'PAY-000053', 'sale', 'customer', 2, 'Sale', 84, 'INV-000084', '2025-08-17', '46897.92', 'mobile_banking', NULL, NULL, NULL, 'completed', 'Payment for sale INV-000084', 1, '2025-12-21 14:30:47', '2025-12-21 14:30:47', NULL),
(54, 'PAY-000054', 'sale', 'customer', 3, 'Sale', 85, 'INV-000085', '2025-07-14', '40808.91', 'cheque', 'CHQ-846595', 'Eastern Bank', '3536222803', 'completed', 'Payment for sale INV-000085', 1, '2025-12-21 14:30:47', '2025-12-21 14:30:47', NULL),
(55, 'PAY-000055', 'sale', 'customer', 3, 'Sale', 88, 'INV-000088', '2025-08-16', '6248.74', 'cash', NULL, NULL, NULL, 'completed', 'Payment for sale INV-000088', 1, '2025-12-21 14:30:47', '2025-12-21 14:30:47', NULL),
(56, 'PAY-000056', 'sale', 'customer', 2, 'Sale', 89, 'INV-000089', '2025-10-13', '5667.23', 'cash', NULL, NULL, NULL, 'completed', 'Payment for sale INV-000089', 1, '2025-12-21 14:30:47', '2025-12-21 14:30:47', NULL),
(57, 'PAY-000057', 'sale', 'customer', 1, 'Sale', 92, 'INV-000092', '2025-06-24', '14253.08', 'card', NULL, NULL, NULL, 'completed', 'Payment for sale INV-000092', 1, '2025-12-21 14:30:47', '2025-12-21 14:30:47', NULL),
(58, 'PAY-000058', 'purchase', 'supplier', 1, NULL, NULL, NULL, '2025-11-29', '5713.00', 'cheque', 'CHQ-179879', NULL, NULL, 'completed', 'Advance payment to supplier', 1, '2025-12-21 14:30:47', '2025-12-21 14:30:47', NULL),
(59, 'PAY-000059', 'purchase', 'supplier', 2, NULL, NULL, NULL, '2025-12-18', '16978.00', 'cheque', 'CHQ-555426', NULL, NULL, 'completed', 'Advance payment to supplier', 1, '2025-12-21 14:30:47', '2025-12-21 14:30:47', NULL),
(60, 'PAY-000060', 'purchase', 'supplier', 3, NULL, NULL, NULL, '2025-12-05', '8823.00', 'bank_transfer', NULL, 'DBBL', NULL, 'completed', 'Advance payment to supplier', 1, '2025-12-21 14:30:47', '2025-12-21 14:30:47', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

CREATE TABLE `permissions` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `group` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'general',
  `description` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `permissions`
--

INSERT INTO `permissions` (`id`, `name`, `slug`, `group`, `description`, `created_at`, `updated_at`) VALUES
(1, 'Access Dashboard', 'access-dashboard', 'general', 'Access to admin dashboard', '2025-12-21 14:30:44', '2025-12-21 14:30:44'),
(2, 'View Products', 'view-products', 'products', 'View product list', '2025-12-21 14:30:44', '2025-12-21 14:30:44'),
(3, 'Create Products', 'create-products', 'products', 'Create new products', '2025-12-21 14:30:44', '2025-12-21 14:30:44'),
(4, 'Edit Products', 'edit-products', 'products', 'Edit existing products', '2025-12-21 14:30:44', '2025-12-21 14:30:44'),
(5, 'Delete Products', 'delete-products', 'products', 'Delete products', '2025-12-21 14:30:44', '2025-12-21 14:30:44'),
(6, 'Manage Categories', 'manage-categories', 'products', 'Manage product categories', '2025-12-21 14:30:44', '2025-12-21 14:30:44'),
(7, 'Manage Units', 'manage-units', 'products', 'Manage product units', '2025-12-21 14:30:44', '2025-12-21 14:30:44'),
(8, 'View Warehouses', 'view-warehouses', 'warehouses', 'View warehouse list', '2025-12-21 14:30:44', '2025-12-21 14:30:44'),
(9, 'Manage Warehouses', 'manage-warehouses', 'warehouses', 'Create, edit, delete warehouses', '2025-12-21 14:30:44', '2025-12-21 14:30:44'),
(10, 'View Stock Levels', 'view-stock-levels', 'warehouses', 'View current stock levels', '2025-12-21 14:30:44', '2025-12-21 14:30:44'),
(11, 'View Stock Ledger', 'view-stock-ledger', 'reports', 'View complete stock movement history', '2025-12-21 14:30:44', '2025-12-21 14:30:44'),
(12, 'View Purchases', 'view-purchases', 'purchases', 'View purchase records', '2025-12-21 14:30:44', '2025-12-21 14:30:44'),
(13, 'Create Purchase', 'create-purchase', 'purchases', 'Create purchase invoices', '2025-12-21 14:30:44', '2025-12-21 14:30:44'),
(14, 'Manage Suppliers', 'manage-suppliers', 'purchases', 'Manage supplier information', '2025-12-21 14:30:44', '2025-12-21 14:30:44'),
(15, 'View Sales', 'view-sales', 'sales', 'View sales records', '2025-12-21 14:30:44', '2025-12-21 14:30:44'),
(16, 'Create Sale', 'create-sale', 'sales', 'Create sales invoices', '2025-12-21 14:30:44', '2025-12-21 14:30:44'),
(17, 'Manage Customers', 'manage-customers', 'sales', 'Manage customer information', '2025-12-21 14:30:44', '2025-12-21 14:30:44'),
(18, 'View Payments', 'view-payments', 'payments', 'View payment records', '2025-12-21 14:30:44', '2025-12-21 14:30:44'),
(19, 'Record Payment', 'record-payment', 'payments', 'Record customer/supplier payments', '2025-12-21 14:30:44', '2025-12-21 14:30:44'),
(20, 'View Reports', 'view-reports', 'reports', 'View reports', '2025-12-21 14:30:44', '2025-12-21 14:30:44'),
(21, 'Export Reports', 'export-reports', 'reports', 'Export reports to various formats', '2025-12-21 14:30:44', '2025-12-21 14:30:44'),
(22, 'Manage Users', 'manage-users', 'users', 'Create, edit, delete users', '2025-12-21 14:30:44', '2025-12-21 14:30:44'),
(23, 'Manage Roles', 'manage-roles', 'users', 'Create, edit, delete roles and permissions', '2025-12-21 14:30:44', '2025-12-21 14:30:44'),
(24, 'Manage Settings', 'manage-settings', 'settings', 'Manage system settings', '2025-12-21 14:30:44', '2025-12-21 14:30:44'),
(25, 'Upload Files', 'upload-files', 'general', 'Upload images and files', '2025-12-21 14:30:44', '2025-12-21 14:30:44'),
(26, 'View Login Logs', 'view-login-logs', 'system', 'View and manage login logs', '2025-12-21 14:30:44', '2025-12-21 14:30:44');

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint UNSIGNED NOT NULL,
  `name` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sku` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `barcode` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `category_id` bigint UNSIGNED DEFAULT NULL,
  `unit_id` bigint UNSIGNED DEFAULT NULL,
  `order` int NOT NULL DEFAULT '0',
  `description` text COLLATE utf8mb4_unicode_ci,
  `brand` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `purchase_price` decimal(15,2) NOT NULL DEFAULT '0.00',
  `sale_price` decimal(15,2) NOT NULL DEFAULT '0.00',
  `tax_rate` decimal(5,2) NOT NULL DEFAULT '0.00',
  `minimum_stock_level` int NOT NULL DEFAULT '0',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_by` bigint UNSIGNED DEFAULT NULL,
  `updated_by` bigint UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `name`, `sku`, `barcode`, `category_id`, `unit_id`, `order`, `description`, `brand`, `image`, `purchase_price`, `sale_price`, `tax_rate`, `minimum_stock_level`, `is_active`, `created_by`, `updated_by`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Rice 1kg', 'RICE-1KG', '1000001', 1, 2, 1, NULL, NULL, NULL, '45.00', '55.00', '0.00', 5, 1, 1, 1, '2025-12-21 14:30:45', '2025-12-21 14:30:45', NULL),
(2, 'Shampoo 200ml', 'SHP-200', '1000002', 2, 3, 2, NULL, NULL, NULL, '120.00', '150.00', '0.00', 3, 1, 1, 1, '2025-12-21 14:30:45', '2025-12-21 14:30:45', NULL),
(3, 'Laptop Dell Inspiron 15', 'SKU-000001', 'BC00000001', 11, 2, 1, 'Product description for Laptop Dell Inspiron 15', 'Dell', NULL, '3364.00', '3935.88', '9.00', 20, 1, 1, 1, '2025-12-21 14:30:45', '2025-12-21 14:30:45', NULL),
(4, 'Samsung Galaxy S23', 'SKU-000002', 'BC00000002', 1, 1, 2, 'Product description for Samsung Galaxy S23', 'Samsung', NULL, '1247.00', '1384.17', '12.00', 17, 1, 1, 1, '2025-12-21 14:30:45', '2025-12-21 14:30:45', NULL),
(5, 'iPhone 15 Pro', 'SKU-000003', 'BC00000003', 4, 1, 3, 'Product description for iPhone 15 Pro', 'Apple', NULL, '1261.00', '1513.20', '2.00', 17, 1, 1, 1, '2025-12-21 14:30:45', '2025-12-21 14:30:45', NULL),
(6, 'Wireless Mouse Logitech', 'SKU-000004', 'BC00000004', 6, 1, 4, 'Product description for Wireless Mouse Logitech', 'Logitech', NULL, '2715.00', '3013.65', '0.00', 14, 1, 1, 1, '2025-12-21 14:30:45', '2025-12-21 14:30:45', NULL),
(7, 'Mechanical Keyboard RGB', 'SKU-000005', 'BC00000005', 15, 3, 5, 'Product description for Mechanical Keyboard RGB', 'Corsair', NULL, '1808.00', '2332.32', '7.00', 18, 1, 1, 1, '2025-12-21 14:30:45', '2025-12-21 14:30:45', NULL),
(8, 'Monitor LG 27 inch', 'SKU-000006', 'BC00000006', 15, 2, 6, 'Product description for Monitor LG 27 inch', 'LG', NULL, '3776.00', '4342.40', '8.00', 9, 1, 1, 1, '2025-12-21 14:30:45', '2025-12-21 14:30:45', NULL),
(9, 'Webcam HD 1080p', 'SKU-000007', 'BC00000007', 12, 3, 7, 'Product description for Webcam HD 1080p', 'Logitech', NULL, '973.00', '1118.95', '1.00', 20, 1, 1, 1, '2025-12-21 14:30:45', '2025-12-21 14:30:45', NULL),
(10, 'USB-C Hub Multiport', 'SKU-000008', 'BC00000008', 3, 3, 8, 'Product description for USB-C Hub Multiport', 'Anker', NULL, '4144.00', '5180.00', '5.00', 15, 1, 1, 1, '2025-12-21 14:30:45', '2025-12-21 14:30:45', NULL),
(11, 'SSD 1TB Samsung', 'SKU-000009', 'BC00000009', 4, 1, 9, 'Product description for SSD 1TB Samsung', 'Samsung', NULL, '3378.00', '3783.36', '12.00', 8, 1, 1, 1, '2025-12-21 14:30:45', '2025-12-21 14:30:45', NULL),
(12, 'RAM 16GB DDR4', 'SKU-000010', 'BC00000010', 10, 3, 10, 'Product description for RAM 16GB DDR4', 'Corsair', NULL, '716.00', '902.16', '0.00', 19, 1, 1, 1, '2025-12-21 14:30:45', '2025-12-21 14:30:45', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `purchases`
--

CREATE TABLE `purchases` (
  `id` bigint UNSIGNED NOT NULL,
  `invoice_number` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `supplier_id` bigint UNSIGNED NOT NULL,
  `warehouse_id` bigint UNSIGNED NOT NULL,
  `invoice_date` date NOT NULL,
  `due_date` date DEFAULT NULL,
  `status` enum('draft','pending','partial','paid','cancelled') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'draft',
  `subtotal` decimal(15,2) NOT NULL DEFAULT '0.00',
  `tax_amount` decimal(15,2) NOT NULL DEFAULT '0.00',
  `discount_amount` decimal(15,2) NOT NULL DEFAULT '0.00',
  `shipping_cost` decimal(15,2) NOT NULL DEFAULT '0.00',
  `total_amount` decimal(15,2) NOT NULL DEFAULT '0.00',
  `paid_amount` decimal(15,2) NOT NULL DEFAULT '0.00',
  `balance_amount` decimal(15,2) NOT NULL DEFAULT '0.00',
  `notes` text COLLATE utf8mb4_unicode_ci,
  `created_by` bigint UNSIGNED NOT NULL,
  `updated_by` bigint UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `purchases`
--

INSERT INTO `purchases` (`id`, `invoice_number`, `supplier_id`, `warehouse_id`, `invoice_date`, `due_date`, `status`, `subtotal`, `tax_amount`, `discount_amount`, `shipping_cost`, `total_amount`, `paid_amount`, `balance_amount`, `notes`, `created_by`, `updated_by`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'PO-000001', 1, 3, '2025-09-07', '2025-10-17', 'cancelled', '10692.00', '1523.70', '534.00', '0.00', '11681.70', '0.00', '0.00', NULL, 1, NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45', NULL),
(2, 'PO-000002', 1, 1, '2025-09-20', '2025-10-07', 'partial', '16408.80', '2316.12', '968.00', '0.00', '17756.92', '13486.38', '4270.54', NULL, 1, NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:47', NULL),
(3, 'PO-000003', 3, 1, '2025-08-13', '2025-09-13', 'paid', '3972.15', '568.97', '179.00', '330.00', '4692.12', '4692.12', '0.00', NULL, 1, NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45', NULL),
(4, 'PO-000004', 2, 2, '2025-07-26', '2025-09-04', 'paid', '12094.95', '1814.24', '0.00', '260.00', '14169.19', '14169.19', '0.00', NULL, 1, NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:47', NULL),
(5, 'PO-000005', 1, 2, '2025-10-21', '2025-11-08', 'cancelled', '5472.00', '820.80', '0.00', '396.00', '6688.80', '0.00', '0.00', NULL, 1, NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45', NULL),
(6, 'PO-000006', 3, 2, '2025-10-04', '2025-11-06', 'paid', '8460.00', '1253.10', '106.00', '0.00', '9607.10', '9607.10', '0.00', NULL, 1, NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45', NULL),
(7, 'PO-000007', 3, 3, '2025-11-15', '2025-12-12', 'draft', '8072.70', '1210.91', '0.00', '423.00', '9706.61', '0.00', '9706.61', 'Additional notes for purchase order PO-000007', 1, NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45', NULL),
(8, 'PO-000008', 2, 2, '2025-11-27', '2025-12-17', 'draft', '7611.30', '1141.70', '0.00', '0.00', '8753.00', '0.00', '8753.00', NULL, 1, NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45', NULL),
(9, 'PO-000009', 2, 1, '2025-09-16', '2025-10-01', 'paid', '2208.00', '331.20', '0.00', '0.00', '2539.20', '2539.20', '0.00', NULL, 1, NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45', NULL),
(10, 'PO-000010', 2, 3, '2025-11-02', '2025-11-22', 'draft', '6308.40', '946.26', '0.00', '0.00', '7254.66', '0.00', '7254.66', NULL, 1, NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45', NULL),
(11, 'PO-000011', 3, 3, '2025-07-22', '2025-08-10', 'paid', '11625.00', '1521.15', '1484.00', '332.00', '11994.15', '11994.15', '0.00', NULL, 1, NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:47', NULL),
(12, 'PO-000012', 1, 2, '2025-08-31', '2025-10-06', 'partial', '3672.90', '550.94', '0.00', '291.00', '4514.84', '3794.72', '720.12', 'Additional notes for purchase order PO-000012', 1, NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:47', NULL),
(13, 'PO-000013', 1, 2, '2025-12-01', '2026-01-13', 'paid', '7047.00', '1057.05', '0.00', '469.00', '8573.05', '8573.05', '0.00', 'Additional notes for purchase order PO-000013', 1, NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:47', NULL),
(14, 'PO-000014', 1, 1, '2025-12-02', '2026-01-11', 'paid', '2072.70', '310.91', '0.00', '0.00', '2383.61', '2383.61', '0.00', 'Additional notes for purchase order PO-000014', 1, NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45', NULL),
(15, 'PO-000015', 3, 2, '2025-10-25', '2025-11-17', 'cancelled', '11130.00', '1623.60', '306.00', '270.00', '12717.60', '0.00', '0.00', NULL, 1, NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45', NULL),
(16, 'PO-000016', 2, 2, '2025-11-21', '2025-12-21', 'draft', '3230.10', '461.12', '156.00', '0.00', '3535.22', '0.00', '3535.22', 'Additional notes for purchase order PO-000016', 1, NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45', NULL),
(17, 'PO-000017', 1, 3, '2025-07-22', '2025-08-25', 'paid', '534.60', '80.19', '0.00', '0.00', '614.79', '614.79', '0.00', NULL, 1, NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45', NULL),
(18, 'PO-000018', 1, 3, '2025-11-03', '2025-12-07', 'paid', '10032.00', '1440.90', '426.00', '0.00', '11046.90', '11046.90', '0.00', NULL, 1, NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:47', NULL),
(19, 'PO-000019', 1, 3, '2025-12-07', '2026-01-02', 'draft', '4539.60', '680.94', '0.00', '0.00', '5220.54', '0.00', '5220.54', 'Additional notes for purchase order PO-000019', 1, NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45', NULL),
(20, 'PO-000020', 1, 1, '2025-07-16', '2025-08-16', 'paid', '10011.60', '1501.74', '0.00', '226.00', '11739.34', '11739.34', '0.00', NULL, 1, NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:47', NULL),
(21, 'PO-000021', 2, 3, '2025-09-24', '2025-11-03', 'paid', '2308.50', '346.28', '0.00', '485.00', '3139.78', '3139.78', '0.00', 'Additional notes for purchase order PO-000021', 1, NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45', NULL),
(22, 'PO-000022', 2, 1, '2025-11-04', '2025-12-19', 'paid', '13191.30', '1978.70', '0.00', '201.00', '15371.00', '15371.00', '0.00', 'Additional notes for purchase order PO-000022', 1, NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:47', NULL),
(23, 'PO-000023', 1, 2, '2025-11-20', '2025-12-18', 'partial', '6465.75', '969.86', '0.00', '0.00', '7435.61', '4668.82', '2766.79', 'Additional notes for purchase order PO-000023', 1, NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:47', NULL),
(24, 'PO-000024', 1, 2, '2025-09-30', '2025-10-21', 'paid', '6420.60', '963.09', '0.00', '0.00', '7383.69', '7383.69', '0.00', 'Additional notes for purchase order PO-000024', 1, NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:47', NULL),
(25, 'PO-000025', 3, 3, '2025-08-15', '2025-09-26', 'partial', '3360.00', '504.00', '0.00', '0.00', '3864.00', '2867.09', '996.91', NULL, 1, NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:47', NULL),
(26, 'PO-000026', 3, 2, '2025-08-04', '2025-09-06', 'draft', '12378.45', '1856.77', '0.00', '0.00', '14235.22', '0.00', '14235.22', NULL, 1, NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45', NULL),
(27, 'PO-000027', 3, 2, '2025-08-30', '2025-10-06', 'draft', '3013.20', '451.98', '0.00', '0.00', '3465.18', '0.00', '3465.18', NULL, 1, NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45', NULL),
(28, 'PO-000028', 1, 2, '2025-06-29', '2025-07-14', 'paid', '4653.90', '698.09', '0.00', '0.00', '5351.99', '5351.99', '0.00', NULL, 1, NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45', NULL),
(29, 'PO-000029', 2, 3, '2025-06-05', '2025-06-23', 'cancelled', '10158.00', '1474.50', '328.00', '0.00', '11304.50', '0.00', '0.00', NULL, 1, NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45', NULL),
(30, 'PO-000030', 2, 3, '2025-09-21', '2025-10-17', 'cancelled', '8613.60', '1292.04', '0.00', '416.00', '10321.64', '0.00', '0.00', NULL, 1, NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45', NULL),
(31, 'PO-000031', 2, 2, '2025-10-16', '2025-11-10', 'paid', '12667.65', '1900.15', '0.00', '0.00', '14567.80', '14567.80', '0.00', 'Additional notes for purchase order PO-000031', 1, NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:47', NULL),
(32, 'PO-000032', 3, 1, '2025-10-19', '2025-11-18', 'paid', '8290.80', '1243.62', '0.00', '0.00', '9534.42', '9534.42', '0.00', 'Additional notes for purchase order PO-000032', 1, NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45', NULL),
(33, 'PO-000033', 1, 1, '2025-09-07', '2025-10-03', 'partial', '3003.30', '450.50', '0.00', '0.00', '3453.80', '2784.45', '669.34', 'Additional notes for purchase order PO-000033', 1, NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:47', NULL),
(34, 'PO-000034', 1, 1, '2025-08-03', '2025-09-09', 'partial', '2214.90', '332.24', '0.00', '0.00', '2547.14', '1956.70', '590.43', NULL, 1, NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:47', NULL),
(35, 'PO-000035', 3, 1, '2025-09-27', '2025-10-21', 'partial', '480.15', '72.02', '0.00', '450.00', '1002.17', '803.74', '198.43', NULL, 1, NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:47', NULL),
(36, 'PO-000036', 3, 3, '2025-10-11', '2025-11-21', 'paid', '8979.75', '1346.96', '0.00', '0.00', '10326.71', '10326.71', '0.00', 'Additional notes for purchase order PO-000036', 1, NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45', NULL),
(37, 'PO-000037', 3, 2, '2025-07-30', '2025-08-18', 'partial', '4594.50', '689.18', '0.00', '0.00', '5283.68', '2916.59', '2367.08', NULL, 1, NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:47', NULL),
(38, 'PO-000038', 3, 2, '2025-05-28', '2025-06-15', 'partial', '6133.50', '920.03', '0.00', '0.00', '7053.53', '6047.70', '1005.83', NULL, 1, NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:47', NULL),
(39, 'PO-000039', 3, 3, '2025-10-10', '2025-11-04', 'draft', '11290.80', '1693.62', '0.00', '356.00', '13340.42', '0.00', '13340.42', NULL, 1, NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45', NULL),
(40, 'PO-000040', 2, 2, '2025-10-01', '2025-10-18', 'paid', '3976.20', '596.43', '0.00', '271.00', '4843.63', '4843.63', '0.00', NULL, 1, NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45', NULL),
(41, 'PO-000041', 1, 1, '2025-10-31', '2025-11-16', 'cancelled', '6932.40', '910.56', '862.00', '0.00', '6980.96', '0.00', '0.00', NULL, 1, NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45', NULL),
(42, 'PO-000042', 2, 2, '2025-09-26', '2025-10-31', 'draft', '6868.80', '1030.32', '0.00', '0.00', '7899.12', '0.00', '7899.12', NULL, 1, NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45', NULL),
(43, 'PO-000043', 2, 3, '2025-11-23', '2025-12-24', 'partial', '5061.60', '759.24', '0.00', '0.00', '5820.84', '4723.61', '1097.23', 'Additional notes for purchase order PO-000043', 1, NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:47', NULL),
(44, 'PO-000044', 3, 3, '2025-06-01', '2025-06-30', 'cancelled', '9115.20', '1284.33', '553.00', '451.00', '10297.53', '0.00', '0.00', NULL, 1, NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45', NULL),
(45, 'PO-000045', 1, 2, '2025-09-19', '2025-10-29', 'paid', '11054.40', '1566.06', '614.00', '306.00', '12312.46', '12312.46', '0.00', NULL, 1, NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:47', NULL),
(46, 'PO-000046', 2, 2, '2025-06-20', '2025-07-22', 'cancelled', '13371.00', '1930.35', '502.00', '437.00', '15236.35', '0.00', '0.00', NULL, 1, NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45', NULL),
(47, 'PO-000047', 2, 2, '2025-11-07', '2025-12-17', 'draft', '9758.40', '1463.76', '0.00', '0.00', '11222.16', '0.00', '11222.16', NULL, 1, NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45', NULL),
(48, 'PO-000048', 3, 1, '2025-06-07', '2025-06-24', 'partial', '2687.40', '403.11', '0.00', '218.00', '3308.51', '3016.70', '291.81', NULL, 1, NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:47', NULL),
(49, 'PO-000049', 3, 1, '2025-07-28', '2025-08-31', 'partial', '13653.45', '2048.02', '0.00', '234.00', '15935.47', '13704.50', '2230.97', NULL, 1, NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:47', NULL),
(50, 'PO-000050', 2, 3, '2025-11-24', '2025-12-21', 'partial', '12750.45', '1803.82', '725.00', '0.00', '13829.27', '11229.37', '2599.90', 'Additional notes for purchase order PO-000050', 1, NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:47', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `purchase_items`
--

CREATE TABLE `purchase_items` (
  `id` bigint UNSIGNED NOT NULL,
  `purchase_id` bigint UNSIGNED NOT NULL,
  `product_id` bigint UNSIGNED NOT NULL,
  `quantity` int NOT NULL,
  `unit_price` decimal(15,2) NOT NULL,
  `discount` decimal(15,2) NOT NULL DEFAULT '0.00',
  `tax` decimal(15,2) NOT NULL DEFAULT '0.00',
  `total` decimal(15,2) NOT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `purchase_items`
--

INSERT INTO `purchase_items` (`id`, `purchase_id`, `product_id`, `quantity`, `unit_price`, `discount`, `tax`, `total`, `notes`, `created_at`, `updated_at`) VALUES
(1, 1, 2, 81, '132.00', '534.00', '1523.70', '11681.70', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(2, 2, 1, 88, '47.70', '867.00', '499.59', '3830.19', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(3, 2, 2, 96, '127.20', '101.00', '1816.53', '13926.73', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(4, 3, 1, 97, '40.95', '179.00', '568.97', '4362.12', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(5, 4, 1, 57, '40.95', '0.00', '350.12', '2684.27', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(6, 4, 2, 83, '117.60', '0.00', '1464.12', '11224.92', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(7, 5, 1, 87, '43.20', '0.00', '563.76', '4322.16', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(8, 5, 2, 14, '122.40', '0.00', '257.04', '1970.64', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(9, 6, 2, 75, '112.80', '106.00', '1253.10', '9607.10', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(10, 7, 1, 18, '46.35', '0.00', '125.15', '959.45', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(11, 7, 2, 58, '124.80', '0.00', '1085.76', '8324.16', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(12, 8, 1, 97, '40.50', '0.00', '589.28', '4517.78', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(13, 8, 2, 33, '111.60', '0.00', '552.42', '4235.22', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(14, 9, 2, 20, '110.40', '0.00', '331.20', '2539.20', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(15, 10, 1, 32, '45.90', '0.00', '220.32', '1689.12', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(16, 10, 2, 37, '130.80', '0.00', '725.94', '5565.54', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(17, 11, 1, 28, '44.55', '966.00', '42.21', '323.61', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(18, 11, 2, 94, '110.40', '518.00', '1478.94', '11338.54', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(19, 12, 1, 77, '47.70', '0.00', '550.94', '4223.84', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(20, 13, 1, 44, '42.75', '0.00', '282.15', '2163.15', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(21, 13, 2, 41, '126.00', '0.00', '774.90', '5940.90', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(22, 14, 1, 49, '42.30', '0.00', '310.91', '2383.61', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(23, 15, 1, 72, '49.50', '306.00', '488.70', '3746.70', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(24, 15, 2, 65, '116.40', '0.00', '1134.90', '8700.90', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(25, 16, 1, 74, '43.65', '156.00', '461.12', '3535.22', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(26, 17, 1, 11, '48.60', '0.00', '80.19', '614.79', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(27, 18, 2, 88, '114.00', '426.00', '1440.90', '11046.90', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(28, 19, 1, 97, '46.80', '0.00', '680.94', '5220.54', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(29, 20, 2, 81, '123.60', '0.00', '1501.74', '11513.34', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(30, 21, 1, 54, '42.75', '0.00', '346.28', '2654.78', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(31, 22, 1, 90, '41.85', '0.00', '564.98', '4331.48', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(32, 22, 2, 77, '122.40', '0.00', '1413.72', '10838.52', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(33, 23, 1, 87, '41.85', '0.00', '546.14', '4187.09', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(34, 23, 2, 22, '128.40', '0.00', '423.72', '3248.52', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(35, 24, 1, 77, '48.60', '0.00', '561.33', '4303.53', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(36, 24, 2, 24, '111.60', '0.00', '401.76', '3080.16', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(37, 25, 2, 28, '120.00', '0.00', '504.00', '3864.00', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(38, 26, 1, 29, '49.05', '0.00', '213.37', '1635.82', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(39, 26, 2, 83, '132.00', '0.00', '1643.40', '12599.40', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(40, 27, 1, 72, '41.85', '0.00', '451.98', '3465.18', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(41, 28, 1, 54, '41.85', '0.00', '338.99', '2598.89', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(42, 28, 2, 21, '114.00', '0.00', '359.10', '2753.10', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(43, 29, 1, 40, '45.90', '0.00', '275.40', '2111.40', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(44, 29, 2, 73, '114.00', '328.00', '1199.10', '9193.10', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(45, 30, 2, 74, '116.40', '0.00', '1292.04', '9905.64', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(46, 31, 1, 79, '42.75', '0.00', '506.59', '3883.84', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(47, 31, 2, 79, '117.60', '0.00', '1393.56', '10683.96', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(48, 32, 1, 56, '49.05', '0.00', '412.02', '3158.82', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(49, 32, 2, 42, '132.00', '0.00', '831.60', '6375.60', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(50, 33, 1, 71, '42.30', '0.00', '450.50', '3453.80', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(51, 34, 1, 46, '48.15', '0.00', '332.24', '2547.14', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(52, 35, 1, 11, '43.65', '0.00', '72.02', '552.17', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(53, 36, 1, 55, '41.85', '0.00', '345.26', '2647.01', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(54, 36, 2, 53, '126.00', '0.00', '1001.70', '7679.70', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(55, 37, 1, 69, '40.50', '0.00', '419.18', '3213.68', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(56, 37, 2, 15, '120.00', '0.00', '270.00', '2070.00', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(57, 38, 1, 50, '42.75', '0.00', '320.63', '2458.13', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(58, 38, 2, 37, '108.00', '0.00', '599.40', '4595.40', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(59, 39, 2, 97, '116.40', '0.00', '1693.62', '12984.42', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(60, 40, 1, 94, '42.30', '0.00', '596.43', '4572.63', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(61, 41, 2, 53, '130.80', '862.00', '910.56', '6980.96', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(62, 42, 2, 53, '129.60', '0.00', '1030.32', '7899.12', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(63, 43, 1, 81, '43.20', '0.00', '524.88', '4024.08', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(64, 43, 2, 14, '111.60', '0.00', '234.36', '1796.76', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(65, 44, 1, 72, '46.35', '553.00', '417.63', '3201.83', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(66, 44, 2, 45, '128.40', '0.00', '866.70', '6644.70', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(67, 45, 2, 94, '117.60', '614.00', '1566.06', '12006.46', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(68, 46, 1, 70, '47.70', '221.00', '467.70', '3585.70', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(69, 46, 2, 76, '132.00', '281.00', '1462.65', '11213.65', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(70, 47, 2, 76, '128.40', '0.00', '1463.76', '11222.16', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(71, 48, 1, 19, '48.60', '0.00', '138.51', '1061.91', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(72, 48, 2, 15, '117.60', '0.00', '264.60', '2028.60', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(73, 49, 1, 23, '40.95', '0.00', '141.28', '1083.13', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(74, 49, 2, 99, '128.40', '0.00', '1906.74', '14618.34', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(75, 50, 1, 75, '40.95', '0.00', '460.69', '3531.94', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(76, 50, 2, 74, '130.80', '725.00', '1343.13', '10297.33', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45');

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `is_system` tinyint(1) NOT NULL DEFAULT '0',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `order` int NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`, `slug`, `description`, `is_system`, `is_active`, `order`, `created_at`, `updated_at`) VALUES
(1, 'Administrator', 'administrator', 'Full system access - manage users, roles, warehouse access, and configure master data', 1, 1, 1, '2025-12-21 14:30:44', '2025-12-21 14:30:44'),
(2, 'Cashier', 'cashier', 'Handle sales and customer payments', 1, 1, 2, '2025-12-21 14:30:44', '2025-12-21 14:30:44'),
(3, 'Storekeeper', 'storekeeper', 'Manage stock, purchases, and products', 1, 1, 3, '2025-12-21 14:30:44', '2025-12-21 14:30:44');

-- --------------------------------------------------------

--
-- Table structure for table `role_permission`
--

CREATE TABLE `role_permission` (
  `id` bigint UNSIGNED NOT NULL,
  `role_id` bigint UNSIGNED NOT NULL,
  `permission_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `role_permission`
--

INSERT INTO `role_permission` (`id`, `role_id`, `permission_id`, `created_at`, `updated_at`) VALUES
(1, 1, 1, NULL, NULL),
(2, 1, 2, NULL, NULL),
(3, 1, 3, NULL, NULL),
(4, 1, 4, NULL, NULL),
(5, 1, 5, NULL, NULL),
(6, 1, 6, NULL, NULL),
(7, 1, 7, NULL, NULL),
(8, 1, 8, NULL, NULL),
(9, 1, 9, NULL, NULL),
(10, 1, 10, NULL, NULL),
(11, 1, 11, NULL, NULL),
(12, 1, 12, NULL, NULL),
(13, 1, 13, NULL, NULL),
(14, 1, 14, NULL, NULL),
(15, 1, 15, NULL, NULL),
(16, 1, 16, NULL, NULL),
(17, 1, 17, NULL, NULL),
(18, 1, 18, NULL, NULL),
(19, 1, 19, NULL, NULL),
(20, 1, 20, NULL, NULL),
(21, 1, 21, NULL, NULL),
(22, 1, 22, NULL, NULL),
(23, 1, 23, NULL, NULL),
(24, 1, 24, NULL, NULL),
(25, 1, 25, NULL, NULL),
(26, 1, 26, NULL, NULL),
(27, 2, 1, NULL, NULL),
(28, 2, 2, NULL, NULL),
(29, 2, 8, NULL, NULL),
(30, 2, 15, NULL, NULL),
(31, 2, 16, NULL, NULL),
(32, 2, 17, NULL, NULL),
(33, 2, 18, NULL, NULL),
(34, 2, 19, NULL, NULL),
(35, 2, 20, NULL, NULL),
(36, 2, 25, NULL, NULL),
(37, 3, 1, NULL, NULL),
(38, 3, 2, NULL, NULL),
(39, 3, 3, NULL, NULL),
(40, 3, 4, NULL, NULL),
(41, 3, 5, NULL, NULL),
(42, 3, 6, NULL, NULL),
(43, 3, 7, NULL, NULL),
(44, 3, 8, NULL, NULL),
(45, 3, 9, NULL, NULL),
(46, 3, 10, NULL, NULL),
(47, 3, 11, NULL, NULL),
(48, 3, 12, NULL, NULL),
(49, 3, 13, NULL, NULL),
(50, 3, 14, NULL, NULL),
(51, 3, 18, NULL, NULL),
(52, 3, 19, NULL, NULL),
(53, 3, 20, NULL, NULL),
(54, 3, 25, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `sales`
--

CREATE TABLE `sales` (
  `id` bigint UNSIGNED NOT NULL,
  `invoice_number` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `customer_id` bigint UNSIGNED NOT NULL,
  `warehouse_id` bigint UNSIGNED NOT NULL,
  `invoice_date` date NOT NULL,
  `due_date` date DEFAULT NULL,
  `status` enum('draft','pending','partial','paid','cancelled') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'draft',
  `subtotal` decimal(15,2) NOT NULL DEFAULT '0.00',
  `tax_amount` decimal(15,2) NOT NULL DEFAULT '0.00',
  `discount_amount` decimal(15,2) NOT NULL DEFAULT '0.00',
  `shipping_cost` decimal(15,2) NOT NULL DEFAULT '0.00',
  `total_amount` decimal(15,2) NOT NULL DEFAULT '0.00',
  `paid_amount` decimal(15,2) NOT NULL DEFAULT '0.00',
  `balance_amount` decimal(15,2) NOT NULL DEFAULT '0.00',
  `notes` text COLLATE utf8mb4_unicode_ci,
  `created_by` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sales`
--

INSERT INTO `sales` (`id`, `invoice_number`, `customer_id`, `warehouse_id`, `invoice_date`, `due_date`, `status`, `subtotal`, `tax_amount`, `discount_amount`, `shipping_cost`, `total_amount`, `paid_amount`, `balance_amount`, `notes`, `created_by`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'INV-0001', 1, 1, '2025-12-21', NULL, 'paid', '110.00', '0.00', '0.00', '0.00', '110.00', '110.00', '0.00', NULL, 1, '2025-12-21 14:30:45', '2025-12-21 14:30:45', NULL),
(2, 'INV-000002', 3, 1, '2025-11-02', '2025-11-15', 'partial', '99949.64', '3734.54', '406.00', '0.00', '103278.18', '75083.24', '28194.94', NULL, 1, '2025-12-21 14:30:45', '2025-12-21 14:30:47', NULL),
(3, 'INV-000003', 3, 1, '2025-08-23', '2025-09-22', 'draft', '3783.36', '454.00', '0.00', '0.00', '4237.36', '0.00', '4237.36', NULL, 1, '2025-12-21 14:30:45', '2025-12-21 14:30:45', NULL),
(4, 'INV-000004', 2, 2, '2025-11-29', '2025-12-15', 'paid', '36974.97', '3612.72', '63.00', '0.00', '40524.69', '40524.69', '0.00', NULL, 1, '2025-12-21 14:30:45', '2025-12-21 14:30:45', NULL),
(5, 'INV-000005', 3, 2, '2025-10-02', '2025-10-29', 'paid', '21559.92', '1108.09', '615.00', '62.00', '22115.01', '22115.01', '0.00', NULL, 1, '2025-12-21 14:30:45', '2025-12-21 14:30:45', NULL),
(6, 'INV-000006', 2, 1, '2025-12-19', '2026-01-10', 'paid', '11350.08', '1313.05', '408.00', '0.00', '12255.13', '12255.13', '0.00', 'Additional notes for invoice INV-000006', 1, '2025-12-21 14:30:45', '2025-12-21 14:30:47', NULL),
(7, 'INV-000007', 1, 3, '2025-06-25', '2025-07-04', 'cancelled', '69611.55', '4624.70', '372.00', '0.00', '73864.25', '0.00', '0.00', 'Additional notes for invoice INV-000007', 1, '2025-12-21 14:30:45', '2025-12-21 14:30:45', NULL),
(8, 'INV-000008', 2, 3, '2025-12-07', '2025-12-23', 'cancelled', '34480.62', '2479.60', '239.00', '0.00', '36721.22', '0.00', '0.00', NULL, 1, '2025-12-21 14:30:45', '2025-12-21 14:30:45', NULL),
(9, 'INV-000009', 2, 2, '2025-10-29', '2025-11-28', 'partial', '35779.84', '1830.97', '0.00', '0.00', '37610.81', '27019.61', '10591.21', NULL, 1, '2025-12-21 14:30:45', '2025-12-21 14:30:47', NULL),
(10, 'INV-000010', 3, 2, '2025-12-07', '2025-12-31', 'paid', '98622.56', '7271.06', '118.00', '0.00', '105775.62', '105775.62', '0.00', NULL, 1, '2025-12-21 14:30:45', '2025-12-21 14:30:45', NULL),
(11, 'INV-000011', 1, 2, '2025-08-18', '2025-09-02', 'cancelled', '31182.00', '2975.78', '480.00', '0.00', '33677.78', '0.00', '0.00', 'Additional notes for invoice INV-000011', 1, '2025-12-21 14:30:45', '2025-12-21 14:30:45', NULL),
(12, 'INV-000012', 2, 2, '2025-08-02', '2025-08-25', 'partial', '4539.60', '90.79', '0.00', '0.00', '4630.39', '3719.13', '911.26', NULL, 1, '2025-12-21 14:30:45', '2025-12-21 14:30:47', NULL),
(13, 'INV-000013', 3, 1, '2025-09-04', '2025-10-03', 'paid', '23819.11', '2679.22', '550.00', '0.00', '25948.33', '25948.33', '0.00', NULL, 1, '2025-12-21 14:30:45', '2025-12-21 14:30:47', NULL),
(14, 'INV-000014', 1, 1, '2025-10-03', '2025-10-14', 'cancelled', '41072.68', '3155.61', '711.00', '0.00', '43517.29', '0.00', '0.00', NULL, 1, '2025-12-21 14:30:45', '2025-12-21 14:30:45', NULL),
(15, 'INV-000015', 3, 2, '2025-08-25', '2025-09-08', 'paid', '33959.10', '1982.28', '366.00', '0.00', '35575.38', '35575.38', '0.00', NULL, 1, '2025-12-21 14:30:45', '2025-12-21 14:30:45', NULL),
(16, 'INV-000016', 1, 3, '2025-09-28', '2025-10-17', 'paid', '42683.16', '2782.24', '0.00', '0.00', '45465.40', '45465.40', '0.00', 'Additional notes for invoice INV-000016', 1, '2025-12-21 14:30:45', '2025-12-21 14:30:45', NULL),
(17, 'INV-000017', 3, 3, '2025-08-20', '2025-09-05', 'partial', '55256.20', '4427.17', '434.00', '0.00', '59249.37', '51167.76', '8081.61', 'Additional notes for invoice INV-000017', 1, '2025-12-21 14:30:45', '2025-12-21 14:30:47', NULL),
(18, 'INV-000018', 1, 2, '2025-09-21', '2025-10-06', 'partial', '11331.42', '1057.13', '0.00', '0.00', '12388.55', '8987.89', '3400.66', NULL, 1, '2025-12-21 14:30:45', '2025-12-21 14:30:47', NULL),
(19, 'INV-000019', 3, 1, '2025-06-20', '2025-07-20', 'paid', '108894.00', '7006.13', '679.00', '0.00', '115221.13', '115221.13', '0.00', NULL, 1, '2025-12-21 14:30:45', '2025-12-21 14:30:45', NULL),
(20, 'INV-000020', 1, 3, '2025-10-06', '2025-10-18', 'paid', '68532.54', '5428.11', '0.00', '0.00', '73960.65', '73960.65', '0.00', NULL, 1, '2025-12-21 14:30:45', '2025-12-21 14:30:45', NULL),
(21, 'INV-000021', 1, 2, '2025-06-22', '2025-07-01', 'partial', '25953.66', '708.46', '0.00', '0.00', '26662.12', '19943.27', '6718.85', NULL, 1, '2025-12-21 14:30:45', '2025-12-21 14:30:47', NULL),
(22, 'INV-000022', 3, 1, '2025-07-16', '2025-07-25', 'cancelled', '119466.79', '8542.32', '60.00', '0.00', '127949.11', '0.00', '0.00', NULL, 1, '2025-12-21 14:30:45', '2025-12-21 14:30:45', NULL),
(23, 'INV-000023', 2, 1, '2025-06-29', '2025-07-28', 'cancelled', '80286.72', '6757.86', '566.00', '0.00', '86478.58', '0.00', '0.00', NULL, 1, '2025-12-21 14:30:45', '2025-12-21 14:30:45', NULL),
(24, 'INV-000024', 2, 1, '2025-11-03', '2025-12-02', 'draft', '33526.08', '2652.48', '1082.00', '0.00', '35096.56', '0.00', '35096.56', 'Additional notes for invoice INV-000024', 1, '2025-12-21 14:30:45', '2025-12-21 14:30:45', NULL),
(25, 'INV-000025', 1, 3, '2025-05-24', '2025-06-10', 'paid', '125613.75', '11437.87', '214.00', '0.00', '136837.62', '136837.62', '0.00', NULL, 1, '2025-12-21 14:30:45', '2025-12-21 14:30:45', NULL),
(26, 'INV-000026', 3, 3, '2025-09-14', '2025-10-06', 'paid', '37231.77', '3385.27', '275.00', '0.00', '40342.04', '40342.04', '0.00', NULL, 1, '2025-12-21 14:30:45', '2025-12-21 14:30:45', NULL),
(27, 'INV-000027', 1, 2, '2025-05-31', '2025-06-16', 'partial', '34360.20', '311.12', '812.00', '167.00', '34026.32', '31705.72', '2320.60', NULL, 1, '2025-12-21 14:30:45', '2025-12-21 14:30:47', NULL),
(28, 'INV-000028', 2, 3, '2025-06-26', '2025-07-13', 'paid', '5566.80', '326.52', '0.00', '161.00', '6054.32', '6054.32', '0.00', 'Additional notes for invoice INV-000028', 1, '2025-12-21 14:30:45', '2025-12-21 14:30:45', NULL),
(29, 'INV-000029', 1, 2, '2025-10-22', '2025-11-20', 'cancelled', '26483.52', '3178.02', '0.00', '0.00', '29661.54', '0.00', '0.00', NULL, 1, '2025-12-21 14:30:45', '2025-12-21 14:30:45', NULL),
(30, 'INV-000030', 3, 3, '2025-09-10', '2025-09-25', 'paid', '55675.50', '1112.93', '392.00', '154.00', '56550.43', '56550.43', '0.00', NULL, 1, '2025-12-21 14:30:45', '2025-12-21 14:30:47', NULL),
(31, 'INV-000031', 1, 3, '2025-08-29', '2025-09-14', 'draft', '39273.65', '1813.00', '0.00', '0.00', '41086.65', '0.00', '41086.65', NULL, 1, '2025-12-21 14:30:45', '2025-12-21 14:30:45', NULL),
(32, 'INV-000032', 1, 3, '2025-10-10', '2025-10-19', 'draft', '5894.97', '118.70', '667.00', '0.00', '5346.67', '0.00', '5346.67', NULL, 1, '2025-12-21 14:30:45', '2025-12-21 14:30:45', NULL),
(33, 'INV-000033', 3, 2, '2025-10-23', '2025-11-21', 'partial', '30578.40', '3026.33', '500.00', '59.00', '33163.73', '19433.95', '13729.78', 'Additional notes for invoice INV-000033', 1, '2025-12-21 14:30:45', '2025-12-21 14:30:47', NULL),
(34, 'INV-000034', 3, 2, '2025-06-30', '2025-07-13', 'draft', '29210.03', '2181.32', '0.00', '131.00', '31522.35', '0.00', '31522.35', NULL, 1, '2025-12-21 14:30:45', '2025-12-21 14:30:45', NULL),
(35, 'INV-000035', 2, 3, '2025-09-24', '2025-10-17', 'draft', '10198.15', '192.77', '0.00', '0.00', '10390.92', '0.00', '10390.92', 'Additional notes for invoice INV-000035', 1, '2025-12-21 14:30:45', '2025-12-21 14:30:45', NULL),
(36, 'INV-000036', 3, 2, '2025-10-10', '2025-10-31', 'draft', '6069.69', '620.10', '0.00', '0.00', '6689.79', '0.00', '6689.79', NULL, 1, '2025-12-21 14:30:45', '2025-12-21 14:30:45', NULL),
(37, 'INV-000037', 3, 2, '2025-10-01', '2025-10-23', 'partial', '67871.20', '5524.86', '119.00', '0.00', '73277.06', '57830.26', '15446.80', NULL, 1, '2025-12-21 14:30:45', '2025-12-21 14:30:47', NULL),
(38, 'INV-000038', 1, 2, '2025-07-28', '2025-08-16', 'cancelled', '13841.70', '1661.00', '0.00', '0.00', '15502.70', '0.00', '0.00', 'Additional notes for invoice INV-000038', 1, '2025-12-21 14:30:45', '2025-12-21 14:30:45', NULL),
(39, 'INV-000039', 1, 3, '2025-06-21', '2025-07-14', 'partial', '21420.63', '1418.56', '368.00', '0.00', '22471.19', '18617.37', '3853.81', NULL, 1, '2025-12-21 14:30:45', '2025-12-21 14:30:47', NULL),
(40, 'INV-000040', 1, 2, '2025-12-06', '2025-12-22', 'draft', '29570.19', '1198.35', '927.00', '0.00', '29841.54', '0.00', '29841.54', NULL, 1, '2025-12-21 14:30:45', '2025-12-21 14:30:45', NULL),
(41, 'INV-000041', 2, 2, '2025-11-13', '2025-12-01', 'paid', '13027.20', '1042.18', '0.00', '0.00', '14069.38', '14069.38', '0.00', NULL, 1, '2025-12-21 14:30:45', '2025-12-21 14:30:45', NULL),
(42, 'INV-000042', 1, 2, '2025-11-04', '2025-11-17', 'paid', '33598.89', '2218.60', '0.00', '0.00', '35817.49', '35817.49', '0.00', 'Additional notes for invoice INV-000042', 1, '2025-12-21 14:30:45', '2025-12-21 14:30:47', NULL),
(43, 'INV-000043', 3, 2, '2025-09-12', '2025-09-30', 'paid', '103194.90', '8252.06', '345.00', '0.00', '111101.96', '111101.96', '0.00', 'Additional notes for invoice INV-000043', 1, '2025-12-21 14:30:45', '2025-12-21 14:30:45', NULL),
(44, 'INV-000044', 1, 3, '2025-08-16', '2025-09-04', 'partial', '49163.73', '4442.59', '0.00', '0.00', '53606.32', '43989.35', '9616.98', 'Additional notes for invoice INV-000044', 1, '2025-12-21 14:30:45', '2025-12-21 14:30:47', NULL),
(45, 'INV-000045', 1, 1, '2025-11-28', '2025-12-17', 'paid', '6613.86', '496.31', '766.00', '0.00', '6344.17', '6344.17', '0.00', 'Additional notes for invoice INV-000045', 1, '2025-12-21 14:30:45', '2025-12-21 14:30:47', NULL),
(46, 'INV-000046', 3, 3, '2025-06-17', '2025-07-16', 'cancelled', '79302.88', '6578.71', '284.00', '200.00', '85797.59', '0.00', '0.00', NULL, 1, '2025-12-21 14:30:45', '2025-12-21 14:30:45', NULL),
(47, 'INV-000047', 1, 2, '2025-07-05', '2025-07-19', 'paid', '30715.33', '1109.54', '0.00', '0.00', '31824.87', '31824.87', '0.00', NULL, 1, '2025-12-21 14:30:45', '2025-12-21 14:30:47', NULL),
(48, 'INV-000048', 1, 1, '2025-12-15', '2026-01-09', 'partial', '88500.24', '5321.48', '441.00', '0.00', '93380.72', '79569.71', '13811.01', 'Additional notes for invoice INV-000048', 1, '2025-12-21 14:30:45', '2025-12-21 14:30:47', NULL),
(49, 'INV-000049', 3, 3, '2025-09-08', '2025-09-23', 'cancelled', '9472.56', '1018.63', '0.00', '183.00', '10674.19', '0.00', '0.00', 'Additional notes for invoice INV-000049', 1, '2025-12-21 14:30:45', '2025-12-21 14:30:45', NULL),
(50, 'INV-000050', 3, 3, '2025-10-29', '2025-11-12', 'paid', '74777.34', '3832.68', '537.00', '0.00', '78073.02', '78073.02', '0.00', 'Additional notes for invoice INV-000050', 1, '2025-12-21 14:30:45', '2025-12-21 14:30:47', NULL),
(51, 'INV-000051', 3, 2, '2025-11-19', '2025-12-09', 'draft', '73359.82', '5438.21', '262.00', '0.00', '78536.03', '0.00', '78536.03', NULL, 1, '2025-12-21 14:30:45', '2025-12-21 14:30:45', NULL),
(52, 'INV-000052', 3, 2, '2025-08-15', '2025-09-08', 'draft', '5594.75', '55.95', '0.00', '0.00', '5650.70', '0.00', '5650.70', NULL, 1, '2025-12-21 14:30:45', '2025-12-21 14:30:45', NULL),
(53, 'INV-000053', 2, 3, '2025-07-16', '2025-08-12', 'paid', '42554.13', '2908.84', '462.00', '169.00', '45169.97', '45169.97', '0.00', NULL, 1, '2025-12-21 14:30:45', '2025-12-21 14:30:47', NULL),
(54, 'INV-000054', 3, 1, '2025-05-27', '2025-06-22', 'paid', '9021.60', '0.00', '0.00', '110.00', '9131.60', '9131.60', '0.00', NULL, 1, '2025-12-21 14:30:45', '2025-12-21 14:30:45', NULL),
(55, 'INV-000055', 3, 3, '2025-09-12', '2025-10-02', 'paid', '87741.04', '6077.51', '479.00', '0.00', '93339.55', '93339.55', '0.00', 'Additional notes for invoice INV-000055', 1, '2025-12-21 14:30:45', '2025-12-21 14:30:45', NULL),
(56, 'INV-000056', 2, 1, '2025-11-02', '2025-11-28', 'paid', '88763.24', '4743.58', '409.00', '0.00', '93097.82', '93097.82', '0.00', 'Additional notes for invoice INV-000056', 1, '2025-12-21 14:30:45', '2025-12-21 14:30:47', NULL),
(57, 'INV-000057', 2, 3, '2025-11-06', '2025-12-03', 'partial', '45897.65', '3562.45', '410.00', '0.00', '49050.10', '45224.19', '3825.91', NULL, 1, '2025-12-21 14:30:45', '2025-12-21 14:30:47', NULL),
(58, 'INV-000058', 3, 3, '2025-11-12', '2025-12-05', 'partial', '31975.34', '2418.87', '0.00', '127.00', '34521.21', '29919.53', '4601.68', 'Additional notes for invoice INV-000058', 1, '2025-12-21 14:30:45', '2025-12-21 14:30:47', NULL),
(59, 'INV-000059', 3, 1, '2025-10-17', '2025-10-25', 'partial', '38760.48', '2657.43', '739.00', '0.00', '40678.91', '28251.50', '12427.41', 'Additional notes for invoice INV-000059', 1, '2025-12-21 14:30:45', '2025-12-21 14:30:47', NULL),
(60, 'INV-000060', 3, 3, '2025-10-10', '2025-10-25', 'cancelled', '3783.36', '454.00', '0.00', '65.00', '4302.36', '0.00', '0.00', NULL, 1, '2025-12-21 14:30:45', '2025-12-21 14:30:45', NULL),
(61, 'INV-000061', 3, 2, '2025-06-06', '2025-07-03', 'draft', '39824.04', '1854.40', '431.00', '0.00', '41247.44', '0.00', '41247.44', 'Additional notes for invoice INV-000061', 1, '2025-12-21 14:30:45', '2025-12-21 14:30:45', NULL),
(62, 'INV-000062', 3, 3, '2025-06-09', '2025-06-24', 'draft', '71423.86', '4530.49', '57.00', '171.00', '76068.35', '0.00', '76068.35', 'Additional notes for invoice INV-000062', 1, '2025-12-21 14:30:45', '2025-12-21 14:30:45', NULL),
(63, 'INV-000063', 2, 1, '2025-10-09', '2025-11-06', 'paid', '31465.25', '328.19', '240.00', '0.00', '31553.44', '31553.44', '0.00', NULL, 1, '2025-12-21 14:30:45', '2025-12-21 14:30:47', NULL),
(64, 'INV-000064', 2, 2, '2025-10-04', '2025-10-16', 'draft', '36873.99', '762.16', '0.00', '0.00', '37636.15', '0.00', '37636.15', NULL, 1, '2025-12-21 14:30:45', '2025-12-21 14:30:45', NULL),
(65, 'INV-000065', 2, 1, '2025-11-08', '2025-12-01', 'paid', '61898.38', '5016.20', '0.00', '71.00', '66985.58', '66985.58', '0.00', NULL, 1, '2025-12-21 14:30:45', '2025-12-21 14:30:45', NULL),
(66, 'INV-000066', 2, 3, '2025-05-22', '2025-06-20', 'paid', '31487.04', '2833.83', '0.00', '0.00', '34320.87', '34320.87', '0.00', 'Additional notes for invoice INV-000066', 1, '2025-12-21 14:30:45', '2025-12-21 14:30:45', NULL),
(67, 'INV-000067', 3, 1, '2025-06-28', '2025-07-11', 'paid', '31080.00', '1545.65', '167.00', '119.00', '32577.65', '32577.65', '0.00', 'Additional notes for invoice INV-000067', 1, '2025-12-21 14:30:45', '2025-12-21 14:30:47', NULL),
(68, 'INV-000068', 1, 3, '2025-11-02', '2025-12-01', 'paid', '71313.64', '4183.28', '388.00', '191.00', '75299.92', '75299.92', '0.00', NULL, 1, '2025-12-21 14:30:45', '2025-12-21 14:30:45', NULL),
(69, 'INV-000069', 1, 3, '2025-12-19', '2025-12-30', 'cancelled', '36260.00', '1813.00', '0.00', '0.00', '38073.00', '0.00', '0.00', 'Additional notes for invoice INV-000069', 1, '2025-12-21 14:30:45', '2025-12-21 14:30:45', NULL),
(70, 'INV-000070', 1, 1, '2025-06-26', '2025-07-13', 'paid', '31023.12', '3268.81', '0.00', '0.00', '34291.93', '34291.93', '0.00', NULL, 1, '2025-12-21 14:30:46', '2025-12-21 14:30:46', NULL),
(71, 'INV-000071', 1, 1, '2025-08-19', '2025-08-27', 'draft', '95915.00', '8095.81', '173.00', '0.00', '103837.81', '0.00', '103837.81', NULL, 1, '2025-12-21 14:30:46', '2025-12-21 14:30:46', NULL),
(72, 'INV-000072', 3, 2, '2025-05-24', '2025-06-13', 'paid', '11350.08', '1362.01', '0.00', '0.00', '12712.09', '12712.09', '0.00', NULL, 1, '2025-12-21 14:30:46', '2025-12-21 14:30:47', NULL),
(73, 'INV-000073', 3, 2, '2025-10-07', '2025-10-22', 'cancelled', '3783.36', '454.00', '0.00', '108.00', '4345.36', '0.00', '0.00', NULL, 1, '2025-12-21 14:30:46', '2025-12-21 14:30:46', NULL),
(74, 'INV-000074', 2, 1, '2025-10-17', '2025-10-26', 'paid', '10592.40', '211.85', '0.00', '0.00', '10804.25', '10804.25', '0.00', NULL, 1, '2025-12-21 14:30:46', '2025-12-21 14:30:47', NULL),
(75, 'INV-000075', 2, 1, '2025-05-31', '2025-06-19', 'paid', '69044.30', '2678.39', '378.00', '0.00', '71344.69', '71344.69', '0.00', NULL, 1, '2025-12-21 14:30:46', '2025-12-21 14:30:46', NULL),
(76, 'INV-000076', 1, 1, '2025-07-28', '2025-08-14', 'paid', '77534.44', '6950.23', '126.00', '59.00', '84417.67', '84417.67', '0.00', NULL, 1, '2025-12-21 14:30:46', '2025-12-21 14:30:47', NULL),
(77, 'INV-000077', 3, 1, '2025-08-02', '2025-08-26', 'cancelled', '79563.18', '6515.40', '0.00', '0.00', '86078.58', '0.00', '0.00', NULL, 1, '2025-12-21 14:30:46', '2025-12-21 14:30:46', NULL),
(78, 'INV-000078', 1, 3, '2025-11-13', '2025-11-28', 'cancelled', '51351.07', '3639.90', '711.00', '0.00', '54279.97', '0.00', '0.00', NULL, 1, '2025-12-21 14:30:46', '2025-12-21 14:30:46', NULL),
(79, 'INV-000079', 2, 1, '2025-11-17', '2025-12-03', 'partial', '69747.36', '3253.39', '214.00', '0.00', '72786.75', '53483.70', '19303.05', NULL, 1, '2025-12-21 14:30:46', '2025-12-21 14:30:47', NULL),
(80, 'INV-000080', 2, 2, '2025-11-13', '2025-11-30', 'draft', '20720.00', '1036.00', '0.00', '123.00', '21879.00', '0.00', '21879.00', NULL, 1, '2025-12-21 14:30:46', '2025-12-21 14:30:46', NULL),
(81, 'INV-000081', 1, 2, '2025-12-16', '2026-01-11', 'paid', '9341.52', '50.75', '489.00', '0.00', '8903.27', '8903.27', '0.00', NULL, 1, '2025-12-21 14:30:46', '2025-12-21 14:30:46', NULL),
(82, 'INV-000082', 1, 3, '2025-10-26', '2025-11-07', 'draft', '21712.00', '1736.96', '0.00', '0.00', '23448.96', '0.00', '23448.96', NULL, 1, '2025-12-21 14:30:46', '2025-12-21 14:30:46', NULL),
(83, 'INV-000083', 1, 3, '2025-09-02', '2025-09-20', 'paid', '8550.33', '664.40', '95.00', '0.00', '9119.73', '9119.73', '0.00', NULL, 1, '2025-12-21 14:30:46', '2025-12-21 14:30:46', NULL),
(84, 'INV-000084', 2, 3, '2025-08-07', '2025-08-21', 'paid', '43424.00', '3473.92', '0.00', '0.00', '46897.92', '46897.92', '0.00', NULL, 1, '2025-12-21 14:30:46', '2025-12-21 14:30:47', NULL),
(85, 'INV-000085', 3, 1, '2025-06-29', '2025-07-22', 'paid', '38683.53', '2125.38', '0.00', '0.00', '40808.91', '40808.91', '0.00', NULL, 1, '2025-12-21 14:30:46', '2025-12-21 14:30:47', NULL),
(86, 'INV-000086', 2, 2, '2025-12-05', '2025-12-23', 'paid', '68234.32', '3888.33', '624.00', '0.00', '71498.65', '71498.65', '0.00', NULL, 1, '2025-12-21 14:30:46', '2025-12-21 14:30:46', NULL),
(87, 'INV-000087', 1, 1, '2025-11-21', '2025-11-30', 'cancelled', '53818.53', '1562.04', '0.00', '0.00', '55380.57', '0.00', '0.00', NULL, 1, '2025-12-21 14:30:46', '2025-12-21 14:30:46', NULL),
(88, 'INV-000088', 3, 2, '2025-07-23', '2025-08-22', 'partial', '58838.49', '4557.11', '277.00', '0.00', '63118.60', '48538.20', '14580.40', NULL, 1, '2025-12-21 14:30:46', '2025-12-21 14:30:47', NULL),
(89, 'INV-000089', 2, 2, '2025-09-26', '2025-10-19', 'partial', '33723.99', '1968.96', '86.00', '171.00', '35777.95', '24271.76', '11506.18', 'Additional notes for invoice INV-000089', 1, '2025-12-21 14:30:46', '2025-12-21 14:30:47', NULL),
(90, 'INV-000090', 2, 2, '2025-12-06', '2026-01-05', 'draft', '84647.54', '5741.38', '0.00', '0.00', '90388.92', '0.00', '90388.92', 'Additional notes for invoice INV-000090', 1, '2025-12-21 14:30:46', '2025-12-21 14:30:46', NULL),
(91, 'INV-000091', 2, 2, '2025-11-16', '2025-12-08', 'cancelled', '26124.15', '1198.13', '66.00', '174.00', '27430.28', '0.00', '0.00', NULL, 1, '2025-12-21 14:30:46', '2025-12-21 14:30:46', NULL),
(92, 'INV-000092', 1, 1, '2025-06-14', '2025-06-28', 'paid', '14364.56', '89.52', '261.00', '60.00', '14253.08', '14253.08', '0.00', 'Additional notes for invoice INV-000092', 1, '2025-12-21 14:30:46', '2025-12-21 14:30:47', NULL),
(93, 'INV-000093', 2, 1, '2025-06-09', '2025-06-29', 'paid', '38344.56', '3377.07', '0.00', '0.00', '41721.63', '41721.63', '0.00', NULL, 1, '2025-12-21 14:30:46', '2025-12-21 14:30:46', NULL),
(94, 'INV-000094', 2, 1, '2025-06-04', '2025-07-03', 'draft', '41710.88', '2473.30', '458.00', '0.00', '43726.18', '0.00', '43726.18', NULL, 1, '2025-12-21 14:30:46', '2025-12-21 14:30:46', NULL),
(95, 'INV-000095', 1, 1, '2025-10-08', '2025-10-19', 'cancelled', '35812.17', '2532.05', '0.00', '0.00', '38344.22', '0.00', '0.00', NULL, 1, '2025-12-21 14:30:46', '2025-12-21 14:30:46', NULL),
(96, 'INV-000096', 1, 3, '2025-07-01', '2025-07-31', 'cancelled', '27018.95', '1291.74', '289.00', '0.00', '28021.69', '0.00', '0.00', 'Additional notes for invoice INV-000096', 1, '2025-12-21 14:30:46', '2025-12-21 14:30:46', NULL),
(97, 'INV-000097', 3, 1, '2025-12-10', '2026-01-02', 'draft', '84795.17', '5830.45', '293.00', '0.00', '90332.62', '0.00', '90332.62', NULL, 1, '2025-12-21 14:30:46', '2025-12-21 14:30:46', NULL),
(98, 'INV-000098', 2, 3, '2025-11-25', '2025-12-02', 'paid', '19579.05', '0.00', '0.00', '99.00', '19678.05', '19678.05', '0.00', NULL, 1, '2025-12-21 14:30:46', '2025-12-21 14:30:46', NULL),
(99, 'INV-000099', 1, 1, '2025-06-16', '2025-06-24', 'cancelled', '48990.22', '2190.96', '144.00', '0.00', '51037.18', '0.00', '0.00', 'Additional notes for invoice INV-000099', 1, '2025-12-21 14:30:46', '2025-12-21 14:30:46', NULL),
(100, 'INV-000100', 3, 1, '2025-07-19', '2025-08-13', 'cancelled', '46859.15', '1824.58', '227.00', '200.00', '48656.73', '0.00', '0.00', NULL, 1, '2025-12-21 14:30:46', '2025-12-21 14:30:46', NULL),
(101, 'INV-000101', 2, 2, '2025-06-09', '2025-07-04', 'cancelled', '27551.16', '2462.41', '191.00', '75.00', '29897.57', '0.00', '0.00', 'Additional notes for invoice INV-000101', 1, '2025-12-21 14:30:46', '2025-12-21 14:30:46', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `sales_items`
--

CREATE TABLE `sales_items` (
  `id` bigint UNSIGNED NOT NULL,
  `sale_id` bigint UNSIGNED NOT NULL,
  `product_id` bigint UNSIGNED NOT NULL,
  `quantity` int NOT NULL,
  `unit_price` decimal(15,2) NOT NULL,
  `discount` decimal(15,2) NOT NULL DEFAULT '0.00',
  `tax` decimal(15,2) NOT NULL DEFAULT '0.00',
  `total` decimal(15,2) NOT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sales_items`
--

INSERT INTO `sales_items` (`id`, `sale_id`, `product_id`, `quantity`, `unit_price`, `discount`, `tax`, `total`, `notes`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 2, '55.00', '0.00', '0.00', '110.00', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(2, 2, 4, 7, '1384.17', '0.00', '1162.70', '10851.89', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(3, 2, 5, 5, '1513.20', '0.00', '151.32', '7717.32', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(4, 2, 6, 9, '3013.65', '406.00', '0.00', '26716.85', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(5, 2, 9, 8, '1118.95', '0.00', '89.52', '9041.12', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(6, 2, 10, 9, '5180.00', '0.00', '2331.00', '48951.00', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(7, 3, 11, 1, '3783.36', '0.00', '454.00', '4237.36', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(8, 4, 3, 6, '3935.88', '0.00', '2125.38', '25740.66', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(9, 4, 4, 9, '1384.17', '63.00', '1487.34', '13881.87', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(10, 4, 12, 1, '902.16', '0.00', '0.00', '902.16', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(11, 5, 5, 5, '1513.20', '405.00', '143.22', '7304.22', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(12, 5, 7, 6, '2332.32', '210.00', '964.87', '14748.79', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(13, 6, 11, 3, '3783.36', '408.00', '1313.05', '12255.13', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(14, 7, 4, 7, '1384.17', '0.00', '1162.70', '10851.89', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(15, 7, 7, 3, '2332.32', '0.00', '489.79', '7486.75', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(16, 7, 8, 4, '4342.40', '0.00', '1389.57', '18759.17', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(17, 7, 9, 4, '1118.95', '62.00', '44.14', '4457.94', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(18, 7, 10, 6, '5180.00', '310.00', '1538.50', '32308.50', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(19, 8, 3, 7, '3935.88', '0.00', '2479.60', '30030.76', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(20, 8, 6, 2, '3013.65', '0.00', '0.00', '6027.30', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(21, 8, 12, 1, '902.16', '239.00', '0.00', '663.16', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(22, 9, 5, 4, '1513.20', '0.00', '121.06', '6173.86', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(23, 9, 7, 2, '2332.32', '0.00', '326.52', '4991.16', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(24, 9, 8, 1, '4342.40', '0.00', '347.39', '4689.79', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(25, 9, 10, 4, '5180.00', '0.00', '1036.00', '21756.00', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(26, 10, 3, 6, '3935.88', '0.00', '2125.38', '25740.66', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(27, 10, 5, 7, '1513.20', '0.00', '211.85', '10804.25', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(28, 10, 7, 9, '2332.32', '0.00', '1469.36', '22460.24', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(29, 10, 8, 10, '4342.40', '118.00', '3464.48', '46770.48', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(30, 11, 3, 6, '3935.88', '0.00', '2125.38', '25740.66', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(31, 11, 11, 2, '3783.36', '480.00', '850.41', '7937.13', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(32, 12, 5, 3, '1513.20', '0.00', '90.79', '4630.39', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(33, 13, 9, 1, '1118.95', '91.00', '10.28', '1038.23', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(34, 13, 11, 6, '3783.36', '459.00', '2668.94', '24910.10', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(35, 14, 3, 3, '3935.88', '457.00', '1021.56', '12372.20', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(36, 14, 9, 8, '1118.95', '0.00', '89.52', '9041.12', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(37, 14, 10, 1, '5180.00', '0.00', '259.00', '5439.00', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(38, 14, 11, 4, '3783.36', '254.00', '1785.53', '16664.97', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(39, 15, 3, 5, '3935.88', '0.00', '1771.15', '21450.55', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(40, 15, 5, 5, '1513.20', '366.00', '144.00', '7344.00', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(41, 15, 9, 6, '1118.95', '0.00', '67.14', '6780.84', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(42, 16, 3, 7, '3935.88', '0.00', '2479.60', '30030.76', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(43, 16, 5, 10, '1513.20', '0.00', '302.64', '15434.64', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(44, 17, 3, 5, '3935.88', '0.00', '1771.15', '21450.55', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(45, 17, 8, 7, '4342.40', '434.00', '2397.02', '32359.82', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(46, 17, 10, 1, '5180.00', '0.00', '259.00', '5439.00', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(47, 18, 4, 6, '1384.17', '0.00', '996.60', '9301.62', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(48, 18, 5, 2, '1513.20', '0.00', '60.53', '3086.93', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(49, 19, 3, 10, '3935.88', '0.00', '3542.29', '42901.09', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(50, 19, 5, 10, '1513.20', '284.00', '296.96', '15144.96', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(51, 19, 7, 10, '2332.32', '0.00', '1632.62', '24955.82', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(52, 19, 10, 6, '5180.00', '395.00', '1534.25', '32219.25', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(53, 20, 3, 5, '3935.88', '0.00', '1771.15', '21450.55', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(54, 20, 4, 10, '1384.17', '0.00', '1661.00', '15502.70', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(55, 20, 8, 5, '4342.40', '0.00', '1736.96', '23448.96', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(56, 20, 10, 1, '5180.00', '0.00', '259.00', '5439.00', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(57, 20, 12, 9, '902.16', '0.00', '0.00', '8119.44', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(58, 21, 3, 2, '3935.88', '0.00', '708.46', '8580.22', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(59, 21, 6, 6, '3013.65', '0.00', '0.00', '18081.90', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(60, 22, 3, 3, '3935.88', '0.00', '1062.69', '12870.33', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(61, 22, 4, 8, '1384.17', '60.00', '1321.60', '12334.96', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(62, 22, 6, 7, '3013.65', '0.00', '0.00', '21095.55', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(63, 22, 10, 8, '5180.00', '0.00', '2072.00', '43512.00', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(64, 22, 11, 9, '3783.36', '0.00', '4086.03', '38136.27', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(65, 23, 3, 8, '3935.88', '148.00', '2820.51', '34159.55', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(66, 23, 5, 8, '1513.20', '418.00', '233.75', '11921.35', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(67, 23, 7, 6, '2332.32', '0.00', '979.57', '14973.49', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(68, 23, 11, 6, '3783.36', '0.00', '2724.02', '25424.18', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(69, 24, 4, 2, '1384.17', '390.00', '285.40', '2663.74', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(70, 24, 5, 2, '1513.20', '332.00', '53.89', '2748.29', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(71, 24, 9, 2, '1118.95', '0.00', '22.38', '2260.28', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(72, 24, 10, 2, '5180.00', '0.00', '518.00', '10878.00', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(73, 24, 11, 4, '3783.36', '360.00', '1772.81', '16546.25', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(74, 25, 3, 10, '3935.88', '0.00', '3542.29', '42901.09', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(75, 25, 4, 7, '1384.17', '0.00', '1162.70', '10851.89', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(76, 25, 8, 9, '4342.40', '0.00', '3126.53', '42208.13', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(77, 25, 11, 8, '3783.36', '214.00', '3606.35', '33659.23', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(78, 25, 12, 8, '902.16', '0.00', '0.00', '7217.28', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(79, 26, 4, 9, '1384.17', '275.00', '1461.90', '13644.43', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(80, 26, 7, 9, '2332.32', '0.00', '1469.36', '22460.24', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(81, 26, 11, 1, '3783.36', '0.00', '454.00', '4237.36', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(82, 27, 3, 1, '3935.88', '479.00', '311.12', '3768.00', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(83, 27, 6, 8, '3013.65', '175.00', '0.00', '23934.20', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(84, 27, 12, 7, '902.16', '158.00', '0.00', '6157.12', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(85, 28, 7, 2, '2332.32', '0.00', '326.52', '4991.16', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(86, 28, 12, 1, '902.16', '0.00', '0.00', '902.16', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(87, 29, 11, 7, '3783.36', '0.00', '3178.02', '29661.54', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(88, 30, 6, 9, '3013.65', '252.00', '0.00', '26870.85', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(89, 30, 9, 7, '1118.95', '140.00', '76.93', '7769.58', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(90, 30, 10, 4, '5180.00', '0.00', '1036.00', '21756.00', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(91, 31, 6, 1, '3013.65', '0.00', '0.00', '3013.65', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(92, 31, 10, 7, '5180.00', '0.00', '1813.00', '38073.00', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(93, 32, 4, 1, '1384.17', '395.00', '118.70', '1107.87', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(94, 32, 12, 5, '902.16', '272.00', '0.00', '4238.80', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(95, 33, 7, 5, '2332.32', '0.00', '816.31', '12477.91', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(96, 33, 11, 5, '3783.36', '500.00', '2210.02', '20626.82', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(97, 34, 3, 6, '3935.88', '0.00', '2125.38', '25740.66', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(98, 34, 9, 5, '1118.95', '0.00', '55.95', '5650.70', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(99, 35, 5, 6, '1513.20', '0.00', '181.58', '9260.78', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(100, 35, 9, 1, '1118.95', '0.00', '11.19', '1130.14', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(101, 36, 4, 1, '1384.17', '0.00', '166.10', '1550.27', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(102, 36, 11, 1, '3783.36', '0.00', '454.00', '4237.36', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(103, 36, 12, 1, '902.16', '0.00', '0.00', '902.16', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(104, 37, 3, 4, '3935.88', '0.00', '1416.92', '17160.44', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(105, 37, 4, 8, '1384.17', '0.00', '1328.80', '12402.16', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(106, 37, 8, 8, '4342.40', '0.00', '2779.14', '37518.34', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(107, 37, 12, 7, '902.16', '119.00', '0.00', '6196.12', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(108, 38, 4, 10, '1384.17', '0.00', '1661.00', '15502.70', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(109, 39, 9, 9, '1118.95', '0.00', '100.71', '10171.26', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(110, 39, 11, 3, '3783.36', '368.00', '1317.85', '12299.93', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(111, 40, 4, 3, '1384.17', '0.00', '498.30', '4650.81', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(112, 40, 5, 8, '1513.20', '0.00', '242.11', '12347.71', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(113, 40, 7, 3, '2332.32', '455.00', '457.94', '6999.90', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(114, 40, 12, 7, '902.16', '472.00', '0.00', '5843.12', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(115, 41, 8, 3, '4342.40', '0.00', '1042.18', '14069.38', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(116, 42, 3, 4, '3935.88', '0.00', '1416.92', '17160.44', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(117, 42, 4, 1, '1384.17', '0.00', '166.10', '1550.27', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(118, 42, 5, 6, '1513.20', '0.00', '181.58', '9260.78', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(119, 42, 11, 1, '3783.36', '0.00', '454.00', '4237.36', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(120, 42, 12, 4, '902.16', '0.00', '0.00', '3608.64', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(121, 43, 5, 1, '1513.20', '0.00', '30.26', '1543.46', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(122, 43, 8, 6, '4342.40', '216.00', '2067.07', '27905.47', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(123, 43, 9, 6, '1118.95', '0.00', '67.14', '6780.84', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(124, 43, 10, 6, '5180.00', '129.00', '1547.55', '32498.55', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(125, 43, 11, 10, '3783.36', '0.00', '4540.03', '42373.63', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(126, 44, 9, 3, '1118.95', '0.00', '33.57', '3390.42', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(127, 44, 10, 3, '5180.00', '0.00', '777.00', '16317.00', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(128, 44, 11, 8, '3783.36', '0.00', '3632.03', '33898.91', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(129, 45, 4, 2, '1384.17', '0.00', '332.20', '3100.54', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(130, 45, 5, 1, '1513.20', '484.00', '20.58', '1049.78', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(131, 45, 7, 1, '2332.32', '282.00', '143.52', '2193.84', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(132, 46, 5, 2, '1513.20', '284.00', '54.85', '2797.25', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(133, 46, 7, 7, '2332.32', '0.00', '1142.84', '17469.08', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(134, 46, 10, 5, '5180.00', '0.00', '1295.00', '27195.00', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(135, 46, 11, 9, '3783.36', '0.00', '4086.03', '38136.27', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(136, 47, 3, 1, '3935.88', '0.00', '354.23', '4290.11', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(137, 47, 5, 2, '1513.20', '0.00', '60.53', '3086.93', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(138, 47, 6, 5, '3013.65', '0.00', '0.00', '15068.25', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(139, 47, 8, 2, '4342.40', '0.00', '694.78', '9379.58', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(140, 48, 3, 4, '3935.88', '0.00', '1416.92', '17160.44', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(141, 48, 4, 9, '1384.17', '0.00', '1494.90', '13952.43', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(142, 48, 9, 9, '1118.95', '0.00', '100.71', '10171.26', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(143, 48, 10, 9, '5180.00', '441.00', '2308.95', '48487.95', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(144, 48, 12, 4, '902.16', '0.00', '0.00', '3608.64', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(145, 49, 3, 1, '3935.88', '0.00', '354.23', '4290.11', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(146, 49, 4, 4, '1384.17', '0.00', '664.40', '6201.08', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(147, 50, 4, 2, '1384.17', '67.00', '324.16', '3025.50', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(148, 50, 6, 8, '3013.65', '343.00', '0.00', '23766.20', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(149, 50, 8, 10, '4342.40', '127.00', '3463.76', '46760.76', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(150, 50, 9, 4, '1118.95', '0.00', '44.76', '4520.56', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(151, 51, 6, 6, '3013.65', '0.00', '0.00', '18081.90', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(152, 51, 7, 7, '2332.32', '0.00', '1142.84', '17469.08', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(153, 51, 8, 2, '4342.40', '0.00', '694.78', '9379.58', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(154, 51, 11, 8, '3783.36', '262.00', '3600.59', '33605.47', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(155, 52, 9, 5, '1118.95', '0.00', '55.95', '5650.70', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(156, 53, 3, 7, '3935.88', '0.00', '2479.60', '30030.76', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(157, 53, 4, 1, '1384.17', '0.00', '166.10', '1550.27', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(158, 53, 5, 9, '1513.20', '462.00', '263.14', '13419.94', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(159, 54, 12, 10, '902.16', '0.00', '0.00', '9021.60', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(160, 55, 3, 4, '3935.88', '0.00', '1416.92', '17160.44', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(161, 55, 5, 7, '1513.20', '332.00', '205.21', '10465.61', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(162, 55, 10, 5, '5180.00', '0.00', '1295.00', '27195.00', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(163, 55, 11, 7, '3783.36', '147.00', '3160.38', '29496.90', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(164, 55, 12, 10, '902.16', '0.00', '0.00', '9021.60', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(165, 56, 3, 3, '3935.88', '0.00', '1062.69', '12870.33', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(166, 56, 5, 6, '1513.20', '409.00', '173.40', '8843.60', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(167, 56, 6, 7, '3013.65', '0.00', '0.00', '21095.55', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(168, 56, 8, 10, '4342.40', '0.00', '3473.92', '46897.92', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(169, 56, 9, 3, '1118.95', '0.00', '33.57', '3390.42', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(170, 57, 4, 7, '1384.17', '0.00', '1162.70', '10851.89', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(171, 57, 7, 9, '2332.32', '0.00', '1469.36', '22460.24', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(172, 57, 9, 2, '1118.95', '0.00', '22.38', '2260.28', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(173, 57, 11, 2, '3783.36', '0.00', '908.01', '8474.73', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(174, 57, 12, 6, '902.16', '410.00', '0.00', '5002.96', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(175, 58, 3, 4, '3935.88', '0.00', '1416.92', '17160.44', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(176, 58, 7, 6, '2332.32', '0.00', '979.57', '14973.49', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(177, 58, 9, 2, '1118.95', '0.00', '22.38', '2260.28', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(178, 59, 3, 6, '3935.88', '482.00', '2082.00', '25215.28', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(179, 59, 5, 3, '1513.20', '257.00', '85.65', '4368.25', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(180, 59, 7, 3, '2332.32', '0.00', '489.79', '7486.75', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(181, 59, 12, 4, '902.16', '0.00', '0.00', '3608.64', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(182, 60, 11, 1, '3783.36', '0.00', '454.00', '4237.36', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(183, 61, 3, 3, '3935.88', '431.00', '1023.90', '12400.54', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(184, 61, 4, 5, '1384.17', '0.00', '830.50', '7751.35', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(185, 61, 6, 7, '3013.65', '0.00', '0.00', '21095.55', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(186, 62, 3, 6, '3935.88', '0.00', '2125.38', '25740.66', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(187, 62, 5, 8, '1513.20', '57.00', '240.97', '12289.57', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(188, 62, 6, 2, '3013.65', '0.00', '0.00', '6027.30', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(189, 62, 7, 9, '2332.32', '0.00', '1469.36', '22460.24', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(190, 62, 8, 2, '4342.40', '0.00', '694.78', '9379.58', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(191, 63, 6, 9, '3013.65', '0.00', '0.00', '27122.85', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(192, 63, 8, 1, '4342.40', '240.00', '328.19', '4430.59', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(193, 64, 5, 9, '1513.20', '0.00', '272.38', '13891.18', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(194, 64, 6, 3, '3013.65', '0.00', '0.00', '9040.95', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(195, 64, 7, 3, '2332.32', '0.00', '489.79', '7486.75', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(196, 64, 12, 8, '902.16', '0.00', '0.00', '7217.28', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(197, 65, 3, 10, '3935.88', '0.00', '3542.29', '42901.09', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(198, 65, 9, 10, '1118.95', '0.00', '111.90', '11301.40', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(199, 65, 11, 3, '3783.36', '0.00', '1362.01', '12712.09', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(200, 66, 3, 8, '3935.88', '0.00', '2833.83', '34320.87', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(201, 67, 10, 6, '5180.00', '167.00', '1545.65', '32458.65', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(202, 68, 4, 4, '1384.17', '0.00', '664.40', '6201.08', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(203, 68, 5, 8, '1513.20', '0.00', '242.11', '12347.71', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(204, 68, 7, 2, '2332.32', '336.00', '303.00', '4631.64', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(205, 68, 10, 8, '5180.00', '0.00', '2072.00', '43512.00', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(206, 68, 11, 2, '3783.36', '52.00', '901.77', '8416.49', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(207, 69, 10, 7, '5180.00', '0.00', '1813.00', '38073.00', NULL, '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(208, 70, 5, 3, '1513.20', '0.00', '90.79', '4630.39', NULL, '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(209, 70, 11, 7, '3783.36', '0.00', '3178.02', '29661.54', NULL, '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(210, 71, 3, 8, '3935.88', '0.00', '2833.83', '34320.87', NULL, '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(211, 71, 8, 5, '4342.40', '0.00', '1736.96', '23448.96', NULL, '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(212, 71, 9, 4, '1118.95', '0.00', '44.76', '4520.56', NULL, '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(213, 71, 10, 3, '5180.00', '0.00', '777.00', '16317.00', NULL, '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(214, 71, 11, 6, '3783.36', '173.00', '2703.26', '25230.42', NULL, '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(215, 72, 11, 3, '3783.36', '0.00', '1362.01', '12712.09', NULL, '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(216, 73, 11, 1, '3783.36', '0.00', '454.00', '4237.36', NULL, '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(217, 74, 5, 7, '1513.20', '0.00', '211.85', '10804.25', NULL, '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(218, 75, 6, 6, '3013.65', '378.00', '0.00', '17703.90', NULL, '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(219, 75, 8, 1, '4342.40', '0.00', '347.39', '4689.79', NULL, '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(220, 75, 10, 9, '5180.00', '0.00', '2331.00', '48951.00', NULL, '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(221, 76, 3, 5, '3935.88', '0.00', '1771.15', '21450.55', NULL, '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(222, 76, 5, 4, '1513.20', '0.00', '121.06', '6173.86', NULL, '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(223, 76, 10, 2, '5180.00', '0.00', '518.00', '10878.00', NULL, '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(224, 76, 11, 10, '3783.36', '0.00', '4540.03', '42373.63', NULL, '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(225, 76, 12, 4, '902.16', '126.00', '0.00', '3482.64', NULL, '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(226, 77, 3, 1, '3935.88', '0.00', '354.23', '4290.11', NULL, '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(227, 77, 9, 6, '1118.95', '0.00', '67.14', '6780.84', NULL, '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(228, 77, 10, 6, '5180.00', '0.00', '1554.00', '32634.00', NULL, '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(229, 77, 11, 10, '3783.36', '0.00', '4540.03', '42373.63', NULL, '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(230, 78, 7, 1, '2332.32', '365.00', '137.71', '2105.03', NULL, '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(231, 78, 8, 10, '4342.40', '346.00', '3446.24', '46524.24', NULL, '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(232, 78, 9, 5, '1118.95', '0.00', '55.95', '5650.70', NULL, '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(233, 79, 5, 4, '1513.20', '0.00', '121.06', '6173.86', NULL, '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(234, 79, 7, 5, '2332.32', '214.00', '801.33', '12248.93', NULL, '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(235, 79, 10, 9, '5180.00', '0.00', '2331.00', '48951.00', NULL, '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(236, 79, 12, 6, '902.16', '0.00', '0.00', '5412.96', NULL, '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(237, 80, 10, 4, '5180.00', '0.00', '1036.00', '21756.00', NULL, '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(238, 81, 5, 2, '1513.20', '489.00', '50.75', '2588.15', NULL, '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(239, 81, 12, 7, '902.16', '0.00', '0.00', '6315.12', NULL, '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(240, 82, 8, 5, '4342.40', '0.00', '1736.96', '23448.96', NULL, '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(241, 83, 4, 4, '1384.17', '0.00', '664.40', '6201.08', NULL, '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(242, 83, 6, 1, '3013.65', '95.00', '0.00', '2918.65', NULL, '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(243, 84, 8, 10, '4342.40', '0.00', '3473.92', '46897.92', NULL, '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(244, 85, 3, 6, '3935.88', '0.00', '2125.38', '25740.66', NULL, '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(245, 85, 6, 5, '3013.65', '0.00', '0.00', '15068.25', NULL, '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(246, 86, 5, 5, '1513.20', '78.00', '149.76', '7637.76', NULL, '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(247, 86, 7, 5, '2332.32', '0.00', '816.31', '12477.91', NULL, '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(248, 86, 10, 8, '5180.00', '111.00', '2066.45', '43395.45', NULL, '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(249, 86, 11, 2, '3783.36', '435.00', '855.81', '7987.53', NULL, '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(250, 87, 4, 9, '1384.17', '0.00', '1494.90', '13952.43', NULL, '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(251, 87, 6, 10, '3013.65', '0.00', '0.00', '30136.50', NULL, '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(252, 87, 9, 6, '1118.95', '0.00', '67.14', '6780.84', NULL, '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(253, 87, 12, 5, '902.16', '0.00', '0.00', '4510.80', NULL, '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(254, 88, 4, 2, '1384.17', '0.00', '332.20', '3100.54', NULL, '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(255, 88, 5, 5, '1513.20', '208.00', '147.16', '7505.16', NULL, '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(256, 88, 6, 3, '3013.65', '0.00', '0.00', '9040.95', NULL, '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(257, 88, 11, 9, '3783.36', '69.00', '4077.75', '38058.99', NULL, '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(258, 88, 12, 6, '902.16', '0.00', '0.00', '5412.96', NULL, '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(259, 89, 6, 3, '3013.65', '0.00', '0.00', '9040.95', NULL, '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(260, 89, 7, 1, '2332.32', '0.00', '163.26', '2495.58', NULL, '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(261, 89, 11, 4, '3783.36', '86.00', '1805.69', '16853.13', NULL, '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(262, 89, 12, 8, '902.16', '0.00', '0.00', '7217.28', NULL, '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(263, 90, 4, 2, '1384.17', '0.00', '332.20', '3100.54', NULL, '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(264, 90, 5, 10, '1513.20', '0.00', '302.64', '15434.64', NULL, '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(265, 90, 7, 10, '2332.32', '0.00', '1632.62', '24955.82', NULL, '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(266, 90, 8, 10, '4342.40', '0.00', '3473.92', '46897.92', NULL, '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(267, 91, 5, 2, '1513.20', '0.00', '60.53', '3086.93', NULL, '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(268, 91, 8, 3, '4342.40', '66.00', '1036.90', '13998.10', NULL, '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(269, 91, 9, 9, '1118.95', '0.00', '100.71', '10171.26', NULL, '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(270, 92, 9, 8, '1118.95', '0.00', '89.52', '9041.12', NULL, '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(271, 92, 12, 6, '902.16', '261.00', '0.00', '5151.96', NULL, '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(272, 93, 7, 4, '2332.32', '0.00', '653.05', '9982.33', NULL, '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(273, 93, 11, 6, '3783.36', '0.00', '2724.02', '25424.18', NULL, '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(274, 93, 12, 7, '902.16', '0.00', '0.00', '6315.12', NULL, '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(275, 94, 7, 9, '2332.32', '458.00', '1437.30', '21970.18', NULL, '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(276, 94, 10, 4, '5180.00', '0.00', '1036.00', '21756.00', NULL, '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(277, 95, 3, 3, '3935.88', '0.00', '1062.69', '12870.33', NULL, '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(278, 95, 6, 1, '3013.65', '0.00', '0.00', '3013.65', NULL, '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(279, 95, 7, 9, '2332.32', '0.00', '1469.36', '22460.24', NULL, '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(280, 96, 9, 1, '1118.95', '0.00', '11.19', '1130.14', NULL, '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(281, 96, 10, 5, '5180.00', '289.00', '1280.55', '26891.55', NULL, '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(282, 97, 4, 7, '1384.17', '293.00', '1127.54', '10523.73', NULL, '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(283, 97, 8, 9, '4342.40', '0.00', '3126.53', '42208.13', NULL, '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(284, 97, 9, 2, '1118.95', '0.00', '22.38', '2260.28', NULL, '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(285, 97, 10, 6, '5180.00', '0.00', '1554.00', '32634.00', NULL, '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(286, 97, 12, 3, '902.16', '0.00', '0.00', '2706.48', NULL, '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(287, 98, 6, 5, '3013.65', '0.00', '0.00', '15068.25', NULL, '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(288, 98, 12, 5, '902.16', '0.00', '0.00', '4510.80', NULL, '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(289, 99, 6, 6, '3013.65', '144.00', '0.00', '17937.90', NULL, '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(290, 99, 8, 5, '4342.40', '0.00', '1736.96', '23448.96', NULL, '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(291, 99, 11, 1, '3783.36', '0.00', '454.00', '4237.36', NULL, '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(292, 99, 12, 6, '902.16', '0.00', '0.00', '5412.96', NULL, '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(293, 100, 3, 3, '3935.88', '227.00', '1042.26', '12622.90', NULL, '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(294, 100, 5, 9, '1513.20', '0.00', '272.38', '13891.18', NULL, '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(295, 100, 6, 4, '3013.65', '0.00', '0.00', '12054.60', NULL, '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(296, 100, 9, 5, '1118.95', '0.00', '55.95', '5650.70', NULL, '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(297, 100, 11, 1, '3783.36', '0.00', '454.00', '4237.36', NULL, '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(298, 101, 3, 7, '3935.88', '191.00', '2462.41', '29822.57', NULL, '2025-12-21 14:30:46', '2025-12-21 14:30:46');

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `settings`
--

CREATE TABLE `settings` (
  `id` bigint UNSIGNED NOT NULL,
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` text COLLATE utf8mb4_unicode_ci,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'text',
  `group` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'general',
  `description` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `settings`
--

INSERT INTO `settings` (`id`, `key`, `value`, `type`, `group`, `description`, `created_at`, `updated_at`) VALUES
(1, 'site_name', 'SMS', 'text', 'general', NULL, '2025-12-21 14:30:44', '2025-12-21 14:30:44'),
(2, 'logo', '', 'image', 'branding', NULL, '2025-12-21 14:30:44', '2025-12-21 14:30:44'),
(3, 'powered_by_text', 'Powered By CPB-IT', 'text', 'footer', NULL, '2025-12-21 14:30:44', '2025-12-21 14:30:44'),
(4, 'version', 'v1.0', 'text', 'footer', NULL, '2025-12-21 14:30:44', '2025-12-21 14:30:44'),
(5, 'copyright_text', 'All Rights Reserved', 'text', 'footer', NULL, '2025-12-21 14:30:44', '2025-12-21 14:30:44');

-- --------------------------------------------------------

--
-- Table structure for table `stocks`
--

CREATE TABLE `stocks` (
  `id` bigint UNSIGNED NOT NULL,
  `product_id` bigint UNSIGNED NOT NULL,
  `warehouse_id` bigint UNSIGNED NOT NULL,
  `quantity` int NOT NULL DEFAULT '0',
  `average_cost` decimal(15,2) NOT NULL DEFAULT '0.00',
  `total_value` decimal(15,2) NOT NULL DEFAULT '0.00',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `stocks`
--

INSERT INTO `stocks` (`id`, `product_id`, `warehouse_id`, `quantity`, `average_cost`, `total_value`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 570, '44.24', '25219.35', '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(2, 2, 1, 450, '125.06', '56275.20', '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(3, 1, 2, 688, '43.34', '29816.55', '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(4, 2, 2, 491, '116.95', '57424.80', '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(5, 1, 3, 304, '42.64', '12962.70', '2025-12-21 14:30:45', '2025-12-21 14:30:45'),
(6, 2, 3, 351, '118.77', '41689.20', '2025-12-21 14:30:45', '2025-12-21 14:30:45');

-- --------------------------------------------------------

--
-- Table structure for table `stock_ledgers`
--

CREATE TABLE `stock_ledgers` (
  `id` bigint UNSIGNED NOT NULL,
  `product_id` bigint UNSIGNED NOT NULL,
  `warehouse_id` bigint UNSIGNED NOT NULL,
  `type` enum('in','out') COLLATE utf8mb4_unicode_ci NOT NULL,
  `reference_type` enum('purchase','sales','return','damage','lost') COLLATE utf8mb4_unicode_ci NOT NULL,
  `reference_id` bigint UNSIGNED DEFAULT NULL,
  `reference_number` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `quantity` int NOT NULL,
  `unit_cost` decimal(15,2) NOT NULL DEFAULT '0.00',
  `weighted_avg_cost` decimal(15,2) NOT NULL DEFAULT '0.00',
  `cost_method` enum('fifo','lifo','wavg') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'wavg',
  `total_cost` decimal(15,2) NOT NULL DEFAULT '0.00',
  `balance_after` int NOT NULL DEFAULT '0',
  `value_before` decimal(15,2) NOT NULL DEFAULT '0.00',
  `value_after` decimal(15,2) NOT NULL DEFAULT '0.00',
  `notes` text COLLATE utf8mb4_unicode_ci,
  `created_by` bigint UNSIGNED DEFAULT NULL,
  `transaction_date` date NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `stock_ledgers`
--

INSERT INTO `stock_ledgers` (`id`, `product_id`, `warehouse_id`, `type`, `reference_type`, `reference_id`, `reference_number`, `quantity`, `unit_cost`, `weighted_avg_cost`, `cost_method`, `total_cost`, `balance_after`, `value_before`, `value_after`, `notes`, `created_by`, `transaction_date`, `created_at`, `updated_at`) VALUES
(1, 2, 3, 'in', 'purchase', 1, 'PO-000001', 81, '132.00', '121.25', 'wavg', '10692.00', 432, '41689.20', '52381.20', 'Stock in from purchase PO-000001', 1, '2025-09-07', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(2, 1, 1, 'in', 'purchase', 2, 'PO-000002', 88, '47.70', '44.71', 'wavg', '4197.60', 658, '25219.35', '29416.95', 'Stock in from purchase PO-000002', 1, '2025-09-20', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(3, 2, 1, 'in', 'purchase', 2, 'PO-000002', 96, '127.20', '125.43', 'wavg', '12211.20', 546, '56275.20', '68486.40', 'Stock in from purchase PO-000002', 1, '2025-09-20', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(4, 1, 1, 'in', 'purchase', 3, 'PO-000003', 97, '40.95', '43.77', 'wavg', '3972.15', 667, '25219.35', '29191.50', 'Stock in from purchase PO-000003', 1, '2025-08-13', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(5, 1, 2, 'in', 'purchase', 4, 'PO-000004', 57, '40.95', '43.16', 'wavg', '2334.15', 745, '29816.55', '32150.70', 'Stock in from purchase PO-000004', 1, '2025-07-26', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(6, 2, 2, 'in', 'purchase', 4, 'PO-000004', 83, '117.60', '117.05', 'wavg', '9760.80', 574, '57424.80', '67185.60', 'Stock in from purchase PO-000004', 1, '2025-07-26', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(7, 1, 2, 'in', 'purchase', 5, 'PO-000005', 87, '43.20', '43.32', 'wavg', '3758.40', 775, '29816.55', '33574.95', 'Stock in from purchase PO-000005', 1, '2025-10-21', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(8, 2, 2, 'in', 'purchase', 5, 'PO-000005', 14, '122.40', '117.11', 'wavg', '1713.60', 505, '57424.80', '59138.40', 'Stock in from purchase PO-000005', 1, '2025-10-21', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(9, 2, 2, 'in', 'purchase', 6, 'PO-000006', 75, '112.80', '116.40', 'wavg', '8460.00', 566, '57424.80', '65884.80', 'Stock in from purchase PO-000006', 1, '2025-10-04', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(10, 1, 3, 'in', 'purchase', 7, 'PO-000007', 18, '46.35', '42.85', 'wavg', '834.30', 322, '12962.70', '13797.00', 'Stock in from purchase PO-000007', 1, '2025-11-15', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(11, 2, 3, 'in', 'purchase', 7, 'PO-000007', 58, '124.80', '119.63', 'wavg', '7238.40', 409, '41689.20', '48927.60', 'Stock in from purchase PO-000007', 1, '2025-11-15', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(12, 1, 2, 'in', 'purchase', 8, 'PO-000008', 97, '40.50', '42.99', 'wavg', '3928.50', 785, '29816.55', '33745.05', 'Stock in from purchase PO-000008', 1, '2025-11-27', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(13, 2, 2, 'in', 'purchase', 8, 'PO-000008', 33, '111.60', '116.62', 'wavg', '3682.80', 524, '57424.80', '61107.60', 'Stock in from purchase PO-000008', 1, '2025-11-27', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(14, 2, 1, 'in', 'purchase', 9, 'PO-000009', 20, '110.40', '124.43', 'wavg', '2208.00', 470, '56275.20', '58483.20', 'Stock in from purchase PO-000009', 1, '2025-09-16', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(15, 1, 3, 'in', 'purchase', 10, 'PO-000010', 32, '45.90', '42.95', 'wavg', '1468.80', 336, '12962.70', '14431.50', 'Stock in from purchase PO-000010', 1, '2025-11-02', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(16, 2, 3, 'in', 'purchase', 10, 'PO-000010', 37, '130.80', '119.92', 'wavg', '4839.60', 388, '41689.20', '46528.80', 'Stock in from purchase PO-000010', 1, '2025-11-02', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(17, 1, 3, 'in', 'purchase', 11, 'PO-000011', 28, '44.55', '42.80', 'wavg', '1247.40', 332, '12962.70', '14210.10', 'Stock in from purchase PO-000011', 1, '2025-07-22', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(18, 2, 3, 'in', 'purchase', 11, 'PO-000011', 94, '110.40', '117.00', 'wavg', '10377.60', 445, '41689.20', '52066.80', 'Stock in from purchase PO-000011', 1, '2025-07-22', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(19, 1, 2, 'in', 'purchase', 12, 'PO-000012', 77, '47.70', '43.78', 'wavg', '3672.90', 765, '29816.55', '33489.45', 'Stock in from purchase PO-000012', 1, '2025-08-31', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(20, 1, 2, 'in', 'purchase', 13, 'PO-000013', 44, '42.75', '43.30', 'wavg', '1881.00', 732, '29816.55', '31697.55', 'Stock in from purchase PO-000013', 1, '2025-12-01', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(21, 2, 2, 'in', 'purchase', 13, 'PO-000013', 41, '126.00', '117.65', 'wavg', '5166.00', 532, '57424.80', '62590.80', 'Stock in from purchase PO-000013', 1, '2025-12-01', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(22, 1, 1, 'in', 'purchase', 14, 'PO-000014', 49, '42.30', '44.09', 'wavg', '2072.70', 619, '25219.35', '27292.05', 'Stock in from purchase PO-000014', 1, '2025-12-02', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(23, 1, 2, 'in', 'purchase', 15, 'PO-000015', 72, '49.50', '43.92', 'wavg', '3564.00', 760, '29816.55', '33380.55', 'Stock in from purchase PO-000015', 1, '2025-10-25', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(24, 2, 2, 'in', 'purchase', 15, 'PO-000015', 65, '116.40', '116.89', 'wavg', '7566.00', 556, '57424.80', '64990.80', 'Stock in from purchase PO-000015', 1, '2025-10-25', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(25, 1, 2, 'in', 'purchase', 16, 'PO-000016', 74, '43.65', '43.37', 'wavg', '3230.10', 762, '29816.55', '33046.65', 'Stock in from purchase PO-000016', 1, '2025-11-21', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(26, 1, 3, 'in', 'purchase', 17, 'PO-000017', 11, '48.60', '42.85', 'wavg', '534.60', 315, '12962.70', '13497.30', 'Stock in from purchase PO-000017', 1, '2025-07-22', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(27, 2, 3, 'in', 'purchase', 18, 'PO-000018', 88, '114.00', '117.82', 'wavg', '10032.00', 439, '41689.20', '51721.20', 'Stock in from purchase PO-000018', 1, '2025-11-03', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(28, 1, 3, 'in', 'purchase', 19, 'PO-000019', 97, '46.80', '43.65', 'wavg', '4539.60', 401, '12962.70', '17502.30', 'Stock in from purchase PO-000019', 1, '2025-12-07', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(29, 2, 1, 'in', 'purchase', 20, 'PO-000020', 81, '123.60', '124.83', 'wavg', '10011.60', 531, '56275.20', '66286.80', 'Stock in from purchase PO-000020', 1, '2025-07-16', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(30, 1, 3, 'in', 'purchase', 21, 'PO-000021', 54, '42.75', '42.66', 'wavg', '2308.50', 358, '12962.70', '15271.20', 'Stock in from purchase PO-000021', 1, '2025-09-24', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(31, 1, 1, 'in', 'purchase', 22, 'PO-000022', 90, '41.85', '43.92', 'wavg', '3766.50', 660, '25219.35', '28985.85', 'Stock in from purchase PO-000022', 1, '2025-11-04', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(32, 2, 1, 'in', 'purchase', 22, 'PO-000022', 77, '122.40', '124.67', 'wavg', '9424.80', 527, '56275.20', '65700.00', 'Stock in from purchase PO-000022', 1, '2025-11-04', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(33, 1, 2, 'in', 'purchase', 23, 'PO-000023', 87, '41.85', '43.17', 'wavg', '3640.95', 775, '29816.55', '33457.50', 'Stock in from purchase PO-000023', 1, '2025-11-20', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(34, 2, 2, 'in', 'purchase', 23, 'PO-000023', 22, '128.40', '117.45', 'wavg', '2824.80', 513, '57424.80', '60249.60', 'Stock in from purchase PO-000023', 1, '2025-11-20', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(35, 1, 2, 'in', 'purchase', 24, 'PO-000024', 77, '48.60', '43.87', 'wavg', '3742.20', 765, '29816.55', '33558.75', 'Stock in from purchase PO-000024', 1, '2025-09-30', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(36, 2, 2, 'in', 'purchase', 24, 'PO-000024', 24, '111.60', '116.71', 'wavg', '2678.40', 515, '57424.80', '60103.20', 'Stock in from purchase PO-000024', 1, '2025-09-30', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(37, 2, 3, 'in', 'purchase', 25, 'PO-000025', 28, '120.00', '118.86', 'wavg', '3360.00', 379, '41689.20', '45049.20', 'Stock in from purchase PO-000025', 1, '2025-08-15', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(38, 1, 2, 'in', 'purchase', 26, 'PO-000026', 29, '49.05', '43.57', 'wavg', '1422.45', 717, '29816.55', '31239.00', 'Stock in from purchase PO-000026', 1, '2025-08-04', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(39, 2, 2, 'in', 'purchase', 26, 'PO-000026', 83, '132.00', '119.13', 'wavg', '10956.00', 574, '57424.80', '68380.80', 'Stock in from purchase PO-000026', 1, '2025-08-04', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(40, 1, 2, 'in', 'purchase', 27, 'PO-000027', 72, '41.85', '43.20', 'wavg', '3013.20', 760, '29816.55', '32829.75', 'Stock in from purchase PO-000027', 1, '2025-08-30', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(41, 1, 2, 'in', 'purchase', 28, 'PO-000028', 54, '41.85', '43.23', 'wavg', '2259.90', 742, '29816.55', '32076.45', 'Stock in from purchase PO-000028', 1, '2025-06-29', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(42, 2, 2, 'in', 'purchase', 28, 'PO-000028', 21, '114.00', '116.83', 'wavg', '2394.00', 512, '57424.80', '59818.80', 'Stock in from purchase PO-000028', 1, '2025-06-29', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(43, 1, 3, 'in', 'purchase', 29, 'PO-000029', 40, '45.90', '43.02', 'wavg', '1836.00', 344, '12962.70', '14798.70', 'Stock in from purchase PO-000029', 1, '2025-06-05', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(44, 2, 3, 'in', 'purchase', 29, 'PO-000029', 73, '114.00', '117.95', 'wavg', '8322.00', 424, '41689.20', '50011.20', 'Stock in from purchase PO-000029', 1, '2025-06-05', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(45, 2, 3, 'in', 'purchase', 30, 'PO-000030', 74, '116.40', '118.36', 'wavg', '8613.60', 425, '41689.20', '50302.80', 'Stock in from purchase PO-000030', 1, '2025-09-21', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(46, 1, 2, 'in', 'purchase', 31, 'PO-000031', 79, '42.75', '43.28', 'wavg', '3377.25', 767, '29816.55', '33193.80', 'Stock in from purchase PO-000031', 1, '2025-10-16', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(47, 2, 2, 'in', 'purchase', 31, 'PO-000031', 79, '117.60', '117.04', 'wavg', '9290.40', 570, '57424.80', '66715.20', 'Stock in from purchase PO-000031', 1, '2025-10-16', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(48, 1, 1, 'in', 'purchase', 32, 'PO-000032', 56, '49.05', '44.67', 'wavg', '2746.80', 626, '25219.35', '27966.15', 'Stock in from purchase PO-000032', 1, '2025-10-19', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(49, 2, 1, 'in', 'purchase', 32, 'PO-000032', 42, '132.00', '125.65', 'wavg', '5544.00', 492, '56275.20', '61819.20', 'Stock in from purchase PO-000032', 1, '2025-10-19', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(50, 1, 1, 'in', 'purchase', 33, 'PO-000033', 71, '42.30', '44.03', 'wavg', '3003.30', 641, '25219.35', '28222.65', 'Stock in from purchase PO-000033', 1, '2025-09-07', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(51, 1, 1, 'in', 'purchase', 34, 'PO-000034', 46, '48.15', '44.54', 'wavg', '2214.90', 616, '25219.35', '27434.25', 'Stock in from purchase PO-000034', 1, '2025-08-03', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(52, 1, 1, 'in', 'purchase', 35, 'PO-000035', 11, '43.65', '44.23', 'wavg', '480.15', 581, '25219.35', '25699.50', 'Stock in from purchase PO-000035', 1, '2025-09-27', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(53, 1, 3, 'in', 'purchase', 36, 'PO-000036', 55, '41.85', '42.52', 'wavg', '2301.75', 359, '12962.70', '15264.45', 'Stock in from purchase PO-000036', 1, '2025-10-11', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(54, 2, 3, 'in', 'purchase', 36, 'PO-000036', 53, '126.00', '119.72', 'wavg', '6678.00', 404, '41689.20', '48367.20', 'Stock in from purchase PO-000036', 1, '2025-10-11', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(55, 1, 2, 'in', 'purchase', 37, 'PO-000037', 69, '40.50', '43.08', 'wavg', '2794.50', 757, '29816.55', '32611.05', 'Stock in from purchase PO-000037', 1, '2025-07-30', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(56, 2, 2, 'in', 'purchase', 37, 'PO-000037', 15, '120.00', '117.05', 'wavg', '1800.00', 506, '57424.80', '59224.80', 'Stock in from purchase PO-000037', 1, '2025-07-30', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(57, 1, 2, 'in', 'purchase', 38, 'PO-000038', 50, '42.75', '43.30', 'wavg', '2137.50', 738, '29816.55', '31954.05', 'Stock in from purchase PO-000038', 1, '2025-05-28', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(58, 2, 2, 'in', 'purchase', 38, 'PO-000038', 37, '108.00', '116.33', 'wavg', '3996.00', 528, '57424.80', '61420.80', 'Stock in from purchase PO-000038', 1, '2025-05-28', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(59, 2, 3, 'in', 'purchase', 39, 'PO-000039', 97, '116.40', '118.26', 'wavg', '11290.80', 448, '41689.20', '52980.00', 'Stock in from purchase PO-000039', 1, '2025-10-10', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(60, 1, 2, 'in', 'purchase', 40, 'PO-000040', 94, '42.30', '43.21', 'wavg', '3976.20', 782, '29816.55', '33792.75', 'Stock in from purchase PO-000040', 1, '2025-10-01', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(61, 2, 1, 'in', 'purchase', 41, 'PO-000041', 53, '130.80', '125.66', 'wavg', '6932.40', 503, '56275.20', '63207.60', 'Stock in from purchase PO-000041', 1, '2025-10-31', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(62, 2, 2, 'in', 'purchase', 42, 'PO-000042', 53, '129.60', '118.19', 'wavg', '6868.80', 544, '57424.80', '64293.60', 'Stock in from purchase PO-000042', 1, '2025-09-26', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(63, 1, 3, 'in', 'purchase', 43, 'PO-000043', 81, '43.20', '42.76', 'wavg', '3499.20', 385, '12962.70', '16461.90', 'Stock in from purchase PO-000043', 1, '2025-11-23', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(64, 2, 3, 'in', 'purchase', 43, 'PO-000043', 14, '111.60', '118.50', 'wavg', '1562.40', 365, '41689.20', '43251.60', 'Stock in from purchase PO-000043', 1, '2025-11-23', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(65, 1, 3, 'in', 'purchase', 44, 'PO-000044', 72, '46.35', '43.35', 'wavg', '3337.20', 376, '12962.70', '16299.90', 'Stock in from purchase PO-000044', 1, '2025-06-01', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(66, 2, 3, 'in', 'purchase', 44, 'PO-000044', 45, '128.40', '119.87', 'wavg', '5778.00', 396, '41689.20', '47467.20', 'Stock in from purchase PO-000044', 1, '2025-06-01', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(67, 2, 2, 'in', 'purchase', 45, 'PO-000045', 94, '117.60', '117.06', 'wavg', '11054.40', 585, '57424.80', '68479.20', 'Stock in from purchase PO-000045', 1, '2025-09-19', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(68, 1, 2, 'in', 'purchase', 46, 'PO-000046', 70, '47.70', '43.74', 'wavg', '3339.00', 758, '29816.55', '33155.55', 'Stock in from purchase PO-000046', 1, '2025-06-20', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(69, 2, 2, 'in', 'purchase', 46, 'PO-000046', 76, '132.00', '118.97', 'wavg', '10032.00', 567, '57424.80', '67456.80', 'Stock in from purchase PO-000046', 1, '2025-06-20', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(70, 2, 2, 'in', 'purchase', 47, 'PO-000047', 76, '128.40', '118.49', 'wavg', '9758.40', 567, '57424.80', '67183.20', 'Stock in from purchase PO-000047', 1, '2025-11-07', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(71, 1, 1, 'in', 'purchase', 48, 'PO-000048', 19, '48.60', '44.38', 'wavg', '923.40', 589, '25219.35', '26142.75', 'Stock in from purchase PO-000048', 1, '2025-06-07', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(72, 2, 1, 'in', 'purchase', 48, 'PO-000048', 15, '117.60', '124.82', 'wavg', '1764.00', 465, '56275.20', '58039.20', 'Stock in from purchase PO-000048', 1, '2025-06-07', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(73, 1, 1, 'in', 'purchase', 49, 'PO-000049', 23, '40.95', '44.12', 'wavg', '941.85', 593, '25219.35', '26161.20', 'Stock in from purchase PO-000049', 1, '2025-07-28', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(74, 2, 1, 'in', 'purchase', 49, 'PO-000049', 99, '128.40', '125.66', 'wavg', '12711.60', 549, '56275.20', '68986.80', 'Stock in from purchase PO-000049', 1, '2025-07-28', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(75, 1, 3, 'in', 'purchase', 50, 'PO-000050', 75, '40.95', '42.31', 'wavg', '3071.25', 379, '12962.70', '16033.95', 'Stock in from purchase PO-000050', 1, '2025-11-24', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(76, 2, 3, 'in', 'purchase', 50, 'PO-000050', 74, '130.80', '120.87', 'wavg', '9679.20', 425, '41689.20', '51368.40', 'Stock in from purchase PO-000050', 1, '2025-11-24', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(77, 1, 1, 'out', 'sales', 1, 'INV-0001', 2, '44.24', '44.24', 'wavg', '88.48', 568, '25219.35', '25130.87', 'Stock out from sale INV-0001', 1, '2025-12-21', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(78, 4, 1, 'out', 'sales', 2, 'INV-000002', 7, '1247.00', '1247.00', 'wavg', '8729.00', 0, '0.00', '0.00', 'Stock out from sale INV-000002', 1, '2025-11-02', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(79, 5, 1, 'out', 'sales', 2, 'INV-000002', 5, '1261.00', '1261.00', 'wavg', '6305.00', 0, '0.00', '0.00', 'Stock out from sale INV-000002', 1, '2025-11-02', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(80, 6, 1, 'out', 'sales', 2, 'INV-000002', 9, '2715.00', '2715.00', 'wavg', '24435.00', 0, '0.00', '0.00', 'Stock out from sale INV-000002', 1, '2025-11-02', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(81, 9, 1, 'out', 'sales', 2, 'INV-000002', 8, '973.00', '973.00', 'wavg', '7784.00', 0, '0.00', '0.00', 'Stock out from sale INV-000002', 1, '2025-11-02', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(82, 10, 1, 'out', 'sales', 2, 'INV-000002', 9, '4144.00', '4144.00', 'wavg', '37296.00', 0, '0.00', '0.00', 'Stock out from sale INV-000002', 1, '2025-11-02', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(83, 11, 1, 'out', 'sales', 3, 'INV-000003', 1, '3378.00', '3378.00', 'wavg', '3378.00', 0, '0.00', '0.00', 'Stock out from sale INV-000003', 1, '2025-08-23', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(84, 3, 2, 'out', 'sales', 4, 'INV-000004', 6, '3364.00', '3364.00', 'wavg', '20184.00', 0, '0.00', '0.00', 'Stock out from sale INV-000004', 1, '2025-11-29', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(85, 4, 2, 'out', 'sales', 4, 'INV-000004', 9, '1247.00', '1247.00', 'wavg', '11223.00', 0, '0.00', '0.00', 'Stock out from sale INV-000004', 1, '2025-11-29', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(86, 12, 2, 'out', 'sales', 4, 'INV-000004', 1, '716.00', '716.00', 'wavg', '716.00', 0, '0.00', '0.00', 'Stock out from sale INV-000004', 1, '2025-11-29', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(87, 5, 2, 'out', 'sales', 5, 'INV-000005', 5, '1261.00', '1261.00', 'wavg', '6305.00', 0, '0.00', '0.00', 'Stock out from sale INV-000005', 1, '2025-10-02', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(88, 7, 2, 'out', 'sales', 5, 'INV-000005', 6, '1808.00', '1808.00', 'wavg', '10848.00', 0, '0.00', '0.00', 'Stock out from sale INV-000005', 1, '2025-10-02', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(89, 11, 1, 'out', 'sales', 6, 'INV-000006', 3, '3378.00', '3378.00', 'wavg', '10134.00', 0, '0.00', '0.00', 'Stock out from sale INV-000006', 1, '2025-12-19', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(90, 4, 3, 'out', 'sales', 7, 'INV-000007', 7, '1247.00', '1247.00', 'wavg', '8729.00', 0, '0.00', '0.00', 'Stock out from sale INV-000007', 1, '2025-06-25', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(91, 7, 3, 'out', 'sales', 7, 'INV-000007', 3, '1808.00', '1808.00', 'wavg', '5424.00', 0, '0.00', '0.00', 'Stock out from sale INV-000007', 1, '2025-06-25', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(92, 8, 3, 'out', 'sales', 7, 'INV-000007', 4, '3776.00', '3776.00', 'wavg', '15104.00', 0, '0.00', '0.00', 'Stock out from sale INV-000007', 1, '2025-06-25', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(93, 9, 3, 'out', 'sales', 7, 'INV-000007', 4, '973.00', '973.00', 'wavg', '3892.00', 0, '0.00', '0.00', 'Stock out from sale INV-000007', 1, '2025-06-25', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(94, 10, 3, 'out', 'sales', 7, 'INV-000007', 6, '4144.00', '4144.00', 'wavg', '24864.00', 0, '0.00', '0.00', 'Stock out from sale INV-000007', 1, '2025-06-25', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(95, 3, 3, 'out', 'sales', 8, 'INV-000008', 7, '3364.00', '3364.00', 'wavg', '23548.00', 0, '0.00', '0.00', 'Stock out from sale INV-000008', 1, '2025-12-07', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(96, 6, 3, 'out', 'sales', 8, 'INV-000008', 2, '2715.00', '2715.00', 'wavg', '5430.00', 0, '0.00', '0.00', 'Stock out from sale INV-000008', 1, '2025-12-07', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(97, 12, 3, 'out', 'sales', 8, 'INV-000008', 1, '716.00', '716.00', 'wavg', '716.00', 0, '0.00', '0.00', 'Stock out from sale INV-000008', 1, '2025-12-07', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(98, 5, 2, 'out', 'sales', 9, 'INV-000009', 4, '1261.00', '1261.00', 'wavg', '5044.00', 0, '0.00', '0.00', 'Stock out from sale INV-000009', 1, '2025-10-29', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(99, 7, 2, 'out', 'sales', 9, 'INV-000009', 2, '1808.00', '1808.00', 'wavg', '3616.00', 0, '0.00', '0.00', 'Stock out from sale INV-000009', 1, '2025-10-29', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(100, 8, 2, 'out', 'sales', 9, 'INV-000009', 1, '3776.00', '3776.00', 'wavg', '3776.00', 0, '0.00', '0.00', 'Stock out from sale INV-000009', 1, '2025-10-29', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(101, 10, 2, 'out', 'sales', 9, 'INV-000009', 4, '4144.00', '4144.00', 'wavg', '16576.00', 0, '0.00', '0.00', 'Stock out from sale INV-000009', 1, '2025-10-29', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(102, 3, 2, 'out', 'sales', 10, 'INV-000010', 6, '3364.00', '3364.00', 'wavg', '20184.00', 0, '0.00', '0.00', 'Stock out from sale INV-000010', 1, '2025-12-07', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(103, 5, 2, 'out', 'sales', 10, 'INV-000010', 7, '1261.00', '1261.00', 'wavg', '8827.00', 0, '0.00', '0.00', 'Stock out from sale INV-000010', 1, '2025-12-07', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(104, 7, 2, 'out', 'sales', 10, 'INV-000010', 9, '1808.00', '1808.00', 'wavg', '16272.00', 0, '0.00', '0.00', 'Stock out from sale INV-000010', 1, '2025-12-07', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(105, 8, 2, 'out', 'sales', 10, 'INV-000010', 10, '3776.00', '3776.00', 'wavg', '37760.00', 0, '0.00', '0.00', 'Stock out from sale INV-000010', 1, '2025-12-07', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(106, 3, 2, 'out', 'sales', 11, 'INV-000011', 6, '3364.00', '3364.00', 'wavg', '20184.00', 0, '0.00', '0.00', 'Stock out from sale INV-000011', 1, '2025-08-18', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(107, 11, 2, 'out', 'sales', 11, 'INV-000011', 2, '3378.00', '3378.00', 'wavg', '6756.00', 0, '0.00', '0.00', 'Stock out from sale INV-000011', 1, '2025-08-18', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(108, 5, 2, 'out', 'sales', 12, 'INV-000012', 3, '1261.00', '1261.00', 'wavg', '3783.00', 0, '0.00', '0.00', 'Stock out from sale INV-000012', 1, '2025-08-02', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(109, 9, 1, 'out', 'sales', 13, 'INV-000013', 1, '973.00', '973.00', 'wavg', '973.00', 0, '0.00', '0.00', 'Stock out from sale INV-000013', 1, '2025-09-04', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(110, 11, 1, 'out', 'sales', 13, 'INV-000013', 6, '3378.00', '3378.00', 'wavg', '20268.00', 0, '0.00', '0.00', 'Stock out from sale INV-000013', 1, '2025-09-04', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(111, 3, 1, 'out', 'sales', 14, 'INV-000014', 3, '3364.00', '3364.00', 'wavg', '10092.00', 0, '0.00', '0.00', 'Stock out from sale INV-000014', 1, '2025-10-03', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(112, 9, 1, 'out', 'sales', 14, 'INV-000014', 8, '973.00', '973.00', 'wavg', '7784.00', 0, '0.00', '0.00', 'Stock out from sale INV-000014', 1, '2025-10-03', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(113, 10, 1, 'out', 'sales', 14, 'INV-000014', 1, '4144.00', '4144.00', 'wavg', '4144.00', 0, '0.00', '0.00', 'Stock out from sale INV-000014', 1, '2025-10-03', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(114, 11, 1, 'out', 'sales', 14, 'INV-000014', 4, '3378.00', '3378.00', 'wavg', '13512.00', 0, '0.00', '0.00', 'Stock out from sale INV-000014', 1, '2025-10-03', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(115, 3, 2, 'out', 'sales', 15, 'INV-000015', 5, '3364.00', '3364.00', 'wavg', '16820.00', 0, '0.00', '0.00', 'Stock out from sale INV-000015', 1, '2025-08-25', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(116, 5, 2, 'out', 'sales', 15, 'INV-000015', 5, '1261.00', '1261.00', 'wavg', '6305.00', 0, '0.00', '0.00', 'Stock out from sale INV-000015', 1, '2025-08-25', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(117, 9, 2, 'out', 'sales', 15, 'INV-000015', 6, '973.00', '973.00', 'wavg', '5838.00', 0, '0.00', '0.00', 'Stock out from sale INV-000015', 1, '2025-08-25', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(118, 3, 3, 'out', 'sales', 16, 'INV-000016', 7, '3364.00', '3364.00', 'wavg', '23548.00', 0, '0.00', '0.00', 'Stock out from sale INV-000016', 1, '2025-09-28', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(119, 5, 3, 'out', 'sales', 16, 'INV-000016', 10, '1261.00', '1261.00', 'wavg', '12610.00', 0, '0.00', '0.00', 'Stock out from sale INV-000016', 1, '2025-09-28', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(120, 3, 3, 'out', 'sales', 17, 'INV-000017', 5, '3364.00', '3364.00', 'wavg', '16820.00', 0, '0.00', '0.00', 'Stock out from sale INV-000017', 1, '2025-08-20', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(121, 8, 3, 'out', 'sales', 17, 'INV-000017', 7, '3776.00', '3776.00', 'wavg', '26432.00', 0, '0.00', '0.00', 'Stock out from sale INV-000017', 1, '2025-08-20', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(122, 10, 3, 'out', 'sales', 17, 'INV-000017', 1, '4144.00', '4144.00', 'wavg', '4144.00', 0, '0.00', '0.00', 'Stock out from sale INV-000017', 1, '2025-08-20', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(123, 4, 2, 'out', 'sales', 18, 'INV-000018', 6, '1247.00', '1247.00', 'wavg', '7482.00', 0, '0.00', '0.00', 'Stock out from sale INV-000018', 1, '2025-09-21', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(124, 5, 2, 'out', 'sales', 18, 'INV-000018', 2, '1261.00', '1261.00', 'wavg', '2522.00', 0, '0.00', '0.00', 'Stock out from sale INV-000018', 1, '2025-09-21', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(125, 3, 1, 'out', 'sales', 19, 'INV-000019', 10, '3364.00', '3364.00', 'wavg', '33640.00', 0, '0.00', '0.00', 'Stock out from sale INV-000019', 1, '2025-06-20', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(126, 5, 1, 'out', 'sales', 19, 'INV-000019', 10, '1261.00', '1261.00', 'wavg', '12610.00', 0, '0.00', '0.00', 'Stock out from sale INV-000019', 1, '2025-06-20', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(127, 7, 1, 'out', 'sales', 19, 'INV-000019', 10, '1808.00', '1808.00', 'wavg', '18080.00', 0, '0.00', '0.00', 'Stock out from sale INV-000019', 1, '2025-06-20', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(128, 10, 1, 'out', 'sales', 19, 'INV-000019', 6, '4144.00', '4144.00', 'wavg', '24864.00', 0, '0.00', '0.00', 'Stock out from sale INV-000019', 1, '2025-06-20', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(129, 3, 3, 'out', 'sales', 20, 'INV-000020', 5, '3364.00', '3364.00', 'wavg', '16820.00', 0, '0.00', '0.00', 'Stock out from sale INV-000020', 1, '2025-10-06', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(130, 4, 3, 'out', 'sales', 20, 'INV-000020', 10, '1247.00', '1247.00', 'wavg', '12470.00', 0, '0.00', '0.00', 'Stock out from sale INV-000020', 1, '2025-10-06', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(131, 8, 3, 'out', 'sales', 20, 'INV-000020', 5, '3776.00', '3776.00', 'wavg', '18880.00', 0, '0.00', '0.00', 'Stock out from sale INV-000020', 1, '2025-10-06', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(132, 10, 3, 'out', 'sales', 20, 'INV-000020', 1, '4144.00', '4144.00', 'wavg', '4144.00', 0, '0.00', '0.00', 'Stock out from sale INV-000020', 1, '2025-10-06', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(133, 12, 3, 'out', 'sales', 20, 'INV-000020', 9, '716.00', '716.00', 'wavg', '6444.00', 0, '0.00', '0.00', 'Stock out from sale INV-000020', 1, '2025-10-06', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(134, 3, 2, 'out', 'sales', 21, 'INV-000021', 2, '3364.00', '3364.00', 'wavg', '6728.00', 0, '0.00', '0.00', 'Stock out from sale INV-000021', 1, '2025-06-22', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(135, 6, 2, 'out', 'sales', 21, 'INV-000021', 6, '2715.00', '2715.00', 'wavg', '16290.00', 0, '0.00', '0.00', 'Stock out from sale INV-000021', 1, '2025-06-22', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(136, 3, 1, 'out', 'sales', 22, 'INV-000022', 3, '3364.00', '3364.00', 'wavg', '10092.00', 0, '0.00', '0.00', 'Stock out from sale INV-000022', 1, '2025-07-16', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(137, 4, 1, 'out', 'sales', 22, 'INV-000022', 8, '1247.00', '1247.00', 'wavg', '9976.00', 0, '0.00', '0.00', 'Stock out from sale INV-000022', 1, '2025-07-16', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(138, 6, 1, 'out', 'sales', 22, 'INV-000022', 7, '2715.00', '2715.00', 'wavg', '19005.00', 0, '0.00', '0.00', 'Stock out from sale INV-000022', 1, '2025-07-16', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(139, 10, 1, 'out', 'sales', 22, 'INV-000022', 8, '4144.00', '4144.00', 'wavg', '33152.00', 0, '0.00', '0.00', 'Stock out from sale INV-000022', 1, '2025-07-16', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(140, 11, 1, 'out', 'sales', 22, 'INV-000022', 9, '3378.00', '3378.00', 'wavg', '30402.00', 0, '0.00', '0.00', 'Stock out from sale INV-000022', 1, '2025-07-16', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(141, 3, 1, 'out', 'sales', 23, 'INV-000023', 8, '3364.00', '3364.00', 'wavg', '26912.00', 0, '0.00', '0.00', 'Stock out from sale INV-000023', 1, '2025-06-29', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(142, 5, 1, 'out', 'sales', 23, 'INV-000023', 8, '1261.00', '1261.00', 'wavg', '10088.00', 0, '0.00', '0.00', 'Stock out from sale INV-000023', 1, '2025-06-29', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(143, 7, 1, 'out', 'sales', 23, 'INV-000023', 6, '1808.00', '1808.00', 'wavg', '10848.00', 0, '0.00', '0.00', 'Stock out from sale INV-000023', 1, '2025-06-29', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(144, 11, 1, 'out', 'sales', 23, 'INV-000023', 6, '3378.00', '3378.00', 'wavg', '20268.00', 0, '0.00', '0.00', 'Stock out from sale INV-000023', 1, '2025-06-29', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(145, 4, 1, 'out', 'sales', 24, 'INV-000024', 2, '1247.00', '1247.00', 'wavg', '2494.00', 0, '0.00', '0.00', 'Stock out from sale INV-000024', 1, '2025-11-03', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(146, 5, 1, 'out', 'sales', 24, 'INV-000024', 2, '1261.00', '1261.00', 'wavg', '2522.00', 0, '0.00', '0.00', 'Stock out from sale INV-000024', 1, '2025-11-03', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(147, 9, 1, 'out', 'sales', 24, 'INV-000024', 2, '973.00', '973.00', 'wavg', '1946.00', 0, '0.00', '0.00', 'Stock out from sale INV-000024', 1, '2025-11-03', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(148, 10, 1, 'out', 'sales', 24, 'INV-000024', 2, '4144.00', '4144.00', 'wavg', '8288.00', 0, '0.00', '0.00', 'Stock out from sale INV-000024', 1, '2025-11-03', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(149, 11, 1, 'out', 'sales', 24, 'INV-000024', 4, '3378.00', '3378.00', 'wavg', '13512.00', 0, '0.00', '0.00', 'Stock out from sale INV-000024', 1, '2025-11-03', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(150, 3, 3, 'out', 'sales', 25, 'INV-000025', 10, '3364.00', '3364.00', 'wavg', '33640.00', 0, '0.00', '0.00', 'Stock out from sale INV-000025', 1, '2025-05-24', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(151, 4, 3, 'out', 'sales', 25, 'INV-000025', 7, '1247.00', '1247.00', 'wavg', '8729.00', 0, '0.00', '0.00', 'Stock out from sale INV-000025', 1, '2025-05-24', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(152, 8, 3, 'out', 'sales', 25, 'INV-000025', 9, '3776.00', '3776.00', 'wavg', '33984.00', 0, '0.00', '0.00', 'Stock out from sale INV-000025', 1, '2025-05-24', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(153, 11, 3, 'out', 'sales', 25, 'INV-000025', 8, '3378.00', '3378.00', 'wavg', '27024.00', 0, '0.00', '0.00', 'Stock out from sale INV-000025', 1, '2025-05-24', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(154, 12, 3, 'out', 'sales', 25, 'INV-000025', 8, '716.00', '716.00', 'wavg', '5728.00', 0, '0.00', '0.00', 'Stock out from sale INV-000025', 1, '2025-05-24', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(155, 4, 3, 'out', 'sales', 26, 'INV-000026', 9, '1247.00', '1247.00', 'wavg', '11223.00', 0, '0.00', '0.00', 'Stock out from sale INV-000026', 1, '2025-09-14', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(156, 7, 3, 'out', 'sales', 26, 'INV-000026', 9, '1808.00', '1808.00', 'wavg', '16272.00', 0, '0.00', '0.00', 'Stock out from sale INV-000026', 1, '2025-09-14', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(157, 11, 3, 'out', 'sales', 26, 'INV-000026', 1, '3378.00', '3378.00', 'wavg', '3378.00', 0, '0.00', '0.00', 'Stock out from sale INV-000026', 1, '2025-09-14', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(158, 3, 2, 'out', 'sales', 27, 'INV-000027', 1, '3364.00', '3364.00', 'wavg', '3364.00', 0, '0.00', '0.00', 'Stock out from sale INV-000027', 1, '2025-05-31', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(159, 6, 2, 'out', 'sales', 27, 'INV-000027', 8, '2715.00', '2715.00', 'wavg', '21720.00', 0, '0.00', '0.00', 'Stock out from sale INV-000027', 1, '2025-05-31', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(160, 12, 2, 'out', 'sales', 27, 'INV-000027', 7, '716.00', '716.00', 'wavg', '5012.00', 0, '0.00', '0.00', 'Stock out from sale INV-000027', 1, '2025-05-31', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(161, 7, 3, 'out', 'sales', 28, 'INV-000028', 2, '1808.00', '1808.00', 'wavg', '3616.00', 0, '0.00', '0.00', 'Stock out from sale INV-000028', 1, '2025-06-26', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(162, 12, 3, 'out', 'sales', 28, 'INV-000028', 1, '716.00', '716.00', 'wavg', '716.00', 0, '0.00', '0.00', 'Stock out from sale INV-000028', 1, '2025-06-26', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(163, 11, 2, 'out', 'sales', 29, 'INV-000029', 7, '3378.00', '3378.00', 'wavg', '23646.00', 0, '0.00', '0.00', 'Stock out from sale INV-000029', 1, '2025-10-22', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(164, 6, 3, 'out', 'sales', 30, 'INV-000030', 9, '2715.00', '2715.00', 'wavg', '24435.00', 0, '0.00', '0.00', 'Stock out from sale INV-000030', 1, '2025-09-10', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(165, 9, 3, 'out', 'sales', 30, 'INV-000030', 7, '973.00', '973.00', 'wavg', '6811.00', 0, '0.00', '0.00', 'Stock out from sale INV-000030', 1, '2025-09-10', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(166, 10, 3, 'out', 'sales', 30, 'INV-000030', 4, '4144.00', '4144.00', 'wavg', '16576.00', 0, '0.00', '0.00', 'Stock out from sale INV-000030', 1, '2025-09-10', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(167, 6, 3, 'out', 'sales', 31, 'INV-000031', 1, '2715.00', '2715.00', 'wavg', '2715.00', 0, '0.00', '0.00', 'Stock out from sale INV-000031', 1, '2025-08-29', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(168, 10, 3, 'out', 'sales', 31, 'INV-000031', 7, '4144.00', '4144.00', 'wavg', '29008.00', 0, '0.00', '0.00', 'Stock out from sale INV-000031', 1, '2025-08-29', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(169, 4, 3, 'out', 'sales', 32, 'INV-000032', 1, '1247.00', '1247.00', 'wavg', '1247.00', 0, '0.00', '0.00', 'Stock out from sale INV-000032', 1, '2025-10-10', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(170, 12, 3, 'out', 'sales', 32, 'INV-000032', 5, '716.00', '716.00', 'wavg', '3580.00', 0, '0.00', '0.00', 'Stock out from sale INV-000032', 1, '2025-10-10', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(171, 7, 2, 'out', 'sales', 33, 'INV-000033', 5, '1808.00', '1808.00', 'wavg', '9040.00', 0, '0.00', '0.00', 'Stock out from sale INV-000033', 1, '2025-10-23', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(172, 11, 2, 'out', 'sales', 33, 'INV-000033', 5, '3378.00', '3378.00', 'wavg', '16890.00', 0, '0.00', '0.00', 'Stock out from sale INV-000033', 1, '2025-10-23', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(173, 3, 2, 'out', 'sales', 34, 'INV-000034', 6, '3364.00', '3364.00', 'wavg', '20184.00', 0, '0.00', '0.00', 'Stock out from sale INV-000034', 1, '2025-06-30', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(174, 9, 2, 'out', 'sales', 34, 'INV-000034', 5, '973.00', '973.00', 'wavg', '4865.00', 0, '0.00', '0.00', 'Stock out from sale INV-000034', 1, '2025-06-30', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(175, 5, 3, 'out', 'sales', 35, 'INV-000035', 6, '1261.00', '1261.00', 'wavg', '7566.00', 0, '0.00', '0.00', 'Stock out from sale INV-000035', 1, '2025-09-24', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(176, 9, 3, 'out', 'sales', 35, 'INV-000035', 1, '973.00', '973.00', 'wavg', '973.00', 0, '0.00', '0.00', 'Stock out from sale INV-000035', 1, '2025-09-24', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(177, 4, 2, 'out', 'sales', 36, 'INV-000036', 1, '1247.00', '1247.00', 'wavg', '1247.00', 0, '0.00', '0.00', 'Stock out from sale INV-000036', 1, '2025-10-10', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(178, 11, 2, 'out', 'sales', 36, 'INV-000036', 1, '3378.00', '3378.00', 'wavg', '3378.00', 0, '0.00', '0.00', 'Stock out from sale INV-000036', 1, '2025-10-10', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(179, 12, 2, 'out', 'sales', 36, 'INV-000036', 1, '716.00', '716.00', 'wavg', '716.00', 0, '0.00', '0.00', 'Stock out from sale INV-000036', 1, '2025-10-10', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(180, 3, 2, 'out', 'sales', 37, 'INV-000037', 4, '3364.00', '3364.00', 'wavg', '13456.00', 0, '0.00', '0.00', 'Stock out from sale INV-000037', 1, '2025-10-01', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(181, 4, 2, 'out', 'sales', 37, 'INV-000037', 8, '1247.00', '1247.00', 'wavg', '9976.00', 0, '0.00', '0.00', 'Stock out from sale INV-000037', 1, '2025-10-01', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(182, 8, 2, 'out', 'sales', 37, 'INV-000037', 8, '3776.00', '3776.00', 'wavg', '30208.00', 0, '0.00', '0.00', 'Stock out from sale INV-000037', 1, '2025-10-01', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(183, 12, 2, 'out', 'sales', 37, 'INV-000037', 7, '716.00', '716.00', 'wavg', '5012.00', 0, '0.00', '0.00', 'Stock out from sale INV-000037', 1, '2025-10-01', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(184, 4, 2, 'out', 'sales', 38, 'INV-000038', 10, '1247.00', '1247.00', 'wavg', '12470.00', 0, '0.00', '0.00', 'Stock out from sale INV-000038', 1, '2025-07-28', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(185, 9, 3, 'out', 'sales', 39, 'INV-000039', 9, '973.00', '973.00', 'wavg', '8757.00', 0, '0.00', '0.00', 'Stock out from sale INV-000039', 1, '2025-06-21', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(186, 11, 3, 'out', 'sales', 39, 'INV-000039', 3, '3378.00', '3378.00', 'wavg', '10134.00', 0, '0.00', '0.00', 'Stock out from sale INV-000039', 1, '2025-06-21', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(187, 4, 2, 'out', 'sales', 40, 'INV-000040', 3, '1247.00', '1247.00', 'wavg', '3741.00', 0, '0.00', '0.00', 'Stock out from sale INV-000040', 1, '2025-12-06', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(188, 5, 2, 'out', 'sales', 40, 'INV-000040', 8, '1261.00', '1261.00', 'wavg', '10088.00', 0, '0.00', '0.00', 'Stock out from sale INV-000040', 1, '2025-12-06', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(189, 7, 2, 'out', 'sales', 40, 'INV-000040', 3, '1808.00', '1808.00', 'wavg', '5424.00', 0, '0.00', '0.00', 'Stock out from sale INV-000040', 1, '2025-12-06', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(190, 12, 2, 'out', 'sales', 40, 'INV-000040', 7, '716.00', '716.00', 'wavg', '5012.00', 0, '0.00', '0.00', 'Stock out from sale INV-000040', 1, '2025-12-06', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(191, 8, 2, 'out', 'sales', 41, 'INV-000041', 3, '3776.00', '3776.00', 'wavg', '11328.00', 0, '0.00', '0.00', 'Stock out from sale INV-000041', 1, '2025-11-13', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(192, 3, 2, 'out', 'sales', 42, 'INV-000042', 4, '3364.00', '3364.00', 'wavg', '13456.00', 0, '0.00', '0.00', 'Stock out from sale INV-000042', 1, '2025-11-04', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(193, 4, 2, 'out', 'sales', 42, 'INV-000042', 1, '1247.00', '1247.00', 'wavg', '1247.00', 0, '0.00', '0.00', 'Stock out from sale INV-000042', 1, '2025-11-04', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(194, 5, 2, 'out', 'sales', 42, 'INV-000042', 6, '1261.00', '1261.00', 'wavg', '7566.00', 0, '0.00', '0.00', 'Stock out from sale INV-000042', 1, '2025-11-04', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(195, 11, 2, 'out', 'sales', 42, 'INV-000042', 1, '3378.00', '3378.00', 'wavg', '3378.00', 0, '0.00', '0.00', 'Stock out from sale INV-000042', 1, '2025-11-04', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(196, 12, 2, 'out', 'sales', 42, 'INV-000042', 4, '716.00', '716.00', 'wavg', '2864.00', 0, '0.00', '0.00', 'Stock out from sale INV-000042', 1, '2025-11-04', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(197, 5, 2, 'out', 'sales', 43, 'INV-000043', 1, '1261.00', '1261.00', 'wavg', '1261.00', 0, '0.00', '0.00', 'Stock out from sale INV-000043', 1, '2025-09-12', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(198, 8, 2, 'out', 'sales', 43, 'INV-000043', 6, '3776.00', '3776.00', 'wavg', '22656.00', 0, '0.00', '0.00', 'Stock out from sale INV-000043', 1, '2025-09-12', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(199, 9, 2, 'out', 'sales', 43, 'INV-000043', 6, '973.00', '973.00', 'wavg', '5838.00', 0, '0.00', '0.00', 'Stock out from sale INV-000043', 1, '2025-09-12', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(200, 10, 2, 'out', 'sales', 43, 'INV-000043', 6, '4144.00', '4144.00', 'wavg', '24864.00', 0, '0.00', '0.00', 'Stock out from sale INV-000043', 1, '2025-09-12', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(201, 11, 2, 'out', 'sales', 43, 'INV-000043', 10, '3378.00', '3378.00', 'wavg', '33780.00', 0, '0.00', '0.00', 'Stock out from sale INV-000043', 1, '2025-09-12', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(202, 9, 3, 'out', 'sales', 44, 'INV-000044', 3, '973.00', '973.00', 'wavg', '2919.00', 0, '0.00', '0.00', 'Stock out from sale INV-000044', 1, '2025-08-16', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(203, 10, 3, 'out', 'sales', 44, 'INV-000044', 3, '4144.00', '4144.00', 'wavg', '12432.00', 0, '0.00', '0.00', 'Stock out from sale INV-000044', 1, '2025-08-16', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(204, 11, 3, 'out', 'sales', 44, 'INV-000044', 8, '3378.00', '3378.00', 'wavg', '27024.00', 0, '0.00', '0.00', 'Stock out from sale INV-000044', 1, '2025-08-16', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(205, 4, 1, 'out', 'sales', 45, 'INV-000045', 2, '1247.00', '1247.00', 'wavg', '2494.00', 0, '0.00', '0.00', 'Stock out from sale INV-000045', 1, '2025-11-28', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(206, 5, 1, 'out', 'sales', 45, 'INV-000045', 1, '1261.00', '1261.00', 'wavg', '1261.00', 0, '0.00', '0.00', 'Stock out from sale INV-000045', 1, '2025-11-28', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(207, 7, 1, 'out', 'sales', 45, 'INV-000045', 1, '1808.00', '1808.00', 'wavg', '1808.00', 0, '0.00', '0.00', 'Stock out from sale INV-000045', 1, '2025-11-28', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(208, 5, 3, 'out', 'sales', 46, 'INV-000046', 2, '1261.00', '1261.00', 'wavg', '2522.00', 0, '0.00', '0.00', 'Stock out from sale INV-000046', 1, '2025-06-17', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(209, 7, 3, 'out', 'sales', 46, 'INV-000046', 7, '1808.00', '1808.00', 'wavg', '12656.00', 0, '0.00', '0.00', 'Stock out from sale INV-000046', 1, '2025-06-17', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(210, 10, 3, 'out', 'sales', 46, 'INV-000046', 5, '4144.00', '4144.00', 'wavg', '20720.00', 0, '0.00', '0.00', 'Stock out from sale INV-000046', 1, '2025-06-17', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(211, 11, 3, 'out', 'sales', 46, 'INV-000046', 9, '3378.00', '3378.00', 'wavg', '30402.00', 0, '0.00', '0.00', 'Stock out from sale INV-000046', 1, '2025-06-17', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(212, 3, 2, 'out', 'sales', 47, 'INV-000047', 1, '3364.00', '3364.00', 'wavg', '3364.00', 0, '0.00', '0.00', 'Stock out from sale INV-000047', 1, '2025-07-05', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(213, 5, 2, 'out', 'sales', 47, 'INV-000047', 2, '1261.00', '1261.00', 'wavg', '2522.00', 0, '0.00', '0.00', 'Stock out from sale INV-000047', 1, '2025-07-05', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(214, 6, 2, 'out', 'sales', 47, 'INV-000047', 5, '2715.00', '2715.00', 'wavg', '13575.00', 0, '0.00', '0.00', 'Stock out from sale INV-000047', 1, '2025-07-05', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(215, 8, 2, 'out', 'sales', 47, 'INV-000047', 2, '3776.00', '3776.00', 'wavg', '7552.00', 0, '0.00', '0.00', 'Stock out from sale INV-000047', 1, '2025-07-05', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(216, 3, 1, 'out', 'sales', 48, 'INV-000048', 4, '3364.00', '3364.00', 'wavg', '13456.00', 0, '0.00', '0.00', 'Stock out from sale INV-000048', 1, '2025-12-15', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(217, 4, 1, 'out', 'sales', 48, 'INV-000048', 9, '1247.00', '1247.00', 'wavg', '11223.00', 0, '0.00', '0.00', 'Stock out from sale INV-000048', 1, '2025-12-15', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(218, 9, 1, 'out', 'sales', 48, 'INV-000048', 9, '973.00', '973.00', 'wavg', '8757.00', 0, '0.00', '0.00', 'Stock out from sale INV-000048', 1, '2025-12-15', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(219, 10, 1, 'out', 'sales', 48, 'INV-000048', 9, '4144.00', '4144.00', 'wavg', '37296.00', 0, '0.00', '0.00', 'Stock out from sale INV-000048', 1, '2025-12-15', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(220, 12, 1, 'out', 'sales', 48, 'INV-000048', 4, '716.00', '716.00', 'wavg', '2864.00', 0, '0.00', '0.00', 'Stock out from sale INV-000048', 1, '2025-12-15', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(221, 3, 3, 'out', 'sales', 49, 'INV-000049', 1, '3364.00', '3364.00', 'wavg', '3364.00', 0, '0.00', '0.00', 'Stock out from sale INV-000049', 1, '2025-09-08', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(222, 4, 3, 'out', 'sales', 49, 'INV-000049', 4, '1247.00', '1247.00', 'wavg', '4988.00', 0, '0.00', '0.00', 'Stock out from sale INV-000049', 1, '2025-09-08', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(223, 4, 3, 'out', 'sales', 50, 'INV-000050', 2, '1247.00', '1247.00', 'wavg', '2494.00', 0, '0.00', '0.00', 'Stock out from sale INV-000050', 1, '2025-10-29', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(224, 6, 3, 'out', 'sales', 50, 'INV-000050', 8, '2715.00', '2715.00', 'wavg', '21720.00', 0, '0.00', '0.00', 'Stock out from sale INV-000050', 1, '2025-10-29', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(225, 8, 3, 'out', 'sales', 50, 'INV-000050', 10, '3776.00', '3776.00', 'wavg', '37760.00', 0, '0.00', '0.00', 'Stock out from sale INV-000050', 1, '2025-10-29', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(226, 9, 3, 'out', 'sales', 50, 'INV-000050', 4, '973.00', '973.00', 'wavg', '3892.00', 0, '0.00', '0.00', 'Stock out from sale INV-000050', 1, '2025-10-29', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(227, 6, 2, 'out', 'sales', 51, 'INV-000051', 6, '2715.00', '2715.00', 'wavg', '16290.00', 0, '0.00', '0.00', 'Stock out from sale INV-000051', 1, '2025-11-19', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(228, 7, 2, 'out', 'sales', 51, 'INV-000051', 7, '1808.00', '1808.00', 'wavg', '12656.00', 0, '0.00', '0.00', 'Stock out from sale INV-000051', 1, '2025-11-19', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(229, 8, 2, 'out', 'sales', 51, 'INV-000051', 2, '3776.00', '3776.00', 'wavg', '7552.00', 0, '0.00', '0.00', 'Stock out from sale INV-000051', 1, '2025-11-19', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(230, 11, 2, 'out', 'sales', 51, 'INV-000051', 8, '3378.00', '3378.00', 'wavg', '27024.00', 0, '0.00', '0.00', 'Stock out from sale INV-000051', 1, '2025-11-19', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(231, 9, 2, 'out', 'sales', 52, 'INV-000052', 5, '973.00', '973.00', 'wavg', '4865.00', 0, '0.00', '0.00', 'Stock out from sale INV-000052', 1, '2025-08-15', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(232, 3, 3, 'out', 'sales', 53, 'INV-000053', 7, '3364.00', '3364.00', 'wavg', '23548.00', 0, '0.00', '0.00', 'Stock out from sale INV-000053', 1, '2025-07-16', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(233, 4, 3, 'out', 'sales', 53, 'INV-000053', 1, '1247.00', '1247.00', 'wavg', '1247.00', 0, '0.00', '0.00', 'Stock out from sale INV-000053', 1, '2025-07-16', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(234, 5, 3, 'out', 'sales', 53, 'INV-000053', 9, '1261.00', '1261.00', 'wavg', '11349.00', 0, '0.00', '0.00', 'Stock out from sale INV-000053', 1, '2025-07-16', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(235, 12, 1, 'out', 'sales', 54, 'INV-000054', 10, '716.00', '716.00', 'wavg', '7160.00', 0, '0.00', '0.00', 'Stock out from sale INV-000054', 1, '2025-05-27', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(236, 3, 3, 'out', 'sales', 55, 'INV-000055', 4, '3364.00', '3364.00', 'wavg', '13456.00', 0, '0.00', '0.00', 'Stock out from sale INV-000055', 1, '2025-09-12', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(237, 5, 3, 'out', 'sales', 55, 'INV-000055', 7, '1261.00', '1261.00', 'wavg', '8827.00', 0, '0.00', '0.00', 'Stock out from sale INV-000055', 1, '2025-09-12', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(238, 10, 3, 'out', 'sales', 55, 'INV-000055', 5, '4144.00', '4144.00', 'wavg', '20720.00', 0, '0.00', '0.00', 'Stock out from sale INV-000055', 1, '2025-09-12', '2025-12-21 14:30:46', '2025-12-21 14:30:46');
INSERT INTO `stock_ledgers` (`id`, `product_id`, `warehouse_id`, `type`, `reference_type`, `reference_id`, `reference_number`, `quantity`, `unit_cost`, `weighted_avg_cost`, `cost_method`, `total_cost`, `balance_after`, `value_before`, `value_after`, `notes`, `created_by`, `transaction_date`, `created_at`, `updated_at`) VALUES
(239, 11, 3, 'out', 'sales', 55, 'INV-000055', 7, '3378.00', '3378.00', 'wavg', '23646.00', 0, '0.00', '0.00', 'Stock out from sale INV-000055', 1, '2025-09-12', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(240, 12, 3, 'out', 'sales', 55, 'INV-000055', 10, '716.00', '716.00', 'wavg', '7160.00', 0, '0.00', '0.00', 'Stock out from sale INV-000055', 1, '2025-09-12', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(241, 3, 1, 'out', 'sales', 56, 'INV-000056', 3, '3364.00', '3364.00', 'wavg', '10092.00', 0, '0.00', '0.00', 'Stock out from sale INV-000056', 1, '2025-11-02', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(242, 5, 1, 'out', 'sales', 56, 'INV-000056', 6, '1261.00', '1261.00', 'wavg', '7566.00', 0, '0.00', '0.00', 'Stock out from sale INV-000056', 1, '2025-11-02', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(243, 6, 1, 'out', 'sales', 56, 'INV-000056', 7, '2715.00', '2715.00', 'wavg', '19005.00', 0, '0.00', '0.00', 'Stock out from sale INV-000056', 1, '2025-11-02', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(244, 8, 1, 'out', 'sales', 56, 'INV-000056', 10, '3776.00', '3776.00', 'wavg', '37760.00', 0, '0.00', '0.00', 'Stock out from sale INV-000056', 1, '2025-11-02', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(245, 9, 1, 'out', 'sales', 56, 'INV-000056', 3, '973.00', '973.00', 'wavg', '2919.00', 0, '0.00', '0.00', 'Stock out from sale INV-000056', 1, '2025-11-02', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(246, 4, 3, 'out', 'sales', 57, 'INV-000057', 7, '1247.00', '1247.00', 'wavg', '8729.00', 0, '0.00', '0.00', 'Stock out from sale INV-000057', 1, '2025-11-06', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(247, 7, 3, 'out', 'sales', 57, 'INV-000057', 9, '1808.00', '1808.00', 'wavg', '16272.00', 0, '0.00', '0.00', 'Stock out from sale INV-000057', 1, '2025-11-06', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(248, 9, 3, 'out', 'sales', 57, 'INV-000057', 2, '973.00', '973.00', 'wavg', '1946.00', 0, '0.00', '0.00', 'Stock out from sale INV-000057', 1, '2025-11-06', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(249, 11, 3, 'out', 'sales', 57, 'INV-000057', 2, '3378.00', '3378.00', 'wavg', '6756.00', 0, '0.00', '0.00', 'Stock out from sale INV-000057', 1, '2025-11-06', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(250, 12, 3, 'out', 'sales', 57, 'INV-000057', 6, '716.00', '716.00', 'wavg', '4296.00', 0, '0.00', '0.00', 'Stock out from sale INV-000057', 1, '2025-11-06', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(251, 3, 3, 'out', 'sales', 58, 'INV-000058', 4, '3364.00', '3364.00', 'wavg', '13456.00', 0, '0.00', '0.00', 'Stock out from sale INV-000058', 1, '2025-11-12', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(252, 7, 3, 'out', 'sales', 58, 'INV-000058', 6, '1808.00', '1808.00', 'wavg', '10848.00', 0, '0.00', '0.00', 'Stock out from sale INV-000058', 1, '2025-11-12', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(253, 9, 3, 'out', 'sales', 58, 'INV-000058', 2, '973.00', '973.00', 'wavg', '1946.00', 0, '0.00', '0.00', 'Stock out from sale INV-000058', 1, '2025-11-12', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(254, 3, 1, 'out', 'sales', 59, 'INV-000059', 6, '3364.00', '3364.00', 'wavg', '20184.00', 0, '0.00', '0.00', 'Stock out from sale INV-000059', 1, '2025-10-17', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(255, 5, 1, 'out', 'sales', 59, 'INV-000059', 3, '1261.00', '1261.00', 'wavg', '3783.00', 0, '0.00', '0.00', 'Stock out from sale INV-000059', 1, '2025-10-17', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(256, 7, 1, 'out', 'sales', 59, 'INV-000059', 3, '1808.00', '1808.00', 'wavg', '5424.00', 0, '0.00', '0.00', 'Stock out from sale INV-000059', 1, '2025-10-17', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(257, 12, 1, 'out', 'sales', 59, 'INV-000059', 4, '716.00', '716.00', 'wavg', '2864.00', 0, '0.00', '0.00', 'Stock out from sale INV-000059', 1, '2025-10-17', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(258, 11, 3, 'out', 'sales', 60, 'INV-000060', 1, '3378.00', '3378.00', 'wavg', '3378.00', 0, '0.00', '0.00', 'Stock out from sale INV-000060', 1, '2025-10-10', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(259, 3, 2, 'out', 'sales', 61, 'INV-000061', 3, '3364.00', '3364.00', 'wavg', '10092.00', 0, '0.00', '0.00', 'Stock out from sale INV-000061', 1, '2025-06-06', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(260, 4, 2, 'out', 'sales', 61, 'INV-000061', 5, '1247.00', '1247.00', 'wavg', '6235.00', 0, '0.00', '0.00', 'Stock out from sale INV-000061', 1, '2025-06-06', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(261, 6, 2, 'out', 'sales', 61, 'INV-000061', 7, '2715.00', '2715.00', 'wavg', '19005.00', 0, '0.00', '0.00', 'Stock out from sale INV-000061', 1, '2025-06-06', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(262, 3, 3, 'out', 'sales', 62, 'INV-000062', 6, '3364.00', '3364.00', 'wavg', '20184.00', 0, '0.00', '0.00', 'Stock out from sale INV-000062', 1, '2025-06-09', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(263, 5, 3, 'out', 'sales', 62, 'INV-000062', 8, '1261.00', '1261.00', 'wavg', '10088.00', 0, '0.00', '0.00', 'Stock out from sale INV-000062', 1, '2025-06-09', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(264, 6, 3, 'out', 'sales', 62, 'INV-000062', 2, '2715.00', '2715.00', 'wavg', '5430.00', 0, '0.00', '0.00', 'Stock out from sale INV-000062', 1, '2025-06-09', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(265, 7, 3, 'out', 'sales', 62, 'INV-000062', 9, '1808.00', '1808.00', 'wavg', '16272.00', 0, '0.00', '0.00', 'Stock out from sale INV-000062', 1, '2025-06-09', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(266, 8, 3, 'out', 'sales', 62, 'INV-000062', 2, '3776.00', '3776.00', 'wavg', '7552.00', 0, '0.00', '0.00', 'Stock out from sale INV-000062', 1, '2025-06-09', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(267, 6, 1, 'out', 'sales', 63, 'INV-000063', 9, '2715.00', '2715.00', 'wavg', '24435.00', 0, '0.00', '0.00', 'Stock out from sale INV-000063', 1, '2025-10-09', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(268, 8, 1, 'out', 'sales', 63, 'INV-000063', 1, '3776.00', '3776.00', 'wavg', '3776.00', 0, '0.00', '0.00', 'Stock out from sale INV-000063', 1, '2025-10-09', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(269, 5, 2, 'out', 'sales', 64, 'INV-000064', 9, '1261.00', '1261.00', 'wavg', '11349.00', 0, '0.00', '0.00', 'Stock out from sale INV-000064', 1, '2025-10-04', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(270, 6, 2, 'out', 'sales', 64, 'INV-000064', 3, '2715.00', '2715.00', 'wavg', '8145.00', 0, '0.00', '0.00', 'Stock out from sale INV-000064', 1, '2025-10-04', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(271, 7, 2, 'out', 'sales', 64, 'INV-000064', 3, '1808.00', '1808.00', 'wavg', '5424.00', 0, '0.00', '0.00', 'Stock out from sale INV-000064', 1, '2025-10-04', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(272, 12, 2, 'out', 'sales', 64, 'INV-000064', 8, '716.00', '716.00', 'wavg', '5728.00', 0, '0.00', '0.00', 'Stock out from sale INV-000064', 1, '2025-10-04', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(273, 3, 1, 'out', 'sales', 65, 'INV-000065', 10, '3364.00', '3364.00', 'wavg', '33640.00', 0, '0.00', '0.00', 'Stock out from sale INV-000065', 1, '2025-11-08', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(274, 9, 1, 'out', 'sales', 65, 'INV-000065', 10, '973.00', '973.00', 'wavg', '9730.00', 0, '0.00', '0.00', 'Stock out from sale INV-000065', 1, '2025-11-08', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(275, 11, 1, 'out', 'sales', 65, 'INV-000065', 3, '3378.00', '3378.00', 'wavg', '10134.00', 0, '0.00', '0.00', 'Stock out from sale INV-000065', 1, '2025-11-08', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(276, 3, 3, 'out', 'sales', 66, 'INV-000066', 8, '3364.00', '3364.00', 'wavg', '26912.00', 0, '0.00', '0.00', 'Stock out from sale INV-000066', 1, '2025-05-22', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(277, 10, 1, 'out', 'sales', 67, 'INV-000067', 6, '4144.00', '4144.00', 'wavg', '24864.00', 0, '0.00', '0.00', 'Stock out from sale INV-000067', 1, '2025-06-28', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(278, 4, 3, 'out', 'sales', 68, 'INV-000068', 4, '1247.00', '1247.00', 'wavg', '4988.00', 0, '0.00', '0.00', 'Stock out from sale INV-000068', 1, '2025-11-02', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(279, 5, 3, 'out', 'sales', 68, 'INV-000068', 8, '1261.00', '1261.00', 'wavg', '10088.00', 0, '0.00', '0.00', 'Stock out from sale INV-000068', 1, '2025-11-02', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(280, 7, 3, 'out', 'sales', 68, 'INV-000068', 2, '1808.00', '1808.00', 'wavg', '3616.00', 0, '0.00', '0.00', 'Stock out from sale INV-000068', 1, '2025-11-02', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(281, 10, 3, 'out', 'sales', 68, 'INV-000068', 8, '4144.00', '4144.00', 'wavg', '33152.00', 0, '0.00', '0.00', 'Stock out from sale INV-000068', 1, '2025-11-02', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(282, 11, 3, 'out', 'sales', 68, 'INV-000068', 2, '3378.00', '3378.00', 'wavg', '6756.00', 0, '0.00', '0.00', 'Stock out from sale INV-000068', 1, '2025-11-02', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(283, 10, 3, 'out', 'sales', 69, 'INV-000069', 7, '4144.00', '4144.00', 'wavg', '29008.00', 0, '0.00', '0.00', 'Stock out from sale INV-000069', 1, '2025-12-19', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(284, 5, 1, 'out', 'sales', 70, 'INV-000070', 3, '1261.00', '1261.00', 'wavg', '3783.00', 0, '0.00', '0.00', 'Stock out from sale INV-000070', 1, '2025-06-26', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(285, 11, 1, 'out', 'sales', 70, 'INV-000070', 7, '3378.00', '3378.00', 'wavg', '23646.00', 0, '0.00', '0.00', 'Stock out from sale INV-000070', 1, '2025-06-26', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(286, 3, 1, 'out', 'sales', 71, 'INV-000071', 8, '3364.00', '3364.00', 'wavg', '26912.00', 0, '0.00', '0.00', 'Stock out from sale INV-000071', 1, '2025-08-19', '2025-12-21 14:30:46', '2025-12-21 14:30:46'),
(287, 8, 1, 'out', 'sales', 71, 'INV-000071', 5, '3776.00', '3776.00', 'wavg', '18880.00', 0, '0.00', '0.00', 'Stock out from sale INV-000071', 1, '2025-08-19', '2025-12-21 14:30:47', '2025-12-21 14:30:47'),
(288, 9, 1, 'out', 'sales', 71, 'INV-000071', 4, '973.00', '973.00', 'wavg', '3892.00', 0, '0.00', '0.00', 'Stock out from sale INV-000071', 1, '2025-08-19', '2025-12-21 14:30:47', '2025-12-21 14:30:47'),
(289, 10, 1, 'out', 'sales', 71, 'INV-000071', 3, '4144.00', '4144.00', 'wavg', '12432.00', 0, '0.00', '0.00', 'Stock out from sale INV-000071', 1, '2025-08-19', '2025-12-21 14:30:47', '2025-12-21 14:30:47'),
(290, 11, 1, 'out', 'sales', 71, 'INV-000071', 6, '3378.00', '3378.00', 'wavg', '20268.00', 0, '0.00', '0.00', 'Stock out from sale INV-000071', 1, '2025-08-19', '2025-12-21 14:30:47', '2025-12-21 14:30:47'),
(291, 11, 2, 'out', 'sales', 72, 'INV-000072', 3, '3378.00', '3378.00', 'wavg', '10134.00', 0, '0.00', '0.00', 'Stock out from sale INV-000072', 1, '2025-05-24', '2025-12-21 14:30:47', '2025-12-21 14:30:47'),
(292, 11, 2, 'out', 'sales', 73, 'INV-000073', 1, '3378.00', '3378.00', 'wavg', '3378.00', 0, '0.00', '0.00', 'Stock out from sale INV-000073', 1, '2025-10-07', '2025-12-21 14:30:47', '2025-12-21 14:30:47'),
(293, 5, 1, 'out', 'sales', 74, 'INV-000074', 7, '1261.00', '1261.00', 'wavg', '8827.00', 0, '0.00', '0.00', 'Stock out from sale INV-000074', 1, '2025-10-17', '2025-12-21 14:30:47', '2025-12-21 14:30:47'),
(294, 6, 1, 'out', 'sales', 75, 'INV-000075', 6, '2715.00', '2715.00', 'wavg', '16290.00', 0, '0.00', '0.00', 'Stock out from sale INV-000075', 1, '2025-05-31', '2025-12-21 14:30:47', '2025-12-21 14:30:47'),
(295, 8, 1, 'out', 'sales', 75, 'INV-000075', 1, '3776.00', '3776.00', 'wavg', '3776.00', 0, '0.00', '0.00', 'Stock out from sale INV-000075', 1, '2025-05-31', '2025-12-21 14:30:47', '2025-12-21 14:30:47'),
(296, 10, 1, 'out', 'sales', 75, 'INV-000075', 9, '4144.00', '4144.00', 'wavg', '37296.00', 0, '0.00', '0.00', 'Stock out from sale INV-000075', 1, '2025-05-31', '2025-12-21 14:30:47', '2025-12-21 14:30:47'),
(297, 3, 1, 'out', 'sales', 76, 'INV-000076', 5, '3364.00', '3364.00', 'wavg', '16820.00', 0, '0.00', '0.00', 'Stock out from sale INV-000076', 1, '2025-07-28', '2025-12-21 14:30:47', '2025-12-21 14:30:47'),
(298, 5, 1, 'out', 'sales', 76, 'INV-000076', 4, '1261.00', '1261.00', 'wavg', '5044.00', 0, '0.00', '0.00', 'Stock out from sale INV-000076', 1, '2025-07-28', '2025-12-21 14:30:47', '2025-12-21 14:30:47'),
(299, 10, 1, 'out', 'sales', 76, 'INV-000076', 2, '4144.00', '4144.00', 'wavg', '8288.00', 0, '0.00', '0.00', 'Stock out from sale INV-000076', 1, '2025-07-28', '2025-12-21 14:30:47', '2025-12-21 14:30:47'),
(300, 11, 1, 'out', 'sales', 76, 'INV-000076', 10, '3378.00', '3378.00', 'wavg', '33780.00', 0, '0.00', '0.00', 'Stock out from sale INV-000076', 1, '2025-07-28', '2025-12-21 14:30:47', '2025-12-21 14:30:47'),
(301, 12, 1, 'out', 'sales', 76, 'INV-000076', 4, '716.00', '716.00', 'wavg', '2864.00', 0, '0.00', '0.00', 'Stock out from sale INV-000076', 1, '2025-07-28', '2025-12-21 14:30:47', '2025-12-21 14:30:47'),
(302, 3, 1, 'out', 'sales', 77, 'INV-000077', 1, '3364.00', '3364.00', 'wavg', '3364.00', 0, '0.00', '0.00', 'Stock out from sale INV-000077', 1, '2025-08-02', '2025-12-21 14:30:47', '2025-12-21 14:30:47'),
(303, 9, 1, 'out', 'sales', 77, 'INV-000077', 6, '973.00', '973.00', 'wavg', '5838.00', 0, '0.00', '0.00', 'Stock out from sale INV-000077', 1, '2025-08-02', '2025-12-21 14:30:47', '2025-12-21 14:30:47'),
(304, 10, 1, 'out', 'sales', 77, 'INV-000077', 6, '4144.00', '4144.00', 'wavg', '24864.00', 0, '0.00', '0.00', 'Stock out from sale INV-000077', 1, '2025-08-02', '2025-12-21 14:30:47', '2025-12-21 14:30:47'),
(305, 11, 1, 'out', 'sales', 77, 'INV-000077', 10, '3378.00', '3378.00', 'wavg', '33780.00', 0, '0.00', '0.00', 'Stock out from sale INV-000077', 1, '2025-08-02', '2025-12-21 14:30:47', '2025-12-21 14:30:47'),
(306, 7, 3, 'out', 'sales', 78, 'INV-000078', 1, '1808.00', '1808.00', 'wavg', '1808.00', 0, '0.00', '0.00', 'Stock out from sale INV-000078', 1, '2025-11-13', '2025-12-21 14:30:47', '2025-12-21 14:30:47'),
(307, 8, 3, 'out', 'sales', 78, 'INV-000078', 10, '3776.00', '3776.00', 'wavg', '37760.00', 0, '0.00', '0.00', 'Stock out from sale INV-000078', 1, '2025-11-13', '2025-12-21 14:30:47', '2025-12-21 14:30:47'),
(308, 9, 3, 'out', 'sales', 78, 'INV-000078', 5, '973.00', '973.00', 'wavg', '4865.00', 0, '0.00', '0.00', 'Stock out from sale INV-000078', 1, '2025-11-13', '2025-12-21 14:30:47', '2025-12-21 14:30:47'),
(309, 5, 1, 'out', 'sales', 79, 'INV-000079', 4, '1261.00', '1261.00', 'wavg', '5044.00', 0, '0.00', '0.00', 'Stock out from sale INV-000079', 1, '2025-11-17', '2025-12-21 14:30:47', '2025-12-21 14:30:47'),
(310, 7, 1, 'out', 'sales', 79, 'INV-000079', 5, '1808.00', '1808.00', 'wavg', '9040.00', 0, '0.00', '0.00', 'Stock out from sale INV-000079', 1, '2025-11-17', '2025-12-21 14:30:47', '2025-12-21 14:30:47'),
(311, 10, 1, 'out', 'sales', 79, 'INV-000079', 9, '4144.00', '4144.00', 'wavg', '37296.00', 0, '0.00', '0.00', 'Stock out from sale INV-000079', 1, '2025-11-17', '2025-12-21 14:30:47', '2025-12-21 14:30:47'),
(312, 12, 1, 'out', 'sales', 79, 'INV-000079', 6, '716.00', '716.00', 'wavg', '4296.00', 0, '0.00', '0.00', 'Stock out from sale INV-000079', 1, '2025-11-17', '2025-12-21 14:30:47', '2025-12-21 14:30:47'),
(313, 10, 2, 'out', 'sales', 80, 'INV-000080', 4, '4144.00', '4144.00', 'wavg', '16576.00', 0, '0.00', '0.00', 'Stock out from sale INV-000080', 1, '2025-11-13', '2025-12-21 14:30:47', '2025-12-21 14:30:47'),
(314, 5, 2, 'out', 'sales', 81, 'INV-000081', 2, '1261.00', '1261.00', 'wavg', '2522.00', 0, '0.00', '0.00', 'Stock out from sale INV-000081', 1, '2025-12-16', '2025-12-21 14:30:47', '2025-12-21 14:30:47'),
(315, 12, 2, 'out', 'sales', 81, 'INV-000081', 7, '716.00', '716.00', 'wavg', '5012.00', 0, '0.00', '0.00', 'Stock out from sale INV-000081', 1, '2025-12-16', '2025-12-21 14:30:47', '2025-12-21 14:30:47'),
(316, 8, 3, 'out', 'sales', 82, 'INV-000082', 5, '3776.00', '3776.00', 'wavg', '18880.00', 0, '0.00', '0.00', 'Stock out from sale INV-000082', 1, '2025-10-26', '2025-12-21 14:30:47', '2025-12-21 14:30:47'),
(317, 4, 3, 'out', 'sales', 83, 'INV-000083', 4, '1247.00', '1247.00', 'wavg', '4988.00', 0, '0.00', '0.00', 'Stock out from sale INV-000083', 1, '2025-09-02', '2025-12-21 14:30:47', '2025-12-21 14:30:47'),
(318, 6, 3, 'out', 'sales', 83, 'INV-000083', 1, '2715.00', '2715.00', 'wavg', '2715.00', 0, '0.00', '0.00', 'Stock out from sale INV-000083', 1, '2025-09-02', '2025-12-21 14:30:47', '2025-12-21 14:30:47'),
(319, 8, 3, 'out', 'sales', 84, 'INV-000084', 10, '3776.00', '3776.00', 'wavg', '37760.00', 0, '0.00', '0.00', 'Stock out from sale INV-000084', 1, '2025-08-07', '2025-12-21 14:30:47', '2025-12-21 14:30:47'),
(320, 3, 1, 'out', 'sales', 85, 'INV-000085', 6, '3364.00', '3364.00', 'wavg', '20184.00', 0, '0.00', '0.00', 'Stock out from sale INV-000085', 1, '2025-06-29', '2025-12-21 14:30:47', '2025-12-21 14:30:47'),
(321, 6, 1, 'out', 'sales', 85, 'INV-000085', 5, '2715.00', '2715.00', 'wavg', '13575.00', 0, '0.00', '0.00', 'Stock out from sale INV-000085', 1, '2025-06-29', '2025-12-21 14:30:47', '2025-12-21 14:30:47'),
(322, 5, 2, 'out', 'sales', 86, 'INV-000086', 5, '1261.00', '1261.00', 'wavg', '6305.00', 0, '0.00', '0.00', 'Stock out from sale INV-000086', 1, '2025-12-05', '2025-12-21 14:30:47', '2025-12-21 14:30:47'),
(323, 7, 2, 'out', 'sales', 86, 'INV-000086', 5, '1808.00', '1808.00', 'wavg', '9040.00', 0, '0.00', '0.00', 'Stock out from sale INV-000086', 1, '2025-12-05', '2025-12-21 14:30:47', '2025-12-21 14:30:47'),
(324, 10, 2, 'out', 'sales', 86, 'INV-000086', 8, '4144.00', '4144.00', 'wavg', '33152.00', 0, '0.00', '0.00', 'Stock out from sale INV-000086', 1, '2025-12-05', '2025-12-21 14:30:47', '2025-12-21 14:30:47'),
(325, 11, 2, 'out', 'sales', 86, 'INV-000086', 2, '3378.00', '3378.00', 'wavg', '6756.00', 0, '0.00', '0.00', 'Stock out from sale INV-000086', 1, '2025-12-05', '2025-12-21 14:30:47', '2025-12-21 14:30:47'),
(326, 4, 1, 'out', 'sales', 87, 'INV-000087', 9, '1247.00', '1247.00', 'wavg', '11223.00', 0, '0.00', '0.00', 'Stock out from sale INV-000087', 1, '2025-11-21', '2025-12-21 14:30:47', '2025-12-21 14:30:47'),
(327, 6, 1, 'out', 'sales', 87, 'INV-000087', 10, '2715.00', '2715.00', 'wavg', '27150.00', 0, '0.00', '0.00', 'Stock out from sale INV-000087', 1, '2025-11-21', '2025-12-21 14:30:47', '2025-12-21 14:30:47'),
(328, 9, 1, 'out', 'sales', 87, 'INV-000087', 6, '973.00', '973.00', 'wavg', '5838.00', 0, '0.00', '0.00', 'Stock out from sale INV-000087', 1, '2025-11-21', '2025-12-21 14:30:47', '2025-12-21 14:30:47'),
(329, 12, 1, 'out', 'sales', 87, 'INV-000087', 5, '716.00', '716.00', 'wavg', '3580.00', 0, '0.00', '0.00', 'Stock out from sale INV-000087', 1, '2025-11-21', '2025-12-21 14:30:47', '2025-12-21 14:30:47'),
(330, 4, 2, 'out', 'sales', 88, 'INV-000088', 2, '1247.00', '1247.00', 'wavg', '2494.00', 0, '0.00', '0.00', 'Stock out from sale INV-000088', 1, '2025-07-23', '2025-12-21 14:30:47', '2025-12-21 14:30:47'),
(331, 5, 2, 'out', 'sales', 88, 'INV-000088', 5, '1261.00', '1261.00', 'wavg', '6305.00', 0, '0.00', '0.00', 'Stock out from sale INV-000088', 1, '2025-07-23', '2025-12-21 14:30:47', '2025-12-21 14:30:47'),
(332, 6, 2, 'out', 'sales', 88, 'INV-000088', 3, '2715.00', '2715.00', 'wavg', '8145.00', 0, '0.00', '0.00', 'Stock out from sale INV-000088', 1, '2025-07-23', '2025-12-21 14:30:47', '2025-12-21 14:30:47'),
(333, 11, 2, 'out', 'sales', 88, 'INV-000088', 9, '3378.00', '3378.00', 'wavg', '30402.00', 0, '0.00', '0.00', 'Stock out from sale INV-000088', 1, '2025-07-23', '2025-12-21 14:30:47', '2025-12-21 14:30:47'),
(334, 12, 2, 'out', 'sales', 88, 'INV-000088', 6, '716.00', '716.00', 'wavg', '4296.00', 0, '0.00', '0.00', 'Stock out from sale INV-000088', 1, '2025-07-23', '2025-12-21 14:30:47', '2025-12-21 14:30:47'),
(335, 6, 2, 'out', 'sales', 89, 'INV-000089', 3, '2715.00', '2715.00', 'wavg', '8145.00', 0, '0.00', '0.00', 'Stock out from sale INV-000089', 1, '2025-09-26', '2025-12-21 14:30:47', '2025-12-21 14:30:47'),
(336, 7, 2, 'out', 'sales', 89, 'INV-000089', 1, '1808.00', '1808.00', 'wavg', '1808.00', 0, '0.00', '0.00', 'Stock out from sale INV-000089', 1, '2025-09-26', '2025-12-21 14:30:47', '2025-12-21 14:30:47'),
(337, 11, 2, 'out', 'sales', 89, 'INV-000089', 4, '3378.00', '3378.00', 'wavg', '13512.00', 0, '0.00', '0.00', 'Stock out from sale INV-000089', 1, '2025-09-26', '2025-12-21 14:30:47', '2025-12-21 14:30:47'),
(338, 12, 2, 'out', 'sales', 89, 'INV-000089', 8, '716.00', '716.00', 'wavg', '5728.00', 0, '0.00', '0.00', 'Stock out from sale INV-000089', 1, '2025-09-26', '2025-12-21 14:30:47', '2025-12-21 14:30:47'),
(339, 4, 2, 'out', 'sales', 90, 'INV-000090', 2, '1247.00', '1247.00', 'wavg', '2494.00', 0, '0.00', '0.00', 'Stock out from sale INV-000090', 1, '2025-12-06', '2025-12-21 14:30:47', '2025-12-21 14:30:47'),
(340, 5, 2, 'out', 'sales', 90, 'INV-000090', 10, '1261.00', '1261.00', 'wavg', '12610.00', 0, '0.00', '0.00', 'Stock out from sale INV-000090', 1, '2025-12-06', '2025-12-21 14:30:47', '2025-12-21 14:30:47'),
(341, 7, 2, 'out', 'sales', 90, 'INV-000090', 10, '1808.00', '1808.00', 'wavg', '18080.00', 0, '0.00', '0.00', 'Stock out from sale INV-000090', 1, '2025-12-06', '2025-12-21 14:30:47', '2025-12-21 14:30:47'),
(342, 8, 2, 'out', 'sales', 90, 'INV-000090', 10, '3776.00', '3776.00', 'wavg', '37760.00', 0, '0.00', '0.00', 'Stock out from sale INV-000090', 1, '2025-12-06', '2025-12-21 14:30:47', '2025-12-21 14:30:47'),
(343, 5, 2, 'out', 'sales', 91, 'INV-000091', 2, '1261.00', '1261.00', 'wavg', '2522.00', 0, '0.00', '0.00', 'Stock out from sale INV-000091', 1, '2025-11-16', '2025-12-21 14:30:47', '2025-12-21 14:30:47'),
(344, 8, 2, 'out', 'sales', 91, 'INV-000091', 3, '3776.00', '3776.00', 'wavg', '11328.00', 0, '0.00', '0.00', 'Stock out from sale INV-000091', 1, '2025-11-16', '2025-12-21 14:30:47', '2025-12-21 14:30:47'),
(345, 9, 2, 'out', 'sales', 91, 'INV-000091', 9, '973.00', '973.00', 'wavg', '8757.00', 0, '0.00', '0.00', 'Stock out from sale INV-000091', 1, '2025-11-16', '2025-12-21 14:30:47', '2025-12-21 14:30:47'),
(346, 9, 1, 'out', 'sales', 92, 'INV-000092', 8, '973.00', '973.00', 'wavg', '7784.00', 0, '0.00', '0.00', 'Stock out from sale INV-000092', 1, '2025-06-14', '2025-12-21 14:30:47', '2025-12-21 14:30:47'),
(347, 12, 1, 'out', 'sales', 92, 'INV-000092', 6, '716.00', '716.00', 'wavg', '4296.00', 0, '0.00', '0.00', 'Stock out from sale INV-000092', 1, '2025-06-14', '2025-12-21 14:30:47', '2025-12-21 14:30:47'),
(348, 7, 1, 'out', 'sales', 93, 'INV-000093', 4, '1808.00', '1808.00', 'wavg', '7232.00', 0, '0.00', '0.00', 'Stock out from sale INV-000093', 1, '2025-06-09', '2025-12-21 14:30:47', '2025-12-21 14:30:47'),
(349, 11, 1, 'out', 'sales', 93, 'INV-000093', 6, '3378.00', '3378.00', 'wavg', '20268.00', 0, '0.00', '0.00', 'Stock out from sale INV-000093', 1, '2025-06-09', '2025-12-21 14:30:47', '2025-12-21 14:30:47'),
(350, 12, 1, 'out', 'sales', 93, 'INV-000093', 7, '716.00', '716.00', 'wavg', '5012.00', 0, '0.00', '0.00', 'Stock out from sale INV-000093', 1, '2025-06-09', '2025-12-21 14:30:47', '2025-12-21 14:30:47'),
(351, 7, 1, 'out', 'sales', 94, 'INV-000094', 9, '1808.00', '1808.00', 'wavg', '16272.00', 0, '0.00', '0.00', 'Stock out from sale INV-000094', 1, '2025-06-04', '2025-12-21 14:30:47', '2025-12-21 14:30:47'),
(352, 10, 1, 'out', 'sales', 94, 'INV-000094', 4, '4144.00', '4144.00', 'wavg', '16576.00', 0, '0.00', '0.00', 'Stock out from sale INV-000094', 1, '2025-06-04', '2025-12-21 14:30:47', '2025-12-21 14:30:47'),
(353, 3, 1, 'out', 'sales', 95, 'INV-000095', 3, '3364.00', '3364.00', 'wavg', '10092.00', 0, '0.00', '0.00', 'Stock out from sale INV-000095', 1, '2025-10-08', '2025-12-21 14:30:47', '2025-12-21 14:30:47'),
(354, 6, 1, 'out', 'sales', 95, 'INV-000095', 1, '2715.00', '2715.00', 'wavg', '2715.00', 0, '0.00', '0.00', 'Stock out from sale INV-000095', 1, '2025-10-08', '2025-12-21 14:30:47', '2025-12-21 14:30:47'),
(355, 7, 1, 'out', 'sales', 95, 'INV-000095', 9, '1808.00', '1808.00', 'wavg', '16272.00', 0, '0.00', '0.00', 'Stock out from sale INV-000095', 1, '2025-10-08', '2025-12-21 14:30:47', '2025-12-21 14:30:47'),
(356, 9, 3, 'out', 'sales', 96, 'INV-000096', 1, '973.00', '973.00', 'wavg', '973.00', 0, '0.00', '0.00', 'Stock out from sale INV-000096', 1, '2025-07-01', '2025-12-21 14:30:47', '2025-12-21 14:30:47'),
(357, 10, 3, 'out', 'sales', 96, 'INV-000096', 5, '4144.00', '4144.00', 'wavg', '20720.00', 0, '0.00', '0.00', 'Stock out from sale INV-000096', 1, '2025-07-01', '2025-12-21 14:30:47', '2025-12-21 14:30:47'),
(358, 4, 1, 'out', 'sales', 97, 'INV-000097', 7, '1247.00', '1247.00', 'wavg', '8729.00', 0, '0.00', '0.00', 'Stock out from sale INV-000097', 1, '2025-12-10', '2025-12-21 14:30:47', '2025-12-21 14:30:47'),
(359, 8, 1, 'out', 'sales', 97, 'INV-000097', 9, '3776.00', '3776.00', 'wavg', '33984.00', 0, '0.00', '0.00', 'Stock out from sale INV-000097', 1, '2025-12-10', '2025-12-21 14:30:47', '2025-12-21 14:30:47'),
(360, 9, 1, 'out', 'sales', 97, 'INV-000097', 2, '973.00', '973.00', 'wavg', '1946.00', 0, '0.00', '0.00', 'Stock out from sale INV-000097', 1, '2025-12-10', '2025-12-21 14:30:47', '2025-12-21 14:30:47'),
(361, 10, 1, 'out', 'sales', 97, 'INV-000097', 6, '4144.00', '4144.00', 'wavg', '24864.00', 0, '0.00', '0.00', 'Stock out from sale INV-000097', 1, '2025-12-10', '2025-12-21 14:30:47', '2025-12-21 14:30:47'),
(362, 12, 1, 'out', 'sales', 97, 'INV-000097', 3, '716.00', '716.00', 'wavg', '2148.00', 0, '0.00', '0.00', 'Stock out from sale INV-000097', 1, '2025-12-10', '2025-12-21 14:30:47', '2025-12-21 14:30:47'),
(363, 6, 3, 'out', 'sales', 98, 'INV-000098', 5, '2715.00', '2715.00', 'wavg', '13575.00', 0, '0.00', '0.00', 'Stock out from sale INV-000098', 1, '2025-11-25', '2025-12-21 14:30:47', '2025-12-21 14:30:47'),
(364, 12, 3, 'out', 'sales', 98, 'INV-000098', 5, '716.00', '716.00', 'wavg', '3580.00', 0, '0.00', '0.00', 'Stock out from sale INV-000098', 1, '2025-11-25', '2025-12-21 14:30:47', '2025-12-21 14:30:47'),
(365, 6, 1, 'out', 'sales', 99, 'INV-000099', 6, '2715.00', '2715.00', 'wavg', '16290.00', 0, '0.00', '0.00', 'Stock out from sale INV-000099', 1, '2025-06-16', '2025-12-21 14:30:47', '2025-12-21 14:30:47'),
(366, 8, 1, 'out', 'sales', 99, 'INV-000099', 5, '3776.00', '3776.00', 'wavg', '18880.00', 0, '0.00', '0.00', 'Stock out from sale INV-000099', 1, '2025-06-16', '2025-12-21 14:30:47', '2025-12-21 14:30:47'),
(367, 11, 1, 'out', 'sales', 99, 'INV-000099', 1, '3378.00', '3378.00', 'wavg', '3378.00', 0, '0.00', '0.00', 'Stock out from sale INV-000099', 1, '2025-06-16', '2025-12-21 14:30:47', '2025-12-21 14:30:47'),
(368, 12, 1, 'out', 'sales', 99, 'INV-000099', 6, '716.00', '716.00', 'wavg', '4296.00', 0, '0.00', '0.00', 'Stock out from sale INV-000099', 1, '2025-06-16', '2025-12-21 14:30:47', '2025-12-21 14:30:47'),
(369, 3, 1, 'out', 'sales', 100, 'INV-000100', 3, '3364.00', '3364.00', 'wavg', '10092.00', 0, '0.00', '0.00', 'Stock out from sale INV-000100', 1, '2025-07-19', '2025-12-21 14:30:47', '2025-12-21 14:30:47'),
(370, 5, 1, 'out', 'sales', 100, 'INV-000100', 9, '1261.00', '1261.00', 'wavg', '11349.00', 0, '0.00', '0.00', 'Stock out from sale INV-000100', 1, '2025-07-19', '2025-12-21 14:30:47', '2025-12-21 14:30:47'),
(371, 6, 1, 'out', 'sales', 100, 'INV-000100', 4, '2715.00', '2715.00', 'wavg', '10860.00', 0, '0.00', '0.00', 'Stock out from sale INV-000100', 1, '2025-07-19', '2025-12-21 14:30:47', '2025-12-21 14:30:47'),
(372, 9, 1, 'out', 'sales', 100, 'INV-000100', 5, '973.00', '973.00', 'wavg', '4865.00', 0, '0.00', '0.00', 'Stock out from sale INV-000100', 1, '2025-07-19', '2025-12-21 14:30:47', '2025-12-21 14:30:47'),
(373, 11, 1, 'out', 'sales', 100, 'INV-000100', 1, '3378.00', '3378.00', 'wavg', '3378.00', 0, '0.00', '0.00', 'Stock out from sale INV-000100', 1, '2025-07-19', '2025-12-21 14:30:47', '2025-12-21 14:30:47'),
(374, 3, 2, 'out', 'sales', 101, 'INV-000101', 7, '3364.00', '3364.00', 'wavg', '23548.00', 0, '0.00', '0.00', 'Stock out from sale INV-000101', 1, '2025-06-09', '2025-12-21 14:30:47', '2025-12-21 14:30:47'),
(375, 1, 2, 'out', 'damage', NULL, 'DAMAGE-000004', 2, '43.34', '43.34', 'wavg', '86.68', 686, '29816.55', '29729.87', 'Damage adjustment entry', 1, '2025-11-07', '2025-12-21 14:30:47', '2025-12-21 14:30:47');

-- --------------------------------------------------------

--
-- Table structure for table `suppliers`
--

CREATE TABLE `suppliers` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `company_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mobile` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` text COLLATE utf8mb4_unicode_ci,
  `city` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `state` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `postal_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tax_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `opening_balance` decimal(15,2) NOT NULL DEFAULT '0.00',
  `current_balance` decimal(15,2) NOT NULL DEFAULT '0.00',
  `notes` text COLLATE utf8mb4_unicode_ci,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_by` bigint UNSIGNED DEFAULT NULL,
  `updated_by` bigint UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `suppliers`
--

INSERT INTO `suppliers` (`id`, `name`, `code`, `company_name`, `email`, `phone`, `mobile`, `address`, `city`, `state`, `country`, `postal_code`, `tax_id`, `opening_balance`, `current_balance`, `notes`, `is_active`, `created_by`, `updated_by`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'ABC Trading Company', 'SUP-001', 'ABC Trading Company Ltd.', 'contact@abctrading.com', '01700000001', '01700000001', '123 Business Street, Motijheel', 'Dhaka', 'Dhaka', 'Bangladesh', '1200', 'TAX-001', '0.00', '53304.22', 'Primary supplier for electronics and gadgets', 1, 1, NULL, '2025-12-21 14:30:44', '2025-12-21 14:30:47', NULL),
(2, 'XYZ Wholesale Mart', 'SUP-002', 'XYZ Wholesale Mart Pvt. Ltd.', 'info@xyzmart.com', '01700000002', '01700000002', '456 Market Road, Gulshan', 'Dhaka', 'Dhaka', 'Bangladesh', '1212', 'TAX-002', '0.00', '11719.13', 'Bulk supplier for grocery items', 1, 1, NULL, '2025-12-21 14:30:44', '2025-12-21 14:30:47', NULL),
(3, 'Global Imports Ltd', 'SUP-003', 'Global Imports Limited', 'sales@globalimports.com', '01700000003', '01700000003', '789 Import Zone, Chittagong', 'Chittagong', 'Chittagong', 'Bangladesh', '4000', 'TAX-003', '0.00', '73268.03', 'International goods supplier', 1, 1, NULL, '2025-12-21 14:30:44', '2025-12-21 14:30:47', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `units`
--

CREATE TABLE `units` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `units`
--

INSERT INTO `units` (`id`, `name`, `code`, `description`, `is_active`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Piece', 'PCS', NULL, 1, '2025-12-21 14:30:44', '2025-12-21 14:30:44', NULL),
(2, 'Kilogram', 'KG', NULL, 1, '2025-12-21 14:30:44', '2025-12-21 14:30:44', NULL),
(3, 'Liter', 'LTR', NULL, 1, '2025-12-21 14:30:44', '2025-12-21 14:30:44', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `avatar` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `gender` enum('male','female','other') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` text COLLATE utf8mb4_unicode_ci,
  `city` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `state` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `postal_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bio` text COLLATE utf8mb4_unicode_ci,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `avatar`, `phone`, `date_of_birth`, `gender`, `address`, `city`, `state`, `country`, `postal_code`, `bio`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Administrator', 'admin@mail.com', NULL, '$2y$12$//38WVPkeGSeCX3ZVVtjd.sf9d.9mpau6mWESp1aQC4d2DPDyfsfC', NULL, '+8801707080401', NULL, 'male', NULL, 'Dhaka', 'Dhaka', 'Bangladesh', NULL, 'System Administrator with full access to all features and settings.', NULL, '2025-12-21 14:30:44', '2025-12-21 14:30:44'),
(2, 'Cashier', 'cashier@mail.com', NULL, '$2y$12$sQxnZql2XmoR3kzkCG7aF./MdXyIeR1LmujiI9rYt1beIWAraqx7i', NULL, '+8801707080402', NULL, 'female', NULL, 'Dhaka', 'Dhaka', 'Bangladesh', NULL, 'Cashier role for POS and due collection.', NULL, '2025-12-21 14:30:44', '2025-12-21 14:30:44'),
(3, 'Storekeeper', 'store@mail.com', NULL, '$2y$12$1eWsl7Wlwt9cq5kvjcZTd.AkjBtP84Os3EZLDLrCWDiUE8aBcBYOK', NULL, '+8801707080403', NULL, 'male', NULL, 'Dhaka', 'Dhaka', 'Bangladesh', NULL, 'Storekeeper to manage purchases, products, and stock.', NULL, '2025-12-21 14:30:44', '2025-12-21 14:30:44');

-- --------------------------------------------------------

--
-- Table structure for table `user_role`
--

CREATE TABLE `user_role` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `role_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `user_role`
--

INSERT INTO `user_role` (`id`, `user_id`, `role_id`, `created_at`, `updated_at`) VALUES
(1, 1, 1, NULL, NULL),
(2, 2, 2, NULL, NULL),
(3, 3, 3, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `visitor_logs`
--

CREATE TABLE `visitor_logs` (
  `id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `warehouses`
--

CREATE TABLE `warehouses` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` text COLLATE utf8mb4_unicode_ci,
  `city` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `state` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `postal_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `manager_id` bigint UNSIGNED DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_by` bigint UNSIGNED DEFAULT NULL,
  `updated_by` bigint UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `warehouses`
--

INSERT INTO `warehouses` (`id`, `name`, `code`, `address`, `city`, `state`, `country`, `postal_code`, `phone`, `email`, `manager_id`, `is_active`, `created_by`, `updated_by`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Main Warehouse', 'WH-001', '123 Main Street, Business District', 'Dhaka', 'Dhaka', 'Bangladesh', '1200', '01700001001', 'warehouse1@sms.com', NULL, 1, 1, 1, '2025-12-21 14:30:44', '2025-12-21 14:30:44', NULL),
(2, 'Secondary Warehouse', 'WH-002', '456 Industrial Area, Port Zone', 'Chittagong', 'Chittagong', 'Bangladesh', '4000', '01700001002', 'warehouse2@sms.com', NULL, 1, 1, 1, '2025-12-21 14:30:44', '2025-12-21 14:30:44', NULL),
(3, 'Distribution Center', 'WH-003', '789 Commerce Road, Export Zone', 'Dhaka', 'Dhaka', 'Bangladesh', '1212', '01700001003', 'warehouse3@sms.com', NULL, 1, 1, 1, '2025-12-21 14:30:44', '2025-12-21 14:30:44', NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `categories_slug_unique` (`slug`),
  ADD KEY `categories_created_by_foreign` (`created_by`),
  ADD KEY `categories_updated_by_foreign` (`updated_by`);

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `customers_code_unique` (`code`),
  ADD KEY `customers_created_by_foreign` (`created_by`),
  ADD KEY `customers_updated_by_foreign` (`updated_by`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indexes for table `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `login_logs`
--
ALTER TABLE `login_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `login_logs_user_id_index` (`user_id`),
  ADD KEY `login_logs_email_index` (`email`),
  ADD KEY `login_logs_status_index` (`status`),
  ADD KEY `login_logs_created_at_index` (`created_at`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `payments_payment_number_unique` (`payment_number`),
  ADD KEY `payments_created_by_foreign` (`created_by`),
  ADD KEY `payments_party_type_party_id_index` (`party_type`,`party_id`),
  ADD KEY `payments_reference_type_reference_id_index` (`reference_type`,`reference_id`),
  ADD KEY `payments_payment_date_index` (`payment_date`);

--
-- Indexes for table `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `permissions_slug_unique` (`slug`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`),
  ADD KEY `personal_access_tokens_expires_at_index` (`expires_at`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `products_sku_unique` (`sku`),
  ADD UNIQUE KEY `products_barcode_unique` (`barcode`),
  ADD KEY `products_category_id_foreign` (`category_id`),
  ADD KEY `products_unit_id_foreign` (`unit_id`),
  ADD KEY `products_created_by_foreign` (`created_by`),
  ADD KEY `products_updated_by_foreign` (`updated_by`);

--
-- Indexes for table `purchases`
--
ALTER TABLE `purchases`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `purchases_invoice_number_unique` (`invoice_number`),
  ADD KEY `purchases_supplier_id_foreign` (`supplier_id`),
  ADD KEY `purchases_warehouse_id_foreign` (`warehouse_id`),
  ADD KEY `purchases_created_by_foreign` (`created_by`),
  ADD KEY `purchases_updated_by_foreign` (`updated_by`);

--
-- Indexes for table `purchase_items`
--
ALTER TABLE `purchase_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `purchase_items_purchase_id_foreign` (`purchase_id`),
  ADD KEY `purchase_items_product_id_foreign` (`product_id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `roles_name_unique` (`name`),
  ADD UNIQUE KEY `roles_slug_unique` (`slug`);

--
-- Indexes for table `role_permission`
--
ALTER TABLE `role_permission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `role_permission_role_id_permission_id_unique` (`role_id`,`permission_id`),
  ADD KEY `role_permission_permission_id_foreign` (`permission_id`);

--
-- Indexes for table `sales`
--
ALTER TABLE `sales`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `sales_invoice_number_unique` (`invoice_number`),
  ADD KEY `sales_customer_id_foreign` (`customer_id`),
  ADD KEY `sales_warehouse_id_foreign` (`warehouse_id`),
  ADD KEY `sales_created_by_foreign` (`created_by`);

--
-- Indexes for table `sales_items`
--
ALTER TABLE `sales_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sales_items_sale_id_foreign` (`sale_id`),
  ADD KEY `sales_items_product_id_foreign` (`product_id`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indexes for table `settings`
--
ALTER TABLE `settings`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `settings_key_unique` (`key`);

--
-- Indexes for table `stocks`
--
ALTER TABLE `stocks`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `stocks_product_id_warehouse_id_unique` (`product_id`,`warehouse_id`),
  ADD KEY `stocks_warehouse_id_foreign` (`warehouse_id`);

--
-- Indexes for table `stock_ledgers`
--
ALTER TABLE `stock_ledgers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `stock_ledgers_warehouse_id_foreign` (`warehouse_id`),
  ADD KEY `stock_ledgers_created_by_foreign` (`created_by`),
  ADD KEY `stock_ledgers_product_id_warehouse_id_transaction_date_index` (`product_id`,`warehouse_id`,`transaction_date`),
  ADD KEY `stock_ledgers_reference_type_reference_id_index` (`reference_type`,`reference_id`);

--
-- Indexes for table `suppliers`
--
ALTER TABLE `suppliers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `suppliers_code_unique` (`code`),
  ADD KEY `suppliers_created_by_foreign` (`created_by`),
  ADD KEY `suppliers_updated_by_foreign` (`updated_by`);

--
-- Indexes for table `units`
--
ALTER TABLE `units`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `units_code_unique` (`code`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- Indexes for table `user_role`
--
ALTER TABLE `user_role`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_role_user_id_role_id_unique` (`user_id`,`role_id`),
  ADD KEY `user_role_role_id_foreign` (`role_id`);

--
-- Indexes for table `visitor_logs`
--
ALTER TABLE `visitor_logs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `warehouses`
--
ALTER TABLE `warehouses`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `warehouses_code_unique` (`code`),
  ADD KEY `warehouses_manager_id_foreign` (`manager_id`),
  ADD KEY `warehouses_created_by_foreign` (`created_by`),
  ADD KEY `warehouses_updated_by_foreign` (`updated_by`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `login_logs`
--
ALTER TABLE `login_logs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=47;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=61;

--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `purchases`
--
ALTER TABLE `purchases`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT for table `purchase_items`
--
ALTER TABLE `purchase_items`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=77;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `role_permission`
--
ALTER TABLE `role_permission`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=55;

--
-- AUTO_INCREMENT for table `sales`
--
ALTER TABLE `sales`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=102;

--
-- AUTO_INCREMENT for table `sales_items`
--
ALTER TABLE `sales_items`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=299;

--
-- AUTO_INCREMENT for table `settings`
--
ALTER TABLE `settings`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `stocks`
--
ALTER TABLE `stocks`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `stock_ledgers`
--
ALTER TABLE `stock_ledgers`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=376;

--
-- AUTO_INCREMENT for table `suppliers`
--
ALTER TABLE `suppliers`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `units`
--
ALTER TABLE `units`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `user_role`
--
ALTER TABLE `user_role`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `visitor_logs`
--
ALTER TABLE `visitor_logs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `warehouses`
--
ALTER TABLE `warehouses`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `categories`
--
ALTER TABLE `categories`
  ADD CONSTRAINT `categories_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `categories_updated_by_foreign` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `customers`
--
ALTER TABLE `customers`
  ADD CONSTRAINT `customers_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `customers_updated_by_foreign` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `login_logs`
--
ALTER TABLE `login_logs`
  ADD CONSTRAINT `login_logs_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `payments`
--
ALTER TABLE `payments`
  ADD CONSTRAINT `payments_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `products_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `products_unit_id_foreign` FOREIGN KEY (`unit_id`) REFERENCES `units` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `products_updated_by_foreign` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `purchases`
--
ALTER TABLE `purchases`
  ADD CONSTRAINT `purchases_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `purchases_supplier_id_foreign` FOREIGN KEY (`supplier_id`) REFERENCES `suppliers` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `purchases_updated_by_foreign` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `purchases_warehouse_id_foreign` FOREIGN KEY (`warehouse_id`) REFERENCES `warehouses` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `purchase_items`
--
ALTER TABLE `purchase_items`
  ADD CONSTRAINT `purchase_items_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `purchase_items_purchase_id_foreign` FOREIGN KEY (`purchase_id`) REFERENCES `purchases` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `role_permission`
--
ALTER TABLE `role_permission`
  ADD CONSTRAINT `role_permission_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `role_permission_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `sales`
--
ALTER TABLE `sales`
  ADD CONSTRAINT `sales_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `sales_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `sales_warehouse_id_foreign` FOREIGN KEY (`warehouse_id`) REFERENCES `warehouses` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `sales_items`
--
ALTER TABLE `sales_items`
  ADD CONSTRAINT `sales_items_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `sales_items_sale_id_foreign` FOREIGN KEY (`sale_id`) REFERENCES `sales` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `stocks`
--
ALTER TABLE `stocks`
  ADD CONSTRAINT `stocks_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `stocks_warehouse_id_foreign` FOREIGN KEY (`warehouse_id`) REFERENCES `warehouses` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `stock_ledgers`
--
ALTER TABLE `stock_ledgers`
  ADD CONSTRAINT `stock_ledgers_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `stock_ledgers_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `stock_ledgers_warehouse_id_foreign` FOREIGN KEY (`warehouse_id`) REFERENCES `warehouses` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `suppliers`
--
ALTER TABLE `suppliers`
  ADD CONSTRAINT `suppliers_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `suppliers_updated_by_foreign` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `user_role`
--
ALTER TABLE `user_role`
  ADD CONSTRAINT `user_role_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `user_role_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `warehouses`
--
ALTER TABLE `warehouses`
  ADD CONSTRAINT `warehouses_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `warehouses_manager_id_foreign` FOREIGN KEY (`manager_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `warehouses_updated_by_foreign` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
