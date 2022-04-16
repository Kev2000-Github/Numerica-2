# initialValues should be vector, example: [1,2,3]
# independentTerms should be vector, example: [1,2,3]
# matrix should be of order NxN

function GaussSeidel(matrix, independentTerms, initialValues, tol)
  isDiagonalDominant = isDiagonallyDominant(matrix);
  isSquare = isMatrixSquare(matrix);
  N = rows(matrix);
  if isDiagonalDominant && isSquare
    solutions = initialValues;
    errors = zeros(1,N);
    #sigue iterando hasta que el error relativo porcentual de todas las variables sean menor que el provisto
    do
      for j=1:N
        xant = solutions(j);
        #obtiene la sumatoria ponderada de la fila exceptuando el de la variable a buscar
        #el cual seria la variable dentro de la diagonal, y sigue la formula:
        #x = (C - sumatoria)/a  (con C siendo el termino independiente y a el factor de x)
        #Y el resultado se guarda inmediatamente en el vector para usarlo en las siguientes filas
        sumatoria = sum(matrix(j,:).*solutions) - matrix(j,j)*solutions(j);
        xi = (independentTerms(j) - sumatoria)/matrix(j,j);
        solutions(j) = xi;
        #Se calcula el error relativo porcentual de la variable y se almacena en un arreglo
        err = abs((xi-xant)/xi)*100;
        errors(j) = err;
        xant = xi;
      endfor
    until(all(errors < tol));
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