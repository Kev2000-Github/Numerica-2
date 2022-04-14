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
    do
      for j=1:N
        xant = solutions(j);
        sumatoria = sum(matrix(j,:).*solutions) - matrix(j,j)*solutions(j);
        xi = (independentTerms(j) - sumatoria)/matrix(j,j);
        solutions(j) = xi;
        err = abs((xi-xant)/xi)*100;
        errors(j) = err;
        xant = xi;
      endfor
    until(all(errors < tol));
    solutions
  endif
endfunction