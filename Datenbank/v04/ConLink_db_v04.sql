-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema ConLink_db_v04
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema ConLink_db_v04
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `ConLink_db_v04` DEFAULT CHARACTER SET utf8 ;
-- -----------------------------------------------------
-- Schema ConLink_db_v04
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema ConLink_db_v04
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `ConLink_db_v04` DEFAULT CHARACTER SET utf8 ;
USE `ConLink_db_v04` ;

-- -----------------------------------------------------
-- Table `ConLink_db_v04`.`a_aerzte`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ConLink_db_v04`.`a_aerzte` (
  `a_id` INT NOT NULL,
  `a_titel` VARCHAR(20) NULL,
  `a_vorname` VARCHAR(45) NULL,
  `a_nachname` VARCHAR(45) NULL,
  `a_email` VARCHAR(100) NULL,
  `a_telefonnummer` VARCHAR(20) NULL,
  `a_fachrichtung` VARCHAR(50) NULL,
  `a_plz` VARCHAR(10) NULL,
  `a_ort` VARCHAR(100) NULL,
  `a_berufserfahrung` INT NULL,
  `a_qualifikationen` TEXT NULL,
  PRIMARY KEY (`a_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ConLink_db_v04`.`p_patienten`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ConLink_db_v04`.`p_patienten` (
  `p_id` INT NOT NULL,
  `p_vorname` VARCHAR(45) NULL,
  `p_nachname` VARCHAR(45) NULL,
  `p_email` VARCHAR(100) NULL,
  `p_passwort` VARCHAR(255) NULL,
  `p_telefonnummer` VARCHAR(20) NULL,
  `p_geburtsdatum` DATE NULL,
  `p_svnr` VARCHAR(45) CHARACTER SET 'utf8' NULL,
  `p_allergien` TEXT NULL,
  `p_vorerkrankungen` TEXT NULL,
  `p_medikamente` TEXT NULL,
  `p_a_behandelnderArzt` INT NOT NULL,
  PRIMARY KEY (`p_id`),
  INDEX `fk_p_patienten_a_aerzte_idx` (`p_a_behandelnderArzt` ASC) ,
  CONSTRAINT `fk_p_patienten_a_aerzte`
    FOREIGN KEY (`p_a_behandelnderArzt`)
    REFERENCES `ConLink_db_v04`.`a_aerzte` (`a_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ConLink_db_v04`.`t_termine`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ConLink_db_v04`.`t_termine` (
  `t_id` INT NOT NULL,
  `t_datum` DATE NULL,
  `t_uhrzeit` TIME NULL,
  `t_termintyp` VARCHAR(45) NULL,
  `t_p_id` INT NOT NULL,
  `t_a_id` INT NOT NULL,
  `t_tt_id` INT NOT NULL,
  `t_z_id` INT NOT NULL,
  PRIMARY KEY (`t_id`),
  INDEX `fk_t_termine_p_patienten1_idx` (`t_p_id` ASC),
  INDEX `fk_t_termine_a_aerzte1_idx` (`t_a_id` ASC),
  INDEX `fk_t_termine_tt_termintyp1_idx` (`t_tt_id` ASC),
  INDEX `fk_t_termine_z_zeitslots1_idx` (`t_z_id` ASC),
  CONSTRAINT `fk_t_termine_p_patienten1`
    FOREIGN KEY (`t_p_id`)
    REFERENCES `ConLink_db_v04`.`p_patienten` (`p_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_t_termine_a_aerzte1`
    FOREIGN KEY (`t_a_id`)
    REFERENCES `ConLink_db_v04`.`a_aerzte` (`a_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_t_termine_tt_termintyp1_idx`
    FOREIGN KEY (`t_tt_id`)
    REFERENCES `ConLink_db_v04`.`tt_termintyp` (`tt_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_t_termine_z_zeitslots1_idx`
    FOREIGN KEY (`t_z_id`)
    REFERENCES `ConLink_db_v04`.`z_zeitslots` (`z_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `ConLink_db_v04`.`b_bewertungen`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ConLink_db_v04`.`b_bewertungen` (
  `b_id` INT NOT NULL,
  `b_punkte` INT NULL,
  `b_kommentar` TEXT NULL,
  `b_p_id` INT NOT NULL,
  `b_a_id` INT NOT NULL,
  PRIMARY KEY (`b_id`),
  INDEX `fk_b_bewertungen_p_patienten1_idx` (`b_p_id` ASC) ,
  INDEX `fk_b_bewertungen_a_aerzte1_idx` (`b_a_id` ASC) ,
  CONSTRAINT `fk_b_bewertungen_p_patienten1`
    FOREIGN KEY (`b_p_id`)
    REFERENCES `ConLink_db_v04`.`p_patienten` (`p_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_b_bewertungen_a_aerzte1`
    FOREIGN KEY (`b_a_id`)
    REFERENCES `ConLink_db_v04`.`a_aerzte` (`a_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ConLink_db_v04`.`tt_termintyp`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ConLink_db_v04`.`tt_termintyp` (
  `tt_id` INT NOT NULL,
  `tt_bezeichnung` VARCHAR(45) NULL,
  PRIMARY KEY (`tt_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ConLink_db_v04`.`m_medikamente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ConLink_db_v04`.`m_medikamente` (
  `m_id` INT NOT NULL,
  `m_aktuell` TINYINT NOT NULL,
  `m_name` VARCHAR(45) NULL,
  PRIMARY KEY (`m_id`))
ENGINE = InnoDB;

USE `ConLink_db_v04` ;

-- -----------------------------------------------------
-- Table `ConLink_db_v04`.`a_aerzte`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ConLink_db_v04`.`a_aerzte` (
  `a_id` INT(11) NOT NULL,
  `a_vorname` VARCHAR(45) NULL DEFAULT NULL,
  `a_nachname` VARCHAR(45) NULL DEFAULT NULL,
  `a_fachrichtung` VARCHAR(50) NULL DEFAULT NULL,
  `a_plz` VARCHAR(10) NULL DEFAULT NULL,
  `a_ort` VARCHAR(100) NULL DEFAULT NULL,
  `a_berufserfahrung` INT(11) NULL DEFAULT NULL,
  `a_qualifikationen` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`a_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `ConLink_db_v04`.`p_patienten`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ConLink_db_v04`.`p_patienten` (
  `p_id` INT(11) NOT NULL AUTO_INCREMENT,
  `p_vorname` VARCHAR(45) NULL DEFAULT NULL,
  `p_nachname` VARCHAR(45) NULL DEFAULT NULL,
  `p_geburtsdatum` DATE NULL DEFAULT NULL,
  `p_svnr` VARCHAR(45) NULL DEFAULT NULL,
  `p_allergien` TEXT NULL DEFAULT NULL,
  `p_vorerkrankungen` TEXT NULL DEFAULT NULL,
  `p_medikamente` VARCHAR(255) NULL DEFAULT NULL,
  `p_a_behandelnderArzt` INT(11) NOT NULL,
  PRIMARY KEY (`p_id`),
  INDEX `fk_p_patienten_a_aerzte_idx` (`p_a_behandelnderArzt` ASC) ,
  CONSTRAINT `fk_p_patienten_a_aerzte`
    FOREIGN KEY (`p_a_behandelnderArzt`)
    REFERENCES `ConLink_db_v04`.`a_aerzte` (`a_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `ConLink_db_v04`.`b_bewertungen`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ConLink_db_v04`.`b_bewertungen` (
  `b_id` INT(11) NOT NULL AUTO_INCREMENT,
  `b_punkte` INT(11) NULL DEFAULT NULL,
  `b_kommentar` TEXT NULL DEFAULT NULL,
  `b_p_id` INT(11) NOT NULL,
  `b_a_id` INT(11) NOT NULL,
  PRIMARY KEY (`b_id`),
  INDEX `fk_b_bewertungen_p_patienten1_idx` (`b_p_id` ASC) ,
  INDEX `fk_b_bewertungen_a_aerzte1_idx` (`b_a_id` ASC) ,
  CONSTRAINT `fk_b_bewertungen_a_aerzte1`
    FOREIGN KEY (`b_a_id`)
    REFERENCES `ConLink_db_v04`.`a_aerzte` (`a_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_b_bewertungen_p_patienten1`
    FOREIGN KEY (`b_p_id`)
    REFERENCES `ConLink_db_v04`.`p_patienten` (`p_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `ConLink_db_v04`.`l_logging`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ConLink_db_v04`.`l_logging` (
  `l_id` INT(11) NOT NULL AUTO_INCREMENT,
  `l_event_typ` VARCHAR(255) NULL DEFAULT NULL COMMENT 'Dieses Feld gibt den Typ des Ereignisses an (z.B. Anmeldung, Terminvereinbarung, Bewertung).',
  `l_timestamp` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP(),
  `l_p_id` INT(11) NOT NULL COMMENT '- ID des Patienten, der das Ereignis betrifft',
  `l_a_id` INT(11) NOT NULL COMMENT '- ID des Arzt, der das Ereignis betrifft',
  PRIMARY KEY (`l_id`),
  INDEX `fk_l_logging_p_patienten1_idx` (`l_p_id` ASC) ,
  INDEX `fk_l_logging_a_aerzte1_idx` (`l_a_id` ASC) ,
  CONSTRAINT `fk_l_logging_p_patienten1`
    FOREIGN KEY (`l_p_id`)
    REFERENCES `ConLink_db_v04`.`p_patienten` (`p_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_l_logging_a_aerzte1`
    FOREIGN KEY (`l_a_id`)
    REFERENCES `ConLink_db_v04`.`a_aerzte` (`a_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `ConLink_db_v04`.`z_zeitslots`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ConLink_db_v04`.`z_zeitslots` (
  `z_id` INT(11) NOT NULL AUTO_INCREMENT,
  `z_startzeit` TIME NULL DEFAULT NULL,
  `z_endzeit` TIME NULL DEFAULT NULL,
  PRIMARY KEY (`z_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `ConLink_db_v04`.`t_termine`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ConLink_db_v04`.`t_termine` (
  `t_id` INT(11) NOT NULL AUTO_INCREMENT,
  `t_datum` DATE NULL DEFAULT NULL,
  `t_uhrzeit` TIME NULL DEFAULT NULL,
  `t_p_id` INT(11) NOT NULL,
  `t_a_id` INT(11) NOT NULL,
  `t_tt_id` INT NOT NULL,
  `t_z_id` INT(11) NOT NULL,
  PRIMARY KEY (`t_id`),
  INDEX `fk_t_termine_p_patienten1_idx` (`t_p_id` ASC) ,
  INDEX `fk_t_termine_a_aerzte1_idx` (`t_a_id` ASC) ,
  INDEX `fk_t_termine_tt_termintyp1_idx` (`t_tt_id` ASC) ,
  INDEX `fk_t_termine_z_zeitslots1_idx` (`t_z_id` ASC) ,
  CONSTRAINT `fk_t_termine_a_aerzte1`
    FOREIGN KEY (`t_a_id`)
    REFERENCES `ConLink_db_v04`.`a_aerzte` (`a_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_t_termine_p_patienten1`
    FOREIGN KEY (`t_p_id`)
    REFERENCES `ConLink_db_v04`.`p_patienten` (`p_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_t_termine_tt_termintyp1`
    FOREIGN KEY (`t_tt_id`)
    REFERENCES `ConLink_db_v04`.`tt_termintyp` (`tt_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_t_termine_z_zeitslots1`
    FOREIGN KEY (`t_z_id`)
    REFERENCES `ConLink_db_v04`.`z_zeitslots` (`z_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `ConLink_db_v04`.`u_userverwaltung`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ConLink_db_v04`.`u_userverwaltung` (
  `u_id` INT(11) NOT NULL AUTO_INCREMENT,
  `u_username` VARCHAR(45) NULL DEFAULT NULL,
  `u_passwort` VARCHAR(50) NULL DEFAULT NULL,
  `u_email` VARCHAR(45) NULL,
  `u_telefonnummer` VARCHAR(20) NULL,
  `u_rolle` VARCHAR(45) NULL DEFAULT NULL,
  `u_p_id` INT(11) NOT NULL,
  `u_a_id` INT(11) NOT NULL,
  PRIMARY KEY (`u_id`),
  INDEX `fk_u_userverwaltung_p_patienten1_idx` (`u_p_id` ASC) ,
  INDEX `fk_u_userverwaltung_a_aerzte1_idx` (`u_a_id` ASC) ,
  CONSTRAINT `fk_u_userverwaltung_p_patienten1`
    FOREIGN KEY (`u_p_id`)
    REFERENCES `ConLink_db_v04`.`p_patienten` (`p_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_u_userverwaltung_a_aerzte1`
    FOREIGN KEY (`u_a_id`)
    REFERENCES `ConLink_db_v04`.`a_aerzte` (`a_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `ConLink_db_v04`.`pm_p_hat_m`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ConLink_db_v04`.`pm_p_hat_m` (
  `pm_p_id` INT(11) NOT NULL,
  `pm_m_id` INT NOT NULL,
  PRIMARY KEY (`pm_p_id`, `pm_m_id`),
  INDEX `fk_p_patienten_has_m_medikamente_m_medikamente1_idx` (`pm_m_id` ASC) ,
  INDEX `fk_p_patienten_has_m_medikamente_p_patienten1_idx` (`pm_p_id` ASC) ,
  CONSTRAINT `fk_p_patienten_has_m_medikamente_p_patienten1`
    FOREIGN KEY (`pm_p_id`)
    REFERENCES `ConLink_db_v04`.`p_patienten` (`p_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_p_patienten_has_m_medikamente_m_medikamente1`
    FOREIGN KEY (`pm_m_id`)
    REFERENCES `ConLink_db_v04`.`m_medikamente` (`m_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- Ärzte 
INSERT INTO `ConLink_db_v04`.`a_aerzte` (a_id, a_titel, a_vorname, a_nachname, a_email, a_telefonnummer, a_fachrichtung, a_plz, a_ort, a_berufserfahrung, a_qualifikationen)
VALUES
(1, 'Dr', 'Erwald', 'Heberer', 'erwald.heberer@example.com', '123456789', 'Allgemeinarzt', '1050', 'Wien', 10, 'PhD'),
(2, 'Dr', 'Marie', 'Effner', 'marie.effnerh@example.com', '987654321', 'Kardiologin', '1100', 'Wien', 15, NULL),
(3, 'Dr. med.', 'Michael', 'Jordan', 'michael.jordan@example.com', '555555555', 'Hautarzt', '1120', 'Wien', 12, NULL),
(4, 'Dr. med.', 'Julia', 'Schmidt', 'julia.schmidt@example.com', '111111111', 'Kinderärztin', '1010', 'Wien', 8, 'Dr. med.'),
(5, 'Dr. med.', 'Michael', 'Müller', 'michael.mueller@example.com', '222222222', 'Onkologe', '1020', 'Wien', 20, 'Dr. med.'),
(6, 'Dr. med.', 'Anna', 'Wagner', 'anna.wagner@example.com', '333333333', 'Psychiaterin', '1030', 'Wien', 15, 'Dr. med., Psychiatrie'),
(7, 'Dr', 'Christoph', 'Becker', 'christoph.becker@example.com', '444444444', 'Orthopäde', '1040', 'Wien', 18, NULL),
(8, 'Dr. med.', 'Laura', 'Hofmann', 'laura.hofmann@example.com', '481910519', 'Neurologin', '1050', 'Wien', 12, 'Dr. med., Neurologie');

-- Patienten
INSERT INTO `ConLink_db_v04`.`p_patienten` (p_id, p_vorname, p_nachname, p_email, p_passwort, p_telefonnummer, p_geburtsdatum, p_svnr, p_allergien, p_vorerkrankungen, p_medikamente, p_a_behandelnderArzt)
VALUES
(1, 'Anna', 'Schmidt', 'anna.schmidt@example.com', 'pass123', '123456789', '1990-05-15', '1234567890', 'Pollen', 'Bluthochdruck', 'Aspirin', 1),
(2, 'Markus', 'Müller', 'markus.mueller@example.com', 'pass456', '0987654321', '1985-08-22', '0987654321', 'Penicillin', 'Diabetes', 'Insulin', 2),
(3, 'Julia', 'Becker', 'julia.becker@example.com', 'pass789', '1122334455', '1993-03-10', '1122334455', NULL, 'Asthma', 'Ventolin', 3),
(4, 'Max', 'Lehmann', 'max.lehmann@example.com', 'passabc', '5544332211', '1980-11-28', '5544332211', 'Erdnüsse', 'Herzkrankheit', 'Clopidogrel', 2),
(5, 'Sophie', 'Hoffmann', 'sophie.hoffmann@example.com', 'passxyz', '6677889900', '1995-07-03', '6677889900', 'Schalentiere', 'Arthritis', 'Ibuprofen', 1);

-- Bewertungen
INSERT INTO `ConLink_db_v04`.`b_bewertungen` (b_id, b_punkte, b_kommentar, b_p_id, b_a_id)
VALUES
(1, 2, 'Nicht zufrieden mit der Behandlung!', 1, 1),
(2, 5, 'Kompetenter Arzt, empfehle ich weiter.', 3, 3),
(3, 3, 'Etwas längere Wartezeit, aber gute Beratung.', 2, 2),
(4, 4, 'Freundliches Personal und saubere Praxis.', 4, 2),
(5, 5, 'Schnelle Diagnose, bin sehr zufrieden.', 5, 1);

-- Logging
INSERT INTO `ConLink_db_v04`.`l_logging` (l_id, l_event_typ, l_timestamp, l_p_id, l_a_id)
VALUES
(1, 'Anmeldung', CURRENT_TIMESTAMP(), 1, 1),
(2, 'Terminvereinbarung', CURRENT_TIMESTAMP(), 3, 3),
(3, 'Bewertung', CURRENT_TIMESTAMP(), 2, 2),
(4, 'Anmeldung', CURRENT_TIMESTAMP(), 4, 2),
(5, 'Terminvereinbarung', CURRENT_TIMESTAMP(), 5, 1);

-- Termintyp
INSERT INTO `ConLink_db_v04`.`tt_termintyp` (tt_id, tt_bezeichnung) VALUES
(1, 'Erstuntersuchung'),
(2, 'Folgeuntersuchung');

ALTER TABLE `ConLink_db_v04`.`t_termine`
ADD FOREIGN KEY (`t_z_id`)
REFERENCES `ConLink_db_v04`.`z_zeitslots` (`z_id`)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE `ConLink_db_v04`.`t_termine`
ADD FOREIGN KEY (`t_tt_id`)
REFERENCES `ConLink_db_v04`.`tt_termintyp` (`tt_id`)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

-- foreign key hinzufügen zu t_termine 
ALTER TABLE `ConLink_db_v04`.`t_termine`
ADD FOREIGN KEY (`t_p_id`)
REFERENCES `ConLink_db_v04`.`p_patienten` (`p_id`)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE `ConLink_db_v04`.`t_termine`
ADD FOREIGN KEY (`t_a_id`)
REFERENCES `ConLink_db_v04`.`a_aerzte` (`a_id`)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

-- foreign key hinzufügen zu u_userverwaltung 
ALTER TABLE `ConLink_db_v04`.`b_bewertungen`
ADD FOREIGN KEY (`b_a_id`)
REFERENCES `ConLink_db_v04`.`a_aerzte` (`a_id`)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE `ConLink_db_v04`.`b_bewertungen`
ADD FOREIGN KEY (`b_p_id`)
REFERENCES `ConLink_db_v04`.`p_patienten` (`p_id`)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

-- foreign key hinzufügen zu u_userverwaltung 
ALTER TABLE `ConLink_db_v04`.`u_userverwaltung`
ADD FOREIGN KEY (`u_a_id`)
REFERENCES `ConLink_db_v04`.`a_aerzte` (`a_id`)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE `ConLink_db_v04`.`u_userverwaltung`
ADD FOREIGN KEY (`u_p_id`)
REFERENCES `ConLink_db_v04`.`p_patienten` (`p_id`)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

-- foreign key hinzufügen zu l_logging 
ALTER TABLE `ConLink_db_v04`.`l_logging`
ADD FOREIGN KEY (`l_a_id`)
REFERENCES `ConLink_db_v04`.`a_aerzte` (`a_id`)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE `ConLink_db_v04`.`l_logging`
ADD FOREIGN KEY (`l_p_id`)
REFERENCES `ConLink_db_v04`.`p_patienten` (`p_id`)
ON DELETE NO ACTION
ON UPDATE NO ACTION;


