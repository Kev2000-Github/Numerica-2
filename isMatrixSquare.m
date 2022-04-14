function isSquare = isMatrixSquare(matrix)
  numberCol = columns(matrix);
  numberRows = rows(matrix);
  isSquare = numberCol == numberRows;
endfunction
