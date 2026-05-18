var database = require("../database/config")

function autenticar(email, senha) {
    console.log("ACESSEI O USUARIO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function entrar(): ", email, senha)
    var instrucaoSql = `
        SELECT idUsuario, codigoVerificacao, nomeUsuario, email FROM usuario WHERE email = '${email}' AND senha = '${senha}';`;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

// CORRIGIDO: Adicionado o parâmetro 'codigo' que estava faltando na assinatura da função
function cadastrar(nome, email, senha, codigo) {
    console.log("ACESSEI O USUARIO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function cadastrar():", nome, email, senha, codigo); 
     var codigosql = `
        SELECT codigoVerificacao FROM loja;
    `;
    let resultado = database.executar(codigosql);
    console.log(resultado);
    let codigoCerto = false;
    
    for(let i = 0; i < resultado.length; i++){
        if(resultado[i] == codigo){
            codigoCerto = true
        }
    }
    if(codigoCerto){
        console.log('oi')
        var instrucaoSql = `
        INSERT INTO usuario (nomeUsuario, email, senha) VALUES ('${nome}', '${email}', '${senha}');
    `;
    return;
    }else {
        console.log('Erro do código de verificação')
    }
    
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

module.exports = {
    autenticar,
    cadastrar
};
