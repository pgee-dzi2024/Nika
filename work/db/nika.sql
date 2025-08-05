-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1
-- Време на генериране:  5 авг 2025 в 17:52
-- Версия на сървъра: 10.4.32-MariaDB
-- Версия на PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данни: `nika`
--

-- --------------------------------------------------------

--
-- Структура на таблица `authtoken_token`
--

CREATE TABLE `authtoken_token` (
  `key` varchar(40) NOT NULL,
  `created` datetime(6) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Схема на данните от таблица `authtoken_token`
--

INSERT INTO `authtoken_token` (`key`, `created`, `user_id`) VALUES
('6d3453048b4a3e5438fcf7201c483ab210a39942', '2025-08-04 21:19:17.910056', 1);

-- --------------------------------------------------------

--
-- Структура на таблица `auth_group`
--

CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Структура на таблица `auth_group_permissions`
--

CREATE TABLE `auth_group_permissions` (
  `id` bigint(20) NOT NULL,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Структура на таблица `auth_permission`
--

CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Схема на данните от таблица `auth_permission`
--

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
(1, 'Can add log entry', 1, 'add_logentry'),
(2, 'Can change log entry', 1, 'change_logentry'),
(3, 'Can delete log entry', 1, 'delete_logentry'),
(4, 'Can view log entry', 1, 'view_logentry'),
(5, 'Can add permission', 2, 'add_permission'),
(6, 'Can change permission', 2, 'change_permission'),
(7, 'Can delete permission', 2, 'delete_permission'),
(8, 'Can view permission', 2, 'view_permission'),
(9, 'Can add group', 3, 'add_group'),
(10, 'Can change group', 3, 'change_group'),
(11, 'Can delete group', 3, 'delete_group'),
(12, 'Can view group', 3, 'view_group'),
(13, 'Can add user', 4, 'add_user'),
(14, 'Can change user', 4, 'change_user'),
(15, 'Can delete user', 4, 'delete_user'),
(16, 'Can view user', 4, 'view_user'),
(17, 'Can add content type', 5, 'add_contenttype'),
(18, 'Can change content type', 5, 'change_contenttype'),
(19, 'Can delete content type', 5, 'delete_contenttype'),
(20, 'Can view content type', 5, 'view_contenttype'),
(21, 'Can add session', 6, 'add_session'),
(22, 'Can change session', 6, 'change_session'),
(23, 'Can delete session', 6, 'delete_session'),
(24, 'Can view session', 6, 'view_session'),
(25, 'Can add Системен параметър', 7, 'add_sysparam'),
(26, 'Can change Системен параметър', 7, 'change_sysparam'),
(27, 'Can delete Системен параметър', 7, 'delete_sysparam'),
(28, 'Can view Системен параметър', 7, 'view_sysparam'),
(29, 'Can add Състезател', 8, 'add_athlete'),
(30, 'Can change Състезател', 8, 'change_athlete'),
(31, 'Can delete Състезател', 8, 'delete_athlete'),
(32, 'Can view Състезател', 8, 'view_athlete'),
(33, 'Can add Група/категория', 9, 'add_group'),
(34, 'Can change Група/категория', 9, 'change_group'),
(35, 'Can delete Група/категория', 9, 'delete_group'),
(36, 'Can view Група/категория', 9, 'view_group'),
(37, 'Can add competition', 10, 'add_competition'),
(38, 'Can change competition', 10, 'change_competition'),
(39, 'Can delete competition', 10, 'delete_competition'),
(40, 'Can view competition', 10, 'view_competition'),
(41, 'Can add Token', 11, 'add_token'),
(42, 'Can change Token', 11, 'change_token'),
(43, 'Can delete Token', 11, 'delete_token'),
(44, 'Can view Token', 11, 'view_token'),
(45, 'Can add Token', 12, 'add_tokenproxy'),
(46, 'Can change Token', 12, 'change_tokenproxy'),
(47, 'Can delete Token', 12, 'delete_tokenproxy'),
(48, 'Can view Token', 12, 'view_tokenproxy');

-- --------------------------------------------------------

--
-- Структура на таблица `auth_user`
--

CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Схема на данните от таблица `auth_user`
--

INSERT INTO `auth_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`) VALUES
(1, 'pbkdf2_sha256$600000$WRVKovSTGb2ZvqzgZjCbCF$N69TaCQClH5kugaW0ontEbIyUdM+atS8t3TVvMwTZWg=', '2025-08-02 19:25:24.537533', 1, 'nika_admin', '', '', '', 1, 1, '2025-07-28 09:02:22.129213');

-- --------------------------------------------------------

--
-- Структура на таблица `auth_user_groups`
--

CREATE TABLE `auth_user_groups` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Структура на таблица `auth_user_user_permissions`
--

CREATE TABLE `auth_user_user_permissions` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Структура на таблица `django_admin_log`
--

CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext DEFAULT NULL,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) UNSIGNED NOT NULL CHECK (`action_flag` >= 0),
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Схема на данните от таблица `django_admin_log`
--

INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES
(1, '2025-07-29 20:18:15.838212', '1', 'младежи младша възраст(12-16 г)', 1, '[{\"added\": {}}]', 9, 1),
(2, '2025-07-29 20:18:43.761560', '2', 'младежи старша възраст(17-19 г)', 1, '[{\"added\": {}}]', 9, 1),
(3, '2025-07-29 20:19:25.883495', '3', 'Елит(20-40 г)', 1, '[{\"added\": {}}]', 9, 1),
(4, '2025-07-29 20:20:19.290354', '4', 'мастър Елит(41-50 г)', 1, '[{\"added\": {}}]', 9, 1),
(5, '2025-07-29 20:20:51.404537', '5', 'Мастъри(51-60 г)', 1, '[{\"added\": {}}]', 9, 1),
(6, '2025-07-29 20:21:24.601780', '6', 'Най-опитен планинар(61+ г)', 1, '[{\"added\": {}}]', 9, 1),
(7, '2025-07-29 20:21:34.542669', '5', 'Мастър(51-60 г)', 2, '[{\"changed\": {\"fields\": [\"\\u0418\\u043c\\u0435 \\u043d\\u0430\\u0433\\u0440\\u0443\\u043f\\u0430\\u0442\\u0430\"]}}]', 9, 1),
(8, '2025-07-29 20:23:02.114115', '1', 'status: 0', 1, '[{\"added\": {}}]', 7, 1),
(9, '2025-07-29 20:26:41.633048', '2', 'competition: ТОДОРКА VERTICAL', 1, '[{\"added\": {}}]', 7, 1),
(10, '2025-07-30 07:17:44.899215', '4', 'Мастър Елит(41-50 г)', 2, '[{\"changed\": {\"fields\": [\"\\u0418\\u043c\\u0435 \\u043d\\u0430\\u0433\\u0440\\u0443\\u043f\\u0430\\u0442\\u0430\"]}}]', 9, 1),
(11, '2025-07-30 11:09:52.945742', '1', 'Иван Петров (88)', 1, '[{\"added\": {}}]', 8, 1),
(12, '2025-07-30 11:10:10.141414', '2', 'Петър Иванов (99)', 1, '[{\"added\": {}}]', 8, 1),
(13, '2025-07-31 14:03:30.623545', '1', 'Competition object (1)', 1, '[{\"added\": {}}]', 10, 1);

-- --------------------------------------------------------

--
-- Структура на таблица `django_content_type`
--

CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Схема на данните от таблица `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(1, 'admin', 'logentry'),
(3, 'auth', 'group'),
(2, 'auth', 'permission'),
(4, 'auth', 'user'),
(11, 'authtoken', 'token'),
(12, 'authtoken', 'tokenproxy'),
(5, 'contenttypes', 'contenttype'),
(8, 'main', 'athlete'),
(10, 'main', 'competition'),
(9, 'main', 'group'),
(7, 'main', 'sysparam'),
(6, 'sessions', 'session');

-- --------------------------------------------------------

--
-- Структура на таблица `django_migrations`
--

CREATE TABLE `django_migrations` (
  `id` bigint(20) NOT NULL,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Схема на данните от таблица `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'contenttypes', '0001_initial', '2025-07-28 08:59:34.998335'),
