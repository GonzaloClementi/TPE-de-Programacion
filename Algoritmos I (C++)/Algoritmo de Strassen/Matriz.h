#ifndef MATRIZ_H_INCLUDED
#define MATRIZ_H_INCLUDED

template <class T>
class Matriz {

        public:
                Matriz(int fil,int col); //Constructor
                Matriz(const Matriz& m); //Constructor por copia
                ~Matriz(); //Destructor
                void insertar(const T& elem, int fil, int col);
                T get(int i,int j)const;
                void suma(const Matriz& otraM,Matriz& res,int dim);
                void resta(const Matriz& otraM,Matriz& res,int dim);
                void mult(const Matriz& otraM,Matriz& res);
                void getCuadrante(int dim, Matriz& M11,Matriz& M12,Matriz& M21,Matriz& M22);
                void unirCuadrantes(int dim,const Matriz& M11,const Matriz& M12,const Matriz& M21,const Matriz& M22);
                int getFilas()const;
                int getColumnas()const;
                void cargar();
                void cargarceros();

        private:
                T ** elementos;
                int filas;
                int columnas;
};

#endif // MATRIZ_H_INCLUDED
