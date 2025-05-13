-- MySQL Script corrigido para compatibilidade com MariaDB

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Floricultura
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `Floricultura`;
CREATE SCHEMA IF NOT EXISTS `Floricultura` DEFAULT CHARACTER SET utf8;
USE `Floricultura`;

-- -----------------------------------------------------
-- Table `usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `usuarios` (
  `id_usuarios` INT NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `telefone` VARCHAR(45) NOT NULL,
  `login` VARCHAR(45) NOT NULL,
  `senha` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_usuarios`)
) ENGINE=InnoDB;

-- -----------------------------------------------------
-- Table `endereco`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `endereco` (
  `id_endereco` INT NOT NULL,
  `rua` VARCHAR(45) NOT NULL,
  `numero` VARCHAR(45) NOT NULL,
  `complemento` VARCHAR(45) NULL,
  `bairro` VARCHAR(45) NOT NULL,
  `cidade` VARCHAR(45) NOT NULL,
  `UF` VARCHAR(2) NULL,
  PRIMARY KEY (`id_endereco`)
) ENGINE=InnoDB;

-- -----------------------------------------------------
-- Table `clientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `clientes` (
  `id_clientes` INT NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `telefone` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NULL,
  `endereco_id_endereco` INT NOT NULL,
  PRIMARY KEY (`id_clientes`),
  INDEX `fk_clientes_endereco1_idx` (`endereco_id_endereco`),
  CONSTRAINT `fk_clientes_endereco1`
    FOREIGN KEY (`endereco_id_endereco`)
    REFERENCES `endereco` (`id_endereco`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE=InnoDB;

-- -----------------------------------------------------
-- Table `produto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `produto` (
  `id_produto` INT NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `descricao` VARCHAR(100) NOT NULL,
  `preco` FLOAT NOT NULL,
  `categoria` VARCHAR(45) NOT NULL,
  `fornecedor` VARCHAR(45) NOT NULL,
  `estoque` VARCHAR(45) NOT NULL,
  `data_fabricacao` DATE NULL,
  `data_validade` DATE NULL,
  `marca` VARCHAR(45) NULL,
  PRIMARY KEY (`id_produto`)
) ENGINE=InnoDB;

-- -----------------------------------------------------
-- Table `venda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `venda` (
  `clientes_id_clientes` INT NOT NULL,
  `id_venda` INT NOT NULL,
  `data_venda` DATETIME(6) NOT NULL,
  `total` FLOAT(10,2) NOT NULL,
  PRIMARY KEY (`clientes_id_clientes`, `id_venda`),
  INDEX `fk_clientes_has_produto_clientes1_idx` (`clientes_id_clientes`),
  CONSTRAINT `fk_clientes_has_produto_clientes1`
    FOREIGN KEY (`clientes_id_clientes`)
    REFERENCES `clientes` (`id_clientes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE=InnoDB;

-- -----------------------------------------------------
-- Table `itens_venda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `itens_venda` (
  `id_itens_venda` INT NOT NULL,
  `quantidade` INT NOT NULL,
  `preco_unitario` DECIMAL(10,2) NOT NULL,
  `subtotal` DECIMAL(10,2) NOT NULL,
  `venda_clientes_id_clientes` INT NOT NULL,
  `venda_id_venda` INT NOT NULL,
  `produto_id_produto` INT NOT NULL,
  PRIMARY KEY (`id_itens_venda`, `venda_clientes_id_clientes`, `venda_id_venda`),
  INDEX `fk_itens_venda_venda1_idx` (`venda_clientes_id_clientes`, `venda_id_venda`),
  INDEX `fk_itens_venda_produto1_idx` (`produto_id_produto`),
  CONSTRAINT `fk_itens_venda_venda1`
    FOREIGN KEY (`venda_clientes_id_clientes`, `venda_id_venda`)
    REFERENCES `venda` (`clientes_id_clientes`, `id_venda`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_itens_venda_produto1`
    FOREIGN KEY (`produto_id_produto`)
    REFERENCES `produto` (`id_produto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE=InnoDB;

-- Reset SQL modes
SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