(2, 'auth', '0001_initial', '2025-07-28 08:59:36.018351'),
(3, 'admin', '0001_initial', '2025-07-28 08:59:36.277046'),
(4, 'admin', '0002_logentry_remove_auto_add', '2025-07-28 08:59:36.298107'),
(5, 'admin', '0003_logentry_add_action_flag_choices', '2025-07-28 08:59:36.316958'),
(6, 'contenttypes', '0002_remove_content_type_name', '2025-07-28 08:59:36.453849'),
(7, 'auth', '0002_alter_permission_name_max_length', '2025-07-28 08:59:36.578588'),
(8, 'auth', '0003_alter_user_email_max_length', '2025-07-28 08:59:36.612527'),
(9, 'auth', '0004_alter_user_username_opts', '2025-07-28 08:59:36.630742'),
(10, 'auth', '0005_alter_user_last_login_null', '2025-07-28 08:59:36.718378'),
(11, 'auth', '0006_require_contenttypes_0002', '2025-07-28 08:59:36.727331'),
(12, 'auth', '0007_alter_validators_add_error_messages', '2025-07-28 08:59:36.747745'),
(13, 'auth', '0008_alter_user_username_max_length', '2025-07-28 08:59:36.781749'),
(14, 'auth', '0009_alter_user_last_name_max_length', '2025-07-28 08:59:36.817403'),
(15, 'auth', '0010_alter_group_name_max_length', '2025-07-28 08:59:36.856990'),
(16, 'auth', '0011_update_proxy_permissions', '2025-07-28 08:59:36.879992'),
(17, 'auth', '0012_alter_user_first_name_max_length', '2025-07-28 08:59:36.910084'),
(18, 'sessions', '0001_initial', '2025-07-28 08:59:36.966665'),
(19, 'main', '0001_initial', '2025-07-29 20:15:27.006199'),
(20, 'main', '0002_alter_athlete_bib_number_alter_athlete_group_and_more', '2025-07-30 22:14:18.186706'),
(21, 'main', '0003_competition', '2025-07-31 13:31:15.651957'),
(22, 'main', '0004_delete_sysparam_alter_athlete_options_and_more', '2025-07-31 15:47:01.972261'),
(23, 'main', '0005_alter_athlete_result_time', '2025-07-31 17:24:21.463846'),
(24, 'main', '0006_alter_athlete_name', '2025-07-31 18:04:54.653869'),
(25, 'main', '0007_alter_athlete_result_time', '2025-07-31 18:29:51.558444'),
(26, 'main', '0008_alter_athlete_result_time', '2025-07-31 19:27:35.398302'),
(27, 'main', '0009_athlete_user', '2025-08-04 20:43:59.834925'),
(28, 'authtoken', '0001_initial', '2025-08-04 21:14:14.653454'),
(29, 'authtoken', '0002_auto_20160226_1747', '2025-08-04 21:14:14.672636'),
(30, 'authtoken', '0003_tokenproxy', '2025-08-04 21:14:14.676665'),
(31, 'authtoken', '0004_alter_tokenproxy_options', '2025-08-04 21:14:14.681171');

-- --------------------------------------------------------

--
-- Структура на таблица `django_session`
--

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Схема на данните от таблица `django_session`
--

INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
('a0l2jkig0sjn2s2cy7kotek3bhcvfjgx', '.eJxVjMsOwiAQRf-FtSE8WgZcuvcbyAxMpWogKe3K-O_apAvd3nPOfYmI21ri1nmJcxZnocXpdyNMD647yHestyZTq-syk9wVedAury3z83K4fwcFe_nWwTlQqIJJARAzWJwMas8YvNdJEQViHs2ABqyGnJyhEclrmpRNMGTx_gDjjjgm:1uiHrA:1EZpeJfcBcilA9zXnrLgcGXHxIAX3zY661wwRChclfw', '2025-08-16 19:25:24.540076'),
('xie79wdivtnlywfzzgajew6j30q2ira7', '.eJxVjMsOwiAQRf-FtSE8WgZcuvcbyAxMpWogKe3K-O_apAvd3nPOfYmI21ri1nmJcxZnocXpdyNMD647yHestyZTq-syk9wVedAury3z83K4fwcFe_nWwTlQqIJJARAzWJwMas8YvNdJEQViHs2ABqyGnJyhEclrmpRNMGTx_gDjjjgm:1ugJlM:1RdfDgutybsOwO4jwoLv0NKxsPGJhWc-8bR_gvqaS2E', '2025-08-11 09:03:16.705860');

-- --------------------------------------------------------

--
-- Структура на таблица `main_athlete`
--

