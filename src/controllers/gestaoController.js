var gestaoModel = require("../models/gestaoModel");


function listarSetores(req, res) {
  var id = req.params.idLoja;

  gestaoModel.listarSetores(id).then((resultado) => {
    res.status(200).json(resultado);
  }).catch(function(erro) {
        console.log(erro);
        res.status(500).json(erro);
    });
}

module.exports = {listarSetores};
