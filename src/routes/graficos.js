var express = require("express");
var router = express.Router();

var graficosController = require("../controllers/graficosController");

router.get("/buscarDadosGraficoBarras/:idLoja", function (req, res) {
    graficosController.buscarDadosGraficoBarras(req, res);
});

router.get("/buscarDadosGraficoPizzaGeral/", function (req, res) {
    graficosController.buscarDadosGraficoPizzaGeral(req, res);
});

router.get("/buscarDadosGraficoLinha/", function (req, res) {
    graficosController.buscarDadosGraficoLinha(req, res);
});

router.get("/buscarDadosGraficoRadar/", function (req, res) {
    graficosController.buscarDadosGraficoRadar(req, res);
});


module.exports = router;