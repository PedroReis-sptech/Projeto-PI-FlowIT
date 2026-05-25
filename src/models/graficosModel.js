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

function buscarDadosGraficoPizza() {
  var instrucaoSql = ``;

  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}

// ====================================================================================================

function buscarDadosGraficoLinha() {
  var instrucaoSql = ``;

  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}

// ====================================================================================================


function buscarDadosGraficoRadar() {
  var instrucaoSql = ``;

  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}

// ====================================================================================================


module.exports = {
  buscarDadosGraficoBarras,
  buscarDadosGraficoPizza,
  buscarDadosGraficoLinha,
  buscarDadosGraficoRadar
}
