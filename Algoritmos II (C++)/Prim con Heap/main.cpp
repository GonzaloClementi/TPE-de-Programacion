#include "Grafo.h"
#include "Heap.h"

#include <iostream>
#include <limits>

using namespace std;

template <typename C>
ostream & operator << (ostream & salida, const Grafo<C> & grafo)
{
	// Recorremos todos los vertices
	list<int> vertices;
	grafo.devolver_vertices(vertices);
	list<int>::iterator v = vertices.begin();
	while (v != vertices.end()) {
		salida << "    " << *v << "\n";
		// Recorremos todos los adyacentes de cada vertice
		list<typename Grafo<C>::Arco> adyacentes;
		grafo.devolver_adyacentes(*v, adyacentes);
		typename list<typename Grafo<C>::Arco>::iterator ady = adyacentes.begin();
		while (ady != adyacentes.end()) {
			salida << "    " << *v << "-> " << ady->devolver_adyacente() << " (" << ady->devolver_costo() << ")\n";
			ady++;
		}
		v++;
	}

	return salida;
}

template <typename C>
void DFSCosto_Visit(const Grafo<C> &grafo, int vertice, vector<bool> visitados, int &costo){

    visitados[vertice] = true;
    list<typename Grafo<C>::Arco> adyacentes;
    grafo.devolver_adyacentes(vertice,adyacentes);
    typename list<typename Grafo<C>::Arco>::iterator it = adyacentes.begin();
    for (it; it != adyacentes.end(); it++)
        if (visitados[it->devolver_adyacente()] == false)
        {
            costo = costo + it->devolver_costo();
            DFSCosto_Visit(grafo,it->devolver_adyacente(),visitados,costo);
        }
}

template <typename C>
int DFSCosto(const Grafo<C> &grafo, int vertice){

    int costo = 0;
    vector<bool> visitados(grafo.devolver_longitud()+1,false);
    DFSCosto_Visit(grafo,vertice,visitados,costo);
    return costo;

}

template <typename C>
Grafo<C> Prim(const Grafo<C> &grafo, int origen) {

    const int INF = numeric_limits<int>::max();
    Grafo<C> ArbolMC;
    Heap<C> prioridad;
    vector<int> distancia(grafo.devolver_longitud()+1,INF);
    vector<int> padre(grafo.devolver_longitud()+1,0);

    list<typename Grafo<C>::Arco> adyacentes;
    list<int> vertices;
    grafo.devolver_vertices(vertices);
    typename list<int>::iterator it_ver = vertices.begin();
    for (it_ver; it_ver != vertices.end(); it_ver++)
        prioridad.Insertar(*it_ver,INF);
    distancia[origen] = 0;
    prioridad.Actualizar(origen,0);
    //prioridad.Imprimir();
    while (!prioridad.esVacia())
    {
        typename Heap<C>::Par minimo = prioridad.ExtraerMin();
        //cout << "Min vert: " << minimo.devolver_vertice() << " Dist: " << minimo.devolver_dist() << endl;
        grafo.devolver_adyacentes(minimo.devolver_vertice(),adyacentes);
        typename list<typename Grafo<C>::Arco>::iterator it_ady = adyacentes.begin();
        for (it_ady; it_ady != adyacentes.end(); it_ady++)
        {
            //cout << "Adyacente: " << it_ady->devolver_adyacente() << " Costo: " << it_ady->devolver_costo() << endl;
            if (prioridad.Existe(it_ady->devolver_adyacente()) && distancia[it_ady->devolver_adyacente()] > it_ady->devolver_costo())
            {
                padre[it_ady->devolver_adyacente()] = minimo.devolver_vertice();
                distancia[it_ady->devolver_adyacente()] = it_ady->devolver_costo();
                prioridad.Actualizar(it_ady->devolver_adyacente(),it_ady->devolver_costo());
            }
        }
        typename Heap<C>::Par aux = prioridad.Tope();
        //cout << "Min vert: " << aux.devolver_vertice() << " Dist: " << aux.devolver_dist() << endl;
        ArbolMC.agregar_vertice(padre[aux.devolver_vertice()]);
        ArbolMC.agregar_vertice(aux.devolver_vertice());
        ArbolMC.agregar_arco(padre[aux.devolver_vertice()],aux.devolver_vertice(),aux.devolver_dist());
        ArbolMC.agregar_arco(aux.devolver_vertice(),padre[aux.devolver_vertice()],aux.devolver_dist());
    }

    return ArbolMC;

}


int main(int argc, char **argv)
{
	Grafo<int> g;	// Cargamos un grafo dirigido

	// Primero los vértices

	/*g.agregar_vertice(1);
	g.agregar_vertice(2);
	g.agregar_vertice(3);
	g.agregar_vertice(4);

	// Luego los arcos

	g.agregar_arco(1, 2, 1);
	g.agregar_arco(1, 4, 3);
	g.agregar_arco(2, 1, 1);
	g.agregar_arco(2, 3, 1);
	g.agregar_arco(2, 4, 3);
	g.agregar_arco(3, 2, 1);
	g.agregar_arco(3, 4, 1);
	g.agregar_arco(4, 2, 3);
	g.agregar_arco(4, 1, 3);
	g.agregar_arco(4, 3, 1);*/

    g.agregar_vertice(1);
	g.agregar_vertice(2);
	g.agregar_vertice(3);
	g.agregar_vertice(4);
	g.agregar_vertice(5);
	g.agregar_vertice(6);

	g.agregar_arco(1, 2, 3);
	g.agregar_arco(1, 4, 1);
	g.agregar_arco(2, 1, 3);
	g.agregar_arco(2, 3, 1);
	g.agregar_arco(2, 4, 3);
	g.agregar_arco(3, 2, 1);
	g.agregar_arco(3, 4, 1);
	g.agregar_arco(3, 5, 5);
	g.agregar_arco(3, 6, 4);
	g.agregar_arco(4, 2, 3);
	g.agregar_arco(4, 1, 1);
	g.agregar_arco(4, 3, 1);
	g.agregar_arco(4, 5, 6);
	g.agregar_arco(5, 3, 5);
	g.agregar_arco(5, 4, 6);
	g.agregar_arco(5, 6, 2);
	g.agregar_arco(6, 3, 4);
	g.agregar_arco(6, 5, 2);

    Grafo<int> MST = Prim(g,1);
    int costo = DFSCosto(MST,1);

	// Mostramos el grafo

	cout << endl << endl;

	cout << endl << "[----------------------->Estructura del grafo<---------------------] \n" << endl << g << "\n";
	cout << endl << "[->-------------------------------------------------------------<-]" << endl << endl;

	cout << endl << "[------------------------------>PRIM<-----------------------------] \n" << endl << MST << "\n";
	cout << endl << "Costo del Arbol de Recubrimiento Minimo: " << costo << endl;
	cout << endl << "[->-------------------------------------------------------------<-]" << endl << endl;


    return 0;
}
