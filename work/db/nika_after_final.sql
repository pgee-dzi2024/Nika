-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1
-- Време на генериране:  9 авг 2025 в 19:29
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
(48, 'Can view Token', 12, 'view_tokenproxy'),
(49, 'Can add Снимка', 13, 'add_athletephoto'),
(50, 'Can change Снимка', 13, 'change_athletephoto'),
(51, 'Can delete Снимка', 13, 'delete_athletephoto'),
(52, 'Can view Снимка', 13, 'view_athletephoto');

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
(1, 'pbkdf2_sha256$600000$WRVKovSTGb2ZvqzgZjCbCF$N69TaCQClH5kugaW0ontEbIyUdM+atS8t3TVvMwTZWg=', '2025-08-08 15:57:32.545476', 1, 'nika_admin', '', '', '', 1, 1, '2025-07-28 09:02:22.129213');

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
(13, '2025-07-31 14:03:30.623545', '1', 'Competition object (1)', 1, '[{\"added\": {}}]', 10, 1),
(14, '2025-08-08 15:58:13.496589', '7', 'Планинска легенда()', 1, '[{\"added\": {}}]', 9, 1),
(15, '2025-08-08 17:02:26.042756', '27', 'Марко Ноков (3)', 2, '[{\"changed\": {\"fields\": [\"\\u0418\\u043c\\u0435 \\u043d\\u0430 \\u0441\\u044a\\u0441\\u0442\\u0435\\u0437\\u0430\\u0442\\u0435\\u043b\\u044f\"]}}]', 8, 1),
(16, '2025-08-08 17:04:12.433430', '104', 'Михаела Димитрова (19)', 2, '[{\"changed\": {\"fields\": [\"\\u0418\\u043c\\u0435 \\u043d\\u0430 \\u0441\\u044a\\u0441\\u0442\\u0435\\u0437\\u0430\\u0442\\u0435\\u043b\\u044f\"]}}]', 8, 1),
(17, '2025-08-08 17:05:40.961665', '229', 'Божидар Къртунов (36)', 2, '[{\"changed\": {\"fields\": [\"\\u0418\\u043c\\u0435 \\u043d\\u0430 \\u0441\\u044a\\u0441\\u0442\\u0435\\u0437\\u0430\\u0442\\u0435\\u043b\\u044f\"]}}]', 8, 1),
(18, '2025-08-08 17:06:17.403770', '47', 'Борис Кюшев (37)', 2, '[{\"changed\": {\"fields\": [\"\\u0418\\u043c\\u0435 \\u043d\\u0430 \\u0441\\u044a\\u0441\\u0442\\u0435\\u0437\\u0430\\u0442\\u0435\\u043b\\u044f\"]}}]', 8, 1),
(19, '2025-08-08 17:06:49.668925', '194', 'Велизар Блъсков (41)', 2, '[{\"changed\": {\"fields\": [\"\\u0418\\u043c\\u0435 \\u043d\\u0430 \\u0441\\u044a\\u0441\\u0442\\u0435\\u0437\\u0430\\u0442\\u0435\\u043b\\u044f\"]}}]', 8, 1),
(20, '2025-08-08 17:07:20.059472', '227', 'Велияна Лозанова (43)', 2, '[{\"changed\": {\"fields\": [\"\\u0418\\u043c\\u0435 \\u043d\\u0430 \\u0441\\u044a\\u0441\\u0442\\u0435\\u0437\\u0430\\u0442\\u0435\\u043b\\u044f\"]}}]', 8, 1),
(21, '2025-08-08 17:07:46.238493', '202', 'Венелина Захариева (45)', 2, '[{\"changed\": {\"fields\": [\"\\u041f\\u043e\\u043b\"]}}]', 8, 1),
(22, '2025-08-08 17:13:39.721401', '82', 'Крисиян Стоянов (112)', 2, '[]', 8, 1),
(23, '2025-08-08 17:13:57.040760', '82', 'Кристиян Стоянов (112)', 2, '[{\"changed\": {\"fields\": [\"\\u0418\\u043c\\u0435 \\u043d\\u0430 \\u0441\\u044a\\u0441\\u0442\\u0435\\u0437\\u0430\\u0442\\u0435\\u043b\\u044f\"]}}]', 8, 1),
(24, '2025-08-08 17:17:30.956536', '187', 'Славчо Тричков (162)', 2, '[{\"changed\": {\"fields\": [\"\\u0418\\u043c\\u0435 \\u043d\\u0430 \\u0441\\u044a\\u0441\\u0442\\u0435\\u0437\\u0430\\u0442\\u0435\\u043b\\u044f\"]}}]', 8, 1),
(25, '2025-08-08 17:18:17.040263', '199', 'Станислав Крушовалиев (165)', 2, '[{\"changed\": {\"fields\": [\"\\u0418\\u043c\\u0435 \\u043d\\u0430 \\u0441\\u044a\\u0441\\u0442\\u0435\\u0437\\u0430\\u0442\\u0435\\u043b\\u044f\"]}}]', 8, 1),
(26, '2025-08-08 17:19:24.519039', '176', 'Аглика Бяндова (175)', 2, '[{\"changed\": {\"fields\": [\"\\u041f\\u043e\\u043b\"]}}]', 8, 1);

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
(13, 'main', 'athletephoto'),
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
(31, 'authtoken', '0004_alter_tokenproxy_options', '2025-08-04 21:14:14.681171'),
(32, 'main', '0010_athletephoto', '2025-08-05 19:59:21.752445'),
(33, 'main', '0011_remove_athletephoto_uploaded_at', '2025-08-05 20:06:11.072120'),
(34, 'main', '0012_athlete_gender_alter_athlete_status', '2025-08-07 19:56:50.900659');

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
('37g7cxx1befhpzvrbs9nudi3esydbca8', '.eJxVjMsOwiAQRf-FtSE8WgZcuvcbyAxMpWogKe3K-O_apAvd3nPOfYmI21ri1nmJcxZnocXpdyNMD647yHestyZTq-syk9wVedAury3z83K4fwcFe_nWwTlQqIJJARAzWJwMas8YvNdJEQViHs2ABqyGnJyhEclrmpRNMGTx_gDjjjgm:1ujOSb:r13KIJuYgtJqBOMbn4aJNGTjS3dMihT-PFkIA4gbfjM', '2025-08-19 20:40:37.845920'),
('a0l2jkig0sjn2s2cy7kotek3bhcvfjgx', '.eJxVjMsOwiAQRf-FtSE8WgZcuvcbyAxMpWogKe3K-O_apAvd3nPOfYmI21ri1nmJcxZnocXpdyNMD647yHestyZTq-syk9wVedAury3z83K4fwcFe_nWwTlQqIJJARAzWJwMas8YvNdJEQViHs2ABqyGnJyhEclrmpRNMGTx_gDjjjgm:1uiHrA:1EZpeJfcBcilA9zXnrLgcGXHxIAX3zY661wwRChclfw', '2025-08-16 19:25:24.540076'),
('r9bietdu2p2i5o77men5va2z7jf0yvsp', '.eJxVjMsOwiAQRf-FtSE8WgZcuvcbyAxMpWogKe3K-O_apAvd3nPOfYmI21ri1nmJcxZnocXpdyNMD647yHestyZTq-syk9wVedAury3z83K4fwcFe_nWwTlQqIJJARAzWJwMas8YvNdJEQViHs2ABqyGnJyhEclrmpRNMGTx_gDjjjgm:1ukPTI:bwlcLNrkgOdHSQIip9uhsoCyZLtvlEoAApDNFZX5NNU', '2025-08-22 15:57:32.550822'),
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
  `status` smallint(6) NOT NULL,
  `user` varchar(1) NOT NULL,
  `gender` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Схема на данните от таблица `main_athlete`
