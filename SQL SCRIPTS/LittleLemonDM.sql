-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema littlelemon_db
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema littlelemon_db
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `littlelemon_db` DEFAULT CHARACTER SET utf8 ;
USE `littlelemon_db` ;

-- -----------------------------------------------------
-- Table `littlelemon_db`.`Roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `littlelemon_db`.`Roles` (
  `RoleID` INT NOT NULL AUTO_INCREMENT,
  `Title` VARCHAR(100) NULL,
  PRIMARY KEY (`RoleID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `littlelemon_db`.`Staff`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `littlelemon_db`.`Staff` (
  `StaffID` INT NOT NULL AUTO_INCREMENT,
  `RoleID` INT NULL,
  `Salary` DECIMAL(6,2) NULL,
  `FullName` VARCHAR(255) NULL,
  PRIMARY KEY (`StaffID`),
  INDEX `role_id_idx` (`RoleID` ASC) VISIBLE,
  CONSTRAINT `role_id`
    FOREIGN KEY (`RoleID`)
    REFERENCES `littlelemon_db`.`Roles` (`RoleID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `littlelemon_db`.`Customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `littlelemon_db`.`Customers` (
  `CustomerID` INT NOT NULL AUTO_INCREMENT,
  `FullName` VARCHAR(255) NULL,
  `Email` VARCHAR(100) NULL,
  `ContactNumber` INT NULL,
  PRIMARY KEY (`CustomerID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `littlelemon_db`.`Bookings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `littlelemon_db`.`Bookings` (
  `BookingID` INT NOT NULL AUTO_INCREMENT,
  `TableNo` INT NOT NULL,
  `BookingDate` DATE NOT NULL,
  `NoGuests` SMALLINT NULL,
  `CustomerID` INT NULL,
  `StaffID` INT NULL,
  PRIMARY KEY (`BookingID`),
  INDEX `staff_id_idx` (`StaffID` ASC) VISIBLE,
  INDEX `customer_id_bookings_idx` (`CustomerID` ASC) VISIBLE,
  CONSTRAINT `staff_id`
    FOREIGN KEY (`StaffID`)
    REFERENCES `littlelemon_db`.`Staff` (`StaffID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `customer_id_bookings`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `littlelemon_db`.`Customers` (`CustomerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `littlelemon_db`.`Cuisine`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `littlelemon_db`.`Cuisine` (
  `CuisineID` INT NOT NULL AUTO_INCREMENT,
  `Title` VARCHAR(60) NULL,
  PRIMARY KEY (`CuisineID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `littlelemon_db`.`Type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `littlelemon_db`.`Type` (
  `TypeID` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(140) NULL,
  PRIMARY KEY (`TypeID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `littlelemon_db`.`MenuItem`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `littlelemon_db`.`MenuItem` (
  `ItemID` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(255) NULL,
  `TypeID` INT NULL,
  `Price` DECIMAL(6,2) NULL,
  PRIMARY KEY (`ItemID`),
  INDEX `type_id_idx` (`TypeID` ASC) VISIBLE,
  CONSTRAINT `type_id`
    FOREIGN KEY (`TypeID`)
    REFERENCES `littlelemon_db`.`Type` (`TypeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `littlelemon_db`.`Menu`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `littlelemon_db`.`Menu` (
  `MenuID` INT NOT NULL AUTO_INCREMENT,
  `CuisineID` INT NOT NULL,
  `ItemID` INT NULL,
  PRIMARY KEY (`MenuID`, `CuisineID`),
  INDEX `category_id_idx` (`CuisineID` ASC) VISIBLE,
  INDEX `item_id_idx` (`ItemID` ASC) VISIBLE,
  CONSTRAINT `cuisine_id`
    FOREIGN KEY (`CuisineID`)
    REFERENCES `littlelemon_db`.`Cuisine` (`CuisineID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `item_id`
    FOREIGN KEY (`ItemID`)
    REFERENCES `littlelemon_db`.`MenuItem` (`ItemID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `littlelemon_db`.`Orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `littlelemon_db`.`Orders` (
  `OrderID` INT NOT NULL AUTO_INCREMENT,
  `OrderDate` DATE NOT NULL,
  `Quantity` INT NOT NULL,
  `TotalCost` DECIMAL(10,2) NOT NULL,
  `CustomerID` INT NULL,
  `MenuID` INT NULL,
  PRIMARY KEY (`OrderID`),
  INDEX `customer_id_idx` (`CustomerID` ASC) VISIBLE,
  INDEX `menu_id_idx` (`MenuID` ASC) VISIBLE,
  CONSTRAINT `customer_id_orders`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `littlelemon_db`.`Customers` (`CustomerID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `menu_id`
    FOREIGN KEY (`MenuID`)
    REFERENCES `littlelemon_db`.`Menu` (`MenuID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `littlelemon_db`.`OrderStatus`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `littlelemon_db`.`OrderStatus` (
  `OrderStatusID` INT NOT NULL AUTO_INCREMENT,
  `OrderID` INT NOT NULL,
  `DeliveryDate` DATE NULL,
  `Status` ENUM('Pending', 'Delivered') NULL DEFAULT 'Pending',
  PRIMARY KEY (`OrderStatusID`, `OrderID`),
  INDEX `order_id_idx` (`OrderID` ASC) VISIBLE,
  CONSTRAINT `order_id`
    FOREIGN KEY (`OrderID`)
    REFERENCES `littlelemon_db`.`Orders` (`OrderID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
