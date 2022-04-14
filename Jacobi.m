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
    do
      for j=1:N
        xant = solutions(j);
        sumatoria = sum(matrix(j,:).*solutions) - matrix(j,j)*solutions(j);
        xi = (independentTerms(j) - sumatoria)/matrix(j,j);
        err = abs((xi-xant)/xi)*100;
        errors(j) = err;
        xant = xi;
        newSolutions(j) = xi;
      endfor
      solutions = newSolutions;
    until(all(errors < tol));
    disp("Solution:");
    solutions
  endif
endfunction