var database = require("../database/config");

// ====================================================================================================

// function buscarSetorComMaiorQueda(idLoja){
//   let ativacaoSemanaAnterior = buscarAtivacoesPorSetorDaSemanaAnterior();
//   let ativacaoAteODiaDaConsulta = buscarAtivacoesPorSetorAteODiaDaConsulta();

// }

// ====================================================================================================


function buscarAtivacoesPorSetorDaSemanaAnterior() {

  var instrucaoSql = `
  SELECT * FROM view_buscarAtivacoesPorSetorDaSemanaAnterior;
  `;

  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}

// ====================================================================================================

function buscarAtivacoesPorSetorAteODiaDaConsulta(){
  var instrucaoSql = `
  SELECT * FROM view_buscarAtivacoesPorSetorAteODiaDaConsulta;
  `;

  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}

// ====================================================================================================

function buscarMetaDiaria(){
  var instrucaoSql = `
  SELECT * FROM view_buscarMetaDiaria;
  `;

  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}

// ====================================================================================================


function buscarSomaDosRegistrosDosSetoresNoDia(){
  var instrucaoSql = `
  SELECT * FROM view_buscarSomaDosRegistrosDosSetoresNoDia
  `;

  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}

// ====================================================================================================


module.exports = {
  buscarAtivacoesPorSetorDaSemanaAnterior,
  buscarAtivacoesPorSetorAteODiaDaConsulta, 
  buscarMetaDiaria,
  buscarSomaDosRegistrosDosSetoresNoDia
}
