CREATE DATABASE flow;
USE flow;

CREATE TABLE empresa (
idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
cnpj CHAR(14),
nomeFantasia VARCHAR(45),
razaoSocial VARCHAR(45)
);

INSERT INTO empresa VALUES
(DEFAULT, '33401443000144', 'Lojas Americanas', 'Lojas Americanas S.A.'),
(DEFAULT,'33001467000101', 'Magazine Luiza', 'Magazine Luiza S.A.'),
(DEFAULT,'59109165000149', 'Casas Bahia', 'Via Varejo S.A.'),
(DEFAULT,'27865757000102', 'Ponto', 'Ponto Frio Comércio Eletrônico S.A.');

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

INSERT INTO endereco (cep, logradouro, numero, estado, cidade, regiao, fkEmpresa) VALUES
('01310-100', 'Av Paulista', '1500', 'SP', 'São Paulo', 'Sudeste', 1),
('13400-000', 'Rua XV de Novembro', '300', 'SP', 'Piracicaba', 'Sudeste', 2),
('20040-020', 'Rua do Ouvidor', '120', 'RJ', 'Rio de Janeiro', 'Sudeste', 3),
('30140-110', 'Av Afonso Pena', '900', 'MG', 'Belo Horizonte', 'Sudeste', 4);

CREATE TABLE usuario (
idUsuario INT PRIMARY KEY AUTO_INCREMENT,
nomeUsuario VARCHAR(45),
email VARCHAR(45),
senha VARCHAR(45),
fkEmpresa INT,
CONSTRAINT fkEmpresaUsuario
FOREIGN KEY (fkEmpresa) REFERENCES empresa (idEmpresa)
);

INSERT INTO usuario (nomeUsuario, email, senha, fkEmpresa) VALUES
('Ana Silva', 'ana@americanas.com', '123456', 1),
('Carlos Souza', 'carlos@magalu.com', '123456', 2),
('Fernanda Lima', 'fernanda@casasbahia.com', '123456', 3),
('Bruno Rocha', 'bruno@ponto.com', '123456', 4);

CREATE TABLE permissao (
idPermisao 	INT PRIMARY KEY AUTO_INCREMENT,
cargo 	VARCHAR(45),
fkUsuario	INT,
CONSTRAINT chfkUsuario FOREIGN KEY (fkUsuario) REFERENCES usuario (idUsuario),
CONSTRAINT chfkCargo CHECK (cargo IN ('Gerente', 'Consultor'))
);

INSERT INTO permissao (cargo, fkUsuario) VALUES
('Gerente', 1),
('Consultor', 2),
('Gerente', 3),
('Consultor', 4);

CREATE TABLE setor (
idSetor INT PRIMARY KEY AUTO_INCREMENT,
nomeSetor VARCHAR(45),
descricao VARCHAR(45),
fkEmpresa INT,
CONSTRAINT fkEmpresaSetor
FOREIGN KEY (fkEmpresa) REFERENCES empresa (idEmpresa)
);

INSERT INTO setor (nomeSetor, descricao, fkEmpresa) VALUES
('Alimentício', 'Corredor 1 - Produtos alimentícios', 1),
('Vestuário', 'Corredor 2 - Roupas e acessórios', 1),
('Doceria', 'Corredor 3 - Doces e chocolates', 2),
('Eletrodomésticos', 'Corredor 4 - Produtos eletrônicos', 2),
('Alimentício', 'Corredor 1 - Produtos alimentícios', 3),
('Vestuário', 'Corredor 5 - Moda geral', 3),
('Doceria', 'Corredor 2 - Área de doces', 4),
('Eletrodomésticos', 'Corredor 6 - eletrodomésticos e eletrônicos', 4);

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

INSERT INTO sensor (numeroSerie, statusOperacional, dataInstalacao, ultimaManutencao, fkSetor) VALUES
('FLUX-1001', 'Ativo', '2025-01-10', '2026-01-10', 1),
('FLUX-1002', 'Ativo', '2025-02-15', '2026-02-15', 2),
('FLUX-1003', 'Inativo', '2024-08-20', '2025-08-20', 3),
('FLUX-1004', 'Ativo', '2025-03-05', '2026-03-05', 4);

CREATE TABLE registroSensor (
idRegistroSensor INT PRIMARY KEY AUTO_INCREMENT,
leitura TINYINT,
dataLeitura DATETIME DEFAULT CURRENT_TIMESTAMP,
fkSensor INT,
CONSTRAINT chfkSensor
FOREIGN KEY (fkSensor) REFERENCES sensor (idSensor),
CONSTRAINT chfkLeitura CHECK (leitura IN ('0', '1'))
);
