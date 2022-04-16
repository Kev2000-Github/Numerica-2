

function  DescomposicionLU(A,b)
  
[n,n]=size(A);
    
%------------------matrices a usar-------------------------

%Sustitucion hacia adelante
L=eye(n);
C=zeros(n,1);%VECTOR DE TERMINOS INDEPENDIENTES CORRESPONDIENTE A COLUMNAS IDENTIDAD
Z=zeros(n,1);%VECTOR SOLUCION

%Sustitucion hacia atras
U=eye(n);
%Z (la misma z de arriba)
X=zeros(n,1);%VECTOR SOLUCION

%Otros
MIden = eye(n,n);%MATRIZ IDENTIDAD
MI=zeros(n,n);%MATRIZ INVERSA

%---------------Calculo de LU-----------------

  fprintf("Descomposicion LU realizada exitosamente... \n")
  
  for k=1:n
    %Llenado de Matrices
    L(k,k)=1;%llenado de la diagonal = 1 para k,k
    U(1,k)=A(1,k);
    
    %Cálculo de U
    for i=k:n
      U(k,i)=A(k,i)-L(k,1:k-1)*U(1:k-1,i);
    endfor
    
    %Cálculo de L
    for i=k+1:n
      L(i,k)=(A(i,k)-L(i,1:k-1)*U(1:k-1,k))/U(k,k);
    endfor
  endfor
  
  L
  U
  
%------------Calculo de la inversa ---------------

  fprintf("\nMatriz Inversa calculada... \n")

for k=1:n %va por la cantidad de columnas de A, ya que MI tendra las mismas dimensiones q A
    
    %llenado de la columna C a usar en esta iteracion
    for l=1:n
    C(l) = MIden(l,k);
    endfor
        
  %Sustitucion hacia adelante (Usamos L)--------------------
    AD = [L C];
    %[n,m] = size(A);
    %declara el vector solucion a llenar
    Z(1)= AD(1,n+1)/AD(1,1);
    for i=2:n
      s=0;
      for j=1:i-1
        s=s+AD(i,j)*Z(j);
      endfor
      Z(i)=(AD(i,n+1)-s)/AD(i,i);
    endfor

    %Sustitucion hacia atras (Usamos U)----------------------------
    AT = [U Z];
    %[n,m] = size(A);
    %declara el vector solucion a llenar
    X(n)= AT(n,n+1)/AT(n,n);
    for i=n-1:-1:1
      s=0;
      for j=n:-1:i+1
        s=s+AT(i,j)*X(j);
      endfor
      X(i)=(AT(i,n+1)-s)/AT(i,i);
    endfor
    
   %llenado de MI con la columna solucion X generada en cada iteracion
   for i=1:n
     MI(i,k)= X(i);
   endfor
   
  endfor 
  
 MI
%-------------------------Resultado---------------------------- 

  fprintf("\nFinalmente obtenemos el vector solucion S: \n")  
  S = MI*b
  
endfunction

