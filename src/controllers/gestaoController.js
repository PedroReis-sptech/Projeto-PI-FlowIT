var gestaoModel = require("../models/gestaoModel"); 

function listarSetores(req, res) {
    var idLoja = req.params.idLoja;

    if (idLoja == undefined) {
        res.status(400).send("O id da loja está undefined!");
    } else {
        gestaoModel.listarSetores(idLoja)
            .then(function (resultado) {
                if (resultado.length > 0) {
                    res.status(200).json(resultado); 
                } else {
                    res.status(204).send("Nenhum resultado encontrado!");
                }
            }).catch(function (erro) {
                console.log(erro);
                res.status(500).json(erro.sqlMessage);
            });
    }
}

function alterarSetor(req, res) {
    var idSetor = req.params.idSetor; 
    var novaMeta = req.body.meta;     

    if (idSetor == undefined) {
        res.status(400).send("O ID do setor está undefined!");
    } else if (novaMeta == undefined) {
        res.status(400).send("A nova meta está undefined!");
    } else {
        gestaoModel.alterarSetor(idSetor, novaMeta)
            .then(function (resultado) {
                res.status(200).json(resultado); 
            }).catch(function (erro) {
                console.log(erro);
                res.status(500).json(erro.sqlMessage);
            });
    }
}

module.exports = {
    listarSetores,
    alterarSetor
};