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

function buscarDadosGraficoLinhaGeral(req, res) {

  graficosModel.buscarDadosGraficoLinhaGeral().then((resultado) => {
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

function buscarDadosGraficoRadarGeral(req, res) {

  graficosModel.buscarDadosGraficoRadarGeral().then((resultado) => {
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

function buscarUltimoRegistro(req, res) {

  graficosModel.buscarUltimoRegistro().then((resultado) => {
    if (resultado.length > 0) {
      res.status(200).json(resultado);
    } else {
      res.status(204).json([]);
    }
  }).catch(function (erro) {
    console.log(erro);
    console.log("Houve um erro ao buscar a Ultima Ativação: ", erro.sqlMessage);
    res.status(500).json(erro.sqlMessage);
  });
}


module.exports = {
  buscarDadosGraficoBarras,
  buscarDadosGraficoPizzaGeral,
  buscarDadosGraficoLinhaGeral,
  buscarDadosGraficoRadarGeral,
  buscarUltimoRegistro
}