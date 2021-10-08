#ifndef STRASSEN_H_INCLUDED
#define STRASSEN_H_INCLUDED

#include "Matriz.h"

void Strassen(int dim, Matriz<int>& A, Matriz<int>& B, Matriz<int>& C)
{
    if (dim == 4)
        A.mult(B,C);
    else
        {
            int newdim = dim/2;
            Matriz<int> A11(newdim,newdim);
            Matriz<int> A12(newdim,newdim);
            Matriz<int> A21(newdim,newdim);
            Matriz<int> A22(newdim,newdim);
            Matriz<int> B11(newdim,newdim);
            Matriz<int> B12(newdim,newdim);
            Matriz<int> B21(newdim,newdim);
            Matriz<int> B22(newdim,newdim);
            Matriz<int> C11(newdim,newdim);
            Matriz<int> C12(newdim,newdim);
            Matriz<int> C21(newdim,newdim);
            Matriz<int> C22(newdim,newdim);
            Matriz<int> M1(newdim,newdim);
            Matriz<int> M2(newdim,newdim);
            Matriz<int> M3(newdim,newdim);
            Matriz<int> M4(newdim,newdim);
            Matriz<int> M5(newdim,newdim);
            Matriz<int> M6(newdim,newdim);
            Matriz<int> M7(newdim,newdim);
            Matriz<int> AA(newdim,newdim);
            Matriz<int> BB(newdim,newdim);

            A.getCuadrante(newdim,A11,A12,A21,A22);
            B.getCuadrante(newdim,B11,B12,B21,B22);


            //Calcular M1
            A11.suma(A22,AA,newdim);
            B11.suma(B22,BB,newdim);
            Strassen(newdim,AA,BB,M1);

            //Calcular M2
            A21.suma(A22,AA,newdim);
            Strassen(newdim,AA,B11,M2);

            //Calcular M3
            B12.resta(B22,BB,newdim);
            Strassen(newdim,A11,BB,M3);

            //Calcular M4
            B21.resta(B11,BB,newdim);
            Strassen(newdim,A22,BB,M4);

            //Calcular M5
            A11.suma(A12,AA,newdim);
            Strassen(newdim,AA,B22,M5);

            //Calcular M6
            A21.resta(A11,AA,newdim);
            B11.suma(B12,BB,newdim);
            Strassen(newdim,AA,BB,M6);

            //Calcular M7
            A12.resta(A22,AA,newdim);
            B21.suma(B22,BB,newdim);
            Strassen(newdim,AA,BB,M7);

            //Calcular C11
            M1.suma(M4,AA,newdim);
            AA.suma(M7,BB,newdim); // CAMBIE ESTO   M5.suma(M7,BB,newdim) por  AA.suma(M7,BB,newdim)
            BB.resta(M5,C11,newdim); // Y ESTO  AA.resta(BB,C11,newdim) por BB.resta(M5,C11,newdim)

            //Calcular C12
            M3.suma(M5,C12,newdim);

            //Calcular C21
            M2.suma(M4,C21,newdim);

            //Calcular C22
            M1.suma(M3,AA,newdim);
            AA.suma(M6,BB,newdim); // CAMBIE ESTO  M2.suma(M6,BB,newdim) por AA.suma(M6,BB,newdim)
            BB.resta(M2,C22,newdim); // Y ESTO  AA.resta(BB,C22,newdim) por BB.resta(M2,C22,newdim)

            //Unimos todas las soluciones (C11,C12,C21,C22)
            C.unirCuadrantes(newdim,C11,C12,C21,C22);
        }
}

#endif // STRASSEN_H_INCLUDED
