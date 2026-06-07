var express = require("express");
var router = express.Router();

var gestaoController = require("../controllers/gestaoUsuarioController");

router.get("/listarUsuarios/:idLoja", function (req, res) {
  gestaoUsuarioController.listarUsuarios(req, res);
});

router.put("/alterarCargo", function (req, res) {
  gestaoUsuarioController.alterarCargo(req, res);
});

router.delete("/deletarUsuario/:idUsuario", function (req, res) {
  gestaoUsuarioController.deletarUsuario(req, res);
});

router.get("/listarSetores/:idLoja", function (req, res) {
  gestaoUsuarioController.listarSetores(req, res);
});

module.exports = router;