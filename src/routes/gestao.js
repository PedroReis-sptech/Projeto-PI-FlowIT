var express = require("express");
var router = express.Router();

var gestaoController = require("../controllers/gestaoController");

router.get("/listarSetores:id", function (req, res) {
  gestaoController.listarSetores(req, res);
});

module.exports = router;