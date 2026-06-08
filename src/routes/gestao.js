var express = require("express");
var router = express.Router();

var gestaoController = require("../controllers/gestaoController");

router.get("/listarSetores/:idLoja", function (req, res) {
  gestaoController.listarSetores(req, res);
});

module.exports = router;