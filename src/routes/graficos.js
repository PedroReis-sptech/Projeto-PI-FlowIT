var express = require("express");
var router = express.Router();

var graficosController = require("../controllers/graficosController");

router.get("/buscarDadosGraficoBarras/:idLoja", function (req, res) {
    graficosController.buscarDadosGraficoBarras(req, res);
});

router.get("/buscarDadosGraficoPizzaGeral/:setor", function (req, res) {
    graficosController.buscarDadosGraficoPizzaGeral(req, res);
});

router.get("/buscarDadosGraficoLinhaGeral/:setor", function (req, res) {
    graficosController.buscarDadosGraficoLinhaGeral(req, res);
});

router.get("/buscarDadosGraficoRadarGeral/:setor", function (req, res) {
    graficosController.buscarDadosGraficoRadarGeral(req, res);
});

router.get("/buscarUltimoRegistro/", function (req, res) {
    graficosController.buscarUltimoRegistro(req, res);
});


module.exports = router;
