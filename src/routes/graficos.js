var express = require("express");
var router = express.Router();

var graficosController = require("../controllers/graficosController");

router.get("/buscarDadosGraficoBarras/:idLoja", function (req, res) {
    graficosController.buscarDadosGraficoBarras(req, res);
});

router.get("/buscarDadosGraficoPizzaGeral/", function (req, res) {
    graficosController.buscarDadosGraficoPizzaGeral(req, res);
});

router.get("/buscarDadosGraficoLinhaGeral/", function (req, res) {
    graficosController.buscarDadosGraficoLinhaGeral(req, res);
});

router.get("/buscarDadosGraficoRadarGeral/", function (req, res) {
    graficosController.buscarDadosGraficoRadarGeral(req, res);
});


module.exports = router;