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

CREATE TABLE IF NOT EXISTS `fornecedores` (
  `id_fornecedor` INT NOT NULL,
  `nome` VARCHAR(100) NOT NULL,
  `cnpj` VARCHAR(18) NOT NULL,
  `telefone` VARCHAR(45) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `endereco` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id_fornecedor`)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS `produto` (
  `id_produto` INT NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `descricao` VARCHAR(100) NOT NULL,
  `preco` FLOAT NOT NULL,
  `categoria` VARCHAR(45) NOT NULL,
  `id_fornecedor` INT NOT NULL,
  `estoque` VARCHAR(45) NOT NULL,
  `data_fabricacao` DATE NULL,
  `data_validade` DATE NULL,
  `marca` VARCHAR(45) NULL,
  PRIMARY KEY (`id_produto`),
  INDEX `fk_produto_fornecedor_idx` (`id_fornecedor`),
  CONSTRAINT `fk_produto_fornecedor`
    FOREIGN KEY (`id_fornecedor`)
    REFERENCES `fornecedores` (`id_fornecedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
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

INSERT INTO usuarios (id_usuarios, nome, email, telefone, login, senha) VALUES
(1, 'Administrador', 'adm@floricultura.com', '11999999999', 'admin', 'admin123'),
(2, 'Funcionário João', 'joao@floricultura.com', '11988887777', 'joao', 'senha123');

INSERT INTO endereco (id_endereco, rua, numero, complemento, bairro, cidade, UF) VALUES
(1, 'Rua das Rosas', '123', 'Apto 12', 'Jardim das Flores', 'São Paulo', 'SP'),
(2, 'Av. das Acácias', '456', NULL, 'Centro', 'Campinas', 'SP');

INSERT INTO clientes (id_clientes, nome, telefone, email, endereco_id_endereco) VALUES
(1, 'Maria Silva', '11987654321', 'maria.silva@email.com', 1),
(2, 'Carlos Oliveira', '11912345678', 'carlos.oliveira@email.com', 2);

INSERT INTO fornecedores (id_fornecedor, nome, cnpj, telefone, email, endereco) VALUES
(1, 'Flores Bela', '12.345.678/0001-90', '1122334455', 'contato@floresbela.com', 'Rua Florença, 100 - São Paulo/SP'),
(2, 'Orquideas Reais', '98.765.432/0001-10', '11988776655', 'vendas@orquideasreais.com', 'Av. Botânica, 456 - Campinas/SP'),
(3, 'Cerâmica ArteFlor', '11.111.222/0001-33', '1133445566', 'arteflor@ceramica.com', 'Rua das Artes, 99 - Sorocaba/SP'),
(4, 'Estação das Flores', '22.222.333/0001-44', '1177886655', 'contato@estacaoflores.com', 'Av. Primavera, 888 - Jundiaí/SP');

INSERT INTO produto (id_produto, nome, descricao, preco, categoria, id_fornecedor, estoque, data_fabricacao, data_validade, marca) VALUES
(1, 'Buquê de Rosas Vermelhas', 'Buquê com 12 rosas vermelhas', 79.90, 'Flores', 1, '20', '2025-05-01', NULL, 'NatureFlora'),
(2, 'Orquídea Branca', 'Vaso com orquídea branca', 59.90, 'Flores', 2, '15', '2025-04-20', NULL, 'OrquiLux'),
(3, 'Vaso Decorativo', 'Vaso de cerâmica decorado', 34.50, 'Acessórios', 3, '50', '2025-03-10', NULL, 'FlorDecor'),
(4, 'Arranjo Primavera', 'Arranjo com flores da estação', 89.90, 'Arranjos', 4, '10', '2025-05-10', NULL, 'PrimaveraFlor');

INSERT INTO venda (clientes_id_clientes, id_venda, data_venda, total) VALUES
(1, 1, NOW(), 169.80);

INSERT INTO itens_venda (id_itens_venda, quantidade, preco_unitario, subtotal, venda_clientes_id_clientes, venda_id_venda, produto_id_produto) VALUES
(1, 1, 79.90, 79.90, 1, 1, 1),
(2, 1, 89.90, 89.90, 1, 1, 4);

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
