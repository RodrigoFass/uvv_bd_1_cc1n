-- SQLINES DEMO *** orward Engineering

/* SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0; */
/* SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0; */
/* SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION'; */

-- SQLINES DEMO *** ------------------------------------
-- Schema hr
-- SQLINES DEMO *** ------------------------------------

-- SQLINES DEMO *** ------------------------------------
-- Schema hr
-- SQLINES DEMO *** ------------------------------------
CREATE SCHEMA IF NOT EXISTS hr DEFAULT CHARACTER SET utf8 COLLATE utf8_bin ;
SET SCHEMA 'hr' ;

-- SQLINES DEMO *** ------------------------------------
-- SQLINES DEMO *** es`
-- SQLINES DEMO *** ------------------------------------
-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE TABLE IF NOT EXISTS hr.Regioes (
  id_regiao INT NOT NULL ,
  nome VARCHAR(25) NOT NULL ,
  PRIMARY KEY (id_regiao),
  CONSTRAINT nome_UNIQUE UNIQUE (nome) VISIBLE)
ENGINE = InnoDB
COMMENT = 'Tatebela regioes;nnela contem o Id da regiaone o nome.';


-- SQLINES DEMO *** ------------------------------------
-- Table `hr`.`Paises`
-- SQLINES DEMO *** ------------------------------------
-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE TABLE IF NOT EXISTS hr.Paises (
  id_pais CHAR(2) NOT NULL ,
  nome VARCHAR(50) NOT NULL ,
  id_regiao INT NOT NULL ,
  PRIMARY KEY (id_pais),
  CONSTRAINT nome_UNIQUE UNIQUE (nome) VISIBLE,
  INDEX fk_Paises_Regioes_idx (id_regiao ASC) VISIBLE,
  CONSTRAINT fk_Paises_Regioes
    FOREIGN KEY (id_regiao)
    REFERENCES hr.Regioes (id_regiao)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Tabela paises;nnela contem o id do pais,nnome, e o id da regiao.';


-- SQLINES DEMO *** ------------------------------------
-- SQLINES DEMO *** izaçoes`
-- SQLINES DEMO *** ------------------------------------
-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE TABLE IF NOT EXISTS hr.localizaçoes (
  id_localizaçao INT NOT NULL ,
  endereço VARCHAR(50) NULL ,
  cep VARCHAR(12) NULL ,
  cidade VARCHAR(50) NULL ,
  uf VARCHAR(25) NULL ,
  id_pais CHAR(2) NOT NULL ,
  PRIMARY KEY (id_localizaçao)
  CREATE INDEX fk_localizaçoes_Paises1_idx ON hr.localizaçoes (id_pais ASC) VISIBLE,
  CONSTRAINT fk_localizaçoes_Paises1
    FOREIGN KEY (id_pais)
    REFERENCES hr.Paises (id_pais)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Tabela localizaçoes;nnela contem os indereços de varios escritorios;nela nao armazena os endereços dos clientes';


-- SQLINES DEMO *** ------------------------------------
-- Table `hr`.`cargos`
-- SQLINES DEMO *** ------------------------------------
-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE TABLE IF NOT EXISTS hr.cargos (
  id_cargo VARCHAR(10) NOT NULL ,
  cargo VARCHAR(35) NOT NULL ,
  salario_minimo DECIMAL(8,2) NULL ,
  salario_maximo DECIMAL(8,2) NULL ,
  PRIMARY KEY (id_cargo),
  CONSTRAINT cargo_UNIQUE UNIQUE (cargo) VISIBLE)
ENGINE = InnoDB
COMMENT = 'tabela de cargos';


-- SQLINES DEMO *** ------------------------------------
-- SQLINES DEMO *** gados`
-- SQLINES DEMO *** ------------------------------------
-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE TABLE IF NOT EXISTS hr.empregados (
  id_empregado INT NOT NULL ,
  nome VARCHAR(75) NOT NULL ,
  email VARCHAR(35) NOT NULL ,
  telefone VARCHAR(20) NULL ,
  data_contrataçao DATE NOT NULL ,
  id_cargo VARCHAR(10) NOT NULL ,
  salario DECIMAL(8,2) NULL ,
  comissao DECIMAL(8,2) NULL ,
  id_departamento INT NOT NULL ,
  id_supervisor INT NOT NULL ,
  PRIMARY KEY (id_empregado),
  CONSTRAINT email_UNIQUE UNIQUE (email) VISIBLE,
  INDEX fk_empregados_cargos1_idx (id_cargo ASC) VISIBLE,
  INDEX fk_empregados_departamentos1_idx (id_departamento ASC) VISIBLE,
  INDEX fk_empregados_empregados1_idx (id_supervisor ASC) VISIBLE,
  CONSTRAINT fk_empregados_cargos1
    FOREIGN KEY (id_cargo)
    REFERENCES hr.cargos (id_cargo)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_empregados_departamentos1
    FOREIGN KEY (id_departamento)
    REFERENCES hr.departamentos (id_departamento)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_empregados_empregados1
    FOREIGN KEY (id_supervisor)
    REFERENCES hr.empregados (id_empregado)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Tabela que contém as informações dos empregados.';


-- SQLINES DEMO *** ------------------------------------
-- SQLINES DEMO *** tamentos`
-- SQLINES DEMO *** ------------------------------------
-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE TABLE IF NOT EXISTS hr.departamentos (
  id_departamento INT NOT NULL ,
  nome VARCHAR(50) NULL ,
  id_localizaçao INT NOT NULL ,
  id_gerente INT NOT NULL ,
  PRIMARY KEY (id_departamento),
  CONSTRAINT nome_UNIQUE UNIQUE (nome) VISIBLE,
  INDEX fk_departamentos_localizaçoes1_idx (id_localizaçao ASC) VISIBLE,
  INDEX fk_departamentos_empregados1_idx (id_gerente ASC) VISIBLE,
  CONSTRAINT fk_departamentos_localizaçoes1
    FOREIGN KEY (id_localizaçao)
    REFERENCES hr.localizaçoes (id_localizaçao)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_departamentos_empregados1
    FOREIGN KEY (id_gerente)
    REFERENCES hr.empregados (id_empregado)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Uma tabela contendo informações da divisão da empresa.';


-- SQLINES DEMO *** ------------------------------------
-- SQLINES DEMO *** rico_cargos`
-- SQLINES DEMO *** ------------------------------------
-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE TABLE IF NOT EXISTS hr.historico_cargos (
  data_inicial DATE NOT NULL ,
  id_empregado INT NOT NULL ,
  data_final DATE NOT NULL ,
  id_cargo VARCHAR(10) NOT NULL ,
  id_departamento INT NOT NULL 
  CREATE INDEX fk_historico_cargos_empregados1_idx ON hr.historico_cargos (id_empregado ASC) VISIBLE,
  PRIMARY KEY (data_inicial),
  INDEX fk_historico_cargos_cargos1_idx (id_cargo ASC) VISIBLE,
  INDEX fk_historico_cargos_departamentos1_idx (id_departamento ASC) VISIBLE,
  CONSTRAINT fk_historico_cargos_empregados1
    FOREIGN KEY (id_empregado)
    REFERENCES hr.empregados (id_empregado)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_historico_cargos_cargos1
    FOREIGN KEY (id_cargo)
    REFERENCES hr.cargos (id_cargo)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_historico_cargos_departamentos1
    FOREIGN KEY (id_departamento)
    REFERENCES hr.departamentos (id_departamento)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Tabela que armazena o histórico de cargos de um empregado.';


-- SQLINES DEMO *** ------------------------------------
-- SQLINES DEMO *** tamps`
-- SQLINES DEMO *** ------------------------------------
-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE TABLE IF NOT EXISTS hr.timestamps (
  create_time TIMESTAMP(0) NULL DEFAULT CURRENT_TIMESTAMP,
  update_time TIMESTAMP(0) NULL);


-- SQLINES DEMO *** ------------------------------------
-- Table `hr`.`user`
-- SQLINES DEMO *** ------------------------------------
-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE TABLE IF NOT EXISTS hr.user (
  username VARCHAR(16) NOT NULL,
  email VARCHAR(255) NULL,
  password VARCHAR(32) NOT NULL,
  create_time TIMESTAMP(0) NULL DEFAULT CURRENT_TIMESTAMP);


-- SQLINES DEMO *** ------------------------------------
-- SQLINES DEMO *** ory`
-- SQLINES DEMO *** ------------------------------------
-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE TABLE IF NOT EXISTS hr.category (
  category_id INT NOT NULL,
  name VARCHAR(255) NOT NULL,
  PRIMARY KEY (category_id));


/* SET SQL_MODE=@OLD_SQL_MODE; */
/* SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS; */
/* SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS; */
