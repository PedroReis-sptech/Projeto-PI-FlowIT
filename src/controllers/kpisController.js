var kpisModel = require("../models/kpisModel");

function buscarSetorComMaiorQueda(req, res) {
  var idLoja = req.params.idLoja;

  kpisModel.buscarSetorComMaiorQueda(idLoja).then((resultado) => {
    if (resultado.length > 0) {
      res.status(200).json(resultado);
    } else {
      res.status(204).json([]);
    }
  }).catch(function (erro) {
    console.log(erro);
    console.log("Houve um erro ao buscar o Setor com Maior Queda: ", erro.sqlMessage);
    res.status(500).json(erro.sqlMessage);
  });
}

function buscarAtingimentoVsMetaSemana(req, res) {
  var idLoja = req.params.idLoja;

  kpisModel.buscarAtingimentoVsMetaSemana(idLoja).then((resultado) => {
    if (resultado.length > 0) {
      res.status(200).json(resultado);
    } else {
      res.status(204).json([]);
    }
  }).catch(function (erro) {
    console.log(erro);
    console.log("Houve um erro ao buscar o Antigimento vs Meta Semanal: ", erro.sqlMessage);
    res.status(500).json(erro.sqlMessage);
  });
}

function buscarAtingimentoVsMetaDiaria(req, res) {
  var idLoja = req.params.idLoja;

  kpisModel.buscarAtingimentoVsMetaDiaria(idLoja).then((resultado) => {
    if (resultado.length > 0) {
      res.status(200).json(resultado);
    } else {
      res.status(204).json([]);
    }
  }).catch(function (erro) {
    console.log(erro);
    console.log("Houve um erro ao buscar o Atingimento vs Meta Diaria: ", erro.sqlMessage);
    res.status(500).json(erro.sqlMessage);
  });
}

function buscarSetorComMaiorCrescimento(req, res) {
  var idLoja = req.params.idLoja;

  kpisModel.buscarSetorComMaiorCrescimento(idLoja).then((resultado) => {
    if (resultado.length > 0) {
      res.status(200).json(resultado);
    } else {
      res.status(204).json([]);
    }
  }).catch(function (erro) {
    console.log(erro);
    console.log("Houve um erro ao buscar o Setor com Maior Crescimento: ", erro.sqlMessage);
    res.status(500).json(erro.sqlMessage);
  });
}

module.exports = {
  buscarSetorComMaiorQueda,
  buscarAtingimentoVsMetaSemana,
  buscarAtingimentoVsMetaDiaria,
  buscarSetorComMaiorCrescimento
}