--

INSERT INTO `main_athlete` (`id`, `name`, `bib_number`, `result_time`, `group_id`, `num`, `status`, `user`, `gender`) VALUES
(18, 'Верадина Начева', 14, '0:48:32.2', 4, 0, 3, 'M', 0),
(19, 'Станислав Чолаков', 9, '0:39:57.5', 3, 0, 3, 'M', 1),
(20, 'Емил Димитров', 88, '0:55:54.5', 4, 0, 3, 'M', 1),
(21, 'Влади Веков', 214, '1:03:40.6', 4, 0, 3, 'M', 1),
(22, 'Момчил Фичев', 7, '0:47:51.3', 3, 0, 3, 'M', 1),
(23, 'Виктор Василев', 48, 'DQ', 3, 999, 0, 'A', 1),
(24, 'Кристиян Кобер', 2, '0:43:59.8', 5, 0, 3, 'M', 1),
(25, 'Калинка Мишева', 188, 'DQ', 4, 999, 0, 'A', 0),
(26, 'Сабина  Гълъбова', 158, '1:20:32.5', 3, 0, 3, 'M', 0),
(27, 'Марко Ноков', 3, '0:39:06.7', 1, 0, 3, 'M', 1),
(28, 'Емил Гьорев', 179, 'DQ', 3, 999, 0, 'A', 1),
(29, 'Димитър Дишев', 75, '1:37:45.5', 3, 0, 3, 'M', 1),
(30, 'Йоана Петроу', 187, 'DQ', 3, 999, 0, 'A', 0),
(32, 'Георги Танев', 62, '1:03:35.6', 3, 0, 3, 'M', 1),
(33, 'Момчил Момчилов', 128, 'DQ', 5, 999, 0, 'A', 1),
(34, 'Александър Попов', 27, 'DQ', 3, 999, 0, 'A', 1),
(35, 'Силвия Стефанова', 160, 'DQ', 3, 999, 0, 'A', 0),
(36, 'Андрей Николов', 32, '0:59:07.1', 3, 0, 3, 'M', 1),
(37, 'Димитриус Папаникус', 11, 'DQ', 3, 999, 0, 'A', 1),
(38, 'Памела Узунова', 142, '1:23:08.3', 3, 0, 3, 'M', 0),
(39, 'Божидар Иванчев', 35, '0:55:25.8', 3, 0, 3, 'M', 1),
(40, 'Славчо Гаврилов', 161, 'DQ', 4, 999, 0, 'A', 1),
(41, 'Весела Димитрова', 46, '1:10:27.7', 5, 0, 3, 'M', 0),
(42, 'Анелия Партенова', 33, '1:08:00.8', 3, 0, 3, 'M', 0),
(43, 'Ангел Праматаров', 30, '0:54:34.7', 3, 0, 3, 'M', 1),
(44, 'Петър Тодоров', 204, 'DQ', 4, 999, 0, 'A', 1),
(45, 'Красимир Стефанов', 191, 'DQ', 4, 999, 0, 'A', 1),
(46, 'Борислав Въчков', 177, '0:57:46.7', 3, 0, 3, 'M', 1),
(47, 'Борис Кюшев', 37, '0:56:00.1', 1, 0, 3, 'M', 1),
(48, 'Асен Радулов', 1, '0:40:08.9', 3, 0, 3, 'M', 1),
(49, 'Деян Ангеловски', 69, 'DQ', 3, 999, 0, 'A', 1),
(50, 'Юлиан Иванов', 173, 'DQ', 4, 999, 0, 'A', 1),
(51, 'Нина Чолева', 138, '1:08:18.9', 4, 0, 3, 'M', 0),
(52, 'Лазар Варин', 113, '1:27:57.9', 3, 0, 3, 'M', 1),
(53, 'Валентин Василев', 40, '1:09:39.6', 3, 0, 3, 'M', 1),
(54, 'Александър Грънчаров', 24, '1:05:58.2', 4, 0, 3, 'M', 1),
(55, 'Глория Русева', 64, 'DQ', 3, 999, 0, 'A', 0),
(56, 'Емил Гьорев', 87, '0:45:09.3', 3, 0, 3, 'M', 1),
(57, 'Георги Александров', 57, 'DQ', 4, 999, 0, 'A', 1),
(58, 'Виктор Китин', 49, 'DQ', 3, 999, 0, 'A', 1),
(59, 'Гошо Иванов', 183, 'DQ', 4, 999, 0, 'A', 1),
(60, 'Ирина Горанова', 103, 'DQ', 4, 999, 0, 'A', 0),
(61, 'Александър Димитров', 25, 'DQ', 4, 999, 0, 'A', 1),
(62, 'Иван Каназирев', 96, 'DQ', 3, 999, 0, 'A', 1),
(63, 'Георги Турлаков', 63, 'DQ', 3, 999, 0, 'A', 1),
(64, 'Александър Шопов', 150, '1:31:44.4', 6, 0, 3, 'M', 1),
(65, 'Слави Асенов', 8, '1:16:55.1', 4, 0, 3, 'M', 1),
(66, 'Юлиан Валентинов Иванов', 172, '0:53:51.9', 4, 0, 3, 'M', 1),
(67, 'Иван Иванов', 95, 'DQ', 4, 999, 0, 'A', 1),
(68, 'Асен Асенов', 207, '1:35:12.8', 4, 0, 3, 'M', 1),
(69, 'Павло Левко', 203, '1:11:06.6', 3, 0, 3, 'M', 1),
(70, 'Момчил Блъсков', 127, 'DQ', 3, 999, 0, 'A', 1),
(71, 'Надежда Маркова', 130, '1:00:38.7', 3, 0, 3, 'M', 0),
(72, 'Илиян Петков', 102, '0:56:19.1', 4, 0, 3, 'M', 1),
(73, 'Мартин Сугарев', 124, '1:20:26.6', 3, 0, 3, 'M', 1),
(74, 'Петър Галчев', 145, 'DQ', 4, 999, 0, 'A', 1),
(75, 'Никола Кръстев Ръжев', 134, '0:49:35.3', 1, 0, 3, 'M', 1),
(76, 'Даниела Маринова', 66, 'DQ', 4, 999, 0, 'A', 0),
(77, 'Димирър Търев', 79, 'DQ', 3, 999, 0, 'A', 1),
(78, 'Борислав Чолев', 39, 'DQ', 3, 999, 0, 'A', 1),
(79, 'Росен Стоянов', 157, '0:57:38.4', 3, 0, 3, 'M', 1),
(80, 'Емил Филипов', 90, '1:00:20.7', 4, 0, 3, 'M', 1),
(81, 'Александър Христов', 29, 'DQ', 3, 999, 0, 'A', 1),
(82, 'Кристиян Стоянов', 112, '1:07:36.5', 3, 0, 3, 'M', 1),
(83, 'Илияна Стефанова', 16, '0:57:18.2', 3, 0, 3, 'M', 0),
(84, 'Мартин Малечков', 122, '1:09:11.7', 3, 0, 3, 'M', 1),
(85, 'Ивайло Пейнов', 6, 'DQ', 2, 999, 0, 'A', 1),
(86, 'Ивона Михайлова', 15, '0:54:52.8', 4, 0, 3, 'M', 0),
(87, 'Павлин Беев', 141, '1:06:07.6', 3, 0, 3, 'M', 1),
(88, 'Виктор Стефанов', 4, 'DQ', 4, 999, 0, 'A', 1),
(89, 'Даниела Христова', 67, 'DQ', 5, 999, 0, 'A', 0),
(90, 'Иван Шопов', 100, 'DQ', 3, 999, 0, 'A', 1),
(91, 'Христо Боянов', 185, '2:05:01.9', 3, 0, 3, 'M', 1),
(92, 'Райна Коюва', 208, '1:27:43.8', 4, 0, 3, 'M', 0),
(93, 'Иван Христов', 99, '0:50:03.8', 3, 0, 3, 'M', 1),
(94, 'Емил Хедков', 89, '0:50:23.1', 4, 0, 3, 'M', 1),
(95, 'Марина Анастасова', 17, '0:58:50.8', 2, 0, 3, 'M', 0),
(96, 'Никола Френчев', 199, '0:57:16.0', 1, 0, 3, 'M', 1),
(97, 'Красимир Маринов', 110, 'DQ', 3, 999, 0, 'A', 1),
(98, 'Надежда Крумова', 129, 'DQ', 3, 999, 0, 'A', 0),
(99, 'Леасабрина Кауфман', 21, 'DQ', 3, 999, 0, 'A', 0),
(100, 'Данаил Павлов', 65, '1:06:55.8', 3, 0, 3, 'M', 1),
(101, 'Невелина Павлова', 131, '1:06:59.5', 3, 0, 3, 'M', 0),
(102, 'Петя Бандева', 206, 'DQ', 3, 999, 0, 'A', 0),
(103, 'Стамена Вълчева', 164, '0:49:22.6', 5, 0, 3, 'M', 0),
(104, 'Михаела Димитрова', 19, '1:02:38.1', 3, 0, 3, 'M', 0),
(105, 'Тихомир Христов', 169, '1:06:06.3', 3, 0, 3, 'M', 1),
(106, 'Никол Калчева', 133, '1:41:31.3', 3, 0, 3, 'M', 0),
(107, 'Борислав Димитров', 38, '1:13:22.5', 5, 0, 3, 'M', 1),
(108, 'Мария Николова', 195, '0:45:55.1', 3, 0, 3, 'M', 0),
(109, 'Вилиян Петков', 52, '0:52:48.8', 3, 0, 3, 'M', 1),
(110, 'Цветан Бакърджиев', 10, '0:52:58.9', 4, 0, 3, 'M', 1),
(111, 'Теодора Станкова', 167, '0:47:08.8', 3, 0, 3, 'M', 0),
(112, 'Виктор Стефанов', 50, 'DQ', 2, 999, 0, 'A', 1),
(113, 'Мариана Денева', 118, '1:31:43.2', 5, 0, 3, 'M', 0),
(114, 'Виктория Тенева', 51, 'DQ', 3, 999, 0, 'A', 0),
(115, 'Дойчин Дойчев', 80, 'DQ', 2, 999, 0, 'A', 1),
(116, 'Огняна Бакърджиева', 20, 'DQ', 1, 999, 0, 'A', 0),
(117, 'Лазар Димитров', 193, '0:48:30.8', 3, 0, 3, 'M', 1),
(118, 'Петър Карамитов', 147, '1:01:30.8', 3, 0, 3, 'M', 1),
(119, 'Георги Стоянов', 61, '1:14:50.6', 3, 0, 3, 'M', 1),
(120, 'Николай Колев', 200, '0:44:22.9', 4, 0, 3, 'M', 1),
(121, 'Надя Гелова', 198, '1:10:46.4', 3, 0, 3, 'M', 0),
(122, 'Велислав Стоев', 213, '0:47:10.1', 3, 0, 3, 'M', 1),
(123, 'Жаклина Жекова', 186, '1:01:19.5', 3, 0, 3, 'M', 0),
(124, 'Светлин Игнатов', 211, 'DQ', 3, 999, 0, 'A', 1),
(125, 'Павел Марков', 140, '1:05:07.1', 3, 0, 3, 'M', 1),
(126, 'Лазар Кърчев', 114, '1:07:25.7', 3, 0, 3, 'M', 1),
(127, 'Делина Тенева', 70, '1:19:36.6', 3, 0, 3, 'M', 0),
(128, 'Емо Горянов', 181, 'DQ', 3, 999, 0, 'A', 1),
(129, 'Емилия Драгосинова', 91, '1:34:20.1', 4, 0, 3, 'M', 0),
(130, 'Радослав Дурев', 156, '1:09:04.2', 3, 0, 3, 'M', 1),
(131, 'Мария Михнева', 119, '1:01:57.8', 3, 0, 3, 'M', 0),
(132, 'Мария Хинкова', 18, 'DQ', 1, 999, 0, 'A', 0),
(133, 'Красимир Василев', 107, '1:02:00.7', 3, 0, 3, 'M', 1),
(134, 'Димитър Геогиев', 73, 'DQ', 7, 999, 0, 'A', 1),
(135, 'Елена Кемилева', 83, '1:00:51.7', 3, 0, 3, 'M', 0),
(136, 'Димитър Стоянов', 78, '1:32:16.8', 4, 0, 3, 'M', 1),
(137, 'Янко Месьов', 174, '1:01:47.5', 4, 0, 3, 'M', 1),
(138, 'Славчо Тумбев', 163, '1:03:15.8', 4, 0, 3, 'M', 1),
(139, 'Преслав Христов', 153, '1:01:15.1', 3, 0, 3, 'M', 1),
(140, 'Иван Попов', 98, 'DQ', 4, 999, 0, 'A', 1),
(141, 'Мартин Стоименов', 123, '1:04:01.1', 3, 0, 3, 'M', 1),
(142, 'Дарина Славчева', 68, 'DQ', 4, 999, 0, 'A', 0),
(143, 'Кирил Дамянов', 106, '1:09:30.3', 3, 0, 3, 'M', 1),
(144, 'Григор Григоров', 12, 'DQ', 2, 999, 0, 'A', 1),
(145, 'Калоян Николов', 104, 'DQ', 3, 999, 0, 'A', 1),
(146, 'Мъри Иванов', 197, 'DQ', 3, 999, 0, 'A', 1),
(147, 'Владимир Астарджиев', 55, '1:03:49.0', 3, 0, 3, 'M', 1),
(148, 'Виктор Василев', 47, 'DQ', 3, 999, 0, 'A', 1),
(149, 'Ани Томева', 34, '1:00:09.1', 3, 0, 3, 'M', 0),
(150, 'Дейвид Кларк', 178, '1:55:06.5', 6, 0, 3, 'M', 1),
(151, 'Робин Хамилтън', 209, '1:19:38.9', 6, 0, 3, 'M', 1),
(152, 'Мария Кларк', 194, 'DQ', 3, 999, 0, 'A', 0),
(153, 'Катя Глушкова', 189, '1:49:30.4', 5, 0, 3, 'M', 0),
(154, 'Николай Бенковски', 135, '1:06:22.1', 3, 0, 3, 'M', 1),
(155, 'Александър Димитров', 26, '1:20:06.5', 3, 0, 3, 'M', 1),
(156, 'Лора Божилова', 115, '1:51:39.8', 3, 0, 3, 'M', 0),
(157, 'Камелия Божилова', 105, '2:10:28.7', 4, 0, 3, 'M', 0),
(158, 'Димитър Мавродиев', 76, '0:55:16.4', 5, 0, 3, 'M', 1),
(159, 'Мехмед Мехмед', 126, 'DQ', 4, 999, 0, 'A', 1),
(160, 'Елена Татарска', 84, '1:17:23.9', 5, 0, 3, 'M', 0),
(161, 'Андрий Дерунов', 176, 'DQ', 5, 999, 0, 'A', 1),
(162, 'Красимир Гергов', 109, '1:00:15.7', 4, 0, 3, 'M', 1),
(163, 'Иван Пандинов', 97, 'DQ', 5, 999, 0, 'A', 1),
(164, 'Мартин Инчев', 121, '1:02:13.0', 3, 0, 3, 'M', 1),
(165, 'Паул Чапман', 202, '2:16:29.6', 5, 0, 3, 'M', 1),
(166, 'Трейси Пийт', 212, '2:17:25.5', 5, 0, 3, 'M', 0),
(167, 'Теодора Тодорова', 168, 'DQ', 3, 999, 0, 'A', 0),
(168, 'Мартин Тодоров', 125, '0:58:00.3', 2, 0, 3, 'M', 1),
(169, 'Стоян Мавродиев', 166, '0:54:17.8', 4, 0, 3, 'M', 1),
(170, 'Емилиян Френчев', 180, 'DQ', 4, 999, 0, 'A', 1),
(171, 'Владимир Ангелов', 53, '1:44:51.2', 4, 0, 3, 'M', 1),
(172, 'Владимир Ангелов', 54, '0:56:03.0', 2, 0, 3, 'M', 1),
(173, 'Диан Стайков', 72, '0:54:54.3', 3, 0, 3, 'M', 1),
(174, 'Николай Николов', 136, 'DQ', 3, 999, 0, 'A', 1),
(175, 'Кристина Стоименова', 111, '1:02:45.7', 3, 0, 3, 'M', 0),
(176, 'Аглика Бяндова', 175, '1:29:14.7', 3, 0, 3, 'M', 0),
(177, 'Петър Тодоров', 149, '0:58:33.6', 4, 0, 3, 'M', 1),
(178, 'Георги Котирков', 60, '0:59:43.6', 4, 0, 3, 'M', 1),
(179, 'Величка Котиркова', 42, '1:40:17.9', 4, 0, 3, 'M', 0),
(180, 'Хасан Сакалов', 184, 'DQ', 5, 999, 0, 'A', 1),
(181, 'Николай Христов', 137, '0:53:06.0', 4, 0, 3, 'M', 1),
(182, 'Магдалена Липева', 117, 'DQ', 3, 999, 0, 'A', 0),
(183, 'Деница Минчева', 71, '1:46:18.6', 3, 0, 3, 'M', 0),
(184, 'Ива Николова', 92, '1:15:59.2', 5, 0, 3, 'M', 0),
(185, 'Димитър Димитров', 74, '1:22:33.8', 4, 0, 3, 'M', 1),
(186, 'Пламена Аврамова', 152, 'DQ', 3, 999, 0, 'A', 0),
(187, 'Славчо Тричков', 162, '1:06:50.8', 4, 0, 3, 'M', 1),
(188, 'Здравко Кръстев', 5, 'DQ', 3, 999, 0, 'A', 1),
(189, 'Христо Топузов', 171, '1:08:52.7', 4, 0, 3, 'M', 1),
(190, 'Александър Топузов', 28, 'DQ', 3, 999, 0, 'A', 1),
(191, 'Костадин Ганчев', 190, '1:05:29.1', 4, 0, 3, 'M', 1),
(192, 'Люба Хлебарова', 116, '0:56:41.6', 6, 0, 3, 'M', 0),
(193, 'Гергана Божкова', 182, 'DQ', 3, 999, 0, 'A', 0),
(194, 'Велизар Блъсков', 41, '0:52:54.1', 3, 0, 3, 'M', 1),
(195, 'Елена Ташева', 85, '2:05:05.4', 5, 0, 3, 'M', 0),
(196, 'Димитър Мичков', 77, 'DQ', 3, 999, 0, 'A', 1),
(197, 'Драгомир Драгиев', 81, 'DQ', 4, 999, 0, 'A', 1),
(198, 'Мартин Добрев', 120, '1:16:46.8', 3, 0, 3, 'M', 1),
(199, 'Станислав Крушовалиев', 165, '1:07:50.0', 3, 0, 3, 'M', 1),
(200, 'Петър Рангелов', 148, '1:22:47.7', 4, 0, 3, 'M', 1),
(201, 'Георги Бреснички', 58, 'DQ', 4, 999, 0, 'A', 1),
(202, 'Венелина Захариева', 45, 'DQ', 4, 999, 0, 'A', 0),
(203, 'Петър Бонев', 144, '1:28:06.8', 6, 0, 3, 'M', 1),
(204, 'Александър Бекяров', 23, '0:59:08.6', 4, 0, 3, 'M', 1),
(205, 'Радка Петкова', 154, '1:13:03.0', 4, 0, 3, 'M', 0),
(206, 'Мартин Маринов', 196, 'DQ', 4, 999, 0, 'A', 1),
(207, 'Панталей Златков', 143, '1:06:23.5', 3, 0, 3, 'M', 1),
(208, 'Екатерина Куртева', 82, '1:00:42.2', 3, 0, 3, 'M', 0),
(209, 'Христо Кръстев', 170, '0:49:06.6', 4, 0, 3, 'M', 1),
(210, 'Красимир Георгиев Стоянов', 108, '1:22:21.2', 7, 0, 3, 'M', 1),
(211, 'Радослав Байрактаров', 155, 'DQ', 4, 999, 0, 'A', 1),
(212, 'Ема Байрактарова', 86, 'DQ', 1, 999, 0, 'A', 0),
(213, 'Милица Мирчева', 13, 'DQ', 3, 999, 0, 'A', 0),
(214, 'Петър Джостов', 146, 'DQ', 4, 999, 0, 'A', 1),
(215, 'Никол Йорданова', 132, 'DQ', 1, 999, 0, 'A', 0),
(216, 'Светослав Сугарев', 159, '1:20:25.4', 3, 0, 3, 'M', 1),
(217, 'Савина Николова', 210, 'DQ', 3, 999, 0, 'A', 0),
(218, 'Кристин Генкова', 192, 'DQ', 3, 999, 0, 'A', 0),
(219, 'Илияна Вълканова', 22, 'DQ', 1, 999, 0, 'A', 0),
(220, 'Иван Белянов', 94, '1:24:06.6', 3, 0, 3, 'M', 1),
(221, 'Пламен Лилов', 151, 'DQ', 4, 999, 0, 'A', 1),
(222, 'Иво Христов', 101, 'DQ', 3, 999, 0, 'A', 1),
(223, 'Георги Жегов', 59, 'DQ', 4, 999, 0, 'A', 1),
(224, 'Петър Петров', 205, '1:26:38.5', 5, 0, 3, 'M', 1),
(225, 'Владимир Тумбев', 56, '1:09:40.6', 3, 0, 3, 'M', 1),
(226, 'Николай Димитров', 201, '0:44:04.5', 4, 0, 3, 'M', 1),
(227, 'Велияна Лозанова', 43, 'DQ', 3, 999, 0, 'A', 0),
(228, 'Андрей Къртунов', 31, 'DQ', 4, 999, 0, 'A', 1),
(229, 'Божидар Къртунов', 36, '0:58:40.7', 3, 0, 3, 'M', 1),
(230, 'Ивайло Станимиров', 93, 'DQ', 2, 999, 0, 'A', 1),
(231, 'Венелина Емилова', 44, 'DQ', 4, 999, 0, 'A', 0),
(232, 'Тео Дучев', 215, '0:56:20.8', 2, 0, 3, 'M', 1),
(233, 'Даниела Кадева', 216, '0:48:57.9', 3, 0, 3, 'M', 0);

