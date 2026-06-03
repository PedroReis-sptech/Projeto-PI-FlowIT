var database = require("../database/config");

function listar() {
  var instrucaoSql = `SELECT nomeUsuario, email, fkPermissao FROM usuario JOIN loja ON fkLoja = idLoja JOIN permissao p WHERE fkLoja = '${id}'`;

  return database.executar(instrucaoSql);
}

function listarSetores() {
  var instrucaoSql = `SELECT idSetor, nomesetor, meta
  FROM setor 
  JOIN loja ON fkLoja = idLoja
  WHERE fkLoja = '${id}'`;

  return database.executar(instrucaoSql);
}
module.exports = {listarSetores};
