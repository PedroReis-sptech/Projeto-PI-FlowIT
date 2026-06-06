CREATE DATABASE flow;
USE flow;

CREATE TABLE loja (
    idLoja INT PRIMARY KEY AUTO_INCREMENT,
    cnpj CHAR(14),
    nomeFantasia VARCHAR(45),
    razaoSocial VARCHAR(45),
    codigoVerificacao CHAR(4) UNIQUE
);

INSERT INTO loja VALUES
(DEFAULT, '33401443000144', 'Lojas Americanas', 'Lojas Americanas S.A.', 'ABC1'),
(DEFAULT, '33001467000101', 'Magazine Luiza', 'Magazine Luiza S.A.', 'GAT4'),
(DEFAULT, '59109165000149', 'Casas Bahia', 'Via Varejo S.A.', 'LFN9'),
(DEFAULT, '27865757000102', 'Ponto', 'Ponto Frio Comércio Eletrônico S.A.', '4H6S');

CREATE TABLE endereco (
    idEndereco INT PRIMARY KEY AUTO_INCREMENT,
    cep CHAR(9),
    logradouro VARCHAR(45),
    numero CHAR(6),
    estado VARCHAR(45),
    cidade VARCHAR(45),
    regiao VARCHAR(45),
    fkloja INT,
    CONSTRAINT chfkloja FOREIGN KEY (fkloja) REFERENCES loja (idLoja)
);

INSERT INTO endereco (cep, logradouro, numero, estado, cidade, regiao, fkloja) VALUES
('01310-100', 'Av Paulista', '1500', 'SP', 'São Paulo', 'Sudeste', 1),
('13400-000', 'Rua XV de Novembro', '300', 'SP', 'Piracicaba', 'Sudeste', 2),
('20040-020', 'Rua do Ouvidor', '120', 'RJ', 'Rio de Janeiro', 'Sudeste', 3),
('30140-110', 'Av Afonso Pena', '900', 'MG', 'Belo Horizonte', 'Sudeste', 4);

CREATE TABLE permissao (
    idPermissao INT PRIMARY KEY AUTO_INCREMENT,
    cargo VARCHAR(45),
    CONSTRAINT chfkCargo CHECK (cargo IN ('Gerente', 'Consultor', 'Suporte'))
);

INSERT INTO permissao (cargo) VALUES
('Gerente'),
('Consultor'),
('Suporte');


CREATE TABLE usuario (
    idUsuario INT PRIMARY KEY AUTO_INCREMENT,
    nomeUsuario VARCHAR(45),
    email VARCHAR(45),
    senha VARCHAR(45),
    fkloja INT,
    fkPermissao INT,
    CONSTRAINT fklojaUsuario FOREIGN KEY (fkloja) REFERENCES loja (idLoja),
    CONSTRAINT chfkPermissao FOREIGN KEY (fkPermissao) REFERENCES permissao (idPermissao)
);

INSERT INTO usuario (nomeUsuario, email, senha, fkloja, fkPermissao) VALUES
('Ana Silva', 'ana@americanas.com', '123456', 1, 1),
('Carlos Souza', 'carlos@magalu.com', '123456', 2, 2),
('Fernanda Lima', 'fernanda@casasbahia.com', '123456', 3, 2),
('Claudio', 'suporte@flow.com', '123456', null, 3),
('Bruno Rocha', 'bruno@ponto.com', '123456', 4, 1);

CREATE TABLE setor (
    idSetor INT PRIMARY KEY AUTO_INCREMENT,
    nomeSetor VARCHAR(45),
    meta INT,
    fkloja INT,
    CONSTRAINT fklojaSetor FOREIGN KEY (fkloja) REFERENCES loja (idLoja)
);

INSERT INTO setor (nomeSetor, meta, fkloja) VALUES
('Alimentício', 100, 1),
('Vestuário', 100, 1),
('Utensilio', 100, 1),
('Eletrônicos', 100, 1),
('Higiene', 100, 1);

CREATE TABLE corredor (
    idCorredor INT PRIMARY KEY AUTO_INCREMENT,
    fkSetor INT,
    CONSTRAINT chfkSetor FOREIGN KEY (fkSetor) REFERENCES setor (idSetor)
);

INSERT INTO corredor (fkSetor) VALUES
(1), (2), (3), (4), (5), (1), (2), (3);

CREATE TABLE sensor (
    idSensor INT PRIMARY KEY AUTO_INCREMENT,
    numeroSerie VARCHAR(45),
    statusOperacional VARCHAR(15),
    dataInstalacao DATE,
    ultimaManutencao DATE,
    fkCorredor INT,
    CONSTRAINT chfkCorredor FOREIGN KEY (fkCorredor) REFERENCES corredor (idCorredor)
);

