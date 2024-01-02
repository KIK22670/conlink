-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema ConLink_DB_v1
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema ConLink_DB_v1
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `ConLink_DB_v1` DEFAULT CHARACTER SET utf8 ;
-- -----------------------------------------------------
-- Schema conlink_db_v1
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema conlink_db_v1
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `conlink_db_v1` DEFAULT CHARACTER SET utf8 ;
USE `ConLink_DB_v1` ;

-- -----------------------------------------------------
-- Table `ConLink_DB_v1`.`a_aerzte`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ConLink_DB_v1`.`a_aerzte` (
  `a_id` INT NOT NULL,
  `a_vorname` VARCHAR(45) NULL,
  `a_nachname` VARCHAR(45) NULL,
  `a_fachrichtung` VARCHAR(50) NULL,
  `a_plz` VARCHAR(10) NULL,
  `a_ort` VARCHAR(100) NULL,
  `a_berufserfahrung` INT NULL,
  `a_qualifikationen` TEXT NULL,
  PRIMARY KEY (`a_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ConLink_DB_v1`.`p_patienten`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ConLink_DB_v1`.`p_patienten` (
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
    REFERENCES `ConLink_DB_v1`.`a_aerzte` (`a_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ConLink_DB_v1`.`t_termine`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ConLink_DB_v1`.`t_termine` (
  `t_id` INT NOT NULL,
  `t_datum` DATE NULL,
  `t_uhrzeit` TIME NULL,
  `t_termintyp` VARCHAR(45) NULL,
  `p_patienten_p_id` INT NOT NULL,
  `a_aerzte_a_id` INT NOT NULL,
  PRIMARY KEY (`t_id`),
  INDEX `fk_t_termine_p_patienten1_idx` (`p_patienten_p_id` ASC) ,
  INDEX `fk_t_termine_a_aerzte1_idx` (`a_aerzte_a_id` ASC) ,
  CONSTRAINT `fk_t_termine_p_patienten1`
    FOREIGN KEY (`p_patienten_p_id`)
    REFERENCES `ConLink_DB_v1`.`p_patienten` (`p_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_t_termine_a_aerzte1`
    FOREIGN KEY (`a_aerzte_a_id`)
    REFERENCES `ConLink_DB_v1`.`a_aerzte` (`a_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ConLink_DB_v1`.`b_bewertungen`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ConLink_DB_v1`.`b_bewertungen` (
  `b_id` INT NOT NULL,
  `b_punkte` INT NULL,
  `b_kommentar` TEXT NULL,
  `p_patienten_p_id` INT NOT NULL,
  `a_aerzte_a_id` INT NOT NULL,
  PRIMARY KEY (`b_id`),
  INDEX `fk_b_bewertungen_p_patienten1_idx` (`p_patienten_p_id` ASC) ,
  INDEX `fk_b_bewertungen_a_aerzte1_idx` (`a_aerzte_a_id` ASC) ,
  CONSTRAINT `fk_b_bewertungen_p_patienten1`
    FOREIGN KEY (`p_patienten_p_id`)
    REFERENCES `ConLink_DB_v1`.`p_patienten` (`p_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_b_bewertungen_a_aerzte1`
    FOREIGN KEY (`a_aerzte_a_id`)
    REFERENCES `ConLink_DB_v1`.`a_aerzte` (`a_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `conlink_db_v1` ;

-- -----------------------------------------------------
-- Table `conlink_db_v1`.`a_aerzte`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `conlink_db_v1`.`a_aerzte` (
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
-- Table `conlink_db_v1`.`p_patienten`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `conlink_db_v1`.`p_patienten` (
  `p_id` INT(11) NOT NULL AUTO_INCREMENT,
  `p_vorname` VARCHAR(45) NULL DEFAULT NULL,
  `p_nachname` VARCHAR(45) NULL DEFAULT NULL,
  `p_email` VARCHAR(100) NULL DEFAULT NULL,
  `p_passwort` VARCHAR(255) NULL DEFAULT NULL,
  `p_telefonnummer` VARCHAR(20) NULL DEFAULT NULL,
  `p_geburtsdatum` DATE NULL DEFAULT NULL,
  `p_svnr` VARCHAR(45) NULL DEFAULT NULL,
  `p_allergien` TEXT NULL DEFAULT NULL,
  `p_vorerkrankungen` TEXT NULL DEFAULT NULL,
  `p_medikamente` TEXT NULL DEFAULT NULL,
  `p_a_behandelnderArzt` INT(11) NOT NULL,
  PRIMARY KEY (`p_id`),
  INDEX `fk_p_patienten_a_aerzte_idx` (`p_a_behandelnderArzt` ASC) ,
  CONSTRAINT `fk_p_patienten_a_aerzte`
    FOREIGN KEY (`p_a_behandelnderArzt`)
    REFERENCES `conlink_db_v1`.`a_aerzte` (`a_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `conlink_db_v1`.`b_bewertungen`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `conlink_db_v1`.`b_bewertungen` (
  `b_id` INT(11) NOT NULL AUTO_INCREMENT,
  `b_punkte` INT(11) NULL DEFAULT NULL,
  `b_kommentar` TEXT NULL DEFAULT NULL,
  `p_patienten_p_id` INT(11) NOT NULL,
  `a_aerzte_a_id` INT(11) NOT NULL,
  PRIMARY KEY (`b_id`),
  INDEX `fk_b_bewertungen_p_patienten1_idx` (`p_patienten_p_id` ASC) ,
  INDEX `fk_b_bewertungen_a_aerzte1_idx` (`a_aerzte_a_id` ASC) ,
  CONSTRAINT `fk_b_bewertungen_a_aerzte1`
    FOREIGN KEY (`a_aerzte_a_id`)
    REFERENCES `conlink_db_v1`.`a_aerzte` (`a_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_b_bewertungen_p_patienten1`
    FOREIGN KEY (`p_patienten_p_id`)
    REFERENCES `conlink_db_v1`.`p_patienten` (`p_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `conlink_db_v1`.`t_termine`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `conlink_db_v1`.`t_termine` (
  `t_id` INT(11) NOT NULL AUTO_INCREMENT,
  `t_datum` DATE NULL DEFAULT NULL,
  `t_uhrzeit` TIME NULL DEFAULT NULL,
  `t_termintyp` VARCHAR(45) NULL DEFAULT NULL,
  `p_patienten_p_id` INT(11) NOT NULL,
  `a_aerzte_a_id` INT(11) NOT NULL,
  PRIMARY KEY (`t_id`),
  INDEX `fk_t_termine_p_patienten1_idx` (`p_patienten_p_id` ASC) ,
  INDEX `fk_t_termine_a_aerzte1_idx` (`a_aerzte_a_id` ASC) ,
  CONSTRAINT `fk_t_termine_a_aerzte1`
    FOREIGN KEY (`a_aerzte_a_id`)
    REFERENCES `conlink_db_v1`.`a_aerzte` (`a_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_t_termine_p_patienten1`
    FOREIGN KEY (`p_patienten_p_id`)
    REFERENCES `conlink_db_v1`.`p_patienten` (`p_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
