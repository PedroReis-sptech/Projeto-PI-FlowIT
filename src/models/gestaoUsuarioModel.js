var database = require("../database/config");

function listarUsuarios(idLoja) {
  var instrucaoSql = `
    SELECT u.idUsuario, u.nomeUsuario, u.email, u.fkPermissao, p.cargo 
    FROM usuario u 
    INNER JOIN permissao p ON u.fkPermissao = p.idPermissao 
    WHERE u.fkloja = '${idLoja}';
  `;
  return database.executar(instrucaoSql);
}

function alterarCargo(idUsuario, fkPermissao) {
  var instrucaoSql = `
    UPDATE usuario SET fkPermissao = ${fkPermissao} WHERE idUsuario = ${idUsuario};
  `;
  return database.executar(instrucaoSql);
}

function deletarUsuario(idUsuario) {
  var instrucaoSql = `
    DELETE FROM usuario WHERE idUsuario = ${idUsuario};
  `;
  return database.executar(instrucaoSql);
}

function listarSetores(id) {
  var instrucaoSql = `
    SELECT idSetor, nomeSetor, meta
    FROM setor 
    JOIN loja ON fkLoja = idLoja
    WHERE fkLoja = '${id}';
  `;
  return database.executar(instrucaoSql);
}

module.exports = {
  listarUsuarios,
  alterarCargo,
  deletarUsuario,
  listarSetores
};