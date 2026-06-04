var gestaoModel = require("../models/gestaoUsuarioModel");

function listarUsuarios(req, res) {
  var idLoja = req.params.idLoja;

  gestaoModel.listarUsuarios(idLoja)
    .then((resultado) => {
      res.status(200).json(resultado);
    }).catch(function(erro) {
      console.log(erro);
      res.status(500).json(erro);
    });
}

function alterarCargo(req, res) {
  var idUsuario = req.body.idUsuario;
  var fkPermissao = req.body.fkPermissao;

  gestaoModel.alterarCargo(idUsuario, fkPermissao)
    .then((resultado) => {
      res.status(200).json(resultado);
    }).catch(function(erro) {
      console.log(erro);
      res.status(500).json(erro);
    });
}

function deletarUsuario(req, res) {
  var idUsuario = req.params.idUsuario;

  gestaoModel.deletarUsuario(idUsuario)
    .then((resultado) => {
      res.status(200).json(resultado);
    }).catch(function(erro) {
      console.log(erro);
      res.status(500).json(erro);
    });
}

function listarSetores(req, res) {
  var id = req.params.idLoja;

  gestaoModel.listarSetores(id).then((resultado) => {
    res.status(200).json(resultado);
  }).catch(function(erro) {
      console.log(erro);
      res.status(500).json(erro);
  });
}

module.exports = {
  listarUsuarios,
  alterarCargo,
  deletarUsuario,
  listarSetores
};