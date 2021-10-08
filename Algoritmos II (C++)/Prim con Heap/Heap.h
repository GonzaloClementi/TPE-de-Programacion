#ifndef HEAP_H_INCLUDED
#define HEAP_H_INCLUDED

#include <iostream>
#include <vector>

using namespace std;

template <class T>
class Heap{

public:

    class Par{
        public:
            Par();
            Par(const T & vert, int dist);
            const T & devolver_vertice() const;
            int devolver_dist() const;
            void modificar_dist(int dist);
        private:
            T vertice;
            int distancia;
    };

    Heap();
    void Insertar(const T &elem, int valor);
    int get_tamanio();
    const Par& Tope();
    const Par& ExtraerMin();
    void Actualizar(const T &elem, int valor);
    bool Existe(const T& elem)const;
    bool esVacia()const;
    void Imprimir();
    void ImprimirMapa();

private:

    vector<Par> Arr_heap;
    map<int,T> posiciones; // Posiciones de los elementos del arreglo, para que complejidad de actualizar sea O(log n)

    void Hundir (int padre);
    void Flotar (int hijo, int padre);
    void Intercambiar(int hijo, int padre);
    int get_hijoizq(int padre);
    int get_hijoder(int padre);
    int get_padre(int hijo);

};

template <class T>
Heap<T>::Par::Par()
{

}

template <class T>
Heap<T>::Par::Par(const T & vert, int dist)
{
    vertice = vert;
    distancia = dist;
}

template <class T>
const T & Heap<T>::Par::devolver_vertice() const
{
    return vertice;
}

template <class T>
int Heap<T>::Par::devolver_dist() const
{
    return distancia;
}

template <class T>
void Heap<T>::Par::modificar_dist(int dist)
{
    distancia = dist;
}

template <class T>
Heap<T>::Heap(){

}

template <class T>
int Heap<T>::get_tamanio(){

    return Arr_heap.size();

}

template <class T>
const typename Heap<T>::Par& Heap<T>::Tope(){

    return Arr_heap[0];
}

template <class T>
int Heap<T>::get_hijoizq(int padre){

    return 2 * padre + 1;

}

template <class T>
int Heap<T>::get_hijoder(int padre){

    return 2 * padre + 2;

}

template <class T>
int Heap<T>::get_padre(int hijo){

    return (hijo - 1) / 2;

}

template <class T>
bool Heap<T>::Existe(const T& elem)const {

    typename map<T,int>::const_iterator it = posiciones.find(elem);
    if (it != posiciones.end())
        return true;
    else
        return false;

}

template <class T>
bool Heap<T>::esVacia()const {

    return Arr_heap.empty();

}

template <class T>
void Heap<T>::Intercambiar(int hijo, int padre){

    int dist = Arr_heap[hijo].devolver_dist();
    T vert = Arr_heap[hijo].devolver_vertice();
    T vert_padre = Arr_heap[padre].devolver_vertice();
    Par Aux(vert,dist);
    posiciones[vert] = padre;
    posiciones[vert_padre] = hijo;
    Arr_heap[hijo] = Arr_heap[padre];
    Arr_heap[padre] = Aux;

}

template <class T>
void Heap<T>::Hundir (int padre){

    bool finaliza = false;
    while (!finaliza){
        int hijoizq = get_hijoizq(padre);
        int hijoder = get_hijoder(padre);
        int tamanio = Arr_heap.size();
        int hijomenor = padre;

        if ((hijoizq < tamanio) && (Arr_heap[hijoizq].devolver_dist() < Arr_heap[hijomenor].devolver_dist()))
            hijomenor = hijoizq;

        if ((hijoder < tamanio) && (Arr_heap[hijoder].devolver_dist() < Arr_heap[hijomenor].devolver_dist()))
            hijomenor = hijoder;

        if (hijomenor != padre){
            Intercambiar(hijomenor,padre);
            padre = hijomenor;
        }
        else
            finaliza = true;
    }
}

template <class T>
void Heap<T>::Flotar (int hijo, int padre){

    while (hijo != padre && Arr_heap[hijo].devolver_dist() <= Arr_heap[padre].devolver_dist()){
        Intercambiar(hijo,padre);
        hijo = padre;
        padre = get_padre(hijo);
    }
}

template <class T>
void Heap<T>::Insertar(const T &elem, int valor){

    Par nuevo(elem,valor);
    Arr_heap.push_back(nuevo);
    int hijo = Arr_heap.size()-1;
    Flotar(hijo,get_padre(hijo));

}

template <class T>
void Heap<T>::Actualizar(const T &elem, int valor){

    typename map<T,int>::iterator it = posiciones.find(elem);
    int actual = it->second;
    Arr_heap[actual].modificar_dist(valor);
    int padre = get_padre(actual);
    if (Arr_heap[actual].devolver_dist() < Arr_heap[padre].devolver_dist())
        Flotar(actual,padre);
    else
        Hundir(actual);

}


template <class T>
const typename Heap<T>::Par& Heap<T>::ExtraerMin(){

    int hijo = Arr_heap.size() - 1;
    Intercambiar(hijo,0);

    typename Heap<T>::Par aux = Arr_heap.back();
    Arr_heap.pop_back();

    Hundir(0);

    return aux;

}

template <class T>
void Heap<T>::Imprimir(){

    cout << "arr: " << endl;
    for (int i = 0; i < Arr_heap.size(); i++)
        cout << " (" << Arr_heap[i].devolver_vertice() << ";" << Arr_heap[i].devolver_dist() << ")";

}

template <class T>
void Heap<T>::ImprimirMapa(){

    cout << "mapa: ";
    typename map<T,int>::iterator it = posiciones.begin();
    for(it; it != posiciones.end(); it++)
        cout << "Vertice: " << it->first << " Posicion: " << it-> second << endl;

}

#endif // HEAP_H_INCLUDED
