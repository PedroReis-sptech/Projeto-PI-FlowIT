var database = require("../database/config");

function listar() {
  var instrucaoSql = `SELECT nomeUsuario, email, fkPermissao FROM usuario JOIN loja ON fkLoja = idLoja JOIN permissao p WHERE fkLoja = '${id}'`;

  return database.executar(instrucaoSql);
}

module.exports = {buscarPorId, listar };
