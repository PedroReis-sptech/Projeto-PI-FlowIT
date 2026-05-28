var database = require("../database/config");

// ====================================================================================================


function buscarDadosGraficoBarras(idLoja) {

  var instrucaoSql = `SELECT 
          st.nomeSetor,
          COUNT(rs.leitura) AS totalAtivacoes
        FROM setor st
        JOIN corredor       c   ON st.idSetor   = c.fkSetor
        JOIN sensor         ss  ON c.idCorredor = ss.fkCorredor
        JOIN registroSensor rs  ON ss.idSensor  = rs.fkSensor
        WHERE st.fkloja = ${idLoja}
        GROUP BY st.idSetor, st.nomeSetor;`;

  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}

// ====================================================================================================

function buscarDadosGraficoPizzaGeral() {
  var instrucaoSql = `SELECT 
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
GROUP BY turno;`;

  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}

// ====================================================================================================

function buscarDadosGraficoLinhaGeral() {
  var instrucaoSql = `SELECT 
    HOUR(rs.dataLeitura) AS hora,
    COUNT(CASE WHEN rs.leitura = 1 THEN 1 END) AS quantidade
FROM setor st
JOIN corredor       c   ON st.idSetor   = c.fkSetor
JOIN sensor         ss  ON c.idCorredor = ss.fkCorredor
JOIN registroSensor rs  ON ss.idSensor  = rs.fkSensor
WHERE st.fkloja
  AND HOUR(rs.dataLeitura) BETWEEN 8 AND 20
GROUP BY  HOUR(rs.dataLeitura);
`;

  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}

// ====================================================================================================


function buscarDadosGraficoRadarGeral() {
  var instrucaoSql = ``;

  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}

// ====================================================================================================

function buscarUltimoRegistro() {
  var instrucaoSql = `SELECT DATE_FORMAT(dataLeitura, '%d/%m/%y %H:%i:%s') AS dataLeitura 
FROM registroSensor 
WHERE dataLeitura < NOW() AND leitura = 1
ORDER BY dataLeitura DESC 
LIMIT 1;`;

  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}

module.exports = {
  buscarDadosGraficoBarras,
  buscarDadosGraficoPizzaGeral,
  buscarDadosGraficoLinhaGeral,
  buscarDadosGraficoRadarGeral,
  buscarUltimoRegistro
}
