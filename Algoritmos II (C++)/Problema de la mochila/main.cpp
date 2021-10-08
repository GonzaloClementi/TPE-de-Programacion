#include <iostream>
#include <vector>

using namespace std;

struct Objeto {
    int beneficio;
    int peso;
};

void unir(Objeto arr[], int izq, int medio, int der)
{
    int i, j, k;
    int n1 = medio - izq + 1;
    int n2 =  der - medio;

    Objeto I[n1], D[n2];

    for (i = 0; i < n1; i++)
        I[i] = arr[izq + i];
    for (j = 0; j < n2; j++)
        D[j] = arr[medio + 1 + j];

    i = 0;
    j = 0;
    k = izq;
    while (i < n1 && j < n2)
    {
        if ((I[i].beneficio/I[i].peso) >= (D[j].beneficio/D[j].peso))
        {
            arr[k] = I[i];
            i++;
        }
        else
        {
            arr[k] = D[j];
            j++;
        }
        k++;
    }

    while (i < n1)
    {
        arr[k] = I[i];
        i++;
        k++;
    }

    while (j < n2)
    {
        arr[k] = D[j];
        j++;
        k++;
    }
}

void mergeSort(Objeto arr[], int izq, int der)
{
    if (izq < der)
    {
        int medio = (izq + der)/2;
        mergeSort(arr,izq,medio);
        mergeSort(arr,medio+1,der);
        unir(arr,izq,medio,der);
    }
}

int Mochila(Objeto arr[], int C, int n, vector<Objeto> &solucion)
{
    int pesoactual = 0;
    int beneficiototal = 0;
    int i = 0;
    mergeSort(arr,0,n-1);
    while (pesoactual + arr[i].peso <= C)
    {
        solucion.push_back(arr[i]);
        pesoactual = pesoactual + arr[i].peso;
        beneficiototal = beneficiototal + arr[i].beneficio;
        i++;
    }
    return beneficiototal;
}

int main()
{
    //Objeto arr[] = {{6,1}, {3,4}, {10,1}, {4,2}, {5,5}};
    Objeto arr[] = {{11,1}, {21,11}, {31,21}, {33,23}, {43,33}, {53,43}, {55,45}, {65,55}};
    int C = 110; // Capacidad de la mochila
    int n = sizeof(arr) / sizeof(arr[0]); // Cantidad de elementos
    vector<Objeto> solucion;
    cout << endl << "<-------------Problema de la mochila------------>" << endl << endl;
    cout << "El mayor beneficio es: " << Mochila(arr,C,n,solucion);
    cout << endl;
    cout << endl << "Elementos introducidos: ";
    for (int i = 0; i < solucion.size(); i++)
        cout << "(" << solucion[i].beneficio << "," << solucion[i].peso << ") ";
    cout << endl << endl << "<----------------------------------------------->" << endl;
    return 0;
}