INSERT INTO sensor (numeroSerie, statusOperacional, dataInstalacao, ultimaManutencao, fkCorredor) VALUES
('FLUX-1001', 'Ativo', '2025-01-10', '2026-01-10', 1),
('FLUX-1002', 'Ativo', '2025-02-15', '2026-02-15', 2),
('FLUX-1003', 'Inativo', '2024-08-20', '2025-08-20', 3),
('FLUX-1004', 'Ativo', '2025-03-05', '2026-03-05', 4),
('FLUX-1005', 'Ativo', '2025-04-15', '2026-03-05', 5),
('FLUX-1006', 'Ativo', '2025-05-18', '2026-03-05', 6),
('FLUX-1007', 'Ativo', '2025-06-26', '2026-03-05', 7),
('FLUX-1008', 'Ativo', '2025-07-30', '2026-03-05', 8);

CREATE TABLE registroSensor (
    idRegistroSensor INT PRIMARY KEY AUTO_INCREMENT,
    leitura TINYINT,
    dataLeitura DATETIME DEFAULT current_timestamp,
    fkSensor INT,
    CONSTRAINT chfkSensor FOREIGN KEY (fkSensor) REFERENCES sensor (idSensor),
    CONSTRAINT chfkLeitura CHECK (leitura IN (0, 1)) -- CORREÇÃO: Removido as aspas simples, pois TINYINT é número
);

