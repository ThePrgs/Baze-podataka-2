-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema overwatch
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema overwatch
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `overwatch` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `overwatch` ;

-- -----------------------------------------------------
-- Table `overwatch`.`nacini_igre`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `overwatch`.`nacini_igre` (
  `tip` VARCHAR(50) NOT NULL,
  `opis` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`tip`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `overwatch`.`arkadni_tipovi`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `overwatch`.`arkadni_tipovi` (
  `naziv` VARCHAR(50) NOT NULL,
  `opis` VARCHAR(100) NOT NULL,
  `broj_likova` INT NOT NULL,
  `dozvoljene_mape` VARCHAR(45) NOT NULL,
  `tip_fk` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`naziv`, `dozvoljene_mape`),
  INDEX `tip_tip_fk_idx` (`tip_fk` ASC) VISIBLE,
  INDEX `arkadni_tip_fk` (`dozvoljene_mape` ASC) VISIBLE,
  CONSTRAINT `tip_tip_fk`
    FOREIGN KEY (`tip_fk`)
    REFERENCES `overwatch`.`nacini_igre` (`tip`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `overwatch`.`drzave`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `overwatch`.`drzave` (
  `naziv` VARCHAR(45) NOT NULL,
  `kontinent` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`naziv`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `overwatch`.`klase`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `overwatch`.`klase` (
  `ime` VARCHAR(16) NOT NULL,
  `uloga` VARCHAR(60) NOT NULL,
  PRIMARY KEY (`ime`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `overwatch`.`likovi`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `overwatch`.`likovi` (
  `ime` VARCHAR(20) NOT NULL,
  `klasa` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`ime`),
  UNIQUE INDEX `ime_2` (`ime` ASC) VISIBLE,
  INDEX `klase_fk` (`klasa` ASC) VISIBLE,
  CONSTRAINT `klase_fk`
    FOREIGN KEY (`klasa`)
    REFERENCES `overwatch`.`klase` (`ime`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `overwatch`.`organizacije`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `overwatch`.`organizacije` (
  `naziv` VARCHAR(25) NOT NULL,
  `ravnanje` VARCHAR(10) NOT NULL,
  `drzave` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`naziv`),
  INDEX `drzava_fk_idx` (`drzave` ASC) VISIBLE,
  CONSTRAINT `drzave_drzava_fk`
    FOREIGN KEY (`drzave`)
    REFERENCES `overwatch`.`drzave` (`naziv`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `overwatch`.`likovi_organizacije`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `overwatch`.`likovi_organizacije` (
  `ime` VARCHAR(20) NULL DEFAULT NULL,
  `organizacija` VARCHAR(25) NULL DEFAULT NULL,
  INDEX `likovi_pripadnost_ibfk_1` (`ime` ASC) VISIBLE,
  INDEX `likovi_pripadnost_ibfk_2` (`organizacija` ASC) VISIBLE,
  CONSTRAINT `likovi_organizacije_ibfk_1`
    FOREIGN KEY (`ime`)
    REFERENCES `overwatch`.`likovi` (`ime`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `likovi_organizacije_ibfk_2`
    FOREIGN KEY (`organizacija`)
    REFERENCES `overwatch`.`organizacije` (`naziv`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `overwatch`.`mape`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `overwatch`.`mape` (
  `naziv` VARCHAR(50) NOT NULL,
  `vrsta` VARCHAR(45) NOT NULL,
  `drzava` VARCHAR(45) NOT NULL,
  `broj_likova` VARCHAR(1) NOT NULL,
  PRIMARY KEY (`naziv`),
  INDEX `mape_drzave_fk_idx` (`drzava` ASC) VISIBLE,
  INDEX `arkada_idx` (`vrsta` ASC) VISIBLE,
  INDEX `arkadni_stilovi_idx` (`vrsta` ASC) VISIBLE,
  CONSTRAINT `arkadni_stilovi`
    FOREIGN KEY (`vrsta`)
    REFERENCES `overwatch`.`arkadni_tipovi` (`dozvoljene_mape`)
    ON UPDATE CASCADE,
  CONSTRAINT `mape_drzave_fk`
    FOREIGN KEY (`drzava`)
    REFERENCES `overwatch`.`drzave` (`naziv`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `overwatch`.`moci`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `overwatch`.`moci` (
  `lik` VARCHAR(20) NOT NULL,
  `moc` VARCHAR(60) NOT NULL,
  `opis_moci` VARCHAR(100) NOT NULL,
  `hotkey` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`moc`),
  INDEX `moc_fk_idx` (`lik` ASC) VISIBLE,
  CONSTRAINT `moc_fk`
    FOREIGN KEY (`lik`)
    REFERENCES `overwatch`.`likovi` (`ime`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `overwatch`.`oruzja`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `overwatch`.`oruzja` (
  `imena` VARCHAR(20) NOT NULL,
  `oruzje` VARCHAR(40) NOT NULL,
  `opis` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`oruzje`),
  UNIQUE INDEX `imena` (`imena` ASC) VISIBLE,
  UNIQUE INDEX `oruzje_UNIQUE` (`oruzje` ASC) VISIBLE,
  CONSTRAINT `oruzja_ibfk_1`
    FOREIGN KEY (`imena`)
    REFERENCES `overwatch`.`likovi` (`ime`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

USE `overwatch`;

DELIMITER $$
USE `overwatch`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `overwatch`.`viseigraca`
BEFORE INSERT ON `overwatch`.`mape`
FOR EACH ROW
begin
    
		declare pom_broj_igraca int;
        
		SELECT new.broj_likova INTO pom_broj_igraca;
		IF pom_broj_igraca>6 then
			SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'Maksimalan broj igaraca je 6';
		end if;
		
	END$$

USE `overwatch`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `overwatch`.`viseigracaupdate`
BEFORE UPDATE ON `overwatch`.`mape`
FOR EACH ROW
begin
    
		declare pom_broj_igraca int;
        
		SELECT new.broj_likova INTO pom_broj_igraca;
		IF pom_broj_igraca>6 then
			SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'Maksimalan broj igaraca je 6';
		end if;
		
	END$$

USE `overwatch`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `overwatch`.`istemoci`
BEFORE INSERT ON `overwatch`.`moci`
FOR EACH ROW
begin
		declare hotkey_pom varchar(10);
        declare lik_pom varchar(20);
        
		SELECT lik, hotkey INTO lik_pom, hotkey_pom FROM moci where lik=new.lik and hotkey=new.hotkey;
		IF lik_pom=new.lik and hotkey_pom=new.hotkey then
			SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'Isti lik ne moze imati vise mociju na istom hotkeyu';
		end if;
		
	END$$


DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
