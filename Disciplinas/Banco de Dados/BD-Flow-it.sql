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
    CONSTRAINT chfkCargo CHECK (cargo IN ('Gerente', 'Consultor'))
);

INSERT INTO permissao (cargo) VALUES
('Gerente'),
('Consultor');

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
('Utensilio', 100, 2),
('Eletrônico', 100, 2),
('Higiene', 100, 3);

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
('FLUX-1004', 'Ativo', '2025-03-05', '2026-03-05', 4);

CREATE TABLE registroSensor (
    idRegistroSensor INT PRIMARY KEY AUTO_INCREMENT,
    leitura TINYINT,
    dataLeitura DATETIME,
    fkSensor INT,
    CONSTRAINT chfkSensor FOREIGN KEY (fkSensor) REFERENCES sensor (idSensor),
    CONSTRAINT chfkLeitura CHECK (leitura IN (0, 1)) -- CORREÇÃO: Removido as aspas simples, pois TINYINT é número
);

INSERT INTO registroSensor (leitura, dataLeitura, fkSensor) VALUES 
-- Dia 10/05/2026 (Domingo)
(0, '2026-05-10 08:12:34', 1),
(1, '2026-05-10 09:45:12', 2),
(0, '2026-05-10 11:20:59', 3),
(1, '2026-05-10 14:05:22', 4),
(1, '2026-05-10 15:30:15', 1),
(1, '2026-05-10 17:18:44', 2),
(0, '2026-05-10 19:40:01', 3),
(1, '2026-05-10 21:11:13', 4),
(1, '2026-05-10 22:03:50', 1),
-- Dia 11/05/2026 (Segunda-feira)
(1, '2026-05-11 07:33:21', 2),
(1, '2026-05-11 08:50:11', 3),
(0, '2026-05-11 10:15:43', 4),
(0, '2026-05-11 12:00:27', 1),
(1, '2026-05-11 14:22:19', 2),
(0, '2026-05-11 16:09:55', 3),
(0, '2026-05-11 18:55:04', 4),
(1, '2026-05-11 20:34:12', 1),
(1, '2026-05-11 22:45:30', 2),
-- Dia 12/05/2026 (Terça-feira)
(0, '2026-05-12 06:15:22', 3),
(0, '2026-05-12 08:44:11', 4),
(1, '2026-05-12 09:30:00', 1),
(0, '2026-05-12 11:12:45', 2),
(1, '2026-05-12 13:55:18', 3),
(1, '2026-05-12 15:20:33', 4),
(0, '2026-05-12 17:05:12', 1),
(1, '2026-05-12 19:42:59', 2),
(1, '2026-05-12 21:18:24', 3),
(0, '2026-05-12 23:50:01', 4),
-- Dia 13/05/2026 (Quarta-feira)
(1, '2026-05-13 07:10:15', 1),
(1, '2026-05-13 09:25:40', 2),
(0, '2026-05-13 11:40:12', 3),
(0, '2026-05-13 14:15:55', 4),
(1, '2026-05-13 16:33:21', 1),
(0, '2026-05-13 18:11:04', 2),
(1, '2026-05-13 20:45:50', 3),
(1, '2026-05-13 22:22:13', 4),
-- Dia 14/05/2026 (Quinta-feira)
(0, '2026-05-14 06:45:30', 1),
(1, '2026-05-14 08:12:19', 2),
(1, '2026-05-14 10:55:02', 3),
(0, '2026-05-14 13:20:44', 4),
(1, '2026-05-14 15:14:12', 1),
(0, '2026-05-14 17:40:59', 2),
(1, '2026-05-14 19:02:33', 3),
(1, '2026-05-14 21:55:11', 4),
(0, '2026-05-14 23:18:00', 1),
-- Dia 15/05/2026 (Sexta-feira)
(1, '2026-05-15 07:05:12', 2),
(0, '2026-05-15 09:14:55', 3),
(1, '2026-05-15 11:30:22', 4),
(1, '2026-05-15 14:45:01', 1),
(0, '2026-05-15 16:12:34', 2),
(1, '2026-05-15 18:22:19', 3),
(0, '2026-05-15 20:05:50', 4),
(1, '2026-05-15 22:40:11', 1),
-- Dia 16/05/2026 (Sábado)
(1, '2026-05-16 08:33:44', 2),
(0, '2026-05-16 10:12:05', 3),
(1, '2026-05-16 12:55:27', 4),
(1, '2026-05-16 14:18:12', 1),
(0, '2026-05-16 16:40:33', 2),
(1, '2026-05-16 19:11:59', 3),
(0, '2026-05-16 21:05:04', 4),
(1, '2026-05-16 23:45:22', 1),
-- Dia 17/05/2026 (Domingo)
(0, '2026-05-17 07:50:15', 2),
(1, '2026-05-17 09:22:40', 3),
(1, '2026-05-17 11:05:11', 4),
(0, '2026-05-17 13:44:30', 1),
(1, '2026-05-17 15:15:55', 2),
(0, '2026-05-17 17:30:12', 3),
(1, '2026-05-17 19:59:44', 4),
(1, '2026-05-17 22:12:01', 1),
-- Dia 18/05/2026 (Segunda-feira)
(0, '2026-05-18 06:12:55', 2),
(1, '2026-05-18 08:40:22', 3),
(0, '2026-05-18 10:15:04', 4),
(1, '2026-05-18 13:22:19', 1),
(1, '2026-05-18 15:50:33', 2),
(0, '2026-05-18 17:11:12', 3),
(1, '2026-05-18 19:45:59', 4),
(0, '2026-05-18 21:30:00', 1),
(1, '2026-05-18 23:05:44', 2),
-- Dia 19/05/2026 (Terça-feira)
(1, '2026-05-19 07:22:15', 3),
(0, '2026-05-19 09:05:30', 4),
(1, '2026-05-19 11:40:12', 1),
(0, '2026-05-19 14:15:44', 2),
(1, '2026-05-19 16:55:01', 3),
(1, '2026-05-19 18:33:27', 4),
(0, '2026-05-19 20:12:19', 1),
(1, '2026-05-19 22:45:50', 2),
-- Dia 20/05/2026 (Quarta-feira)
(0, '2026-05-20 06:30:12', 3),
(1, '2026-05-20 08:15:44', 4),
(1, '2026-05-20 09:55:22', 1),
(0, '2026-05-20 11:12:05', 2),
(1, '2026-05-20 13:40:33', 3),
(0, '2026-05-20 14:55:19', 4),
(1, '2026-05-20 15:22:01', 1),
(1, '2026-05-20 16:11:44', 2),
(0, '2026-05-20 17:05:59', 3),
(1, '2026-05-20 17:35:12', 4);