INSERT INTO registroSensor (leitura, dataLeitura, fkSensor) VALUES  
-- Dia 10/05/2026 (Domingo)
(1, '2026-05-17 08:12:34', 1),
(1, '2026-05-17 09:45:12', 2),
(1, '2026-05-17 11:20:59', 3),
(1, '2026-05-17 14:05:22', 4),
(1, '2026-05-17 15:30:15', 5),
(1, '2026-05-17 17:18:44', 6),
(1, '2026-05-17 19:40:01', 7),
(1, '2026-05-17 21:11:13', 8),
(1, '2026-05-17 22:03:50', 1),
-- Dia 11/05/2026 (Segunda-feira)
(1, '2026-05-18 07:33:21', 2),
(1, '2026-05-18 08:50:11', 3),
(1, '2026-05-18 10:15:43', 4),
(1, '2026-05-18 12:00:27', 5),
(1, '2026-05-18 14:22:19', 6),
(1, '2026-05-18 16:09:55', 7),
(1, '2026-05-18 18:55:04', 8),
(1, '2026-05-18 20:34:12', 1),
(1, '2026-05-18 22:45:30', 2),
-- Dia 12/05/2026 (Terça-feira)
(1, '2026-05-19 06:15:22', 3),
(1, '2026-05-19 08:44:11', 4),
(1, '2026-05-19 09:30:00', 5),
(1, '2026-05-19 11:12:45', 6),
(1, '2026-05-19 13:55:18', 7),
(1, '2026-05-19 15:20:33', 8),
(1, '2026-05-19 17:05:12', 1),
(1, '2026-05-19 19:42:59', 2),
(1, '2026-05-19 21:18:24', 3),
(1, '2026-05-19 23:50:01', 4),
-- Dia 13/05/2026 (Quarta-feira)
(1, '2026-05-20 07:10:15', 5),
(1, '2026-05-20 09:25:40', 6),
(1, '2026-05-20 11:40:12', 7),
(1, '2026-05-20 14:15:55', 8),
(1, '2026-05-20 16:33:21', 1),
(1, '2026-05-20 18:11:04', 2),
(1, '2026-05-20 20:45:50', 3),
(1, '2026-05-20 22:22:13', 4),
-- Dia 14/05/2026 (Quinta-feira)
(1, '2026-05-21 06:45:30', 5),
(1, '2026-05-21 08:12:19', 6),
(1, '2026-05-21 10:55:02', 7),
(1, '2026-05-21 13:20:44', 8),
(1, '2026-05-21 15:14:12', 1),
(1, '2026-05-21 17:40:59', 2),
(1, '2026-05-21 19:02:33', 3),
(1, '2026-05-21 21:55:11', 4),
(1, '2026-05-21 23:18:00', 5),
-- Dia 15/05/2026 (Sexta-feira)
(1, '2026-05-22 07:05:12', 6),
(1, '2026-05-22 09:14:55', 7),
(1, '2026-05-22 11:30:22', 8),
(1, '2026-05-22 14:45:01', 1),
(1, '2026-05-22 16:12:34', 2),
(1, '2026-05-22 18:22:19', 3),
(1, '2026-05-22 20:05:50', 4),
(1, '2026-05-22 22:40:11', 5),
-- Dia 16/05/2026 (Sábado)
(1, '2026-05-23 08:33:44', 6),
(1, '2026-05-23 10:12:05', 7),
(1, '2026-05-23 12:55:27', 8),
(1, '2026-05-23 14:18:12', 1),
(1, '2026-05-23 16:40:33', 2),
(1, '2026-05-23 19:11:59', 3),
(1, '2026-05-23 21:05:04', 4),
(1, '2026-05-23 23:45:22', 5),
-- Dia 17/05/2026 (Domingo)
(1, '2026-05-24 07:50:15', 6),
(1, '2026-05-24 09:22:40', 7),
(1, '2026-05-24 11:05:11', 8),
(1, '2026-05-24 13:44:30', 1),
(1, '2026-05-24 15:15:55', 2),
(1, '2026-05-24 17:30:12', 3),
(1, '2026-05-24 19:59:44', 4),
(1, '2026-05-24 22:12:01', 5),
-- Dia 18/05/2026 (Segunda-feira)
(1, '2026-05-25 06:12:55', 6),
(1, '2026-05-25 08:40:22', 7),
(1, '2026-05-25 10:15:04', 8),
(1, '2026-05-25 13:22:19', 1),
(1, '2026-05-25 15:50:33', 2),
(1, '2026-05-25 17:11:12', 3),
(1, '2026-05-25 19:45:59', 4),
(1, '2026-05-25 21:30:00', 5),
(1, '2026-05-25 23:05:44', 6),
-- Dia 19/05/2026 (Terça-feira)
(1, '2026-05-25 07:22:15', 7),
(1, '2026-05-25 09:05:30', 8),
(1, '2026-05-25 11:40:12', 1),
(1, '2026-05-25 14:15:44', 2),
(1, '2026-05-25 16:55:01', 3),
(1, '2026-05-25 18:33:27', 4),
(1, '2026-05-25 20:12:19', 5),
(1, '2026-05-25 22:45:50', 6),
-- Dia 20/05/2026 (Quarta-feira)
(1, '2026-05-26 06:30:12', 7),
(1, '2026-05-26 08:15:44', 8),
(1, '2026-05-26 09:55:22', 1),
(1, '2026-05-26 11:12:05', 2),
(1, '2026-05-26 13:40:33', 3),
(1, '2026-05-26 14:55:19', 4),
(1, '2026-05-26 15:22:01', 5),
(1, '2026-05-26 16:11:44', 6),
(1, '2026-05-26 17:05:59', 7),
(1, '2026-05-26 17:35:12', 8),
-- Dia 21/05/2026 (Quinta-feira)
(1, '2026-05-21 07:12:34', 1),
(1, '2026-05-21 09:45:12', 2),
(1, '2026-05-21 11:20:59', 3),
(1, '2026-05-21 14:05:22', 4),
(1, '2026-05-21 16:30:15', 5),
(1, '2026-05-21 18:18:44', 6),
(1, '2026-05-21 20:40:01', 7),
(1, '2026-05-21 22:11:13', 8),
-- Dia 22/05/2026 (Sexta-feira)
(1, '2026-05-22 06:45:30', 1),
(1, '2026-05-22 08:33:21', 2),
(1, '2026-05-22 10:50:11', 3),
(1, '2026-05-22 13:15:43', 4),
(1, '2026-05-22 15:00:27', 5),
(1, '2026-05-22 17:22:19', 6),
(1, '2026-05-22 19:09:55', 7),
(1, '2026-05-22 21:55:04', 8),
-- Dia 23/05/2026 (Sábado)
(1, '2026-05-23 07:15:22', 1),
(1, '2026-05-23 09:44:11', 2),
(1, '2026-05-23 11:30:00', 3),
(1, '2026-05-23 13:12:45', 4),
(1, '2026-05-23 15:55:18', 5),
(1, '2026-05-23 17:20:33', 6),
(1, '2026-05-23 19:05:12', 7),
(1, '2026-05-23 21:42:59', 8),
-- Dia 24/05/2026 (Domingo)
(1, '2026-05-24 08:10:15', 1),
(1, '2026-05-24 10:25:40', 2),
(1, '2026-05-24 12:40:12', 3),
(1, '2026-05-24 14:15:55', 4),
(1, '2026-05-24 16:33:21', 5),
(1, '2026-05-24 19:11:04', 6),
(1, '2026-05-24 21:45:50', 7),
(1, '2026-05-24 23:22:13', 8),
-- Dia 25/05/2026 (Segunda-feira)
(1, '2026-05-25 06:45:30', 1),
(1, '2026-05-25 08:12:19', 2),
(1, '2026-05-25 10:55:02', 3),
(1, '2026-05-25 13:20:44', 4),
(1, '2026-05-25 15:14:12', 5),
(1, '2026-05-25 17:40:59', 6),
(1, '2026-05-25 19:02:33', 7),
(1, '2026-05-25 21:55:11', 8),
-- Dia 26/05/2026 (Terça-feira)
(1, '2026-05-26 07:05:12', 1),
(1, '2026-05-26 09:14:55', 2),
(1, '2026-05-26 11:30:22', 3),
(1, '2026-05-26 14:45:01', 4),
(1, '2026-05-26 16:12:34', 5),
(1, '2026-05-26 18:22:19', 6),
(1, '2026-05-26 20:05:50', 7),
(1, '2026-05-26 22:40:11', 8),
-- Dia 27/05/2026 (Quarta-feira)
(1, '2026-05-27 08:33:44', 1),
(1, '2026-05-27 10:12:05', 2),
(1, '2026-05-27 12:55:27', 3),
(1, '2026-05-27 14:18:12', 4),
(1, '2026-05-27 16:40:33', 5),
(1, '2026-05-27 19:11:59', 6),
(1, '2026-05-27 21:05:04', 7),
(1, '2026-05-27 23:45:22', 8),
-- Dia 28/06/2026
(1, '2026-05-28 08:20:00', 1),
(1, '2026-05-28 10:15:00', 2),
(1, '2026-05-28 11:45:00', 3),
(1, '2026-05-28 13:30:00', 1),
(1, '2026-05-28 15:10:00', 2),
(1, '2026-05-28 17:40:00', 3),
(1, '2026-05-28 19:25:00', 1),

