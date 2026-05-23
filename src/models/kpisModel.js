var database = require("../database/config");

// ====================================================================================================

// function buscarSetorComMaiorQueda(idLoja){
//   let ativacaoSemanaAnterior = buscarAtivacoesPorSetorDaSemanaAnterior();
//   let ativacaoAteODiaDaConsulta = buscarAtivacoesPorSetorAteODiaDaConsulta();

// }

function buscarAtivacoesPorSetorDaSemanaAnterior() {

  var instrucaoSql = `SELECT 
        st.nomeSetor, 
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
  `;

  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}

function buscarAtivacoesPorSetorAteODiaDaConsulta(){
  var instrucaoSql = `SELECT 
      st.nomeSetor, 
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
  `;

  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}

function buscarMetaDiaria(){
  var instrucaoSql = `SELECT 
        SUM(meta) AS metaDiaria
        FROM setor
        GROUP BY meta;
  `;

  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}

// ====================================================================================================


module.exports = {
  buscarAtivacoesPorSetorDaSemanaAnterior,
  buscarAtivacoesPorSetorAteODiaDaConsulta, 
  buscarMetaDiaria
}
