-- phpMyAdmin SQL Dump
-- version 4.7.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Erstellungszeit: 24. Okt 2017 um 08:09
-- Server-Version: 5.7.18
-- PHP-Version: 7.1.5-1+0~20170522123046.25+jessie~1.gbpb8686b

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Datenbank: `steamboost`
--

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `AccountGames`
--

CREATE TABLE `AccountGames` (
  `SteamAccount_NR` int(11) NOT NULL,
  `App_NR` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `AccountUser`
--

CREATE TABLE `AccountUser` (
  `SteamAccount_NR` int(11) NOT NULL,
  `User_NR` int(11) NOT NULL,
  `canWeLoginData` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `Games`
--

CREATE TABLE `Games` (
  `app_id` int(11) NOT NULL,
  `name` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `SteamAccount`
--

CREATE TABLE `SteamAccount` (
  `steamAccount_ID` int(11) NOT NULL,
  `username` varchar(48) NOT NULL,
  `password` varchar(128) NOT NULL,
  `secret` varchar(32) NOT NULL,
  `sentry` varchar(2732) NOT NULL,
  `IsActive` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `User`
--

CREATE TABLE `User` (
  `user_id` int(11) NOT NULL,
  `username` varchar(48) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Indizes der exportierten Tabellen
--

--
-- Indizes für die Tabelle `AccountGames`
--
ALTER TABLE `AccountGames`
  ADD KEY `App_NR` (`App_NR`),
  ADD KEY `SteamAccount_NR` (`SteamAccount_NR`);

--
-- Indizes für die Tabelle `AccountUser`
--
ALTER TABLE `AccountUser`
  ADD KEY `SteamAccount_NR` (`SteamAccount_NR`),
  ADD KEY `User_NR` (`User_NR`);

--
-- Indizes für die Tabelle `Games`
--
ALTER TABLE `Games`
  ADD PRIMARY KEY (`app_id`);

--
-- Indizes für die Tabelle `SteamAccount`
--
ALTER TABLE `SteamAccount`
  ADD PRIMARY KEY (`steamAccount_ID`);

--
-- Indizes für die Tabelle `User`
--
ALTER TABLE `User`
  ADD PRIMARY KEY (`user_id`);

--
-- AUTO_INCREMENT für exportierte Tabellen
--

--
-- AUTO_INCREMENT für Tabelle `SteamAccount`
--
ALTER TABLE `SteamAccount`
  MODIFY `steamAccount_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT für Tabelle `User`
--
ALTER TABLE `User`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- Constraints der exportierten Tabellen
--

--
-- Constraints der Tabelle `AccountGames`
--
ALTER TABLE `AccountGames`
  ADD CONSTRAINT `AccountGames_ibfk_1` FOREIGN KEY (`App_NR`) REFERENCES `Games` (`app_id`),
  ADD CONSTRAINT `AccountGames_ibfk_2` FOREIGN KEY (`SteamAccount_NR`) REFERENCES `SteamAccount` (`steamAccount_ID`);

--
-- Constraints der Tabelle `AccountUser`
--
ALTER TABLE `AccountUser`
  ADD CONSTRAINT `AccountUser_ibfk_1` FOREIGN KEY (`SteamAccount_NR`) REFERENCES `SteamAccount` (`steamAccount_ID`),
  ADD CONSTRAINT `AccountUser_ibfk_2` FOREIGN KEY (`User_NR`) REFERENCES `User` (`user_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