-- Dia 29/06/2026
(1, '2026-05-29 07:45:00', 2),
(1, '2026-05-29 09:12:00', 3),
(1, '2026-05-29 11:05:00', 1),
(1, '2026-05-29 13:18:00', 2),
(1, '2026-05-29 14:50:00', 3),
(1, '2026-05-29 16:35:00', 1),
(1, '2026-05-29 18:10:00', 2),

-- Dia 30/06/2026
(1, '2026-05-30 08:05:00', 3),
(1, '2026-05-30 09:40:00', 1),
(1, '2026-05-30 11:15:00', 2),
(1, '2026-05-30 13:02:00', 3),
(1, '2026-05-30 14:55:00', 1),
(1, '2026-05-30 16:20:00', 2),
(1, '2026-05-30 18:45:00', 3),

(1, '2026-05-30 08:05:00', 4),
(1, '2026-05-30 09:40:00', 4),
(1, '2026-05-30 11:15:00', 4),
(1, '2026-05-30 13:02:00', 4),
(1, '2026-05-30 14:55:00', 4),
(1, '2026-05-30 16:20:00', 4),
(1, '2026-05-30 18:45:00', 4),

(1, '2026-05-30 08:05:00', 5),
(1, '2026-05-30 09:40:00', 5),
(1, '2026-05-30 11:15:00', 5),
(1, '2026-05-30 13:02:00', 5),
(1, '2026-05-30 14:55:00', 5),
(1, '2026-05-30 16:20:00', 5),
(1, '2026-05-30 18:45:00', 5),

-- Dia 31/05/2026
(1, '2026-05-31 08:05:00', 3),
(1, '2026-05-31 09:40:00', 1),
(1, '2026-05-31 11:15:00', 2),
(1, '2026-05-31 13:02:00', 3),
(1, '2026-05-31 14:55:00', 1),
(1, '2026-05-31 16:20:00', 2),
(1, '2026-05-31 18:45:00', 3),

(1, '2026-05-31 08:05:00', 4),
(1, '2026-05-31 09:40:00', 4),
(1, '2026-05-31 11:15:00', 4),
(1, '2026-05-31 13:02:00', 4),
(1, '2026-05-31 14:55:00', 4),
(1, '2026-05-31 16:20:00', 4),
(1, '2026-05-31 18:45:00', 4),

(1, '2026-05-31 08:05:00', 5),
(1, '2026-05-31 09:40:00', 5),
(1, '2026-05-31 11:15:00', 5),
(1, '2026-05-31 13:02:00', 5),
(1, '2026-05-31 14:55:00', 5),
(1, '2026-05-31 16:20:00', 5),
(1, '2026-05-31 18:45:00', 5),
-- Dia 01/06/2026
(1, '2026-06-01 07:30:00', 1),
(1, '2026-06-01 09:10:00', 2),
(1, '2026-06-01 11:22:00', 3),
(1, '2026-06-01 13:40:00', 1),
(1, '2026-06-01 15:15:00', 2),
(1, '2026-06-01 17:05:00', 3),
(1, '2026-06-01 19:30:00', 1),

(1, '2026-06-01 07:30:00', 4),
(1, '2026-06-01 09:10:00', 4),
(1, '2026-06-01 11:22:00', 4),
(1, '2026-06-01 13:40:00', 4),
(1, '2026-06-01 15:15:00', 4),
(1, '2026-06-01 17:05:00', 4),
(1, '2026-06-01 19:30:00', 4),

(1, '2026-06-01 07:30:00', 5),
(1, '2026-06-01 09:10:00', 5),
(1, '2026-06-01 11:22:00', 5),
(1, '2026-06-01 13:40:00', 5),
(1, '2026-06-01 15:15:00', 5),
(1, '2026-06-01 17:05:00', 5),
(1, '2026-06-01 19:30:00', 5),

-- Dia 02/06/2026
(1, '2026-06-02 08:12:00', 2),
(1, '2026-06-02 09:55:00', 3),
(1, '2026-06-02 11:30:00', 1),
(1, '2026-06-02 13:05:00', 2),
(1, '2026-06-02 14:45:00', 3),
(1, '2026-06-02 16:10:00', 1),
(1, '2026-06-02 18:22:00', 2),

(1, '2026-06-02 08:12:00', 4),
(1, '2026-06-02 09:55:00', 4),
(1, '2026-06-02 11:30:00', 4),
(1, '2026-06-02 13:05:00', 4),
(1, '2026-06-02 14:45:00', 4),
(1, '2026-06-02 16:10:00', 4),
(1, '2026-06-02 18:22:00', 4),

