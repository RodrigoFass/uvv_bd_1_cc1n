-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema hr
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema hr
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `hr` DEFAULT CHARACTER SET utf8 COLLATE utf8_bin ;
USE `hr` ;

-- -----------------------------------------------------
-- Table `hr`.`Regioes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hr`.`Regioes` (
  `id_regiao` INT NOT NULL COMMENT 'id_regiao é a chave primaria da tabela regioes.',
  `nome` VARCHAR(25) NOT NULL COMMENT 'Nome das regioes.',
  PRIMARY KEY (`id_regiao`),
  UNIQUE INDEX `nome_UNIQUE` (`nome` ASC) VISIBLE)
ENGINE = InnoDB
COMMENT = 'Tatebela regioes;\nnela contem o Id da regiao\ne o nome.';


-- -----------------------------------------------------
-- Table `hr`.`Paises`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hr`.`Paises` (
  `id_pais` CHAR(2) NOT NULL COMMENT 'id_pais é a chave primaria da tabela paises',
  `nome` VARCHAR(50) NOT NULL COMMENT 'Nome do país.',
  `id_regiao` INT NOT NULL COMMENT 'id_regiao é uma chave estrangeira vinda da tabela regiao',
  PRIMARY KEY (`id_pais`),
  UNIQUE INDEX `nome_UNIQUE` (`nome` ASC) VISIBLE,
  INDEX `fk_Paises_Regioes_idx` (`id_regiao` ASC) VISIBLE,
  CONSTRAINT `fk_Paises_Regioes`
    FOREIGN KEY (`id_regiao`)
    REFERENCES `hr`.`Regioes` (`id_regiao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Tabela paises;\nnela contem o id do pais,\nnome, e o id da regiao.';


