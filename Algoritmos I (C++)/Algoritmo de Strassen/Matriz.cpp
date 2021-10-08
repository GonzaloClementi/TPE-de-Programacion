#include "Matriz.h"
#include <assert.h>
#include <iostream>
#include <stdlib.h>
#include <stdio.h>
#include <conio.h>
#include <time.h>

using namespace std;

template <class T>
Matriz<T>::Matriz(int fil, int col)
{
    elementos = new T*[fil];
    for (int i = 0; i < fil; i++)
        elementos[i] = new T[col];
    filas = fil;
    columnas = col;
}

template <class T>
Matriz<T>::Matriz(const Matriz& m)
{
    elementos = new T*[m.filas];
    filas = m.filas;
    columnas = m.columnas;
    for (int i = 0; i < filas; i++)
        elementos[i] = new T[columnas];
    for (int i = 0; i < filas; i++)
        for (int j = 0; j < columnas; j++)
            elementos[i][j] = m.elementos[i][j];
}

template <class T>
Matriz<T>::~Matriz()
{
    for (int f = 0; f < filas ; f++)
        delete [] elementos[f];
    delete [] elementos;
    elementos = 0;
}

template <class T>
void Matriz<T>::insertar(const T& elem, int fil, int col)
{
    assert((fil < filas) && (col < columnas));
    elementos[fil][col] = elem;
}

template <class T>
T Matriz<T>::get(int i, int j)const
{
    assert((i < filas) && (j < columnas));
    return elementos[i][j];
}

template <class T>
void Matriz<T>::suma(const Matriz& otraM, Matriz& res,int dim)
{
    assert((filas == otraM.filas) && (columnas == otraM.columnas));
    for (int i = 0; i < dim; i++)
        for (int j = 0; j < dim; j++)
            res.elementos[i][j] = elementos[i][j] + otraM.elementos[i][j];
}

template <class T>
void Matriz<T>::resta(const Matriz& otraM, Matriz& res,int dim)
{
    assert((filas == otraM.filas) && (columnas == otraM.columnas));
    for (int i = 0; i < dim; i++)
        for (int j = 0; j < dim; j++)
            res.elementos[i][j] = elementos[i][j] - otraM.elementos[i][j];
}

template <class T>
void Matriz<T>::mult(const Matriz& otraM, Matriz& res)
{
    assert((columnas == otraM.filas) && (res.filas == filas) && (res.columnas == otraM.columnas));
    for (int i = 0; i < filas; i++)
        for (int j = 0; j < columnas; j++)
        {
            res.elementos[i][j] = 0;
            for (int k = 0; k < columnas; k++)
                res.elementos[i][j] = res.elementos[i][j] + elementos[i][k] * otraM.elementos[k][j];
        }
}

template <class T>
void Matriz<T>::getCuadrante(int dim, Matriz& M11,Matriz& M12,Matriz& M21,Matriz& M22)
{
    for(int i = 0; i < dim; i++)
        for(int j = 0; j < dim; j++)
        {
            M11.insertar(elementos[i][j],i,j);
            M12.insertar(elementos[i][j+dim],i,j);
            M21.insertar(elementos[i+dim][j],i,j);
            M22.insertar(elementos[i+dim][j+dim],i,j);
        }
}

template <class T>
void Matriz<T>::unirCuadrantes(int dim,const Matriz& M11,const Matriz& M12,const Matriz& M21,const Matriz& M22)
{
    for(int i = 0; i < dim; i++)
        for(int j = 0; j < dim; j++)
        {
            elementos[i][j] = M11.get(i,j);
            elementos[i][j+dim] = M12.get(i,j);
            elementos[i+dim][j] = M21.get(i,j);
            elementos[i+dim][j+dim] = M22.get(i,j);
        }

}

template <class T>
int Matriz<T>::getFilas()const
{
    return filas;
}

template <class T>
int Matriz<T>::getColumnas()const
{
    return columnas;
}

template <class T>
void Matriz<T>::cargar() // Aclaracion: este metodo se utilizo para cargar la matriz con numeros randomizados. Para
{                        // la prueba del algoritmo se puede modificar
    srand(time(NULL));
    for (int i = 0; i < filas; i++)
    {
        for (int j = 0; j < columnas; j++){
            int aux= 1 + rand() % ((10+1) - 1);
            elementos[i][j]=aux;
        }
    }
}

template <class T>
void Matriz<T>::cargarceros()
{
    for (int i = 0; i < filas; i++)
        for (int j = 0; j < columnas; j++)
            elementos[i][j] = 0;
}

template class Matriz<float>;
template class Matriz<double>;
template class Matriz<unsigned int>;
template class Matriz<int>;
