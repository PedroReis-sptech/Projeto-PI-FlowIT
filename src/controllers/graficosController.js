var graficosModel = require("../models/graficosModel");

function buscarDadosGraficoBarras(req, res) {
 
  var idLoja = req.params.idLoja;

  graficosModel.buscarDadosGraficoBarras(idLoja).then((resultado) => {
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

function buscarDadosGraficoPizzaGeral(req, res) {

  graficosModel.buscarDadosGraficoPizzaGeral().then((resultado) => {
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

function buscarDadosGraficoLinha(req, res) {

  graficosModel.buscarDadosGraficoLinha().then((resultado) => {
    if (resultado.length > 0) {
      res.status(200).json(resultado);
    } else {
      res.status(204).json([]);
    }
  }).catch(function (erro) {
    console.log(erro);
    console.log("Houve um erro ao buscar a Meta Diaria: ", erro.sqlMessage);
    res.status(500).json(erro.sqlMessage);
  });
}

function buscarDadosGraficoRadar(req, res) {

  graficosModel.buscarDadosGraficoRadar().then((resultado) => {
    if (resultado.length > 0) {
      res.status(200).json(resultado);
    } else {
      res.status(204).json([]);
    }
  }).catch(function (erro) {
    console.log(erro);
    console.log("Houve um erro ao buscar a Meta Diaria: ", erro.sqlMessage);
    res.status(500).json(erro.sqlMessage);
  });
}


module.exports = {
  buscarDadosGraficoBarras,
  buscarDadosGraficoPizzaGeral,
  buscarDadosGraficoLinha,
  buscarDadosGraficoRadar
}