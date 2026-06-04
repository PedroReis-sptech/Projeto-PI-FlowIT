var express = require("express");
var router = express.Router();

var gestaoController = require("../controllers/gestaoUsuarioController");

router.get("/listarUsuarios/:idLoja", function (req, res) {
  gestaoController.listarUsuarios(req, res);
});

router.put("/alterarCargo", function (req, res) {
  gestaoController.alterarCargo(req, res);
});

router.delete("/deletarUsuario/:idUsuario", function (req, res) {
  gestaoController.deletarUsuario(req, res);
});

router.get("/listarSetores/:idLoja", function (req, res) {
  gestaoController.listarSetores(req, res);
});

module.exports = router;