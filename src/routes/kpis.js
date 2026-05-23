var express = require("express");
var router = express.Router();

var kpisController = require("../controllers/kpisController");

router.get("/ativacaoSemanaAnterior/", function (req, res) {
    kpisController.buscarAtivacoesPorSetorDaSemanaAnterior(req, res);
});

router.get("/ativacaoAteConsulta/", function (req, res) {
    kpisController.buscarAtivacoesPorSetorAteODiaDaConsulta(req, res);
});

router.get("/metaDiaria/", function (req, res) {
    kpisController.buscarMetaDiaria(req, res);
});


module.exports = router;