(1, '2026-06-02 08:12:00', 5),
(1, '2026-06-02 09:55:00', 5),
(1, '2026-06-02 11:30:00', 5),
(1, '2026-06-02 13:05:00', 5),
(1, '2026-06-02 14:45:00', 5),
(1, '2026-06-02 16:10:00', 5),
(1, '2026-06-02 18:22:00', 5),

-- Dia 03/06/2026
(1, '2026-06-03 07:50:00', 3),
(1, '2026-06-03 09:25:00', 1),
(1, '2026-06-03 11:08:00', 2),
(1, '2026-06-03 13:35:00', 3),
(1, '2026-06-03 15:20:00', 1),
(1, '2026-06-03 17:12:00', 2),
(1, '2026-06-03 19:01:00', 3),

(1, '2026-06-03 07:50:00', 4),
(1, '2026-06-03 09:25:00', 4),
(1, '2026-06-03 11:08:00', 4),
(1, '2026-06-03 13:35:00', 4),
(1, '2026-06-03 15:20:00', 4),
(1, '2026-06-03 17:12:00', 4),
(1, '2026-06-03 19:01:00', 4),

(1, '2026-06-03 07:50:00', 5),
(1, '2026-06-03 09:25:00', 5),
(1, '2026-06-03 11:08:00', 5),
(1, '2026-06-03 13:35:00', 5),
(1, '2026-06-03 15:20:00', 5),
(1, '2026-06-03 17:12:00', 5),
(1, '2026-06-03 19:01:00', 5),

-- Dia 04/06/2026
(1, '2026-06-04 08:35:00', 1),
(1, '2026-06-04 10:02:00', 2),
(1, '2026-06-04 11:40:00', 3),
(1, '2026-06-04 13:15:00', 1),
(1, '2026-06-04 15:50:00', 2),
(1, '2026-06-04 17:22:00', 3),
(1, '2026-06-04 19:40:00', 1),


(1, '2026-06-04 08:35:00', 4),
(1, '2026-06-04 10:02:00', 4),
(1, '2026-06-04 11:40:00', 4),
(1, '2026-06-04 13:15:00', 4),
(1, '2026-06-04 15:50:00', 4),
(1, '2026-06-04 17:22:00', 4),
(1, '2026-06-04 19:40:00', 4),


(1, '2026-06-04 08:35:00', 5),
(1, '2026-06-04 10:02:00', 5),
(1, '2026-06-04 11:40:00', 5),
(1, '2026-06-04 13:15:00', 5),
(1, '2026-06-04 15:50:00', 5),
(1, '2026-06-04 17:22:00', 5),
(1, '2026-06-04 19:40:00', 5),

-- Dia 05/06/2026
(1, '2026-06-05 07:55:00', 2),
(1, '2026-06-05 09:30:00', 3),
(1, '2026-06-05 11:12:00', 1),
(1, '2026-06-05 13:05:00', 2),
(1, '2026-06-05 15:18:00', 3),
(1, '2026-06-05 16:44:00', 1),
(1, '2026-06-05 18:50:00', 2),

(1, '2026-06-05 07:55:00', 4),
(1, '2026-06-05 09:30:00', 4),
(1, '2026-06-05 11:12:00', 4),
(1, '2026-06-05 13:05:00', 4),
(1, '2026-06-05 15:18:00', 4),
(1, '2026-06-05 16:44:00', 4),
(1, '2026-06-05 18:50:00', 4),


(1, '2026-06-05 07:55:00', 5),
(1, '2026-06-05 09:30:00', 5),
(1, '2026-06-05 11:12:00', 5),
(1, '2026-06-05 13:05:00', 5),
(1, '2026-06-05 15:18:00', 5),
(1, '2026-06-05 16:44:00', 5),
(1, '2026-06-05 18:50:00', 5),


-- Dia 06/06/2026
(1, '2026-06-06 08:10:00', 3),
(1, '2026-06-06 09:45:00', 1),
(1, '2026-06-06 11:20:00', 2),
(1, '2026-06-06 13:50:00', 3),
(1, '2026-06-06 15:05:00', 1),
(1, '2026-06-06 17:35:00', 2),
(1, '2026-06-06 19:15:00', 3),

(1, '2026-06-06 08:10:00', 4),
(1, '2026-06-06 09:45:00', 4),
(1, '2026-06-06 11:20:00', 4),
(1, '2026-06-06 13:50:00', 4),
(1, '2026-06-06 15:05:00', 4),
(1, '2026-06-06 17:35:00', 4),
(1, '2026-06-06 19:15:00', 4),

(1, '2026-06-06 08:10:00', 5),
(1, '2026-06-06 09:45:00', 5),
(1, '2026-06-06 11:20:00', 5),
(1, '2026-06-06 13:50:00', 5),
(1, '2026-06-06 15:05:00', 5),
(1, '2026-06-06 17:35:00', 5),
(1, '2026-06-06 19:15:00', 5),

-- Dia 07/06/2026
(1, '2026-06-07 07:40:00', 1),
(1, '2026-06-07 09:15:00', 2),
(1, '2026-06-07 11:02:00', 3),
(1, '2026-06-07 13:44:00', 1),
(1, '2026-06-07 15:25:00', 2),
(1, '2026-06-07 17:50:00', 3),
(1, '2026-06-07 19:33:00', 1),

