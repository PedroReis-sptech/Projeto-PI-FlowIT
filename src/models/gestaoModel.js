var database = require("../database/config");

function listarSetores(id) {
  var instrucaoSql = `SELECT idSetor, nomeSetor, meta
  FROM setor 
  JOIN loja ON fkLoja = idLoja
  WHERE fkLoja = '${id}'`;

  return database.executar(instrucaoSql);
}

function alterarSetor(idSetor, novaMeta) {
    var instrucaoSql = `
        UPDATE setor 
        SET meta = ${novaMeta} 
        WHERE idSetor = ${idSetor};
    `;
    return database.executar(instrucaoSql);
}

module.exports = {
  listarSetores,
  alterarSetor
};
