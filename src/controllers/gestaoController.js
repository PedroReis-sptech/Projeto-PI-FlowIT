var gestaoModel = require("../models/gestaoModel");


function listarSetores(req, res) {
  var id = req.params.id;

  gestaoModel.listarSetores().then((resultado) => {
    res.status(200).json(resultado);
  });
}

module.exports = {listarSetores};