-- -----------------------------------------------------
-- Table `hr`.`localizaçoes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hr`.`localizaçoes` (
  `id_localizaçao` INT NOT NULL COMMENT 'id_localizaçao é a chave primaria da tabela localizaçoes',
  `endereço` VARCHAR(50) NULL COMMENT 'Endereço de um escritório.',
  `cep` VARCHAR(12) NULL COMMENT 'CEP da localização de um escritório.',
  `cidade` VARCHAR(50) NULL COMMENT 'Cidade onde está localizado o escritório.',
  `uf` VARCHAR(25) NULL COMMENT 'Estado onde está localizado o escritório',
  `id_pais` CHAR(2) NOT NULL COMMENT 'id_pais é uma chave estrangeira vinda da tebela paises',
  PRIMARY KEY (`id_localizaçao`),
  INDEX `fk_localizaçoes_Paises1_idx` (`id_pais` ASC) VISIBLE,
  CONSTRAINT `fk_localizaçoes_Paises1`
    FOREIGN KEY (`id_pais`)
    REFERENCES `hr`.`Paises` (`id_pais`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Tabela localizaçoes;\nnela contem os indereços de varios escritorios;\nela nao armazena os endereços dos clientes';


-- -----------------------------------------------------
-- Table `hr`.`cargos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hr`.`cargos` (
  `id_cargo` VARCHAR(10) NOT NULL COMMENT 'id_cargo é a chave primaria da tabela cargos',
  `cargo` VARCHAR(35) NOT NULL COMMENT 'Nome do cargo.',
  `salario_minimo` DECIMAL(8,2) NULL COMMENT 'O menor salário admitido para um cargo.',
  `salario_maximo` DECIMAL(8,2) NULL COMMENT 'O maior salário admitido para um cargo.',
  PRIMARY KEY (`id_cargo`),
  UNIQUE INDEX `cargo_UNIQUE` (`cargo` ASC) VISIBLE)
ENGINE = InnoDB
COMMENT = 'tabela de cargos';


-- -----------------------------------------------------
-- Table `hr`.`empregados`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hr`.`empregados` (
  `id_empregado` INT NOT NULL COMMENT 'id_empregados é a cheve primaria da tabela empregado.',
  `nome` VARCHAR(75) NOT NULL COMMENT 'Nome completo dos empregado.',
  `email` VARCHAR(35) NOT NULL COMMENT 'gmail dos empregados',
  `telefone` VARCHAR(20) NULL COMMENT 'Telefones dos empregados.',
  `data_contrataçao` DATE NOT NULL COMMENT 'Data que o empregado iniciou no cargo atual.',
  `id_cargo` VARCHAR(10) NOT NULL COMMENT 'id_cargo é uma chave estrangeira vinda da tabela cargos',
  `salario` DECIMAL(8,2) NULL COMMENT 'Salário mensal atual do empregado.',
  `comissao` DECIMAL(8,2) NULL COMMENT 'O percentual de comissão do funcionário.',
  `id_departamento` INT NOT NULL COMMENT 'id_departamento é uma chave estrangeira vinda da tabela departamentos',
  `id_supervisor` INT NOT NULL COMMENT 'Chave estrangeira para a própria tabela empregados (auto-relacionamento).',
  PRIMARY KEY (`id_empregado`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  INDEX `fk_empregados_cargos1_idx` (`id_cargo` ASC) VISIBLE,
  INDEX `fk_empregados_departamentos1_idx` (`id_departamento` ASC) VISIBLE,
  INDEX `fk_empregados_empregados1_idx` (`id_supervisor` ASC) VISIBLE,
  CONSTRAINT `fk_empregados_cargos1`
    FOREIGN KEY (`id_cargo`)
    REFERENCES `hr`.`cargos` (`id_cargo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_empregados_departamentos1`
    FOREIGN KEY (`id_departamento`)
    REFERENCES `hr`.`departamentos` (`id_departamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_empregados_empregados1`
    FOREIGN KEY (`id_supervisor`)
    REFERENCES `hr`.`empregados` (`id_empregado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Tabela que contém as informações dos empregados.';


-- -----------------------------------------------------
-- Table `hr`.`departamentos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hr`.`departamentos` (
  `id_departamento` INT NOT NULL COMMENT 'id_departamento é a chave primaria da tabela departamentos',
  `nome` VARCHAR(50) NULL COMMENT 'Nome do departamento.',
  `id_localizaçao` INT NOT NULL COMMENT 'id_localizaçao é uma chave estrangeira vinda da tabela localizaçao',
  `id_gerente` INT NOT NULL COMMENT 'id_gerente é uma chave estrangeira vinda da tabela empregados',
  PRIMARY KEY (`id_departamento`),
  UNIQUE INDEX `nome_UNIQUE` (`nome` ASC) VISIBLE,
  INDEX `fk_departamentos_localizaçoes1_idx` (`id_localizaçao` ASC) VISIBLE,
  INDEX `fk_departamentos_empregados1_idx` (`id_gerente` ASC) VISIBLE,
  CONSTRAINT `fk_departamentos_localizaçoes1`
    FOREIGN KEY (`id_localizaçao`)
    REFERENCES `hr`.`localizaçoes` (`id_localizaçao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_departamentos_empregados1`
    FOREIGN KEY (`id_gerente`)
    REFERENCES `hr`.`empregados` (`id_empregado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Uma tabela contendo informações da divisão da empresa.';


-- -----------------------------------------------------
-- Table `hr`.`historico_cargos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hr`.`historico_cargos` (
  `data_inicial` DATE NOT NULL COMMENT 'data_inicial é uma chave primaria da tabela historico_cargos\nIndica a data inicial do empregado em um novo cargo.',
  `id_empregado` INT NOT NULL COMMENT 'id_empregado é uma chave estrangeira vinda da tabela empregados e uma chave primaria da tabela historico_cargos',
  `data_final` DATE NOT NULL COMMENT 'Último dia de um empregado neste cargo.',
  `id_cargo` VARCHAR(10) NOT NULL COMMENT 'id_cargo é uma chave estrangeira vinda da tabela cargos',
  `id_departamento` INT NOT NULL COMMENT 'id_departamento é uma chave estrangeira vinda da tabela departamentos',
  INDEX `fk_historico_cargos_empregados1_idx` (`id_empregado` ASC) VISIBLE,
  PRIMARY KEY (`data_inicial`),
  INDEX `fk_historico_cargos_cargos1_idx` (`id_cargo` ASC) VISIBLE,
  INDEX `fk_historico_cargos_departamentos1_idx` (`id_departamento` ASC) VISIBLE,
  CONSTRAINT `fk_historico_cargos_empregados1`
    FOREIGN KEY (`id_empregado`)
    REFERENCES `hr`.`empregados` (`id_empregado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_historico_cargos_cargos1`
    FOREIGN KEY (`id_cargo`)
    REFERENCES `hr`.`cargos` (`id_cargo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_historico_cargos_departamentos1`
    FOREIGN KEY (`id_departamento`)
    REFERENCES `hr`.`departamentos` (`id_departamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Tabela que armazena o histórico de cargos de um empregado.';


-- -----------------------------------------------------
-- Table `hr`.`timestamps`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hr`.`timestamps` (
  `create_time` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` TIMESTAMP NULL);


-- -----------------------------------------------------
-- Table `hr`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hr`.`user` (
  `username` VARCHAR(16) NOT NULL,
  `email` VARCHAR(255) NULL,
  `password` VARCHAR(32) NOT NULL,
  `create_time` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP);


-- -----------------------------------------------------
-- Table `hr`.`category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hr`.`category` (
  `category_id` INT NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`category_id`));


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
