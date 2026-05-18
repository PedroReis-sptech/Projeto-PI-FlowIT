var express = require("express");
var router = express.Router();

var empresaController = require("../controllers/gestaoController");

//Recebendo os dados do html e direcionando para a função cadastrar de usuarioController.js

router.get("/buscar/:id", function (req, res) {
  empresaController.buscarPorId(req, res);
});

router.get("/listar", function (req, res) {
  empresaController.listar(req, res);
});

module.exports = router;