-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema parkour_db
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema parkour_db
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `parkour_db` DEFAULT CHARACTER SET utf8 ;
USE `parkour_db` ;

-- -----------------------------------------------------
-- Table `parkour_db`.`tbl_customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `parkour_db`.`tbl_customers` (
  `customer_id` INT NOT NULL AUTO_INCREMENT COMMENT '',
  `customer_first_name` VARCHAR(45) NULL COMMENT '',
  `customer_last_name` VARCHAR(45) NOT NULL COMMENT '',
  `address_line_1` VARCHAR(255) NOT NULL COMMENT '',
  `address_line_2` VARCHAR(255) NULL COMMENT '',
  `city` VARCHAR(255) NOT NULL COMMENT '',
  `state` VARCHAR(2) NOT NULL COMMENT '',
  `zip` VARCHAR(12) NOT NULL COMMENT '',
  `telephone_1` VARCHAR(20) NOT NULL COMMENT '',
  `telephone_2` VARCHAR(20) NULL COMMENT '',
  `email_address` VARCHAR(255) NULL COMMENT '',
  PRIMARY KEY (`customer_id`)  COMMENT '')
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `parkour_db`.`tbl_vehicles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `parkour_db`.`tbl_vehicles` (
  `vehicle_id` INT NOT NULL AUTO_INCREMENT COMMENT '',
  `vehicle_make` VARCHAR(45) NULL COMMENT '',
  `vehicle_model` VARCHAR(45) NULL COMMENT '',
  `vehicle_vin_number` VARCHAR(100) NULL COMMENT '',
  `vehicle_year` SMALLINT NULL COMMENT '',
  `last_update_date` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP COMMENT '',
  PRIMARY KEY (`vehicle_id`)  COMMENT '')
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `parkour_db`.`tbl_customer_vehicles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `parkour_db`.`tbl_customer_vehicles` (
  `customer_vehicle_id` INT NOT NULL AUTO_INCREMENT COMMENT '',
  `customer_id` INT NULL COMMENT '',
  `vehicle_id` INT NULL COMMENT '',
  `date_added` DATE NULL COMMENT '',
  `date_removed` DATE NULL COMMENT '',
  PRIMARY KEY (`customer_vehicle_id`)  COMMENT '',
  INDEX `fk_tbl_customer_vehicle_01_idx` (`customer_id` ASC)  COMMENT '',
  INDEX `fk_tbl_customer_vehicle_02_idx` (`vehicle_id` ASC)  COMMENT '',
  CONSTRAINT `fk_tbl_customer_vehicles_01`
    FOREIGN KEY (`customer_id`)
    REFERENCES `parkour_db`.`tbl_customers` (`customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbl_customer_vehicles_02`
    FOREIGN KEY (`vehicle_id`)
    REFERENCES `parkour_db`.`tbl_vehicles` (`vehicle_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `parkour_db`.`tbl_services`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `parkour_db`.`tbl_services` (
  `service_id` INT(11) NOT NULL AUTO_INCREMENT COMMENT '',
  `service_name` VARCHAR(255) NOT NULL DEFAULT 'Oil Change' COMMENT '',
  `parts_price` DECIMAL(6,2) NOT NULL COMMENT '',
  `labor_price` DECIMAL(6,2) NOT NULL COMMENT '',
  `is_warranty` TINYINT NOT NULL COMMENT '',
  `warranty_description` VARCHAR(1000) NULL COMMENT '',
  PRIMARY KEY (`service_id`)  COMMENT '')
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `parkour_db`.`tbl_workers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `parkour_db`.`tbl_workers` (
  `worker_id` INT NOT NULL AUTO_INCREMENT COMMENT '',
  `worker_first_name` VARCHAR(45) NULL COMMENT '',
  `worker_last_name` VARCHAR(45) NOT NULL COMMENT '',
  `SSN` VARCHAR(25) NOT NULL COMMENT '',
  `length_of_tenure` INT NULL COMMENT '',
  `specialities` VARCHAR(255) NULL COMMENT '',
  `address_line_1` VARCHAR(255) NOT NULL COMMENT '',
  `address_line_2` VARCHAR(255) NULL COMMENT '',
  `city` VARCHAR(255) NOT NULL COMMENT '',
  `state` VARCHAR(2) NOT NULL COMMENT '',
  `zip` VARCHAR(12) NOT NULL COMMENT '',
  `telephone_1` VARCHAR(20) NOT NULL COMMENT '',
  PRIMARY KEY (`worker_id`)  COMMENT '')
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `parkour_db`.`tbl_orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `parkour_db`.`tbl_orders` (
  `order_id` INT NOT NULL AUTO_INCREMENT COMMENT '',
  `order_date` VARCHAR(45) NULL COMMENT '',
  `order_payment_type` ENUM('CASH','CHEQUE','VISA','MASTERCARD', 'DISCOVER','MONEY ORDER') NULL COMMENT '',
  `payment_date` DATE NULL COMMENT '',
  PRIMARY KEY (`order_id`)  COMMENT '')
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `parkour_db`.`tbl_vehicle_services`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `parkour_db`.`tbl_vehicle_services` (
  `vehicle_service_id` INT NOT NULL AUTO_INCREMENT COMMENT '',
  `vehicle_id` INT NOT NULL COMMENT '',
  `service_id` INT NOT NULL COMMENT '',
  `date_added` DATE NULL COMMENT '',
  `date_removed` DATE NULL COMMENT '',
  PRIMARY KEY (`vehicle_service_id`)  COMMENT '',
  INDEX `fk_tbl_vehicle_services_02_idx` (`vehicle_id` ASC)  COMMENT '',
  INDEX `fk_tbl_vehicle_services_01_idx` (`service_id` ASC)  COMMENT '',
  CONSTRAINT `fk_tbl_vehicle_services_01`
    FOREIGN KEY (`service_id`)
    REFERENCES `parkour_db`.`tbl_services` (`service_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbl_vehicle_services_02`
    FOREIGN KEY (`vehicle_id`)
    REFERENCES `parkour_db`.`tbl_vehicles` (`vehicle_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `parkour_db`.`tbl_worker_services`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `parkour_db`.`tbl_worker_services` (
  `worker_service_id` INT NOT NULL AUTO_INCREMENT COMMENT '',
  `worker_id` INT NOT NULL COMMENT '',
  `service_id` INT NOT NULL COMMENT '',
  `date_started` DATE NOT NULL COMMENT '',
  `date_completed` DATE NOT NULL COMMENT '',
  `total_hours_to_complete` DECIMAL(5,2) NOT NULL COMMENT '',
  PRIMARY KEY (`worker_service_id`)  COMMENT '',
  INDEX `fk_tbl_worker_services_01_idx` (`service_id` ASC)  COMMENT '',
  INDEX `fk_tbl_worker_services_02_idx` (`worker_id` ASC)  COMMENT '',
  CONSTRAINT `fk_tbl_worker_services_01`
    FOREIGN KEY (`service_id`)
    REFERENCES `parkour_db`.`tbl_services` (`service_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbl_worker_services_02`
    FOREIGN KEY (`worker_id`)
    REFERENCES `parkour_db`.`tbl_workers` (`worker_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `parkour_db`.`tbl_order_services`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `parkour_db`.`tbl_order_services` (
  `order_service_id` INT NOT NULL AUTO_INCREMENT COMMENT '',
  `order_id` INT NOT NULL COMMENT '',
  `service_id` INT NOT NULL COMMENT '',
  `date_added` DATE NOT NULL COMMENT '',
  `date_removed` DATE NULL COMMENT '',
  `last_modified_by` VARCHAR(255) NOT NULL COMMENT '',
  PRIMARY KEY (`order_service_id`)  COMMENT '',
  INDEX `fk_tbl_order_services_01_idx` (`service_id` ASC)  COMMENT '',
  INDEX `fk_tbl_order_services_02_idx` (`order_id` ASC)  COMMENT '',
  CONSTRAINT `fk_tbl_order_services_01`
    FOREIGN KEY (`service_id`)
    REFERENCES `parkour_db`.`tbl_services` (`service_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbl_order_services_02`
    FOREIGN KEY (`order_id`)
    REFERENCES `parkour_db`.`tbl_orders` (`order_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `parkour_db`.`tbl_users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `parkour_db`.`tbl_users` (
  `user_first_name` VARCHAR(45) NOT NULL COMMENT '',
  `user_last_name` VARCHAR(45) NOT NULL COMMENT '',
  `street_address` VARCHAR(45) NOT NULL COMMENT '',
  `city` VARCHAR(45) NOT NULL COMMENT '',
  `state` VARCHAR(45) NOT NULL COMMENT '',
  `zip_code` INT NOT NULL COMMENT '',
  `phone_number` INT NULL COMMENT '',
  `email_address` VARCHAR(45) NULL COMMENT '',
  PRIMARY KEY (`user_first_name`, `user_last_name`)  COMMENT '')
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `parkour_db`.`tbl_contacts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `parkour_db`.`tbl_contacts` (
  `contact_id` INT NOT NULL COMMENT '',
  `contact_title` VARCHAR(45) NULL COMMENT '',
  `street_address` VARCHAR(45) NULL COMMENT '',
  `city` VARCHAR(45) NULL COMMENT '',
  `state` VARCHAR(45) NULL COMMENT '',
  `zip_code` INT NULL COMMENT '',
  `phone_number` VARCHAR(45) NULL COMMENT '',
  `email_address` VARCHAR(45) NULL COMMENT '',
  PRIMARY KEY (`contact_id`)  COMMENT '')
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `parkour_db`.`tbl_parking_locations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `parkour_db`.`tbl_parking_locations` (
  `location_id` INT NOT NULL COMMENT '',
  `location_coordinates` VARCHAR(45) NULL COMMENT '',
  `location_name` VARCHAR(45) NULL COMMENT '',
  `location_cost` INT NULL COMMENT '',
  `opening_time` VARCHAR(45) NULL COMMENT '',
  `closing_time` VARCHAR(45) NULL COMMENT '',
  `street_address` VARCHAR(45) NULL COMMENT '',
  `city` VARCHAR(45) NULL COMMENT '',
  `state` VARCHAR(45) NULL COMMENT '',
  `zip_code` INT NULL COMMENT '',
  PRIMARY KEY (`location_id`)  COMMENT '')
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `parkour_db`.`tbl_citations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `parkour_db`.`tbl_citations` (
  `citation_id` INT NOT NULL COMMENT '',
  `user_id` INT NULL COMMENT '',
  `date` VARCHAR(45) NULL COMMENT '',
  `time` VARCHAR(45) NULL COMMENT '',
  `fine_amount` INT NULL COMMENT '',
  `citation_location` VARCHAR(45) NULL COMMENT '',
  PRIMARY KEY (`citation_id`)  COMMENT '')
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `parkour_db`.`tbl_parking_space`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `parkour_db`.`tbl_parking_space` (
  `parking_space_id` INT NOT NULL COMMENT '',
  `location_id` INT NULL COMMENT '',
  `location_cost` INT NULL COMMENT '',
  `space_status` TINYINT(1) NULL COMMENT '',
  `timestamp_entered` VARCHAR(45) NULL COMMENT '',
  `timestamp_expiration` VARCHAR(45) NULL COMMENT '',
  `timestamp_exit` VARCHAR(45) NULL COMMENT '',
  `user_id` INT NULL COMMENT '',
  PRIMARY KEY (`parking_space_id`)  COMMENT '')
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `parkour_db`.`tbl_users_parking_event`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `parkour_db`.`tbl_users_parking_event` (
  `location_id` INT NOT NULL COMMENT '',
  `park_time` VARCHAR(45) NULL COMMENT '',
  `park_space` INT NULL COMMENT '',
  `user_id` INT NULL COMMENT '')
ENGINE = InnoDB;

USE `parkour_db` ;

-- -----------------------------------------------------
-- View `parkour_db`.`v_customer_vehicles`
-- -----------------------------------------------------
USE `parkour_db`;
CREATE  OR REPLACE VIEW parkour_db.v_customer_vehicles AS 
SELECT
  c.customer_last_name AS customer_last_name
 ,c.customer_first_name AS customer_first_name
 ,c.email_address AS email_address
 ,v.vehicle_make AS vehicle_make
 ,v.vehicle_model AS vehicle_model
 ,v.vehicle_vin_number AS vehicle_vin_number
 ,v.vehicle_year AS vehicle_year
FROM parkour_db.tbl_customer_vehicles cv
JOIN parkour_db.tbl_vehicles v ON cv.vehicle_id = v.vehicle_id 
JOIN parkour_db.tbl_customers c ON cv.customer_id = c.customer_id
WHERE isnull(cv.date_removed)
ORDER BY
  c.customer_last_name
 ,c.customer_first_name
 ,v.vehicle_make
 ,v.vehicle_model
 ,v.vehicle_year;

-- -----------------------------------------------------
-- View `parkour_db`.`v_vehicle_services`
-- -----------------------------------------------------
USE `parkour_db`;
CREATE  OR REPLACE VIEW `v_vehicle_services` AS
SELECT v.vehicle_id
     , v.vehicle_make
     , v.vehicle_model
     , v.vehicle_year
     , v.vehicle_vin_number
     , s.service_name
     , s.parts_price
     , s.labor_price
     , s.is_warranty
     , s.warranty_description
FROM parkour_db.tbl_vehicles v
JOIN parkour_db.tbl_vehicle_services vs ON  vs.vehicle_id = v.vehicle_id
JOIN parkour_db.tbl_services s ON s.service_id = vs.service_id




;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
