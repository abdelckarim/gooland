-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 16-01-2024 a las 21:06:17
-- Versión del servidor: 10.4.20-MariaDB
-- Versión de PHP: 8.0.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `wizatek`
--
CREATE DATABASE IF NOT EXISTS `wizatek` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `wizatek`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categorias`
--

CREATE TABLE `categorias` (
  `ca_id` int(200) NOT NULL,
  `ca_idnt` varchar(300) DEFAULT NULL,
  `ca_type` int(2) DEFAULT NULL,
  `ca_name` varchar(300) DEFAULT NULL,
  `ca_url` text DEFAULT NULL,
  `ca_desc` text DEFAULT NULL,
  `ca_short` text DEFAULT NULL,
  `ca_img` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `categorias`
--

INSERT INTO `categorias` (`ca_id`, `ca_idnt`, `ca_type`, `ca_name`, `ca_url`, `ca_desc`, `ca_short`, `ca_img`) VALUES
(1, '1', 1, 'Fanny', 'fanny', 'Loreum...', 'Why so serious', 'https://miscmedia-9gag-fun.9cache.com/images/thumbnail-facebook/1557376304.186_U5U7u5_100x100wp.webp'),
(2, '2', 1, 'Animales', 'animales', 'Loreum...', 'It\'s so fluffy I\'m gonna die!', 'https://miscmedia-9gag-fun.9cache.com/images/thumbnail-facebook/1557391851.3248_Za4UdA_100x100wp.webp'),
(3, '3', 1, 'Asombroso', 'asombroso', 'Loreum...', 'Things that make you WOW', 'https://miscmedia-9gag-fun.9cache.com/images/thumbnail-facebook/1557217995.2799_bYQyJU_100x100wp.webp'),
(4, '4', 1, 'Cosplay', 'cosplay', 'Loreum...', 'Be the character you love', 'https://miscmedia-9gag-fun.9cache.com/images/thumbnail-facebook/1557216678.2404_U2EHEM_100x100wp.webp'),
(5, '5', 1, 'Gaming', 'gaming', 'Loreum...', 'We don\'t die, we respawn!', 'https://miscmedia-9gag-fun.9cache.com/images/thumbnail-facebook/1557286928.6604_uTYgug_100x100wp.webp'),
(6, '6', 1, 'League Of Legends', 'lol', 'Loreum...', 'Welcome to the summoner\'s rift, KDA, Riot Games, Yasuo, Teemo, Zed, Lux and more. ', 'https://miscmedia-9gag-fun.9cache.com/images/thumbnail-facebook/1557291375.3948_Dy2yZu_100x100wp.webp'),
(7, '7', 1, 'Salvage', 'savage', 'Loreum...', 'Apply cold water to burnt area', 'https://miscmedia-9gag-fun.9cache.com/images/thumbnail-facebook/1557291282.8015_egYQAB_100x100wp.webp'),
(8, '8', 1, 'WTF', 'wtf', 'Loreum...', 'Jaw-dropping moments', 'https://miscmedia-9gag-fun.9cache.com/images/thumbnail-facebook/1557310702.1267_UgysAp_100x100wp.webp'),
(9, '9', 1, 'Criptomonedas', 'criptomonedas', 'Explore cryptocurrency on 9GAG. See top posts and trending searches about cryptocurrency, Bitcoin, Dogecoin, Ethereum and more.', 'Everything about Bitcoin (BTC), Ethereum (ETH), Dogecoins...', 'https://miscmedia-9gag-fun.9cache.com/images/thumbnail-facebook/1612499626.65_ARaqeP_100x100wp.webp'),
(10, '10', 1, 'NSFW', 'nsfw', 'Loreum...', 'Not Safe For Work. No sexually explicit content.', 'https://miscmedia-9gag-fun.9cache.com/images/thumbnail-facebook/1557297099.4728_VeSAvU_100x100wp.webp');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `posts`
--

CREATE TABLE `posts` (
  `ps_id` int(200) NOT NULL,
  `ps_user` int(200) NOT NULL,
  `ps_url` text NOT NULL,
  `ps_type` int(1) DEFAULT NULL,
  `ps_title` varchar(300) CHARACTER SET utf8 COLLATE utf8_vietnamese_ci DEFAULT NULL,
  `ps_sensible` int(1) DEFAULT 0,
  `ps_tags` varchar(100) DEFAULT NULL,
  `ps_server` int(1) DEFAULT NULL,
  `ps_visual` text DEFAULT NULL,
  `ps_coments` int(200) DEFAULT 0,
  `ps_section` int(5) NOT NULL,
  `ps_likes` int(200) DEFAULT 0,
  `ps_dislike` int(200) DEFAULT 0,
  `ps_value` int(200) DEFAULT 0,
  `ps_ancho` int(10) DEFAULT NULL,
  `ps_alto` int(10) DEFAULT NULL,
  `ps_created` varchar(250) DEFAULT NULL,
  `ps_update` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `posts`
--

INSERT INTO `posts` (`ps_id`, `ps_user`, `ps_url`, `ps_type`, `ps_title`, `ps_sensible`, `ps_tags`, `ps_server`, `ps_visual`, `ps_coments`, `ps_section`, `ps_likes`, `ps_dislike`, `ps_value`, `ps_ancho`, `ps_alto`, `ps_created`, `ps_update`) VALUES
(1, 1, 'f58d3', 3, 'Baby Elefant', 0, '', 1, 'https://testing-memes.s3.eu-west-3.amazonaws.com/Videos/f58d3.mp4', 0, 1, 0, 0, 0, 0, 0, '2021-09-23 14:58:19', '2021-09-23 12:58:19'),
(2, 1, '27335', 3, 'Video 2', 0, '', 1, 'https://testing-memes.s3.eu-west-3.amazonaws.com/Videos/27335.mp4', 0, 2, 0, 0, 0, 0, 0, '2021-09-23 14:59:43', '2021-09-23 12:59:43'),
(3, 1, '24378', 3, 'Video 3', 0, '', 1, 'https://testing-memes.s3.eu-west-3.amazonaws.com/Videos/24378.mp4', 0, 3, 0, 0, 0, 0, 0, '2021-09-23 15:00:22', '2021-09-23 13:00:22'),
(4, 1, '12c7b', 3, 'Video 4', 0, '', 1, 'https://testing-memes.s3.eu-west-3.amazonaws.com/Videos/12c7b.mp4', 0, 5, 0, 0, 0, 0, 0, '2021-09-23 15:01:15', '2021-09-23 13:01:15'),
(5, 1, '17840', 3, 'Video 5', 0, '', 1, 'https://testing-memes.s3.eu-west-3.amazonaws.com/Videos/17840.mp4', 0, 7, 0, 0, 0, 0, 0, '2021-09-23 15:02:20', '2021-09-23 13:02:20'),
(6, 1, '86466', 3, 'The faith she had in that bucket', 0, '', 1, 'https://testing-memes.s3.eu-west-3.amazonaws.com/Videos/86466.mp4', 0, 1, 0, 0, 0, 0, 0, '2021-09-23 15:02:52', '2021-09-23 13:02:52'),
(7, 1, '49c28', 3, 'Women Gang up and assault man who tried to use his freedom of speech in the most peaceful way...', 0, '', 1, 'https://testing-memes.s3.eu-west-3.amazonaws.com/Videos/49c28.mp4', 0, 2, 0, 0, 0, 0, 0, '2021-09-23 15:03:32', '2021-09-23 13:03:32'),
(8, 1, '528dc', 3, 'Dodging responsibility be like....', 0, '', 1, 'https://testing-memes.s3.eu-west-3.amazonaws.com/Videos/528dc.mp4', 0, 3, 0, 0, 0, 0, 0, '2021-09-23 15:04:05', '2021-09-23 13:04:05'),
(9, 1, '65f75', 3, 'This is multicultural space. But, it doesn\'t include whites because you guys have no culture.', 0, 'Racist', 1, 'https://testing-memes.s3.eu-west-3.amazonaws.com/Videos/65f75.mp4', 0, 2, 0, 0, 0, 0, 0, '2021-09-24 13:15:32', '2021-09-24 11:15:32'),
(10, 1, 'f892c', 1, 'awdawdawd', 0, '', 1, 'https://testing-memes.s3.eu-west-3.amazonaws.com/Images/f892c.jpeg', 0, 2, 0, 0, 0, 827, 824, '2021-09-26 13:12:22', '2021-09-26 11:12:22'),
(11, 1, '2e9d8', 1, 'awdawd', 0, '', 1, 'https://testing-memes.s3.eu-west-3.amazonaws.com/Images/2e9d8.jfif', 0, 4, 0, 0, 0, 1909, 967, '2021-09-26 13:12:55', '2021-09-26 11:12:55'),
(12, 1, '4d1ba', 3, 'awdawdawd', 0, '', 1, 'https://testing-memes.s3.eu-west-3.amazonaws.com/Videos/4d1ba.mp4', 0, 3, 0, 0, 0, 0, 0, '2021-09-26 13:25:59', '2021-09-26 11:25:59'),
(13, 1, '8764a', 1, 'awdawd', 0, '', 1, 'https://testing-memes.s3.eu-west-3.amazonaws.com/Images/8764a.jpg', 0, 1, 0, 0, 0, 1024, 1449, '2021-09-30 17:28:36', '2021-09-30 15:28:36'),
(14, 1, '4e1e6', 1, 'awdawdawd', 0, '', 1, 'https://testing-memes.s3.eu-west-3.amazonaws.com/Images/4e1e6.jpg', 0, 1, 0, 0, 0, 1024, 576, '2021-09-30 20:44:29', '2021-09-30 18:44:29'),
(15, 1, '7ea73', 1, 'I love this', 1, 'testing', 1, 'https://testing-memes.s3.eu-west-3.amazonaws.com/Images/7ea73.png', 0, 3, 0, 0, 0, 627, 925, '2021-10-10 13:11:23', '2021-10-10 11:11:23'),
(16, 1, 'afc37', 3, 'Cultural appropriation', 0, '', 1, 'https://testing-memes.s3.eu-west-3.amazonaws.com/Videos/afc37.mp4', 0, 7, 0, 0, 0, 0, 0, '2021-10-13 11:03:07', '2021-10-13 09:03:07'),
(17, 1, '7d3c4', 3, 'Realmente lo está disfrutando :)', 1, 'Nieve,Gatos', 1, 'https://testing-memes.s3.eu-west-3.amazonaws.com/Videos/7d3c4.mp4', 0, 2, 0, 0, 0, 0, 0, '2021-10-19 13:54:15', '2021-10-19 11:54:15'),
(18, 2, 'b47a0', 1, 'Prueba', 1, 'dawd,xD,mola', 1, 'https://testing-memes.s3.eu-west-3.amazonaws.com/Images/b47a0.PNG', 0, 1, 0, 0, 0, 1113, 615, '2021-10-19 15:47:08', '2021-10-19 13:47:08'),
(19, 2, '28216', 1, 'dale dale', 0, '', 1, 'https://testing-memes.s3.eu-west-3.amazonaws.com/Images/28216.jpg', 0, 3, 0, 0, 0, 1920, 960, '2021-10-19 15:47:28', '2021-10-19 13:47:28'),
(20, 2, '57674', 1, 'awdawd', 0, '', 1, 'https://testing-memes.s3.eu-west-3.amazonaws.com/Images/57674.png', 0, 2, 0, 0, 0, 800, 496, '2021-10-19 15:47:41', '2021-10-19 13:47:41'),
(21, 2, '8658c', 1, 'awdawd', 0, '', 1, 'https://testing-memes.s3.eu-west-3.amazonaws.com/Images/8658c.png', 0, 2, 0, 0, 0, 800, 496, '2021-10-19 15:49:03', '2021-10-19 13:49:03'),
(22, 2, 'c3b2f', 1, 'dawd1', 0, '', 1, 'https://testing-memes.s3.eu-west-3.amazonaws.com/Images/c3b2f.png', 0, 2, 0, 0, 0, 800, 496, '2021-10-19 15:49:13', '2021-10-19 13:49:13'),
(23, 1, 'a873d', 3, 'Are you pregnarenent?', 0, 'Song,Awesome', 1, 'https://testing-memes.s3.eu-west-3.amazonaws.com/Videos/a873d.mp4', 0, 1, 0, 0, 0, 0, 0, '2021-10-20 11:54:22', '2021-10-20 09:54:22'),
(24, 1, 'b53e9', 3, 'Lesson learned. Be the first ant to climb up', 0, 'Forget,Ant', 1, 'https://testing-memes.s3.eu-west-3.amazonaws.com/Videos/b53e9.mp4', 0, 2, 0, 0, 0, 0, 0, '2021-10-20 17:35:10', '2021-10-20 15:35:10'),
(25, 1, '1218c', 1, 'awdawd', 0, 'awdawd', 1, 'https://testing-memes.s3.eu-west-3.amazonaws.com/Images/1218c.png', 0, 2, 0, 0, 0, 688, 688, '2021-10-20 17:39:08', '2021-10-20 15:39:08'),
(26, 1, 'ad4e2', 3, 'DYOR', 0, 'Robert Lustig', 1, 'https://testing-memes.s3.eu-west-3.amazonaws.com/Videos/ad4e2.mp4', 0, 7, 0, 0, 0, 0, 0, '2021-10-20 17:43:44', '2021-10-20 15:43:44'),
(27, 1, '43651', 1, 'Calavera con laser en los Ojos.', 0, 'Halloween ,Calavera', 1, 'https://testing-memes.s3.eu-west-3.amazonaws.com/Images/43651.png', 0, 3, 0, 0, 0, 1376, 1376, '2021-10-21 14:24:11', '2021-10-21 12:24:11'),
(28, 1, '30293', 1, 'Testeando todo esto', 0, 'xD112,Mola Mucho', 1, 'https://testing-memes.s3.eu-west-3.amazonaws.com/Images/30293.png', 0, 5, 0, 0, 0, 2752, 2752, '2021-10-30 13:52:37', '2021-10-30 11:52:37'),
(29, 1, '1cb44', 3, 'Arab Music be Like @Razioff', 0, 'Music,Arab', 1, 'https://testing-memes.s3.eu-west-3.amazonaws.com/Videos/1cb44.mp4', 0, 1, 0, 0, 0, 0, 0, '2021-10-30 20:20:32', '2021-10-30 18:20:32'),
(34, 1, '447d7', 3, 'Testing this amazing', 0, 'Ocean', 1, 'https://testing-memes.s3.eu-west-3.amazonaws.com/Videos/447d7.mp4', 0, 2, 0, 0, 0, 0, 0, '2021-11-08 13:12:24', '2021-11-08 12:12:24'),
(35, 1, '7e947', 2, 'awdawdawdawdawd', 1, '', 1, 'https://testing-memes.s3.eu-west-3.amazonaws.com/Gifs/7e947.gif', 0, 2, 0, 0, 0, 328, 328, '2021-11-09 18:25:36', '2021-11-09 17:25:36'),
(36, 1, '4c606', 3, 'awjkdnakjwnd', 0, '', 1, 'https://testing-memes.s3.eu-west-3.amazonaws.com/Videos/4c606.mp4', 0, 3, 0, 0, 0, 252, 480, '2021-11-10 11:24:15', '2021-11-10 10:24:15'),
(37, 1, '16a80', 3, '1111111111111111111awdawd', 0, '', 1, 'https://testing-memes.s3.eu-west-3.amazonaws.com/Videos/16a80.mp4', 0, 2, 0, 0, 0, 460, 258, '2021-11-10 16:13:05', '2021-11-10 15:13:05'),
(38, 1, '5e94a', 3, 'acadawdawdawd', 0, '', 1, 'https://testing-memes.s3.eu-west-3.amazonaws.com/Videos/5e94a.mp4', 0, 3, 0, 0, 0, 460, 574, '2021-11-10 16:14:22', '2021-11-10 15:14:22'),
(39, 1, '05f35', 3, 'awdawdaw2222', 0, '', 1, 'https://testing-memes.s3.eu-west-3.amazonaws.com/Videos/05f35.mp4', 0, 4, 0, 0, 0, 960, 720, '2021-11-10 16:17:34', '2021-11-10 15:17:34'),
(40, 1, 'd0a87', 3, 'Stole this a while back, left the customary upvote. Happy Wednesday my dudes.\n', 1, 'itswednesdaymydudes,wednesday', 1, 'https://testing-memes.s3.eu-west-3.amazonaws.com/Videos/d0a87.mp4', 0, 10, 0, 0, 0, 960, 1703, '2021-11-10 17:14:44', '2021-11-10 16:14:44'),
(41, 1, '66865', 3, 'Finder\'s keeper\'s\n', 1, '', 1, 'https://testing-memes.s3.eu-west-3.amazonaws.com/Videos/66865.mp4', 0, 4, 0, 0, 0, 460, 574, '2021-11-10 17:17:08', '2021-11-10 16:17:08'),
(42, 1, '7af22', 1, 'Ajanwdawd', 1, '', 1, 'https://testing-memes.s3.eu-west-3.amazonaws.com/Images/7af22.jpg', 0, 2, 0, 0, 0, 600, 600, '2021-11-10 17:39:07', '2021-11-10 16:39:07'),
(43, 1, '9e78e', 1, 'Testing', 0, 'daw,awdaw,awdawd', 1, 'https://testing-memes.s3.eu-west-3.amazonaws.com/Images/9e78e.png', 0, 5, 0, 0, 0, 1000, 1000, '2021-11-13 18:35:42', '2021-11-13 17:35:42'),
(44, 1, 'e5b4d', 1, 'Cool Skull', 0, 'Skull', 1, 'https://testing-memes.s3.eu-west-3.amazonaws.com/Images/e5b4d.png', 0, 3, 0, 0, 0, 688, 688, '2021-11-13 18:56:20', '2021-11-13 17:56:20'),
(45, 2, '16476', 1, 'Testing', 1, '', 1, 'https://testing-memes.s3.eu-west-3.amazonaws.com/Images/16476.jpg', 0, 2, 0, 0, 0, 728, 412, '2021-11-13 19:07:48', '2021-11-13 18:07:48'),
(47, 1, '84169', 1, 'awdawdawdawd', 0, '', 1, 'https://testing-memes.s3.eu-west-3.amazonaws.com/Images/84169.png', 0, 3, 0, 0, 0, 896, 496, '2021-11-30 20:18:54', '2021-11-30 19:18:54'),
(48, 5, '418ca', 1, 'wdawdjanwd', 0, 'wdaw,awdawda,awdawd', 1, 'https://testing-memes.s3.eu-west-3.amazonaws.com/Images/418ca.png', 0, 9, 0, 0, 0, 1262, 1262, '2022-01-04 16:45:05', '2022-01-04 15:45:05'),
(49, 5, 'd65df', 3, 'loool', 0, 'n ,jnkj,nmn', 1, 'https://testing-memes.s3.eu-west-3.amazonaws.com/Videos/d65df.mp4', 0, 8, 0, 0, 0, 334, 720, '2022-01-09 00:40:13', '2022-01-08 23:40:13'),
(50, 7, '070ba', 1, 'Testiong this ', 0, 'ad,awdaw', 1, 'https://testing-memes.s3.eu-west-3.amazonaws.com/Images/070ba.jpg', 0, 4, 0, 0, 0, 1040, 1800, '2023-06-15 11:32:47', '2023-06-15 09:32:47'),
(51, 7, '5f7ec', 1, 'awdawd', 0, '11', 1, 'https://testing-memes.s3.eu-west-3.amazonaws.com/Images/5f7ec.png', 0, 2, 0, 0, 0, 1280, 720, '2023-06-15 12:05:21', '2023-06-15 10:05:21'),
(53, 9, 'dd7a0', 1, 'Testing', 1, 'awdawd', 1, 'https://link.storjshare.io/raw/juvgoqqkyow6incgwozecbavhleq/storage-one/Images/dd7a0.png', 0, 3, 0, 0, 0, 1280, 720, '2023-09-14 19:38:50', '2023-09-14 17:38:50'),
(54, 9, '615a2', 3, 'Testing Video', 0, '113,112', 1, 'https://link.storjshare.io/raw/juvgoqqkyow6incgwozecbavhleq/storage-one/Videos/615a2.mp4', 0, 10, 0, 0, 0, 460, 344, '2023-09-14 19:41:21', '2023-09-14 17:41:21'),
(55, 9, 'ee859', 1, 'Mi web!', 1, 'Nothing to see here', 1, 'https://link.storjshare.io/raw/juvgoqqkyow6incgwozecbavhleq/storage-one/Images/ee859.png', 0, 4, 0, 0, 0, 1280, 720, '2023-09-14 19:42:25', '2023-09-14 17:42:25'),
(56, 9, '8ef8c', 3, 'Movie', 0, 'awd', 1, 'https://link.storjshare.io/raw/juvgoqqkyow6incgwozecbavhleq/storage-one/Videos/8ef8c.mkv', 0, 3, 0, 0, 0, 1920, 784, '2023-09-14 21:08:46', '2023-09-14 19:08:46'),
(57, 10, 'b6e5b', 3, 'Me gusta mucho esto verdad?', 0, 'xD,nothing,testing', 1, 'https://link.storjshare.io/raw/juvgoqqkyow6incgwozecbavhleq/storage-one/Videos/b6e5b.mp4', 0, 8, 0, 0, 0, 1080, 1920, '2024-01-12 12:46:47', '2024-01-12 11:46:47');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `u_id` int(255) NOT NULL,
  `u_type` int(1) NOT NULL,
  `u_nombre` varchar(500) CHARACTER SET utf8 COLLATE utf8_vietnamese_ci NOT NULL,
  `u_pwd` varchar(60) NOT NULL,
  `u_email` text NOT NULL,
  `u_hash` varchar(255) DEFAULT NULL,
  `u_avatar` text DEFAULT NULL,
  `u_ip` varchar(255) DEFAULT NULL,
  `u_created` varchar(255) DEFAULT NULL,
  `u_sensible` int(2) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`u_id`, `u_type`, `u_nombre`, `u_pwd`, `u_email`, `u_hash`, `u_avatar`, `u_ip`, `u_created`, `u_sensible`) VALUES
(1, 2, 'Wizatek', '$2y$10$UY5eF/jsdQXBRoHirgCjr.9BAY9O1yrliUctCsF33MUA5P.FgHoQW', 'wiza@gmail.com', 'eaeec671', NULL, '999.999.99', '2021-09-13 21:09:37', 0),
(2, 2, 'Wizar', '$2y$10$pWhd8Z6P758Z8DqNKZlgwuTdO4DASOzJ8LMoQqnE/ZU.lo5tPykTG', 'xk@gmail.com', '2c0544df', NULL, '999.999.99', '2021-10-19 14:10:44', 0),
(3, 2, 'carim', '$2y$10$.54ubMsrXKk8HRHCvDvtmO4YnnxWXXMWXzAm75aaNyjbiRsvwJiBK', 'awdawd@gmail.com', '223b934a', NULL, '999.999.99', '2021-12-16 17:35:01', 0),
(4, 2, 'mohamed', '$2y$10$RYy6qN.53G0dMwzsvocw1O/JhuUjV7wtp0NFw5o3Fv5MVD60f8Aly', 'moawdaw@gmail.com', '01738967', NULL, '999.999.99', '2021-12-17 12:08:45', 0),
(5, 2, 'testing', '$2y$10$ac5AaOaltQoAhTATzZwKROz8WuSNtl2CYOMS47lBpQbMDXc34R8qy', 'testaa@gmail.com', '263cb2a7', NULL, '999.999.99', '2022-01-04 16:41:59', 0),
(6, 2, 'come', '$2y$10$IIC5er.2O9vgqGDtaslKnOY5zeJeZgaDCBULSpIrsehOtDBi9tWcm', 'aaawdawd@gmail.com', '6e9cc6de', NULL, '999.999.99', '2022-02-11 15:31:41', 0),
(7, 2, 'memes1', '$2y$10$X45eg00ADCGrcVTwPhz0kOPq8DYUBXScOVZnvNC4P4Rh7SbG74WBS', 'carim.programer@gmail.com', '436439b0', NULL, '999.999.99', '2023-06-15 11:31:42', 0),
(8, 2, 'SimDonovan', '$2y$10$kithdtHz7U5mtPd3hzpv..Y7qD1.I/ayFeO2t5WI2g05BdmszPkCS', 'carim1.programer@gmail.com', '67223798', NULL, '999.999.99', '2023-06-17 12:06:22', 0),
(9, 2, 'Testing123', '$2y$10$O87T/.iLTZhNHD.bujVcDeQTo/xS9V0Yw101yfvhKN53r.8hM7k1K', 'carim.progr1amer@gmail.com', '63375ec7', NULL, '999.999.99', '2023-09-14 15:03:48', 0),
(10, 2, 'HolaAmigo', '$2y$10$501fzyuIzntF9VExsVqdJ.qM9DJMfEBty9U2zu9ntFDiJCkpvDMRu', 'tes@gmail.com', '140457e0', NULL, '999.999.99', '2024-01-12 12:45:29', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios_tokens`
--