(1, '2026-06-07 07:40:00', 4),
(1, '2026-06-07 09:15:00', 4),
(1, '2026-06-07 11:02:00', 4),
(1, '2026-06-07 13:44:00', 4),
(1, '2026-06-07 15:25:00', 4),
(1, '2026-06-07 17:50:00', 4),
(1, '2026-06-07 19:33:00', 4),


(1, '2026-06-07 07:40:00', 5),
(1, '2026-06-07 09:15:00', 5),
(1, '2026-06-07 11:02:00', 5),
(1, '2026-06-07 13:44:00', 5),
(1, '2026-06-07 15:25:00', 5),
(1, '2026-06-07 17:50:00', 5),
(1, '2026-06-07 19:33:00', 5),

-- Dia 08/06/2026
(1, '2026-06-08 06:15:00', 2),
(1, '2026-06-08 07:30:00', 3),
(1, '2026-06-08 08:45:00', 1),
(1, '2026-06-08 09:20:00', 2),
(1, '2026-06-08 10:10:00', 3),
(1, '2026-06-08 11:15:00', 1),
(1, '2026-06-08 11:55:00', 2),


(1, '2026-06-08 06:15:00', 4),
(1, '2026-06-08 07:30:00', 4),
(1, '2026-06-08 08:45:00', 4),
(1, '2026-06-08 09:20:00', 4),
(1, '2026-06-08 10:10:00', 4),
(1, '2026-06-08 11:15:00', 4),
(1, '2026-06-08 11:55:00', 4),


(1, '2026-06-08 06:15:00', 5),
(1, '2026-06-08 07:30:00', 5),
(1, '2026-06-08 08:45:00', 5),
(1, '2026-06-08 09:20:00', 5),
(1, '2026-06-08 10:10:00', 5),
(1, '2026-06-08 11:15:00', 5),
(1, '2026-06-08 11:55:00', 5);

SELECT DATE_FORMAT(dataLeitura, '%d/%m/%y %H:%i:%s') AS dataLeitura 
FROM registroSensor 
WHERE dataLeitura < NOW() AND leitura = 1
ORDER BY dataLeitura DESC 
LIMIT 1;

-- Contar a quantidade de ativações por setor na última semana cheia (dom-sab)
SELECT st.nomeSetor, 
    COUNT(CASE WHEN rs.leitura = 1 THEN 1 END) AS quantidade
FROM setor st
JOIN corredor c ON st.idSetor = c.fkSetor
JOIN sensor ss  ON c.idCorredor = ss.fkCorredor
JOIN registroSensor rs ON ss.idSensor = rs.fkSensor
WHERE ss.idSensor
    AND rs.dataLeitura >= STR_TO_DATE(CONCAT(YEARWEEK(NOW() - INTERVAL 1 WEEK, 0), ' Sunday'), '%X%V %W')
    AND rs.dataLeitura <= STR_TO_DATE(CONCAT(YEARWEEK(NOW() - INTERVAL 1 WEEK, 0), ' Saturday'), '%X%V %W')
GROUP BY st.nomeSetor
LIMIT 0, 1000;

-- Contar a quantidade de ativações por setor do último domingo até hoje
SELECT st.nomeSetor, 
    COUNT(CASE WHEN rs.leitura = 1 THEN 1 END) AS quantidade
FROM setor st
JOIN corredor c ON st.idSetor = c.fkSetor
JOIN sensor ss  ON c.idCorredor = ss.fkCorredor
JOIN registroSensor rs ON ss.idSensor = rs.fkSensor
WHERE ss.idSensor
    AND rs.dataLeitura >= STR_TO_DATE(DATE_SUB(CURDATE(), INTERVAL WEEKDAY(NOW()) + 1 DAY), '%Y-%m-%d')
    AND rs.dataLeitura <= NOW()
GROUP BY st.nomeSetor
LIMIT 0, 1000;

-- META DIARIA KPI 2 e 3
CREATE VIEW view_buscarMetaDiaria AS
SELECT SUM(meta) AS 'META DIARIA'
FROM setor
GROUP BY meta;

-- Fazer Select soma de registros de todos os setores juntos do dia da consulta apenas --
SELECT COUNT(registroSensor.idRegistroSensor) AS Quant_Registros_Dia FROM registroSensor
WHERE dataLeitura = CURDATE();


-- SELECT DA SOMA DOS REGISTROS ATE A DATA DA CONSULTA DA LOJA
CREATE VIEW view_buscarAtivacoesPorSetorAteODiaDaConsulta AS
SELECT 
		COUNT(CASE WHEN rs.leitura = 1 THEN 1 END) AS quantidade
FROM setor st
JOIN corredor c ON st.idSetor = c.fkSetor
JOIN sensor ss  ON c.idCorredor = ss.fkCorredor
JOIN registroSensor rs ON ss.idSensor = rs.fkSensor
WHERE ss.idSensor 
    AND rs.dataLeitura >= STR_TO_DATE(DATE_SUB(CURDATE(), INTERVAL WEEKDAY(NOW()) + 1 DAY), '%Y-%m-%d')
    AND rs.dataLeitura <= NOW()
