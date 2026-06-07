var express = require("express");
var router = express.Router();

var gestaoController = require("../controllers/gestaoController");

router.get("/listarSetores/:idLoja", function (req, res) {
  gestaoController.listarSetores(req, res);
});

router.delete("/deletarSetor/:idSetor", function (req, res) {
  gestaoController.deletarSetor(req, res);
});

router.post("/cadastrarSetor", function (req, res) {
  gestaoController.cadastrarSetor(req, res);
});

module.exports = router;