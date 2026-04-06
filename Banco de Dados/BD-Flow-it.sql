CREATE DATABASE flow;

USE flow;

CREATE TABLE empresa (
idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
cnpj CHAR(14),
nomeFantasia VARCHAR(45),
razaoSocial VARCHAR(45)
);

CREATE TABLE endereco (
idEndereco INT PRIMARY KEY AUTO_INCREMENT,
cep CHAR(9),
logradouro VARCHAR(45),
numero CHAR(6),
estado VARCHAR(45),
cidade VARCHAR(45),
regiao VARCHAR(45),
fkEmpresa INT,
CONSTRAINT chfkEmpresa
FOREIGN KEY (fkEmpresa) REFERENCES empresa (idEmpresa)
);

CREATE TABLE usuario (
idUsuario INT PRIMARY KEY AUTO_INCREMENT,
nomeUsuario VARCHAR(45),
email VARCHAR(45),
senha VARCHAR(45),
fkEmpresa INT,
CONSTRAINT chfkEmpresa
FOREIGN KEY (fkEmpresa) REFERENCES empresa (idEmpresa)
);

CREATE TABLE permissao (
idPermisao 	INT PRIMARY KEY AUTO_INCREMENT,
cargo 	VARCHAR(45),
fkUsuario	INT,
CONSTRAINT chfkUsuario FOREIGN KEY (fkUsuario) REFERENCES usuario (idUsuario),
CONSTRAINT chfkCargo CHECK (cargo IN ('Gerente', 'Consultor'))
);

CREATE TABLE setor (
idSetor INT PRIMARY KEY AUTO_INCREMENT,
nomeSetor VARCHAR(45),
descricao VARCHAR(45),
fkEmpresa INT,
CONSTRAINT chfkEmpresa
FOREIGN KEY (fkEmpresa) REFERENCES empresa (idEmpresa)
);

CREATE TABLE sensor (
idSensor INT PRIMARY KEY AUTO_INCREMENT,
numeroSerie VARCHAR(45),
statusOperacional VARCHAR(15),
dataInstalacao DATE,
ultimaManutencao DATE,
fkSetor INT,
CONSTRAINT chfkSetor
FOREIGN KEY (fkSetor) REFERENCES setor (idSetor)
);

CREATE TABLE registroSensor (
idRegistroSensor INT PRIMARY KEY AUTO_INCREMENT,
leitura TINYINT,
dataLeitura DATETIME,
fkSensor INT,
CONSTRAINT chfkSensor
FOREIGN KEY (fkSensor) REFERENCES sensor (idSensor),
CONSTRAINT chfkLeitura CHECK (leitura IN ('0', '1'))
);