-- Contar a quantidade de ativações por setor na última semana cheia (dom-sab)
SELECT st.nomeSetor, 
       COUNT(CASE WHEN rs.leitura = 1 THEN 1 END) AS quantidade
FROM setor st
JOIN corredor c ON st.idSetor = c.fkSetor
JOIN sensor ss  ON c.idCorredor = ss.fkCorredor
JOIN registroSensor rs ON ss.idSensor = rs.fkSensor
WHERE ss.idSensor IN (1, 2, 3, 4) 
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
WHERE ss.idSensor IN (1, 2, 3, 4) 
  AND rs.dataLeitura >= STR_TO_DATE(DATE_SUB(CURDATE(), INTERVAL WEEKDAY(NOW()) + 1 DAY), '%Y-%m-%d')
  AND rs.dataLeitura <= NOW()
GROUP BY st.nomeSetor
LIMIT 0, 1000;

-- META DIARIA
SELECT SUM(meta) AS 'META DIARIA'
FROM setor
GROUP BY meta;

-- SELECT DA SOMA DOS REGISTROS ATE A DATA DA CONSULTA DA LOJA
SELECT 
		COUNT(CASE WHEN rs.leitura = 1 THEN 1 END) AS quantidade
FROM setor st
JOIN corredor c ON st.idSetor = c.fkSetor
JOIN sensor ss  ON c.idCorredor = ss.fkCorredor
JOIN registroSensor rs ON ss.idSensor = rs.fkSensor
WHERE ss.idSensor IN (1, 2, 3, 4) 
  AND rs.dataLeitura >= STR_TO_DATE(DATE_SUB(CURDATE(), INTERVAL WEEKDAY(NOW()) + 1 DAY), '%Y-%m-%d')
  AND rs.dataLeitura <= NOW()
GROUP BY rs.leitura
LIMIT 1000;

-- SELECT DA SOMA DOS REGISTROS DA ULTIMA SEMANA COMPLETA
SELECT
       COUNT(CASE WHEN rs.leitura = 1 THEN 1 END) AS quantidade
FROM setor st
JOIN corredor c ON st.idSetor = c.fkSetor
JOIN sensor ss  ON c.idCorredor = ss.fkCorredor
JOIN registroSensor rs ON ss.idSensor = rs.fkSensor
WHERE ss.idSensor IN (1, 2, 3, 4) 
  AND rs.dataLeitura >= STR_TO_DATE(CONCAT(YEARWEEK(NOW() - INTERVAL 1 WEEK, 0), ' Sunday'), '%X%V %W')
  AND rs.dataLeitura <= STR_TO_DATE(CONCAT(YEARWEEK(NOW() - INTERVAL 1 WEEK, 0), ' Saturday'), '%X%V %W')
GROUP BY rs.leitura
LIMIT 1000;