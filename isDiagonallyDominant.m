#i es la iteracion, si i es mayor o igual a 150, quiere decir que convergio por limite de iteraciones
#numConverge es el ultimo valor X que adopto la funcion iterativa
#numEvaluacion es el ultimo valor f(x) que adopto la funcion iterativa
#error es el ultimo error relativo obtenido
#errorEsperado es la tolerancia dada 
function isDominant = isDiagonallyDominant(matrix)
  try
    diagonal = abs(diag(matrix));
    sumRows = sum(abs(matrix),2) - diagonal;
    isDominant = all(diagonal >= sumRows);
  catch
    isDominant = 0;
  end_try_catch
endfunction

