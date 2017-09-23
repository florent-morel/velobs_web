-- phpMyAdmin SQL Dump
-- version 4.2.10
-- http://www.phpmyadmin.net
--
-- Client :  localhost:8889
-- Généré le :  Jeu 07 Janvier 2016 à 12:21
-- Version du serveur :  5.5.38
-- Version de PHP :  5.6.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de données :  `velobs`
--

-- --------------------------------------------------------

--
-- Structure de la table `translation`
--

CREATE TABLE `translation` (
`id_translation` int(11) NOT NULL,
  `code_translation` varchar(50) DEFAULT NULL,
  `lib_translation` varchar(250) DEFAULT NULL,
  `language_id_language` int(11) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8;

--
-- Contenu de la table `translation`
--

--
-- Index pour les tables exportées
--

--
-- Index pour la table `translation`
--
ALTER TABLE `translation`
 ADD PRIMARY KEY (`id_translation`), ADD KEY `language_id_language` (`language_id_language`);

--
-- AUTO_INCREMENT pour les tables exportées
--

--
-- AUTO_INCREMENT pour la table `translation`
--
ALTER TABLE `translation`
MODIFY `id_translation` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=29;
--
-- Contraintes pour les tables exportées
--

--
-- Contraintes pour la table `translation`
--
ALTER TABLE `translation`
ADD CONSTRAINT `translation_ibfk_1` FOREIGN KEY (`language_id_language`) REFERENCES `language` (`id_language`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