GROUP BY rs.leitura
LIMIT 1000;

-- SELECT DA SOMA DOS REGISTROS DA ULTIMA SEMANA COMPLETA
CREATE VIEW view_buscarAtivacoesPorSetorDaSemanaAnterior AS
SELECT
    COUNT(CASE WHEN rs.leitura = 1 THEN 1 END) AS quantidade
FROM setor st
JOIN corredor c ON st.idSetor = c.fkSetor
JOIN sensor ss  ON c.idCorredor = ss.fkCorredor
JOIN registroSensor rs ON ss.idSensor = rs.fkSensor
WHERE ss.idSensor
    AND rs.dataLeitura >= STR_TO_DATE(CONCAT(YEARWEEK(NOW() - INTERVAL 1 WEEK, 0), ' Sunday'), '%X%V %W')
    AND rs.dataLeitura <= STR_TO_DATE(CONCAT(YEARWEEK(NOW() - INTERVAL 1 WEEK, 0), ' Saturday'), '%X%V %W')
GROUP BY rs.leitura
LIMIT 1000;

-- Fluxo por hora (gráfico de linha)
SELECT 
    st.nomeSetor,
    HOUR(rs.dataLeitura) AS hora,
    COUNT(CASE WHEN rs.leitura = 1 THEN 1 END) AS quantidade
FROM setor st
JOIN corredor       c   ON st.idSetor   = c.fkSetor
JOIN sensor         ss  ON c.idCorredor = ss.fkCorredor
JOIN registroSensor rs  ON ss.idSensor  = rs.fkSensor
WHERE st.fkloja
    AND HOUR(rs.dataLeitura) BETWEEN 8 AND 20
GROUP BY st.nomeSetor, HOUR(rs.dataLeitura);

/* 
COMO FICARIA NO MODELS
SELECT 
    st.nomeSetor,
    HOUR(rs.dataLeitura) AS hora,
    COUNT(CASE WHEN rs.leitura = 1 THEN 1 END) AS quantidade
FROM setor st
JOIN corredor       c   ON st.idSetor   = c.fkSetor
JOIN sensor         ss  ON c.idCorredor = ss.fkCorredor
JOIN registroSensor rs  ON ss.idSensor  = rs.fkSensor
WHERE st.fkloja = ${idLoja}
    AND HOUR(rs.dataLeitura) BETWEEN 8 AND 20
    ${FILTRO DA COMBOBOX}
GROUP BY st.nomeSetor, HOUR(rs.dataLeitura);
*/

-- -------------------------------------------------------------------------

-- Fluxo por turno (gráfico de pizza)
SELECT 
    st.nomeSetor,
    CASE 
        WHEN HOUR(rs.dataLeitura) >= 8  AND HOUR(rs.dataLeitura) < 12 THEN '08:00-12:00'
        WHEN HOUR(rs.dataLeitura) >= 12 AND HOUR(rs.dataLeitura) < 16 THEN '12:00-16:00'
        WHEN HOUR(rs.dataLeitura) >= 16 AND HOUR(rs.dataLeitura) < 20 THEN '16:00-20:00'
    END AS turno,
    COUNT(CASE WHEN rs.leitura = 1 THEN 1 END) AS quantidade
FROM setor st
JOIN corredor       c   ON st.idSetor   = c.fkSetor
JOIN sensor         ss  ON c.idCorredor = ss.fkCorredor
JOIN registroSensor rs  ON ss.idSensor  = rs.fkSensor
WHERE st.fkloja
    AND HOUR(rs.dataLeitura) BETWEEN 8 AND 19
GROUP BY st.nomeSetor, turno;

/* 
COMO FICARIA NO MODELS
SELECT 
    st.nomeSetor,
    CASE 
        WHEN HOUR(rs.dataLeitura) >= 8  AND HOUR(rs.dataLeitura) < 12 THEN '08:00-12:00'
        WHEN HOUR(rs.dataLeitura) >= 12 AND HOUR(rs.dataLeitura) < 16 THEN '12:00-16:00'
        WHEN HOUR(rs.dataLeitura) >= 16 AND HOUR(rs.dataLeitura) < 20 THEN '16:00-20:00'
    END AS turno,
    COUNT(CASE WHEN rs.leitura = 1 THEN 1 END) AS quantidade
FROM setor st
JOIN corredor       c   ON st.idSetor   = c.fkSetor
JOIN sensor         ss  ON c.idCorredor = ss.fkCorredor
JOIN registroSensor rs  ON ss.idSensor  = rs.fkSensor
WHERE st.fkloja = ${idLoja}
    AND HOUR(rs.dataLeitura) BETWEEN 8 AND 19
    ${FILTRO DA COMBOBOX}
GROUP BY st.nomeSetor, turno;
*/

-- -------------------------------------------------------------------------