CREATE TABLE `main_athlete` (
  `id` bigint(20) NOT NULL,
  `name` varchar(80) NOT NULL,
  `bib_number` int(11) NOT NULL,
  `result_time` varchar(10) NOT NULL,
  `group_id` bigint(20) NOT NULL,
  `num` smallint(5) UNSIGNED DEFAULT NULL CHECK (`num` >= 0),
  `status` smallint(5) UNSIGNED NOT NULL CHECK (`status` >= 0),
  `user` varchar(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Схема на данните от таблица `main_athlete`
--

INSERT INTO `main_athlete` (`id`, `name`, `bib_number`, `result_time`, `group_id`, `num`, `status`, `user`) VALUES
(1, 'Иван Георгиев', 101, '0:00:00.0', 3, 48, 2, 'М'),
(2, 'Петър Иванов', 99, '0:00:00.0', 4, 999, 1, 'М'),
(3, 'Георги Георгиев', 21, '0:00:00.0', 6, 999, 1, 'М'),
(5, 'Виктор Василев', 55, '0:00:00.0', 3, 999, 1, 'М'),
(7, 'Тодор Тодоров', 1, '0:00:00.0', 6, 999, 1, 'М'),
(8, 'Петър Петров', 2, '0:00:00.0', 3, 999, 1, 'М'),
(9, 'Славчо Друмев', 5, '0:00:00.0', 3, 999, 1, 'М'),
(10, 'Минчо Празников', 6, '0:00:00.0', 6, 999, 1, 'М'),
(11, 'Питър Пан', 8, '0:00:00.0', 3, 999, 1, 'М'),
(12, 'Васил Викторов', 32, '0:00:00.0', 3, 999, 1, 'М'),
(13, 'Васил Василев', 35, '0:00:00.0', 4, 49, 2, 'М'),
(14, 'Светослав Карагеоргиев', 66, '0:02:58.5', 4, 0, 3, 'М'),
(15, 'Мария Иванова', 7, '0:00:00.0', 2, 47, 2, 'М'),
(16, 'Георги Георгиев', 9, '0:03:31.4', 5, 0, 3, 'М'),
(17, 'Петко Петров', 3, '0:00:00.0', 5, 999, 1, 'М');

-- --------------------------------------------------------

--
-- Структура на таблица `main_competition`
--

CREATE TABLE `main_competition` (
  `id` bigint(20) NOT NULL,
  `name` varchar(100) NOT NULL,
  `start_time` datetime(6) DEFAULT NULL,
  `next_num` smallint(5) UNSIGNED DEFAULT NULL CHECK (`next_num` >= 0),
  `status` smallint(5) UNSIGNED DEFAULT NULL CHECK (`status` >= 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Схема на данните от таблица `main_competition`
--

INSERT INTO `main_competition` (`id`, `name`, `start_time`, `next_num`, `status`) VALUES
(1, 'ТОДОРКА VERTICAL', '2025-08-05 13:14:29.651638', 50, 3);

-- --------------------------------------------------------

--
-- Структура на таблица `main_group`
--

CREATE TABLE `main_group` (
  `id` bigint(20) NOT NULL,
  `name` varchar(30) NOT NULL,
  `comment` varchar(80) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Схема на данните от таблица `main_group`
--

INSERT INTO `main_group` (`id`, `name`, `comment`) VALUES
(1, 'младежи младша възраст', '12-16 г'),
(2, 'младежи старша възраст', '17-19 г'),
(3, 'Елит', '20-40 г'),
(4, 'Мастър Елит', '41-50 г'),
(5, 'Мастър', '51-60 г'),
(6, 'Най-опитен планинар', '61+ г');

--
-- Indexes for dumped tables
--

--
-- Индекси за таблица `authtoken_token`
--
ALTER TABLE `authtoken_token`
  ADD PRIMARY KEY (`key`),
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- Индекси за таблица `auth_group`
--
ALTER TABLE `auth_group`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Индекси за таблица `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  ADD KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`);

--
-- Индекси за таблица `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`);

--
-- Индекси за таблица `auth_user`
--
ALTER TABLE `auth_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Индекси за таблица `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  ADD KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`);

--
-- Индекси за таблица `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  ADD KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`);

--
-- Индекси за таблица `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  ADD KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`);

--
-- Индекси за таблица `django_content_type`
--
ALTER TABLE `django_content_type`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`);

--
-- Индекси за таблица `django_migrations`
--
ALTER TABLE `django_migrations`
  ADD PRIMARY KEY (`id`);

--
-- Индекси за таблица `django_session`
--
ALTER TABLE `django_session`
  ADD PRIMARY KEY (`session_key`),
  ADD KEY `django_session_expire_date_a5c62663` (`expire_date`);

--
-- Индекси за таблица `main_athlete`
--
ALTER TABLE `main_athlete`
  ADD PRIMARY KEY (`id`),
  ADD KEY `main_athlete_group_id_732d8675_fk_main_group_id` (`group_id`);

--
-- Индекси за таблица `main_competition`
--
ALTER TABLE `main_competition`
  ADD PRIMARY KEY (`id`);

--
-- Индекси за таблица `main_group`
--
ALTER TABLE `main_group`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `auth_group`
--
ALTER TABLE `auth_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_permission`
--
ALTER TABLE `auth_permission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;

--
-- AUTO_INCREMENT for table `auth_user`
--
ALTER TABLE `auth_user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `django_content_type`
--
ALTER TABLE `django_content_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `main_athlete`
--
ALTER TABLE `main_athlete`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `main_competition`
--
ALTER TABLE `main_competition`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `main_group`
--
ALTER TABLE `main_group`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Ограничения за дъмпнати таблици
--

--
-- Ограничения за таблица `authtoken_token`
--
ALTER TABLE `authtoken_token`
  ADD CONSTRAINT `authtoken_token_user_id_35299eff_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Ограничения за таблица `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);

--
-- Ограничения за таблица `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`);

--
-- Ограничения за таблица `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  ADD CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Ограничения за таблица `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Ограничения за таблица `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Ограничения за таблица `main_athlete`
--
ALTER TABLE `main_athlete`
  ADD CONSTRAINT `main_athlete_group_id_732d8675_fk_main_group_id` FOREIGN KEY (`group_id`) REFERENCES `main_group` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
