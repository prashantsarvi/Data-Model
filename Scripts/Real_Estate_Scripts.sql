-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
-- -----------------------------------------------------
-- Schema real_estate
-- -----------------------------------------------------
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Halifax`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Halifax` (
  `H_ID` INT NOT NULL,
  `H_Crime` VARCHAR(45) NULL,
  `H_Education` VARCHAR(45) NULL,
  PRIMARY KEY (`H_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Education`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Education` (
  `ComID` INT NOT NULL,
  `GeogName` VARCHAR(45) NULL,
  `DataGroup` VARCHAR(45) NULL,
  `Female - .` VARCHAR(45) NULL,
  `Male - .` VARCHAR(45) NULL,
  `Male - %` VARCHAR(45) NULL,
  `Total - .` VARCHAR(45) NULL,
  `Total - %` VARCHAR(45) NULL,
  `Halifax_H_ID` INT NOT NULL,
  PRIMARY KEY (`ComID`, `Halifax_H_ID`),
 --  INDEX `fk_Education_Halifax1_idx` (`Halifax_H_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Education_Halifax1`
    FOREIGN KEY (`Halifax_H_ID`)
    REFERENCES `mydb`.`Halifax` (`H_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Geography`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Geography` (
  `G_ID` INT NOT NULL,
  `G_LONGITUDE` VARCHAR(45) NULL,
  `G_LATITUDE` VARCHAR(45) NULL,
  `G_INFO` VARCHAR(45) NULL,
  `Education_ComID` INT NOT NULL,
  `Education_Halifax_H_ID` INT NOT NULL,
  PRIMARY KEY (`G_ID`, `Education_ComID`, `Education_Halifax_H_ID`),
  -- INDEX `fk_Geography_Education1_idx` (`Education_ComID` ASC, `Education_Halifax_H_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Geography_Education1`
    FOREIGN KEY (`Education_ComID` , `Education_Halifax_H_ID`)
    REFERENCES `mydb`.`Education` (`ComID` , `Halifax_H_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Crime`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Crime` (
  `C_ID` INT NOT NULL,
  `C_TYPE` VARCHAR(45) NULL,
  `C_MAXIMUM_CASES` VARCHAR(45) NULL,
  `Halifax_H_ID` INT NOT NULL,
  `Geography_G_ID` INT NOT NULL,
  `Geography_Education_ComID` INT NOT NULL,
  `Geography_Education_Halifax_H_ID` INT NOT NULL,
  PRIMARY KEY (`C_ID`, `Halifax_H_ID`, `Geography_G_ID`, `Geography_Education_ComID`, `Geography_Education_Halifax_H_ID`),
  -- INDEX `fk_Crime_Halifax_idx` (`Halifax_H_ID` ASC) VISIBLE,
  -- INDEX `fk_Crime_Geography1_idx` (`Geography_G_ID` ASC, `Geography_Education_ComID` ASC, `Geography_Education_Halifax_H_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Crime_Halifax`
    FOREIGN KEY (`Halifax_H_ID`)
    REFERENCES `mydb`.`Halifax` (`H_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Crime_Geography1`
    FOREIGN KEY (`Geography_G_ID` , `Geography_Education_ComID` , `Geography_Education_Halifax_H_ID`)
    REFERENCES `mydb`.`Geography` (`G_ID` , `Education_ComID` , `Education_Halifax_H_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Shopping`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Shopping` (
  `S_TYPE` INT NOT NULL,
  `S_MALLS` VARCHAR(45) NULL,
  `S_REVENUE` VARCHAR(45) NULL,
  `S_PERCENTAGE` VARCHAR(45) NULL,
  `Geography_G_ID` INT NOT NULL,
  `Geography_Education_ComID` INT NOT NULL,
  `Geography_Education_Halifax_H_ID` INT NOT NULL,
  PRIMARY KEY (`S_TYPE`, `Geography_G_ID`, `Geography_Education_ComID`, `Geography_Education_Halifax_H_ID`),
  -- INDEX `fk_Shopping_Geography1_idx` (`Geography_G_ID` ASC, `Geography_Education_ComID` ASC, `Geography_Education_Halifax_H_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Shopping_Geography1`
    FOREIGN KEY (`Geography_G_ID` , `Geography_Education_ComID` , `Geography_Education_Halifax_H_ID`)
    REFERENCES `mydb`.`Geography` (`G_ID` , `Education_ComID` , `Education_Halifax_H_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Mall`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Mall` (
  `M_ID` INT NOT NULL,
  `M_TYPE` VARCHAR(45) NULL,
  `M_LOCATION` VARCHAR(45) NULL,
  `M_AREA` VARCHAR(45) NULL,
  `Shopping_S_TYPE` INT NOT NULL,
  `Geography_G_ID` INT NOT NULL,
  `Geography_Education_ComID` INT NOT NULL,
  `Geography_Education_Halifax_H_ID` INT NOT NULL,
  PRIMARY KEY (`M_ID`, `Shopping_S_TYPE`),
  -- INDEX `fk_Mall_Shopping1_idx` (`Shopping_S_TYPE` ASC) VISIBLE,
  -- INDEX `fk_Mall_Geography1_idx` (`Geography_G_ID` ASC, `Geography_Education_ComID` ASC, `Geography_Education_Halifax_H_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Mall_Shopping1`
    FOREIGN KEY (`Shopping_S_TYPE`)
    REFERENCES `mydb`.`Shopping` (`S_TYPE`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Mall_Geography1`
    FOREIGN KEY (`Geography_G_ID` , `Geography_Education_ComID` , `Geography_Education_Halifax_H_ID`)
    REFERENCES `mydb`.`Geography` (`G_ID` , `Education_ComID` , `Education_Halifax_H_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Gaming`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Gaming` (
  `Registration No.` INT NOT NULL,
  `Registration Type` VARCHAR(45) NULL,
  `Supplier Name` VARCHAR(45) NULL,
  `Municipality, Province, State, Postal Code/Zip` VARCHAR(45) NULL,
  `Mall_M_ID` INT NOT NULL,
  `Mall_Shopping_S_TYPE` INT NOT NULL,
  PRIMARY KEY (`Registration No.`, `Mall_M_ID`, `Mall_Shopping_S_TYPE`),
  -- INDEX `fk_Gaming_Mall1_idx` (`Mall_M_ID` ASC, `Mall_Shopping_S_TYPE` ASC) VISIBLE,
  CONSTRAINT `fk_Gaming_Mall1`
    FOREIGN KEY (`Mall_M_ID` , `Mall_Shopping_S_TYPE`)
    REFERENCES `mydb`.`Mall` (`M_ID` , `Shopping_S_TYPE`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Visitor Survey`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Visitor Survey` (
  `Trip Purpose` INT NULL,
  `Market of Origin` VARCHAR(45) NULL,
  `Survey Year` VARCHAR(45) NULL,
  `% of Visitor Parties` VARCHAR(45) NULL,
  `Halifax_H_ID` INT NOT NULL,
  -- INDEX `fk_Visitor Survey_Halifax1_idx` (`Halifax_H_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Visitor Survey_Halifax1`
    FOREIGN KEY (`Halifax_H_ID`)
    REFERENCES `mydb`.`Halifax` (`H_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Early Education`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Early Education` (
  `Institution` INT NOT NULL,
  `Credential` VARCHAR(45) NULL,
  `Civic_Address` VARCHAR(45) NULL,
  `Province` VARCHAR(45) NULL,
  `Website` VARCHAR(45) NULL,
  `Location` VARCHAR(45) NULL,
  `Education_ComID` INT NOT NULL,
  `Education_Halifax_H_ID` INT NOT NULL,
  PRIMARY KEY (`Institution`, `Education_ComID`, `Education_Halifax_H_ID`),
  -- INDEX `fk_Early Education_Education1_idx` (`Education_ComID` ASC, `Education_Halifax_H_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Early Education_Education1`
    FOREIGN KEY (`Education_ComID` , `Education_Halifax_H_ID`)
    REFERENCES `mydb`.`Education` (`ComID` , `Halifax_H_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Geography_has_Crime`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Geography_has_Crime` (
  `Geography_G_ID` INT NOT NULL,
  `Crime_C_ID` INT NOT NULL,
  `Crime_Halifax_H_ID` INT NOT NULL,
  PRIMARY KEY (`Geography_G_ID`, `Crime_C_ID`, `Crime_Halifax_H_ID`),
  -- INDEX `fk_Geography_has_Crime_Crime1_idx` (`Crime_C_ID` ASC, `Crime_Halifax_H_ID` ASC) VISIBLE,
  -- INDEX `fk_Geography_has_Crime_Geography1_idx` (`Geography_G_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Geography_has_Crime_Geography1`
    FOREIGN KEY (`Geography_G_ID`)
    REFERENCES `mydb`.`Geography` (`G_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Geography_has_Crime_Crime1`
    FOREIGN KEY (`Crime_C_ID` , `Crime_Halifax_H_ID`)
    REFERENCES `mydb`.`Crime` (`C_ID` , `Halifax_H_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