-- Fluxo por dia da semana (gráfico polar)
SELECT 
    st.nomeSetor,
    DAYOFWEEK(rs.dataLeitura) AS numeroDia,
    CASE DAYOFWEEK(rs.dataLeitura)
        WHEN 1 THEN 'Domingo'
        WHEN 2 THEN 'Segunda-feira'
        WHEN 3 THEN 'Terça-feira'
        WHEN 4 THEN 'Quarta-feira'
        WHEN 5 THEN 'Quinta-feira'
        WHEN 6 THEN 'Sexta-feira'
        WHEN 7 THEN 'Sábado'
    END AS diaSemana,
    COUNT(CASE WHEN rs.leitura = 1 THEN 1 END) AS quantidade
FROM setor st
JOIN corredor       c   ON st.idSetor   = c.fkSetor
JOIN sensor         ss  ON c.idCorredor = ss.fkCorredor
JOIN registroSensor rs  ON ss.idSensor  = rs.fkSensor
WHERE st.fkloja
    AND rs.dataLeitura >= DATE_SUB(CURDATE(), INTERVAL DAYOFWEEK(NOW()) - 1 DAY)
    AND rs.dataLeitura <= NOW()
GROUP BY st.nomeSetor, DAYOFWEEK(rs.dataLeitura), diaSemana;

/* 
SELECT 
    st.nomeSetor,
    DAYOFWEEK(rs.dataLeitura) AS numeroDia,
    CASE DAYOFWEEK(rs.dataLeitura)
        WHEN 1 THEN 'Domingo'
        WHEN 2 THEN 'Segunda-feira'
        WHEN 3 THEN 'Terça-feira'
        WHEN 4 THEN 'Quarta-feira'
        WHEN 5 THEN 'Quinta-feira'
        WHEN 6 THEN 'Sexta-feira'
        WHEN 7 THEN 'Sábado'
    END AS diaSemana,
    COUNT(CASE WHEN rs.leitura = 1 THEN 1 END) AS quantidade
FROM setor st
JOIN corredor       c   ON st.idSetor   = c.fkSetor
JOIN sensor         ss  ON c.idCorredor = ss.fkCorredor
JOIN registroSensor rs  ON ss.idSensor  = rs.fkSensor
WHERE st.fkloja = ${idLoja}
    AND rs.dataLeitura >= DATE_SUB(CURDATE(), INTERVAL DAYOFWEEK(NOW()) - 1 DAY)
    AND rs.dataLeitura <= NOW()
    ${FILTRO DA COMBOBOX}
GROUP BY st.nomeSetor, DAYOFWEEK(rs.dataLeitura), diaSemana
*/

-- -------------------------------------------------------------------------


--  Fluxo por setor / zonas quentes e frias (gráfico de barras)
CREATE VIEW total_ativacoes AS
SELECT COUNT(rs.idRegistroSensor) AS totalRegistros FROM registroSensor rs
WHERE rs.dataLeitura >= NOW();

select * from total_ativacoes;

SELECT 
    st.nomeSetor,
    ROUND(
        COUNT(CASE WHEN rs.leitura = 1 THEN 1 END) * 100.0
        / (select * from total_ativacoes),
        2
    ) AS percentualAtivacao
FROM setor st
JOIN corredor       c   ON st.idSetor   = c.fkSetor
JOIN sensor         ss  ON c.idCorredor = ss.fkCorredor
JOIN registroSensor rs  ON ss.idSensor  = rs.fkSensor
WHERE st.fkloja AND rs.dataLeitura >= NOW()
GROUP BY st.idSetor, st.nomeSetor;

/* 
COMO FICARIA NO MODELS
SELECT 
    st.nomeSetor,
    COUNT(rs.idRegistroSensor) AS totalRegistros,
    COUNT(CASE WHEN rs.leitura = 1 THEN 1 END) AS totalAtivacoes,
    ROUND(
        COUNT(CASE WHEN rs.leitura = 1 THEN 1 END) * 100.0
        / NULLIF(COUNT(rs.idRegistroSensor), 0),
        2
    ) AS percentualAtivacao
FROM setor st
JOIN corredor       c   ON st.idSetor   = c.fkSetor
JOIN sensor         ss  ON c.idCorredor = ss.fkCorredor
JOIN registroSensor rs  ON ss.idSensor  = rs.fkSensor
WHERE st.fkloja = ${idLoja}
GROUP BY st.idSetor, st.nomeSetor;
*/
CREATE VIEW buscarSomaDosRegistrosDosSetoresNoDia AS
SELECT 
        COUNT(registroSensor.idRegistroSensor) AS Quant_Registros_Dia 
        FROM registroSensor
        WHERE DAY(dataLeitura) = DAY(current_date()) AND MONTH(dataLeitura) = MONTH(current_date());
    

SELECT * FROM view_buscarAtivacoesPorSetorDaSemanaAnterior;
SELECT * FROM view_buscarAtivacoesPorSetorAteODiaDaConsulta;
SELECT * FROM buscarSomaDosRegistrosDosSetoresNoDia;
SELECT * FROM view_buscarMetaDiaria;

