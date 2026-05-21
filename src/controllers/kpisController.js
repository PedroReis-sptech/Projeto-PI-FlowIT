var kpisModel = require("../models/kpisModel");

function buscarAtivacoesPorSetorDaSemanaAnterior(req, res) {

  kpisModel.buscarAtivacoesPorSetorDaSemanaAnterior().then((resultado) => {
    if (resultado.length > 0) {
      res.status(200).json(resultado);
    } else {
      res.status(204).json([]);
    }
  }).catch(function (erro) {
    console.log(erro);
    console.log("Houve um erro ao buscar a Ativacao da Semana Anterior: ", erro.sqlMessage);
    res.status(500).json(erro.sqlMessage);
  });
}

function buscarAtivacoesPorSetorAteODiaDaConsulta(req, res) {

  kpisModel.buscarAtivacoesPorSetorAteODiaDaConsulta().then((resultado) => {
    if (resultado.length > 0) {
      res.status(200).json(resultado);
    } else {
      res.status(204).json([]);
    }
  }).catch(function (erro) {
    console.log(erro);
    console.log("Houve um erro ao buscar a Ativacao do Setor ate o Dia da Consulta: ", erro.sqlMessage);
    res.status(500).json(erro.sqlMessage);
  });
}



module.exports = {
  buscarAtivacoesPorSetorDaSemanaAnterior,
  buscarAtivacoesPorSetorAteODiaDaConsulta
}