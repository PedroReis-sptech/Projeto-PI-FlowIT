var express = require("express");
var router = express.Router();

var kpisController = require("../controllers/kpisController");

router.get("/setorEmQueda/:idLoja", function (req, res) {
    kpisController.buscarSetorComMaiorQueda(req, res);
});

router.get("/atingimentoSemanal/:idLoja", function (req, res) {
    kpisController.buscarAtingimentoVsMetaSemana(req, res);
});

router.get("/atingimentoDiario/:idLoja", function (req, res) {
    kpisController.buscarAtingimentoVsMetaDiaria(req, res);
});

router.get("/setorEmCrescimento/:idLoja", function (req, res) {
    kpisController.buscarSetorComMaiorCrescimento(req, res);
});

module.exports = router;