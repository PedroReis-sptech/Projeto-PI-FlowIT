var gestaoModel = require("../models/gestaoModel");


function listarSetores(req, res) {
  var id = req.params.idLoja;

  gestaoModel.listarSetores(id).then((resultado) => {
    res.status(200).json(resultado);
  });
}

module.exports = {listarSetores};
