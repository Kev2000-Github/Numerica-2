function menu
  repeat = "1";
  while (repeat == "1")
    clc;
    disp("-----------");
    disp("  M E N U  ");
    disp("-----------");
    disp("Descomposicion LU (1)");
    disp("Metodo de Jacobi (2)");
    disp("Metodo Gauss-Seidel (3)");
    disp("salir (presione cualquier otra tecla)")
    answer = input("Respuesta: ","s");
    clc;
    switch(answer)
      case "1"
        descomposicionLU;
        input("presione cualquier tecla para continuar...");
      case "2"
        Jacobi;
        input("presione cualquier tecla para continuar...");
      case "3"
        GaussSeidel;
        input("presione cualquier tecla para continuar...");
      otherwise
        repeat = -1;
    endswitch
    if(repeat != -1)
      clc;
      disp("desea calcular otra aproximacion?");
      disp("Si (1)");
      disp("No (Presione cualquier tecla)");
      repeat = input("Respuesta: ", "s");
    endif
  endwhile
  clc 
endfunction
