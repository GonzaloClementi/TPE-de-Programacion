public class NodoArbolHuffman implements Comparable {
    int simbolo;
    double probabilidad;
    NodoArbolHuffman menor; // Nodo Izq
    NodoArbolHuffman mayor; // Nodo Der

    public NodoArbolHuffman(int simbolo, double probabilidad, NodoArbolHuffman menor, NodoArbolHuffman mayor) {
        this.simbolo = simbolo;
        this.probabilidad = probabilidad;
        this.menor = menor;
        this.mayor = mayor;
    }

    public int getSimbolo() {
        return simbolo;
    }

    public double getProbabilidad() {
        return probabilidad;
    }

    public NodoArbolHuffman getMenor() {
        return menor;
    }
    public NodoArbolHuffman getMayor() {
        return mayor;
    }

    public boolean esHoja() {
        return ((mayor == null) && (menor == null));
    }
    public int compareTo(Object otroNodo) {
        double result = this.probabilidad - ((NodoArbolHuffman) otroNodo).getProbabilidad();
        if (result < 0)
            return -1;
        else if (result > 0)
            return 1;
        return (int) result;
    }
}