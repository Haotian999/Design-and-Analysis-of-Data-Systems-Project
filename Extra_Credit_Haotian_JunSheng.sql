-- MySQL Script generated by MySQL Workbench
-- Thu 13 Dec 2018 11:16:17 PM MST
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `mydb` ;

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Employee`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Employee` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Employee` (
  `_AutoID` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(50) NOT NULL,
  `Address` VARCHAR(50) NOT NULL,
  `SkillLevel` VARCHAR(45) NOT NULL,
  `TypeWork` VARCHAR(45) NULL,
  `Remark` TEXT NULL,
  `salaries__AutoID` INT NOT NULL,
  PRIMARY KEY (`_AutoID`, `salaries__AutoID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`SetTime`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`SetTime` ;

CREATE TABLE IF NOT EXISTS `mydb`.`SetTime` (
  `_AutoID` INT NOT NULL AUTO_INCREMENT,
  `salariesID` INT NOT NULL,
  `EmployeeID` INT NOT NULL,
  `HourSalary` DECIMAL(18,2) NULL,
  `NowDate` DATE NOT NULL,
  `StartDate` DATETIME NOT NULL,
  `EndDate` DATETIME NOT NULL,
  `overtime` DECIMAL(18,2) NULL,
  `OvertimeHours` DECIMAL(18,2) NULL,
  `AllHours` DECIMAL(18,2) NULL,
  `theDaySalary` DECIMAL(18,2) NOT NULL,
  `Employee__AutoID` INT NOT NULL,
  `Employee_salaries__AutoID` INT NOT NULL,
  PRIMARY KEY (`_AutoID`),
  UNIQUE INDEX `salariesID_UNIQUE` (`salariesID` ASC),
  UNIQUE INDEX `EmployeeID_UNIQUE` (`EmployeeID` ASC),
  INDEX `fk_SetTime_Employee1_idx` (`Employee__AutoID` ASC, `Employee_salaries__AutoID` ASC),
  CONSTRAINT `fk_SetTime_Employee1`
    FOREIGN KEY (`Employee__AutoID` , `Employee_salaries__AutoID`)
    REFERENCES `mydb`.`Employee` (`_AutoID` , `salaries__AutoID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Salaries`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Salaries` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Salaries` (
  `_AutoID` INT NOT NULL AUTO_INCREMENT,
  `EmployeeID` INT NOT NULL,
  `SalaryType` VARCHAR(50) NOT NULL,
  `FixedSalary` DECIMAL(18,2) NULL,
  `Days` INT NULL,
  `HourlyPay` VARCHAR(45) NULL,
  `SetTime__AutoID` INT NOT NULL,
  `Employee__AutoID` INT NOT NULL,
  `Employee_salaries__AutoID` INT NOT NULL,
  PRIMARY KEY (`_AutoID`),
  UNIQUE INDEX `EmployeeID_UNIQUE` (`EmployeeID` ASC),
  INDEX `fk_salaries_SetTime1_idx` (`SetTime__AutoID` ASC),
  INDEX `fk_salaries_Employee1_idx` (`Employee__AutoID` ASC, `Employee_salaries__AutoID` ASC),
  CONSTRAINT `fk_salaries_SetTime1`
    FOREIGN KEY (`SetTime__AutoID`)
    REFERENCES `mydb`.`SetTime` (`_AutoID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_salaries_Employee1`
    FOREIGN KEY (`Employee__AutoID` , `Employee_salaries__AutoID`)
    REFERENCES `mydb`.`Employee` (`_AutoID` , `salaries__AutoID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Supplier`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Supplier` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Supplier` (
  `_AutoID` INT NOT NULL AUTO_INCREMENT,
  `category` VARCHAR(45) NOT NULL,
  `name` VARCHAR(100) NOT NULL,
  `address1` VARCHAR(100) NULL,
  `address2` VARCHAR(100) NULL,
  `CityStateZip` VARCHAR(100) NOT NULL,
  `Phone` VARCHAR(45) NULL,
  `Contact` VARCHAR(45) NULL,
  `ContactPhone` VARCHAR(45) NULL,
  `ShippingAndBillingTrems` VARCHAR(45) NULL,
  `notes` TEXT NULL,
  PRIMARY KEY (`_AutoID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Order`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Order` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Order` (
  `_AutoID` INT NOT NULL AUTO_INCREMENT,
  `OrderDate` DATE NULL,
  `SupplierID` INT NOT NULL,
  `Material` VARCHAR(45) NOT NULL,
  `MaterialType` VARCHAR(45) NOT NULL,
  `MaterialCount` DECIMAL(18,2) NOT NULL,
  `price` DECIMAL(18,2) NOT NULL,
  `Specifications` VARCHAR(45) NULL,
  `tax` DECIMAL(18,2) NULL,
  `Freight` DECIMAL(18,2) NOT NULL,
  `AllPrice` DECIMAL(18,2) NOT NULL,
  `Supplier__AutoID` INT NOT NULL,
  `Employee__AutoID` INT NOT NULL,
  `Employee_salaries__AutoID` INT NOT NULL,
  PRIMARY KEY (`_AutoID`),
  UNIQUE INDEX `SupplierID_UNIQUE` (`SupplierID` ASC),
  INDEX `fk_Order_Supplier1_idx` (`Supplier__AutoID` ASC),
  INDEX `fk_Order_Employee1_idx` (`Employee__AutoID` ASC, `Employee_salaries__AutoID` ASC),
  CONSTRAINT `fk_Order_Supplier1`
    FOREIGN KEY (`Supplier__AutoID`)
    REFERENCES `mydb`.`Supplier` (`_AutoID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Order_Employee1`
    FOREIGN KEY (`Employee__AutoID` , `Employee_salaries__AutoID`)
    REFERENCES `mydb`.`Employee` (`_AutoID` , `salaries__AutoID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`EquipmentInventory`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`EquipmentInventory` ;

CREATE TABLE IF NOT EXISTS `mydb`.`EquipmentInventory` (
  `_AutoID` INT NOT NULL AUTO_INCREMENT,
  `SupplierID` INT NOT NULL,
  `PurchasePrice` DECIMAL(18,2) NULL,
  `Buyyear` INT NULL,
  `DepreciationAmount` DECIMAL(18,2) NULL,
  `MaterialName` NVARCHAR(50) NOT NULL,
  `BuyNum` INT NULL,
  `UseType` VARCHAR(45) NULL,
  `Remarks` TEXT NULL,
  `Order__AutoID` INT NOT NULL,
  PRIMARY KEY (`_AutoID`),
  UNIQUE INDEX `SupplierID_UNIQUE` (`SupplierID` ASC),
  INDEX `fk_EquipmentInventory_Order1_idx` (`Order__AutoID` ASC),
  CONSTRAINT `fk_EquipmentInventory_Order1`
    FOREIGN KEY (`Order__AutoID`)
    REFERENCES `mydb`.`Order` (`_AutoID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`StockGoods`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`StockGoods` ;

CREATE TABLE IF NOT EXISTS `mydb`.`StockGoods` (
  `_AutoID` INT NOT NULL AUTO_INCREMENT,
  `TypeName` VARCHAR(45) NOT NULL,
  `Count` INT NOT NULL,
  `SpotName` VARCHAR(45) NOT NULL,
  `SpecificationType` VARCHAR(45) NULL,
  `Remarks` TEXT NULL,
  `SupplierID` INT NOT NULL,
  `Order__AutoID` INT NOT NULL,
  `Supplier__AutoID` INT NOT NULL,
  PRIMARY KEY (`_AutoID`),
  UNIQUE INDEX `SupplierID_UNIQUE` (`SupplierID` ASC),
  INDEX `fk_stockGoods_Order1_idx` (`Order__AutoID` ASC),
  INDEX `fk_stockGoods_Supplier1_idx` (`Supplier__AutoID` ASC),
  CONSTRAINT `fk_stockGoods_Order1`
    FOREIGN KEY (`Order__AutoID`)
    REFERENCES `mydb`.`Order` (`_AutoID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_stockGoods_Supplier1`
    FOREIGN KEY (`Supplier__AutoID`)
    REFERENCES `mydb`.`Supplier` (`_AutoID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`LandscapeMaterials`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`LandscapeMaterials` ;

CREATE TABLE IF NOT EXISTS `mydb`.`LandscapeMaterials` (
  `_AutoID` INT NOT NULL AUTO_INCREMENT,
  `SupplierID` INT NOT NULL,
  `TypeName` VARCHAR(45) NOT NULL,
  `SpotName` VARCHAR(45) NOT NULL,
  `SpecificationType` VARCHAR(45) NULL,
  `Count` VARCHAR(45) NOT NULL,
  `Remarks` TEXT NULL,
  `Supplier__AutoID` INT NOT NULL,
  `Order__AutoID` INT NOT NULL,
  PRIMARY KEY (`_AutoID`),
  UNIQUE INDEX `SupplierID_UNIQUE` (`SupplierID` ASC),
  INDEX `fk_LandscapeMaterials_Supplier1_idx` (`Supplier__AutoID` ASC),
  UNIQUE INDEX `Supplier__AutoID_UNIQUE` (`Supplier__AutoID` ASC),
  INDEX `fk_LandscapeMaterials_Order1_idx` (`Order__AutoID` ASC),
  CONSTRAINT `fk_LandscapeMaterials_Supplier1`
    FOREIGN KEY (`Supplier__AutoID`)
    REFERENCES `mydb`.`Supplier` (`_AutoID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_LandscapeMaterials_Order1`
    FOREIGN KEY (`Order__AutoID`)
    REFERENCES `mydb`.`Order` (`_AutoID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Customer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Customer` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Customer` (
  `_AutoID` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `address1` VARCHAR(45) NULL,
  `address2` VARCHAR(45) NULL,
  `CityStateZip` VARCHAR(100) NULL,
  `Phone1` VARCHAR(45) NULL,
  `Phone2` VARCHAR(50) NULL,
  `Referred` VARCHAR(100) NULL,
  `CustomerSince` VARCHAR(100) NULL,
  `demand` VARCHAR(200) NULL,
  `notes` TEXT NULL,
  PRIMARY KEY (`_AutoID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`RetailSalesTicket_Detaileds`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`RetailSalesTicket_Detaileds` ;

CREATE TABLE IF NOT EXISTS `mydb`.`RetailSalesTicket_Detaileds` (
  `_AutoID` INT NOT NULL AUTO_INCREMENT,
  `_MainID` INT NOT NULL,
  `DetailedsType` VARCHAR(45) NOT NULL,
  `MaterialsID` INT NOT NULL,
  `Price` DECIMAL(18,2) NOT NULL,
  `Count` DECIMAL(18,2) NOT NULL,
  `TotlePrice` DECIMAL(18,2) NOT NULL,
  `stockGoods__AutoID` INT NOT NULL,
  `LandscapeMaterials__AutoID` INT NOT NULL,
  PRIMARY KEY (`_AutoID`),
  UNIQUE INDEX `_MainID_UNIQUE` (`_MainID` ASC),
  INDEX `fk_RetailSalesTicket_Detaileds_stockGoods1_idx` (`stockGoods__AutoID` ASC),
  INDEX `fk_RetailSalesTicket_Detaileds_LandscapeMaterials1_idx` (`LandscapeMaterials__AutoID` ASC),
  CONSTRAINT `fk_RetailSalesTicket_Detaileds_stockGoods1`
    FOREIGN KEY (`stockGoods__AutoID`)
    REFERENCES `mydb`.`StockGoods` (`_AutoID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_RetailSalesTicket_Detaileds_LandscapeMaterials1`
    FOREIGN KEY (`LandscapeMaterials__AutoID`)
    REFERENCES `mydb`.`LandscapeMaterials` (`_AutoID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`RetailSalesTicket`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`RetailSalesTicket` ;

CREATE TABLE IF NOT EXISTS `mydb`.`RetailSalesTicket` (
  `_AutoID` INT NOT NULL AUTO_INCREMENT,
  `Date` DATE NOT NULL,
  `EmployeeID` INT NOT NULL,
  `CustomerID` INT NOT NULL,
  `RetailSalesTicket_Detaileds__AutoID` INT NOT NULL,
  `customer__AutoID` INT NOT NULL,
  `Employee__AutoID` INT NOT NULL,
  `Employee_salaries__AutoID` INT NOT NULL,
  PRIMARY KEY (`_AutoID`),
  INDEX `fk_RetailSalesTicket_RetailSalesTicket_Detaileds1_idx` (`RetailSalesTicket_Detaileds__AutoID` ASC),
  INDEX `fk_RetailSalesTicket_customer1_idx` (`customer__AutoID` ASC),
  UNIQUE INDEX `EmployeeID_UNIQUE` (`EmployeeID` ASC),
  UNIQUE INDEX `CustomerID_UNIQUE` (`CustomerID` ASC),
  INDEX `fk_RetailSalesTicket_Employee1_idx` (`Employee__AutoID` ASC, `Employee_salaries__AutoID` ASC),
  CONSTRAINT `fk_RetailSalesTicket_RetailSalesTicket_Detaileds1`
    FOREIGN KEY (`RetailSalesTicket_Detaileds__AutoID`)
    REFERENCES `mydb`.`RetailSalesTicket_Detaileds` (`_AutoID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_RetailSalesTicket_customer1`
    FOREIGN KEY (`customer__AutoID`)
    REFERENCES `mydb`.`Customer` (`_AutoID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_RetailSalesTicket_Employee1`
    FOREIGN KEY (`Employee__AutoID` , `Employee_salaries__AutoID`)
    REFERENCES `mydb`.`Employee` (`_AutoID` , `salaries__AutoID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
