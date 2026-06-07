var database = require("../database/config");

function listarSetores(idLoja) {
  var instrucaoSql = `
    SELECT 
      s.idSetor, 
      s.nomeSetor, 
      s.meta, 
      c.idCorredor
    FROM setor s
    JOIN loja l ON s.fkLoja = l.idLoja
    LEFT JOIN corredor c ON c.fkSetor = s.idSetor
    WHERE s.fkLoja = '${idLoja}';
  `;
  return database.executar(instrucaoSql);
}

function deletarSetor(idSetor) {
  var sqlRegistros = `
    DELETE FROM registroSensor 
    WHERE fkSensor IN (
      SELECT idSensor FROM sensor WHERE fkCorredor IN (
        SELECT idCorredor FROM corredor WHERE fkSetor = '${idSetor}'
      )
    );
  `;

  var sqlSensores = `
    DELETE FROM sensor 
    WHERE fkCorredor IN (
      SELECT idCorredor FROM corredor WHERE fkSetor = '${idSetor}'
    );
  `;

  var sqlCorredores = `DELETE FROM corredor WHERE fkSetor = '${idSetor}';`;
  var sqlSetor = `DELETE FROM setor WHERE idSetor = '${idSetor}';`;

  return database.executar(sqlRegistros)
    .then(function () {
        return database.executar(sqlSensores);
    })
    .then(function () {
        return database.executar(sqlCorredores);
    })
    .then(function () {
        return database.executar(sqlSetor);
    });
}

function cadastrarSetor(nomeSetor, meta, fkLoja) {
  var instrucaoSql = `INSERT INTO setor (nomeSetor, meta, fkLoja) VALUES ('${nomeSetor}', ${meta}, ${fkLoja});`;
  return database.executar(instrucaoSql);
}

function cadastrarCorredor(idCorredor, fkSetor) {
  var instrucaoSql = `INSERT INTO corredor (idCorredor, fkSetor) VALUES ('${idCorredor}', ${fkSetor});`;
  return database.executar(instrucaoSql);
}

module.exports = { 
  listarSetores, 
  deletarSetor, 
  cadastrarSetor,
  cadastrarCorredor 
};