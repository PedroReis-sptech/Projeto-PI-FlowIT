var database = require("../database/config");

// ====================================================================================================


function buscarDadosGraficoBarras(idLoja) {

  var instrucaoSql = `
  SELECT 
    st.nomeSetor,
    ROUND(
        COUNT(CASE WHEN rs.leitura = 1 THEN 1 END) * 100.0
        / (SELECT COUNT(rs.idRegistroSensor) AS totalRegistros FROM registroSensor rs
          WHERE rs.dataLeitura >= CURDATE()),
        2
    ) AS percentualAtivacao
FROM setor st
JOIN corredor       c   ON st.idSetor   = c.fkSetor
JOIN sensor         ss  ON c.idCorredor = ss.fkCorredor
JOIN registroSensor rs  ON ss.idSensor  = rs.fkSensor
WHERE st.fkloja AND rs.dataLeitura >= CURDATE()
AND DAY(rs.dataLeitura) = DAY(NOW())
GROUP BY st.idSetor, st.nomeSetor;`;


  return database.executar(instrucaoSql);
}

// ====================================================================================================

function buscarDadosGraficoPizzaGeral(setor) {
  if(setor == 'Geral'){
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
  AND HOUR(rs.dataLeitura) BETWEEN 8 AND 20
  AND DAY(rs.dataLeitura) = DAY(NOW())
GROUP BY turno;`;
  } else {
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
  AND HOUR(rs.dataLeitura) BETWEEN 8 AND 19 AND st.nomeSetor = '${setor}'
  AND DAY(rs.dataLeitura) = DAY(NOW())
GROUP BY turno;`;
  }


  return database.executar(instrucaoSql);
}

// ====================================================================================================

function buscarDadosGraficoLinhaGeral(setor) {
  if(setor == 'Geral'){
    var instrucaoSql = `SELECT 
    HOUR(rs.dataLeitura) AS hora,
    COUNT(CASE WHEN rs.leitura = 1 THEN 1 END) AS quantidade
FROM setor st
JOIN corredor       c   ON st.idSetor   = c.fkSetor
JOIN sensor         ss  ON c.idCorredor = ss.fkCorredor
JOIN registroSensor rs  ON ss.idSensor  = rs.fkSensor
WHERE st.fkloja
  AND HOUR(rs.dataLeitura) BETWEEN 8 AND 20
  AND DAY(rs.dataLeitura) = DAY(NOW())
GROUP BY  HOUR(rs.dataLeitura)
ORDER BY hora;
`;
  } else {
  var instrucaoSql = `SELECT 
    HOUR(rs.dataLeitura) AS hora,
    COUNT(CASE WHEN rs.leitura = 1 THEN 1 END) AS quantidade
FROM setor st
JOIN corredor       c   ON st.idSetor   = c.fkSetor
JOIN sensor         ss  ON c.idCorredor = ss.fkCorredor
JOIN registroSensor rs  ON ss.idSensor  = rs.fkSensor
WHERE st.fkloja
  AND HOUR(rs.dataLeitura) BETWEEN 8 AND 20 AND st.nomeSetor = '${setor}'
  AND DAY(rs.dataLeitura) = DAY(NOW())
GROUP BY  HOUR(rs.dataLeitura)
ORDER BY hora;
`;
  }


  return database.executar(instrucaoSql);
}

// ====================================================================================================


function buscarDadosGraficoRadarGeral(setor) {
  if(setor == 'Geral'){
      var instrucaoSql = `SELECT 
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
GROUP BY DAYOFWEEK(rs.dataLeitura), diaSemana;`;
  } else {
    var instrucaoSql = `SELECT 
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
    AND st.nomeSetor = '${setor}'
GROUP BY DAYOFWEEK(rs.dataLeitura), diaSemana;`;
  }



  return database.executar(instrucaoSql);
}

// ====================================================================================================

function buscarUltimoRegistro() {
  var instrucaoSql = `SELECT DATE_FORMAT(dataLeitura, '%d/%m/%y %H:%i:%s') AS dataLeitura 
FROM registroSensor 
WHERE DAY(dataLeitura) <= DAY(NOW()) AND leitura = 1
ORDER BY dataLeitura DESC 
LIMIT 1;`;


  return database.executar(instrucaoSql);
}

module.exports = {
  buscarDadosGraficoBarras,
  buscarDadosGraficoPizzaGeral,
  buscarDadosGraficoLinhaGeral,
  buscarDadosGraficoRadarGeral,
  buscarUltimoRegistro
}
