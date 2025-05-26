-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Creato il: Mag 26, 2025 alle 18:39
-- Versione del server: 10.4.32-MariaDB
-- Versione PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `gavinelli_servlet_db`
--

-- --------------------------------------------------------

--
-- Struttura della tabella `ordini`
--

CREATE TABLE `ordini` (
  `ID` int(11) NOT NULL,
  `ID_Utente` int(11) NOT NULL,
  `ID_Prodotto` int(11) NOT NULL,
  `Data_Acquisto` datetime NOT NULL DEFAULT current_timestamp(),
  `Quantita` int(11) NOT NULL,
  `SubTotale` double(7,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struttura della tabella `prodotti`
--

CREATE TABLE `prodotti` (
  `ID` int(11) NOT NULL,
  `Nome` varchar(50) NOT NULL,
  `Descrizione` text NOT NULL,
  `Immagine` varchar(20) NOT NULL,
  `Prezzo` double(7,2) NOT NULL,
  `Disponibilita` tinyint(1) NOT NULL,
  `Quantita` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `prodotti`
--

INSERT INTO `prodotti` (`ID`, `Nome`, `Descrizione`, `Immagine`, `Prezzo`, `Disponibilita`, `Quantita`) VALUES
(1, 'Computer Notebook', 'Lorem ipsum dolor sit amet consectetur adipisicing elit. Voluptatibus, hic eveniet odio inventore aspernatur quaerat consequatur obcaecati reprehenderit aliquid et?', 'computer', 699.99, 1, 10),
(2, 'Smartphone', 'Lorem ipsum dolor sit amet consectetur adipisicing elit. Voluptatibus, hic eveniet odio inventore aspernatur quaerat consequatur obcaecati reprehenderit aliquid et?', 'smartphone', 399.99, 1, 6),
(3, 'Tv', 'Lorem ipsum dolor sit amet consectetur adipisicing elit. Voluptatibus, hic eveniet odio inventore aspernatur quaerat consequatur obcaecati reprehenderit aliquid et?', 'tv', 799.99, 1, 9),
(4, 'Joystick', 'Lorem ipsum dolor sit amet consectetur adipisicing elit. Voluptatibus, hic eveniet odio inventore aspernatur quaerat consequatur obcaecati reprehenderit aliquid et?', 'joystick', 79.99, 1, 7);

-- --------------------------------------------------------

--
-- Struttura della tabella `utenti`
--

CREATE TABLE `utenti` (
  `ID` int(11) NOT NULL,
  `Cognome` varchar(50) NOT NULL,
  `Nome` varchar(50) NOT NULL,
  `Email` varchar(50) NOT NULL,
  `Username` varchar(50) NOT NULL,
  `Password` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `utenti`
--

INSERT INTO `utenti` (`ID`, `Cognome`, `Nome`, `Email`, `Username`, `Password`) VALUES
(1, 'Admin', 'Admin', 'admin@mail.com', 'Admin', '1234');

--
-- Indici per le tabelle scaricate
--

--
-- Indici per le tabelle `ordini`
--
ALTER TABLE `ordini`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `FK_Utente` (`ID_Utente`),
  ADD KEY `FK_Prodotto` (`ID_Prodotto`);

--
-- Indici per le tabelle `prodotti`
--
ALTER TABLE `prodotti`
  ADD PRIMARY KEY (`ID`);

--
-- Indici per le tabelle `utenti`
--
ALTER TABLE `utenti`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `Email` (`Email`),
  ADD UNIQUE KEY `Username` (`Username`);

--
-- AUTO_INCREMENT per le tabelle scaricate
--

--
-- AUTO_INCREMENT per la tabella `ordini`
--
ALTER TABLE `ordini`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT per la tabella `utenti`
--
ALTER TABLE `utenti`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Limiti per le tabelle scaricate
--

--
-- Limiti per la tabella `ordini`
--
ALTER TABLE `ordini`
  ADD CONSTRAINT `FK_Prodotto` FOREIGN KEY (`ID_Prodotto`) REFERENCES `prodotti` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_Utente` FOREIGN KEY (`ID_Utente`) REFERENCES `utenti` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