-- --------------------------------------------------------

--
-- Структура на таблица `main_athletephoto`
--

CREATE TABLE `main_athletephoto` (
  `id` bigint(20) NOT NULL,
  `image` varchar(100) NOT NULL,
  `athlete_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
(1, 'ТОДОРКА VERTICAL', '2025-08-09 06:30:06.623010', 141, 3);

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
(6, 'Най-опитен планинар', '61+ г'),
(7, 'Планинска легенда', '');

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
-- Индекси за таблица `main_athletephoto`
--
ALTER TABLE `main_athletephoto`
  ADD PRIMARY KEY (`id`),
  ADD KEY `main_athletephoto_athlete_id_ce8a7963_fk_main_athlete_id` (`athlete_id`);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=53;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `django_content_type`
--
ALTER TABLE `django_content_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT for table `main_athlete`
--
ALTER TABLE `main_athlete`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=234;

--
-- AUTO_INCREMENT for table `main_athletephoto`
--
ALTER TABLE `main_athletephoto`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=223;

--
-- AUTO_INCREMENT for table `main_competition`
--
ALTER TABLE `main_competition`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `main_group`
--
ALTER TABLE `main_group`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

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

--
-- Ограничения за таблица `main_athletephoto`
--
ALTER TABLE `main_athletephoto`
  ADD CONSTRAINT `main_athletephoto_athlete_id_ce8a7963_fk_main_athlete_id` FOREIGN KEY (`athlete_id`) REFERENCES `main_athlete` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
