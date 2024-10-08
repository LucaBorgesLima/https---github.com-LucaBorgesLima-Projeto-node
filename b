SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';


CREATE SCHEMA IF NOT EXISTS `Car Parking` DEFAULT CHARACTER SET utf8 ;
USE `Car Parking` ;


CREATE TABLE IF NOT EXISTS `Car Parking`.`cliente` (
  `idcliente` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `telefone` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idcliente`))
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `Car Parking`.`marca` (
  `idmarca` INT NOT NULL AUTO_INCREMENT,
  `marca` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idmarca`))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `Car Parking`.`modelo` (
  `idmodelo` INT NOT NULL AUTO_INCREMENT,
  `modelo` VARCHAR(45) NOT NULL,
  `marca_idmarca` INT NOT NULL,
  PRIMARY KEY (`idmodelo`),
  INDEX `fk_modelo_marca1_idx` (`marca_idmarca` ASC),
  CONSTRAINT `fk_modelo_marca1`
    FOREIGN KEY (`marca_idmarca`)
    REFERENCES `Car Parking`.`marca` (`idmarca`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `Car Parking`.`veiculo` (
  `idveiculo` INT NOT NULL AUTO_INCREMENT,
  `placa` VARCHAR(7) NOT NULL,
  `cor` VARCHAR(45) NOT NULL,
  `cliente_idcliente` INT NOT NULL,
  `modelo_idmodelo` INT NOT NULL,
  PRIMARY KEY (`idveiculo`),
  INDEX `fk_veiculo_cliente_idx` (`cliente_idcliente` ASC),
  INDEX `fk_veiculo_modelo1_idx` (`modelo_idmodelo` ASC),
  CONSTRAINT `fk_veiculo_cliente`
    FOREIGN KEY (`cliente_idcliente`)
    REFERENCES `Car Parking`.`cliente` (`idcliente`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_veiculo_modelo1`
    FOREIGN KEY (`modelo_idmodelo`)
    REFERENCES `Car Parking`.`modelo` (`idmodelo`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `Car Parking`.`vaga` (
  `idvaga` INT NOT NULL AUTO_INCREMENT,
  `numero` INT NOT NULL,
  `status` ENUM('livre', 'ocupada', 'reservada') NOT NULL DEFAULT 'livre',
  `horario_entrada` DATETIME NOT NULL,
  `horario_saida` DATETIME NULL,
  `veiculo_idveiculo` INT,
  PRIMARY KEY (`idvaga`),
  INDEX `fk_vaga_veiculo1_idx` (`veiculo_idveiculo` ASC),
  CONSTRAINT `fk_vaga_veiculo1`
    FOREIGN KEY (`veiculo_idveiculo`)
    REFERENCES `Car Parking`.`veiculo` (`idveiculo`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `Car Parking`.`orcamento` (
  `idorcamento` INT NOT NULL AUTO_INCREMENT,
  `preco` DECIMAL(10, 2) NOT NULL,
  `data_criacao` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `vaga_idvaga` INT NOT NULL,
  PRIMARY KEY (`idorcamento`),
  INDEX `fk_orcamento_vaga1_idx` (`vaga_idvaga` ASC),
  CONSTRAINT `fk_orcamento_vaga1`
    FOREIGN KEY (`vaga_idvaga`)
    REFERENCES `Car Parking`.`vaga` (`idvaga`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `Car Parking`.`pagamento` (
  `idpagamento` INT NOT NULL AUTO_INCREMENT,
  `tipo_pagamento` VARCHAR(45) NOT NULL,
  `orcamento_idorcamento` INT NOT NULL,
  PRIMARY KEY (`idpagamento`),
  INDEX `fk_pagamento_orcamento1_idx` (`orcamento_idorcamento` ASC),
  CONSTRAINT `fk_pagamento_orcamento1`
    FOREIGN KEY (`orcamento_idorcamento`)
    REFERENCES `Car Parking`.`orcamento` (`idorcamento`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;



INSERT INTO `Car Parking`.`cliente`
VALUES (1,'Luca', '(11)876543212');

select * from modelo;
select * from vaga;
select* from veiculo;
select* from cliente;
select * from marca;
select * from orcamento;
ALTER TABLE marca ADD CONSTRAINT UNIQUE (marca);


select m.modelo , ve.placa
from veiculo ve 
join modelo m on ve.modelo_idmodelo = m.idmodelo;

select ve.idveiculo,m.modelo,ve.placa,va.horario_entrada , va.horario_saida, o.preco
from vaga va
join veiculo ve on va.veiculo_idveiculo = ve.idveiculo
join  modelo m on ve.modelo_idmodelo = m.idmodelo
join orcamento o on va.idvaga = o.vaga_idvaga
where idorcamento = 2 ;






ALTER TABLE vaga;
MODIFY horario_entrada datetime NULL;

ALTER TABLE vaga
MODIFY status  varchar(10) NOT NULL;

INSERT INTO vaga (numero,status) VALUES (10,'livre');

SELECT horario_entrada,horario_saida FROM vaga WHERE idvaga = 2;
SELECT horario_entrada,horario_saida FROM vaga WHERE idvaga = 1;


select m.modelo, v.placa
from veiculo v 
join modelo m on v.modelo_idmodelo = m.idmodelo;
