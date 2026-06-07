var gestaoModel = require("../models/gestaoModel");

function listarSetores(req, res) {
  var idLoja = req.params.idLoja;
  gestaoModel.listarSetores(idLoja).then((resultado) => {
    res.status(200).json(resultado);
  }).catch(function(erro) {
    console.log(erro);
    res.status(500).json(erro);
  });
}

function deletarSetor(req, res) {
  var idSetor = req.params.idSetor;
  gestaoModel.deletarSetor(idSetor).then((resultado) => {
    res.status(200).json({ mensagem: "Setor deletado com sucesso!" });
  }).catch(function(erro) {
    console.log(erro);
    res.status(500).json(erro);
  });
}

function cadastrarSetor(req, res) {
  var nomeSetor = req.body.nomeSetor;
  var meta = req.body.meta;
  var fkLoja = req.body.fkLoja;
  var idCorredor = req.body.idCorredor; 

  if (nomeSetor == undefined || meta == undefined || fkLoja == undefined || idCorredor == undefined) {
    res.status(400).send("Seus dados estão undefined!");
    return;
  }

  gestaoModel.cadastrarSetor(nomeSetor, meta, fkLoja)
    .then((resultadoSetor) => {
      var idSetorCriado = resultadoSetor.insertId;
      return gestaoModel.cadastrarCorredor(idCorredor, idSetorCriado);
    })
    .then(() => {
      res.status(201).json({ mensagem: "Setor e Corredor criados com sucesso!" });
    })
    .catch(function(erro) {
      console.log(erro);
      res.status(500).json(erro);
    });
}

module.exports = { listarSetores, deletarSetor, cadastrarSetor };