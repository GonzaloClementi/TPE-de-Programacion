#ifndef GRAFO_H_
#define GRAFO_H_

#include <list>
#include <map>
#include <iostream>
#include <cstdlib>

using namespace std;

template <typename C> class Grafo
{
public:
	class Arco
	{
	public:
		Arco();
		Arco(int adyacente, const C & costo);
		int devolver_adyacente() const;
		const C & devolver_costo() const;
	private:
		int vertice;
		C costo;
	};

public:
	Grafo();
	Grafo(const Grafo & otroGrafo);

	~Grafo();

	Grafo & operator = (const Grafo & otroGrafo);

	// Devuelve true si la cantidad de vértices es cero
	bool esta_vacio() const;

	// Indica la cantidad de vértices del grafo
	int devolver_longitud() const;

	bool existe_vertice(int vertice) const;

	bool existe_arco(int origen, int destino) const;

	// PRE CONDICION: existe_arco(origen, destino)
	const C & costo_arco(int origen, int destino) const;

	void devolver_vertices(list<int> & vertices) const;

	void devolver_adyacentes(int origen, list<Arco> & adyacentes) const;

	void agregar_vertice(int vertice);

	// POST CONDICION: Para todo vértice v != vertice: !existeArco(v, vertice) && !existeArco(vertice, v)
	void eliminar_vertice(int vertice);

	// PRE CONDICION: existeArco(origen, destino)
	void modificar_costo_arco(int origen, int destino, const C & costo);

	// PRE CONDICION: existeVertice(origen) && existeVertice(destino)
	// POST CONDICION: existeArco(origen, destino)
	void agregar_arco(int origen, int destino, const C & costo);

	// POST CONDICION: !existeArco(origen, destino)
	void eliminar_arco(int origen, int destino);

	void vaciar();

private:

    map<int, map<int, C> > mapa;
};


/*
 * Arco
*/

template <typename C> Grafo<C>::Arco::Arco()
{

}

template <typename C> Grafo<C>::Arco::Arco(int adyacente, const C & costo)
{
    this->vertice = adyacente;
    this->costo = costo;
}

template <typename C> int Grafo<C>::Arco::devolver_adyacente() const
{
    return vertice;
}

template <typename C> const C & Grafo<C>::Arco::devolver_costo() const
{
    return costo;
}


/*
 * Grafo
 */

template <typename C> Grafo<C>::Grafo()
{
}

template <typename C> Grafo<C>::Grafo(const Grafo & otroGrafo)
{
    this->operator = (otroGrafo);
}

template <typename C> Grafo<C>::~Grafo()
{

}

template <typename C> Grafo<C> & Grafo<C>::operator = (const Grafo & otroGrafo)
{
    // Operador que permite igualar un grafo a otro (asignacion)

    mapa.clear(); // Limpio el mapa al que le estoy asignando un nuevo valor
    typename map <int, map <int, C> >::const_iterator it = otroGrafo.mapa.begin();
    while (it != otroGrafo.mapa.end()){
        mapa[it->first] = it->second; // Creo el nuevo grafo
        it++;
    }
    return *this;
}

template <typename C> bool Grafo<C>::esta_vacio() const
{
  return (mapa.empty());
}

template <typename C> int Grafo<C>::devolver_longitud() const
{
    return (mapa.size());
}

template <typename C> bool Grafo<C>::existe_vertice(int vertice) const
{
    return (mapa.find(vertice) != mapa.end());
}

template <typename C> bool Grafo<C>::existe_arco(int origen, int destino) const
{
    typename map <int, map <int, C> >::const_iterator it = mapa.find(origen); // asigno un primero iterador al origen (principio)
    if (it != mapa.end()){ // Si el iterador es distinto del final del mapa.
        typename map <int, C>::const_iterator it2 = it->second.find (destino); // asigno un segundo iterador que es el destino
        if (it2 != it->second.end()) // si el segundo iterador es distinto del final del mapa
            return true; // Retorna true si tanto el primero como el segundo iterador no estan en el final del grafo
    }
    return false;
}

template <typename C> const C & Grafo<C>::costo_arco(int origen, int destino) const
{
    typename map <int, map <int, C> >::const_iterator it = mapa.find(origen); //Iterador del primer mapa
    typename map <int, C>::const_iterator it2 = it->second.find(destino); //Iterador del mapa incluido en el anterior
    return it2->second;
}

template <typename C> void Grafo<C>::devolver_vertices(list<int> & vertices) const
{
    //Devuelve los vertices presentes en el grafo

    typename map <int, map <int, C> >::const_iterator it = mapa.begin();
    while (it != mapa.end()){
        vertices.push_back(it->first); // Arma la lista de vertices
        it++;
    }
}

template <typename C> void Grafo<C>::devolver_adyacentes(int origen, list<Arco> & adyacentes) const
{
    // Devuelve todos los adyacentes del vertice

    typename map <int, map <int, C> >::const_iterator it = mapa.find(origen); // Iterador constante por ser constante el void
    if (it != mapa.end()){
        typename map <int, C>::const_iterator it2 = it->second.begin();
        while (it2 != it->second.end()){
            adyacentes.push_back(Arco (it2->first, it2->second));// añade al mapa de mapa el arco del primero al segundo en la lista ARCO(adyacentes).
            it2++;
        }
    }
}

template <typename C> void Grafo<C>::agregar_vertice(int vertice)
{
    // Agrega un vertice nuevo al grafo

    if (mapa.find(vertice) == mapa.end()){ // Pregunta si el vertice existe
        map <int, C> hijos;
        mapa[vertice] = hijos;
    }
}

template <typename C> void Grafo<C>::eliminar_vertice(int vertice)
{
  mapa.erase(vertice);   // Borro el vertice y todas sus ocurrencias en los arcos
}

template <typename C> void Grafo<C>::modificar_costo_arco(int origen, int destino, const C & costo)
{
    // Creo los dos iteradores y cambio el costo del segundo componente del segundo iterador
    typename map <int, map <int, C> >::iterator it = mapa.find(origen);
    if (it != mapa.end()){
        typename map <int, C>::iterator it2 = it->second.find(destino);
        if (it2 != it->second.end())
            it2->second = costo;
    }
}

template <typename C> void Grafo<C>::agregar_arco(int origen, int destino, const C & costo)
{
    // Busco el origen y agrego, con la clave destino, el costo del arco
    typename map <int, map <int, C> >::iterator it = mapa.find(origen);
    if (it != mapa.end())
        it->second[destino] = costo;
}

template <typename C> void Grafo<C>::eliminar_arco(int origen, int destino)
{
    // Busco el vertice origen y elimino el arco, siempre usando el iterador

    mapa[origen].erase(destino);
}

template <typename C> void Grafo<C>::vaciar()
{
    mapa.clear();
}


#endif /* GRAFO_H_ */
