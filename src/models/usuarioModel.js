var database = require("../database/config")

function autenticar(email, senha) {
    console.log("ACESSEI O USUARIO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function entrar(): ", email, senha)
    
     var instrucaoSql = `
        SELECT u.idUsuario, u.nomeUsuario, u.email, u.senha, p.cargo
         FROM usuario u
         JOIN permissao p ON u.fkPermissao = p.idPermissao
         WHERE u.email = "${email}" AND u.senha = "${senha}";`;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function cadastrar(nome, email, senha, codigo) {

    var pegarLoja = `SELECT idLoja FROM loja WHERE codigoVerificacao = '${codigo}'`;
    return database.executar(pegarLoja).then(function(resultado) {

        if (resultado.length === 0) {
            console.log('Código de verificação inválido');
            return null;
        }

        var idLoja = resultado[0].idLoja;

        var instrucaoSql = `
            INSERT INTO usuario (nomeUsuario, email, senha, fkLoja, fkPermissao) 
            VALUES ('${nome}', '${email}', '${senha}', ${idLoja}, 2)`;

        return database.executar(instrucaoSql);
    });
}

function gerenciar(codigo){
    console.log("ACESSEI O USUARIO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente.")

    var instrucaoSql = `SELECT nomeUsuario, email, permissao.cargo
        FROM usuario
        JOIN permissao ON usuario.fkPermissao = permissao.idPermissao
        JOIN loja ON usuario.fkLoja = loja.idLoja
        WHERE loja.codigoVerificacao = '${codigo}'`

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

module.exports = {
    autenticar,
    cadastrar,
    gerenciar
};
