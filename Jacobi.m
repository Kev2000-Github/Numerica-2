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
    counter = 1
    do
      fprintf("============< Iteracion %d >=============\n", counter);
      #calcula las incognitas fila por fila
      for j=1:N
        xant = solutions(j);
        #obtiene la sumatoria ponderada de la fila exceptuando el de la variable a buscar
        #el cual seria la variable dentro de la diagonal, y sigue la formula:
        # x = (C - sumatoria)/a  (con C siendo el termino independiente y a el factor de x)
        sumatoria = sum(matrix(j,:).*solutions) - matrix(j,j)*solutions(j);
        xi = (independentTerms(j) - sumatoria)/matrix(j,j);
        #Se calcula el error relativo porcentual de la variable y se almacena en un arreglo
        #si xi = 0, entonces debe estar en la primera iteracion con valores iniciales 0 y algun termino independiente 0
        if xi != 0
          err = abs((xi-xant)/xi);
        else
          err = 1;
        endif
        errors(j) = err;
        xant = xi;
        newSolutions(j) = xi;
        fprintf('X%d = %.7f   Error Relativo: %.7f \n', j, xi, err);
      endfor
      #Se actualiza las soluciones para el calculo de la siguiente iteracion
      solutions = newSolutions;
      counter++;
    until(all(errors < tol));
    #print results
    disp("===========================");
    disp("Solucion del sistema");
    for i = 1:size(solutions,2)
      fprintf("X%d = %.7f\n", i, solutions(i));
    endfor
    disp("===========================");
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