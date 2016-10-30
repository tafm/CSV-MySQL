-- MySQL Script generated by MySQL Workbench
-- Sáb 29 Out 2016 23:19:24 BRT
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema dashboard
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema dashboard
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `dashboard` DEFAULT CHARACTER SET utf8 ;
USE `dashboard` ;

-- -----------------------------------------------------
-- Table `dashboard`.`Modulo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dashboard`.`Modulo` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dashboard`.`Construto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dashboard`.`Construto` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `id_modulo` INT NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Construto_Modulo_idx` (`id_modulo` ASC),
  CONSTRAINT `fk_Construto_Modulo`
    FOREIGN KEY (`id_modulo`)
    REFERENCES `dashboard`.`Modulo` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dashboard`.`Variavel`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dashboard`.`Variavel` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `id_construto` INT NOT NULL,
  `descricao` VARCHAR(45) NOT NULL,
  `tipo` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Variavel_Construto1_idx` (`id_construto` ASC),
  CONSTRAINT `fk_Variavel_Construto1`
    FOREIGN KEY (`id_construto`)
    REFERENCES `dashboard`.`Construto` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dashboard`.`Curso`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dashboard`.`Curso` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dashboard`.`Disciplina`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dashboard`.`Disciplina` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dashboard`.`Curso_Disciplina`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dashboard`.`Curso_Disciplina` (
  `id_disciplina` INT NOT NULL,
  `id_curso` INT NOT NULL,
  `periodo` INT(11) NULL,
  PRIMARY KEY (`id_disciplina`, `id_curso`),
  INDEX `fk_Disciplina_has_Curso_Curso1_idx` (`id_curso` ASC),
  INDEX `fk_Disciplina_has_Curso_Disciplina1_idx` (`id_disciplina` ASC),
  CONSTRAINT `fk_Disciplina_has_Curso_Disciplina1`
    FOREIGN KEY (`id_disciplina`)
    REFERENCES `dashboard`.`Disciplina` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Disciplina_has_Curso_Curso1`
    FOREIGN KEY (`id_curso`)
    REFERENCES `dashboard`.`Curso` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dashboard`.`Aluno`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dashboard`.`Aluno` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `id_curso` INT NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Aluno_Curso1_idx` (`id_curso` ASC),
  CONSTRAINT `fk_Aluno_Curso1`
    FOREIGN KEY (`id_curso`)
    REFERENCES `dashboard`.`Curso` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dashboard`.`Turma`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dashboard`.`Turma` (
  `id_disciplina` INT NOT NULL,
  `ano` INT(11) NOT NULL,
  `semestre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ano`, `semestre`, `id_disciplina`),
  INDEX `fk_Turma_Disciplina1_idx` (`id_disciplina` ASC),
  CONSTRAINT `fk_Turma_Disciplina1`
    FOREIGN KEY (`id_disciplina`)
    REFERENCES `dashboard`.`Disciplina` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dashboard`.`Variavel_Aluno`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dashboard`.`Variavel_Aluno` (
  `id_variavel` INT NOT NULL,
  `id_aluno` INT NOT NULL,
  `valor` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_variavel`, `id_aluno`),
  INDEX `fk_Variavel_has_Aluno_Aluno1_idx` (`id_aluno` ASC),
  INDEX `fk_Variavel_has_Aluno_Variavel1_idx` (`id_variavel` ASC),
  CONSTRAINT `fk_Variavel_has_Aluno_Variavel1`
    FOREIGN KEY (`id_variavel`)
    REFERENCES `dashboard`.`Variavel` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Variavel_has_Aluno_Aluno1`
    FOREIGN KEY (`id_aluno`)
    REFERENCES `dashboard`.`Aluno` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dashboard`.`Turma_Aluno`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dashboard`.`Turma_Aluno` (
  `ano_turma` INT(11) NOT NULL,
  `semestre_turma` VARCHAR(45) NOT NULL,
  `id_disciplina_turma` INT NOT NULL,
  `id_aluno` INT NOT NULL,
  PRIMARY KEY (`ano_turma`, `semestre_turma`, `id_disciplina_turma`, `id_aluno`),
  INDEX `fk_Turma_has_Aluno_Aluno1_idx` (`id_aluno` ASC),
  INDEX `fk_Turma_has_Aluno_Turma1_idx` (`ano_turma` ASC, `semestre_turma` ASC, `id_disciplina_turma` ASC),
  CONSTRAINT `fk_Turma_has_Aluno_Turma1`
    FOREIGN KEY (`ano_turma` , `semestre_turma` , `id_disciplina_turma`)
    REFERENCES `dashboard`.`Turma` (`ano` , `semestre` , `id_disciplina`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Turma_has_Aluno_Aluno1`
    FOREIGN KEY (`id_aluno`)
    REFERENCES `dashboard`.`Aluno` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;