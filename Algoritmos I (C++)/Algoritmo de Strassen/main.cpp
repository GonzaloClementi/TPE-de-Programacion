#include <iostream>
#include "Matriz.h"
#include "Strassen.h"

using namespace std;

void imprimir(Matriz<int> mat)
{
    for (int i = 0; i < mat.getFilas(); i++)
    {
        for (int j = 0; j < mat.getColumnas(); j++)
            cout << mat.get(i,j) << " ";


        cout << endl;
    }
    cout << endl;
}

int main()
{
    Matriz<int> A(8,8);
    Matriz<int> B(8,8);
    Matriz<int> C(8,8);
    Matriz<int> S(8,8);
    A.cargar();
    B.cargar();
    C.cargarceros();
    imprimir(A);
    imprimir(B);
    imprimir(C);
    int dim = 8;
    Strassen(dim,A,B,S);
    imprimir(S);

    return 0;
}
