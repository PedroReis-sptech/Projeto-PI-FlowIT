var database = require("../database/config");

function listarSetores(id) {
  var instrucaoSql = `SELECT idSetor, nomeSetor, meta
  FROM setor 
  JOIN loja ON fkLoja = idLoja
  WHERE fkLoja = '${id}'`;

  return database.executar(instrucaoSql);
}

module.exports = {
  listarSetores
};