CREATE TABLE `usuarios_tokens` (
  `id` int(200) NOT NULL,
  `token` char(64) NOT NULL,
  `usuario_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `usuarios_tokens`
--

INSERT INTO `usuarios_tokens` (`id`, `token`, `usuario_id`) VALUES
(17, '399c9766d7c580a71d4be118705f297b6978c1ef', 2),
(22, 'd527878b01c9ecee156491f66829380845e06a93', 1),
(23, '3beb2c59a95e0c7c98f18642f2c4b0bc4f7b7e96', 3),
(29, '4fc2d86570b4e1094444bd840425b4f8bc9435db', 6),
(34, '195f6396c7545fb57cc83953caa731b17566b9ec', 9),
(36, 'a2f4417c218afb59259fbaaae54dacc3023fd519', 10);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `categorias`
--
ALTER TABLE `categorias`
  ADD PRIMARY KEY (`ca_id`),
  ADD UNIQUE KEY `ca_id` (`ca_id`),
  ADD KEY `ca_idnt` (`ca_idnt`),
  ADD KEY `ca_name` (`ca_name`);

--
-- Indices de la tabla `posts`
--
ALTER TABLE `posts`
  ADD UNIQUE KEY `ps_id` (`ps_id`),
  ADD KEY `ps_type` (`ps_type`),
  ADD KEY `ps_url` (`ps_server`),
  ADD KEY `ps_title` (`ps_title`),
  ADD KEY `ps_likes` (`ps_likes`),
  ADD KEY `ps_dislike` (`ps_dislike`),
  ADD KEY `ps_created` (`ps_created`),
  ADD KEY `ps_coments` (`ps_coments`),
  ADD KEY `ps_section` (`ps_section`),
  ADD KEY `ps_value` (`ps_value`),
  ADD KEY `ps_url_2` (`ps_url`(3072)),
  ADD KEY `ps_user` (`ps_user`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD UNIQUE KEY `u_id` (`u_id`),
  ADD KEY `u_type` (`u_type`),
  ADD KEY `u_nombre` (`u_nombre`),
  ADD KEY `u_hash` (`u_hash`),
  ADD KEY `u_email` (`u_email`(3072)),
  ADD KEY `u_first_date` (`u_created`) USING BTREE,
  ADD KEY `u_ip` (`u_ip`) USING BTREE,
  ADD KEY `u_nombre_2` (`u_nombre`);

--
-- Indices de la tabla `usuarios_tokens`
--
ALTER TABLE `usuarios_tokens`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id` (`token`) USING BTREE,
  ADD KEY `user_id` (`usuario_id`),
  ADD KEY `token` (`token`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `categorias`
--
ALTER TABLE `categorias`
  MODIFY `ca_id` int(200) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `posts`
--
ALTER TABLE `posts`
  MODIFY `ps_id` int(200) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=58;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `u_id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `usuarios_tokens`
--
ALTER TABLE `usuarios_tokens`
  MODIFY `id` int(200) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
