# initialValues should be vector, example: [1,2,3]
# independentTerms should be vector, example: [1,2,3]
# matrix should be of order NxN

function Jacobi(matrix, independentTerms, initialValues, tol)
  isDiagonalDominant = isDiagonallyDominant(matrix);
  isSquare = isMatrixSquare(matrix);
  N = rows(matrix);
  if isDiagonalDominant && isSquare
    solutions = initialValues;
    newSolutions = solutions;
    errors = zeros(1,N);
    #sigue iterando hasta que el error relativo porcentual de todas las variables sean menor que el provisto
    do
      #calcula las incognitas fila por fila
      for j=1:N
        xant = solutions(j);
        #obtiene la sumatoria ponderada de la fila exceptuando el de la variable a buscar
        #el cual seria la variable dentro de la diagonal, y sigue la formula:
        # x = (C - sumatoria)/a  (con C siendo el termino independiente y a el factor de x)
        sumatoria = sum(matrix(j,:).*solutions) - matrix(j,j)*solutions(j);
        xi = (independentTerms(j) - sumatoria)/matrix(j,j);
        #Se calcula el error relativo porcentual de la variable y se almacena en un arreglo
        err = abs((xi-xant)/xi)*100;
        errors(j) = err;
        xant = xi;
        newSolutions(j) = xi;
      endfor
      #Se actualiza las soluciones para el calculo de la siguiente iteracion
      solutions = newSolutions;
    until(all(errors < tol));
    disp("Solution:");
    solutions
  else
    disp("-----------------------------------------------------")
    disp("La matriz es invalida por las siguientes razones:");
    if(!isDiagonalDominant)
      disp("- No es diagonalmente dominante");
    endif
    if(!isSquare)
      disp("- No es cuadrada");
    endif
    disp("-----------------------------------------------------")
  endif
endfunction